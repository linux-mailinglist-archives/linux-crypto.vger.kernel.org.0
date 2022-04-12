Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335334FE6D7
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Apr 2022 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350278AbiDLRa4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 12 Apr 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352983AbiDLRaw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 12 Apr 2022 13:30:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F065418C
        for <linux-crypto@vger.kernel.org>; Tue, 12 Apr 2022 10:28:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a5b0009000000b006413e60e389so5943590ybp.10
        for <linux-crypto@vger.kernel.org>; Tue, 12 Apr 2022 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NikBb4B8iMT0e4N0K3cscgiuGv/cpZWqZWLvlAvniDg=;
        b=mN5Iqphi/zUfeCFqABrm95mnOsr/++7dxT3gqGYta6yKVADzWSoLLBJnBd6wXmCYnh
         y63+2czbXLWF2RCqwT1H6GpkG3vM/jbe/OM9Yqd4S9MsvA8wGv6ejc0Cw4OY/U9fSnGx
         71uzbKr+MzoQT8JFS6AT2BwjmvGGqAJHaEE0C/J/7WBEWLsJXH1D1/RaqOmqvQ5xLdql
         3BomVrDyW5N0zWVSHLBCIWsyJScyHL7nFWgQ2QmOGmBzml3YsqbXUei80T3Ro2p+lVgd
         YQGI0rm5D2ft7npxA0hhuLbMhRt4jLVpE/7OygOv76iLtKKeYa3EVTfnUuUgpIdMXrcx
         /bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NikBb4B8iMT0e4N0K3cscgiuGv/cpZWqZWLvlAvniDg=;
        b=yPPImxGCMILr9sVBRluIhmdMR2hEuKkHCh908h7Fy20vuMGTvmzcVEF25jCrhpFlUa
         c0wcyVNrxXK5IYu+ASRyPVMfNvGWzK+WQ3OvwuWN6Fj17Oxvdw4w7obxPKOQixfLJP9E
         7io8MCuh3zAZZTpi08eumQ7kylsVFQO4BwPNDCQS3u/jNDp9tt7RxIWOssTo44dVGgaD
         hhlCVnxYSUfESmTHqyviulEV3xdngRcI9reWNSDB07V9l+qxCdJB/H0e08qd3vwkNLHI
         /irA/vz59bqB3X1WZO4DCFiPQjQQC7oMRRyZsmYNyE46Rfd6K0gdXj5JkH4SwBcz+WTZ
         Cr2Q==
X-Gm-Message-State: AOAM531VYdfHLMNJ3T0MKw3+0jUdDT8DE5lntqkICen7rQ12txlBMDoN
        pxvTFLSavMfvpYhbN5zaMn0AUSGFzEE+LPaXj0AShjk1WxroGXXHqW+97mCXpnHNhl02kxWRiOG
        NBBzWzeAygqKtctUIopL9d+wZ8+Rrkde7Zv4MdjR1KRjsXcj3aBXfHVFjdthz+Al1xeU=
X-Google-Smtp-Source: ABdhPJxJRT7t1oKOrnJLDf6SVzBylAM9rt3XG26RrthEfxv0VqusA1DPApSPvHoIIL6xtTG/fMTe1lHmXA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:bfc7:0:b0:641:3c31:fe2d with SMTP id
 q7-20020a25bfc7000000b006413c31fe2dmr9330171ybm.531.1649784512097; Tue, 12
 Apr 2022 10:28:32 -0700 (PDT)
Date:   Tue, 12 Apr 2022 17:28:10 +0000
In-Reply-To: <20220412172816.917723-1-nhuck@google.com>
Message-Id: <20220412172816.917723-3-nhuck@google.com>
Mime-Version: 1.0
References: <20220412172816.917723-1-nhuck@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v4 2/8] crypto: polyval - Add POLYVAL support
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Paul Crowley <paulcrowley@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add support for POLYVAL, an =CE=B5-=CE=94-universal hash function similar t=
o
GHASH.  This patch adds POLYVAL to be used as a component to implement
HCTR2 mode.  It should be noted that POLYVAL was originally specified
for use in AES-GCM-SIV (RFC 8452), but the kernel does not currently
support this mode.

POLYVAL is implemented as an shash algorithm.  The implementation is
modified from ghash-generic.c.

For more information on POLYVAL see:
Length-preserving encryption with HCTR2:
  https://eprint.iacr.org/2021/1441.pdf
AES-GCM-SIV: Nonce Misuse-Resistant Authenticated Encryption:
  https://datatracker.ietf.org/doc/html/rfc8452

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig           |   8 ++
 crypto/Makefile          |   1 +
 crypto/polyval-generic.c | 214 +++++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c          |   4 +
 crypto/testmgr.c         |   6 ++
 crypto/testmgr.h         | 171 +++++++++++++++++++++++++++++++
 include/crypto/polyval.h |  17 ++++
 7 files changed, 421 insertions(+)
 create mode 100644 crypto/polyval-generic.c
 create mode 100644 include/crypto/polyval.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 47752aaa16ff..00139845d76d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -768,6 +768,14 @@ config CRYPTO_GHASH
 	  GHASH is the hash function used in GCM (Galois/Counter Mode).
 	  It is not a general-purpose cryptographic hash function.
=20
+config CRYPTO_POLYVAL
+	tristate
+	select CRYPTO_GF128MUL
+	select CRYPTO_HASH
+	help
+	  POLYVAL is the hash function used in HCTR2.  It is not a general-purpos=
e
+	  cryptographic hash function.
+
 config CRYPTO_POLY1305
 	tristate "Poly1305 authenticator algorithm"
 	select CRYPTO_HASH
diff --git a/crypto/Makefile b/crypto/Makefile
index 6b3fe3df1489..561f901a91d4 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -169,6 +169,7 @@ UBSAN_SANITIZE_jitterentropy.o =3D n
 jitterentropy_rng-y :=3D jitterentropy.o jitterentropy-kcapi.o
 obj-$(CONFIG_CRYPTO_TEST) +=3D tcrypt.o
 obj-$(CONFIG_CRYPTO_GHASH) +=3D ghash-generic.o
+obj-$(CONFIG_CRYPTO_POLYVAL) +=3D polyval-generic.o
 obj-$(CONFIG_CRYPTO_USER_API) +=3D af_alg.o
 obj-$(CONFIG_CRYPTO_USER_API_HASH) +=3D algif_hash.o
 obj-$(CONFIG_CRYPTO_USER_API_SKCIPHER) +=3D algif_skcipher.o
diff --git a/crypto/polyval-generic.c b/crypto/polyval-generic.c
new file mode 100644
index 000000000000..1399af125b93
--- /dev/null
+++ b/crypto/polyval-generic.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POLYVAL: hash function for HCTR2.
+ *
+ * Copyright (c) 2007 Nokia Siemens Networks - Mikko Herranen <mh1@iki.fi>
+ * Copyright (c) 2009 Intel Corp.
+ *   Author: Huang Ying <ying.huang@intel.com>
+ * Copyright 2021 Google LLC
+ */
+
+/*
+ * Code based on crypto/ghash-generic.c
+ *
+ * POLYVAL is a keyed hash function similar to GHASH. POLYVAL uses a diffe=
rent
+ * modulus for finite field multiplication which makes hardware accelerate=
d
+ * implementations on little-endian machines faster. POLYVAL is used in th=
e
+ * kernel to implement HCTR2, but was originally specified for AES-GCM-SIV
+ * (RFC 8452).
+ *
+ * For more information see:
+ * Length-preserving encryption with HCTR2:
+ *   https://eprint.iacr.org/2021/1441.pdf
+ * AES-GCM-SIV: Nonce Misuse-Resistant Authenticated Encryption:
+ *   https://datatracker.ietf.org/doc/html/rfc8452
+ *
+ * Like GHASH, POLYVAL is not a cryptographic hash function and should
+ * not be used outside of crypto modes explicitly designed to use POLYVAL.
+ *
+ * This implementation uses a convenient trick involving the GHASH and POL=
YVAL
+ * fields. This trick allows multiplication in the POLYVAL field to be
+ * implemented by using multiplication in the GHASH field as a subroutine.=
 An
+ * element of the POLYVAL field can be converted to an element of the GHAS=
H
+ * field by computing x*REVERSE(a), where REVERSE reverses the byte-orderi=
ng of
+ * a. Similarly, an element of the GHASH field can be converted back to th=
e
+ * POLYVAL field by computing REVERSE(x^{-1}*a). For more information, see=
:
+ * https://datatracker.ietf.org/doc/html/rfc8452#appendix-A
+ *
+ * By using this trick, we do not need to implement the POLYVAL field for =
the
+ * generic implementation.
+ *
+ * Warning: this generic implementation is not intended to be used in prac=
tice
+ * and is not constant time. For practical use, a hardware accelerated
+ * implementation of POLYVAL should be used instead.
+ *
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/algapi.h>
+#include <crypto/gf128mul.h>
+#include <crypto/polyval.h>
+#include <crypto/internal/hash.h>
+#include <linux/crypto.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+struct polyval_tfm_ctx {
+	struct gf128mul_4k *gf128;
+};
+
+struct polyval_desc_ctx {
+	union {
+		u8 buffer[POLYVAL_BLOCK_SIZE];
+		be128 buffer128;
+	};
+	u32 bytes;
+};
+
+static int polyval_init(struct shash_desc *desc)
+{
+	struct polyval_desc_ctx *dctx =3D shash_desc_ctx(desc);
+
+	memset(dctx, 0, sizeof(*dctx));
+
+	return 0;
+}
+
+static void reverse_block(u8 block[POLYVAL_BLOCK_SIZE])
+{
+	u64 *p1 =3D (u64 *)block;
+	u64 *p2 =3D (u64 *)&block[8];
+	u64 a =3D get_unaligned(p1);
+	u64 b =3D get_unaligned(p2);
+
+	put_unaligned(swab64(a), p2);
+	put_unaligned(swab64(b), p1);
+}
+
+static int polyval_setkey(struct crypto_shash *tfm,
+			const u8 *key, unsigned int keylen)
+{
+	struct polyval_tfm_ctx *ctx =3D crypto_shash_ctx(tfm);
+	be128 k;
+
+	if (keylen !=3D POLYVAL_BLOCK_SIZE)
+		return -EINVAL;
+
+	gf128mul_free_4k(ctx->gf128);
+
+	BUILD_BUG_ON(sizeof(k) !=3D POLYVAL_BLOCK_SIZE);
+	// avoid violating alignment rules
+	memcpy(&k, key, POLYVAL_BLOCK_SIZE);
+
+	reverse_block((u8 *)&k);
+	gf128mul_x_lle(&k, &k);
+
+	ctx->gf128 =3D gf128mul_init_4k_lle(&k);
+	memzero_explicit(&k, POLYVAL_BLOCK_SIZE);
+
+	if (!ctx->gf128)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int polyval_update(struct shash_desc *desc,
+			 const u8 *src, unsigned int srclen)
+{
+	struct polyval_desc_ctx *dctx =3D shash_desc_ctx(desc);
+	const struct polyval_tfm_ctx *ctx =3D crypto_shash_ctx(desc->tfm);
+	u8 *pos;
+	u8 tmp[POLYVAL_BLOCK_SIZE];
+	int n;
+
+	if (dctx->bytes) {
+		n =3D min(srclen, dctx->bytes);
+		pos =3D dctx->buffer + dctx->bytes - 1;
+
+		dctx->bytes -=3D n;
+		srclen -=3D n;
+
+		while (n--)
+			*pos-- ^=3D *src++;
+
+		if (!dctx->bytes)
+			gf128mul_4k_lle(&dctx->buffer128, ctx->gf128);
+	}
+
+	while (srclen >=3D POLYVAL_BLOCK_SIZE) {
+		memcpy(tmp, src, POLYVAL_BLOCK_SIZE);
+		reverse_block(tmp);
+		crypto_xor(dctx->buffer, tmp, POLYVAL_BLOCK_SIZE);
+		gf128mul_4k_lle(&dctx->buffer128, ctx->gf128);
+		src +=3D POLYVAL_BLOCK_SIZE;
+		srclen -=3D POLYVAL_BLOCK_SIZE;
+	}
+
+	if (srclen) {
+		dctx->bytes =3D POLYVAL_BLOCK_SIZE - srclen;
+		pos =3D dctx->buffer + POLYVAL_BLOCK_SIZE - 1;
+		while (srclen--)
+			*pos-- ^=3D *src++;
+	}
+
+	return 0;
+}
+
+static int polyval_final(struct shash_desc *desc, u8 *dst)
+{
+	struct polyval_desc_ctx *dctx =3D shash_desc_ctx(desc);
+	const struct polyval_tfm_ctx *ctx =3D crypto_shash_ctx(desc->tfm);
+
+	if (dctx->bytes)
+		gf128mul_4k_lle(&dctx->buffer128, ctx->gf128);
+	dctx->bytes =3D 0;
+
+	reverse_block(dctx->buffer);
+	memcpy(dst, dctx->buffer, POLYVAL_BLOCK_SIZE);
+
+	return 0;
+}
+
+static void polyval_exit_tfm(struct crypto_tfm *tfm)
+{
+	struct polyval_tfm_ctx *ctx =3D crypto_tfm_ctx(tfm);
+
+	gf128mul_free_4k(ctx->gf128);
+}
+
+static struct shash_alg polyval_alg =3D {
+	.digestsize	=3D POLYVAL_DIGEST_SIZE,
+	.init		=3D polyval_init,
+	.update		=3D polyval_update,
+	.final		=3D polyval_final,
+	.setkey		=3D polyval_setkey,
+	.descsize	=3D sizeof(struct polyval_desc_ctx),
+	.base		=3D {
+		.cra_name		=3D "polyval",
+		.cra_driver_name	=3D "polyval-generic",
+		.cra_priority		=3D 100,
+		.cra_blocksize		=3D POLYVAL_BLOCK_SIZE,
+		.cra_ctxsize		=3D sizeof(struct polyval_tfm_ctx),
+		.cra_module		=3D THIS_MODULE,
+		.cra_exit		=3D polyval_exit_tfm,
+	},
+};
+
+static int __init polyval_mod_init(void)
+{
+	return crypto_register_shash(&polyval_alg);
+}
+
+static void __exit polyval_mod_exit(void)
+{
+	crypto_unregister_shash(&polyval_alg);
+}
+
+subsys_initcall(polyval_mod_init);
+module_exit(polyval_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("POLYVAL hash function");
+MODULE_ALIAS_CRYPTO("polyval");
+MODULE_ALIAS_CRYPTO("polyval-generic");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index fd671d0e2012..dd9cf216029b 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1730,6 +1730,10 @@ static int do_test(const char *alg, u32 type, u32 ma=
sk, int m, u32 num_mb)
 		ret +=3D tcrypt_test("ccm(sm4)");
 		break;
=20
+	case 57:
+		ret +=3D tcrypt_test("polyval");
+		break;
+
 	case 100:
 		ret +=3D tcrypt_test("hmac(md5)");
 		break;
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index fbb12d7d78af..d807b200edf6 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5284,6 +5284,12 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
 		.suite =3D {
 			.hash =3D __VECS(poly1305_tv_template)
 		}
+	}, {
+		.alg =3D "polyval",
+		.test =3D alg_test_hash,
+		.suite =3D {
+			.hash =3D __VECS(polyval_tv_template)
+		}
 	}, {
 		.alg =3D "rfc3686(ctr(aes))",
 		.test =3D alg_test_skcipher,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index bf4ff97eeb37..c581e5405916 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -34929,4 +34929,175 @@ static const struct cipher_testvec aes_xctr_tv_te=
mplate[] =3D {
=20
 };
=20
+/*
+ * Test vectors generated using https://github.com/google/hctr2
+ *
+ * To ensure compatibility with RFC 8452, some tests were sourced from
+ * https://datatracker.ietf.org/doc/html/rfc8452
+ */
+static const struct hash_testvec polyval_tv_template[] =3D {
+	{ // From RFC 8452
+		.key	=3D "\x31\x07\x28\xd9\x91\x1f\x1f\x38"
+			  "\x37\xb2\x43\x16\xc3\xfa\xb9\xa0",
+		.plaintext	=3D "\x65\x78\x61\x6d\x70\x6c\x65\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x48\x65\x6c\x6c\x6f\x20\x77\x6f"
+			  "\x72\x6c\x64\x00\x00\x00\x00\x00"
+			  "\x38\x00\x00\x00\x00\x00\x00\x00"
+			  "\x58\x00\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\xad\x7f\xcf\x0b\x51\x69\x85\x16"
+			  "\x62\x67\x2f\x3c\x5f\x95\x13\x8f",
+		.psize	=3D 48,
+		.ksize	=3D 16,
+	},
+	{ // From RFC 8452
+		.key	=3D "\xd9\xb3\x60\x27\x96\x94\x94\x1a"
+			  "\xc5\xdb\xc6\x98\x7a\xda\x73\x77",
+		.plaintext	=3D "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.psize	=3D 16,
+		.ksize	=3D 16,
+	},
+	{ // From RFC 8452
+		.key	=3D "\xd9\xb3\x60\x27\x96\x94\x94\x1a"
+			  "\xc5\xdb\xc6\x98\x7a\xda\x73\x77",
+		.plaintext	=3D "\x01\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x40\x00\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\xeb\x93\xb7\x74\x09\x62\xc5\xe4"
+			  "\x9d\x2a\x90\xa7\xdc\x5c\xec\x74",
+		.psize	=3D 32,
+		.ksize	=3D 16,
+	},
+	{ // From RFC 8452
+		.key	=3D "\xd9\xb3\x60\x27\x96\x94\x94\x1a"
+			  "\xc5\xdb\xc6\x98\x7a\xda\x73\x77",
+		.plaintext	=3D "\x01\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x02\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x03\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x80\x01\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\x81\x38\x87\x46\xbc\x22\xd2\x6b"
+			  "\x2a\xbc\x3d\xcb\x15\x75\x42\x22",
+		.psize	=3D 64,
+		.ksize	=3D 16,
+	},
+	{ // From RFC 8452
+		.key	=3D "\xd9\xb3\x60\x27\x96\x94\x94\x1a"
+			  "\xc5\xdb\xc6\x98\x7a\xda\x73\x77",
+		.plaintext	=3D "\x01\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x02\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x03\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x04\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x02\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\x1e\x39\xb6\xd3\x34\x4d\x34\x8f"
+			  "\x60\x44\xf8\x99\x35\xd1\xcf\x78",
+		.psize	=3D 80,
+		.ksize	=3D 16,
+	},
+	{ // From RFC 8452
+		.key	=3D "\xd9\xb3\x60\x27\x96\x94\x94\x1a"
+			  "\xc5\xdb\xc6\x98\x7a\xda\x73\x77",
+		.plaintext	=3D "\x01\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x02\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x03\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x04\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x05\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x08\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x02\x00\x00\x00\x00\x00\x00",
+		.digest	=3D "\xff\xcd\x05\xd5\x77\x0f\x34\xad"
+			  "\x92\x67\xf0\xa5\x99\x94\xb1\x5a",
+		.psize	=3D 96,
+		.ksize	=3D 16,
+	},
+	{ // Random ( 1)
+		.key	=3D "\x90\xcc\xac\xee\xba\xd7\xd4\x68"
+			  "\x98\xa6\x79\x70\xdf\x66\x15\x6c",
+		.plaintext	=3D "",
+		.digest	=3D "\x00\x00\x00\x00\x00\x00\x00\x00"
+			  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.psize	=3D 0,
+		.ksize	=3D 16,
+	},
+	{ // Random ( 1)
+		.key	=3D "\xc1\x45\x71\xf0\x30\x07\x94\xe7"
+			  "\x3a\xdd\xe4\xc6\x19\x2d\x02\xa2",
+		.plaintext	=3D "\xc1\x5d\x47\xc7\x4c\x7c\x5e\x07"
+			  "\x85\x14\x8f\x79\xcc\x73\x83\xf7"
+			  "\x35\xb8\xcb\x73\x61\xf0\x53\x31"
+			  "\xbf\x84\xde\xb6\xde\xaf\xb0\xb8"
+			  "\xb7\xd9\x11\x91\x89\xfd\x1e\x4c"
+			  "\x84\x4a\x1f\x2a\x87\xa4\xaf\x62"
+			  "\x8d\x7d\x58\xf6\x43\x35\xfc\x53"
+			  "\x8f\x1a\xf6\x12\xe1\x13\x3f\x66"
+			  "\x91\x4b\x13\xd6\x45\xfb\xb0\x7a"
+			  "\xe0\x8b\x8e\x99\xf7\x86\x46\x37"
+			  "\xd1\x22\x9e\x52\xf3\x3f\xd9\x75"
+			  "\x2c\x2c\xc6\xbb\x0e\x08\x14\x29"
+			  "\xe8\x50\x2f\xd8\xbe\xf4\xe9\x69"
+			  "\x4a\xee\xf7\xae\x15\x65\x35\x1e",
+		.digest	=3D "\x00\x4f\x5d\xe9\x3b\xc0\xd6\x50"
+			  "\x3e\x38\x73\x86\xc6\xda\xca\x7f",
+		.psize	=3D 112,
+		.ksize	=3D 16,
+	},
+	{ // Random ( 1)
+		.key	=3D "\x37\xbe\x68\x16\x50\xb9\x4e\xb0"
+			  "\x47\xde\xe2\xbd\xde\xe4\x48\x09",
+		.plaintext	=3D "\x87\xfc\x68\x9f\xff\xf2\x4a\x1e"
+			  "\x82\x3b\x73\x8f\xc1\xb2\x1b\x7a"
+			  "\x6c\x4f\x81\xbc\x88\x9b\x6c\xa3"
+			  "\x9c\xc2\xa5\xbc\x14\x70\x4c\x9b"
+			  "\x0c\x9f\x59\x92\x16\x4b\x91\x3d"
+			  "\x18\x55\x22\x68\x12\x8c\x63\xb2"
+			  "\x51\xcb\x85\x4b\xd2\xae\x0b\x1c"
+			  "\x5d\x28\x9d\x1d\xb1\xc8\xf0\x77"
+			  "\xe9\xb5\x07\x4e\x06\xc8\xee\xf8"
+			  "\x1b\xed\x72\x2a\x55\x7d\x16\xc9"
+			  "\xf2\x54\xe7\xe9\xe0\x44\x5b\x33"
+			  "\xb1\x49\xee\xff\x43\xfb\x82\xcd"
+			  "\x4a\x70\x78\x81\xa4\x34\x36\xe8"
+			  "\x4c\x28\x54\xa6\x6c\xc3\x6b\x78"
+			  "\xe7\xc0\x5d\xc6\x5d\x81\xab\x70"
+			  "\x08\x86\xa1\xfd\xf4\x77\x55\xfd"
+			  "\xa3\xe9\xe2\x1b\xdf\x99\xb7\x80"
+			  "\xf9\x0a\x4f\x72\x4a\xd3\xaf\xbb"
+			  "\xb3\x3b\xeb\x08\x58\x0f\x79\xce"
+			  "\xa5\x99\x05\x12\x34\xd4\xf4\x86"
+			  "\x37\x23\x1d\xc8\x49\xc0\x92\xae"
+			  "\xa6\xac\x9b\x31\x55\xed\x15\xc6"
+			  "\x05\x17\x37\x8d\x90\x42\xe4\x87"
+			  "\x89\x62\x88\x69\x1c\x6a\xfd\xe3"
+			  "\x00\x2b\x47\x1a\x73\xc1\x51\xc2"
+			  "\xc0\x62\x74\x6a\x9e\xb2\xe5\x21"
+			  "\xbe\x90\xb5\xb0\x50\xca\x88\x68"
+			  "\xe1\x9d\x7a\xdf\x6c\xb7\xb9\x98"
+			  "\xee\x28\x62\x61\x8b\xd1\x47\xf9"
+			  "\x04\x7a\x0b\x5d\xcd\x2b\x65\xf5"
+			  "\x12\xa3\xfe\x1a\xaa\x2c\x78\x42"
+			  "\xb8\xbe\x7d\x74\xeb\x59\xba\xba",
+		.digest	=3D "\xae\x11\xd4\x60\x2a\x5f\x9e\x42"
+			  "\x89\x04\xc2\x34\x8d\x55\x94\x0a",
+		.psize	=3D 256,
+		.ksize	=3D 16,
+	},
+
+};
+
 #endif	/* _CRYPTO_TESTMGR_H */
diff --git a/include/crypto/polyval.h b/include/crypto/polyval.h
new file mode 100644
index 000000000000..b14c38aa9166
--- /dev/null
+++ b/include/crypto/polyval.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common values for the Polyval hash algorithm
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#ifndef _CRYPTO_POLYVAL_H
+#define _CRYPTO_POLYVAL_H
+
+#include <linux/types.h>
+#include <linux/crypto.h>
+
+#define POLYVAL_BLOCK_SIZE	16
+#define POLYVAL_DIGEST_SIZE	16
+
+#endif
--=20
2.35.1.1178.g4f1659d476-goog

