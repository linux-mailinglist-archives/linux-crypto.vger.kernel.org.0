Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA5381D2C
	for <lists+linux-crypto@lfdr.de>; Sun, 16 May 2021 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhEPG70 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 16 May 2021 02:59:26 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:19576 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhEPG7Y (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 16 May 2021 02:59:24 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d54 with ME
        id 5Jy42500J21Fzsu03Jy4SW; Sun, 16 May 2021 08:58:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 May 2021 08:58:07 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gary.hook@amd.com, brijesh.singh@amd.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: ccp - Fix a resource leak in an error handling path
Date:   Sun, 16 May 2021 08:58:04 +0200
Message-Id: <4af832b7e75b729ebfb0f07fe039dc47712512c2.1621146079.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

If an error occurs after calling 'sp_get_irqs()', 'sp_free_irqs()' must be
called as already done in the error handling path.

Fixes: f4d18d656f88 ("crypto: ccp - Abstract interrupt registeration")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/ccp/sp-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index f468594ef8af..6fb6ba35f89d 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -222,7 +222,7 @@ static int sp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (ret) {
 			dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n",
 				ret);
-			goto e_err;
+			goto free_irqs;
 		}
 	}
 
@@ -230,10 +230,12 @@ static int sp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = sp_init(sp);
 	if (ret)
-		goto e_err;
+		goto free_irqs;
 
 	return 0;
 
+free_irqs:
+	sp_free_irqs(sp);
 e_err:
 	dev_notice(dev, "initialization failed\n");
 	return ret;
-- 
2.30.2

