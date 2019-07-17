Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4186B903
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jul 2019 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQJOG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 17 Jul 2019 05:14:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56070 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQJOF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 17 Jul 2019 05:14:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3219120005C;
        Wed, 17 Jul 2019 11:14:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F185E20005E;
        Wed, 17 Jul 2019 11:13:55 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D2E4F402C3;
        Wed, 17 Jul 2019 17:13:45 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        rfontana@redhat.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] char: hw_random: imx-rngc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 17 Jul 2019 17:04:37 +0800
Message-Id: <20190717090438.31522-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/char/hw_random/imx-rngc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 69f5379..30cf00f 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -196,7 +196,6 @@ static int imx_rngc_init(struct hwrng *rng)
 static int imx_rngc_probe(struct platform_device *pdev)
 {
 	struct imx_rngc *rngc;
-	struct resource *res;
 	int ret;
 	int irq;
 
@@ -204,8 +203,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	if (!rngc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rngc->base = devm_ioremap_resource(&pdev->dev, res);
+	rngc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rngc->base))
 		return PTR_ERR(rngc->base);
 
-- 
2.7.4

