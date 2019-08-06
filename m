Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF382E0F
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Aug 2019 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfHFItB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Aug 2019 04:49:01 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45790 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfHFItA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Aug 2019 04:49:00 -0400
Received: by mail-ed1-f48.google.com with SMTP id x19so75647281eda.12
        for <linux-crypto@vger.kernel.org>; Tue, 06 Aug 2019 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZZhZ78KG/1jPRcn6eVKMdZx4cVQ4n0xTgrm4+NFSFI=;
        b=g5iWm3sR15u1v5IaIiCn+OsEiVv55BDzruOOYJ7A7KIGK+D6Yw0OvqvAOgo9VEBjhB
         d9Fv7/ZxiOQKDl7Fmpp/MNqsi1nMSPzRPZxp80ARVn8nNvgbqEpE7xyyntEXAIFMm2Rm
         ToQw6dV+yjO1zb2+ZnHfUQn7AeWZCnQ2/I4QRE22JekcVT1D4GSAPxN6C+ax1hGsRhOn
         ksKFF5y29DOztpPw5dTWqlOY5FMTN7JTHKHBizxUe00h/9OmWQaXO0IbiFcNFyQvdYUr
         6cdeCfR18tR8PZ2wJrh1IHToQ2bYMz+P4FgB8ZHGPcIkIffFk9P4aLRumY6MhYNTSCl4
         Acjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZZhZ78KG/1jPRcn6eVKMdZx4cVQ4n0xTgrm4+NFSFI=;
        b=UkzvjwIz4cbn16bTOXWJAriQksM7EUA3MecfM1i8pudISiTeUE8ZFMsZocrV5xTidg
         s4d6j27Z2G/RJ8+TuWMXPbzxGekqw5ahMS7WSl+2HNlDGR+F1PuzUplIB1wO8QwxLLFA
         TabgJysh1D7WUYapctgjSfUUr1BTqcO2EzTRlGRgQ6DZ2aYQT9gR9g/e+SFeQK6MM9cb
         tGHjTlXR7W7exxkbfsvfc7OCuWnGxtEYtXejz8CJC0efGiFQFLGOM1kn+neR/grpHMRo
         tAh4KWTGWZ53sEdnJf0ddxJisM5OCyajQ0cS3tm8j/9zcSYJ9kILoWQFQNI1aunYZb9M
         ilaw==
X-Gm-Message-State: APjAAAWEkzez9rT/fhMakicDkQw47rvNMV63k/8OPRFqubCpjR+HIjFQ
        fBRMGeXb7ezXFzX5BdDKtnm7KzGE
X-Google-Smtp-Source: APXvYqx3L7Mxt2ynB3qroctRqaGSjPDeOxIW8AYb+wAbZ+KyMTo6h0duFeXfTlwQAQ2mOkb9lBptag==
X-Received: by 2002:a17:906:1e89:: with SMTP id e9mr2143584ejj.56.1565081337853;
        Tue, 06 Aug 2019 01:48:57 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id f21sm19980304edj.36.2019.08.06.01.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 01:48:57 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv4 2/4] crypto: inside-secure - Remove redundant algo to engine mapping code
Date:   Tue,  6 Aug 2019 09:46:24 +0200
Message-Id: <1565077586-27814-3-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565077586-27814-1-git-send-email-pvanleeuwen@verimatrix.com>
References: <1565077586-27814-1-git-send-email-pvanleeuwen@verimatrix.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This removes some code determine which engine has which algorithms which
was effectively redundant (may have been forward-looking?) due to always
enabling all algorithms for all currently supported engines.
A future patch will use a different, more scalable approach to achieve
this. This is removed now because otherwise the next patch will add new
hardware which would otherwise have to be added to all algorithms, so
now is a convenient time to just get rid of this.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c        |  9 ---------
 drivers/crypto/inside-secure/safexcel.h        |  1 -
 drivers/crypto/inside-secure/safexcel_cipher.c | 11 -----------
 drivers/crypto/inside-secure/safexcel_hash.c   | 12 ------------
 4 files changed, 33 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index df43a2c..a066152 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -869,9 +869,6 @@ static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
 	for (i = 0; i < ARRAY_SIZE(safexcel_algs); i++) {
 		safexcel_algs[i]->priv = priv;

-		if (!(safexcel_algs[i]->engines & priv->version))
-			continue;
-
 		if (safexcel_algs[i]->type == SAFEXCEL_ALG_TYPE_SKCIPHER)
 			ret = crypto_register_skcipher(&safexcel_algs[i]->alg.skcipher);
 		else if (safexcel_algs[i]->type == SAFEXCEL_ALG_TYPE_AEAD)
@@ -887,9 +884,6 @@ static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)

 fail:
 	for (j = 0; j < i; j++) {
-		if (!(safexcel_algs[j]->engines & priv->version))
-			continue;
-
 		if (safexcel_algs[j]->type == SAFEXCEL_ALG_TYPE_SKCIPHER)
 			crypto_unregister_skcipher(&safexcel_algs[j]->alg.skcipher);
 		else if (safexcel_algs[j]->type == SAFEXCEL_ALG_TYPE_AEAD)
@@ -906,9 +900,6 @@ static void safexcel_unregister_algorithms(struct safexcel_crypto_priv *priv)
 	int i;

 	for (i = 0; i < ARRAY_SIZE(safexcel_algs); i++) {
-		if (!(safexcel_algs[i]->engines & priv->version))
-			continue;
-
 		if (safexcel_algs[i]->type == SAFEXCEL_ALG_TYPE_SKCIPHER)
 			crypto_unregister_skcipher(&safexcel_algs[i]->alg.skcipher);
 		else if (safexcel_algs[i]->type == SAFEXCEL_ALG_TYPE_AEAD)
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index e0c202f..e53c232 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -655,7 +655,6 @@ struct safexcel_ahash_export_state {
 struct safexcel_alg_template {
 	struct safexcel_crypto_priv *priv;
 	enum safexcel_alg_type type;
-	u32 engines;
 	union {
 		struct skcipher_alg skcipher;
 		struct aead_alg aead;
diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 8cdbdbe..ee8a0c3 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -881,7 +881,6 @@ static void safexcel_aead_cra_exit(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_ecb_aes = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_skcipher_aes_setkey,
 		.encrypt = safexcel_ecb_aes_encrypt,
@@ -920,7 +919,6 @@ static int safexcel_cbc_aes_decrypt(struct skcipher_request *req)

 struct safexcel_alg_template safexcel_alg_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_skcipher_aes_setkey,
 		.encrypt = safexcel_cbc_aes_encrypt,
@@ -990,7 +988,6 @@ static int safexcel_des_setkey(struct crypto_skcipher *ctfm, const u8 *key,

 struct safexcel_alg_template safexcel_alg_cbc_des = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_des_setkey,
 		.encrypt = safexcel_cbc_des_encrypt,
@@ -1030,7 +1027,6 @@ static int safexcel_ecb_des_decrypt(struct skcipher_request *req)

 struct safexcel_alg_template safexcel_alg_ecb_des = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_des_setkey,
 		.encrypt = safexcel_ecb_des_encrypt,
@@ -1093,7 +1089,6 @@ static int safexcel_des3_ede_setkey(struct crypto_skcipher *ctfm,

 struct safexcel_alg_template safexcel_alg_cbc_des3_ede = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_des3_ede_setkey,
 		.encrypt = safexcel_cbc_des3_ede_encrypt,
@@ -1133,7 +1128,6 @@ static int safexcel_ecb_des3_ede_decrypt(struct skcipher_request *req)

 struct safexcel_alg_template safexcel_alg_ecb_des3_ede = {
 	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.skcipher = {
 		.setkey = safexcel_des3_ede_setkey,
 		.encrypt = safexcel_ecb_des3_ede_encrypt,
@@ -1203,7 +1197,6 @@ static int safexcel_aead_sha1_cra_init(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_AEAD,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.aead = {
 		.setkey = safexcel_aead_aes_setkey,
 		.encrypt = safexcel_aead_encrypt,
@@ -1238,7 +1231,6 @@ static int safexcel_aead_sha256_cra_init(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_AEAD,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.aead = {
 		.setkey = safexcel_aead_aes_setkey,
 		.encrypt = safexcel_aead_encrypt,
@@ -1273,7 +1265,6 @@ static int safexcel_aead_sha224_cra_init(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_AEAD,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.aead = {
 		.setkey = safexcel_aead_aes_setkey,
 		.encrypt = safexcel_aead_encrypt,
@@ -1308,7 +1299,6 @@ static int safexcel_aead_sha512_cra_init(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_AEAD,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.aead = {
 		.setkey = safexcel_aead_aes_setkey,
 		.encrypt = safexcel_aead_encrypt,
@@ -1343,7 +1333,6 @@ static int safexcel_aead_sha384_cra_init(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_cbc_aes = {
 	.type = SAFEXCEL_ALG_TYPE_AEAD,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.aead = {
 		.setkey = safexcel_aead_aes_setkey,
 		.encrypt = safexcel_aead_encrypt,
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index a80a5e7..2c31536 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -802,7 +802,6 @@ static void safexcel_ahash_cra_exit(struct crypto_tfm *tfm)

 struct safexcel_alg_template safexcel_alg_sha1 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_sha1_init,
 		.update = safexcel_ahash_update,
@@ -1035,7 +1034,6 @@ static int safexcel_hmac_sha1_setkey(struct crypto_ahash *tfm, const u8 *key,

 struct safexcel_alg_template safexcel_alg_hmac_sha1 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_sha1_init,
 		.update = safexcel_ahash_update,
@@ -1099,7 +1097,6 @@ static int safexcel_sha256_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_sha256 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_sha256_init,
 		.update = safexcel_ahash_update,
@@ -1162,7 +1159,6 @@ static int safexcel_sha224_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_sha224 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_sha224_init,
 		.update = safexcel_ahash_update,
@@ -1218,7 +1214,6 @@ static int safexcel_hmac_sha224_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_hmac_sha224 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_sha224_init,
 		.update = safexcel_ahash_update,
@@ -1275,7 +1270,6 @@ static int safexcel_hmac_sha256_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_hmac_sha256 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_sha256_init,
 		.update = safexcel_ahash_update,
@@ -1347,7 +1341,6 @@ static int safexcel_sha512_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_sha512 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_sha512_init,
 		.update = safexcel_ahash_update,
@@ -1418,7 +1411,6 @@ static int safexcel_sha384_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_sha384 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_sha384_init,
 		.update = safexcel_ahash_update,
@@ -1474,7 +1466,6 @@ static int safexcel_hmac_sha512_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_hmac_sha512 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_sha512_init,
 		.update = safexcel_ahash_update,
@@ -1531,7 +1522,6 @@ static int safexcel_hmac_sha384_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_hmac_sha384 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_sha384_init,
 		.update = safexcel_ahash_update,
@@ -1591,7 +1581,6 @@ static int safexcel_md5_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_md5 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_md5_init,
 		.update = safexcel_ahash_update,
@@ -1647,7 +1636,6 @@ static int safexcel_hmac_md5_digest(struct ahash_request *areq)

 struct safexcel_alg_template safexcel_alg_hmac_md5 = {
 	.type = SAFEXCEL_ALG_TYPE_AHASH,
-	.engines = EIP97IES | EIP197B | EIP197D,
 	.alg.ahash = {
 		.init = safexcel_hmac_md5_init,
 		.update = safexcel_ahash_update,
--
1.8.3.1
