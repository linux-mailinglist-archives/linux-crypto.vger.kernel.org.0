Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07763A332D
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Aug 2019 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfH3IzT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Aug 2019 04:55:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39963 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfH3IzR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Aug 2019 04:55:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so1282103edm.7
        for <linux-crypto@vger.kernel.org>; Fri, 30 Aug 2019 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PYZvPAGI90ZvthU7p1kP5ssQqTW5DQ+l7cDUuwmPor8=;
        b=URAisa/c8FO+ZBFE9fnzy1guOh74deNAU9lYfIf2BHOPECLnWm73nWtEAP00x3IjIN
         B+8eGqsIwoF4f1jon/BOBs6VHia2TBb2s6AWR6o+sJn+KxFhMI0jdFmw4XbVJWUVsRNf
         j24Tgqd9ZEu6tN+sk1T8vwWUobcw8/hE/1MCeOyOuLfESw1zsisBEnQn9Qg6ZpDMoeCE
         qlWrLTOskiVwHWrCb36YlECQ0NDOmABkAdG56X661J+8crkE7ADSR3mquSLsSjq2cdIR
         c8q1QQdljxdKs4ho+pDrxVfUfvcWJYhJ35tpo8lHJY9yxrDcdRoJwi6NqpvskVBBaRJA
         dDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PYZvPAGI90ZvthU7p1kP5ssQqTW5DQ+l7cDUuwmPor8=;
        b=cLtpFopcLQ4S1lQ3OgvkDM9rtcPJ1Pw+9Hu8BQcrho5z/N3OHEbOWNUKir29LjGpqx
         /B+XF2MuudGlOwTyTIjxGbtPIwHLdagkGAYeEiBryLs7XkCVttbWbzWEHLFJcYwRRRMx
         MJ66Dx8/S1G04T+oSxS1i1NYwfXr8u3BGLROBxNTJw2qKKu3klymxIhx3RccnmoH+fYj
         rc4CvRqmwp2oCpNODvCRIggKlZsSubBeHNJDueXnxNm+44maITHwKqlVX1hjqQuVxfQq
         LMzTRa3dbjIYMJfuSCwXq0pLtHJMEXzA+a1jx3Z3oBl5z6zJa9FNj2ZEbNSiiGl/bVSL
         Ns0w==
X-Gm-Message-State: APjAAAUfRjp8gWbtcQZcFBNtqcIUWyNPBRfsku33H6GCaA0drV/02+Oj
        UgDa8fe85OkMAgJwOZJxxqo9obip
X-Google-Smtp-Source: APXvYqxqXmMY/aAD12Wvn0j0TC2ECGotmjWuuSxYzvjpsI/AoinfaxRVWGeMQbylafyyFs0hWuxRJA==
X-Received: by 2002:a17:906:5e50:: with SMTP id b16mr12064416eju.254.1567155314907;
        Fri, 30 Aug 2019 01:55:14 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id l9sm335610eda.51.2019.08.30.01.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:55:14 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 1/4] crypto: inside-secure - Added support for basic AES-GCM
Date:   Fri, 30 Aug 2019 09:52:30 +0200
Message-Id: <1567151553-11108-2-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567151553-11108-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1567151553-11108-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for the basic AES-GCM AEAD cipher suite.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel.c        |   4 +-
 drivers/crypto/inside-secure/safexcel.h        |   7 +-
 drivers/crypto/inside-secure/safexcel_cipher.c | 226 ++++++++++++++++++++-----
 drivers/crypto/inside-secure/safexcel_ring.c   |   8 +-
 4 files changed, 204 insertions(+), 41 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 25285d6..46cdcbe 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -715,7 +715,8 @@ inline int safexcel_rdesc_check_errors(struct safexcel_crypto_priv *priv,
 	} else if (rdesc->result_data.error_code & BIT(9)) {
 		/* Authentication failed */
 		return -EBADMSG;
-	}
+	} else if (!rdesc->result_data.error_code)
+		return 0;
 
 	/* All other non-fatal errors */
 	return -EINVAL;
@@ -1005,6 +1006,7 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
 	&safexcel_alg_authenc_hmac_sha384_ctr_aes,
 	&safexcel_alg_authenc_hmac_sha512_ctr_aes,
 	&safexcel_alg_xts_aes,
+	&safexcel_alg_gcm,
 };
 
 static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 1e575a1..c6f93ec 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -19,7 +19,7 @@
 
 /* Static configuration */
 #define EIP197_DEFAULT_RING_SIZE		400
-#define EIP197_MAX_TOKENS			8
+#define EIP197_MAX_TOKENS			10
 #define EIP197_MAX_RINGS			4
 #define EIP197_FETCH_COUNT			1
 #define EIP197_MAX_BATCH_SZ			64
@@ -321,6 +321,7 @@ struct safexcel_context_record {
 #define CONTEXT_CONTROL_CRYPTO_ALG_AES192	(0x6 << 17)
 #define CONTEXT_CONTROL_CRYPTO_ALG_AES256	(0x7 << 17)
 #define CONTEXT_CONTROL_DIGEST_PRECOMPUTED	(0x1 << 21)
+#define CONTEXT_CONTROL_DIGEST_XCM		(0x2 << 21)
 #define CONTEXT_CONTROL_DIGEST_HMAC		(0x3 << 21)
 #define CONTEXT_CONTROL_CRYPTO_ALG_MD5		(0x0 << 23)
 #define CONTEXT_CONTROL_CRYPTO_ALG_SHA1		(0x2 << 23)
@@ -328,6 +329,7 @@ struct safexcel_context_record {
 #define CONTEXT_CONTROL_CRYPTO_ALG_SHA256	(0x3 << 23)
 #define CONTEXT_CONTROL_CRYPTO_ALG_SHA384	(0x6 << 23)
 #define CONTEXT_CONTROL_CRYPTO_ALG_SHA512	(0x5 << 23)
+#define CONTEXT_CONTROL_CRYPTO_ALG_GHASH	(0x4 << 23)
 #define CONTEXT_CONTROL_INV_FR			(0x5 << 24)
 #define CONTEXT_CONTROL_INV_TR			(0x6 << 24)
 
@@ -336,6 +338,7 @@ struct safexcel_context_record {
 #define CONTEXT_CONTROL_CRYPTO_MODE_CBC		(1 << 0)
 #define CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD	(6 << 0)
 #define CONTEXT_CONTROL_CRYPTO_MODE_XTS		(7 << 0)
+#define CONTEXT_CONTROL_CRYPTO_MODE_XCM		((6 << 0) | BIT(17))
 #define CONTEXT_CONTROL_IV0			BIT(5)
 #define CONTEXT_CONTROL_IV1			BIT(6)
 #define CONTEXT_CONTROL_IV2			BIT(7)
@@ -445,6 +448,7 @@ struct safexcel_token {
 #define EIP197_TOKEN_OPCODE_INSERT		0x2
 #define EIP197_TOKEN_OPCODE_NOOP		EIP197_TOKEN_OPCODE_INSERT
 #define EIP197_TOKEN_OPCODE_RETRIEVE		0x4
+#define EIP197_TOKEN_OPCODE_INSERT_REMRES	0xa
 #define EIP197_TOKEN_OPCODE_VERIFY		0xd
 #define EIP197_TOKEN_OPCODE_CTX_ACCESS		0xe
 #define EIP197_TOKEN_OPCODE_BYPASS		GENMASK(3, 0)
@@ -788,5 +792,6 @@ int safexcel_hmac_setkey(const char *alg, const u8 *key, unsigned int keylen,
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_ctr_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_ctr_aes;
 extern struct safexcel_alg_template safexcel_alg_xts_aes;
+extern struct safexcel_alg_template safexcel_alg_gcm;
 
 #endif
diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index c82d003..6f088b4 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -14,6 +14,8 @@
 #include <crypto/authenc.h>
 #include <crypto/ctr.h>
 #include <crypto/des.h>
+#include <crypto/gcm.h>
+#include <crypto/ghash.h>
 #include <crypto/sha.h>
 #include <crypto/xts.h>
 #include <crypto/skcipher.h>
@@ -40,6 +42,7 @@ struct safexcel_cipher_ctx {
 	u32 mode;
 	enum safexcel_cipher_alg alg;
 	bool aead;
+	int  xcm; /* 0=authenc, 1=GCM, 2 reserved for CCM */
 
 	__le32 key[16];
 	u32 nonce;
@@ -50,6 +53,8 @@ struct safexcel_cipher_ctx {
 	u32 state_sz;
 	u32 ipad[SHA512_DIGEST_SIZE / sizeof(u32)];
 	u32 opad[SHA512_DIGEST_SIZE / sizeof(u32)];
+
+	struct crypto_cipher *hkaes;
 };
 
 struct safexcel_cipher_req {
@@ -76,6 +81,15 @@ static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 		cdesc->control_data.token[3] = cpu_to_be32(1);
 
 		return;
+	} else if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_XCM) {
+		cdesc->control_data.options |= EIP197_OPTION_4_TOKEN_IV_CMD;
+
+		/* 96 bit IV part */
+		memcpy(&cdesc->control_data.token[0], iv, 12);
+		/* 32 bit counter, start at 1 (big endian!) */
+		cdesc->control_data.token[3] = cpu_to_be32(1);
+
+		return;
 	}
 
 	if (ctx->mode != CONTEXT_CONTROL_CRYPTO_MODE_ECB) {
@@ -129,56 +143,68 @@ static void safexcel_aead_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 	if (direction == SAFEXCEL_ENCRYPT) {
 		/* align end of instruction sequence to end of token */
 		token = (struct safexcel_token *)(cdesc->control_data.token +
-			 EIP197_MAX_TOKENS - 3);
+			 EIP197_MAX_TOKENS - 5);
 
-		token[2].opcode = EIP197_TOKEN_OPCODE_INSERT;
-		token[2].packet_length = digestsize;
-		token[2].stat = EIP197_TOKEN_STAT_LAST_HASH |
+		token[4].opcode = EIP197_TOKEN_OPCODE_INSERT;
+		token[4].packet_length = digestsize;
+		token[4].stat = EIP197_TOKEN_STAT_LAST_HASH |
 				EIP197_TOKEN_STAT_LAST_PACKET;
-		token[2].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT |
+		token[4].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT |
 					EIP197_TOKEN_INS_INSERT_HASH_DIGEST;
 	} else {
 		cryptlen -= digestsize;
 
 		/* align end of instruction sequence to end of token */
 		token = (struct safexcel_token *)(cdesc->control_data.token +
-			 EIP197_MAX_TOKENS - 4);
+			 EIP197_MAX_TOKENS - 6);
 
-		token[2].opcode = EIP197_TOKEN_OPCODE_RETRIEVE;
-		token[2].packet_length = digestsize;
-		token[2].stat = EIP197_TOKEN_STAT_LAST_HASH |
+		token[4].opcode = EIP197_TOKEN_OPCODE_RETRIEVE;
+		token[4].packet_length = digestsize;
+		token[4].stat = EIP197_TOKEN_STAT_LAST_HASH |
 				EIP197_TOKEN_STAT_LAST_PACKET;
-		token[2].instructions = EIP197_TOKEN_INS_INSERT_HASH_DIGEST;
+		token[4].instructions = EIP197_TOKEN_INS_INSERT_HASH_DIGEST;
 
-		token[3].opcode = EIP197_TOKEN_OPCODE_VERIFY;
-		token[3].packet_length = digestsize |
+		token[5].opcode = EIP197_TOKEN_OPCODE_VERIFY;
+		token[5].packet_length = digestsize |
 					 EIP197_TOKEN_HASH_RESULT_VERIFY;
-		token[3].stat = EIP197_TOKEN_STAT_LAST_HASH |
+		token[5].stat = EIP197_TOKEN_STAT_LAST_HASH |
 				EIP197_TOKEN_STAT_LAST_PACKET;
-		token[3].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT;
+		token[5].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT;
 	}
 
+	token[0].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
+	token[0].packet_length = assoclen;
+
 	if (likely(cryptlen)) {
-		if (likely(assoclen)) {
-			token[0].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
-			token[0].packet_length = assoclen;
-			token[0].instructions = EIP197_TOKEN_INS_TYPE_HASH;
-		}
+		token[0].instructions = EIP197_TOKEN_INS_TYPE_HASH;
 
-		token[1].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
-		token[1].packet_length = cryptlen;
-		token[1].stat = EIP197_TOKEN_STAT_LAST_HASH;
-		token[1].instructions = EIP197_TOKEN_INS_LAST |
+		token[3].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
+		token[3].packet_length = cryptlen;
+		token[3].stat = EIP197_TOKEN_STAT_LAST_HASH;
+		token[3].instructions = EIP197_TOKEN_INS_LAST |
 					EIP197_TOKEN_INS_TYPE_CRYPTO |
 					EIP197_TOKEN_INS_TYPE_HASH |
 					EIP197_TOKEN_INS_TYPE_OUTPUT;
 	} else {
-		token[1].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
-		token[1].packet_length = assoclen;
-		token[1].stat = EIP197_TOKEN_STAT_LAST_HASH;
-		token[1].instructions = EIP197_TOKEN_INS_LAST |
+		token[0].stat = EIP197_TOKEN_STAT_LAST_HASH;
+		token[0].instructions = EIP197_TOKEN_INS_LAST |
 					EIP197_TOKEN_INS_TYPE_HASH;
 	}
+
+	if (ctx->xcm) {
+		token[0].instructions = EIP197_TOKEN_INS_LAST |
+					EIP197_TOKEN_INS_TYPE_HASH;
+
+		token[1].opcode = EIP197_TOKEN_OPCODE_INSERT_REMRES;
+		token[1].packet_length = 0;
+		token[1].stat = EIP197_TOKEN_STAT_LAST_HASH;
+		token[1].instructions = AES_BLOCK_SIZE;
+
+		token[2].opcode = EIP197_TOKEN_OPCODE_INSERT;
+		token[2].packet_length = AES_BLOCK_SIZE;
+		token[2].instructions = EIP197_TOKEN_INS_TYPE_OUTPUT |
+					EIP197_TOKEN_INS_TYPE_CRYPTO;
+	}
 }
 
 static int safexcel_skcipher_aes_setkey(struct crypto_skcipher *ctfm,
@@ -336,22 +362,27 @@ static int safexcel_context_control(struct safexcel_cipher_ctx *ctx,
 
 	if (ctx->aead) {
 		/* Take in account the ipad+opad digests */
-		ctrl_size += ctx->state_sz / sizeof(u32) * 2;
-
-		if (sreq->direction == SAFEXCEL_ENCRYPT)
+		if (ctx->xcm) {
+			ctrl_size += ctx->state_sz / sizeof(u32);
 			cdesc->control_data.control0 =
-				CONTEXT_CONTROL_TYPE_ENCRYPT_HASH_OUT |
-				CONTEXT_CONTROL_DIGEST_HMAC |
 				CONTEXT_CONTROL_KEY_EN |
+				CONTEXT_CONTROL_DIGEST_XCM |
 				ctx->hash_alg |
 				CONTEXT_CONTROL_SIZE(ctrl_size);
-		else
+		} else {
+			ctrl_size += ctx->state_sz / sizeof(u32) * 2;
 			cdesc->control_data.control0 =
-				CONTEXT_CONTROL_TYPE_HASH_DECRYPT_IN |
-				CONTEXT_CONTROL_DIGEST_HMAC |
 				CONTEXT_CONTROL_KEY_EN |
+				CONTEXT_CONTROL_DIGEST_HMAC |
 				ctx->hash_alg |
 				CONTEXT_CONTROL_SIZE(ctrl_size);
+		}
+		if (sreq->direction == SAFEXCEL_ENCRYPT)
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_TYPE_ENCRYPT_HASH_OUT;
+		else
+			cdesc->control_data.control0 |=
+				CONTEXT_CONTROL_TYPE_HASH_DECRYPT_IN;
 	} else {
 		if (sreq->direction == SAFEXCEL_ENCRYPT)
 			cdesc->control_data.control0 =
@@ -491,9 +522,10 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 
 		memcpy(ctx->base.ctxr->data + ctx->key_len / sizeof(u32),
 		       ctx->ipad, ctx->state_sz);
-		memcpy(ctx->base.ctxr->data + (ctx->key_len + ctx->state_sz) /
-		       sizeof(u32),
-		       ctx->opad, ctx->state_sz);
+		if (!ctx->xcm)
+			memcpy(ctx->base.ctxr->data + (ctx->key_len +
+			       ctx->state_sz) / sizeof(u32), ctx->opad,
+			       ctx->state_sz);
 	} else if ((ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CBC) &&
 		   (sreq->direction == SAFEXCEL_DECRYPT)) {
 		/*
@@ -1903,3 +1935,121 @@ struct safexcel_alg_template safexcel_alg_xts_aes = {
 		},
 	},
 };
+
+static int safexcel_aead_gcm_setkey(struct crypto_aead *ctfm, const u8 *key,
+				    unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
+	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct safexcel_crypto_priv *priv = ctx->priv;
+	struct crypto_aes_ctx aes;
+	u32 hashkey[AES_BLOCK_SIZE >> 2];
+	int ret, i;
+
+	ret = aes_expandkey(&aes, key, len);
+	if (ret) {
+		crypto_aead_set_flags(ctfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		memzero_explicit(&aes, sizeof(aes));
+		return ret;
+	}
+
+	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
+		for (i = 0; i < len / sizeof(u32); i++) {
+			if (ctx->key[i] != cpu_to_le32(aes.key_enc[i])) {
+				ctx->base.needs_inv = true;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < len / sizeof(u32); i++)
+		ctx->key[i] = cpu_to_le32(aes.key_enc[i]);
+
+	ctx->key_len = len;
+
+	/* Compute hash key by encrypting zeroes with cipher key */
+	crypto_cipher_clear_flags(ctx->hkaes, CRYPTO_TFM_REQ_MASK);
+	crypto_cipher_set_flags(ctx->hkaes, crypto_aead_get_flags(ctfm) &
+				CRYPTO_TFM_REQ_MASK);
+	ret = crypto_cipher_setkey(ctx->hkaes, key, len);
+	crypto_aead_set_flags(ctfm, crypto_cipher_get_flags(ctx->hkaes) &
+			      CRYPTO_TFM_RES_MASK);
+	if (ret)
+		return ret;
+
+	memset(hashkey, 0, AES_BLOCK_SIZE);
+	crypto_cipher_encrypt_one(ctx->hkaes, (u8 *)hashkey, (u8 *)hashkey);
+
+	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
+		for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++) {
+			if (ctx->ipad[i] != cpu_to_be32(hashkey[i])) {
+				ctx->base.needs_inv = true;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++)
+		ctx->ipad[i] = cpu_to_be32(hashkey[i]);
+
+	memzero_explicit(hashkey, AES_BLOCK_SIZE);
+	memzero_explicit(&aes, sizeof(aes));
+	return 0;
+}
+
+static int safexcel_aead_gcm_cra_init(struct crypto_tfm *tfm)
+{
+	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	safexcel_aead_cra_init(tfm);
+	ctx->hash_alg = CONTEXT_CONTROL_CRYPTO_ALG_GHASH;
+	ctx->state_sz = GHASH_BLOCK_SIZE;
+	ctx->xcm = 1; /* GCM */
+	ctx->mode = CONTEXT_CONTROL_CRYPTO_MODE_XCM; /* override default */
+
+	ctx->hkaes = crypto_alloc_cipher("aes", 0, 0);
+	if (IS_ERR(ctx->hkaes))
+		return PTR_ERR(ctx->hkaes);
+
+	return 0;
+}
+
+static void safexcel_aead_gcm_cra_exit(struct crypto_tfm *tfm)
+{
+	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_cipher(ctx->hkaes);
+	safexcel_aead_cra_exit(tfm);
+}
+
+static int safexcel_aead_gcm_setauthsize(struct crypto_aead *tfm,
+					 unsigned int authsize)
+{
+	return crypto_gcm_check_authsize(authsize);
+}
+
+struct safexcel_alg_template safexcel_alg_gcm = {
+	.type = SAFEXCEL_ALG_TYPE_AEAD,
+	.algo_mask = SAFEXCEL_ALG_AES | SAFEXCEL_ALG_GHASH,
+	.alg.aead = {
+		.setkey = safexcel_aead_gcm_setkey,
+		.setauthsize = safexcel_aead_gcm_setauthsize,
+		.encrypt = safexcel_aead_encrypt,
+		.decrypt = safexcel_aead_decrypt,
+		.ivsize = GCM_AES_IV_SIZE,
+		.maxauthsize = GHASH_DIGEST_SIZE,
+		.base = {
+			.cra_name = "gcm(aes)",
+			.cra_driver_name = "safexcel-gcm-aes",
+			.cra_priority = SAFEXCEL_CRA_PRIORITY,
+			.cra_flags = CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct safexcel_cipher_ctx),
+			.cra_alignmask = 0,
+			.cra_init = safexcel_aead_gcm_cra_init,
+			.cra_exit = safexcel_aead_gcm_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
diff --git a/drivers/crypto/inside-secure/safexcel_ring.c b/drivers/crypto/inside-secure/safexcel_ring.c
index 2402a62..0f269b8 100644
--- a/drivers/crypto/inside-secure/safexcel_ring.c
+++ b/drivers/crypto/inside-secure/safexcel_ring.c
@@ -137,7 +137,13 @@ struct safexcel_command_desc *safexcel_add_cdesc(struct safexcel_crypto_priv *pr
 		struct safexcel_token *token =
 			(struct safexcel_token *)cdesc->control_data.token;
 
-		cdesc->control_data.packet_length = full_data_len;
+		/*
+		 * Note that the length here MUST be >0 or else the EIP(1)97
+		 * may hang. Newer EIP197 firmware actually incorporates this
+		 * fix already, but that doesn't help the EIP97 and we may
+		 * also be running older firmware.
+		 */
+		cdesc->control_data.packet_length = full_data_len ?: 1;
 		cdesc->control_data.options = EIP197_OPTION_MAGIC_VALUE |
 					      EIP197_OPTION_64BIT_CTX |
 					      EIP197_OPTION_CTX_CTRL_IN_CMD;
-- 
1.8.3.1

