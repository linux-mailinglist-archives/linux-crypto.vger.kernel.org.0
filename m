Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE81229805
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgGVMPN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 08:15:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51410 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgGVMPN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 846ED200BF6;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7866520097B;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 176C6202AC;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 2/7] crypto: caam/qi2 - fix error reporting for caam_hash_alloc
Date:   Wed, 22 Jul 2020 15:14:53 +0300
Message-Id: <20200722121458.8478-3-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722121458.8478-1-horia.geanta@nxp.com>
References: <20200722121458.8478-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix error reporting when preparation of an hmac algorithm
for registration fails: print the hmac algorithm name, not the unkeyed
hash algorithm name.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 1b0c28675906..811d34eee4f2 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -5238,7 +5238,7 @@ static int dpaa2_caam_probe(struct fsl_mc_device *dpseci_dev)
 		if (IS_ERR(t_alg)) {
 			err = PTR_ERR(t_alg);
 			dev_warn(dev, "%s hash alg allocation failed: %d\n",
-				 alg->driver_name, err);
+				 alg->hmac_driver_name, err);
 			continue;
 		}
 
-- 
2.17.1

