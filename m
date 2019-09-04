Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F8A7EAE
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfIDJBf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 05:01:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43346 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIDJBe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 05:01:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id c19so7811873edy.10
        for <linux-crypto@vger.kernel.org>; Wed, 04 Sep 2019 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8sK/TEpKB1K9hpjxIVTB9ENX+1tRraJmT84AOUbXEtw=;
        b=Wu1gttxvsS1IFOP+HZeBcDihmz6d3Bhx+E+TJjLmg8nyZX522prM8Wgf2P4fG0f8SP
         Xa0ztAoRryuU1fK7qrvk8qdCsmkQMwe2akUeTeG01o2skTHJpv4BVqqoGYLb+Tkjft7H
         NgQUtZ1FJN3CesGMarlgNUpsJKxBHyWKI/lSAYkFVQwjU66e/VC4+7+m3ojp+ZW692uZ
         Ge+YxBgDl/YdVbjcvBtJtjnbKnEClD35ojn0n/5UfIn+KSwDR56m9HYkCUkAqOnNET1E
         JUWVmAIeCKrvBNqB6vmfAOCAVK+SfGp8ecv+lzpIUwN6Ki/ySpGxS0wZnIYrlyRxMEdp
         sKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8sK/TEpKB1K9hpjxIVTB9ENX+1tRraJmT84AOUbXEtw=;
        b=dGcSg0fam46/D0HnMqUdmJ0ikL7GqLetdaFXsEHHgX9RksFxMhQXiEjWa21Oyxb5AP
         CT1bfO1feoJovXfH5/d4fHhattOwNFRZYtXNxRYVJ/6+z7Z19aIqK1cPfLnG3DkiKDl4
         iMkcWiNrNSRLBi5hQCva4D9KfNoZ2oXpAoE8k1niZPMfr9PdclBa0JYCoSmrhVmgxXlD
         4GQypc25F7HESmG5od70vU2eT+3bpuObRDfurLYXKsuRjQR8pb5QPxL21iO0CjK0xj2D
         3hyGV4XWAyCyP693V3HJ/itZvATKhkaKwxA0OEHozLKTCXAIEP8EjAZVayZPgWt8Grg9
         Q1iQ==
X-Gm-Message-State: APjAAAXQsDeYvn8tvOOYN7hJPDSMJBsIduw7YdA9EG59vnArw1uFHJJo
        LpC79RL93zBbNWCYyIZvX7PH4QR8
X-Google-Smtp-Source: APXvYqw4BfeLiPeZWwYA44MmN9/ZmDNro1Sf2ocg2i58GONjGcBwlJWr/lMQIXgKDtCmm3g7DQCqnQ==
X-Received: by 2002:a17:907:2161:: with SMTP id rl1mr1341616ejb.142.1567587691604;
        Wed, 04 Sep 2019 02:01:31 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id t30sm1473997edt.91.2019.09.04.02.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 02:01:31 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 2/3] crypto: inside-secure - Added support for the AES XCBC ahash
Date:   Wed,  4 Sep 2019 09:36:47 +0200
Message-Id: <1567582608-29177-3-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for the AES XCBC authentication algorithm

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel.c      |   1 +
 drivers/crypto/inside-secure/safexcel.h      |   1 +
 drivers/crypto/inside-secure/safexcel_hash.c | 136 ++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 898a6b0..bc8bd69 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1011,6 +1011,7 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
 	&safexcel_alg_ccm,
 	&safexcel_alg_crc32,
 	&safexcel_alg_cbcmac,
+	&safexcel_alg_xcbcmac,
 };
 
 static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index ff91141..809d8d0 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -808,5 +808,6 @@ int safexcel_hmac_setkey(const char *alg, const u8 *key, unsigned int keylen,
 extern struct safexcel_alg_template safexcel_alg_ccm;
 extern struct safexcel_alg_template safexcel_alg_crc32;
 extern struct safexcel_alg_template safexcel_alg_cbcmac;
+extern struct safexcel_alg_template safexcel_alg_xcbcmac;
 
 #endif
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 8df4fdc..6576430 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -9,6 +9,7 @@
 #include <crypto/hmac.h>
 #include <crypto/md5.h>
 #include <crypto/sha.h>
+#include <crypto/skcipher.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
@@ -21,9 +22,12 @@ struct safexcel_ahash_ctx {
 
 	u32 alg;
 	u8  key_sz;
+	bool cbcmac;
 
 	u32 ipad[SHA512_DIGEST_SIZE / sizeof(u32)];
 	u32 opad[SHA512_DIGEST_SIZE / sizeof(u32)];
+
+	struct crypto_cipher *kaes;
 };
 
 struct safexcel_ahash_req {
@@ -62,7 +66,7 @@ static inline u64 safexcel_queued_len(struct safexcel_ahash_req *req)
 
 static void safexcel_hash_token(struct safexcel_command_desc *cdesc,
 				u32 input_length, u32 result_length,
-				bool xcbcmac)
+				bool cbcmac)
 {
 	struct safexcel_token *token =
 		(struct safexcel_token *)cdesc->control_data.token;
@@ -72,7 +76,7 @@ static void safexcel_hash_token(struct safexcel_command_desc *cdesc,
 	token[0].instructions = EIP197_TOKEN_INS_TYPE_HASH;
 
 	input_length &= 15;
-	if (unlikely(xcbcmac && input_length)) {
+	if (unlikely(cbcmac && input_length)) {
 		token[1].opcode = EIP197_TOKEN_OPCODE_INSERT;
 		token[1].packet_length = 16 - input_length;
 		token[1].stat = EIP197_TOKEN_STAT_LAST_HASH;
@@ -354,6 +358,15 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 			}
 			extra -= skip;
 			memset(req->cache + cache_len + skip, 0, extra);
+			if (!ctx->cbcmac && extra) {
+				// 10- padding for XCBCMAC & CMAC
+				req->cache[cache_len + skip] = 0x80;
+				// HW will use K2 iso K3 - compensate!
+				for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++)
+					((u32 *)req->cache)[i] ^=
+						cpu_to_be32(ctx->ipad[i]) ^
+						cpu_to_be32(ctx->ipad[i + 4]);
+			}
 			cache_len = AES_BLOCK_SIZE;
 			queued = queued + extra;
 		}
@@ -435,7 +448,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 
 	/* Add the token. Note that the XCBC result is only 1 AES block. */
 	res_sz = req->xcbcmac ? AES_BLOCK_SIZE : req->state_sz;
-	safexcel_hash_token(first_cdesc, len, res_sz, req->xcbcmac);
+	safexcel_hash_token(first_cdesc, len, res_sz, ctx->cbcmac);
 
 	req->result_dma = dma_map_single(priv->dev, req->state, req->state_sz,
 					 DMA_FROM_DEVICE);
@@ -771,11 +784,22 @@ static int safexcel_ahash_final(struct ahash_request *areq)
 		/* Zero length CRC32 */
 		memcpy(areq->result, ctx->ipad, sizeof(u32));
 		return 0;
-	} else if (unlikely(req->xcbcmac && req->len == AES_BLOCK_SIZE &&
+	} else if (unlikely(ctx->cbcmac && req->len == AES_BLOCK_SIZE &&
 			    !areq->nbytes)) {
 		/* Zero length CBC MAC */
 		memset(areq->result, 0, AES_BLOCK_SIZE);
 		return 0;
+	} else if (unlikely(req->xcbcmac && req->len == AES_BLOCK_SIZE &&
+			    !areq->nbytes)) {
+		/* Zero length (X)CBC/CMAC */
+		int i;
+
+		for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++)
+			((u32 *)areq->result)[i] =
+				cpu_to_be32(ctx->ipad[i + 4]);	// K3
+		areq->result[0] ^= 0x80;			// 10- padding
+		crypto_cipher_encrypt_one(ctx->kaes, areq->result, areq->result);
+		return 0;
 	} else if (unlikely(req->hmac &&
 			    (req->len == req->block_sz) &&
 			    !areq->nbytes)) {
@@ -1954,6 +1978,7 @@ static int safexcel_cbcmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 		ctx->alg    = CONTEXT_CONTROL_CRYPTO_ALG_XCBC128;
 		ctx->key_sz = AES_MIN_KEY_SIZE + 2 * AES_BLOCK_SIZE;
 	}
+	ctx->cbcmac  = true;
 
 	memzero_explicit(&aes, sizeof(aes));
 	return 0;
@@ -1994,3 +2019,106 @@ struct safexcel_alg_template safexcel_alg_cbcmac = {
 		},
 	},
 };
+
+static int safexcel_xcbcmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+				 unsigned int len)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
+	struct crypto_aes_ctx aes;
+	u32 key_tmp[3 * AES_BLOCK_SIZE / sizeof(u32)];
+	int ret, i;
+
+	ret = aes_expandkey(&aes, key, len);
+	if (ret) {
+		crypto_ahash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
+
+	/* precompute the XCBC key material */
+	crypto_cipher_clear_flags(ctx->kaes, CRYPTO_TFM_REQ_MASK);
+	crypto_cipher_set_flags(ctx->kaes, crypto_ahash_get_flags(tfm) &
+				CRYPTO_TFM_REQ_MASK);
+	ret = crypto_cipher_setkey(ctx->kaes, key, len);
+	crypto_ahash_set_flags(tfm, crypto_cipher_get_flags(ctx->kaes) &
+			       CRYPTO_TFM_RES_MASK);
+	if (ret)
+		return ret;
+
+	crypto_cipher_encrypt_one(ctx->kaes, (u8 *)key_tmp + 2 * AES_BLOCK_SIZE,
+		"\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1\x1");
+	crypto_cipher_encrypt_one(ctx->kaes, (u8 *)key_tmp,
+		"\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2\x2");
+	crypto_cipher_encrypt_one(ctx->kaes, (u8 *)key_tmp + AES_BLOCK_SIZE,
+		"\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3\x3");
+	for (i = 0; i < 3 * AES_BLOCK_SIZE / sizeof(u32); i++)
+		ctx->ipad[i] = cpu_to_be32(key_tmp[i]);
+
+	crypto_cipher_clear_flags(ctx->kaes, CRYPTO_TFM_REQ_MASK);
+	crypto_cipher_set_flags(ctx->kaes, crypto_ahash_get_flags(tfm) &
+				CRYPTO_TFM_REQ_MASK);
+	ret = crypto_cipher_setkey(ctx->kaes,
+				   (u8 *)key_tmp + 2 * AES_BLOCK_SIZE,
+				   AES_MIN_KEY_SIZE);
+	crypto_ahash_set_flags(tfm, crypto_cipher_get_flags(ctx->kaes) &
+			       CRYPTO_TFM_RES_MASK);
+	if (ret)
+		return ret;
+
+	ctx->alg    = CONTEXT_CONTROL_CRYPTO_ALG_XCBC128;
+	ctx->key_sz = AES_MIN_KEY_SIZE + 2 * AES_BLOCK_SIZE;
+	ctx->cbcmac = false;
+
+	memzero_explicit(&aes, sizeof(aes));
+	return 0;
+}
+
+static int safexcel_xcbcmac_cra_init(struct crypto_tfm *tfm)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	safexcel_ahash_cra_init(tfm);
+	ctx->kaes = crypto_alloc_cipher("aes", 0, 0);
+	if (IS_ERR(ctx->kaes))
+		return PTR_ERR(ctx->kaes);
+
+	return 0;
+}
+
+static void safexcel_xcbcmac_cra_exit(struct crypto_tfm *tfm)
+{
+	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_cipher(ctx->kaes);
+	safexcel_ahash_cra_exit(tfm);
+}
+
+struct safexcel_alg_template safexcel_alg_xcbcmac = {
+	.type = SAFEXCEL_ALG_TYPE_AHASH,
+	.algo_mask = 0,
+	.alg.ahash = {
+		.init = safexcel_cbcmac_init,
+		.update = safexcel_ahash_update,
+		.final = safexcel_ahash_final,
+		.finup = safexcel_ahash_finup,
+		.digest = safexcel_cbcmac_digest,
+		.setkey = safexcel_xcbcmac_setkey,
+		.export = safexcel_ahash_export,
+		.import = safexcel_ahash_import,
+		.halg = {
+			.digestsize = AES_BLOCK_SIZE,
+			.statesize = sizeof(struct safexcel_ahash_export_state),
+			.base = {
+				.cra_name = "xcbc(aes)",
+				.cra_driver_name = "safexcel-xcbc-aes",
+				.cra_priority = SAFEXCEL_CRA_PRIORITY,
+				.cra_flags = CRYPTO_ALG_ASYNC |
+					     CRYPTO_ALG_KERN_DRIVER_ONLY,
+				.cra_blocksize = AES_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct safexcel_ahash_ctx),
+				.cra_init = safexcel_xcbcmac_cra_init,
+				.cra_exit = safexcel_xcbcmac_cra_exit,
+				.cra_module = THIS_MODULE,
+			},
+		},
+	},
+};
-- 
1.8.3.1

