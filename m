Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC37F25D775
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgIDLd4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgIDLX7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 07:23:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF702C061231
        for <linux-crypto@vger.kernel.org>; Fri,  4 Sep 2020 04:10:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so5714392wmk.1
        for <linux-crypto@vger.kernel.org>; Fri, 04 Sep 2020 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UnvbnuxprCkyOp0FkMroB9jOrGc7kTm+kwtxJ1aLgkk=;
        b=orDH6CqEwfOskKmfMb+ni4a345rFV+96EGl7hRW+qztpv71v8QbNbmJVlglCCc401q
         Y+dgMFp6RlUjNhMsSJ4TBZnb4vQ5jlFN8J28VmZY0di7r9gtfnJwPYYFQZImkTyk+j9b
         F8HC4SCE4kFFNUvGKBTpdAR/TqinpYRbjDKbWgXx/0prBUTsB+YNE7fBXyO5F8Fv58TN
         a9pv4J5g2tegcdCKG+RUuY3r/9ldaGa9+SEhILI42JYiH7cpMHBvUWeAorMGDeowaICL
         znA5zS04U+2qcHwN6ZyrMTgmyAnYg7C8kBE9W+lZbPUAtolSLk8gDElDQ8pUrnlnAfBZ
         BOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UnvbnuxprCkyOp0FkMroB9jOrGc7kTm+kwtxJ1aLgkk=;
        b=SiyEXmUNbai7OyfUQOgbp6R1ntqTxQcVIPMDl+43Hxzh8E43POFNo1DPY3j/Fx7v++
         CLETjZabRja9D+OnM73TyhZ9vLx7L8KOyUWZCshd0IZHHLbxlZIDOj6VlM/PTdCMrUpf
         4bLrz6AgkAZK66xjzJ2+Y6XDp1RuW2FUdBPLkMuxd+I+ohjpqKPFRAX0KgwuozDUkiOB
         pmjmHeAs0mo133EsWFymPDtS7kuX5K04n3PBccoYt4te7qxWzab2MYz6KlTiUywdZOl1
         oQ4+E+elemeJLqzUYdEnnVY6j+zrA/Qluhr/IOi+tzf3lCe8phJ5ecQ/w2aH5jvHupvF
         pHbA==
X-Gm-Message-State: AOAM530eiUz7ZHm1KTV83k6oEMQ+wUh+Z8oSu8ql9757KjDGXyQysvx6
        N9sJlBzNi81gD898DbVX2isiCqARfHAUGA==
X-Google-Smtp-Source: ABdhPJxrtQ6Rwg/KKIl3xZV7ys8AJQU/FCE32cX1YdsIMinPXaWQc4LMSMk0Vkp5gFGXWGwVG373lw==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr1435881wml.6.1599217824290;
        Fri, 04 Sep 2020 04:10:24 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:23 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 12/18] crypto: sun8i-ce: support hash algorithms
Date:   Fri,  4 Sep 2020 11:09:57 +0000
Message-Id: <1599217803-29755-13-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The CE support multiples hash algorithms, this patch adds support for
MD5, SHA1, SHA224, SHA256, SHA384 and SHA512.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/Kconfig              |  10 +
 drivers/crypto/allwinner/sun8i-ce/Makefile    |   1 +
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 229 ++++++++++
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 413 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  58 +++
 5 files changed, 711 insertions(+)
 create mode 100644 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c

diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index b346850a91b9..fa34df7fbf78 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -78,6 +78,16 @@ config CRYPTO_DEV_SUN8I_CE_DEBUG
 	  This will create /sys/kernel/debug/sun8i-ce/stats for displaying
 	  the number of requests per flow and per algorithm.
 
+config CRYPTO_DEV_SUN8I_CE_HASH
+	bool "Enable support for hash on sun8i-ce"
+	depends on CRYPTO_DEV_SUN8I_CE
+	select MD5
+	select SHA1
+	select SHA256
+	select SHA512
+	help
+	  Say y to enable support for hash algorithms.
+
 config CRYPTO_DEV_SUN8I_SS
 	tristate "Support for Allwinner Security System cryptographic offloader"
 	select CRYPTO_SKCIPHER
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 08b68c3c1ca9..d1b1f0e86c79 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_CRYPTO_DEV_SUN8I_CE) += sun8i-ce.o
 sun8i-ce-y += sun8i-ce-core.o sun8i-ce-cipher.o
+sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_HASH) += sun8i-ce-hash.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 688976011f07..3ef5b1079be3 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -35,6 +35,9 @@
 static const struct ce_variant ce_h3_variant = {
 	.alg_cipher = { CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
 	},
+	.alg_hash = { CE_ALG_MD5, CE_ALG_SHA1, CE_ALG_SHA224, CE_ALG_SHA256,
+		CE_ALG_SHA384, CE_ALG_SHA512
+	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
 	.ce_clks = {
@@ -47,6 +50,9 @@ static const struct ce_variant ce_h3_variant = {
 static const struct ce_variant ce_h5_variant = {
 	.alg_cipher = { CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
 	},
+	.alg_hash = { CE_ALG_MD5, CE_ALG_SHA1, CE_ALG_SHA224, CE_ALG_SHA256,
+		CE_ID_NOTSUPP, CE_ID_NOTSUPP
+	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
 	.ce_clks = {
@@ -59,9 +65,13 @@ static const struct ce_variant ce_h5_variant = {
 static const struct ce_variant ce_h6_variant = {
 	.alg_cipher = { CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
 	},
+	.alg_hash = { CE_ALG_MD5, CE_ALG_SHA1, CE_ALG_SHA224, CE_ALG_SHA256,
+		CE_ALG_SHA384, CE_ALG_SHA512
+	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
 	.cipher_t_dlen_in_bytes = true,
+	.hash_t_dlen_in_bits = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
@@ -73,6 +83,9 @@ static const struct ce_variant ce_h6_variant = {
 static const struct ce_variant ce_a64_variant = {
 	.alg_cipher = { CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
 	},
+	.alg_hash = { CE_ALG_MD5, CE_ALG_SHA1, CE_ALG_SHA224, CE_ALG_SHA256,
+		CE_ID_NOTSUPP, CE_ID_NOTSUPP
+	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
 	.ce_clks = {
@@ -85,6 +98,9 @@ static const struct ce_variant ce_a64_variant = {
 static const struct ce_variant ce_r40_variant = {
 	.alg_cipher = { CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
 	},
+	.alg_hash = { CE_ALG_MD5, CE_ALG_SHA1, CE_ALG_SHA224, CE_ALG_SHA256,
+		CE_ID_NOTSUPP, CE_ID_NOTSUPP
+	},
 	.op_mode = { CE_OP_ECB, CE_OP_CBC
 	},
 	.ce_clks = {
@@ -329,6 +345,188 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 		.decrypt	= sun8i_ce_skdecrypt,
 	}
 },
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_HASH
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_MD5,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = MD5_DIGEST_SIZE,
+			.statesize = sizeof(struct md5_state),
+			.base = {
+				.cra_name = "md5",
+				.cra_driver_name = "md5-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_SHA1,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = SHA1_DIGEST_SIZE,
+			.statesize = sizeof(struct sha1_state),
+			.base = {
+				.cra_name = "sha1",
+				.cra_driver_name = "sha1-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA1_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_SHA224,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = SHA224_DIGEST_SIZE,
+			.statesize = sizeof(struct sha256_state),
+			.base = {
+				.cra_name = "sha224",
+				.cra_driver_name = "sha224-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA224_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_SHA256,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = SHA256_DIGEST_SIZE,
+			.statesize = sizeof(struct sha256_state),
+			.base = {
+				.cra_name = "sha256",
+				.cra_driver_name = "sha256-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA256_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_SHA384,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = SHA384_DIGEST_SIZE,
+			.statesize = sizeof(struct sha512_state),
+			.base = {
+				.cra_name = "sha384",
+				.cra_driver_name = "sha384-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA384_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ce_algo_id = CE_ID_HASH_SHA512,
+	.alg.hash = {
+		.init = sun8i_ce_hash_init,
+		.update = sun8i_ce_hash_update,
+		.final = sun8i_ce_hash_final,
+		.finup = sun8i_ce_hash_finup,
+		.digest = sun8i_ce_hash_digest,
+		.export = sun8i_ce_hash_export,
+		.import = sun8i_ce_hash_import,
+		.halg = {
+			.digestsize = SHA512_DIGEST_SIZE,
+			.statesize = sizeof(struct sha512_state),
+			.base = {
+				.cra_name = "sha512",
+				.cra_driver_name = "sha512-sun8i-ce",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA512_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ce_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ce_hash_crainit,
+				.cra_exit = sun8i_ce_hash_craexit,
+			}
+		}
+	}
+},
+#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
@@ -350,6 +548,12 @@ static int sun8i_ce_dbgfs_read(struct seq_file *seq, void *v)
 				   ce_algs[i].alg.skcipher.base.cra_name,
 				   ce_algs[i].stat_req, ce_algs[i].stat_fb);
 			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			seq_printf(seq, "%s %s %lu %lu\n",
+				   ce_algs[i].alg.hash.halg.base.cra_driver_name,
+				   ce_algs[i].alg.hash.halg.base.cra_name,
+				   ce_algs[i].stat_req, ce_algs[i].stat_fb);
+			break;
 		}
 	}
 	return 0;
@@ -564,6 +768,26 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 				return err;
 			}
 			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			id = ce_algs[i].ce_algo_id;
+			ce_method = ce->variant->alg_hash[id];
+			if (ce_method == CE_ID_NOTSUPP) {
+				dev_info(ce->dev,
+					 "DEBUG: Algo of %s not supported\n",
+					 ce_algs[i].alg.hash.halg.base.cra_name);
+				ce_algs[i].ce = NULL;
+				break;
+			}
+			dev_info(ce->dev, "Register %s\n",
+				 ce_algs[i].alg.hash.halg.base.cra_name);
+			err = crypto_register_ahash(&ce_algs[i].alg.hash);
+			if (err) {
+				dev_err(ce->dev, "ERROR: Fail to register %s\n",
+					ce_algs[i].alg.hash.halg.base.cra_name);
+				ce_algs[i].ce = NULL;
+				return err;
+			}
+			break;
 		default:
 			ce_algs[i].ce = NULL;
 			dev_err(ce->dev, "ERROR: tried to register an unknown algo\n");
@@ -585,6 +809,11 @@ static void sun8i_ce_unregister_algs(struct sun8i_ce_dev *ce)
 				 ce_algs[i].alg.skcipher.base.cra_name);
 			crypto_unregister_skcipher(&ce_algs[i].alg.skcipher);
 			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			dev_info(ce->dev, "Unregister %d %s\n", i,
+				 ce_algs[i].alg.hash.halg.base.cra_name);
+			crypto_unregister_ahash(&ce_algs[i].alg.hash);
+			break;
 		}
 	}
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
new file mode 100644
index 000000000000..54ae98a0ed13
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sun8i-ce-hash.c - hardware cryptographic offloader for
+ * Allwinner H3/A64/H5/H2+/H6/R40 SoC
+ *
+ * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
+ *
+ * This file add support for MD5 and SHA1/SHA224/SHA256/SHA384/SHA512.
+ *
+ * You could find the datasheet in Documentation/arm/sunxi/README
+ */
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha.h>
+#include <crypto/md5.h>
+#include "sun8i-ce.h"
+
+int sun8i_ce_hash_crainit(struct crypto_tfm *tfm)
+{
+	struct sun8i_ce_hash_tfm_ctx *op = crypto_tfm_ctx(tfm);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
+	struct sun8i_ce_alg_template *algt;
+	int err;
+
+	memset(op, 0, sizeof(struct sun8i_ce_hash_tfm_ctx));
+
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	op->ce = algt->ce;
+
+	op->enginectx.op.do_one_request = sun8i_ce_hash_run;
+	op->enginectx.op.prepare_request = NULL;
+	op->enginectx.op.unprepare_request = NULL;
+
+	/* FALLBACK */
+	op->fallback_tfm = crypto_alloc_ahash(crypto_tfm_alg_name(tfm), 0,
+					      CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(op->fallback_tfm)) {
+		dev_err(algt->ce->dev, "Fallback driver could no be loaded\n");
+		return PTR_ERR(op->fallback_tfm);
+	}
+
+	if (algt->alg.hash.halg.statesize < crypto_ahash_statesize(op->fallback_tfm))
+		algt->alg.hash.halg.statesize = crypto_ahash_statesize(op->fallback_tfm);
+
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct sun8i_ce_hash_reqctx) +
+				 crypto_ahash_reqsize(op->fallback_tfm));
+
+	dev_info(op->ce->dev, "Fallback for %s is %s\n",
+		 crypto_tfm_alg_driver_name(tfm),
+		 crypto_tfm_alg_driver_name(&op->fallback_tfm->base));
+	err = pm_runtime_get_sync(op->ce->dev);
+	if (err < 0)
+		goto error_pm;
+	return 0;
+error_pm:
+	pm_runtime_put_noidle(op->ce->dev);
+	crypto_free_ahash(op->fallback_tfm);
+	return err;
+}
+
+void sun8i_ce_hash_craexit(struct crypto_tfm *tfm)
+{
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(tfmctx->fallback_tfm);
+	pm_runtime_put_sync_suspend(tfmctx->ce->dev);
+}
+
+int sun8i_ce_hash_init(struct ahash_request *areq)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	memset(rctx, 0, sizeof(struct sun8i_ce_hash_reqctx));
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_init(&rctx->fallback_req);
+}
+
+int sun8i_ce_hash_export(struct ahash_request *areq, void *out)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_export(&rctx->fallback_req, out);
+}
+
+int sun8i_ce_hash_import(struct ahash_request *areq, const void *in)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_ahash_import(&rctx->fallback_req, in);
+}
+
+int sun8i_ce_hash_final(struct ahash_request *areq)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ce_alg_template *algt;
+#endif
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.result = areq->result;
+
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	algt->stat_fb++;
+#endif
+
+	return crypto_ahash_final(&rctx->fallback_req);
+}
+
+int sun8i_ce_hash_update(struct ahash_request *areq)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+
+	return crypto_ahash_update(&rctx->fallback_req);
+}
+
+int sun8i_ce_hash_finup(struct ahash_request *areq)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ce_alg_template *algt;
+#endif
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	algt->stat_fb++;
+#endif
+
+	return crypto_ahash_finup(&rctx->fallback_req);
+}
+
+static int sun8i_ce_hash_digest_fb(struct ahash_request *areq)
+{
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ce_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ce_alg_template *algt;
+#endif
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	algt->stat_fb++;
+#endif
+
+	return crypto_ahash_digest(&rctx->fallback_req);
+}
+
+static bool sun8i_ce_hash_need_fallback(struct ahash_request *areq)
+{
+	struct scatterlist *sg;
+
+	if (areq->nbytes == 0)
+		return true;
+	/* we need to reserve one SG for padding one */
+	if (sg_nents(areq->src) > MAX_SG - 1)
+		return true;
+	sg = areq->src;
+	while (sg) {
+		if (sg->length % 4 || !IS_ALIGNED(sg->offset, sizeof(u32)))
+			return true;
+		sg = sg_next(sg);
+	}
+	return false;
+}
+
+int sun8i_ce_hash_digest(struct ahash_request *areq)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct sun8i_ce_alg_template *algt;
+	struct sun8i_ce_dev *ce;
+	struct crypto_engine *engine;
+	struct scatterlist *sg;
+	int nr_sgs, e, i;
+
+	if (sun8i_ce_hash_need_fallback(areq))
+		return sun8i_ce_hash_digest_fb(areq);
+
+	nr_sgs = sg_nents(areq->src);
+	if (nr_sgs > MAX_SG - 1)
+		return sun8i_ce_hash_digest_fb(areq);
+
+	for_each_sg(areq->src, sg, nr_sgs, i) {
+		if (sg->length % 4 || !IS_ALIGNED(sg->offset, sizeof(u32)))
+			return sun8i_ce_hash_digest_fb(areq);
+	}
+
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	ce = algt->ce;
+
+	e = sun8i_ce_get_engine_number(ce);
+	rctx->flow = e;
+	engine = ce->chanlist[e].engine;
+
+	return crypto_transfer_hash_request_to_engine(engine, areq);
+}
+
+int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
+{
+	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ce_hash_reqctx *rctx = ahash_request_ctx(areq);
+	struct sun8i_ce_alg_template *algt;
+	struct sun8i_ce_dev *ce;
+	struct sun8i_ce_flow *chan;
+	struct ce_task *cet;
+	struct scatterlist *sg;
+	int nr_sgs, flow, err;
+	unsigned int len;
+	u32 common;
+	u64 byte_count;
+	__le32 *bf;
+	void *buf;
+	int j, i, todo;
+	int nbw = 0;
+	u64 fill, min_fill;
+	__be64 *bebits;
+	__le64 *lebits;
+	void *result;
+	u64 bs;
+	int digestsize;
+	dma_addr_t addr_res, addr_pad;
+
+	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
+	ce = algt->ce;
+
+	bs = algt->alg.hash.halg.base.cra_blocksize;
+	digestsize = algt->alg.hash.halg.digestsize;
+	if (digestsize == SHA224_DIGEST_SIZE)
+		digestsize = SHA256_DIGEST_SIZE;
+	if (digestsize == SHA384_DIGEST_SIZE)
+		digestsize = SHA512_DIGEST_SIZE;
+
+	/* the padding could be up to two block. */
+	buf = kzalloc(bs * 2, GFP_KERNEL | GFP_DMA);
+	if (!buf)
+		return -ENOMEM;
+	bf = (__le32 *)buf;
+
+	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
+	if (!result)
+		return -ENOMEM;
+
+	flow = rctx->flow;
+	chan = &ce->chanlist[flow];
+
+#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
+	algt->stat_req++;
+#endif
+	dev_dbg(ce->dev, "%s %s len=%d\n", __func__, crypto_tfm_alg_name(areq->base.tfm), areq->nbytes);
+
+	cet = chan->tl;
+	memset(cet, 0, sizeof(struct ce_task));
+
+	cet->t_id = cpu_to_le32(flow);
+	common = ce->variant->alg_hash[algt->ce_algo_id];
+	common |= CE_COMM_INT;
+	cet->t_common_ctl = cpu_to_le32(common);
+
+	cet->t_sym_ctl = 0;
+	cet->t_asym_ctl = 0;
+
+	nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
+		err = -EINVAL;
+		goto theend;
+	}
+
+	len = areq->nbytes;
+	for_each_sg(areq->src, sg, nr_sgs, i) {
+		cet->t_src[i].addr = cpu_to_le32(sg_dma_address(sg));
+		todo = min(len, sg_dma_len(sg));
+		cet->t_src[i].len = cpu_to_le32(todo / 4);
+		len -= todo;
+	}
+	if (len > 0) {
+		dev_err(ce->dev, "remaining len %d\n", len);
+		err = -EINVAL;
+		goto theend;
+	}
+	addr_res = dma_map_single(ce->dev, result, digestsize, DMA_FROM_DEVICE);
+	cet->t_dst[0].addr = cpu_to_le32(addr_res);
+	cet->t_dst[0].len = cpu_to_le32(digestsize / 4);
+	if (dma_mapping_error(ce->dev, addr_res)) {
+		dev_err(ce->dev, "DMA map dest\n");
+		err = -EINVAL;
+		goto theend;
+	}
+
+	byte_count = areq->nbytes;
+	j = 0;
+	bf[j++] = cpu_to_le32(0x80);
+
+	if (bs == 64) {
+		fill = 64 - (byte_count % 64);
+		min_fill = 2 * sizeof(u32) + (nbw ? 0 : sizeof(u32));
+	} else {
+		fill = 128 - (byte_count % 128);
+		min_fill = 4 * sizeof(u32) + (nbw ? 0 : sizeof(u32));
+	}
+
+	if (fill < min_fill)
+		fill += bs;
+
+	j += (fill - min_fill) / sizeof(u32);
+
+	switch (algt->ce_algo_id) {
+	case CE_ID_HASH_MD5:
+		lebits = (__le64 *)&bf[j];
+		*lebits = cpu_to_le64(byte_count << 3);
+		j += 2;
+		break;
+	case CE_ID_HASH_SHA1:
+	case CE_ID_HASH_SHA224:
+	case CE_ID_HASH_SHA256:
+		bebits = (__be64 *)&bf[j];
+		*bebits = cpu_to_be64(byte_count << 3);
+		j += 2;
+		break;
+	case CE_ID_HASH_SHA384:
+	case CE_ID_HASH_SHA512:
+		bebits = (__be64 *)&bf[j];
+		*bebits = cpu_to_be64(byte_count >> 61);
+		j += 2;
+		bebits = (__be64 *)&bf[j];
+		*bebits = cpu_to_be64(byte_count << 3);
+		j += 2;
+		break;
+	}
+
+	addr_pad = dma_map_single(ce->dev, buf, j * 4, DMA_TO_DEVICE);
+	cet->t_src[i].addr = cpu_to_le32(addr_pad);
+	cet->t_src[i].len = cpu_to_le32(j);
+	if (dma_mapping_error(ce->dev, addr_pad)) {
+		dev_err(ce->dev, "DMA error on padding SG\n");
+		err = -EINVAL;
+		goto theend;
+	}
+
+	if (ce->variant->hash_t_dlen_in_bits)
+		cet->t_dlen = cpu_to_le32((areq->nbytes + j * 4) * 8);
+	else
+		cet->t_dlen = cpu_to_le32(areq->nbytes / 4 + j);
+
+	chan->timeout = areq->nbytes;
+
+	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(areq->base.tfm));
+
+	dma_unmap_single(ce->dev, addr_pad, j * 4, DMA_TO_DEVICE);
+	dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
+	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
+
+	kfree(buf);
+
+	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
+	kfree(result);
+theend:
+	crypto_finalize_hash_request(engine, breq, err);
+	return 0;
+}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 3dbf8ca47b7c..6bbafdf9d40c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -12,6 +12,9 @@
 #include <linux/atomic.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <crypto/md5.h>
+#include <crypto/sha.h>
 
 /* CE Registers */
 #define CE_TDQ	0x00
@@ -45,6 +48,12 @@
 #define CE_ALG_AES		0
 #define CE_ALG_DES		1
 #define CE_ALG_3DES		2
+#define CE_ALG_MD5              16
+#define CE_ALG_SHA1             17
+#define CE_ALG_SHA224           18
+#define CE_ALG_SHA256           19
+#define CE_ALG_SHA384           20
+#define CE_ALG_SHA512           21
 
 /* Used in ce_variant */
 #define CE_ID_NOTSUPP		0xFF
@@ -54,6 +63,14 @@
 #define CE_ID_CIPHER_DES3	2
 #define CE_ID_CIPHER_MAX	3
 
+#define CE_ID_HASH_MD5		0
+#define CE_ID_HASH_SHA1		1
+#define CE_ID_HASH_SHA224	2
+#define CE_ID_HASH_SHA256	3
+#define CE_ID_HASH_SHA384	4
+#define CE_ID_HASH_SHA512	5
+#define CE_ID_HASH_MAX		6
+
 #define CE_ID_OP_ECB	0
 #define CE_ID_OP_CBC	1
 #define CE_ID_OP_MAX	2
@@ -96,16 +113,22 @@ struct ce_clock {
  * struct ce_variant - Describe CE capability for each variant hardware
  * @alg_cipher:	list of supported ciphers. for each CE_ID_ this will give the
  *              coresponding CE_ALG_XXX value
+ * @alg_hash:	list of supported hashes. for each CE_ID_ this will give the
+ *              corresponding CE_ALG_XXX value
  * @op_mode:	list of supported block modes
  * @cipher_t_dlen_in_bytes:	Does the request size for cipher is in
  *				bytes or words
+ * @hash_t_dlen_in_bytes:	Does the request size for hash is in
+ *				bits or words
  * @ce_clks:	list of clocks needed by this variant
  * @esr:	The type of error register
  */
 struct ce_variant {
 	char alg_cipher[CE_ID_CIPHER_MAX];
+	char alg_hash[CE_ID_HASH_MAX];
 	u32 op_mode[CE_ID_OP_MAX];
 	bool cipher_t_dlen_in_bytes;
+	bool hash_t_dlen_in_bits;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
 };
@@ -221,6 +244,28 @@ struct sun8i_cipher_tfm_ctx {
 	struct crypto_skcipher *fallback_tfm;
 };
 
+/*
+ * struct sun8i_ce_hash_tfm_ctx - context for an ahash TFM
+ * @enginectx:		crypto_engine used by this TFM
+ * @ce:			pointer to the private data of driver handling this TFM
+ * @fallback_tfm:	pointer to the fallback TFM
+ */
+struct sun8i_ce_hash_tfm_ctx {
+	struct crypto_engine_ctx enginectx;
+	struct sun8i_ce_dev *ce;
+	struct crypto_ahash *fallback_tfm;
+};
+
+/*
+ * struct sun8i_ce_hash_reqctx - context for an ahash request
+ * @fallback_req:	pre-allocated fallback request
+ * @flow:	the flow to use for this request
+ */
+struct sun8i_ce_hash_reqctx {
+	struct ahash_request fallback_req;
+	int flow;
+};
+
 /*
  * struct sun8i_ce_alg_template - crypto_alg template
  * @type:		the CRYPTO_ALG_TYPE for this template
@@ -239,6 +284,7 @@ struct sun8i_ce_alg_template {
 	struct sun8i_ce_dev *ce;
 	union {
 		struct skcipher_alg skcipher;
+		struct ahash_alg hash;
 	} alg;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
@@ -260,3 +306,15 @@ int sun8i_ce_skencrypt(struct skcipher_request *areq);
 int sun8i_ce_get_engine_number(struct sun8i_ce_dev *ce);
 
 int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name);
+
+int sun8i_ce_hash_crainit(struct crypto_tfm *tfm);
+void sun8i_ce_hash_craexit(struct crypto_tfm *tfm);
+int sun8i_ce_hash_init(struct ahash_request *areq);
+int sun8i_ce_hash_export(struct ahash_request *areq, void *out);
+int sun8i_ce_hash_import(struct ahash_request *areq, const void *in);
+int sun8i_ce_hash(struct ahash_request *areq);
+int sun8i_ce_hash_final(struct ahash_request *areq);
+int sun8i_ce_hash_update(struct ahash_request *areq);
+int sun8i_ce_hash_finup(struct ahash_request *areq);
+int sun8i_ce_hash_digest(struct ahash_request *areq);
+int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq);
-- 
2.26.2

