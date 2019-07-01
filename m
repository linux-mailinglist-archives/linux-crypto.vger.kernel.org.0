Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDE12FF0
	for <lists+linux-crypto@lfdr.de>; Fri,  3 May 2019 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfECORy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 May 2019 10:17:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56688 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfECORy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 May 2019 10:17:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A09BE1A03C5;
        Fri,  3 May 2019 16:17:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B2C91A0528;
        Fri,  3 May 2019 16:17:51 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D7A5205F4;
        Fri,  3 May 2019 16:17:51 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Vakul Garg <vakul.garg@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 5/7] crypto: caam/qi - fix address translations with IOMMU enabled
Date:   Fri,  3 May 2019 17:17:41 +0300
Message-Id: <20190503141743.27129-6-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503141743.27129-1-horia.geanta@nxp.com>
References: <20190503141743.27129-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When IOMMU is enabled, iova -> phys address translation should be
performed using iommu_ops, not dma_to_phys().

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c   |  1 +
 drivers/crypto/caam/intern.h |  2 ++
 drivers/crypto/caam/qi.c     | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 38bcbbccdfda..bbde6efce8af 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -702,6 +702,7 @@ static int caam_probe(struct platform_device *pdev)
 	}
 
 	ctrlpriv->era = caam_get_era(ctrl);
+	ctrlpriv->domain = iommu_get_domain_for_dev(dev);
 
 #ifdef CONFIG_DEBUG_FS
 	/*
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index c9089da5dbaf..6af84bbc612c 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -70,6 +70,8 @@ struct caam_drv_private {
 	struct caam_queue_if __iomem *qi; /* QI control region */
 	struct caam_job_ring __iomem *jr[4];	/* JobR's register space */
 
+	struct iommu_domain *domain;
+
 	/*
 	 * Detected geometry block. Filled in from device tree if powerpc,
 	 * or from register-based version detection code
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 46fca2c9fb24..0fe618e3804a 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -94,6 +94,16 @@ static u64 times_congested;
  */
 static struct kmem_cache *qi_cache;
 
+static void *caam_iova_to_virt(struct iommu_domain *domain,
+			       dma_addr_t iova_addr)
+{
+	phys_addr_t phys_addr;
+
+	phys_addr = domain ? iommu_iova_to_phys(domain, iova_addr) : iova_addr;
+
+	return phys_to_virt(phys_addr);
+}
+
 int caam_qi_enqueue(struct device *qidev, struct caam_drv_req *req)
 {
 	struct qm_fd fd;
@@ -134,6 +144,7 @@ static void caam_fq_ern_cb(struct qman_portal *qm, struct qman_fq *fq,
 	const struct qm_fd *fd;
 	struct caam_drv_req *drv_req;
 	struct device *qidev = &(raw_cpu_ptr(&pcpu_qipriv)->net_dev.dev);
+	struct caam_drv_private *priv = dev_get_drvdata(qidev);
 
 	fd = &msg->ern.fd;
 
@@ -142,7 +153,7 @@ static void caam_fq_ern_cb(struct qman_portal *qm, struct qman_fq *fq,
 		return;
 	}
 
-	drv_req = (struct caam_drv_req *)phys_to_virt(qm_fd_addr_get64(fd));
+	drv_req = caam_iova_to_virt(priv->domain, qm_fd_addr_get64(fd));
 	if (!drv_req) {
 		dev_err(qidev,
 			"Can't find original request for CAAM response\n");
@@ -549,6 +560,7 @@ static enum qman_cb_dqrr_result caam_rsp_fq_dqrr_cb(struct qman_portal *p,
 	struct caam_drv_req *drv_req;
 	const struct qm_fd *fd;
 	struct device *qidev = &(raw_cpu_ptr(&pcpu_qipriv)->net_dev.dev);
+	struct caam_drv_private *priv = dev_get_drvdata(qidev);
 	u32 status;
 
 	if (caam_qi_napi_schedule(p, caam_napi))
@@ -571,7 +583,7 @@ static enum qman_cb_dqrr_result caam_rsp_fq_dqrr_cb(struct qman_portal *p,
 		return qman_cb_dqrr_consume;
 	}
 
-	drv_req = (struct caam_drv_req *)phys_to_virt(qm_fd_addr_get64(fd));
+	drv_req = caam_iova_to_virt(priv->domain, qm_fd_addr_get64(fd));
 	if (unlikely(!drv_req)) {
 		dev_err(qidev,
 			"Can't find original request for caam response\n");
-- 
2.17.1

