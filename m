Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3B766EBE
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jul 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjG1NtB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jul 2023 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjG1Ns4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jul 2023 09:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3A4495;
        Fri, 28 Jul 2023 06:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D0161F9C;
        Fri, 28 Jul 2023 13:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30CDC433C8;
        Fri, 28 Jul 2023 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690552125;
        bh=7lriKnjSzsL6NUBoZ2qDUpXUnUvaQF/GYKBnxTvTZ5w=;
        h=From:To:Cc:Subject:Date:From;
        b=aNF07MRBOHTU8baIAQfyAHkKYGZGnf+FSa/gKNQYfAZzBsyJmp+PZNRbrIJ436+ZD
         FC6YWvl06ztVQ1PjoCqQsp8yFTGvciP/noD1f6rHrOTjfx25nfbkbVpmVNJzkHtNH7
         LLOhJa7gBxAWsS8KFBJgQyRq/czHc3oU5swwWt5YXLVksykwYZ2T7miNjJvC565of+
         WFPr2ulhkWVyRrPpoxP0ou4q3O9KOPoLiDYJnSOhlSPdbwBaE/UILM0bODo2VhBvNS
         chz22/Sm2QMGPCUknt9Y/UesPLdtj5pDHrG6TdBGLxXsHyPm8FuBcZLrIBSZTdV3p3
         PmT89LTND8sng==
Received: (nullmailer pid 3224486 invoked by uid 1000);
        Fri, 28 Jul 2023 13:48:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3] hwrng: Explicitly include correct DT includes
Date:   Fri, 28 Jul 2023 07:48:27 -0600
Message-Id: <20230728134828.3224218-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Split out hw_random, ipmi and tpm
v2:
 - Fix build for pic32-rng.c dropping of_match_ptr()
---
 drivers/char/hw_random/atmel-rng.c     | 2 +-
 drivers/char/hw_random/bcm2835-rng.c   | 3 +--
 drivers/char/hw_random/ingenic-trng.c  | 2 +-
 drivers/char/hw_random/iproc-rng200.c  | 3 +--
 drivers/char/hw_random/npcm-rng.c      | 3 +--
 drivers/char/hw_random/omap-rng.c      | 2 --
 drivers/char/hw_random/omap3-rom-rng.c | 1 -
 drivers/char/hw_random/pasemi-rng.c    | 3 +--
 drivers/char/hw_random/pic32-rng.c     | 5 ++---
 drivers/char/hw_random/stm32-rng.c     | 3 ++-
 drivers/char/hw_random/xgene-rng.c     | 5 ++---
 drivers/char/hw_random/xiphera-trng.c  | 1 -
 12 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index b8effe77d80f..a37367ebcbac 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -15,7 +15,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/hw_random.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index e98fcac578d6..e19b0f9f48b9 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -8,8 +8,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/clk.h>
diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index 0eb80f786f4d..759445d4f65a 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -11,8 +11,8 @@
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index 06bc060534d8..34df3f0d3e45 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
diff --git a/drivers/char/hw_random/npcm-rng.c b/drivers/char/hw_random/npcm-rng.c
index 9903d0357e06..8a304b754217 100644
--- a/drivers/char/hw_random/npcm-rng.c
+++ b/drivers/char/hw_random/npcm-rng.c
@@ -8,12 +8,11 @@
 #include <linux/init.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/delay.h>
-#include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
 
 #define NPCM_RNGCS_REG		0x00	/* Control and status register */
 #define NPCM_RNGD_REG		0x04	/* Data register */
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 00ff96703dd2..be03f76a2a80 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -26,8 +26,6 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index f06e4f95114f..18dc46b1b58e 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -20,7 +20,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 2498d4ef9fe2..6959d6edd44c 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -9,11 +9,10 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/delay.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/io.h>
 
 #define SDCRNG_CTL_REG			0x00
diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index 99c8bd0859a1..b314d994afcf 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -12,9 +12,8 @@
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -129,7 +128,7 @@ static struct platform_driver pic32_rng_driver = {
 	.remove		= pic32_rng_remove,
 	.driver		= {
 		.name	= "pic32-rng",
-		.of_match_table = of_match_ptr(pic32_rng_of_match),
+		.of_match_table = pic32_rng_of_match,
 	},
 };
 
diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index a6731cf0627a..efb6a9f9a11b 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -10,8 +10,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 7c8f3cb7c6af..c25bb169563d 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -15,9 +15,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/timer.h>
 
 #define RNG_MAX_DATUM			4
diff --git a/drivers/char/hw_random/xiphera-trng.c b/drivers/char/hw_random/xiphera-trng.c
index 2a9fea72b2e0..2c586d1fe8a9 100644
--- a/drivers/char/hw_random/xiphera-trng.c
+++ b/drivers/char/hw_random/xiphera-trng.c
@@ -7,7 +7,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/hw_random.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
-- 
2.40.1

