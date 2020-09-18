Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79F26F6BA
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIRHXz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 03:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgIRHXx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF8C061356
        for <linux-crypto@vger.kernel.org>; Fri, 18 Sep 2020 00:23:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so4535181wrn.0
        for <linux-crypto@vger.kernel.org>; Fri, 18 Sep 2020 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssI8JwV8HbqSNaVY6klw4VkojSyATW/+mZJh2T7ruCE=;
        b=wtglR80Nc3iT76H8CO5QYhReveygXsX/XksXRotCanGQW1RiKNhKcXQPAFq+U81MvU
         dItSXMdSidSLP/NJGVdOzI8mqw3xbUhkUxueX7pfhnj+8l7tX2k98NSHNgWiHWfNnduA
         SwgBm4KpTMrhZvVPkE3ydNoUzkNH+ZyH5dKGYht/9i808ScFjrg3i+cukAsI/5J6zD1V
         IsxUYip/aLER8kUESAcJlVWSvqs9xB3TTz+hNaD6aDUeHAZlb35Y0lXrshJLhHi20luE
         jid/lhRyWSRSR4nXnw/BX0rG7sae46UL01QNIkFGJIaflxDwRSdtZmpt4NAi0ixFSQqR
         qSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssI8JwV8HbqSNaVY6klw4VkojSyATW/+mZJh2T7ruCE=;
        b=C3HUVAq3OpIJElPmMJSVMUMtLMBqVZiC+Rr8pjQyc6+GQRJWV453HQjwdDzOX68WmQ
         773nYXCxUiLaNXBuXepJ29EAqYjxxuHySoPaq6k5Gn7fyQDQZYPkDNZsXnbNwSrGuhuR
         2bo5quGWawZdeK2zbenWBV7QoncoRdNJtSn/Oew1DnLJA+cLrPLKfL1v5OAyRlYB/A+G
         jKLRkNVh49fFXZMoAxRfjE6c8dpgDi8YbuQ4kqwwZ7NJ5J9or4/KVQTtqjG0qLLiJ5rQ
         KU0i8cISsCAeoU7xAZfevvJZsEAkH/cUjVd+OuIf930YOPVClpOl5D/Q5s3ilEFxjsMq
         j8uQ==
X-Gm-Message-State: AOAM530zyx/Q+A2UsI4AhB/LsHKaaIdTMUG/tfCGU7ffnDj8eLaKDLhc
        4ljzU7eppkGCi2aj8NcoT1pYkQ==
X-Google-Smtp-Source: ABdhPJx7u4/aJFHs3INWxpPWPKfSnLSTroQ1llr6JY16rtQMEawgwRZktadT4EZituesQyK6LIqaDg==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr38501772wrq.313.1600413820757;
        Fri, 18 Sep 2020 00:23:40 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 14/17] crypto: sun8i-ce: Add support for the PRNG
Date:   Fri, 18 Sep 2020 07:23:12 +0000
Message-Id: <1600413795-39256-15-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch had support for the PRNG present in the CE.
The output was tested with rngtest without any failure.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/Kconfig              |   8 +
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  58 ++++++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 164 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  31 ++++
 5 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c

diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index fa34df7fbf78..bf4d2a6328dc 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -88,6 +88,14 @@ config CRYPTO_DEV_SUN8I_CE_HASH
 	help
 	  Say y to enable support for hash algorithms.
 
+config CRYPTO_DEV_SUN8I_CE_PRNG
+	bool "Support for Allwinner Crypto Engine PRNG"
+	depends on CRYPTO_DEV_SUN8I_CE
+	select CRYPTO_RNG
+	help
+	  Select this option if you want to provide kernel-side support for
+	  the Pseudo-Random Number Generator found in the Crypto Engine.
+
 config CRYPTO_DEV_SUN8I_SS
 	tristate "Support for Allwinner Security System cryptographic offloader"
 	select CRYPTO_SKCIPHER
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index d1b1f0e86c79..c0ea81da2c7d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CRYPTO_DEV_SUN8I_CE) += sun8i-ce.o
 sun8i-ce-y += sun8i-ce-core.o sun8i-ce-cipher.o
 sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_HASH) += sun8i-ce-hash.o
+sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG) += sun8i-ce-prng.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 3ef5b1079be3..9b7f8fdc4992 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 
 #include "sun8i-ce.h"
@@ -45,6 +46,7 @@ static const struct ce_variant ce_h3_variant = {
 		{ "mod", 50000000, 0 },
 		},
 	.esr = ESR_H3,
+	.prng = CE_ALG_PRNG,
 };
 
 static const struct ce_variant ce_h5_variant = {
@@ -60,6 +62,7 @@ static const struct ce_variant ce_h5_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_H5,
+	.prng = CE_ALG_PRNG,
 };
 
 static const struct ce_variant ce_h6_variant = {
@@ -72,12 +75,14 @@ static const struct ce_variant ce_h6_variant = {
 	},
 	.cipher_t_dlen_in_bytes = true,
 	.hash_t_dlen_in_bits = true,
+	.prng_t_dlen_in_bytes = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
 		{ "ram", 0, 400000000 },
 		},
 	.esr = ESR_H6,
+	.prng = CE_ALG_PRNG_V2,
 };
 
 static const struct ce_variant ce_a64_variant = {
@@ -93,6 +98,7 @@ static const struct ce_variant ce_a64_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_A64,
+	.prng = CE_ALG_PRNG,
 };
 
 static const struct ce_variant ce_r40_variant = {
@@ -108,15 +114,17 @@ static const struct ce_variant ce_r40_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_R40,
+	.prng = CE_ALG_PRNG,
 };
 
 /*
  * sun8i_ce_get_engine_number() get the next channel slot
  * This is a simple round-robin way of getting the next channel
+ * The flow 3 is reserve for xRNG operations
  */
 int sun8i_ce_get_engine_number(struct sun8i_ce_dev *ce)
 {
-	return atomic_inc_return(&ce->flow) % MAXFLOW;
+	return atomic_inc_return(&ce->flow) % (MAXFLOW - 1);
 }
 
 int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
@@ -527,6 +535,25 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 	}
 },
 #endif
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG
+{
+	.type = CRYPTO_ALG_TYPE_RNG,
+	.alg.rng = {
+		.base = {
+			.cra_name		= "stdrng",
+			.cra_driver_name	= "sun8i-ce-prng",
+			.cra_priority		= 300,
+			.cra_ctxsize		= sizeof(struct sun8i_ce_rng_tfm_ctx),
+			.cra_module		= THIS_MODULE,
+			.cra_init		= sun8i_ce_prng_init,
+			.cra_exit		= sun8i_ce_prng_exit,
+		},
+		.generate               = sun8i_ce_prng_generate,
+		.seed                   = sun8i_ce_prng_seed,
+		.seedsize               = PRNG_SEED_SIZE,
+	}
+},
+#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
@@ -554,6 +581,12 @@ static int sun8i_ce_dbgfs_read(struct seq_file *seq, void *v)
 				   ce_algs[i].alg.hash.halg.base.cra_name,
 				   ce_algs[i].stat_req, ce_algs[i].stat_fb);
 			break;
+		case CRYPTO_ALG_TYPE_RNG:
+			seq_printf(seq, "%s %s %lu %lu\n",
+				   ce_algs[i].alg.rng.base.cra_driver_name,
+				   ce_algs[i].alg.rng.base.cra_name,
+				   ce_algs[i].stat_req, ce_algs[i].stat_bytes);
+			break;
 		}
 	}
 	return 0;
@@ -788,6 +821,23 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 				return err;
 			}
 			break;
+		case CRYPTO_ALG_TYPE_RNG:
+			if (ce->variant->prng == CE_ID_NOTSUPP) {
+				dev_info(ce->dev,
+					 "DEBUG: Algo of %s not supported\n",
+					 ce_algs[i].alg.rng.base.cra_name);
+				ce_algs[i].ce = NULL;
+				break;
+			}
+			dev_info(ce->dev, "Register %s\n",
+				 ce_algs[i].alg.rng.base.cra_name);
+			err = crypto_register_rng(&ce_algs[i].alg.rng);
+			if (err) {
+				dev_err(ce->dev, "Fail to register %s\n",
+					ce_algs[i].alg.rng.base.cra_name);
+				ce_algs[i].ce = NULL;
+			}
+			break;
 		default:
 			ce_algs[i].ce = NULL;
 			dev_err(ce->dev, "ERROR: tried to register an unknown algo\n");
@@ -814,6 +864,11 @@ static void sun8i_ce_unregister_algs(struct sun8i_ce_dev *ce)
 				 ce_algs[i].alg.hash.halg.base.cra_name);
 			crypto_unregister_ahash(&ce_algs[i].alg.hash);
 			break;
+		case CRYPTO_ALG_TYPE_RNG:
+			dev_info(ce->dev, "Unregister %d %s\n", i,
+				 ce_algs[i].alg.rng.base.cra_name);
+			crypto_unregister_rng(&ce_algs[i].alg.rng);
+			break;
 		}
 	}
 }
@@ -859,6 +914,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 	}
 
 	mutex_init(&ce->mlock);
+	mutex_init(&ce->rnglock);
 
 	err = sun8i_ce_allocate_chanlist(ce);
 	if (err)
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
new file mode 100644
index 000000000000..1b0b86a943de
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sun8i-ce-prng.c - hardware cryptographic offloader for
+ * Allwinner H3/A64/H5/H2+/H6/R40 SoC
+ *
+ * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
+ *
+ * This file handle the PRNG
+ *
+ * You could find a link for the datasheet in Documentation/arm/sunxi/README
+ */
+#include "sun8i-ce.h"
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <crypto/internal/rng.h>
+
+int sun8i_ce_prng_init(struct crypto_tfm *tfm)
+{
+	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	memset(ctx, 0, sizeof(struct sun8i_ce_rng_tfm_ctx));
+	return 0;
+}
+
+void sun8i_ce_prng_exit(struct crypto_tfm *tfm)
+{
+	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	memzero_explicit(ctx->seed, ctx->slen);
+	kfree(ctx->seed);
+	ctx->seed = NULL;
+	ctx->slen = 0;
+}
+
+int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed,
+		       unsigned int slen)
+{
+	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
+
+	if (ctx->seed && ctx->slen != slen) {
+		memzero_explicit(ctx->seed, ctx->slen);
+		kfree(ctx->seed);
+		ctx->slen = 0;
+		ctx->seed = NULL;
+	}
+	if (!ctx->seed)
+		ctx->seed = kmalloc(slen, GFP_KERNEL | GFP_DMA);
+	if (!ctx->seed)
+		return -ENOMEM;
+
+	memcpy(ctx->seed, seed, slen);
+	ctx->slen = slen;
+
+	return 0;
+}
+
+int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
+			   unsigned int slen, u8 *dst, unsigned int dlen)
+{
+	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
+	struct rng_alg *alg = crypto_rng_alg(tfm);
+	struct sun8i_ce_alg_template *algt;
+	struct sun8i_ce_dev *ce;
+	dma_addr_t dma_iv, dma_dst;
+	int err = 0;
+	int flow = 3;
+	unsigned int todo;
+	struct sun8i_ce_flow *chan;
+	struct ce_task *cet;
+	u32 common, sym;
+	void *d;
+
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.rng);
+	ce = algt->ce;
+
+	if (ctx->slen == 0) {
+		dev_err(ce->dev, "not seeded\n");
+		return -EINVAL;
+	}
+
+	/* we want dlen + seedsize rounded up to a multiple of PRNG_DATA_SIZE */
+	todo = dlen + ctx->slen + PRNG_DATA_SIZE * 2;
+	todo -= todo % PRNG_DATA_SIZE;
+
+	d = kzalloc(todo, GFP_KERNEL | GFP_DMA);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_mem;
+	}
+
+	dev_dbg(ce->dev, "%s PRNG slen=%u dlen=%u todo=%u multi=%u\n", __func__,
+		slen, dlen, todo, todo / PRNG_DATA_SIZE);
+
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	algt->stat_req++;
+	algt->stat_bytes += todo;
+#endif
+
+	dma_iv = dma_map_single(ce->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
+	if (dma_mapping_error(ce->dev, dma_iv)) {
+		dev_err(ce->dev, "Cannot DMA MAP IV\n");
+		goto err_iv;
+	}
+
+	dma_dst = dma_map_single(ce->dev, d, todo, DMA_FROM_DEVICE);
+	if (dma_mapping_error(ce->dev, dma_dst)) {
+		dev_err(ce->dev, "Cannot DMA MAP DST\n");
+		err = -EFAULT;
+		goto err_dst;
+	}
+
+	err = pm_runtime_get_sync(ce->dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(ce->dev);
+		goto err_pm;
+	}
+
+	mutex_lock(&ce->rnglock);
+	chan = &ce->chanlist[flow];
+
+	cet = &chan->tl[0];
+	memset(cet, 0, sizeof(struct ce_task));
+
+	cet->t_id = cpu_to_le32(flow);
+	common = ce->variant->prng | CE_COMM_INT;
+	cet->t_common_ctl = cpu_to_le32(common);
+
+	/* recent CE (H6) need length in bytes, in word otherwise */
+	if (ce->variant->prng_t_dlen_in_bytes)
+		cet->t_dlen = cpu_to_le32(todo);
+	else
+		cet->t_dlen = cpu_to_le32(todo / 4);
+
+	sym = PRNG_LD;
+	cet->t_sym_ctl = cpu_to_le32(sym);
+	cet->t_asym_ctl = 0;
+
+	cet->t_key = cpu_to_le32(dma_iv);
+	cet->t_iv = cpu_to_le32(dma_iv);
+
+	cet->t_dst[0].addr = cpu_to_le32(dma_dst);
+	cet->t_dst[0].len = cpu_to_le32(todo / 4);
+	ce->chanlist[flow].timeout = 2000;
+
+	err = sun8i_ce_run_task(ce, 3, "PRNG");
+	mutex_unlock(&ce->rnglock);
+
+	pm_runtime_put(ce->dev);
+
+err_pm:
+	dma_unmap_single(ce->dev, dma_dst, todo, DMA_FROM_DEVICE);
+err_dst:
+	dma_unmap_single(ce->dev, dma_iv, ctx->slen, DMA_TO_DEVICE);
+
+	if (!err) {
+		memcpy(dst, d, dlen);
+		memcpy(ctx->seed, d + dlen, ctx->slen);
+	}
+	memzero_explicit(d, todo);
+err_iv:
+	kfree(d);
+err_mem:
+	return err;
+}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index c80006853d10..e451ee219c17 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -14,6 +14,7 @@
 #include <linux/crypto.h>
 #include <crypto/internal/hash.h>
 #include <crypto/md5.h>
+#include <crypto/rng.h>
 #include <crypto/sha.h>
 
 /* CE Registers */
@@ -54,6 +55,8 @@
 #define CE_ALG_SHA256           19
 #define CE_ALG_SHA384           20
 #define CE_ALG_SHA512           21
+#define CE_ALG_PRNG		49
+#define CE_ALG_PRNG_V2		0x1d
 
 /* Used in ce_variant */
 #define CE_ID_NOTSUPP		0xFF
@@ -88,6 +91,10 @@
 #define ESR_H5	3
 #define ESR_H6	4
 
+#define PRNG_DATA_SIZE (160 / 8)
+#define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
+#define PRNG_LD BIT(17)
+
 #define CE_DIE_ID_SHIFT	16
 #define CE_DIE_ID_MASK	0x07
 
@@ -120,8 +127,11 @@ struct ce_clock {
  *				bytes or words
  * @hash_t_dlen_in_bytes:	Does the request size for hash is in
  *				bits or words
+ * @prng_t_dlen_in_bytes:	Does the request size for PRNG is in
+ *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
  * @esr:	The type of error register
+ * @prng:	The CE_ALG_XXX value for the PRNG
  */
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
@@ -129,8 +139,10 @@ struct ce_variant {
 	u32 op_mode[CE_ID_OP_MAX];
 	bool cipher_t_dlen_in_bytes;
 	bool hash_t_dlen_in_bits;
+	bool prng_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
+	unsigned char prng;
 };
 
 struct sginfo {
@@ -185,6 +197,7 @@ struct sun8i_ce_flow {
  * @reset:	pointer to reset controller
  * @dev:	the platform device
  * @mlock:	Control access to device registers
+ * @rnglock:	Control access to the RNG (dedicated channel 3)
  * @chanlist:	array of all flow
  * @flow:	flow to use in next request
  * @variant:	pointer to variant specific data
@@ -197,6 +210,7 @@ struct sun8i_ce_dev {
 	struct reset_control *reset;
 	struct device *dev;
 	struct mutex mlock;
+	struct mutex rnglock;
 	struct sun8i_ce_flow *chanlist;
 	atomic_t flow;
 	const struct ce_variant *variant;
@@ -270,6 +284,16 @@ struct sun8i_ce_hash_reqctx {
 	int flow;
 };
 
+/*
+ * struct sun8i_ce_prng_ctx - context for PRNG TFM
+ * @seed:	The seed to use
+ * @slen:	The size of the seed
+ */
+struct sun8i_ce_rng_tfm_ctx {
+	void *seed;
+	unsigned int slen;
+};
+
 /*
  * struct sun8i_ce_alg_template - crypto_alg template
  * @type:		the CRYPTO_ALG_TYPE for this template
@@ -290,6 +314,7 @@ struct sun8i_ce_alg_template {
 	union {
 		struct skcipher_alg skcipher;
 		struct ahash_alg hash;
+		struct rng_alg rng;
 	} alg;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
@@ -324,3 +349,9 @@ int sun8i_ce_hash_update(struct ahash_request *areq);
 int sun8i_ce_hash_finup(struct ahash_request *areq);
 int sun8i_ce_hash_digest(struct ahash_request *areq);
 int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq);
+
+int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
+			   unsigned int slen, u8 *dst, unsigned int dlen);
+int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen);
+void sun8i_ce_prng_exit(struct crypto_tfm *tfm);
+int sun8i_ce_prng_init(struct crypto_tfm *tfm);
-- 
2.26.2

