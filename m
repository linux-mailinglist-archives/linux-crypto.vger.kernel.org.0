Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2032B77E
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0O2Q (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:28:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0O2Q (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:28:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D33BACE5;
        Mon, 27 May 2019 14:28:13 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org, terrelln@fb.com,
        jthumshirn@suse.de, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] crypto: xxhash - Implement xxhash support
Date:   Mon, 27 May 2019 17:28:10 +0300
Message-Id: <20190527142810.31472-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

xxhash is currently implemented as a self-contained module in /lib.
This patch enables that module to be used as part of the generic kernel
crypto framework. It adds a simple wrapper to the 64bit version. I've
also added a couple of simplistic test vectors to ensure I haven't
screwed up anything doing the plumbing.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 crypto/Kconfig          |   8 +++
 crypto/Makefile         |   1 +
 crypto/testmgr.c        |   7 +++
 crypto/testmgr.h        |  26 ++++++++++
 crypto/xxhash_generic.c | 112 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 crypto/xxhash_generic.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index bbab6bf33519..c56cc450ffc0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -665,6 +665,14 @@ config CRYPTO_CRC32_MIPS
 	  instructions, when available.
 
 
+config CRYPTO_XXHASH
+	tristate "xxHash hash algorithm"
+	select CRYPTO_HASH
+	select XXHASH
+	help
+	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
+	  speeds close to RAM limits.
+
 config CRYPTO_CRCT10DIF
 	tristate "CRCT10DIF algorithm"
 	select CRYPTO_HASH
diff --git a/crypto/Makefile b/crypto/Makefile
index fb5bf2a3a666..4dc6c45d026e 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -135,6 +135,7 @@ obj-$(CONFIG_CRYPTO_842) += 842.o
 obj-$(CONFIG_CRYPTO_RNG2) += rng.o
 obj-$(CONFIG_CRYPTO_ANSI_CPRNG) += ansi_cprng.o
 obj-$(CONFIG_CRYPTO_DRBG) += drbg.o
+obj-$(CONFIG_CRYPTO_XXHASH) += xxhash_generic.o
 obj-$(CONFIG_CRYPTO_JITTERENTROPY) += jitterentropy_rng.o
 CFLAGS_jitterentropy.o = -O0
 jitterentropy_rng-y := jitterentropy.o jitterentropy-kcapi.o
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 8386038d67c7..322e906b6b6a 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -3879,6 +3879,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "xts512(paes)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
+	}, {
+		.alg = "xxhash64",
+		.test = alg_test_hash,
+		.fips_allowed = 1,
+		.suite = {
+			.hash = __VECS(xxhash64_tv_template)
+		}
 	}, {
 		.alg = "zlib-deflate",
 		.test = alg_test_comp,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index d18a37629f05..8e0a9385ee5d 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -33218,6 +33218,32 @@ static const struct hash_testvec crc32c_tv_template[] = {
 	}
 };
 
+static const struct hash_testvec xxhash64_tv_template[] = {
+	{
+		.psize = 0,
+		.digest = "\x99\xe9\xd8\x51\x37\xdb\x46\xef",
+	},
+	{
+		.plaintext = "abcdefg",
+		.psize = 7,
+		.digest = "\x2d\x82\x02\x29\x0e\x94\x60\x18",
+	},
+	{
+		.plaintext = "0123456789abcdef0123456789abcdef0123456789"
+			     "abcdef0123456789abcdef",
+		.psize = 64,
+		.digest = "\x85\x2f\xfe\x60\x47\xac\xf3\x1a",
+	},
+	{
+		.key = "\xd2\x02\x96\x49\x00\x00\x00\x00",
+		.ksize = 8,
+		.plaintext = "0123456789abcdef0123456789abcdef0123456789"
+			     "abcdef0123456789abcdef",
+		.psize = 64,
+		.digest = "\xab\xea\xc2\x48\x1a\x80\x4e\x7b",
+	},
+};
+
 static const struct comp_testvec lz4_comp_tv_template[] = {
 	{
 		.inlen	= 255,
diff --git a/crypto/xxhash_generic.c b/crypto/xxhash_generic.c
new file mode 100644
index 000000000000..aedaabe55d45
--- /dev/null
+++ b/crypto/xxhash_generic.c
@@ -0,0 +1,112 @@
+#include <crypto/internal/hash.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/xxhash.h>
+
+#define XXHASH_BLOCK_SIZE	1
+#define XXHASH64_DIGEST_SIZE	8
+
+struct xxhash64_crypto_ctx {
+	u64 seed;
+};
+
+struct xxhash64_desc_ctx {
+	struct xxh64_state xxhstate;
+	u64 seed;
+};
+
+static int xxhash64_init(struct shash_desc *desc)
+{
+	struct xxhash64_crypto_ctx *cctx = crypto_shash_ctx(desc->tfm);
+	struct xxhash64_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	dctx->seed = cctx->seed;
+	xxh64_reset(&dctx->xxhstate, dctx->seed);
+
+	return 0;
+}
+
+static int xxhash64_setkey(struct crypto_shash *tfm, const u8 *key,
+			 unsigned int keylen)
+{
+	struct xxhash64_crypto_ctx *ctx = crypto_shash_ctx(tfm);
+
+	if (keylen != sizeof(ctx->seed)) {
+		crypto_shash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+	ctx->seed = *(u64 *)key;
+	return 0;
+}
+
+static int xxhash64_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int length)
+{
+	struct xxhash64_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	xxh64_update(&ctx->xxhstate, data, length);
+
+	return 0;
+}
+
+static int xxhash64_final(struct shash_desc *desc, u8 *out)
+{
+	struct xxhash64_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	*(u64 *)out = xxh64_digest(&ctx->xxhstate);
+
+	return 0;
+}
+
+static int xxhash64_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	xxhash64_update(desc, data, len);
+	xxhash64_final(desc, out);
+
+	return 0;
+}
+
+static int xxhash64_digest(struct shash_desc *desc, const u8 *data,
+			 unsigned int length, u8 *out)
+{
+	return xxhash64_finup(desc, data, length, out);
+}
+
+static struct shash_alg alg = {
+	.digestsize		=	XXHASH64_DIGEST_SIZE,
+	.setkey			= xxhash64_setkey,
+	.init		=	xxhash64_init,
+	.update		=	xxhash64_update,
+	.final		=	xxhash64_final,
+	.finup		=	xxhash64_finup,
+	.digest		=	xxhash64_digest,
+	.descsize		=	sizeof(struct xxhash64_desc_ctx),
+	.base			=	{
+		.cra_name		=	"xxhash64",
+		.cra_driver_name	=	"xxhash64-generic",
+		.cra_priority		=	100,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
+		.cra_blocksize		=	XXHASH_BLOCK_SIZE,
+		.cra_ctxsize		=	sizeof(struct xxhash64_crypto_ctx),
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static int __init xxhash_mod_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit xxhash_mod_fini(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_init(xxhash_mod_init);
+module_exit(xxhash_mod_fini);
+
+MODULE_AUTHOR("Nikolay Borisov <nborisov@suse.com>");
+MODULE_DESCRIPTION("xxhash  calculations wrapper for lib/xxhash.c");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("xxhash-generic");
-- 
2.17.1

