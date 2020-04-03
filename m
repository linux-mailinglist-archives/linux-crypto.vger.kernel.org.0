Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB219D308
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2020 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgDCJCb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Apr 2020 05:02:31 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8821 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCJCb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Apr 2020 05:02:31 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e86fb91319-74293; Fri, 03 Apr 2020 17:02:09 +0800 (CST)
X-RM-TRANSID: 2ee65e86fb91319-74293
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e86fb8e2e1-42d70;
        Fri, 03 Apr 2020 17:02:08 +0800 (CST)
X-RM-TRANSID: 2eea5e86fb8e2e1-42d70
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     narmstrong@baylibre.com, clabbe@baylibre.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] [PATCH v3]crypto: amlogic - Delete duplicate dev_err in meson_crypto_probe()
Date:   Fri,  3 Apr 2020 17:03:36 +0800
Message-Id: <20200403090336.13796-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When something goes wrong, platform_get_irq() will print an error message,
so in order to avoid the situation of repeat output，we should remove
dev_err here.

Changes from v2:
 - modify the theme format and content description.
 - reformat the patch, it's the wrong way to resubmit a new patch that
   should be modified on top of the original. The original piece is:
   https://lore.kernel.org/patchwork/patch/1219611/

Changes from v1:
 - the title has changed, because the description is not very detailed.
 - the code has been modified, because it needs to match the theme.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 37901bd81..c2fa442c5 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -253,10 +253,8 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	mc->irqs = devm_kcalloc(mc->dev, MAXFLOW, sizeof(int), GFP_KERNEL);
 	for (i = 0; i < MAXFLOW; i++) {
 		mc->irqs[i] = platform_get_irq_optional(pdev, i);
-		if (mc->irqs[i] < 0) {
-			dev_err(mc->dev, "Cannot get IRQ for flow %d\n", i);
+		if (mc->irqs[i] < 0)
 			return mc->irqs[i];
-		}
 
 		err = devm_request_irq(&pdev->dev, mc->irqs[i], meson_irq_handler, 0,
 				       "gxl-crypto", mc);
-- 
2.20.1.windows.1



