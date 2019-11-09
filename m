Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B655F6079
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 18:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKIRLc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 Nov 2019 12:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfKIRLb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 Nov 2019 12:11:31 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F85E20869;
        Sat,  9 Nov 2019 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319490;
        bh=pqPANP9aWEokb1Lp2tjBoe77vRyc0xVhhzXoUdCPhRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpnfoXslHmQrM31G/+VpGvsPLtY6p5gMq/uCDyj/Ir38GkaImPrnuJApjog7QJngq
         A3JZLRakBK4sO87HPBxVOVOaehhXVU6eWWWur1DIuh2DpNGgfLz4XnQUrw5t3oLy4e
         sxaSKvMPVnjGGmD9DFr15WL8VVrkciYmLoY3zijk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 22/29] crypto: niagara2 - switch to skcipher API
Date:   Sat,  9 Nov 2019 18:09:47 +0100
Message-Id: <20191109170954.756-23-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109170954.756-1-ardb@kernel.org>
References: <20191109170954.756-1-ardb@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Commit 7a7ffe65c8c5 ("crypto: skcipher - Add top-level skcipher interface")
dated 20 august 2015 introduced the new skcipher API which is supposed to
replace both blkcipher and ablkcipher. While all consumers of the API have
been converted long ago, some producers of the ablkcipher remain, forcing
us to keep the ablkcipher support routines alive, along with the matching
code to expose [a]blkciphers via the skcipher API.

So switch this driver to the skcipher API, allowing us to finally drop the
ablkcipher code in the near future.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/n2_core.c | 194 ++++++++++----------
 1 file changed, 96 insertions(+), 98 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index dc15b06e96ab..e040912f790e 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 
 #include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/algapi.h>
 
@@ -657,7 +658,7 @@ static int n2_hmac_async_digest(struct ahash_request *req)
 				  ctx->hash_key_len);
 }
 
-struct n2_cipher_context {
+struct n2_skcipher_context {
 	int			key_len;
 	int			enc_type;
 	union {
@@ -683,7 +684,7 @@ struct n2_crypto_chunk {
 };
 
 struct n2_request_context {
-	struct ablkcipher_walk	walk;
+	struct skcipher_walk	walk;
 	struct list_head	chunk_list;
 	struct n2_crypto_chunk	chunk;
 	u8			temp_iv[16];
@@ -708,29 +709,29 @@ struct n2_request_context {
  * is not a valid sequence.
  */
 
-struct n2_cipher_alg {
+struct n2_skcipher_alg {
 	struct list_head	entry;
 	u8			enc_type;
-	struct crypto_alg	alg;
+	struct skcipher_alg	skcipher;
 };
 
-static inline struct n2_cipher_alg *n2_cipher_alg(struct crypto_tfm *tfm)
+static inline struct n2_skcipher_alg *n2_skcipher_alg(struct crypto_skcipher *tfm)
 {
-	struct crypto_alg *alg = tfm->__crt_alg;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 
-	return container_of(alg, struct n2_cipher_alg, alg);
+	return container_of(alg, struct n2_skcipher_alg, skcipher);
 }
 
-struct n2_cipher_request_context {
-	struct ablkcipher_walk	walk;
+struct n2_skcipher_request_context {
+	struct skcipher_walk	walk;
 };
 
-static int n2_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+static int n2_aes_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			 unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct n2_cipher_context *ctx = crypto_tfm_ctx(tfm);
-	struct n2_cipher_alg *n2alg = n2_cipher_alg(tfm);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
+	struct n2_skcipher_context *ctx = crypto_tfm_ctx(tfm);
+	struct n2_skcipher_alg *n2alg = n2_skcipher_alg(skcipher);
 
 	ctx->enc_type = (n2alg->enc_type & ENC_TYPE_CHAINING_MASK);
 
@@ -745,7 +746,7 @@ static int n2_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 		ctx->enc_type |= ENC_TYPE_ALG_AES256;
 		break;
 	default:
-		crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		crypto_skcipher_set_flags(skcipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
 		return -EINVAL;
 	}
 
@@ -754,15 +755,15 @@ static int n2_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 	return 0;
 }
 
-static int n2_des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+static int n2_des_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			 unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct n2_cipher_context *ctx = crypto_tfm_ctx(tfm);
-	struct n2_cipher_alg *n2alg = n2_cipher_alg(tfm);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
+	struct n2_skcipher_context *ctx = crypto_tfm_ctx(tfm);
+	struct n2_skcipher_alg *n2alg = n2_skcipher_alg(skcipher);
 	int err;
 
-	err = verify_ablkcipher_des_key(cipher, key);
+	err = verify_skcipher_des_key(skcipher, key);
 	if (err)
 		return err;
 
@@ -773,15 +774,15 @@ static int n2_des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 	return 0;
 }
 
-static int n2_3des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+static int n2_3des_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			  unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct n2_cipher_context *ctx = crypto_tfm_ctx(tfm);
-	struct n2_cipher_alg *n2alg = n2_cipher_alg(tfm);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
+	struct n2_skcipher_context *ctx = crypto_tfm_ctx(tfm);
+	struct n2_skcipher_alg *n2alg = n2_skcipher_alg(skcipher);
 	int err;
 
-	err = verify_ablkcipher_des3_key(cipher, key);
+	err = verify_skcipher_des3_key(skcipher, key);
 	if (err)
 		return err;
 
@@ -792,12 +793,12 @@ static int n2_3des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 	return 0;
 }
 
-static int n2_arc4_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+static int n2_arc4_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			  unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct n2_cipher_context *ctx = crypto_tfm_ctx(tfm);
-	struct n2_cipher_alg *n2alg = n2_cipher_alg(tfm);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
+	struct n2_skcipher_context *ctx = crypto_tfm_ctx(tfm);
+	struct n2_skcipher_alg *n2alg = n2_skcipher_alg(skcipher);
 	u8 *s = ctx->key.arc4;
 	u8 *x = s + 256;
 	u8 *y = x + 1;
@@ -822,7 +823,7 @@ static int n2_arc4_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 	return 0;
 }
 
-static inline int cipher_descriptor_len(int nbytes, unsigned int block_size)
+static inline int skcipher_descriptor_len(int nbytes, unsigned int block_size)
 {
 	int this_len = nbytes;
 
@@ -830,10 +831,11 @@ static inline int cipher_descriptor_len(int nbytes, unsigned int block_size)
 	return this_len > (1 << 16) ? (1 << 16) : this_len;
 }
 
-static int __n2_crypt_chunk(struct crypto_tfm *tfm, struct n2_crypto_chunk *cp,
+static int __n2_crypt_chunk(struct crypto_skcipher *skcipher,
+			    struct n2_crypto_chunk *cp,
 			    struct spu_queue *qp, bool encrypt)
 {
-	struct n2_cipher_context *ctx = crypto_tfm_ctx(tfm);
+	struct n2_skcipher_context *ctx = crypto_skcipher_ctx(skcipher);
 	struct cwq_initial_entry *ent;
 	bool in_place;
 	int i;
@@ -877,18 +879,17 @@ static int __n2_crypt_chunk(struct crypto_tfm *tfm, struct n2_crypto_chunk *cp,
 	return (spu_queue_submit(qp, ent) != HV_EOK) ? -EINVAL : 0;
 }
 
-static int n2_compute_chunks(struct ablkcipher_request *req)
+static int n2_compute_chunks(struct skcipher_request *req)
 {
-	struct n2_request_context *rctx = ablkcipher_request_ctx(req);
-	struct ablkcipher_walk *walk = &rctx->walk;
+	struct n2_request_context *rctx = skcipher_request_ctx(req);
+	struct skcipher_walk *walk = &rctx->walk;
 	struct n2_crypto_chunk *chunk;
 	unsigned long dest_prev;
 	unsigned int tot_len;
 	bool prev_in_place;
 	int err, nbytes;
 
-	ablkcipher_walk_init(walk, req->dst, req->src, req->nbytes);
-	err = ablkcipher_walk_phys(req, walk);
+	err = skcipher_walk_async(walk, req);
 	if (err)
 		return err;
 
@@ -910,12 +911,12 @@ static int n2_compute_chunks(struct ablkcipher_request *req)
 		bool in_place;
 		int this_len;
 
-		src_paddr = (page_to_phys(walk->src.page) +
-			     walk->src.offset);
-		dest_paddr = (page_to_phys(walk->dst.page) +
-			      walk->dst.offset);
+		src_paddr = (page_to_phys(walk->src.phys.page) +
+			     walk->src.phys.offset);
+		dest_paddr = (page_to_phys(walk->dst.phys.page) +
+			      walk->dst.phys.offset);
 		in_place = (src_paddr == dest_paddr);
-		this_len = cipher_descriptor_len(nbytes, walk->blocksize);
+		this_len = skcipher_descriptor_len(nbytes, walk->blocksize);
 
 		if (chunk->arr_len != 0) {
 			if (in_place != prev_in_place ||
@@ -946,7 +947,7 @@ static int n2_compute_chunks(struct ablkcipher_request *req)
 		prev_in_place = in_place;
 		tot_len += this_len;
 
-		err = ablkcipher_walk_done(req, walk, nbytes - this_len);
+		err = skcipher_walk_done(walk, nbytes - this_len);
 		if (err)
 			break;
 	}
@@ -958,15 +959,14 @@ static int n2_compute_chunks(struct ablkcipher_request *req)
 	return err;
 }
 
-static void n2_chunk_complete(struct ablkcipher_request *req, void *final_iv)
+static void n2_chunk_complete(struct skcipher_request *req, void *final_iv)
 {
-	struct n2_request_context *rctx = ablkcipher_request_ctx(req);
+	struct n2_request_context *rctx = skcipher_request_ctx(req);
 	struct n2_crypto_chunk *c, *tmp;
 
 	if (final_iv)
 		memcpy(rctx->walk.iv, final_iv, rctx->walk.blocksize);
 
-	ablkcipher_walk_complete(&rctx->walk);
 	list_for_each_entry_safe(c, tmp, &rctx->chunk_list, entry) {
 		list_del(&c->entry);
 		if (unlikely(c != &rctx->chunk))
@@ -975,10 +975,10 @@ static void n2_chunk_complete(struct ablkcipher_request *req, void *final_iv)
 
 }
 
-static int n2_do_ecb(struct ablkcipher_request *req, bool encrypt)
+static int n2_do_ecb(struct skcipher_request *req, bool encrypt)
 {
-	struct n2_request_context *rctx = ablkcipher_request_ctx(req);
-	struct crypto_tfm *tfm = req->base.tfm;
+	struct n2_request_context *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	int err = n2_compute_chunks(req);
 	struct n2_crypto_chunk *c, *tmp;
 	unsigned long flags, hv_ret;
@@ -1017,20 +1017,20 @@ static int n2_do_ecb(struct ablkcipher_request *req, bool encrypt)
 	return err;
 }
 
-static int n2_encrypt_ecb(struct ablkcipher_request *req)
+static int n2_encrypt_ecb(struct skcipher_request *req)
 {
 	return n2_do_ecb(req, true);
 }
 
-static int n2_decrypt_ecb(struct ablkcipher_request *req)
+static int n2_decrypt_ecb(struct skcipher_request *req)
 {
 	return n2_do_ecb(req, false);
 }
 
-static int n2_do_chaining(struct ablkcipher_request *req, bool encrypt)
+static int n2_do_chaining(struct skcipher_request *req, bool encrypt)
 {
-	struct n2_request_context *rctx = ablkcipher_request_ctx(req);
-	struct crypto_tfm *tfm = req->base.tfm;
+	struct n2_request_context *rctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	unsigned long flags, hv_ret, iv_paddr;
 	int err = n2_compute_chunks(req);
 	struct n2_crypto_chunk *c, *tmp;
@@ -1107,32 +1107,32 @@ static int n2_do_chaining(struct ablkcipher_request *req, bool encrypt)
 	return err;
 }
 
-static int n2_encrypt_chaining(struct ablkcipher_request *req)
+static int n2_encrypt_chaining(struct skcipher_request *req)
 {
 	return n2_do_chaining(req, true);
 }
 
-static int n2_decrypt_chaining(struct ablkcipher_request *req)
+static int n2_decrypt_chaining(struct skcipher_request *req)
 {
 	return n2_do_chaining(req, false);
 }
 
-struct n2_cipher_tmpl {
+struct n2_skcipher_tmpl {
 	const char		*name;
 	const char		*drv_name;
 	u8			block_size;
 	u8			enc_type;
-	struct ablkcipher_alg	ablkcipher;
+	struct skcipher_alg	skcipher;
 };
 
-static const struct n2_cipher_tmpl cipher_tmpls[] = {
+static const struct n2_skcipher_tmpl skcipher_tmpls[] = {
 	/* ARC4: only ECB is supported (chaining bits ignored) */
 	{	.name		= "ecb(arc4)",
 		.drv_name	= "ecb-arc4",
 		.block_size	= 1,
 		.enc_type	= (ENC_TYPE_ALG_RC4_STREAM |
 				   ENC_TYPE_CHAINING_ECB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= 1,
 			.max_keysize	= 256,
 			.setkey		= n2_arc4_setkey,
@@ -1147,7 +1147,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_DES |
 				   ENC_TYPE_CHAINING_ECB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= DES_KEY_SIZE,
 			.max_keysize	= DES_KEY_SIZE,
 			.setkey		= n2_des_setkey,
@@ -1160,7 +1160,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_DES |
 				   ENC_TYPE_CHAINING_CBC),
-		.ablkcipher	= {
+		.skcipher	= {
 			.ivsize		= DES_BLOCK_SIZE,
 			.min_keysize	= DES_KEY_SIZE,
 			.max_keysize	= DES_KEY_SIZE,
@@ -1174,7 +1174,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_DES |
 				   ENC_TYPE_CHAINING_CFB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= DES_KEY_SIZE,
 			.max_keysize	= DES_KEY_SIZE,
 			.setkey		= n2_des_setkey,
@@ -1189,7 +1189,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_3DES |
 				   ENC_TYPE_CHAINING_ECB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= 3 * DES_KEY_SIZE,
 			.max_keysize	= 3 * DES_KEY_SIZE,
 			.setkey		= n2_3des_setkey,
@@ -1202,7 +1202,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_3DES |
 				   ENC_TYPE_CHAINING_CBC),
-		.ablkcipher	= {
+		.skcipher	= {
 			.ivsize		= DES_BLOCK_SIZE,
 			.min_keysize	= 3 * DES_KEY_SIZE,
 			.max_keysize	= 3 * DES_KEY_SIZE,
@@ -1216,7 +1216,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= DES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_3DES |
 				   ENC_TYPE_CHAINING_CFB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= 3 * DES_KEY_SIZE,
 			.max_keysize	= 3 * DES_KEY_SIZE,
 			.setkey		= n2_3des_setkey,
@@ -1230,7 +1230,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= AES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_AES128 |
 				   ENC_TYPE_CHAINING_ECB),
-		.ablkcipher	= {
+		.skcipher	= {
 			.min_keysize	= AES_MIN_KEY_SIZE,
 			.max_keysize	= AES_MAX_KEY_SIZE,
 			.setkey		= n2_aes_setkey,
@@ -1243,7 +1243,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= AES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_AES128 |
 				   ENC_TYPE_CHAINING_CBC),
-		.ablkcipher	= {
+		.skcipher	= {
 			.ivsize		= AES_BLOCK_SIZE,
 			.min_keysize	= AES_MIN_KEY_SIZE,
 			.max_keysize	= AES_MAX_KEY_SIZE,
@@ -1257,7 +1257,7 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 		.block_size	= AES_BLOCK_SIZE,
 		.enc_type	= (ENC_TYPE_ALG_AES128 |
 				   ENC_TYPE_CHAINING_COUNTER),
-		.ablkcipher	= {
+		.skcipher	= {
 			.ivsize		= AES_BLOCK_SIZE,
 			.min_keysize	= AES_MIN_KEY_SIZE,
 			.max_keysize	= AES_MAX_KEY_SIZE,
@@ -1268,9 +1268,9 @@ static const struct n2_cipher_tmpl cipher_tmpls[] = {
 	},
 
 };
-#define NUM_CIPHER_TMPLS ARRAY_SIZE(cipher_tmpls)
+#define NUM_CIPHER_TMPLS ARRAY_SIZE(skcipher_tmpls)
 
-static LIST_HEAD(cipher_algs);
+static LIST_HEAD(skcipher_algs);
 
 struct n2_hash_tmpl {
 	const char	*name;
@@ -1344,14 +1344,14 @@ static int algs_registered;
 
 static void __n2_unregister_algs(void)
 {
-	struct n2_cipher_alg *cipher, *cipher_tmp;
+	struct n2_skcipher_alg *skcipher, *skcipher_tmp;
 	struct n2_ahash_alg *alg, *alg_tmp;
 	struct n2_hmac_alg *hmac, *hmac_tmp;
 
-	list_for_each_entry_safe(cipher, cipher_tmp, &cipher_algs, entry) {
-		crypto_unregister_alg(&cipher->alg);
-		list_del(&cipher->entry);
-		kfree(cipher);
+	list_for_each_entry_safe(skcipher, skcipher_tmp, &skcipher_algs, entry) {
+		crypto_unregister_skcipher(&skcipher->skcipher);
+		list_del(&skcipher->entry);
+		kfree(skcipher);
 	}
 	list_for_each_entry_safe(hmac, hmac_tmp, &hmac_algs, derived.entry) {
 		crypto_unregister_ahash(&hmac->derived.alg);
@@ -1365,44 +1365,42 @@ static void __n2_unregister_algs(void)
 	}
 }
 
-static int n2_cipher_cra_init(struct crypto_tfm *tfm)
+static int n2_skcipher_init_tfm(struct crypto_skcipher *tfm)
 {
-	tfm->crt_ablkcipher.reqsize = sizeof(struct n2_request_context);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct n2_request_context));
 	return 0;
 }
 
-static int __n2_register_one_cipher(const struct n2_cipher_tmpl *tmpl)
+static int __n2_register_one_skcipher(const struct n2_skcipher_tmpl *tmpl)
 {
-	struct n2_cipher_alg *p = kzalloc(sizeof(*p), GFP_KERNEL);
-	struct crypto_alg *alg;
+	struct n2_skcipher_alg *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	struct skcipher_alg *alg;
 	int err;
 
 	if (!p)
 		return -ENOMEM;
 
-	alg = &p->alg;
+	alg = &p->skcipher;
+	*alg = tmpl->skcipher;
 
-	snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s", tmpl->name);
-	snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s-n2", tmpl->drv_name);
-	alg->cra_priority = N2_CRA_PRIORITY;
-	alg->cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER |
-			 CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC;
-	alg->cra_blocksize = tmpl->block_size;
+	snprintf(alg->base.cra_name, CRYPTO_MAX_ALG_NAME, "%s", tmpl->name);
+	snprintf(alg->base.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s-n2", tmpl->drv_name);
+	alg->base.cra_priority = N2_CRA_PRIORITY;
+	alg->base.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC;
+	alg->base.cra_blocksize = tmpl->block_size;
 	p->enc_type = tmpl->enc_type;
-	alg->cra_ctxsize = sizeof(struct n2_cipher_context);
-	alg->cra_type = &crypto_ablkcipher_type;
-	alg->cra_u.ablkcipher = tmpl->ablkcipher;
-	alg->cra_init = n2_cipher_cra_init;
-	alg->cra_module = THIS_MODULE;
-
-	list_add(&p->entry, &cipher_algs);
-	err = crypto_register_alg(alg);
+	alg->base.cra_ctxsize = sizeof(struct n2_skcipher_context);
+	alg->base.cra_module = THIS_MODULE;
+	alg->init = n2_skcipher_init_tfm;
+
+	list_add(&p->entry, &skcipher_algs);
+	err = crypto_register_skcipher(alg);
 	if (err) {
-		pr_err("%s alg registration failed\n", alg->cra_name);
+		pr_err("%s alg registration failed\n", alg->base.cra_name);
 		list_del(&p->entry);
 		kfree(p);
 	} else {
-		pr_info("%s alg registered\n", alg->cra_name);
+		pr_info("%s alg registered\n", alg->base.cra_name);
 	}
 	return err;
 }
@@ -1517,7 +1515,7 @@ static int n2_register_algs(void)
 		}
 	}
 	for (i = 0; i < NUM_CIPHER_TMPLS; i++) {
-		err = __n2_register_one_cipher(&cipher_tmpls[i]);
+		err = __n2_register_one_skcipher(&skcipher_tmpls[i]);
 		if (err) {
 			__n2_unregister_algs();
 			goto out;
-- 
2.17.1

