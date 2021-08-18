Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF13F0700
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Aug 2021 16:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhHROrR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Aug 2021 10:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239585AbhHROrM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Aug 2021 10:47:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F11610D2;
        Wed, 18 Aug 2021 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629297997;
        bh=Z2TZQDu8ZKb4Xhk6jaMF26MtyQjqKi2hR32T57p31sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsLJ/Q+XbTGBf+5z57Fc9s0BnpmkoHs4s6cdQ0wc3n840VEmvORVpaWJpdVrgtfFr
         4k45bTCfuhJWFP4e6WpFFSD0SeOiwCEI5MV+DkU/Rw5Bq4YYtiU0E00aTCn4v0YNNw
         Tcc4ZkVqXTeBJZ6k76DuGvg+v4or4HjBRw/6IXS5j7FtX/LemclNV4eu900Cw0m0jq
         zN4iK1r9+T2KP+x+RJEUl6HiIHF5u2RqNntoZ8Lj9uFUBFYhpIOTLEMvhLFv7Fw0hU
         16cOl+dIcH3Z14a9h/twYVv9ODV0fJGsZwnChkS5P4207Tt1HBgawkNM22r7nSt706
         oGe0K2u5swa5A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] crypto: md4 - Remove obsolete algorithm
Date:   Wed, 18 Aug 2021 16:46:17 +0200
Message-Id: <20210818144617.110061-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818144617.110061-1-ardb@kernel.org>
References: <20210818144617.110061-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

MD4 is terminally broken, and has been known to broken since 1991.  For
this reason, it was requalified as 'historic' by RFC 6150 back in 2011.

To celebrate the 10th birthday of this RFC, let's finally get rid of the
generic shash implementation of MD4.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/Kconfig   |   6 -
 crypto/Makefile  |   1 -
 crypto/md4.c     | 241 --------------------
 crypto/tcrypt.c  |  14 +-
 crypto/testmgr.c |   6 -
 crypto/testmgr.h |  42 ----
 6 files changed, 1 insertion(+), 309 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 64b772c5d1c9..5826f3e0b1eb 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -780,12 +780,6 @@ config CRYPTO_POLY1305_MIPS
 	depends on MIPS
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 
-config CRYPTO_MD4
-	tristate "MD4 digest algorithm"
-	select CRYPTO_HASH
-	help
-	  MD4 message digest algorithm (RFC1320).
-
 config CRYPTO_MD5
 	tristate "MD5 digest algorithm"
 	select CRYPTO_HASH
diff --git a/crypto/Makefile b/crypto/Makefile
index 10526d4559b8..51be241df46f 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
 obj-$(CONFIG_CRYPTO_XCBC) += xcbc.o
 obj-$(CONFIG_CRYPTO_NULL2) += crypto_null.o
-obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
 obj-$(CONFIG_CRYPTO_RMD160) += rmd160.o
 obj-$(CONFIG_CRYPTO_RMD320) += rmd320.o
diff --git a/crypto/md4.c b/crypto/md4.c
deleted file mode 100644
index 2e7f2f319f95..000000000000
--- a/crypto/md4.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/* 
- * Cryptographic API.
- *
- * MD4 Message Digest Algorithm (RFC1320).
- *
- * Implementation derived from Andrew Tridgell and Steve French's
- * CIFS MD4 implementation, and the cryptoapi implementation
- * originally based on the public domain implementation written
- * by Colin Plumb in 1993.
- *
- * Copyright (c) Andrew Tridgell 1997-1998.
- * Modified by Steve French (sfrench@us.ibm.com) 2002
- * Copyright (c) Cryptoapi developers.
- * Copyright (c) 2002 David S. Miller (davem@redhat.com)
- * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-#define MD4_DIGEST_SIZE		16
-#define MD4_HMAC_BLOCK_SIZE	64
-#define MD4_BLOCK_WORDS		16
-#define MD4_HASH_WORDS		4
-
-struct md4_ctx {
-	u32 hash[MD4_HASH_WORDS];
-	u32 block[MD4_BLOCK_WORDS];
-	u64 byte_count;
-};
-
-static inline u32 lshift(u32 x, unsigned int s)
-{
-	x &= 0xFFFFFFFF;
-	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
-}
-
-static inline u32 F(u32 x, u32 y, u32 z)
-{
-	return (x & y) | ((~x) & z);
-}
-
-static inline u32 G(u32 x, u32 y, u32 z)
-{
-	return (x & y) | (x & z) | (y & z);
-}
-
-static inline u32 H(u32 x, u32 y, u32 z)
-{
-	return x ^ y ^ z;
-}
-
-#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
-#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (u32)0x5A827999,s))
-#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (u32)0x6ED9EBA1,s))
-
-static void md4_transform(u32 *hash, u32 const *in)
-{
-	u32 a, b, c, d;
-
-	a = hash[0];
-	b = hash[1];
-	c = hash[2];
-	d = hash[3];
-
-	ROUND1(a, b, c, d, in[0], 3);
-	ROUND1(d, a, b, c, in[1], 7);
-	ROUND1(c, d, a, b, in[2], 11);
-	ROUND1(b, c, d, a, in[3], 19);
-	ROUND1(a, b, c, d, in[4], 3);
-	ROUND1(d, a, b, c, in[5], 7);
-	ROUND1(c, d, a, b, in[6], 11);
-	ROUND1(b, c, d, a, in[7], 19);
-	ROUND1(a, b, c, d, in[8], 3);
-	ROUND1(d, a, b, c, in[9], 7);
-	ROUND1(c, d, a, b, in[10], 11);
-	ROUND1(b, c, d, a, in[11], 19);
-	ROUND1(a, b, c, d, in[12], 3);
-	ROUND1(d, a, b, c, in[13], 7);
-	ROUND1(c, d, a, b, in[14], 11);
-	ROUND1(b, c, d, a, in[15], 19);
-
-	ROUND2(a, b, c, d,in[ 0], 3);
-	ROUND2(d, a, b, c, in[4], 5);
-	ROUND2(c, d, a, b, in[8], 9);
-	ROUND2(b, c, d, a, in[12], 13);
-	ROUND2(a, b, c, d, in[1], 3);
-	ROUND2(d, a, b, c, in[5], 5);
-	ROUND2(c, d, a, b, in[9], 9);
-	ROUND2(b, c, d, a, in[13], 13);
-	ROUND2(a, b, c, d, in[2], 3);
-	ROUND2(d, a, b, c, in[6], 5);
-	ROUND2(c, d, a, b, in[10], 9);
-	ROUND2(b, c, d, a, in[14], 13);
-	ROUND2(a, b, c, d, in[3], 3);
-	ROUND2(d, a, b, c, in[7], 5);
-	ROUND2(c, d, a, b, in[11], 9);
-	ROUND2(b, c, d, a, in[15], 13);
-
-	ROUND3(a, b, c, d,in[ 0], 3);
-	ROUND3(d, a, b, c, in[8], 9);
-	ROUND3(c, d, a, b, in[4], 11);
-	ROUND3(b, c, d, a, in[12], 15);
-	ROUND3(a, b, c, d, in[2], 3);
-	ROUND3(d, a, b, c, in[10], 9);
-	ROUND3(c, d, a, b, in[6], 11);
-	ROUND3(b, c, d, a, in[14], 15);
-	ROUND3(a, b, c, d, in[1], 3);
-	ROUND3(d, a, b, c, in[9], 9);
-	ROUND3(c, d, a, b, in[5], 11);
-	ROUND3(b, c, d, a, in[13], 15);
-	ROUND3(a, b, c, d, in[3], 3);
-	ROUND3(d, a, b, c, in[11], 9);
-	ROUND3(c, d, a, b, in[7], 11);
-	ROUND3(b, c, d, a, in[15], 15);
-
-	hash[0] += a;
-	hash[1] += b;
-	hash[2] += c;
-	hash[3] += d;
-}
-
-static inline void md4_transform_helper(struct md4_ctx *ctx)
-{
-	le32_to_cpu_array(ctx->block, ARRAY_SIZE(ctx->block));
-	md4_transform(ctx->hash, ctx->block);
-}
-
-static int md4_init(struct shash_desc *desc)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-
-	mctx->hash[0] = 0x67452301;
-	mctx->hash[1] = 0xefcdab89;
-	mctx->hash[2] = 0x98badcfe;
-	mctx->hash[3] = 0x10325476;
-	mctx->byte_count = 0;
-
-	return 0;
-}
-
-static int md4_update(struct shash_desc *desc, const u8 *data, unsigned int len)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-	const u32 avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
-
-	mctx->byte_count += len;
-
-	if (avail > len) {
-		memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-		       data, len);
-		return 0;
-	}
-
-	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-	       data, avail);
-
-	md4_transform_helper(mctx);
-	data += avail;
-	len -= avail;
-
-	while (len >= sizeof(mctx->block)) {
-		memcpy(mctx->block, data, sizeof(mctx->block));
-		md4_transform_helper(mctx);
-		data += sizeof(mctx->block);
-		len -= sizeof(mctx->block);
-	}
-
-	memcpy(mctx->block, data, len);
-
-	return 0;
-}
-
-static int md4_final(struct shash_desc *desc, u8 *out)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-	const unsigned int offset = mctx->byte_count & 0x3f;
-	char *p = (char *)mctx->block + offset;
-	int padding = 56 - (offset + 1);
-
-	*p++ = 0x80;
-	if (padding < 0) {
-		memset(p, 0x00, padding + sizeof (u64));
-		md4_transform_helper(mctx);
-		p = (char *)mctx->block;
-		padding = 56;
-	}
-
-	memset(p, 0, padding);
-	mctx->block[14] = mctx->byte_count << 3;
-	mctx->block[15] = mctx->byte_count >> 29;
-	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
-	                  sizeof(u64)) / sizeof(u32));
-	md4_transform(mctx->hash, mctx->block);
-	cpu_to_le32_array(mctx->hash, ARRAY_SIZE(mctx->hash));
-	memcpy(out, mctx->hash, sizeof(mctx->hash));
-	memset(mctx, 0, sizeof(*mctx));
-
-	return 0;
-}
-
-static struct shash_alg alg = {
-	.digestsize	=	MD4_DIGEST_SIZE,
-	.init		=	md4_init,
-	.update		=	md4_update,
-	.final		=	md4_final,
-	.descsize	=	sizeof(struct md4_ctx),
-	.base		=	{
-		.cra_name	 =	"md4",
-		.cra_driver_name =	"md4-generic",
-		.cra_blocksize	 =	MD4_HMAC_BLOCK_SIZE,
-		.cra_module	 =	THIS_MODULE,
-	}
-};
-
-static int __init md4_mod_init(void)
-{
-	return crypto_register_shash(&alg);
-}
-
-static void __exit md4_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-subsys_initcall(md4_mod_init);
-module_exit(md4_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MD4 Message Digest Algorithm");
-MODULE_ALIAS_CRYPTO("md4");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index f8d06da78e4f..dcb42a9e8cc6 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -68,7 +68,7 @@ static char *tvmem[TVMEMSIZE];
 
 static const char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha224", "sha256", "sm3",
-	"blowfish", "twofish", "serpent", "sha384", "sha512", "md4", "aes",
+	"blowfish", "twofish", "serpent", "sha384", "sha512", "aes",
 	"cast6", "arc4", "michael_mic", "deflate", "crc32c", "tea", "xtea",
 	"khazad", "wp512", "wp384", "wp256", "xeta",  "fcrypt",
 	"camellia", "seed", "rmd160",
@@ -1703,10 +1703,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("ctr(des3_ede)");
 		break;
 
-	case 5:
-		ret += tcrypt_test("md4");
-		break;
-
 	case 6:
 		ret += tcrypt_test("sha256");
 		break;
@@ -2328,10 +2324,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 			break;
 		}
 		fallthrough;
-	case 301:
-		test_hash_speed("md4", sec, generic_hash_speed_template);
-		if (mode > 300 && mode < 400) break;
-		fallthrough;
 	case 302:
 		test_hash_speed("md5", sec, generic_hash_speed_template);
 		if (mode > 300 && mode < 400) break;
@@ -2440,10 +2432,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 			break;
 		}
 		fallthrough;
-	case 401:
-		test_ahash_speed("md4", sec, generic_hash_speed_template);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
 	case 402:
 		test_ahash_speed("md5", sec, generic_hash_speed_template);
 		if (mode > 400 && mode < 500) break;
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c978e41f11a1..3e9378130150 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5153,12 +5153,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(lzorle_decomp_tv_template)
 			}
 		}
-	}, {
-		.alg = "md4",
-		.test = alg_test_hash,
-		.suite = {
-			.hash = __VECS(md4_tv_template)
-		}
 	}, {
 		.alg = "md5",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 3ed6ab34ab51..04e58adee80d 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -2872,48 +2872,6 @@ static const struct kpp_testvec ecdh_p384_tv_template[] = {
 	}
 };
 
-/*
- * MD4 test vectors from RFC1320
- */
-static const struct hash_testvec md4_tv_template[] = {
-	{
-		.plaintext = "",
-		.digest	= "\x31\xd6\xcf\xe0\xd1\x6a\xe9\x31"
-			  "\xb7\x3c\x59\xd7\xe0\xc0\x89\xc0",
-	}, {
-		.plaintext = "a",
-		.psize	= 1,
-		.digest	= "\xbd\xe5\x2c\xb3\x1d\xe3\x3e\x46"
-			  "\x24\x5e\x05\xfb\xdb\xd6\xfb\x24",
-	}, {
-		.plaintext = "abc",
-		.psize	= 3,
-		.digest	= "\xa4\x48\x01\x7a\xaf\x21\xd8\x52"
-			  "\x5f\xc1\x0a\xe8\x7a\xa6\x72\x9d",
-	}, {
-		.plaintext = "message digest",
-		.psize	= 14,
-		.digest	= "\xd9\x13\x0a\x81\x64\x54\x9f\xe8"
-			"\x18\x87\x48\x06\xe1\xc7\x01\x4b",
-	}, {
-		.plaintext = "abcdefghijklmnopqrstuvwxyz",
-		.psize	= 26,
-		.digest	= "\xd7\x9e\x1c\x30\x8a\xa5\xbb\xcd"
-			  "\xee\xa8\xed\x63\xdf\x41\x2d\xa9",
-	}, {
-		.plaintext = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
-		.psize	= 62,
-		.digest	= "\x04\x3f\x85\x82\xf2\x41\xdb\x35"
-			  "\x1c\xe6\x27\xe1\x53\xe7\xf0\xe4",
-	}, {
-		.plaintext = "123456789012345678901234567890123456789012345678901234567890123"
-			   "45678901234567890",
-		.psize	= 80,
-		.digest	= "\xe3\x3b\x4d\xdc\x9c\x38\xf2\x19"
-			  "\x9c\x3e\x7b\x16\x4f\xcc\x05\x36",
-	},
-};
-
 static const struct hash_testvec sha3_224_tv_template[] = {
 	{
 		.plaintext = "",
-- 
2.20.1

