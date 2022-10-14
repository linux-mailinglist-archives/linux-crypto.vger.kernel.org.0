Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFB5FECAD
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Oct 2022 12:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJNKr2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Oct 2022 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNKr1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Oct 2022 06:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353526F6
        for <linux-crypto@vger.kernel.org>; Fri, 14 Oct 2022 03:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A838261AB9
        for <linux-crypto@vger.kernel.org>; Fri, 14 Oct 2022 10:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C03C433C1;
        Fri, 14 Oct 2022 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665744443;
        bh=Km2JqacEtRJCe8N1V0TNMTwZJdk4XXeVGs5r5PAFAg4=;
        h=From:To:Cc:Subject:Date:From;
        b=IPKIJVaWCRF7l2tDParZULcLQ+R5XRiH16eO8qivbBPUzCaMaEM2b2IPQjtNqEPT2
         BzZ6LSrEtZBIAB6lfKSem8XT2pjZKpvrHtGYSGcvXVfTDKvFU0tWyUb87/ULG+kCor
         xzSKYSV4usqOPosWStK8cE7g4M49UGLcFNLM5KgjgS4yfgmaP3Lr5PP8/GJEqz2801
         F+/hFVGd5cslnqrGwpBw17fltzCdsjKv1hYZFiNPENTBtrbhZrN98suGWAJjDNZ+nY
         FVMTgNt4rdnNxn/sUVTJfZb1tmoi2AQ9sz5eK+H+Gk6nApdhHde/AOKRCyC3YDMMHg
         uKFj3FWaBJEzw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     keescook@chromium.org, ebiggers@kernel.org, jason@zx2c4.com,
        herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH v2] crypto: gcmaes - Provide minimal library implementation
Date:   Fri, 14 Oct 2022 12:47:13 +0200
Message-Id: <20221014104713.2613195-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=32629; i=ardb@kernel.org; h=from:subject; bh=Km2JqacEtRJCe8N1V0TNMTwZJdk4XXeVGs5r5PAFAg4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjST4woZLy+Qg2GVmjRMWi51wUj0oINJlxYQXSUb8/ Q56S1qKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY0k+MAAKCRDDTyI5ktmPJAZWDA CPtlcAhGIJl9PqJ5elgb7UscoTXTTeR+Hb2Sx3bpiSPYx9lsH06B3BMyKdxnKe+0yPFmh5fQSL6X67 5LAd8h8ApxZDbKBGrMqaPtoZrcF+WybhIrk06mdwnLE/ctJPqAoFeOeldMFUgxNBZZiMkPZnKprYFB OzIrW4svB0AymwVbe/ycobmqjpEbD8tL++sHXzIFe+36CH6+L5d6nE3shvOw2JWAvRkGHY7Anxcblh /fchBKipLUAIAfCVjfQ5ssbLGu9YQw9FpTltuzn7AcZVT8vBNPgD26Xdusv2EjxINfIXhAdS3uVLhe 5Q6IGH+R0CM8p1Wb14HG5OLFh3RIq9PNZS9eG2VqfvnfMB5UiiMeCSb2G23bmO2QARUm3ZAJBqY/87 EOty0Mekxk9krYM69VmaOm40wIi1qKDaRkb71LFlh1KZUkAqYFahXNcuoM1s3K7NzceTu0mRID08YR Z3Yv5EOotM+mVqAtmfP730wq55vfDCM+MWtuBMlEWwGao=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Implement a minimal library version of GCM based on the existing library
implementations of AES and multiplication in GF(2^128). Using these
primitives, GCM can be implemented in a straight-forward manner.

GCM has a couple of sharp edges, i.e., the amount of input data
processed with the same initialization vector (IV) should be capped to
protect the counter from 32-bit rollover (or carry), and the size of the
authentication tag should be fixed for a given key. [0]

The former concern is addressed trivially, given that the function call
API uses 32-bit signed types for the input lengths. It is still up to
the caller to avoid IV reuse in general, but this is not something we
can police at the implementation level.

As for the latter concern, let's make the authentication tag size part
of the key schedule, and only permit it to be configured as part of the
key expansion routine.

Note that table based AES implementations are susceptible to known
plaintext timing attacks on the encryption key. The AES library already
attempts to mitigate this to some extent, but given that the counter
mode encryption used by GCM operates exclusively on known plaintext by
construction (the IV and therefore the initial counter value are known
to an attacker), let's take some extra care to mitigate this, by calling
the AES library with interrupts disabled.

[0] https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-38d.pdf

Link: https://lore.kernel.org/all/c6fb9b25-a4b6-2e4a-2dd1-63adda055a49@amd.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
---
v2: - rename gcm to gcmaes to reflect that GCM is also used in
      combination with other symmetric ciphers (Jason)
    - add Nikunj's Tested-by

 arch/x86/crypto/aesni-intel_glue.c |  24 +-
 include/crypto/gcm.h               |  66 ++
 lib/crypto/Kconfig                 |   6 +
 lib/crypto/Makefile                |   3 +
 lib/crypto/gcmaes.c                | 720 ++++++++++++++++++++
 5 files changed, 807 insertions(+), 12 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..0733f218783e 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -778,8 +778,8 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
 	return 0;
 }
 
-static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
-			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
+static int gcmaesni_encrypt(struct aead_request *req, unsigned int assoclen,
+			    u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
@@ -797,8 +797,8 @@ static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 	return 0;
 }
 
-static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
-			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
+static int gcmaesni_decrypt(struct aead_request *req, unsigned int assoclen,
+			    u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	unsigned long auth_tag_len = crypto_aead_authsize(tfm);
@@ -847,8 +847,8 @@ static int helper_rfc4106_encrypt(struct aead_request *req)
 		*(iv+4+i) = req->iv[i];
 	*((__be32 *)(iv+12)) = counter;
 
-	return gcmaes_encrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
-			      aes_ctx);
+	return gcmaesni_encrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
+				aes_ctx);
 }
 
 static int helper_rfc4106_decrypt(struct aead_request *req)
@@ -875,8 +875,8 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 		*(iv+4+i) = req->iv[i];
 	*((__be32 *)(iv+12)) = counter;
 
-	return gcmaes_decrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
-			      aes_ctx);
+	return gcmaesni_decrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
+				aes_ctx);
 }
 #endif
 
@@ -1167,8 +1167,8 @@ static int generic_gcmaes_encrypt(struct aead_request *req)
 	memcpy(iv, req->iv, 12);
 	*((__be32 *)(iv+12)) = counter;
 
-	return gcmaes_encrypt(req, req->assoclen, ctx->hash_subkey, iv,
-			      aes_ctx);
+	return gcmaesni_encrypt(req, req->assoclen, ctx->hash_subkey, iv,
+				aes_ctx);
 }
 
 static int generic_gcmaes_decrypt(struct aead_request *req)
@@ -1183,8 +1183,8 @@ static int generic_gcmaes_decrypt(struct aead_request *req)
 	memcpy(iv, req->iv, 12);
 	*((__be32 *)(iv+12)) = counter;
 
-	return gcmaes_decrypt(req, req->assoclen, ctx->hash_subkey, iv,
-			      aes_ctx);
+	return gcmaesni_decrypt(req, req->assoclen, ctx->hash_subkey, iv,
+				aes_ctx);
 }
 
 static struct aead_alg aesni_aeads[] = { {
diff --git a/include/crypto/gcm.h b/include/crypto/gcm.h
index 9d7eff04f224..dfbc381df5ae 100644
--- a/include/crypto/gcm.h
+++ b/include/crypto/gcm.h
@@ -3,6 +3,9 @@
 
 #include <linux/errno.h>
 
+#include <crypto/aes.h>
+#include <crypto/gf128mul.h>
+
 #define GCM_AES_IV_SIZE 12
 #define GCM_RFC4106_IV_SIZE 8
 #define GCM_RFC4543_IV_SIZE 8
@@ -60,4 +63,67 @@ static inline int crypto_ipsec_check_assoclen(unsigned int assoclen)
 
 	return 0;
 }
+
+struct gcmaes_ctx {
+	be128			ghash_key;
+	struct crypto_aes_ctx	aes_ctx;
+	unsigned int		authsize;
+};
+
+/**
+ * gcmaes_expandkey - Expands the AES and GHASH keys for the GCM-AES key
+ * 		      schedule
+ *
+ * @ctx:	The data structure that will hold the GCM-AES key schedule
+ * @key:	The AES encryption input key
+ * @keysize:	The length in bytes of the input key
+ * @authsize:	The size in bytes of the GCM authentication tag
+ *
+ * Returns 0 on success, or -EINVAL if @keysize or @authsize contain values
+ * that are not permitted by the GCM specification.
+ */
+int gcmaes_expandkey(struct gcmaes_ctx *ctx, const u8 *key,
+		     unsigned int keysize, unsigned int authsize);
+
+/**
+ * gcmaes_encrypt - Perform GCM-AES encryption on a block of data
+ *
+ * @ctx:	The GCM-AES key schedule
+ * @dst:	Pointer to the ciphertext output buffer
+ * @src:	Pointer the plaintext (may equal @dst for encryption in place)
+ * @crypt_len:	The size in bytes of the plaintext and ciphertext.
+ * @assoc:	Pointer to the associated data,
+ * @assoc_len:	The size in bytes of the associated data
+ * @iv:		The initialization vector (IV) to use for this block of data
+ *		(must be 12 bytes in size as per the GCM spec recommendation)
+ * @authtag:	The address of the buffer in memory where the authentication
+ *		tag should be stored. The buffer is assumed to have space for
+ *		@ctx->authsize bytes.
+ */
+void gcmaes_encrypt(const struct gcmaes_ctx *ctx, u8 *dst, const u8 *src,
+		    int crypt_len, const u8 *assoc, int assoc_len,
+		    const u8 iv[GCM_AES_IV_SIZE], u8 *authtag);
+
+/**
+ * gcmaes_decrypt - Perform GCM-AES decryption on a block of data
+ *
+ * @ctx:	The GCM-AES key schedule
+ * @dst:	Pointer to the plaintext output buffer
+ * @src:	Pointer the ciphertext (may equal @dst for decryption in place)
+ * @crypt_len:	The size in bytes of the plaintext and ciphertext.
+ * @assoc:	Pointer to the associated data,
+ * @assoc_len:	The size in bytes of the associated data
+ * @iv:		The initialization vector (IV) to use for this block of data
+ *		(must be 12 bytes in size as per the GCM spec recommendation)
+ * @authtag:	The address of the buffer in memory where the authentication
+ *		tag is stored.
+ *
+ * Returns 0 on success, or -EBADMSG if the ciphertext failed authentication.
+ * On failure, no plaintext will be returned.
+ */
+int __must_check gcmaes_decrypt(const struct gcmaes_ctx *ctx, u8 *dst,
+				const u8 *src, int crypt_len, const u8 *assoc,
+				int assoc_len, const u8 iv[GCM_AES_IV_SIZE],
+				const u8 *authtag);
+
 #endif
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 7e9683e9f5c6..974721d4b081 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -8,6 +8,12 @@ config CRYPTO_LIB_UTILS
 config CRYPTO_LIB_AES
 	tristate
 
+config CRYPTO_LIB_GCMAES
+	tristate
+	select CRYPTO_GF128MUL
+	select CRYPTO_LIB_AES
+	select CRYPTO_LIB_UTILS
+
 config CRYPTO_LIB_ARC4
 	tristate
 
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index c852f067ab06..f1b0b2d2d596 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
 obj-$(CONFIG_CRYPTO_LIB_AES)			+= libaes.o
 libaes-y					:= aes.o
 
+obj-$(CONFIG_CRYPTO_LIB_GCMAES)			+= libgcmaes.o
+libgcmaes-y					:= gcmaes.o
+
 obj-$(CONFIG_CRYPTO_LIB_ARC4)			+= libarc4.o
 libarc4-y					:= arc4.o
 
diff --git a/lib/crypto/gcmaes.c b/lib/crypto/gcmaes.c
new file mode 100644
index 000000000000..d6f5c9b1e344
--- /dev/null
+++ b/lib/crypto/gcmaes.c
@@ -0,0 +1,720 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Minimal library implementation of GCM
+ *
+ * Copyright 2022 Google LLC
+ */
+
+#include <linux/module.h>
+
+#include <crypto/algapi.h>
+#include <crypto/gcm.h>
+#include <crypto/ghash.h>
+
+#include <asm/irqflags.h>
+
+static void gcmaes_encrypt_block(const struct crypto_aes_ctx *ctx, void *dst,
+				 const void *src)
+{
+	unsigned long flags;
+
+	/*
+	 * In GCM-AES, both the GHASH key derivation and the CTR mode
+	 * encryption operate on known plaintext, making them susceptible to
+	 * timing attacks on the encryption key. The AES library already
+	 * mitigates this risk to some extent by pulling the entire S-box into
+	 * the caches before doing any substitutions, but this strategy is more
+	 * effective when running with interrupts disabled.
+	 */
+	local_irq_save(flags);
+	aes_encrypt(ctx, dst, src);
+	local_irq_restore(flags);
+}
+
+/**
+ * gcmaes_expandkey - Expands the AES and GHASH keys for the GCM-AES key
+ *		      schedule
+ *
+ * @ctx:	The data structure that will hold the GCM-AES key schedule
+ * @key:	The AES encryption input key
+ * @keysize:	The length in bytes of the input key
+ * @authsize:	The size in bytes of the GCM authentication tag
+ *
+ * Returns 0 on success, or -EINVAL if @keysize or @authsize contain values
+ * that are not permitted by the GCM specification.
+ */
+int gcmaes_expandkey(struct gcmaes_ctx *ctx, const u8 *key,
+		     unsigned int keysize, unsigned int authsize)
+{
+	u8 kin[AES_BLOCK_SIZE] = {};
+	int ret;
+
+	ret = crypto_gcm_check_authsize(authsize) ?:
+	      aes_expandkey(&ctx->aes_ctx, key, keysize);
+	if (ret)
+		return ret;
+
+	ctx->authsize = authsize;
+	gcmaes_encrypt_block(&ctx->aes_ctx, &ctx->ghash_key, kin);
+
+	return 0;
+}
+EXPORT_SYMBOL(gcmaes_expandkey);
+
+static void gcmaes_ghash(be128 *ghash, const be128 *key, const void *src,
+			 int len)
+{
+	while (len > 0) {
+		crypto_xor((u8 *)ghash, src, min(len, GHASH_BLOCK_SIZE));
+		gf128mul_lle(ghash, key);
+
+		src += GHASH_BLOCK_SIZE;
+		len -= GHASH_BLOCK_SIZE;
+	}
+}
+
+static void gcmaes_mac(const struct gcmaes_ctx *ctx, const u8 *src, int src_len,
+		       const u8 *assoc, int assoc_len, __be32 *ctr, u8 *authtag)
+{
+	be128 tail = { cpu_to_be64(assoc_len * 8), cpu_to_be64(src_len * 8) };
+	u8 buf[AES_BLOCK_SIZE];
+	be128 ghash = {};
+
+	gcmaes_ghash(&ghash, &ctx->ghash_key, assoc, assoc_len);
+	gcmaes_ghash(&ghash, &ctx->ghash_key, src, src_len);
+	gcmaes_ghash(&ghash, &ctx->ghash_key, &tail, sizeof(tail));
+
+	ctr[3] = cpu_to_be32(1);
+	gcmaes_encrypt_block(&ctx->aes_ctx, buf, ctr);
+	crypto_xor_cpy(authtag, buf, (u8 *)&ghash, ctx->authsize);
+
+	memzero_explicit(&ghash, sizeof(ghash));
+	memzero_explicit(buf, sizeof(buf));
+}
+
+static void gcmaes_crypt(const struct gcmaes_ctx *ctx, u8 *dst, const u8 *src,
+			 int len, __be32 *ctr)
+{
+	u8 buf[AES_BLOCK_SIZE];
+	unsigned int n = 2;
+
+	while (len > 0) {
+		ctr[3] = cpu_to_be32(n++);
+		gcmaes_encrypt_block(&ctx->aes_ctx, buf, ctr);
+		crypto_xor_cpy(dst, src, buf, min(len, AES_BLOCK_SIZE));
+
+		dst += AES_BLOCK_SIZE;
+		src += AES_BLOCK_SIZE;
+		len -= AES_BLOCK_SIZE;
+	}
+	memzero_explicit(buf, sizeof(buf));
+}
+
+/**
+ * gcmaes_encrypt - Perform GCM-AES encryption on a block of data
+ *
+ * @ctx:	The GCM-AES key schedule
+ * @dst:	Pointer to the ciphertext output buffer
+ * @src:	Pointer the plaintext (may equal @dst for encryption in place)
+ * @crypt_len:	The size in bytes of the plaintext and ciphertext.
+ * @assoc:	Pointer to the associated data,
+ * @assoc_len:	The size in bytes of the associated data
+ * @iv:		The initialization vector (IV) to use for this block of data
+ *		(must be 12 bytes in size as per the GCM spec recommendation)
+ * @authtag:	The address of the buffer in memory where the authentication
+ *		tag should be stored. The buffer is assumed to have space for
+ *		@ctx->authsize bytes.
+ */
+void gcmaes_encrypt(const struct gcmaes_ctx *ctx, u8 *dst, const u8 *src,
+		    int crypt_len, const u8 *assoc, int assoc_len,
+		    const u8 iv[GCM_AES_IV_SIZE], u8 *authtag)
+{
+	__be32 ctr[4];
+
+	memcpy(ctr, iv, GCM_AES_IV_SIZE);
+
+	gcmaes_crypt(ctx, dst, src, crypt_len, ctr);
+	gcmaes_mac(ctx, dst, crypt_len, assoc, assoc_len, ctr, authtag);
+}
+EXPORT_SYMBOL(gcmaes_encrypt);
+
+/**
+ * gcmaes_decrypt - Perform GCM-AES decryption on a block of data
+ *
+ * @ctx:	The GCM-AES key schedule
+ * @dst:	Pointer to the plaintext output buffer
+ * @src:	Pointer the ciphertext (may equal @dst for decryption in place)
+ * @crypt_len:	The size in bytes of the plaintext and ciphertext.
+ * @assoc:	Pointer to the associated data,
+ * @assoc_len:	The size in bytes of the associated data
+ * @iv:		The initialization vector (IV) to use for this block of data
+ *		(must be 12 bytes in size as per the GCM spec recommendation)
+ * @authtag:	The address of the buffer in memory where the authentication
+ *		tag is stored.
+ *
+ * Returns 0 on success, or -EBADMSG if the ciphertext failed authentication.
+ * On failure, no plaintext will be returned.
+ */
+int __must_check gcmaes_decrypt(const struct gcmaes_ctx *ctx, u8 *dst,
+				const u8 *src, int crypt_len, const u8 *assoc,
+				int assoc_len, const u8 iv[GCM_AES_IV_SIZE],
+				const u8 *authtag)
+{
+	u8 tagbuf[AES_BLOCK_SIZE];
+	__be32 ctr[4];
+
+	memcpy(ctr, iv, GCM_AES_IV_SIZE);
+
+	gcmaes_mac(ctx, src, crypt_len, assoc, assoc_len, ctr, tagbuf);
+	if (crypto_memneq(authtag, tagbuf, ctx->authsize)) {
+		memzero_explicit(tagbuf, sizeof(tagbuf));
+		return -EBADMSG;
+	}
+	gcmaes_crypt(ctx, dst, src, crypt_len, ctr);
+	return 0;
+}
+EXPORT_SYMBOL(gcmaes_decrypt);
+
+MODULE_DESCRIPTION("Generic GCM-AES library");
+MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+
+/*
+ * Test code below. Vectors taken from crypto/testmgr.h
+ */
+
+static const u8 __initconst ctext0[16] =
+	"\x58\xe2\xfc\xce\xfa\x7e\x30\x61"
+	"\x36\x7f\x1d\x57\xa4\xe7\x45\x5a";
+
+static const u8 __initconst ptext1[16];
+
+static const u8 __initconst ctext1[32] =
+	"\x03\x88\xda\xce\x60\xb6\xa3\x92"
+	"\xf3\x28\xc2\xb9\x71\xb2\xfe\x78"
+	"\xab\x6e\x47\xd4\x2c\xec\x13\xbd"
+	"\xf5\x3a\x67\xb2\x12\x57\xbd\xdf";
+
+static const u8 __initconst ptext2[64] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39\x1a\xaf\xd2\x55";
+
+static const u8 __initconst ctext2[80] =
+	"\x42\x83\x1e\xc2\x21\x77\x74\x24"
+	"\x4b\x72\x21\xb7\x84\xd0\xd4\x9c"
+	"\xe3\xaa\x21\x2f\x2c\x02\xa4\xe0"
+	"\x35\xc1\x7e\x23\x29\xac\xa1\x2e"
+	"\x21\xd5\x14\xb2\x54\x66\x93\x1c"
+	"\x7d\x8f\x6a\x5a\xac\x84\xaa\x05"
+	"\x1b\xa3\x0b\x39\x6a\x0a\xac\x97"
+	"\x3d\x58\xe0\x91\x47\x3f\x59\x85"
+	"\x4d\x5c\x2a\xf3\x27\xcd\x64\xa6"
+	"\x2c\xf3\x5a\xbd\x2b\xa6\xfa\xb4";
+
+static const u8 __initconst ptext3[60] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39";
+
+static const u8 __initconst ctext3[76] =
+	"\x42\x83\x1e\xc2\x21\x77\x74\x24"
+	"\x4b\x72\x21\xb7\x84\xd0\xd4\x9c"
+	"\xe3\xaa\x21\x2f\x2c\x02\xa4\xe0"
+	"\x35\xc1\x7e\x23\x29\xac\xa1\x2e"
+	"\x21\xd5\x14\xb2\x54\x66\x93\x1c"
+	"\x7d\x8f\x6a\x5a\xac\x84\xaa\x05"
+	"\x1b\xa3\x0b\x39\x6a\x0a\xac\x97"
+	"\x3d\x58\xe0\x91"
+	"\x5b\xc9\x4f\xbc\x32\x21\xa5\xdb"
+	"\x94\xfa\xe9\x5a\xe7\x12\x1a\x47";
+
+static const u8 __initconst ctext4[16] =
+	"\xcd\x33\xb2\x8a\xc7\x73\xf7\x4b"
+	"\xa0\x0e\xd1\xf3\x12\x57\x24\x35";
+
+static const u8 __initconst ctext5[32] =
+	"\x98\xe7\x24\x7c\x07\xf0\xfe\x41"
+	"\x1c\x26\x7e\x43\x84\xb0\xf6\x00"
+	"\x2f\xf5\x8d\x80\x03\x39\x27\xab"
+	"\x8e\xf4\xd4\x58\x75\x14\xf0\xfb";
+
+static const u8 __initconst ptext6[64] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39\x1a\xaf\xd2\x55";
+
+static const u8 __initconst ctext6[80] =
+	"\x39\x80\xca\x0b\x3c\x00\xe8\x41"
+	"\xeb\x06\xfa\xc4\x87\x2a\x27\x57"
+	"\x85\x9e\x1c\xea\xa6\xef\xd9\x84"
+	"\x62\x85\x93\xb4\x0c\xa1\xe1\x9c"
+	"\x7d\x77\x3d\x00\xc1\x44\xc5\x25"
+	"\xac\x61\x9d\x18\xc8\x4a\x3f\x47"
+	"\x18\xe2\x44\x8b\x2f\xe3\x24\xd9"
+	"\xcc\xda\x27\x10\xac\xad\xe2\x56"
+	"\x99\x24\xa7\xc8\x58\x73\x36\xbf"
+	"\xb1\x18\x02\x4d\xb8\x67\x4a\x14";
+
+static const u8 __initconst ctext7[16] =
+	"\x53\x0f\x8a\xfb\xc7\x45\x36\xb9"
+	"\xa9\x63\xb4\xf1\xc4\xcb\x73\x8b";
+
+static const u8 __initconst ctext8[32] =
+	"\xce\xa7\x40\x3d\x4d\x60\x6b\x6e"
+	"\x07\x4e\xc5\xd3\xba\xf3\x9d\x18"
+	"\xd0\xd1\xc8\xa7\x99\x99\x6b\xf0"
+	"\x26\x5b\x98\xb5\xd4\x8a\xb9\x19";
+
+static const u8 __initconst ptext9[64] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39\x1a\xaf\xd2\x55";
+
+static const u8 __initconst ctext9[80] =
+	"\x52\x2d\xc1\xf0\x99\x56\x7d\x07"
+	"\xf4\x7f\x37\xa3\x2a\x84\x42\x7d"
+	"\x64\x3a\x8c\xdc\xbf\xe5\xc0\xc9"
+	"\x75\x98\xa2\xbd\x25\x55\xd1\xaa"
+	"\x8c\xb0\x8e\x48\x59\x0d\xbb\x3d"
+	"\xa7\xb0\x8b\x10\x56\x82\x88\x38"
+	"\xc5\xf6\x1e\x63\x93\xba\x7a\x0a"
+	"\xbc\xc9\xf6\x62\x89\x80\x15\xad"
+	"\xb0\x94\xda\xc5\xd9\x34\x71\xbd"
+	"\xec\x1a\x50\x22\x70\xe3\xcc\x6c";
+
+static const u8 __initconst ptext10[60] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39";
+
+static const u8 __initconst ctext10[76] =
+	"\x52\x2d\xc1\xf0\x99\x56\x7d\x07"
+	"\xf4\x7f\x37\xa3\x2a\x84\x42\x7d"
+	"\x64\x3a\x8c\xdc\xbf\xe5\xc0\xc9"
+	"\x75\x98\xa2\xbd\x25\x55\xd1\xaa"
+	"\x8c\xb0\x8e\x48\x59\x0d\xbb\x3d"
+	"\xa7\xb0\x8b\x10\x56\x82\x88\x38"
+	"\xc5\xf6\x1e\x63\x93\xba\x7a\x0a"
+	"\xbc\xc9\xf6\x62"
+	"\x76\xfc\x6e\xce\x0f\x4e\x17\x68"
+	"\xcd\xdf\x88\x53\xbb\x2d\x55\x1b";
+
+static const u8 __initconst ptext11[60] =
+	"\xd9\x31\x32\x25\xf8\x84\x06\xe5"
+	"\xa5\x59\x09\xc5\xaf\xf5\x26\x9a"
+	"\x86\xa7\xa9\x53\x15\x34\xf7\xda"
+	"\x2e\x4c\x30\x3d\x8a\x31\x8a\x72"
+	"\x1c\x3c\x0c\x95\x95\x68\x09\x53"
+	"\x2f\xcf\x0e\x24\x49\xa6\xb5\x25"
+	"\xb1\x6a\xed\xf5\xaa\x0d\xe6\x57"
+	"\xba\x63\x7b\x39";
+
+static const u8 __initconst ctext11[76] =
+	"\x39\x80\xca\x0b\x3c\x00\xe8\x41"
+	"\xeb\x06\xfa\xc4\x87\x2a\x27\x57"
+	"\x85\x9e\x1c\xea\xa6\xef\xd9\x84"
+	"\x62\x85\x93\xb4\x0c\xa1\xe1\x9c"
+	"\x7d\x77\x3d\x00\xc1\x44\xc5\x25"
+	"\xac\x61\x9d\x18\xc8\x4a\x3f\x47"
+	"\x18\xe2\x44\x8b\x2f\xe3\x24\xd9"
+	"\xcc\xda\x27\x10"
+	"\x25\x19\x49\x8e\x80\xf1\x47\x8f"
+	"\x37\xba\x55\xbd\x6d\x27\x61\x8c";
+
+static const u8 __initconst ptext12[719] =
+	"\x42\xc1\xcc\x08\x48\x6f\x41\x3f"
+	"\x2f\x11\x66\x8b\x2a\x16\xf0\xe0"
+	"\x58\x83\xf0\xc3\x70\x14\xc0\x5b"
+	"\x3f\xec\x1d\x25\x3c\x51\xd2\x03"
+	"\xcf\x59\x74\x1f\xb2\x85\xb4\x07"
+	"\xc6\x6a\x63\x39\x8a\x5b\xde\xcb"
+	"\xaf\x08\x44\xbd\x6f\x91\x15\xe1"
+	"\xf5\x7a\x6e\x18\xbd\xdd\x61\x50"
+	"\x59\xa9\x97\xab\xbb\x0e\x74\x5c"
+	"\x00\xa4\x43\x54\x04\x54\x9b\x3b"
+	"\x77\xec\xfd\x5c\xa6\xe8\x7b\x08"
+	"\xae\xe6\x10\x3f\x32\x65\xd1\xfc"
+	"\xa4\x1d\x2c\x31\xfb\x33\x7a\xb3"
+	"\x35\x23\xf4\x20\x41\xd4\xad\x82"
+	"\x8b\xa4\xad\x96\x1c\x20\x53\xbe"
+	"\x0e\xa6\xf4\xdc\x78\x49\x3e\x72"
+	"\xb1\xa9\xb5\x83\xcb\x08\x54\xb7"
+	"\xad\x49\x3a\xae\x98\xce\xa6\x66"
+	"\x10\x30\x90\x8c\x55\x83\xd7\x7c"
+	"\x8b\xe6\x53\xde\xd2\x6e\x18\x21"
+	"\x01\x52\xd1\x9f\x9d\xbb\x9c\x73"
+	"\x57\xcc\x89\x09\x75\x9b\x78\x70"
+	"\xed\x26\x97\x4d\xb4\xe4\x0c\xa5"
+	"\xfa\x70\x04\x70\xc6\x96\x1c\x7d"
+	"\x54\x41\x77\xa8\xe3\xb0\x7e\x96"
+	"\x82\xd9\xec\xa2\x87\x68\x55\xf9"
+	"\x8f\x9e\x73\x43\x47\x6a\x08\x36"
+	"\x93\x67\xa8\x2d\xde\xac\x41\xa9"
+	"\x5c\x4d\x73\x97\x0f\x70\x68\xfa"
+	"\x56\x4d\x00\xc2\x3b\x1f\xc8\xb9"
+	"\x78\x1f\x51\x07\xe3\x9a\x13\x4e"
+	"\xed\x2b\x2e\xa3\xf7\x44\xb2\xe7"
+	"\xab\x19\x37\xd9\xba\x76\x5e\xd2"
+	"\xf2\x53\x15\x17\x4c\x6b\x16\x9f"
+	"\x02\x66\x49\xca\x7c\x91\x05\xf2"
+	"\x45\x36\x1e\xf5\x77\xad\x1f\x46"
+	"\xa8\x13\xfb\x63\xb6\x08\x99\x63"
+	"\x82\xa2\xed\xb3\xac\xdf\x43\x19"
+	"\x45\xea\x78\x73\xd9\xb7\x39\x11"
+	"\xa3\x13\x7c\xf8\x3f\xf7\xad\x81"
+	"\x48\x2f\xa9\x5c\x5f\xa0\xf0\x79"
+	"\xa4\x47\x7d\x80\x20\x26\xfd\x63"
+	"\x0a\xc7\x7e\x6d\x75\x47\xff\x76"
+	"\x66\x2e\x8a\x6c\x81\x35\xaf\x0b"
+	"\x2e\x6a\x49\x60\xc1\x10\xe1\xe1"
+	"\x54\x03\xa4\x09\x0c\x37\x7a\x15"
+	"\x23\x27\x5b\x8b\x4b\xa5\x64\x97"
+	"\xae\x4a\x50\x73\x1f\x66\x1c\x5c"
+	"\x03\x25\x3c\x8d\x48\x58\x71\x34"
+	"\x0e\xec\x4e\x55\x1a\x03\x6a\xe5"
+	"\xb6\x19\x2b\x84\x2a\x20\xd1\xea"
+	"\x80\x6f\x96\x0e\x05\x62\xc7\x78"
+	"\x87\x79\x60\x38\x46\xb4\x25\x57"
+	"\x6e\x16\x63\xf8\xad\x6e\xd7\x42"
+	"\x69\xe1\x88\xef\x6e\xd5\xb4\x9a"
+	"\x3c\x78\x6c\x3b\xe5\xa0\x1d\x22"
+	"\x86\x5c\x74\x3a\xeb\x24\x26\xc7"
+	"\x09\xfc\x91\x96\x47\x87\x4f\x1a"
+	"\xd6\x6b\x2c\x18\x47\xc0\xb8\x24"
+	"\xa8\x5a\x4a\x9e\xcb\x03\xe7\x2a"
+	"\x09\xe6\x4d\x9c\x6d\x86\x60\xf5"
+	"\x2f\x48\x69\x37\x9f\xf2\xd2\xcb"
+	"\x0e\x5a\xdd\x6e\x8a\xfb\x6a\xfe"
+	"\x0b\x63\xde\x87\x42\x79\x8a\x68"
+	"\x51\x28\x9b\x7a\xeb\xaf\xb8\x2f"
+	"\x9d\xd1\xc7\x45\x90\x08\xc9\x83"
+	"\xe9\x83\x84\xcb\x28\x69\x09\x69"
+	"\xce\x99\x46\x00\x54\xcb\xd8\x38"
+	"\xf9\x53\x4a\xbf\x31\xce\x57\x15"
+	"\x33\xfa\x96\x04\x33\x42\xe3\xc0"
+	"\xb7\x54\x4a\x65\x7a\x7c\x02\xe6"
+	"\x19\x95\xd0\x0e\x82\x07\x63\xf9"
+	"\xe1\x2b\x2a\xfc\x55\x92\x52\xc9"
+	"\xb5\x9f\x23\x28\x60\xe7\x20\x51"
+	"\x10\xd3\xed\x6d\x9b\xab\xb8\xe2"
+	"\x5d\x9a\x34\xb3\xbe\x9c\x64\xcb"
+	"\x78\xc6\x91\x22\x40\x91\x80\xbe"
+	"\xd7\x78\x5c\x0e\x0a\xdc\x08\xe9"
+	"\x67\x10\xa4\x83\x98\x79\x23\xe7"
+	"\x92\xda\xa9\x22\x16\xb1\xe7\x78"
+	"\xa3\x1c\x6c\x8f\x35\x7c\x4d\x37"
+	"\x2f\x6e\x0b\x50\x5c\x34\xb9\xf9"
+	"\xe6\x3d\x91\x0d\x32\x95\xaa\x3d"
+	"\x48\x11\x06\xbb\x2d\xf2\x63\x88"
+	"\x3f\x73\x09\xe2\x45\x56\x31\x51"
+	"\xfa\x5e\x4e\x62\xf7\x90\xf9\xa9"
+	"\x7d\x7b\x1b\xb1\xc8\x26\x6e\x66"
+	"\xf6\x90\x9a\x7f\xf2\x57\xcc\x23"
+	"\x59\xfa\xfa\xaa\x44\x04\x01\xa7"
+	"\xa4\x78\xdb\x74\x3d\x8b\xb5";
+
+static const u8 __initconst ctext12[735] =
+	"\x84\x0b\xdb\xd5\xb7\xa8\xfe\x20"
+	"\xbb\xb1\x12\x7f\x41\xea\xb3\xc0"
+	"\xa2\xb4\x37\x19\x11\x58\xb6\x0b"
+	"\x4c\x1d\x38\x05\x54\xd1\x16\x73"
+	"\x8e\x1c\x20\x90\xa2\x9a\xb7\x74"
+	"\x47\xe6\xd8\xfc\x18\x3a\xb4\xea"
+	"\xd5\x16\x5a\x2c\x53\x01\x46\xb3"
+	"\x18\x33\x74\x6c\x50\xf2\xe8\xc0"
+	"\x73\xda\x60\x22\xeb\xe3\xe5\x9b"
+	"\x20\x93\x6c\x4b\x37\x99\xb8\x23"
+	"\x3b\x4e\xac\xe8\x5b\xe8\x0f\xb7"
+	"\xc3\x8f\xfb\x4a\x37\xd9\x39\x95"
+	"\x34\xf1\xdb\x8f\x71\xd9\xc7\x0b"
+	"\x02\xf1\x63\xfc\x9b\xfc\xc5\xab"
+	"\xb9\x14\x13\x21\xdf\xce\xaa\x88"
+	"\x44\x30\x1e\xce\x26\x01\x92\xf8"
+	"\x9f\x00\x4b\x0c\x4b\xf7\x5f\xe0"
+	"\x89\xca\x94\x66\x11\x21\x97\xca"
+	"\x3e\x83\x74\x2d\xdb\x4d\x11\xeb"
+	"\x97\xc2\x14\xff\x9e\x1e\xa0\x6b"
+	"\x08\xb4\x31\x2b\x85\xc6\x85\x6c"
+	"\x90\xec\x39\xc0\xec\xb3\xb5\x4e"
+	"\xf3\x9c\xe7\x83\x3a\x77\x0a\xf4"
+	"\x56\xfe\xce\x18\x33\x6d\x0b\x2d"
+	"\x33\xda\xc8\x05\x5c\xb4\x09\x2a"
+	"\xde\x6b\x52\x98\x01\xef\x36\x3d"
+	"\xbd\xf9\x8f\xa8\x3e\xaa\xcd\xd1"
+	"\x01\x2d\x42\x49\xc3\xb6\x84\xbb"
+	"\x48\x96\xe0\x90\x93\x6c\x48\x64"
+	"\xd4\xfa\x7f\x93\x2c\xa6\x21\xc8"
+	"\x7a\x23\x7b\xaa\x20\x56\x12\xae"
+	"\x16\x9d\x94\x0f\x54\xa1\xec\xca"
+	"\x51\x4e\xf2\x39\xf4\xf8\x5f\x04"
+	"\x5a\x0d\xbf\xf5\x83\xa1\x15\xe1"
+	"\xf5\x3c\xd8\x62\xa3\xed\x47\x89"
+	"\x85\x4c\xe5\xdb\xac\x9e\x17\x1d"
+	"\x0c\x09\xe3\x3e\x39\x5b\x4d\x74"
+	"\x0e\xf5\x34\xee\x70\x11\x4c\xfd"
+	"\xdb\x34\xb1\xb5\x10\x3f\x73\xb7"
+	"\xf5\xfa\xed\xb0\x1f\xa5\xcd\x3c"
+	"\x8d\x35\x83\xd4\x11\x44\x6e\x6c"
+	"\x5b\xe0\x0e\x69\xa5\x39\xe5\xbb"
+	"\xa9\x57\x24\x37\xe6\x1f\xdd\xcf"
+	"\x16\x2a\x13\xf9\x6a\x2d\x90\xa0"
+	"\x03\x60\x7a\xed\x69\xd5\x00\x8b"
+	"\x7e\x4f\xcb\xb9\xfa\x91\xb9\x37"
+	"\xc1\x26\xce\x90\x97\x22\x64\x64"
+	"\xc1\x72\x43\x1b\xf6\xac\xc1\x54"
+	"\x8a\x10\x9c\xdd\x8d\xd5\x8e\xb2"
+	"\xe4\x85\xda\xe0\x20\x5f\xf4\xb4"
+	"\x15\xb5\xa0\x8d\x12\x74\x49\x23"
+	"\x3a\xdf\x4a\xd3\xf0\x3b\x89\xeb"
+	"\xf8\xcc\x62\x7b\xfb\x93\x07\x41"
+	"\x61\x26\x94\x58\x70\xa6\x3c\xe4"
+	"\xff\x58\xc4\x13\x3d\xcb\x36\x6b"
+	"\x32\xe5\xb2\x6d\x03\x74\x6f\x76"
+	"\x93\x77\xde\x48\xc4\xfa\x30\x4a"
+	"\xda\x49\x80\x77\x0f\x1c\xbe\x11"
+	"\xc8\x48\xb1\xe5\xbb\xf2\x8a\xe1"
+	"\x96\x2f\x9f\xd1\x8e\x8a\x5c\xe2"
+	"\xf7\xd7\xd8\x54\xf3\x3f\xc4\x91"
+	"\xb8\xfb\x86\xdc\x46\x24\x91\x60"
+	"\x6c\x2f\xc9\x41\x37\x51\x49\x54"
+	"\x09\x81\x21\xf3\x03\x9f\x2b\xe3"
+	"\x1f\x39\x63\xaf\xf4\xd7\x53\x60"
+	"\xa7\xc7\x54\xf9\xee\xb1\xb1\x7d"
+	"\x75\x54\x65\x93\xfe\xb1\x68\x6b"
+	"\x57\x02\xf9\xbb\x0e\xf9\xf8\xbf"
+	"\x01\x12\x27\xb4\xfe\xe4\x79\x7a"
+	"\x40\x5b\x51\x4b\xdf\x38\xec\xb1"
+	"\x6a\x56\xff\x35\x4d\x42\x33\xaa"
+	"\x6f\x1b\xe4\xdc\xe0\xdb\x85\x35"
+	"\x62\x10\xd4\xec\xeb\xc5\x7e\x45"
+	"\x1c\x6f\x17\xca\x3b\x8e\x2d\x66"
+	"\x4f\x4b\x36\x56\xcd\x1b\x59\xaa"
+	"\xd2\x9b\x17\xb9\x58\xdf\x7b\x64"
+	"\x8a\xff\x3b\x9c\xa6\xb5\x48\x9e"
+	"\xaa\xe2\x5d\x09\x71\x32\x5f\xb6"
+	"\x29\xbe\xe7\xc7\x52\x7e\x91\x82"
+	"\x6b\x6d\x33\xe1\x34\x06\x36\x21"
+	"\x5e\xbe\x1e\x2f\x3e\xc1\xfb\xea"
+	"\x49\x2c\xb5\xca\xf7\xb0\x37\xea"
+	"\x1f\xed\x10\x04\xd9\x48\x0d\x1a"
+	"\x1c\xfb\xe7\x84\x0e\x83\x53\x74"
+	"\xc7\x65\xe2\x5c\xe5\xba\x73\x4c"
+	"\x0e\xe1\xb5\x11\x45\x61\x43\x46"
+	"\xaa\x25\x8f\xbd\x85\x08\xfa\x4c"
+	"\x15\xc1\xc0\xd8\xf5\xdc\x16\xbb"
+	"\x7b\x1d\xe3\x87\x57\xa7\x2a\x1d"
+	"\x38\x58\x9e\x8a\x43\xdc\x57"
+	"\xd1\x81\x7d\x2b\xe9\xff\x99\x3a"
+	"\x4b\x24\x52\x58\x55\xe1\x49\x14";
+
+static struct {
+	const u8	*ptext;
+	const u8	*ctext;
+
+	u8		key[AES_MAX_KEY_SIZE];
+	u8		iv[GCM_AES_IV_SIZE];
+	u8		assoc[20];
+
+	int		klen;
+	int		clen;
+	int		plen;
+	int		alen;
+} const gcmaes_tv[] __initconst = {
+	{ /* From McGrew & Viega - http://citeseer.ist.psu.edu/656989.html */
+		.klen	= 16,
+		.ctext	= ctext0,
+		.clen	= sizeof(ctext0),
+	}, {
+		.klen	= 16,
+		.ptext	= ptext1,
+		.plen	= sizeof(ptext1),
+		.ctext	= ctext1,
+		.clen	= sizeof(ctext1),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08",
+		.klen	= 16,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext2,
+		.plen	= sizeof(ptext2),
+		.ctext	= ctext2,
+		.clen	= sizeof(ctext2),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08",
+		.klen	= 16,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext3,
+		.plen	= sizeof(ptext3),
+		.assoc	= "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xab\xad\xda\xd2",
+		.alen	= 20,
+		.ctext	= ctext3,
+		.clen	= sizeof(ctext3),
+	}, {
+		.klen	= 24,
+		.ctext	= ctext4,
+		.clen	= sizeof(ctext4),
+	}, {
+		.klen	= 24,
+		.ptext	= ptext1,
+		.plen	= sizeof(ptext1),
+		.ctext	= ctext5,
+		.clen	= sizeof(ctext5),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08"
+			  "\xfe\xff\xe9\x92\x86\x65\x73\x1c",
+		.klen	= 24,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext6,
+		.plen	= sizeof(ptext6),
+		.ctext	= ctext6,
+		.clen	= sizeof(ctext6),
+	}, {
+		.klen	= 32,
+		.ctext	= ctext7,
+		.clen	= sizeof(ctext7),
+	}, {
+		.klen	= 32,
+		.ptext	= ptext1,
+		.plen	= sizeof(ptext1),
+		.ctext	= ctext8,
+		.clen	= sizeof(ctext8),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08"
+			  "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08",
+		.klen	= 32,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext9,
+		.plen	= sizeof(ptext9),
+		.ctext	= ctext9,
+		.clen	= sizeof(ctext9),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08"
+			  "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08",
+		.klen	= 32,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext10,
+		.plen	= sizeof(ptext10),
+		.assoc	= "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xab\xad\xda\xd2",
+		.alen	= 20,
+		.ctext	= ctext10,
+		.clen	= sizeof(ctext10),
+	}, {
+		.key	= "\xfe\xff\xe9\x92\x86\x65\x73\x1c"
+			  "\x6d\x6a\x8f\x94\x67\x30\x83\x08"
+			  "\xfe\xff\xe9\x92\x86\x65\x73\x1c",
+		.klen	= 24,
+		.iv	= "\xca\xfe\xba\xbe\xfa\xce\xdb\xad"
+			  "\xde\xca\xf8\x88",
+		.ptext	= ptext11,
+		.plen	= sizeof(ptext11),
+		.assoc	= "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xfe\xed\xfa\xce\xde\xad\xbe\xef"
+			  "\xab\xad\xda\xd2",
+		.alen	= 20,
+		.ctext	= ctext11,
+		.clen	= sizeof(ctext11),
+	}, {
+		.key	= "\x62\x35\xf8\x95\xfc\xa5\xeb\xf6"
+			  "\x0e\x92\x12\x04\xd3\xa1\x3f\x2e"
+			  "\x8b\x32\xcf\xe7\x44\xed\x13\x59"
+			  "\x04\x38\x77\xb0\xb9\xad\xb4\x38",
+		.klen	= 32,
+		.iv	= "\x00\xff\xff\xff\xff\x00\x00\xff"
+			  "\xff\xff\x00\xff",
+		.ptext	= ptext12,
+		.plen	= sizeof(ptext12),
+		.ctext	= ctext12,
+		.clen	= sizeof(ctext12),
+	}
+};
+
+static int __init libgcmaes_init(void)
+{
+	for (int i = 0; i < ARRAY_SIZE(gcmaes_tv); i++) {
+		u8 tagbuf[AES_BLOCK_SIZE];
+		int plen = gcmaes_tv[i].plen;
+		struct gcmaes_ctx ctx;
+		u8 buf[sizeof(ptext12)];
+
+		if (gcmaes_expandkey(&ctx, gcmaes_tv[i].key, gcmaes_tv[i].klen,
+				     gcmaes_tv[i].clen - plen)) {
+			WARN(1, "gcmaes_expandkey() failed on vector %d\n", i);
+			return -EINVAL;
+		}
+
+		if (gcmaes_decrypt(&ctx, buf, gcmaes_tv[i].ctext, plen,
+				   gcmaes_tv[i].assoc, gcmaes_tv[i].alen,
+				   gcmaes_tv[i].iv, gcmaes_tv[i].ctext + plen)
+		    || memcmp(buf, gcmaes_tv[i].ptext, plen)) {
+			WARN(1, "gcmaes_decrypt() #1 failed on vector %d\n", i);
+			return -EINVAL;
+		}
+
+		/* encrypt in place */
+		gcmaes_encrypt(&ctx, buf, buf, plen, gcmaes_tv[i].assoc,
+			       gcmaes_tv[i].alen, gcmaes_tv[i].iv, tagbuf);
+		if (memcmp(buf, gcmaes_tv[i].ctext, plen)) {
+			WARN(1, "gcmaes_encrypt() failed on vector %d\n", i);
+			return -EINVAL;
+		}
+
+		/* decrypt in place */
+		if (gcmaes_decrypt(&ctx, buf, buf, plen, gcmaes_tv[i].assoc,
+				   gcmaes_tv[i].alen, gcmaes_tv[i].iv, tagbuf)
+		    || memcmp(buf, gcmaes_tv[i].ptext, plen)) {
+			WARN(1, "gcmaes_decrypt() #2 failed on vector %d\n", i);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+module_init(libgcmaes_init);
+
+static void __exit libgcmaes_exit(void)
+{
+}
+module_exit(libgcmaes_exit);
+#endif
-- 
2.35.1

