Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A31DA2CF
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgESUhF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 May 2020 16:37:05 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:27916 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESUhF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 May 2020 16:37:05 -0400
Received: from localhost.localdomain ([93.22.37.87])
        by mwinf5d40 with ME
        id gkcw220091sokYV03kcxsH; Tue, 19 May 2020 22:37:01 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 May 2020 22:37:01 +0200
X-ME-IP: 93.22.37.87
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jsrikanth@marvell.com, phemadri@marvell.com,
        gustavo@embeddedor.com, tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: cavium/nitrox - Fix a typo in a comment
Date:   Tue, 19 May 2020 22:36:54 +0200
Message-Id: <20200519203654.281351-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

s/NITORX/NITROX/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index e91be9b8b083..788c6607078b 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -346,7 +346,7 @@ static void nitrox_pf_sw_cleanup(struct nitrox_device *ndev)
 }
 
 /**
- * nitrox_bist_check - Check NITORX BIST registers status
+ * nitrox_bist_check - Check NITROX BIST registers status
  * @ndev: NITROX device
  */
 static int nitrox_bist_check(struct nitrox_device *ndev)
-- 
2.25.1

