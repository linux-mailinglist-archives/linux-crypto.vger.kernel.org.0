Return-Path: <linux-crypto+bounces-428-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94617FEF6B
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084EF1C20AEE
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF147780
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60319F
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:28:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g9T-005IQo-PV; Thu, 30 Nov 2023 20:28:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:28:28 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:28:28 +0800
Subject: [PATCH 19/19] crypto: cfb,ofb - Remove cfb and ofb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g9T-005IQo-PV@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused algorithms CFB/OFB.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/Kconfig  |   23 -----
 crypto/Makefile |    2 
 crypto/cfb.c    |  254 --------------------------------------------------------
 crypto/ofb.c    |  106 -----------------------
 4 files changed, 385 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 70661f58ee41..7d156c75f15f 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -661,15 +661,6 @@ config CRYPTO_CBC
 
 	  This block cipher mode is required for IPSec ESP (XFRM_ESP).
 
-config CRYPTO_CFB
-	tristate "CFB (Cipher Feedback)"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	help
-	  CFB (Cipher Feedback) mode (NIST SP800-38A)
-
-	  This block cipher mode is required for TPM2 Cryptography.
-
 config CRYPTO_CTR
 	tristate "CTR (Counter)"
 	select CRYPTO_SKCIPHER
@@ -735,20 +726,6 @@ config CRYPTO_LRW
 
 	  See https://people.csail.mit.edu/rivest/pubs/LRW02.pdf
 
-config CRYPTO_OFB
-	tristate "OFB (Output Feedback)"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	help
-	  OFB (Output Feedback) mode (NIST SP800-38A)
-
-	  This mode makes a block cipher into a synchronous
-	  stream cipher. It generates keystream blocks, which are then XORed
-	  with the plaintext blocks to get the ciphertext. Flipping a bit in the
-	  ciphertext produces a flipped bit in the plaintext at the same
-	  location. This property allows many error correcting codes to function
-	  normally even when applied before encryption.
-
 config CRYPTO_PCBC
 	tristate "PCBC (Propagating Cipher Block Chaining)"
 	select CRYPTO_SKCIPHER
diff --git a/crypto/Makefile b/crypto/Makefile
index 5ac6876f935a..408f0a1f9ab9 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -92,7 +92,6 @@ obj-$(CONFIG_CRYPTO_BLAKE2B) += blake2b_generic.o
 CFLAGS_blake2b_generic.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105930
 obj-$(CONFIG_CRYPTO_ECB) += ecb.o
 obj-$(CONFIG_CRYPTO_CBC) += cbc.o
-obj-$(CONFIG_CRYPTO_CFB) += cfb.o
 obj-$(CONFIG_CRYPTO_PCBC) += pcbc.o
 obj-$(CONFIG_CRYPTO_CTS) += cts.o
 obj-$(CONFIG_CRYPTO_LRW) += lrw.o
@@ -186,7 +185,6 @@ obj-$(CONFIG_CRYPTO_USER_API_SKCIPHER) += algif_skcipher.o
 obj-$(CONFIG_CRYPTO_USER_API_RNG) += algif_rng.o
 obj-$(CONFIG_CRYPTO_USER_API_AEAD) += algif_aead.o
 obj-$(CONFIG_CRYPTO_ZSTD) += zstd.o
-obj-$(CONFIG_CRYPTO_OFB) += ofb.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
 obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 obj-$(CONFIG_CRYPTO_CURVE25519) += curve25519-generic.o
diff --git a/crypto/cfb.c b/crypto/cfb.c
deleted file mode 100644
index 5c36b7b65e2a..000000000000
--- a/crypto/cfb.c
+++ /dev/null
@@ -1,254 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * CFB: Cipher FeedBack mode
- *
- * Copyright (c) 2018 James.Bottomley@HansenPartnership.com
- *
- * CFB is a stream cipher mode which is layered on to a block
- * encryption scheme.  It works very much like a one time pad where
- * the pad is generated initially from the encrypted IV and then
- * subsequently from the encrypted previous block of ciphertext.  The
- * pad is XOR'd into the plain text to get the final ciphertext.
- *
- * The scheme of CFB is best described by wikipedia:
- *
- * https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#CFB
- *
- * Note that since the pad for both encryption and decryption is
- * generated by an encryption operation, CFB never uses the block
- * decryption function.
- */
-
-#include <crypto/algapi.h>
-#include <crypto/internal/cipher.h>
-#include <crypto/internal/skcipher.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-
-static unsigned int crypto_cfb_bsize(struct crypto_skcipher *tfm)
-{
-	return crypto_cipher_blocksize(skcipher_cipher_simple(tfm));
-}
-
-static void crypto_cfb_encrypt_one(struct crypto_skcipher *tfm,
-					  const u8 *src, u8 *dst)
-{
-	crypto_cipher_encrypt_one(skcipher_cipher_simple(tfm), dst, src);
-}
-
-/* final encrypt and decrypt is the same */
-static void crypto_cfb_final(struct skcipher_walk *walk,
-			     struct crypto_skcipher *tfm)
-{
-	const unsigned long alignmask = crypto_skcipher_alignmask(tfm);
-	u8 tmp[MAX_CIPHER_BLOCKSIZE + MAX_CIPHER_ALIGNMASK];
-	u8 *stream = PTR_ALIGN(tmp + 0, alignmask + 1);
-	u8 *src = walk->src.virt.addr;
-	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
-	unsigned int nbytes = walk->nbytes;
-
-	crypto_cfb_encrypt_one(tfm, iv, stream);
-	crypto_xor_cpy(dst, stream, src, nbytes);
-}
-
-static int crypto_cfb_encrypt_segment(struct skcipher_walk *walk,
-				      struct crypto_skcipher *tfm)
-{
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
-	unsigned int nbytes = walk->nbytes;
-	u8 *src = walk->src.virt.addr;
-	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
-
-	do {
-		crypto_cfb_encrypt_one(tfm, iv, dst);
-		crypto_xor(dst, src, bsize);
-		iv = dst;
-
-		src += bsize;
-		dst += bsize;
-	} while ((nbytes -= bsize) >= bsize);
-
-	memcpy(walk->iv, iv, bsize);
-
-	return nbytes;
-}
-
-static int crypto_cfb_encrypt_inplace(struct skcipher_walk *walk,
-				      struct crypto_skcipher *tfm)
-{
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
-	unsigned int nbytes = walk->nbytes;
-	u8 *src = walk->src.virt.addr;
-	u8 *iv = walk->iv;
-	u8 tmp[MAX_CIPHER_BLOCKSIZE];
-
-	do {
-		crypto_cfb_encrypt_one(tfm, iv, tmp);
-		crypto_xor(src, tmp, bsize);
-		iv = src;
-
-		src += bsize;
-	} while ((nbytes -= bsize) >= bsize);
-
-	memcpy(walk->iv, iv, bsize);
-
-	return nbytes;
-}
-
-static int crypto_cfb_encrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct skcipher_walk walk;
-	unsigned int bsize = crypto_cfb_bsize(tfm);
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while (walk.nbytes >= bsize) {
-		if (walk.src.virt.addr == walk.dst.virt.addr)
-			err = crypto_cfb_encrypt_inplace(&walk, tfm);
-		else
-			err = crypto_cfb_encrypt_segment(&walk, tfm);
-		err = skcipher_walk_done(&walk, err);
-	}
-
-	if (walk.nbytes) {
-		crypto_cfb_final(&walk, tfm);
-		err = skcipher_walk_done(&walk, 0);
-	}
-
-	return err;
-}
-
-static int crypto_cfb_decrypt_segment(struct skcipher_walk *walk,
-				      struct crypto_skcipher *tfm)
-{
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
-	unsigned int nbytes = walk->nbytes;
-	u8 *src = walk->src.virt.addr;
-	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
-
-	do {
-		crypto_cfb_encrypt_one(tfm, iv, dst);
-		crypto_xor(dst, src, bsize);
-		iv = src;
-
-		src += bsize;
-		dst += bsize;
-	} while ((nbytes -= bsize) >= bsize);
-
-	memcpy(walk->iv, iv, bsize);
-
-	return nbytes;
-}
-
-static int crypto_cfb_decrypt_inplace(struct skcipher_walk *walk,
-				      struct crypto_skcipher *tfm)
-{
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
-	unsigned int nbytes = walk->nbytes;
-	u8 *src = walk->src.virt.addr;
-	u8 * const iv = walk->iv;
-	u8 tmp[MAX_CIPHER_BLOCKSIZE];
-
-	do {
-		crypto_cfb_encrypt_one(tfm, iv, tmp);
-		memcpy(iv, src, bsize);
-		crypto_xor(src, tmp, bsize);
-		src += bsize;
-	} while ((nbytes -= bsize) >= bsize);
-
-	return nbytes;
-}
-
-static int crypto_cfb_decrypt_blocks(struct skcipher_walk *walk,
-				     struct crypto_skcipher *tfm)
-{
-	if (walk->src.virt.addr == walk->dst.virt.addr)
-		return crypto_cfb_decrypt_inplace(walk, tfm);
-	else
-		return crypto_cfb_decrypt_segment(walk, tfm);
-}
-
-static int crypto_cfb_decrypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct skcipher_walk walk;
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while (walk.nbytes >= bsize) {
-		err = crypto_cfb_decrypt_blocks(&walk, tfm);
-		err = skcipher_walk_done(&walk, err);
-	}
-
-	if (walk.nbytes) {
-		crypto_cfb_final(&walk, tfm);
-		err = skcipher_walk_done(&walk, 0);
-	}
-
-	return err;
-}
-
-static int crypto_cfb_create(struct crypto_template *tmpl, struct rtattr **tb)
-{
-	struct skcipher_instance *inst;
-	struct crypto_alg *alg;
-	int err;
-
-	inst = skcipher_alloc_instance_simple(tmpl, tb);
-	if (IS_ERR(inst))
-		return PTR_ERR(inst);
-
-	alg = skcipher_ialg_simple(inst);
-
-	/* CFB mode is a stream cipher. */
-	inst->alg.base.cra_blocksize = 1;
-
-	/*
-	 * To simplify the implementation, configure the skcipher walk to only
-	 * give a partial block at the very end, never earlier.
-	 */
-	inst->alg.chunksize = alg->cra_blocksize;
-
-	inst->alg.encrypt = crypto_cfb_encrypt;
-	inst->alg.decrypt = crypto_cfb_decrypt;
-
-	err = skcipher_register_instance(tmpl, inst);
-	if (err)
-		inst->free(inst);
-
-	return err;
-}
-
-static struct crypto_template crypto_cfb_tmpl = {
-	.name = "cfb",
-	.create = crypto_cfb_create,
-	.module = THIS_MODULE,
-};
-
-static int __init crypto_cfb_module_init(void)
-{
-	return crypto_register_template(&crypto_cfb_tmpl);
-}
-
-static void __exit crypto_cfb_module_exit(void)
-{
-	crypto_unregister_template(&crypto_cfb_tmpl);
-}
-
-subsys_initcall(crypto_cfb_module_init);
-module_exit(crypto_cfb_module_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("CFB block cipher mode of operation");
-MODULE_ALIAS_CRYPTO("cfb");
-MODULE_IMPORT_NS(CRYPTO_INTERNAL);
diff --git a/crypto/ofb.c b/crypto/ofb.c
deleted file mode 100644
index b630fdecceee..000000000000
--- a/crypto/ofb.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * OFB: Output FeedBack mode
- *
- * Copyright (C) 2018 ARM Limited or its affiliates.
- * All rights reserved.
- */
-
-#include <crypto/algapi.h>
-#include <crypto/internal/cipher.h>
-#include <crypto/internal/skcipher.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-static int crypto_ofb_crypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct crypto_cipher *cipher = skcipher_cipher_simple(tfm);
-	const unsigned int bsize = crypto_cipher_blocksize(cipher);
-	struct skcipher_walk walk;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while (walk.nbytes >= bsize) {
-		const u8 *src = walk.src.virt.addr;
-		u8 *dst = walk.dst.virt.addr;
-		u8 * const iv = walk.iv;
-		unsigned int nbytes = walk.nbytes;
-
-		do {
-			crypto_cipher_encrypt_one(cipher, iv, iv);
-			crypto_xor_cpy(dst, src, iv, bsize);
-			dst += bsize;
-			src += bsize;
-		} while ((nbytes -= bsize) >= bsize);
-
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	if (walk.nbytes) {
-		crypto_cipher_encrypt_one(cipher, walk.iv, walk.iv);
-		crypto_xor_cpy(walk.dst.virt.addr, walk.src.virt.addr, walk.iv,
-			       walk.nbytes);
-		err = skcipher_walk_done(&walk, 0);
-	}
-	return err;
-}
-
-static int crypto_ofb_create(struct crypto_template *tmpl, struct rtattr **tb)
-{
-	struct skcipher_instance *inst;
-	struct crypto_alg *alg;
-	int err;
-
-	inst = skcipher_alloc_instance_simple(tmpl, tb);
-	if (IS_ERR(inst))
-		return PTR_ERR(inst);
-
-	alg = skcipher_ialg_simple(inst);
-
-	/* OFB mode is a stream cipher. */
-	inst->alg.base.cra_blocksize = 1;
-
-	/*
-	 * To simplify the implementation, configure the skcipher walk to only
-	 * give a partial block at the very end, never earlier.
-	 */
-	inst->alg.chunksize = alg->cra_blocksize;
-
-	inst->alg.encrypt = crypto_ofb_crypt;
-	inst->alg.decrypt = crypto_ofb_crypt;
-
-	err = skcipher_register_instance(tmpl, inst);
-	if (err)
-		inst->free(inst);
-
-	return err;
-}
-
-static struct crypto_template crypto_ofb_tmpl = {
-	.name = "ofb",
-	.create = crypto_ofb_create,
-	.module = THIS_MODULE,
-};
-
-static int __init crypto_ofb_module_init(void)
-{
-	return crypto_register_template(&crypto_ofb_tmpl);
-}
-
-static void __exit crypto_ofb_module_exit(void)
-{
-	crypto_unregister_template(&crypto_ofb_tmpl);
-}
-
-subsys_initcall(crypto_ofb_module_init);
-module_exit(crypto_ofb_module_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("OFB block cipher mode of operation");
-MODULE_ALIAS_CRYPTO("ofb");
-MODULE_IMPORT_NS(CRYPTO_INTERNAL);

