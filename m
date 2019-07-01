Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD312FF3
	for <lists+linux-crypto@lfdr.de>; Fri,  3 May 2019 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfECOR4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 May 2019 10:17:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56808 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfECORz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 May 2019 10:17:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC04C1A03A9;
        Fri,  3 May 2019 16:17:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F3981A01C7;
        Fri,  3 May 2019 16:17:52 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 320B7205F4;
        Fri,  3 May 2019 16:17:52 +0200 (CEST)
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
Subject: [PATCH v2 7/7] crypto: caam - defer probing until QMan is available
Date:   Fri,  3 May 2019 17:17:43 +0300
Message-Id: <20190503141743.27129-8-horia.geanta@nxp.com>
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

When QI (Queue Interface) support is enabled on DPAA 1.x platforms,
defer probing if dependencies (QMan drivers) are not available yet.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 74 ++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index bbde6efce8af..3b7bd00dc424 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -527,15 +527,54 @@ static int caam_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, ctrlpriv);
 	nprop = pdev->dev.of_node;
 
+	/* Get configuration properties from device tree */
+	/* First, get register page */
+	ctrl = of_iomap(nprop, 0);
+	if (!ctrl) {
+		dev_err(dev, "caam: of_iomap() failed\n");
+		return -ENOMEM;
+	}
+
+	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
+				  (CSTA_PLEND | CSTA_ALT_PLEND));
 	caam_imx = (bool)soc_device_match(imx_soc);
 
+	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ms);
+	caam_dpaa2 = !!(comp_params & CTPR_MS_DPAA2);
+	ctrlpriv->qi_present = !!(comp_params & CTPR_MS_QI_MASK);
+
+#ifdef CONFIG_CAAM_QI
+	/* If (DPAA 1.x) QI present, check whether dependencies are available */
+	if (ctrlpriv->qi_present && !caam_dpaa2) {
+		ret = qman_is_probed();
+		if (!ret) {
+			ret = -EPROBE_DEFER;
+			goto iounmap_ctrl;
+		} else if (ret < 0) {
+			dev_err(dev, "failing probe due to qman probe error\n");
+			ret = -ENODEV;
+			goto iounmap_ctrl;
+		}
+
+		ret = qman_portals_probed();
+		if (!ret) {
+			ret = -EPROBE_DEFER;
+			goto iounmap_ctrl;
+		} else if (ret < 0) {
+			dev_err(dev, "failing probe due to qman portals probe error\n");
+			ret = -ENODEV;
+			goto iounmap_ctrl;
+		}
+	}
+#endif
+
 	/* Enable clocking */
 	clk = caam_drv_identify_clk(&pdev->dev, "ipg");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		dev_err(&pdev->dev,
 			"can't identify CAAM ipg clk: %d\n", ret);
-		return ret;
+		goto iounmap_ctrl;
 	}
 	ctrlpriv->caam_ipg = clk;
 
@@ -546,7 +585,7 @@ static int caam_probe(struct platform_device *pdev)
 			ret = PTR_ERR(clk);
 			dev_err(&pdev->dev,
 				"can't identify CAAM mem clk: %d\n", ret);
-			return ret;
+			goto iounmap_ctrl;
 		}
 		ctrlpriv->caam_mem = clk;
 	}
@@ -556,7 +595,7 @@ static int caam_probe(struct platform_device *pdev)
 		ret = PTR_ERR(clk);
 		dev_err(&pdev->dev,
 			"can't identify CAAM aclk clk: %d\n", ret);
-		return ret;
+		goto iounmap_ctrl;
 	}
 	ctrlpriv->caam_aclk = clk;
 
@@ -568,7 +607,7 @@ static int caam_probe(struct platform_device *pdev)
 			ret = PTR_ERR(clk);
 			dev_err(&pdev->dev,
 				"can't identify CAAM emi_slow clk: %d\n", ret);
-			return ret;
+			goto iounmap_ctrl;
 		}
 		ctrlpriv->caam_emi_slow = clk;
 	}
@@ -576,7 +615,7 @@ static int caam_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(ctrlpriv->caam_ipg);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can't enable CAAM ipg clock: %d\n", ret);
-		return ret;
+		goto iounmap_ctrl;
 	}
 
 	if (ctrlpriv->caam_mem) {
@@ -603,25 +642,10 @@ static int caam_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Get configuration properties from device tree */
-	/* First, get register page */
-	ctrl = of_iomap(nprop, 0);
-	if (ctrl == NULL) {
-		dev_err(dev, "caam: of_iomap() failed\n");
-		ret = -ENOMEM;
-		goto disable_caam_emi_slow;
-	}
-
-	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
-				  (CSTA_PLEND | CSTA_ALT_PLEND));
-
-	/* Finding the page size for using the CTPR_MS register */
-	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ms);
-	pg_size = (comp_params & CTPR_MS_PG_SZ_MASK) >> CTPR_MS_PG_SZ_SHIFT;
-
 	/* Allocating the BLOCK_OFFSET based on the supported page size on
 	 * the platform
 	 */
+	pg_size = (comp_params & CTPR_MS_PG_SZ_MASK) >> CTPR_MS_PG_SZ_SHIFT;
 	if (pg_size == 0)
 		BLOCK_OFFSET = PG_SIZE_4K;
 	else
@@ -646,7 +670,6 @@ static int caam_probe(struct platform_device *pdev)
 	 * In case of SoCs with Management Complex, MC f/w performs
 	 * the configuration.
 	 */
-	caam_dpaa2 = !!(comp_params & CTPR_MS_DPAA2);
 	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-mc");
 	ctrlpriv->mc_en = !!np;
 	of_node_put(np);
@@ -698,7 +721,7 @@ static int caam_probe(struct platform_device *pdev)
 	}
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
-		goto iounmap_ctrl;
+		goto disable_caam_emi_slow;
 	}
 
 	ctrlpriv->era = caam_get_era(ctrl);
@@ -717,7 +740,6 @@ static int caam_probe(struct platform_device *pdev)
 #endif
 
 	/* Check to see if (DPAA 1.x) QI present. If so, enable */
-	ctrlpriv->qi_present = !!(comp_params & CTPR_MS_QI_MASK);
 	if (ctrlpriv->qi_present && !caam_dpaa2) {
 		ctrlpriv->qi = (struct caam_queue_if __iomem __force *)
 			       ((__force uint8_t *)ctrl +
@@ -904,8 +926,6 @@ static int caam_probe(struct platform_device *pdev)
 	if (ctrlpriv->qi_init)
 		caam_qi_shutdown(dev);
 #endif
-iounmap_ctrl:
-	iounmap(ctrl);
 disable_caam_emi_slow:
 	if (ctrlpriv->caam_emi_slow)
 		clk_disable_unprepare(ctrlpriv->caam_emi_slow);
@@ -916,6 +936,8 @@ static int caam_probe(struct platform_device *pdev)
 		clk_disable_unprepare(ctrlpriv->caam_mem);
 disable_caam_ipg:
 	clk_disable_unprepare(ctrlpriv->caam_ipg);
+iounmap_ctrl:
+	iounmap(ctrl);
 	return ret;
 }
 
-- 
2.17.1

