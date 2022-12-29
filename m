Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EB659224
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Dec 2022 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiL2VS3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 29 Dec 2022 16:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiL2VSR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 29 Dec 2022 16:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028F62C4
        for <linux-crypto@vger.kernel.org>; Thu, 29 Dec 2022 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672348650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TT6ZnS4c4XNNryd0dblg0NDQpCD/OKbVNdhp0j+A+E=;
        b=VJ7yYFHI5VE1hw8SHJ58wEx/fMURmE/3jMTK3u/3kNigGP0VhfZSIZSYBqiU8eoxOILsFQ
        wksMTkANV5mRPJCVrFz/1BfYUzH9vcSHAyKelpWwe5eYzxsH3qT+dxQbZhhmsNJqCqCGif
        KvfTljA0MCV8QPxgtE13Mxr/wdO9kLo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-odd_7TpmMEqDQaQiH0_bhA-1; Thu, 29 Dec 2022 16:17:26 -0500
X-MC-Unique: odd_7TpmMEqDQaQiH0_bhA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4882D3C02521;
        Thu, 29 Dec 2022 21:17:25 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-2.brq.redhat.com [10.40.208.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6CC8492B00;
        Thu, 29 Dec 2022 21:17:22 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolai Stange <nstange@suse.de>, Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v3 2/6] crypto: xts - drop xts_check_key()
Date:   Thu, 29 Dec 2022 22:17:06 +0100
Message-Id: <20221229211710.14912-3-vdronov@redhat.com>
In-Reply-To: <20221229211710.14912-1-vdronov@redhat.com>
References: <20221229211710.14912-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

xts_check_key() is obsoleted by xts_verify_key(). Over time XTS crypto
drivers adopted the newer xts_verify_key() variant, but xts_check_key()
is still used by a number of drivers. Switch drivers to use the newer
xts_verify_key() and make a couple of cleanups. This allows us to drop
xts_check_key() completely and avoid redundancy.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/crypto/paes_s390.c                  |  2 +-
 drivers/crypto/atmel-aes.c                    |  2 +-
 drivers/crypto/axis/artpec6_crypto.c          |  2 +-
 drivers/crypto/cavium/cpt/cptvf_algs.c        |  8 +++----
 .../crypto/cavium/nitrox/nitrox_skcipher.c    |  8 +++----
 drivers/crypto/ccree/cc_cipher.c              |  2 +-
 .../crypto/marvell/octeontx/otx_cptvf_algs.c  |  2 +-
 .../marvell/octeontx2/otx2_cptvf_algs.c       |  2 +-
 include/crypto/xts.h                          | 22 ++++---------------
 9 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index a279b7d23a5e..29dc827e0fe8 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -474,7 +474,7 @@ static int xts_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
 		return rc;
 
 	/*
-	 * xts_check_key verifies the key length is not odd and makes
+	 * xts_verify_key verifies the key length is not odd and makes
 	 * sure that the two keys are not the same. This can be done
 	 * on the two protected keys as well
 	 */
diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 886bf258544c..130f8bf09a9a 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -1879,7 +1879,7 @@ static int atmel_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	struct atmel_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 	int err;
 
-	err = xts_check_key(crypto_skcipher_tfm(tfm), key, keylen);
+	err = xts_verify_key(tfm, key, keylen);
 	if (err)
 		return err;
 
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 51c66afbe677..f6f41e316dfe 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1621,7 +1621,7 @@ artpec6_crypto_xts_set_key(struct crypto_skcipher *cipher, const u8 *key,
 		crypto_skcipher_ctx(cipher);
 	int ret;
 
-	ret = xts_check_key(&cipher->base, key, keylen);
+	ret = xts_verify_key(cipher, key, keylen);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index 9eca0c302186..0b38c2600b86 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -232,13 +232,12 @@ static int cvm_decrypt(struct skcipher_request *req)
 static int cvm_xts_setkey(struct crypto_skcipher *cipher, const u8 *key,
 		   u32 keylen)
 {
-	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
-	struct cvm_enc_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cvm_enc_ctx *ctx = crypto_skcipher_ctx(cipher);
 	int err;
 	const u8 *key1 = key;
 	const u8 *key2 = key + (keylen / 2);
 
-	err = xts_check_key(tfm, key, keylen);
+	err = xts_verify_key(cipher, key, keylen);
 	if (err)
 		return err;
 	ctx->key_len = keylen;
@@ -289,8 +288,7 @@ static int cvm_validate_keylen(struct cvm_enc_ctx *ctx, u32 keylen)
 static int cvm_setkey(struct crypto_skcipher *cipher, const u8 *key,
 		      u32 keylen, u8 cipher_type)
 {
-	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
-	struct cvm_enc_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cvm_enc_ctx *ctx = crypto_skcipher_ctx(cipher);
 
 	ctx->cipher_type = cipher_type;
 	if (!cvm_validate_keylen(ctx, keylen)) {
diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
index 248b4fff1c72..138261dcd032 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
@@ -337,12 +337,11 @@ static int nitrox_3des_decrypt(struct skcipher_request *skreq)
 static int nitrox_aes_xts_setkey(struct crypto_skcipher *cipher,
 				 const u8 *key, unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
-	struct nitrox_crypto_ctx *nctx = crypto_tfm_ctx(tfm);
+	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(cipher);
 	struct flexi_crypto_context *fctx;
 	int aes_keylen, ret;
 
-	ret = xts_check_key(tfm, key, keylen);
+	ret = xts_verify_key(cipher, key, keylen);
 	if (ret)
 		return ret;
 
@@ -362,8 +361,7 @@ static int nitrox_aes_xts_setkey(struct crypto_skcipher *cipher,
 static int nitrox_aes_ctr_rfc3686_setkey(struct crypto_skcipher *cipher,
 					 const u8 *key, unsigned int keylen)
 {
-	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
-	struct nitrox_crypto_ctx *nctx = crypto_tfm_ctx(tfm);
+	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(cipher);
 	struct flexi_crypto_context *fctx;
 	int aes_keylen;
 
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 309da6334a0a..2cd44d7457a4 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -460,7 +460,7 @@ static int cc_cipher_setkey(struct crypto_skcipher *sktfm, const u8 *key,
 	}
 
 	if (ctx_p->cipher_mode == DRV_CIPHER_XTS &&
-	    xts_check_key(tfm, key, keylen)) {
+	    xts_verify_key(sktfm, key, keylen)) {
 		dev_dbg(dev, "weak XTS key");
 		return -EINVAL;
 	}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 80ba77c793a7..83493dd0416f 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -398,7 +398,7 @@ static int otx_cpt_skcipher_xts_setkey(struct crypto_skcipher *tfm,
 	const u8 *key1 = key;
 	int ret;
 
-	ret = xts_check_key(crypto_skcipher_tfm(tfm), key, keylen);
+	ret = xts_verify_key(tfm, key, keylen);
 	if (ret)
 		return ret;
 	ctx->key_len = keylen;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 30b423605c9c..443202caa140 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -412,7 +412,7 @@ static int otx2_cpt_skcipher_xts_setkey(struct crypto_skcipher *tfm,
 	const u8 *key1 = key;
 	int ret;
 
-	ret = xts_check_key(crypto_skcipher_tfm(tfm), key, keylen);
+	ret = xts_verify_key(tfm, key, keylen);
 	if (ret)
 		return ret;
 	ctx->key_len = keylen;
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index a233c1054df2..15b16c4853d8 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -8,23 +8,6 @@
 
 #define XTS_BLOCK_SIZE 16
 
-static inline int xts_check_key(struct crypto_tfm *tfm,
-				const u8 *key, unsigned int keylen)
-{
-	/*
-	 * key consists of keys of equal size concatenated, therefore
-	 * the length must be even.
-	 */
-	if (keylen % 2)
-		return -EINVAL;
-
-	/* ensure that the AES and tweak key are not identical */
-	if (fips_enabled && !crypto_memneq(key, key + (keylen / 2), keylen / 2))
-		return -EINVAL;
-
-	return 0;
-}
-
 static inline int xts_verify_key(struct crypto_skcipher *tfm,
 				 const u8 *key, unsigned int keylen)
 {
@@ -42,7 +25,10 @@ static inline int xts_verify_key(struct crypto_skcipher *tfm,
 	if (fips_enabled && keylen != 32 && keylen != 64)
 		return -EINVAL;
 
-	/* ensure that the AES and tweak key are not identical */
+	/*
+	 * Ensure that the AES and tweak key are not identical when
+	 * in FIPS mode or the FORBID_WEAK_KEYS flag is set.
+	 */
 	if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
 			      CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
 	    !crypto_memneq(key, key + (keylen / 2), keylen / 2))
-- 
2.38.1

