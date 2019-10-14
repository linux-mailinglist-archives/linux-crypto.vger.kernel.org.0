Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA8D624C
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfJNMUJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 08:20:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52065 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJNMUJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 08:20:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so17059485wme.1
        for <linux-crypto@vger.kernel.org>; Mon, 14 Oct 2019 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9ONpH+xPqMBLnk9lQxW1U32ZmnTEE1ClXk1NGpv4YU=;
        b=KphZqRM+628TGQmMgw1zCClGZG6p66qXVsBnv5F9GaGQLMwcIEwjuIM1TT3MqKFuzg
         CR2nKDf0aA4yaUtcpZjFdfs0meX/QUPdf91F20nFPletKGqNa04YczwykXyyCqAhLg5L
         RIfIaIijnEp1yg/ZTSdPwPY6cA7KQNia4gl7q0NvXLNt+CAU35aM7a0R/iOEHyKMFaVG
         FzgOnYasuFaQ6mbiZ99ok2yhQoERjyl+wyy8nCmhmdKQB8mOywrFrCwXXuVEUAE8+PvN
         G/88F9oBlIe2+LVs6bkMbCIQirQLKaVjba1CN9l9zwjnk2tCSHHjZ1ekAlsZd+yLMQBY
         ULsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9ONpH+xPqMBLnk9lQxW1U32ZmnTEE1ClXk1NGpv4YU=;
        b=E9uVn37d70yDGme08ooQLF7QpLC5+rE2akRysPT0sSWTGllZXC2nO7TAVyZyFKY6qn
         IY4DvvHWOSNj5OnlAh5XkZFTAwlr2h/Guq0q83R4nSqRWhDf4DyDCRvwR7LR1Rw7f1Rh
         qH+1oTjphZ/nMK2FZJMnBK6+Ag1wMXqB+VNV68FzHU23jS/ZgpWm97TaURhk+llQYpHK
         lirh09zuq50r8gs9kKjCYVWUOEHNMf9ORoa2rxE/gLy86pDsTm/Fw31Yq0n0M0h2uQam
         Z3DP7t87HytRx4gOSCViEoOakyS7c7uva5qsER5SsEdFVG8wQakZjJLvPULfb0rKX2y5
         DBMQ==
X-Gm-Message-State: APjAAAWp6SmbfNFmcwweZnMZtiDZGDSVq1KAHdJqITURcb47FnmA1yKS
        bfrC+MzkdWxmzL0RRMaeLnWzluZY3/NDWQ==
X-Google-Smtp-Source: APXvYqwaMjchoQsBKlTC3vrSxMJAH+TKnwFi6f3mI9W6ehFWv52B/qrb2Yx5XRoSCVUwLqDpdefq+Q==
X-Received: by 2002:a05:600c:2489:: with SMTP id 9mr14734798wms.131.1571055604770;
        Mon, 14 Oct 2019 05:20:04 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id i1sm20222470wmb.19.2019.10.14.05.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:20:03 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 23/25] crypto: niagara2 - switch to skcipher API
Date:   Mon, 14 Oct 2019 14:19:08 +0200
Message-Id: <20191014121910.7264-24-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
References: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
blkcipher code in the near future.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
2.20.1

