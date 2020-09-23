Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979E276390
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Sep 2020 00:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWWIR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Sep 2020 18:08:17 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55843 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbgIWWIR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Sep 2020 18:08:17 -0400
X-Greylist: delayed 2645 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 18:08:17 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 08NLN8mr026845;
        Thu, 24 Sep 2020 00:23:08 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id EBDB3639D6; Thu, 24 Sep 2020 00:23:07 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, joel@jms.id.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, tmaimon77@gmail.com
Subject: [PATCH v1] hw_random: npcm: modify readl to readb
Date:   Thu, 24 Sep 2020 00:23:05 +0300
Message-Id: <20200923212305.198485-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Modify the read size to the correct HW random
registers size, 8bit.
The incorrect read size caused and faulty
HW random value.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/char/hw_random/npcm-rng.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 5d0d13f891b7..1ec5f267a656 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -58,24 +58,24 @@ static int npcm_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 
 	pm_runtime_get_sync((struct device *)priv->rng.priv);
 
-	while (max >= sizeof(u32)) {
+	while (max) {
 		if (wait) {
-			if (readl_poll_timeout(priv->base + NPCM_RNGCS_REG,
+			if (readb_poll_timeout(priv->base + NPCM_RNGCS_REG,
 					       ready,
 					       ready & NPCM_RNG_DATA_VALID,
 					       NPCM_RNG_POLL_USEC,
 					       NPCM_RNG_TIMEOUT_USEC))
 				break;
 		} else {
-			if ((readl(priv->base + NPCM_RNGCS_REG) &
+			if ((readb(priv->base + NPCM_RNGCS_REG) &
 			    NPCM_RNG_DATA_VALID) == 0)
 				break;
 		}
 
-		*(u32 *)buf = readl(priv->base + NPCM_RNGD_REG);
-		retval += sizeof(u32);
-		buf += sizeof(u32);
-		max -= sizeof(u32);
+		*(u8 *)buf = readb(priv->base + NPCM_RNGD_REG);
+		retval++;
+		buf++;
+		max--;
 	}
 
 	pm_runtime_mark_last_busy((struct device *)priv->rng.priv);
-- 
2.22.0

