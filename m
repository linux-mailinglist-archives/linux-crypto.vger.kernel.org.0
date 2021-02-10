Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD7315DC9
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 04:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBJD1y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Feb 2021 22:27:54 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:6843 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBJD1y (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Feb 2021 22:27:54 -0500
X-Greylist: delayed 635 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 22:27:53 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2602350070c8-30d05; Wed, 10 Feb 2021 11:16:24 +0800 (CST)
X-RM-TRANSID: 2ee2602350070c8-30d05
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66023500448f-68b16;
        Wed, 10 Feb 2021 11:16:23 +0800 (CST)
X-RM-TRANSID: 2ee66023500448f-68b16
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     clabbe@baylibre.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] crypto: amlogic - Fix unnecessary check in meson_crypto_probe()
Date:   Wed, 10 Feb 2021 11:16:37 +0800
Message-Id: <20210210031637.19408-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The function meson_crypto_probe() is only called with an openfirmware
platform device. Therefore there is no need to check that the passed
in device is NULL.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 466552acb..468a16f62 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -229,9 +229,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	struct meson_dev *mc;
 	int err, i;
 
-	if (!pdev->dev.of_node)
-		return -ENODEV;
-
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
-- 
2.20.1.windows.1



