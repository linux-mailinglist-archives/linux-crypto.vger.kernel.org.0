Return-Path: <linux-crypto+bounces-25-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7897E463A
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41537B209D8
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1783328CB
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Nov 2023 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C2NFeQp7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1A31A93
	for <linux-crypto@vger.kernel.org>; Tue,  7 Nov 2023 15:56:03 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD647AB
	for <linux-crypto@vger.kernel.org>; Tue,  7 Nov 2023 07:56:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507be298d2aso7541993e87.1
        for <linux-crypto@vger.kernel.org>; Tue, 07 Nov 2023 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699372560; x=1699977360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACrUCaQqBEjX+w74tNKKmwgzPWxiISbd4UEub/jw4AE=;
        b=C2NFeQp7EH1OQK/lADLTFJetuNWRVMleoZjkRxXEmu7g2L0UnQG6YFq/yugknw2kDd
         /7+1Bp46pGRrU7ffPD9CWKR23h+1+Aw5eJ0cE3ee43Etie+Vs8a/ucDZba4qykXkuCy3
         sZWguJLKe/cZJoJjJyMkOQUiMnnH3VfAGWTE18TRyCcmCgn2cHM2t977BTCxtQelQezN
         OoD5AUnrIWmehR5EiTxCVF7F18c59uegVa1mCl80+pSHedKgb4y9vlHooBtVps0bCxbc
         H3HxZxtq53G2cgPXjIiy7aScyZ+FWevr2dhvnaxveBY1hTNEgh1UObojhBGL1/8Rrz7y
         Sjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372560; x=1699977360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACrUCaQqBEjX+w74tNKKmwgzPWxiISbd4UEub/jw4AE=;
        b=sAMtilOm2Kcy740LBdqNoWxxsVxk8CANrVfpYG48fGKJCAHhgNDYDOcrDh11xXcJfZ
         ixKL9odkNWlaLxbk95U0uOxEIidr2WFGVLcq2NDjX4jYNesONnR1qUha0epeTcGl5QpC
         YuPq1bx5k8YLdMya4PaMKmOw+ysdzMplZFcPMAE25nskq1vhRqHaoHLn2M6da0CfrZoK
         L+UqQOD/nlwe/kfWPMFxcu5oDhKA4xAj/nlJ9TmmQdS06/McOXA3NNTIooi+CdLo4/ga
         9HC4fe21uHwJ9ATk+2mUCCFz9t5SM656TyPG/so7OgGGLkfYh29AQ0brA+SMhXtmxRRr
         hr3g==
X-Gm-Message-State: AOJu0Yy3ra5u163MyWA5Eukkfoh/JwLi9ZS+l/PyQ03qiAnjXBN+UI0F
	951NGylRnAzvG90kAURvhzDrCw==
X-Google-Smtp-Source: AGHT+IFtnNVD3peOHdiB3JRA/63VF81K1FFRt73WLadTgQzDX+kpZ57v4JiURazsLgqDUjJJepeFpQ==
X-Received: by 2002:a19:4f42:0:b0:507:a40e:d8bf with SMTP id a2-20020a194f42000000b00507a40ed8bfmr25324337lfk.7.1699372559990;
        Tue, 07 Nov 2023 07:55:59 -0800 (PST)
Received: from arnold.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c4e8600b003fefb94ccc9sm16579085wmq.11.2023.11.07.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:55:55 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: davem@davemloft.net,
	heiko@sntech.de,
	herbert@gondor.apana.org.au,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	sboyd@kernel.org
Cc: ricardo@pardini.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 6/6] crypto: rockchip: add rk3588 driver
Date: Tue,  7 Nov 2023 15:55:32 +0000
Message-Id: <20231107155532.3747113-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107155532.3747113-1-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 have a new crypto IP, this patch adds basic support for it.
Only hashes and cipher are handled for the moment.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig                        |  29 +
 drivers/crypto/rockchip/Makefile              |   5 +
 drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
 drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
 drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
 drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
 6 files changed, 1939 insertions(+)
 create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
 create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
 create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
 create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 79c3bb9c99c3..b6a2027b1f9a 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -660,6 +660,35 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
 	  the number of requests per algorithm and other internal stats.
 
 
+config CRYPTO_DEV_ROCKCHIP2
+	tristate "Rockchip's cryptographic offloader V2"
+	depends on OF && ARCH_ROCKCHIP
+	depends on PM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_AES
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SM3_GENERIC
+	select CRYPTO_HASH
+	select CRYPTO_SKCIPHER
+	select CRYPTO_ENGINE
+
+	help
+	  This driver interfaces with the hardware crypto offloader present
+	  on RK3566, RK3568 and RK3588.
+
+config CRYPTO_DEV_ROCKCHIP2_DEBUG
+	bool "Enable Rockchip V2 crypto stats"
+	depends on CRYPTO_DEV_ROCKCHIP2
+	depends on DEBUG_FS
+	help
+	  Say y to enable Rockchip crypto debug stats.
+	  This will create /sys/kernel/debug/rk3588_crypto/stats for displaying
+	  the number of requests per algorithm and other internal stats.
+
 config CRYPTO_DEV_ZYNQMP_AES
 	tristate "Support for Xilinx ZynqMP AES hw accelerator"
 	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
index 785277aca71e..452a12ff6538 100644
--- a/drivers/crypto/rockchip/Makefile
+++ b/drivers/crypto/rockchip/Makefile
@@ -3,3 +3,8 @@ obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rk_crypto.o
 rk_crypto-objs := rk3288_crypto.o \
 		  rk3288_crypto_skcipher.o \
 		  rk3288_crypto_ahash.o
+
+obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP2) += rk_crypto2.o
+rk_crypto2-objs := rk2_crypto.o \
+		  rk2_crypto_skcipher.o \
+		  rk2_crypto_ahash.o
diff --git a/drivers/crypto/rockchip/rk2_crypto.c b/drivers/crypto/rockchip/rk2_crypto.c
new file mode 100644
index 000000000000..f3b8d27924da
--- /dev/null
+++ b/drivers/crypto/rockchip/rk2_crypto.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hardware cryptographic offloader for RK3568/RK3588 SoC
+ *
+ * Copyright (c) 2022-2023, Corentin Labbe <clabbe@baylibre.com>
+ */
+
+#include "rk2_crypto.h"
+#include <linux/clk.h>
+#include <linux/crypto.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+
+static struct rockchip_ip rocklist = {
+	.dev_list = LIST_HEAD_INIT(rocklist.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(rocklist.lock),
+};
+
+struct rk2_crypto_dev *get_rk2_crypto(void)
+{
+	struct rk2_crypto_dev *first;
+
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk2_crypto_dev, list);
+	list_rotate_left(&rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+	return first;
+}
+
+static const struct rk2_variant rk3568_variant = {
+	.num_clks = 3,
+};
+
+static const struct rk2_variant rk3588_variant = {
+	.num_clks = 3,
+};
+
+static int rk2_crypto_get_clks(struct rk2_crypto_dev *dev)
+{
+	int i, j, err;
+	unsigned long cr;
+
+	dev->num_clks = devm_clk_bulk_get_all(dev->dev, &dev->clks);
+	if (dev->num_clks < dev->variant->num_clks) {
+		dev_err(dev->dev, "Missing clocks, got %d instead of %d\n",
+			dev->num_clks, dev->variant->num_clks);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dev->num_clks; i++) {
+		cr = clk_get_rate(dev->clks[i].clk);
+		for (j = 0; j < ARRAY_SIZE(dev->variant->rkclks); j++) {
+			if (dev->variant->rkclks[j].max == 0)
+				continue;
+			if (strcmp(dev->variant->rkclks[j].name, dev->clks[i].id))
+				continue;
+			if (cr > dev->variant->rkclks[j].max) {
+				err = clk_set_rate(dev->clks[i].clk,
+						   dev->variant->rkclks[j].max);
+				if (err)
+					dev_err(dev->dev, "Fail downclocking %s from %lu to %lu\n",
+						dev->variant->rkclks[j].name, cr,
+						dev->variant->rkclks[j].max);
+				else
+					dev_info(dev->dev, "Downclocking %s from %lu to %lu\n",
+						 dev->variant->rkclks[j].name, cr,
+						 dev->variant->rkclks[j].max);
+			}
+		}
+	}
+	return 0;
+}
+
+static int rk2_crypto_enable_clk(struct rk2_crypto_dev *dev)
+{
+	int err;
+
+	err = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
+	if (err)
+		dev_err(dev->dev, "Could not enable clock clks\n");
+
+	return err;
+}
+
+static void rk2_crypto_disable_clk(struct rk2_crypto_dev *dev)
+{
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+}
+
+/*
+ * Power management strategy: The device is suspended until a request
+ * is handled. For avoiding suspend/resume yoyo, the autosuspend is set to 2s.
+ */
+static int rk2_crypto_pm_suspend(struct device *dev)
+{
+	struct rk2_crypto_dev *rkdev = dev_get_drvdata(dev);
+
+	rk2_crypto_disable_clk(rkdev);
+	reset_control_assert(rkdev->rst);
+
+	return 0;
+}
+
+static int rk2_crypto_pm_resume(struct device *dev)
+{
+	struct rk2_crypto_dev *rkdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = rk2_crypto_enable_clk(rkdev);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(rkdev->rst);
+	return 0;
+}
+
+static const struct dev_pm_ops rk2_crypto_pm_ops = {
+	SET_RUNTIME_PM_OPS(rk2_crypto_pm_suspend, rk2_crypto_pm_resume, NULL)
+};
+
+static int rk2_crypto_pm_init(struct rk2_crypto_dev *rkdev)
+{
+	int err;
+
+	pm_runtime_use_autosuspend(rkdev->dev);
+	pm_runtime_set_autosuspend_delay(rkdev->dev, 2000);
+
+	err = pm_runtime_set_suspended(rkdev->dev);
+	if (err)
+		return err;
+	pm_runtime_enable(rkdev->dev);
+	return err;
+}
+
+static void rk2_crypto_pm_exit(struct rk2_crypto_dev *rkdev)
+{
+	pm_runtime_disable(rkdev->dev);
+}
+
+static irqreturn_t rk2_crypto_irq_handle(int irq, void *dev_id)
+{
+	struct rk2_crypto_dev *rkc  = platform_get_drvdata(dev_id);
+	u32 v;
+
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_INT_ST);
+	writel(v, rkc->reg + RK2_CRYPTO_DMA_INT_ST);
+
+	rkc->status = 1;
+	if (v & 0xF8) {
+		dev_warn(rkc->dev, "DMA Error\n");
+		rkc->status = 0;
+	}
+	complete(&rkc->complete);
+
+	return IRQ_HANDLED;
+}
+
+static struct rk2_crypto_template rk2_crypto_algs[] = {
+	{
+		.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.rk2_mode = RK2_CRYPTO_AES_ECB,
+		.alg.skcipher.base = {
+			.base.cra_name		= "ecb(aes)",
+			.base.cra_driver_name	= "ecb-aes-rk2",
+			.base.cra_priority	= 300,
+			.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+			.base.cra_blocksize	= AES_BLOCK_SIZE,
+			.base.cra_ctxsize	= sizeof(struct rk2_cipher_ctx),
+			.base.cra_alignmask	= 0x0f,
+			.base.cra_module	= THIS_MODULE,
+
+			.init			= rk2_cipher_tfm_init,
+			.exit			= rk2_cipher_tfm_exit,
+			.min_keysize		= AES_MIN_KEY_SIZE,
+			.max_keysize		= AES_MAX_KEY_SIZE,
+			.setkey			= rk2_aes_setkey,
+			.encrypt		= rk2_skcipher_encrypt,
+			.decrypt		= rk2_skcipher_decrypt,
+		},
+		.alg.skcipher.op = {
+			.do_one_request = rk2_cipher_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.rk2_mode = RK2_CRYPTO_AES_CBC,
+		.alg.skcipher.base = {
+			.base.cra_name		= "cbc(aes)",
+			.base.cra_driver_name	= "cbc-aes-rk2",
+			.base.cra_priority	= 300,
+			.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+			.base.cra_blocksize	= AES_BLOCK_SIZE,
+			.base.cra_ctxsize	= sizeof(struct rk2_cipher_ctx),
+			.base.cra_alignmask	= 0x0f,
+			.base.cra_module	= THIS_MODULE,
+
+			.init			= rk2_cipher_tfm_init,
+			.exit			= rk2_cipher_tfm_exit,
+			.min_keysize		= AES_MIN_KEY_SIZE,
+			.max_keysize		= AES_MAX_KEY_SIZE,
+			.ivsize			= AES_BLOCK_SIZE,
+			.setkey			= rk2_aes_setkey,
+			.encrypt		= rk2_skcipher_encrypt,
+			.decrypt		= rk2_skcipher_decrypt,
+		},
+		.alg.skcipher.op = {
+			.do_one_request = rk2_cipher_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_SKCIPHER,
+		.rk2_mode = RK2_CRYPTO_AES_XTS,
+		.is_xts = true,
+		.alg.skcipher.base = {
+			.base.cra_name		= "xts(aes)",
+			.base.cra_driver_name	= "xts-aes-rk2",
+			.base.cra_priority	= 300,
+			.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+			.base.cra_blocksize	= AES_BLOCK_SIZE,
+			.base.cra_ctxsize	= sizeof(struct rk2_cipher_ctx),
+			.base.cra_alignmask	= 0x0f,
+			.base.cra_module	= THIS_MODULE,
+
+			.init			= rk2_cipher_tfm_init,
+			.exit			= rk2_cipher_tfm_exit,
+			.min_keysize		= AES_MIN_KEY_SIZE * 2,
+			.max_keysize		= AES_MAX_KEY_SIZE * 2,
+			.ivsize			= AES_BLOCK_SIZE,
+			.setkey			= rk2_aes_xts_setkey,
+			.encrypt		= rk2_skcipher_encrypt,
+			.decrypt		= rk2_skcipher_decrypt,
+		},
+		.alg.skcipher.op = {
+			.do_one_request = rk2_cipher_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_MD5,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = MD5_DIGEST_SIZE,
+				.statesize = sizeof(struct md5_state),
+				.base = {
+					.cra_name = "md5",
+					.cra_driver_name = "rk2-md5",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_SHA1,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = SHA1_DIGEST_SIZE,
+				.statesize = sizeof(struct sha1_state),
+				.base = {
+					.cra_name = "sha1",
+					.cra_driver_name = "rk2-sha1",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA1_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_SHA256,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = SHA256_DIGEST_SIZE,
+				.statesize = sizeof(struct sha256_state),
+				.base = {
+					.cra_name = "sha256",
+					.cra_driver_name = "rk2-sha256",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA256_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_SHA384,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = SHA384_DIGEST_SIZE,
+				.statesize = sizeof(struct sha512_state),
+				.base = {
+					.cra_name = "sha384",
+					.cra_driver_name = "rk2-sha384",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA384_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_SHA512,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = SHA512_DIGEST_SIZE,
+				.statesize = sizeof(struct sha512_state),
+				.base = {
+					.cra_name = "sha512",
+					.cra_driver_name = "rk2-sha512",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SHA512_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+	},
+	{
+		.type = CRYPTO_ALG_TYPE_AHASH,
+		.rk2_mode = RK2_CRYPTO_SM3,
+		.alg.hash.base = {
+			.init = rk2_ahash_init,
+			.update = rk2_ahash_update,
+			.final = rk2_ahash_final,
+			.finup = rk2_ahash_finup,
+			.export = rk2_ahash_export,
+			.import = rk2_ahash_import,
+			.digest = rk2_ahash_digest,
+			.init_tfm = rk2_hash_init_tfm,
+			.exit_tfm = rk2_hash_exit_tfm,
+			.halg = {
+				.digestsize = SM3_DIGEST_SIZE,
+				.statesize = sizeof(struct sm3_state),
+				.base = {
+					.cra_name = "sm3",
+					.cra_driver_name = "rk2-sm3",
+					.cra_priority = 300,
+					.cra_flags = CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_NEED_FALLBACK,
+					.cra_blocksize = SM3_BLOCK_SIZE,
+					.cra_ctxsize = sizeof(struct rk2_ahash_ctx),
+					.cra_module = THIS_MODULE,
+				}
+			}
+		},
+		.alg.hash.op = {
+			.do_one_request = rk2_hash_run,
+		},
+	},
+};
+
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+static int rk2_crypto_debugfs_stats_show(struct seq_file *seq, void *v)
+{
+	struct rk2_crypto_dev *rkc;
+	unsigned int i;
+
+	spin_lock(&rocklist.lock);
+	list_for_each_entry(rkc, &rocklist.dev_list, list) {
+		seq_printf(seq, "%s %s requests: %lu\n",
+			   dev_driver_string(rkc->dev), dev_name(rkc->dev),
+			   rkc->nreq);
+	}
+	spin_unlock(&rocklist.lock);
+
+	for (i = 0; i < ARRAY_SIZE(rk2_crypto_algs); i++) {
+		if (!rk2_crypto_algs[i].dev)
+			continue;
+		switch (rk2_crypto_algs[i].type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
+				   rk2_crypto_algs[i].alg.skcipher.base.base.cra_driver_name,
+				   rk2_crypto_algs[i].alg.skcipher.base.base.cra_name,
+				   rk2_crypto_algs[i].stat_req, rk2_crypto_algs[i].stat_fb);
+			seq_printf(seq, "\tfallback due to length: %lu\n",
+				   rk2_crypto_algs[i].stat_fb_len);
+			seq_printf(seq, "\tfallback due to alignment: %lu\n",
+				   rk2_crypto_algs[i].stat_fb_align);
+			seq_printf(seq, "\tfallback due to SGs: %lu\n",
+				   rk2_crypto_algs[i].stat_fb_sgdiff);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
+				   rk2_crypto_algs[i].alg.hash.base.halg.base.cra_driver_name,
+				   rk2_crypto_algs[i].alg.hash.base.halg.base.cra_name,
+				   rk2_crypto_algs[i].stat_req, rk2_crypto_algs[i].stat_fb);
+			break;
+		}
+	}
+	return 0;
+}
+
+static int rk2_crypto_debugfs_info_show(struct seq_file *seq, void *d)
+{
+	struct rk2_crypto_dev *rkc;
+	u32 v;
+
+	spin_lock(&rocklist.lock);
+	list_for_each_entry(rkc, &rocklist.dev_list, list) {
+		v = readl(rkc->reg + RK2_CRYPTO_CLK_CTL);
+		seq_printf(seq, "CRYPTO_CLK_CTL %x\n", v);
+		v = readl(rkc->reg + RK2_CRYPTO_RST_CTL);
+		seq_printf(seq, "CRYPTO_RST_CTL %x\n", v);
+
+		v = readl(rkc->reg + CRYPTO_AES_VERSION);
+		seq_printf(seq, "CRYPTO_AES_VERSION %x\n", v);
+		if (v & BIT(17))
+			seq_puts(seq, "AES 192\n");
+
+		v = readl(rkc->reg + CRYPTO_DES_VERSION);
+		seq_printf(seq, "CRYPTO_DES_VERSION %x\n", v);
+		v = readl(rkc->reg + CRYPTO_SM4_VERSION);
+		seq_printf(seq, "CRYPTO_SM4_VERSION %x\n", v);
+		v = readl(rkc->reg + CRYPTO_HASH_VERSION);
+		seq_printf(seq, "CRYPTO_HASH_VERSION %x\n", v);
+		v = readl(rkc->reg + CRYPTO_HMAC_VERSION);
+		seq_printf(seq, "CRYPTO_HMAC_VERSION %x\n", v);
+	v = readl(rkc->reg + CRYPTO_RNG_VERSION);
+	seq_printf(seq, "CRYPTO_RNG_VERSION %x\n", v);
+	v = readl(rkc->reg + CRYPTO_PKA_VERSION);
+	seq_printf(seq, "CRYPTO_PKA_VERSION %x\n", v);
+	v = readl(rkc->reg + CRYPTO_CRYPTO_VERSION);
+	seq_printf(seq, "CRYPTO_CRYPTO_VERSION %x\n", v);
+	}
+	spin_unlock(&rocklist.lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(rk2_crypto_debugfs_stats);
+DEFINE_SHOW_ATTRIBUTE(rk2_crypto_debugfs_info);
+
+#endif
+
+static void register_debugfs(struct rk2_crypto_dev *crypto_dev)
+{
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+	/* Ignore error of debugfs */
+	rocklist.dbgfs_dir = debugfs_create_dir("rk2_crypto", NULL);
+	rocklist.dbgfs_stats = debugfs_create_file("stats", 0440,
+						   rocklist.dbgfs_dir,
+						   &rocklist,
+						   &rk2_crypto_debugfs_stats_fops);
+	rocklist.dbgfs_stats = debugfs_create_file("info", 0440,
+						   rocklist.dbgfs_dir,
+						   &rocklist,
+						   &rk2_crypto_debugfs_info_fops);
+#endif
+}
+
+static int rk2_crypto_register(struct rk2_crypto_dev *rkc)
+{
+	unsigned int i, k;
+	int err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(rk2_crypto_algs); i++) {
+		rk2_crypto_algs[i].dev = rkc;
+		switch (rk2_crypto_algs[i].type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			dev_info(rkc->dev, "Register %s as %s\n",
+				 rk2_crypto_algs[i].alg.skcipher.base.base.cra_name,
+				 rk2_crypto_algs[i].alg.skcipher.base.base.cra_driver_name);
+			err = crypto_engine_register_skcipher(&rk2_crypto_algs[i].alg.skcipher);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			dev_info(rkc->dev, "Register %s as %s %d\n",
+				 rk2_crypto_algs[i].alg.hash.base.halg.base.cra_name,
+				 rk2_crypto_algs[i].alg.hash.base.halg.base.cra_driver_name, i);
+			err = crypto_engine_register_ahash(&rk2_crypto_algs[i].alg.hash);
+			break;
+		default:
+			dev_err(rkc->dev, "unknown algorithm\n");
+		}
+		if (err)
+			goto err_cipher_algs;
+	}
+	return 0;
+
+err_cipher_algs:
+	for (k = 0; k < i; k++) {
+		if (rk2_crypto_algs[k].type == CRYPTO_ALG_TYPE_SKCIPHER)
+			crypto_engine_unregister_skcipher(&rk2_crypto_algs[k].alg.skcipher);
+		else
+			crypto_engine_unregister_ahash(&rk2_crypto_algs[k].alg.hash);
+	}
+	return err;
+}
+
+static void rk2_crypto_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rk2_crypto_algs); i++) {
+		if (rk2_crypto_algs[i].type == CRYPTO_ALG_TYPE_SKCIPHER)
+			crypto_engine_unregister_skcipher(&rk2_crypto_algs[i].alg.skcipher);
+		else
+			crypto_engine_unregister_ahash(&rk2_crypto_algs[i].alg.hash);
+	}
+}
+
+static const struct of_device_id crypto_of_id_table[] = {
+	{ .compatible = "rockchip,rk3568-crypto",
+	  .data = &rk3568_variant,
+	},
+	{ .compatible = "rockchip,rk3588-crypto",
+	  .data = &rk3588_variant,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, crypto_of_id_table);
+
+static int rk2_crypto_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rk2_crypto_dev *rkc, *first;
+	int err = 0;
+
+	rkc = devm_kzalloc(&pdev->dev, sizeof(*rkc), GFP_KERNEL);
+	if (!rkc) {
+		err = -ENOMEM;
+		goto err_crypto;
+	}
+
+	rkc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rkc);
+
+	rkc->variant = of_device_get_match_data(&pdev->dev);
+	if (!rkc->variant) {
+		dev_err(&pdev->dev, "Missing variant\n");
+		return -EINVAL;
+	}
+
+	rkc->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(rkc->rst)) {
+		err = PTR_ERR(rkc->rst);
+		dev_err(&pdev->dev, "Fail to get resets err=%d\n", err);
+		goto err_crypto;
+	}
+
+	rkc->tl = dma_alloc_coherent(rkc->dev,
+				     sizeof(struct rk2_crypto_lli) * MAX_LLI,
+				     &rkc->t_phy, GFP_KERNEL);
+	if (!rkc->tl) {
+		dev_err(rkc->dev, "Cannot get DMA memory for task\n");
+		err = -ENOMEM;
+		goto err_crypto;
+	}
+
+	reset_control_assert(rkc->rst);
+	usleep_range(10, 20);
+	reset_control_deassert(rkc->rst);
+
+	rkc->reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rkc->reg)) {
+		err = PTR_ERR(rkc->reg);
+		dev_err(&pdev->dev, "Fail to get resources\n");
+		goto err_crypto;
+	}
+
+	err = rk2_crypto_get_clks(rkc);
+	if (err)
+		goto err_crypto;
+
+	rkc->irq = platform_get_irq(pdev, 0);
+	if (rkc->irq < 0) {
+		dev_err(&pdev->dev, "control Interrupt is not available.\n");
+		err = rkc->irq;
+		goto err_crypto;
+	}
+
+	err = devm_request_irq(&pdev->dev, rkc->irq,
+			       rk2_crypto_irq_handle, IRQF_SHARED,
+			       "rk-crypto", pdev);
+
+	if (err) {
+		dev_err(&pdev->dev, "irq request failed.\n");
+		goto err_crypto;
+	}
+
+	rkc->engine = crypto_engine_alloc_init(&pdev->dev, true);
+	crypto_engine_start(rkc->engine);
+	init_completion(&rkc->complete);
+
+	err = rk2_crypto_pm_init(rkc);
+	if (err)
+		goto err_pm;
+
+	err = pm_runtime_resume_and_get(&pdev->dev);
+
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk2_crypto_dev, list);
+	list_add_tail(&rkc->list, &rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+
+	if (!first) {
+		dev_info(dev, "Registers crypto algos\n");
+		err = rk2_crypto_register(rkc);
+		if (err) {
+			dev_err(dev, "Fail to register crypto algorithms");
+			goto err_register_alg;
+		}
+
+		register_debugfs(rkc);
+	}
+
+	return 0;
+
+err_register_alg:
+	rk2_crypto_pm_exit(rkc);
+err_pm:
+	crypto_engine_exit(rkc->engine);
+err_crypto:
+	dev_err(dev, "Crypto Accelerator not successfully registered\n");
+	return err;
+}
+
+static int rk2_crypto_remove(struct platform_device *pdev)
+{
+	struct rk2_crypto_dev *rkc = platform_get_drvdata(pdev);
+	struct rk2_crypto_dev *first;
+
+	spin_lock_bh(&rocklist.lock);
+	list_del(&rkc->list);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk2_crypto_dev, list);
+	spin_unlock_bh(&rocklist.lock);
+
+	if (!first) {
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP2_DEBUG
+		debugfs_remove_recursive(rocklist.dbgfs_dir);
+#endif
+		rk2_crypto_unregister();
+	}
+	rk2_crypto_pm_exit(rkc);
+	crypto_engine_exit(rkc->engine);
+	return 0;
+}
+
+static struct platform_driver crypto_driver = {
+	.probe		= rk2_crypto_probe,
+	.remove		= rk2_crypto_remove,
+	.driver		= {
+		.name	= "rk2-crypto",
+		.pm		= &rk2_crypto_pm_ops,
+		.of_match_table	= crypto_of_id_table,
+	},
+};
+
+module_platform_driver(crypto_driver);
+
+MODULE_DESCRIPTION("Rockchip Crypto Engine cryptographic offloader");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Corentin Labbe <clabbe@baylibre.com>");
diff --git a/drivers/crypto/rockchip/rk2_crypto.h b/drivers/crypto/rockchip/rk2_crypto.h
new file mode 100644
index 000000000000..59cd8be59f70
--- /dev/null
+++ b/drivers/crypto/rockchip/rk2_crypto.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <crypto/aes.h>
+#include <crypto/xts.h>
+#include <crypto/engine.h>
+#include <crypto/internal/des.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/md5.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/hw_random.h>
+
+#define RK2_CRYPTO_CLK_CTL	0x0000
+#define RK2_CRYPTO_RST_CTL	0x0004
+
+#define RK2_CRYPTO_DMA_INT_EN	0x0008
+/* values for RK2_CRYPTO_DMA_INT_EN */
+#define RK2_CRYPTO_DMA_INT_LISTDONE	BIT(0)
+
+#define RK2_CRYPTO_DMA_INT_ST	0x000C
+/* values in RK2_CRYPTO_DMA_INT_ST are the same than in RK2_CRYPTO_DMA_INT_EN */
+
+#define RK2_CRYPTO_DMA_CTL	0x0010
+#define RK2_CRYPTO_DMA_CTL_START	BIT(0)
+
+#define RK2_CRYPTO_DMA_LLI_ADDR	0x0014
+#define RK2_CRYPTO_DMA_ST	0x0018
+#define RK2_CRYPTO_DMA_STATE	0x001C
+#define RK2_CRYPTO_DMA_LLI_RADDR	0x0020
+#define RK2_CRYPTO_DMA_SRC_RADDR	0x0024
+#define RK2_CRYPTO_DMA_DST_WADDR	0x0028
+#define RK2_CRYPTO_DMA_ITEM_ID		0x002C
+
+#define RK2_CRYPTO_FIFO_CTL	0x0040
+
+#define RK2_CRYPTO_BC_CTL	0x0044
+#define RK2_CRYPTO_AES		(0 << 8)
+#define RK2_CRYPTO_MODE_ECB	(0 << 4)
+#define RK2_CRYPTO_MODE_CBC	(1 << 4)
+#define RK2_CRYPTO_XTS		(6 << 4)
+
+#define RK2_CRYPTO_HASH_CTL	0x0048
+#define RK2_CRYPTO_HW_PAD	BIT(2)
+#define RK2_CRYPTO_SHA1		(0 << 4)
+#define RK2_CRYPTO_MD5		(1 << 4)
+#define RK2_CRYPTO_SHA224	(3 << 4)
+#define RK2_CRYPTO_SHA256	(2 << 4)
+#define RK2_CRYPTO_SHA384	(9 << 4)
+#define RK2_CRYPTO_SHA512	(8 << 4)
+#define RK2_CRYPTO_SM3		(4 << 4)
+
+#define RK2_CRYPTO_AES_ECB		(RK2_CRYPTO_AES | RK2_CRYPTO_MODE_ECB)
+#define RK2_CRYPTO_AES_CBC		(RK2_CRYPTO_AES | RK2_CRYPTO_MODE_CBC)
+#define RK2_CRYPTO_AES_XTS		(RK2_CRYPTO_AES | RK2_CRYPTO_XTS)
+#define RK2_CRYPTO_AES_CTR_MODE		3
+#define RK2_CRYPTO_AES_128BIT_key	(0 << 2)
+#define RK2_CRYPTO_AES_192BIT_key	(1 << 2)
+#define RK2_CRYPTO_AES_256BIT_key	(2 << 2)
+
+#define RK2_CRYPTO_DEC			BIT(1)
+#define RK2_CRYPTO_ENABLE		BIT(0)
+
+#define RK2_CRYPTO_CIPHER_ST	0x004C
+#define RK2_CRYPTO_CIPHER_STATE	0x0050
+
+#define RK2_CRYPTO_CH0_IV_0		0x0100
+
+#define RK2_CRYPTO_KEY0			0x0180
+#define RK2_CRYPTO_KEY1			0x0184
+#define RK2_CRYPTO_KEY2			0x0188
+#define RK2_CRYPTO_KEY3			0x018C
+#define RK2_CRYPTO_KEY4			0x0190
+#define RK2_CRYPTO_KEY5			0x0194
+#define RK2_CRYPTO_KEY6			0x0198
+#define RK2_CRYPTO_KEY7			0x019C
+#define RK2_CRYPTO_CH4_KEY0		0x01c0
+
+#define RK2_CRYPTO_CH0_PC_LEN_0		0x0280
+
+#define RK2_CRYPTO_CH0_IV_LEN		0x0300
+
+#define RK2_CRYPTO_HASH_DOUT_0	0x03A0
+#define RK2_CRYPTO_HASH_VALID	0x03E4
+
+#define RK2_CRYPTO_TRNG_CTL	0x0400
+#define RK2_CRYPTO_TRNG_START	BIT(0)
+#define RK2_CRYPTO_TRNG_ENABLE	BIT(1)
+#define RK2_CRYPTO_TRNG_256	(0x3 << 4)
+#define RK2_CRYPTO_TRNG_SAMPLE_CNT	0x0404
+#define RK2_CRYPTO_TRNG_DOUT	0x0410
+
+#define CRYPTO_AES_VERSION	0x0680
+#define CRYPTO_DES_VERSION	0x0684
+#define CRYPTO_SM4_VERSION	0x0688
+#define CRYPTO_HASH_VERSION	0x068C
+#define CRYPTO_HMAC_VERSION	0x0690
+#define CRYPTO_RNG_VERSION	0x0694
+#define CRYPTO_PKA_VERSION	0x0698
+#define CRYPTO_CRYPTO_VERSION	0x06F0
+
+#define RK2_LLI_DMA_CTRL_SRC_INT		BIT(10)
+#define RK2_LLI_DMA_CTRL_DST_INT		BIT(9)
+#define RK2_LLI_DMA_CTRL_LIST_INT	BIT(8)
+#define RK2_LLI_DMA_CTRL_LAST		BIT(0)
+
+#define RK2_LLI_STRING_LAST		BIT(2)
+#define RK2_LLI_STRING_FIRST		BIT(1)
+#define RK2_LLI_CIPHER_START		BIT(0)
+
+#define RK2_MAX_CLKS 4
+
+#define MAX_LLI 20
+
+struct rk2_crypto_lli {
+	__le32 src_addr;
+	__le32 src_len;
+	__le32 dst_addr;
+	__le32 dst_len;
+	__le32 user;
+	__le32 iv;
+	__le32 dma_ctrl;
+	__le32 next;
+};
+
+/*
+ * struct rockchip_ip - struct for managing a list of RK crypto instance
+ * @dev_list:		Used for doing a list of rk2_crypto_dev
+ * @lock:		Control access to dev_list
+ * @dbgfs_dir:		Debugfs dentry for statistic directory
+ * @dbgfs_stats:	Debugfs dentry for statistic counters
+ */
+struct rockchip_ip {
+	struct list_head	dev_list;
+	spinlock_t		lock; /* Control access to dev_list */
+	struct dentry		*dbgfs_dir;
+	struct dentry		*dbgfs_stats;
+};
+
+struct rk2_clks {
+	const char *name;
+	unsigned long max;
+};
+
+struct rk2_variant {
+	int num_clks;
+	struct rk2_clks rkclks[RK2_MAX_CLKS];
+};
+
+struct rk2_crypto_dev {
+	struct list_head		list;
+	struct device			*dev;
+	struct clk_bulk_data		*clks;
+	int				num_clks;
+	struct reset_control		*rst;
+	void __iomem			*reg;
+	int				irq;
+	const struct rk2_variant *variant;
+	unsigned long nreq;
+	struct crypto_engine *engine;
+	struct completion complete;
+	int status;
+	struct rk2_crypto_lli *tl;
+	dma_addr_t t_phy;
+};
+
+/* the private variable of hash */
+struct rk2_ahash_ctx {
+	/* for fallback */
+	struct crypto_ahash		*fallback_tfm;
+};
+
+/* the private variable of hash for fallback */
+struct rk2_ahash_rctx {
+	struct rk2_crypto_dev		*dev;
+	struct ahash_request		fallback_req;
+	u32				mode;
+	int nrsgs;
+};
+
+/* the private variable of cipher */
+struct rk2_cipher_ctx {
+	unsigned int			keylen;
+	u8				key[AES_MAX_KEY_SIZE * 2];
+	u8				iv[AES_BLOCK_SIZE];
+	struct crypto_skcipher *fallback_tfm;
+};
+
+struct rk2_cipher_rctx {
+	struct rk2_crypto_dev		*dev;
+	u8 backup_iv[AES_BLOCK_SIZE];
+	u32				mode;
+	struct skcipher_request fallback_req;   // keep at the end
+};
+
+struct rk2_crypto_template {
+	u32 type;
+	u32 rk2_mode;
+	bool is_xts;
+	struct rk2_crypto_dev           *dev;
+	union {
+		struct skcipher_engine_alg	skcipher;
+		struct ahash_engine_alg	hash;
+	} alg;
+	unsigned long stat_req;
+	unsigned long stat_fb;
+	unsigned long stat_fb_len;
+	unsigned long stat_fb_sglen;
+	unsigned long stat_fb_align;
+	unsigned long stat_fb_sgdiff;
+};
+
+struct rk2_crypto_dev *get_rk2_crypto(void);
+int rk2_cipher_run(struct crypto_engine *engine, void *async_req);
+int rk2_hash_run(struct crypto_engine *engine, void *breq);
+
+int rk2_cipher_tfm_init(struct crypto_skcipher *tfm);
+void rk2_cipher_tfm_exit(struct crypto_skcipher *tfm);
+int rk2_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		   unsigned int keylen);
+int rk2_aes_xts_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		       unsigned int keylen);
+int rk2_skcipher_encrypt(struct skcipher_request *req);
+int rk2_skcipher_decrypt(struct skcipher_request *req);
+int rk2_aes_ecb_encrypt(struct skcipher_request *req);
+int rk2_aes_ecb_decrypt(struct skcipher_request *req);
+int rk2_aes_cbc_encrypt(struct skcipher_request *req);
+int rk2_aes_cbc_decrypt(struct skcipher_request *req);
+
+int rk2_ahash_init(struct ahash_request *req);
+int rk2_ahash_update(struct ahash_request *req);
+int rk2_ahash_final(struct ahash_request *req);
+int rk2_ahash_finup(struct ahash_request *req);
+int rk2_ahash_import(struct ahash_request *req, const void *in);
+int rk2_ahash_export(struct ahash_request *req, void *out);
+int rk2_ahash_digest(struct ahash_request *req);
+int rk2_hash_init_tfm(struct crypto_ahash *tfm);
+void rk2_hash_exit_tfm(struct crypto_ahash *tfm);
diff --git a/drivers/crypto/rockchip/rk2_crypto_ahash.c b/drivers/crypto/rockchip/rk2_crypto_ahash.c
new file mode 100644
index 000000000000..75b8d9893447
--- /dev/null
+++ b/drivers/crypto/rockchip/rk2_crypto_ahash.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Crypto offloader support for Rockchip RK3568/RK3588
+ *
+ * Copyright (c) 2022-2023 Corentin Labbe <clabbe@baylibre.com>
+ */
+#include <asm/unaligned.h>
+#include <linux/iopoll.h>
+#include "rk2_crypto.h"
+
+static bool rk2_ahash_need_fallback(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
+	struct scatterlist *sg;
+
+	sg = areq->src;
+	while (sg) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		if (sg->length % 4) {
+			algt->stat_fb_sglen++;
+			return true;
+		}
+		sg = sg_next(sg);
+	}
+	return false;
+}
+
+static int rk2_ahash_digest_fb(struct ahash_request *areq)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk2_ahash_ctx *tfmctx = crypto_ahash_ctx(tfm);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
+
+	algt->stat_fb++;
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+
+	return crypto_ahash_digest(&rctx->fallback_req);
+}
+
+static int zero_message_process(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
+	int digestsize = crypto_ahash_digestsize(tfm);
+
+	switch (algt->rk2_mode) {
+	case RK2_CRYPTO_SHA1:
+		memcpy(req->result, sha1_zero_message_hash, digestsize);
+		break;
+	case RK2_CRYPTO_SHA256:
+		memcpy(req->result, sha256_zero_message_hash, digestsize);
+		break;
+	case RK2_CRYPTO_SHA384:
+		memcpy(req->result, sha384_zero_message_hash, digestsize);
+		break;
+	case RK2_CRYPTO_SHA512:
+		memcpy(req->result, sha512_zero_message_hash, digestsize);
+		break;
+	case RK2_CRYPTO_MD5:
+		memcpy(req->result, md5_zero_message_hash, digestsize);
+		break;
+	case RK2_CRYPTO_SM3:
+		memcpy(req->result, sm3_zero_message_hash, digestsize);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rk2_ahash_init(struct ahash_request *req)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_init(&rctx->fallback_req);
+}
+
+int rk2_ahash_update(struct ahash_request *req)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.nbytes = req->nbytes;
+	rctx->fallback_req.src = req->src;
+
+	return crypto_ahash_update(&rctx->fallback_req);
+}
+
+int rk2_ahash_final(struct ahash_request *req)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.result = req->result;
+
+	return crypto_ahash_final(&rctx->fallback_req);
+}
+
+int rk2_ahash_finup(struct ahash_request *req)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = req->nbytes;
+	rctx->fallback_req.src = req->src;
+	rctx->fallback_req.result = req->result;
+
+	return crypto_ahash_finup(&rctx->fallback_req);
+}
+
+int rk2_ahash_import(struct ahash_request *req, const void *in)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_import(&rctx->fallback_req, in);
+}
+
+int rk2_ahash_export(struct ahash_request *req, void *out)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct rk2_ahash_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, ctx->fallback_tfm);
+	rctx->fallback_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_export(&rctx->fallback_req, out);
+}
+
+int rk2_ahash_digest(struct ahash_request *req)
+{
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(req);
+	struct rk2_crypto_dev *dev;
+	struct crypto_engine *engine;
+
+	if (rk2_ahash_need_fallback(req))
+		return rk2_ahash_digest_fb(req);
+
+	if (!req->nbytes)
+		return zero_message_process(req);
+
+	dev = get_rk2_crypto();
+
+	rctx->dev = dev;
+	engine = dev->engine;
+
+	return crypto_transfer_hash_request_to_engine(engine, req);
+}
+
+static int rk2_hash_prepare(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct rk2_crypto_dev *rkc = rctx->dev;
+	int ret;
+
+	ret = dma_map_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+	if (ret <= 0)
+		return -EINVAL;
+
+	rctx->nrsgs = ret;
+
+	return 0;
+}
+
+static void rk2_hash_unprepare(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct rk2_crypto_dev *rkc = rctx->dev;
+
+	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsgs, DMA_TO_DEVICE);
+}
+
+int rk2_hash_run(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk2_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
+	struct scatterlist *sgs = areq->src;
+	struct rk2_crypto_dev *rkc = rctx->dev;
+	struct rk2_crypto_lli *dd = &rkc->tl[0];
+	int ddi = 0;
+	int err = 0;
+	unsigned int len = areq->nbytes;
+	unsigned int todo;
+	u32 v;
+	int i;
+
+	err = rk2_hash_prepare(engine, breq);
+
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
+	dev_dbg(rkc->dev, "%s %s len=%d\n", __func__,
+		crypto_tfm_alg_name(areq->base.tfm), areq->nbytes);
+
+	algt->stat_req++;
+	rkc->nreq++;
+
+	rctx->mode = algt->rk2_mode;
+	rctx->mode |= 0xffff0000;
+	rctx->mode |= RK2_CRYPTO_ENABLE | RK2_CRYPTO_HW_PAD;
+	writel(rctx->mode, rkc->reg + RK2_CRYPTO_HASH_CTL);
+
+	while (sgs && len > 0) {
+		dd = &rkc->tl[ddi];
+
+		todo = min(sg_dma_len(sgs), len);
+		dd->src_addr = sg_dma_address(sgs);
+		dd->src_len = todo;
+		dd->dst_addr = 0;
+		dd->dst_len = 0;
+		dd->dma_ctrl = ddi << 24;
+		dd->iv = 0;
+		dd->next = rkc->t_phy + sizeof(struct rk2_crypto_lli) * (ddi + 1);
+
+		if (ddi == 0)
+			dd->user = RK2_LLI_CIPHER_START | RK2_LLI_STRING_FIRST;
+		else
+			dd->user = 0;
+
+		len -= todo;
+		dd->dma_ctrl |= RK2_LLI_DMA_CTRL_SRC_INT;
+		if (len == 0) {
+			dd->user |= RK2_LLI_STRING_LAST;
+			dd->dma_ctrl |= RK2_LLI_DMA_CTRL_LAST;
+		}
+		dev_dbg(rkc->dev, "HASH SG %d sglen=%d user=%x dma=%x mode=%x len=%d todo=%d phy=%llx\n",
+			ddi, sgs->length, dd->user, dd->dma_ctrl, rctx->mode, len, todo, rkc->t_phy);
+
+		sgs = sg_next(sgs);
+		ddi++;
+	}
+	dd->next = 1;
+	writel(RK2_CRYPTO_DMA_INT_LISTDONE | 0x7F, rkc->reg + RK2_CRYPTO_DMA_INT_EN);
+
+	writel(rkc->t_phy, rkc->reg + RK2_CRYPTO_DMA_LLI_ADDR);
+
+	reinit_completion(&rkc->complete);
+	rkc->status = 0;
+
+	writel(RK2_CRYPTO_DMA_CTL_START | RK2_CRYPTO_DMA_CTL_START << 16, rkc->reg + RK2_CRYPTO_DMA_CTL);
+
+	wait_for_completion_interruptible_timeout(&rkc->complete,
+						  msecs_to_jiffies(2000));
+	if (!rkc->status) {
+		dev_err(rkc->dev, "DMA timeout\n");
+		err = -EFAULT;
+		goto theend;
+	}
+
+	readl_poll_timeout_atomic(rkc->reg + RK2_CRYPTO_HASH_VALID, v, v == 1,
+				  10, 1000);
+
+	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
+		v = readl(rkc->reg + RK2_CRYPTO_HASH_DOUT_0 + i * 4);
+		put_unaligned_le32(be32_to_cpu(v), areq->result + i * 4);
+	}
+
+theend:
+	pm_runtime_put_autosuspend(rkc->dev);
+
+	rk2_hash_unprepare(engine, breq);
+
+	local_bh_disable();
+	crypto_finalize_hash_request(engine, breq, err);
+	local_bh_enable();
+
+	return 0;
+}
+
+int rk2_hash_init_tfm(struct crypto_ahash *tfm)
+{
+	struct rk2_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
+	const char *alg_name = crypto_ahash_alg_name(tfm);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.hash.base);
+
+	/* for fallback */
+	tctx->fallback_tfm = crypto_alloc_ahash(alg_name, 0,
+						CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(tctx->fallback_tfm)) {
+		dev_err(algt->dev->dev, "Could not load fallback driver.\n");
+		return PTR_ERR(tctx->fallback_tfm);
+	}
+
+	crypto_ahash_set_reqsize(tfm,
+				 sizeof(struct rk2_ahash_rctx) +
+				 crypto_ahash_reqsize(tctx->fallback_tfm));
+	return 0;
+}
+
+void rk2_hash_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct rk2_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	crypto_free_ahash(tctx->fallback_tfm);
+}
diff --git a/drivers/crypto/rockchip/rk2_crypto_skcipher.c b/drivers/crypto/rockchip/rk2_crypto_skcipher.c
new file mode 100644
index 000000000000..3e8e44d84b47
--- /dev/null
+++ b/drivers/crypto/rockchip/rk2_crypto_skcipher.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hardware cryptographic offloader for RK3568/RK3588 SoC
+ *
+ * Copyright (c) 2022-2023 Corentin Labbe <clabbe@baylibre.com>
+ */
+#include <crypto/scatterwalk.h>
+#include "rk2_crypto.h"
+
+static void rk2_print(struct rk2_crypto_dev *rkc)
+{
+	u32 v;
+
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_ST);
+	dev_info(rkc->dev, "DMA_ST %x\n", v);
+	switch (v) {
+	case 0:
+		dev_info(rkc->dev, "DMA_ST: DMA IDLE\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "DMA_ST: DMA BUSY\n");
+		break;
+	default:
+		dev_err(rkc->dev, "DMA_ST: invalid value\n");
+	}
+
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_STATE);
+	dev_info(rkc->dev, "DMA_STATE %x\n", v);
+
+	switch (v & 0x3) {
+	case 0:
+		dev_info(rkc->dev, "DMA_STATE: DMA DST IDLE\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "DMA_STATE: DMA DST LOAD\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "DMA_STATE: DMA DST WORK\n");
+		break;
+	default:
+		dev_err(rkc->dev, "DMA DST invalid\n");
+		break;
+	}
+	switch (v & 0xC) {
+	case 0:
+		dev_info(rkc->dev, "DMA_STATE: DMA SRC IDLE\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "DMA_STATE: DMA SRC LOAD\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "DMA_STATE: DMA SRC WORK\n");
+		break;
+	default:
+		dev_err(rkc->dev, "DMA_STATE: DMA SRC invalid\n");
+		break;
+	}
+	switch (v & 0x30) {
+	case 0:
+		dev_info(rkc->dev, "DMA_STATE: DMA LLI IDLE\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "DMA_STATE: DMA LLI LOAD\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "DMA LLI WORK\n");
+		break;
+	default:
+		dev_err(rkc->dev, "DMA LLI invalid\n");
+		break;
+	}
+
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_LLI_RADDR);
+	dev_info(rkc->dev, "DMA_LLI_RADDR %x\n", v);
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_SRC_RADDR);
+	dev_info(rkc->dev, "DMA_SRC_RADDR %x\n", v);
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_DST_WADDR);
+	dev_info(rkc->dev, "DMA_LLI_WADDR %x\n", v);
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_ITEM_ID);
+	dev_info(rkc->dev, "DMA_LLI_ITEMID %x\n", v);
+
+	v = readl(rkc->reg + RK2_CRYPTO_CIPHER_ST);
+	dev_info(rkc->dev, "CIPHER_ST %x\n", v);
+	if (v & BIT(0))
+		dev_info(rkc->dev, "CIPHER_ST: BLOCK CIPHER BUSY\n");
+	else
+		dev_info(rkc->dev, "CIPHER_ST: BLOCK CIPHER IDLE\n");
+	if (v & BIT(2))
+		dev_info(rkc->dev, "CIPHER_ST: HASH BUSY\n");
+	else
+		dev_info(rkc->dev, "CIPHER_ST: HASH IDLE\n");
+	if (v & BIT(2))
+		dev_info(rkc->dev, "CIPHER_ST: OTP KEY VALID\n");
+	else
+		dev_info(rkc->dev, "CIPHER_ST: OTP KEY INVALID\n");
+
+	v = readl(rkc->reg + RK2_CRYPTO_CIPHER_STATE);
+	dev_info(rkc->dev, "CIPHER_STATE %x\n", v);
+	switch (v & 0x3) {
+	case 0:
+		dev_info(rkc->dev, "serial: IDLE state\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "serial: PRE state\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "serial: BULK state\n");
+		break;
+	default:
+		dev_info(rkc->dev, "serial: reserved state\n");
+		break;
+	}
+	switch (v & 0xC) {
+	case 0:
+		dev_info(rkc->dev, "mac_state: IDLE state\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "mac_state: PRE state\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "mac_state: BULK state\n");
+		break;
+	default:
+		dev_info(rkc->dev, "mac_state: reserved state\n");
+		break;
+	}
+	switch (v & 0x30) {
+	case 0:
+		dev_info(rkc->dev, "parallel_state: IDLE state\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "parallel_state: PRE state\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "parallel_state: BULK state\n");
+		break;
+	default:
+		dev_info(rkc->dev, "parallel_state: reserved state\n");
+		break;
+	}
+	switch (v & 0xC0) {
+	case 0:
+		dev_info(rkc->dev, "ccm_state: IDLE state\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "ccm_state: PRE state\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "ccm_state: NA state\n");
+		break;
+	default:
+		dev_info(rkc->dev, "ccm_state: reserved state\n");
+		break;
+	}
+	switch (v & 0xF00) {
+	case 0:
+		dev_info(rkc->dev, "gcm_state: IDLE state\n");
+		break;
+	case 1:
+		dev_info(rkc->dev, "gcm_state: PRE state\n");
+		break;
+	case 2:
+		dev_info(rkc->dev, "gcm_state: NA state\n");
+		break;
+	case 3:
+		dev_info(rkc->dev, "gcm_state: PC state\n");
+		break;
+	}
+	switch (v & 0xC00) {
+	case 0x1:
+		dev_info(rkc->dev, "hash_state: IDLE state\n");
+		break;
+	case 0x2:
+		dev_info(rkc->dev, "hash_state: IPAD state\n");
+		break;
+	case 0x4:
+		dev_info(rkc->dev, "hash_state: TEXT state\n");
+		break;
+	case 0x8:
+		dev_info(rkc->dev, "hash_state: OPAD state\n");
+		break;
+	case 0x10:
+		dev_info(rkc->dev, "hash_state: OPAD EXT state\n");
+		break;
+	default:
+		dev_info(rkc->dev, "hash_state: invalid state\n");
+		break;
+	}
+
+	v = readl(rkc->reg + RK2_CRYPTO_DMA_INT_ST);
+	dev_info(rkc->dev, "RK2_CRYPTO_DMA_INT_ST %x\n", v);
+}
+
+static int rk2_cipher_need_fallback(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+	struct scatterlist *sgs, *sgd;
+	unsigned int stodo, dtodo, len;
+	unsigned int bs = crypto_skcipher_blocksize(tfm);
+
+	if (!req->cryptlen)
+		return true;
+
+	if (algt->is_xts) {
+		if (sg_nents_for_len(req->src, req->cryptlen) > 1)
+			return true;
+		if (sg_nents_for_len(req->dst, req->cryptlen) > 1)
+			return true;
+	}
+
+	len = req->cryptlen;
+	sgs = req->src;
+	sgd = req->dst;
+	while (sgs && sgd) {
+		if (!IS_ALIGNED(sgs->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		if (!IS_ALIGNED(sgd->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
+			return true;
+		}
+		stodo = min(len, sgs->length);
+		if (stodo % bs) {
+			algt->stat_fb_len++;
+			return true;
+		}
+		dtodo = min(len, sgd->length);
+		if (dtodo % bs) {
+			algt->stat_fb_len++;
+			return true;
+		}
+		if (stodo != dtodo) {
+			algt->stat_fb_sgdiff++;
+			return true;
+		}
+		len -= stodo;
+		sgs = sg_next(sgs);
+		sgd = sg_next(sgd);
+	}
+	return false;
+}
+
+static int rk2_cipher_fallback(struct skcipher_request *areq)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct rk2_cipher_ctx *op = crypto_skcipher_ctx(tfm);
+	struct rk2_cipher_rctx *rctx = skcipher_request_ctx(areq);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+	int err;
+
+	algt->stat_fb++;
+
+	skcipher_request_set_tfm(&rctx->fallback_req, op->fallback_tfm);
+	skcipher_request_set_callback(&rctx->fallback_req, areq->base.flags,
+				      areq->base.complete, areq->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, areq->src, areq->dst,
+				   areq->cryptlen, areq->iv);
+	if (rctx->mode & RK2_CRYPTO_DEC)
+		err = crypto_skcipher_decrypt(&rctx->fallback_req);
+	else
+		err = crypto_skcipher_encrypt(&rctx->fallback_req);
+	return err;
+}
+
+static int rk2_cipher_handle_req(struct skcipher_request *req)
+{
+	struct rk2_cipher_rctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk2_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk2_crypto_dev *rkc;
+	struct crypto_engine *engine;
+
+	if (ctx->keylen == AES_KEYSIZE_192 * 2)
+		return rk2_cipher_fallback(req);
+
+	if (rk2_cipher_need_fallback(req))
+		return rk2_cipher_fallback(req);
+
+	rkc = get_rk2_crypto();
+
+	engine = rkc->engine;
+	rctx->dev = rkc;
+
+	return crypto_transfer_skcipher_request_to_engine(engine, req);
+}
+
+int rk2_aes_xts_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		       unsigned int keylen)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk2_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+	int err;
+
+	err = xts_verify_key(cipher, key, keylen);
+	if (err)
+		return err;
+
+	ctx->keylen = keylen;
+	memcpy(ctx->key, key, keylen);
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
+}
+
+int rk2_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
+		   unsigned int keylen)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk2_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256)
+		return -EINVAL;
+	ctx->keylen = keylen;
+	memcpy(ctx->key, key, keylen);
+
+	return crypto_skcipher_setkey(ctx->fallback_tfm, key, keylen);
+}
+
+int rk2_skcipher_encrypt(struct skcipher_request *req)
+{
+	struct rk2_cipher_rctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+
+	rctx->mode = algt->rk2_mode;
+	return rk2_cipher_handle_req(req);
+}
+
+int rk2_skcipher_decrypt(struct skcipher_request *req)
+{
+	struct rk2_cipher_rctx *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+
+	rctx->mode = algt->rk2_mode | RK2_CRYPTO_DEC;
+	return rk2_cipher_handle_req(req);
+}
+
+int rk2_cipher_run(struct crypto_engine *engine, void *async_req)
+{
+	struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct rk2_cipher_rctx *rctx = skcipher_request_ctx(areq);
+	struct rk2_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct scatterlist *sgs, *sgd;
+	int err = 0;
+	int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int len = areq->cryptlen;
+	unsigned int todo;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+	struct rk2_crypto_dev *rkc = rctx->dev;
+	struct rk2_crypto_lli *dd = &rkc->tl[0];
+	u32 m, v;
+	u32 *rkey = (u32 *)ctx->key;
+	u32 *riv = (u32 *)areq->iv;
+	int i;
+	unsigned int offset;
+
+	algt->stat_req++;
+	rkc->nreq++;
+
+	m = rctx->mode | RK2_CRYPTO_ENABLE;
+	if (algt->is_xts) {
+		switch (ctx->keylen) {
+		case AES_KEYSIZE_128 * 2:
+			m |= RK2_CRYPTO_AES_128BIT_key;
+			break;
+		case AES_KEYSIZE_256 * 2:
+			m |= RK2_CRYPTO_AES_256BIT_key;
+			break;
+		default:
+			dev_err(rkc->dev, "Invalid key length %u\n", ctx->keylen);
+			return -EINVAL;
+		}
+	} else {
+		switch (ctx->keylen) {
+		case AES_KEYSIZE_128:
+			m |= RK2_CRYPTO_AES_128BIT_key;
+			break;
+		case AES_KEYSIZE_192:
+			m |= RK2_CRYPTO_AES_192BIT_key;
+			break;
+		case AES_KEYSIZE_256:
+			m |= RK2_CRYPTO_AES_256BIT_key;
+			break;
+		default:
+			dev_err(rkc->dev, "Invalid key length %u\n", ctx->keylen);
+			return -EINVAL;
+		}
+	}
+
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
+	/* the upper bits are a write enable mask, so we need to write 1 to all
+	 * upper 16 bits to allow write to the 16 lower bits
+	 */
+	m |= 0xffff0000;
+
+	dev_dbg(rkc->dev, "%s %s len=%u keylen=%u mode=%x\n", __func__,
+		crypto_tfm_alg_name(areq->base.tfm),
+		areq->cryptlen, ctx->keylen, m);
+	sgs = areq->src;
+	sgd = areq->dst;
+
+	while (sgs && sgd && len) {
+		ivsize = crypto_skcipher_ivsize(tfm);
+		if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
+			if (rctx->mode & RK2_CRYPTO_DEC) {
+				offset = sgs->length - ivsize;
+				scatterwalk_map_and_copy(rctx->backup_iv, sgs,
+							 offset, ivsize, 0);
+			}
+		}
+
+		dev_dbg(rkc->dev, "SG len=%u mode=%x ivsize=%u\n", sgs->length, m, ivsize);
+
+		if (sgs == sgd) {
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				goto theend;
+			}
+		} else {
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				goto theend;
+			}
+			err = dma_map_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
+			if (err != 1) {
+				dev_err(rkc->dev, "Invalid sg number %d\n", err);
+				err = -EINVAL;
+				dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+				goto theend;
+			}
+		}
+		err = 0;
+		writel(m, rkc->reg + RK2_CRYPTO_BC_CTL);
+
+		if (algt->is_xts) {
+			for (i = 0; i < ctx->keylen / 8; i++) {
+				v = cpu_to_be32(rkey[i]);
+				writel(v, rkc->reg + RK2_CRYPTO_KEY0 + i * 4);
+			}
+			for (i = 0; i < (ctx->keylen / 8); i++) {
+				v = cpu_to_be32(rkey[i + ctx->keylen / 8]);
+				writel(v, rkc->reg + RK2_CRYPTO_CH4_KEY0 + i * 4);
+			}
+		} else {
+			for (i = 0; i < ctx->keylen / 4; i++) {
+				v = cpu_to_be32(rkey[i]);
+				writel(v, rkc->reg + RK2_CRYPTO_KEY0 + i * 4);
+			}
+		}
+
+		if (ivsize) {
+			for (i = 0; i < ivsize / 4; i++)
+				writel(cpu_to_be32(riv[i]),
+				       rkc->reg + RK2_CRYPTO_CH0_IV_0 + i * 4);
+			writel(ivsize, rkc->reg + RK2_CRYPTO_CH0_IV_LEN);
+		}
+		if (!sgs->length) {
+			sgs = sg_next(sgs);
+			sgd = sg_next(sgd);
+			continue;
+		}
+
+		/* The hw support multiple descriptor, so why this driver use
+		 * only one descriptor ?
+		 * Using one descriptor per SG seems the way to do and it works
+		 * but only when doing encryption.
+		 * With decryption it always fail on second descriptor.
+		 * Probably the HW dont know how to use IV.
+		 */
+		todo = min(sg_dma_len(sgs), len);
+		len -= todo;
+		dd->src_addr = sg_dma_address(sgs);
+		dd->src_len = todo;
+		dd->dst_addr = sg_dma_address(sgd);
+		dd->dst_len = todo;
+		dd->iv = 0;
+		dd->next = 1;
+
+		dd->user = RK2_LLI_CIPHER_START | RK2_LLI_STRING_FIRST | RK2_LLI_STRING_LAST;
+		dd->dma_ctrl |= RK2_LLI_DMA_CTRL_DST_INT | RK2_LLI_DMA_CTRL_LAST;
+
+		writel(RK2_CRYPTO_DMA_INT_LISTDONE | 0x7F, rkc->reg + RK2_CRYPTO_DMA_INT_EN);
+
+		/*writel(0x00030000, rkc->reg + RK2_CRYPTO_FIFO_CTL);*/
+		writel(rkc->t_phy, rkc->reg + RK2_CRYPTO_DMA_LLI_ADDR);
+
+		reinit_completion(&rkc->complete);
+		rkc->status = 0;
+
+		writel(RK2_CRYPTO_DMA_CTL_START | 1 << 16, rkc->reg + RK2_CRYPTO_DMA_CTL);
+
+		wait_for_completion_interruptible_timeout(&rkc->complete,
+							  msecs_to_jiffies(10000));
+		if (sgs == sgd) {
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
+		}
+
+		if (!rkc->status) {
+			dev_err(rkc->dev, "DMA timeout\n");
+			rk2_print(rkc);
+			err = -EFAULT;
+			goto theend;
+		}
+		if (areq->iv && ivsize > 0) {
+			offset = sgd->length - ivsize;
+			if (rctx->mode & RK2_CRYPTO_DEC) {
+				memcpy(areq->iv, rctx->backup_iv, ivsize);
+				memzero_explicit(rctx->backup_iv, ivsize);
+			} else {
+				scatterwalk_map_and_copy(areq->iv, sgd, offset,
+							 ivsize, 0);
+			}
+		}
+		sgs = sg_next(sgs);
+		sgd = sg_next(sgd);
+	}
+theend:
+	writel(0xffff0000, rkc->reg + RK2_CRYPTO_BC_CTL);
+	pm_runtime_put_autosuspend(rkc->dev);
+
+	local_bh_disable();
+	crypto_finalize_skcipher_request(engine, areq, err);
+	local_bh_enable();
+	return 0;
+}
+
+int rk2_cipher_tfm_init(struct crypto_skcipher *tfm)
+{
+	struct rk2_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	const char *name = crypto_tfm_alg_name(&tfm->base);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk2_crypto_template *algt = container_of(alg, struct rk2_crypto_template, alg.skcipher.base);
+
+	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		dev_err(algt->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+			name, PTR_ERR(ctx->fallback_tfm));
+		return PTR_ERR(ctx->fallback_tfm);
+	}
+
+	dev_info(algt->dev->dev, "Fallback for %s is %s\n",
+		 crypto_tfm_alg_driver_name(&tfm->base),
+		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(ctx->fallback_tfm)));
+
+	tfm->reqsize = sizeof(struct rk2_cipher_rctx) +
+		crypto_skcipher_reqsize(ctx->fallback_tfm);
+
+	return 0;
+}
+
+void rk2_cipher_tfm_exit(struct crypto_skcipher *tfm)
+{
+	struct rk2_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memzero_explicit(ctx->key, ctx->keylen);
+	crypto_free_skcipher(ctx->fallback_tfm);
+}
-- 
2.41.0


