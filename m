Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1A59EAF
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jun 2019 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1PV2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 11:21:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF1PV1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 11:21:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so9345779wmj.5
        for <linux-crypto@vger.kernel.org>; Fri, 28 Jun 2019 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paYjmK2VK79Q3G5WiLqW097eDaX1Mw8Wcz8d8EbOZUA=;
        b=UJyst81qOJGRReXVV+6LRy+f0kzameQizPy+TslKngBTICbfNK+4v4v23CbTEyVNEF
         XTpLubmZYsudAx5uL8BH/pRl4cnHz7yrgi58fnsU8vJaIzI9t+yKihiSHCiULCOVH4iG
         Zh3Kio7i2utlWAPKcu9lwLNGyQcJZ7qrjNVyW5pX4HdWl8JyHe4FsnRhHKwcASVfYALi
         Zy/wlYXROz6jbGfdIQ3Ob08Qsa29JmAnMJCjEQQ8A0pDn88OqV95WAfzzD+2rMn5Esjr
         +Kftfju0l0XzvC3wviZQQylIpg3uCET5p+JThE2b8ZQUL7Z4G9amXCboWB0TuJeYK343
         LYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paYjmK2VK79Q3G5WiLqW097eDaX1Mw8Wcz8d8EbOZUA=;
        b=sKiOxlcRAzxtwdkEsQNm6WnbRZNHpdbGBfZHc2lp/DCoN8/nZqgOGXOVsBjCy55Ril
         COEPXMThhGOeeP4RLhFL8W0x8G3UjAz8R6RMm+9UWK3Suemss4bEm4pR65q6enr2EYMF
         RMk8OiC8GiYDKpkjCra6cZsvgE6nmaQW+4CdARIgWE6H1sclNhAoFKP2UFAXQM/d4GqS
         2HewibflCkZC4qeGrSJ6dmRcfiSs9UjRBjuYNIemCP+i9zgVutrp0eYiGDsRe1gN+QR1
         gKoFpUuEQgGRdWRaBLs8EDOytoCBBH8y/hoTFl2qgJh7EXY7r+TWyLQ0Vm13YccJdMOS
         ittA==
X-Gm-Message-State: APjAAAWq0shLEKCkUnlgeA28hTM4brSy3Yk82khyZkNpROY3ZEcvAyqD
        flGfKynHw0RokMnciZ7/K8ABZ2hX5cE=
X-Google-Smtp-Source: APXvYqxGotkOPB1Ftrj8U2Lnyh2sR0jN5vnzP8q0uRtv2VxsY2rHYi3XjJukXKLx8no4Ias/p0Hh7g==
X-Received: by 2002:a1c:407:: with SMTP id 7mr8105856wme.113.1561735283026;
        Fri, 28 Jun 2019 08:21:23 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id u13sm2734319wrq.62.2019.06.28.08.21.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 08:21:22 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>, dm-devel@redhat.com,
        linux-fscrypt@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v6 1/7] crypto: essiv - create wrapper template for ESSIV generation
Date:   Fri, 28 Jun 2019 17:21:06 +0200
Message-Id: <20190628152112.914-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628152112.914-1-ard.biesheuvel@linaro.org>
References: <20190628152112.914-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Implement a template that wraps a (skcipher,cipher,shash) or
(aead,cipher,shash) tuple so that we can consolidate the ESSIV handling
in fscrypt and dm-crypt and move it into the crypto API. This will result
in better test coverage, and will allow future changes to make the bare
cipher interface internal to the crypto subsystem, in order to increase
robustness of the API against misuse.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/Kconfig  |   4 +
 crypto/Makefile |   1 +
 crypto/essiv.c  | 640 ++++++++++++++++++++
 3 files changed, 645 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3d056e7da65f..1aa47087c1a2 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1917,6 +1917,10 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
 	bool
 
+config CRYPTO_ESSIV
+	tristate
+	select CRYPTO_AUTHENC
+
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
diff --git a/crypto/Makefile b/crypto/Makefile
index 266a4cdbb9e2..ad1d99ba6d56 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_CRYPTO_USER_API_AEAD) += algif_aead.o
 obj-$(CONFIG_CRYPTO_ZSTD) += zstd.o
 obj-$(CONFIG_CRYPTO_OFB) += ofb.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
+obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
diff --git a/crypto/essiv.c b/crypto/essiv.c
new file mode 100644
index 000000000000..417d60e593dc
--- /dev/null
+++ b/crypto/essiv.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESSIV skcipher and aead template for block encryption
+ *
+ * This template encapsulates the ESSIV IV generation algorithm used by
+ * dm-crypt and fscrypt, which converts the initial vector for the skcipher
+ * used for block encryption, by encrypting it using the hash of the
+ * skcipher key as encryption key. Usually, the input IV is a 64-bit sector
+ * number in LE representation zero-padded to the size of the IV, but this
+ * is not assumed by this driver.
+ *
+ * The typical use of this template is to instantiate the skcipher
+ * 'essiv(cbc(aes),aes,sha256)', which is the only instantiation used by
+ * fscrypt, and the most relevant one for dm-crypt. However, dm-crypt
+ * also permits ESSIV to be used in combination with the authenc template,
+ * e.g., 'essiv(authenc(hmac(sha256),cbc(aes)),aes,sha256)', in which case
+ * we need to instantiate an aead that accepts the same special key format
+ * as the authenc template, and deals with the way the encrypted IV is
+ * embedded into the AAD area of the aead request. This means the AEAD
+ * flavor produced by this template is tightly coupled to the way dm-crypt
+ * happens to use it.
+ *
+ * Copyright (c) 2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * Heavily based on:
+ * adiantum length-preserving encryption mode
+ *
+ * Copyright 2018 Google LLC
+ */
+
+#include <crypto/authenc.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+struct essiv_instance_ctx {
+	union {
+		struct crypto_skcipher_spawn	skcipher_spawn;
+		struct crypto_aead_spawn	aead_spawn;
+	} u;
+	struct crypto_spawn			essiv_cipher_spawn;
+	struct crypto_shash_spawn		hash_spawn;
+};
+
+struct essiv_tfm_ctx {
+	union {
+		struct crypto_skcipher	*skcipher;
+		struct crypto_aead	*aead;
+	} u;
+	struct crypto_cipher		*essiv_cipher;
+	struct crypto_shash		*hash;
+	int				ivoffset;
+};
+
+struct essiv_aead_request_ctx {
+	struct scatterlist		sg[4];
+	u8				*assoc;
+	struct aead_request		aead_req;
+};
+
+static int essiv_skcipher_setkey(struct crypto_skcipher *tfm,
+				 const u8 *key, unsigned int keylen)
+{
+	struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	SHASH_DESC_ON_STACK(desc, tctx->hash);
+	u8 salt[HASH_MAX_DIGESTSIZE];
+	int err;
+
+	crypto_skcipher_clear_flags(tctx->u.skcipher, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(tctx->u.skcipher,
+				  crypto_skcipher_get_flags(tfm) &
+				  CRYPTO_TFM_REQ_MASK);
+	err = crypto_skcipher_setkey(tctx->u.skcipher, key, keylen);
+	crypto_skcipher_set_flags(tfm,
+				  crypto_skcipher_get_flags(tctx->u.skcipher) &
+				  CRYPTO_TFM_RES_MASK);
+	if (err)
+		return err;
+
+	desc->tfm = tctx->hash;
+	err = crypto_shash_digest(desc, key, keylen, salt);
+	if (err)
+		return err;
+
+	crypto_cipher_clear_flags(tctx->essiv_cipher, CRYPTO_TFM_REQ_MASK);
+	crypto_cipher_set_flags(tctx->essiv_cipher,
+				crypto_skcipher_get_flags(tfm) &
+				CRYPTO_TFM_REQ_MASK);
+	err = crypto_cipher_setkey(tctx->essiv_cipher, salt,
+				   crypto_shash_digestsize(tctx->hash));
+	crypto_skcipher_set_flags(tfm,
+				  crypto_cipher_get_flags(tctx->essiv_cipher) &
+				  CRYPTO_TFM_RES_MASK);
+
+	return err;
+}
+
+static int essiv_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			     unsigned int keylen)
+{
+	struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	SHASH_DESC_ON_STACK(desc, tctx->hash);
+	struct crypto_authenc_keys keys;
+	u8 salt[HASH_MAX_DIGESTSIZE];
+	int err;
+
+	crypto_aead_clear_flags(tctx->u.aead, CRYPTO_TFM_REQ_MASK);
+	crypto_aead_set_flags(tctx->u.aead, crypto_aead_get_flags(tfm) &
+					    CRYPTO_TFM_REQ_MASK);
+	err = crypto_aead_setkey(tctx->u.aead, key, keylen);
+	crypto_aead_set_flags(tfm, crypto_aead_get_flags(tctx->u.aead) &
+				   CRYPTO_TFM_RES_MASK);
+	if (err)
+		return err;
+
+	if (crypto_authenc_extractkeys(&keys, key, keylen) != 0) {
+		crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+
+	desc->tfm = tctx->hash;
+	err = crypto_shash_init(desc) ?:
+	      crypto_shash_update(desc, keys.enckey, keys.enckeylen) ?:
+	      crypto_shash_finup(desc, keys.authkey, keys.authkeylen, salt);
+	if (err)
+		return err;
+
+	crypto_cipher_clear_flags(tctx->essiv_cipher, CRYPTO_TFM_REQ_MASK);
+	crypto_cipher_set_flags(tctx->essiv_cipher, crypto_aead_get_flags(tfm) &
+						    CRYPTO_TFM_REQ_MASK);
+	err = crypto_cipher_setkey(tctx->essiv_cipher, salt,
+				   crypto_shash_digestsize(tctx->hash));
+	crypto_aead_set_flags(tfm, crypto_cipher_get_flags(tctx->essiv_cipher) &
+				   CRYPTO_TFM_RES_MASK);
+
+	return err;
+}
+
+static int essiv_aead_setauthsize(struct crypto_aead *tfm,
+				  unsigned int authsize)
+{
+	struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	return crypto_aead_setauthsize(tctx->u.aead, authsize);
+}
+
+static void essiv_skcipher_done(struct crypto_async_request *areq, int err)
+{
+	struct skcipher_request *req = areq->data;
+
+	skcipher_request_complete(req, err);
+}
+
+static int essiv_skcipher_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_request *subreq = skcipher_request_ctx(req);
+
+	crypto_cipher_encrypt_one(tctx->essiv_cipher, req->iv, req->iv);
+
+	skcipher_request_set_tfm(subreq, tctx->u.skcipher);
+	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
+				   req->iv);
+	skcipher_request_set_callback(subreq, skcipher_request_flags(req),
+				      essiv_skcipher_done, req);
+
+	return enc ? crypto_skcipher_encrypt(subreq) :
+		     crypto_skcipher_decrypt(subreq);
+}
+
+static int essiv_skcipher_encrypt(struct skcipher_request *req)
+{
+	return essiv_skcipher_crypt(req, true);
+}
+
+static int essiv_skcipher_decrypt(struct skcipher_request *req)
+{
+	return essiv_skcipher_crypt(req, false);
+}
+
+static void essiv_aead_done(struct crypto_async_request *areq, int err)
+{
+	struct aead_request *req = areq->data;
+	struct essiv_aead_request_ctx *rctx = aead_request_ctx(req);
+
+	if (rctx->assoc)
+		kfree(rctx->assoc);
+	aead_request_complete(req, err);
+}
+
+static int essiv_aead_crypt(struct aead_request *req, bool enc)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	const struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct essiv_aead_request_ctx *rctx = aead_request_ctx(req);
+	struct aead_request *subreq = &rctx->aead_req;
+	struct scatterlist *src = req->src;
+	int err;
+
+	crypto_cipher_encrypt_one(tctx->essiv_cipher, req->iv, req->iv);
+
+	/*
+	 * dm-crypt embeds the sector number and the IV in the AAD region, so
+	 * we have to copy the converted IV into the right scatterlist before
+	 * we pass it on.
+	 */
+	rctx->assoc = NULL;
+	if (req->src == req->dst || !enc) {
+		scatterwalk_map_and_copy(req->iv, req->dst,
+					 req->assoclen - crypto_aead_ivsize(tfm),
+					 crypto_aead_ivsize(tfm), 1);
+	} else {
+		u8 *iv = (u8 *)aead_request_ctx(req) + tctx->ivoffset;
+		int ivsize = crypto_aead_ivsize(tfm);
+		int ssize = req->assoclen - ivsize;
+		struct scatterlist *sg;
+		int nents;
+
+		if (ssize < 0)
+			return -EINVAL;
+
+		nents = sg_nents_for_len(req->src, ssize);
+		if (nents < 0)
+			return -EINVAL;
+
+		memcpy(iv, req->iv, ivsize);
+		sg_init_table(rctx->sg, 4);
+
+		if (unlikely(nents > 1)) {
+			/*
+			 * This is a case that rarely occurs in practice, but
+			 * for correctness, we have to deal with it nonetheless.
+			 */
+			rctx->assoc = kmalloc(ssize, GFP_ATOMIC);
+			if (!rctx->assoc)
+				return -ENOMEM;
+
+			scatterwalk_map_and_copy(rctx->assoc, req->src, 0,
+						 ssize, 0);
+			sg_set_buf(rctx->sg, rctx->assoc, ssize);
+		} else {
+			sg_set_page(rctx->sg, sg_page(req->src), ssize,
+				    req->src->offset);
+		}
+
+		sg_set_buf(rctx->sg + 1, iv, ivsize);
+		sg = scatterwalk_ffwd(rctx->sg + 2, req->src, req->assoclen);
+		if (sg != rctx->sg + 2)
+			sg_chain(rctx->sg, 3, sg);
+
+		src = rctx->sg;
+	}
+
+	aead_request_set_tfm(subreq, tctx->u.aead);
+	aead_request_set_ad(subreq, req->assoclen);
+	aead_request_set_callback(subreq, aead_request_flags(req),
+				  essiv_aead_done, req);
+	aead_request_set_crypt(subreq, src, req->dst, req->cryptlen, req->iv);
+
+	err = enc ? crypto_aead_encrypt(subreq) :
+		    crypto_aead_decrypt(subreq);
+
+	if (rctx->assoc && err != -EINPROGRESS)
+		kfree(rctx->assoc);
+	return err;
+}
+
+static int essiv_aead_encrypt(struct aead_request *req)
+{
+	return essiv_aead_crypt(req, true);
+}
+
+static int essiv_aead_decrypt(struct aead_request *req)
+{
+	return essiv_aead_crypt(req, false);
+}
+
+static int essiv_init_tfm(struct essiv_instance_ctx *ictx,
+			  struct essiv_tfm_ctx *tctx)
+{
+	struct crypto_cipher *essiv_cipher;
+	struct crypto_shash *hash;
+	int err;
+
+	essiv_cipher = crypto_spawn_cipher(&ictx->essiv_cipher_spawn);
+	if (IS_ERR(essiv_cipher))
+		return PTR_ERR(essiv_cipher);
+
+	hash = crypto_spawn_shash(&ictx->hash_spawn);
+	if (IS_ERR(hash)) {
+		err = PTR_ERR(hash);
+		goto err_free_essiv_cipher;
+	}
+
+	tctx->essiv_cipher = essiv_cipher;
+	tctx->hash = hash;
+
+	return 0;
+
+err_free_essiv_cipher:
+	crypto_free_cipher(essiv_cipher);
+	return err;
+}
+
+static int essiv_skcipher_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct skcipher_instance *inst = skcipher_alg_instance(tfm);
+	struct essiv_instance_ctx *ictx = skcipher_instance_ctx(inst);
+	struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct crypto_skcipher *skcipher;
+	int err;
+
+	skcipher = crypto_spawn_skcipher(&ictx->u.skcipher_spawn);
+	if (IS_ERR(skcipher))
+		return PTR_ERR(skcipher);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct skcipher_request) +
+				         crypto_skcipher_reqsize(skcipher));
+
+	err = essiv_init_tfm(ictx, tctx);
+	if (err) {
+		crypto_free_skcipher(skcipher);
+		return err;
+	}
+
+	tctx->u.skcipher = skcipher;
+	return 0;
+}
+
+static int essiv_aead_init_tfm(struct crypto_aead *tfm)
+{
+	struct aead_instance *inst = aead_alg_instance(tfm);
+	struct essiv_instance_ctx *ictx = aead_instance_ctx(inst);
+	struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct crypto_aead *aead;
+	unsigned int subreq_size;
+	int err;
+
+	BUILD_BUG_ON(offsetofend(struct essiv_aead_request_ctx, aead_req) !=
+		     sizeof(struct essiv_aead_request_ctx));
+
+	aead = crypto_spawn_aead(&ictx->u.aead_spawn);
+	if (IS_ERR(aead))
+		return PTR_ERR(aead);
+
+	subreq_size = FIELD_SIZEOF(struct essiv_aead_request_ctx, aead_req) +
+		      crypto_aead_reqsize(aead);
+
+	tctx->ivoffset = offsetof(struct essiv_aead_request_ctx, aead_req) +
+			 subreq_size;
+	crypto_aead_set_reqsize(tfm, tctx->ivoffset + crypto_aead_ivsize(aead));
+
+	err = essiv_init_tfm(ictx, tctx);
+	if (err) {
+		crypto_free_aead(aead);
+		return err;
+	}
+
+	tctx->u.aead = aead;
+	return 0;
+}
+
+static void essiv_skcipher_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	crypto_free_skcipher(tctx->u.skcipher);
+	crypto_free_cipher(tctx->essiv_cipher);
+	crypto_free_shash(tctx->hash);
+}
+
+static void essiv_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct essiv_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	crypto_free_aead(tctx->u.aead);
+	crypto_free_cipher(tctx->essiv_cipher);
+	crypto_free_shash(tctx->hash);
+}
+
+static void essiv_skcipher_free_instance(struct skcipher_instance *inst)
+{
+	struct essiv_instance_ctx *ictx = skcipher_instance_ctx(inst);
+
+	crypto_drop_skcipher(&ictx->u.skcipher_spawn);
+	crypto_drop_spawn(&ictx->essiv_cipher_spawn);
+	crypto_drop_shash(&ictx->hash_spawn);
+	kfree(inst);
+}
+
+static void essiv_aead_free_instance(struct aead_instance *inst)
+{
+	struct essiv_instance_ctx *ictx = aead_instance_ctx(inst);
+
+	crypto_drop_aead(&ictx->u.aead_spawn);
+	crypto_drop_spawn(&ictx->essiv_cipher_spawn);
+	crypto_drop_shash(&ictx->hash_spawn);
+	kfree(inst);
+}
+
+static bool essiv_supported_algorithms(struct crypto_alg *essiv_cipher_alg,
+				       struct shash_alg *hash_alg,
+				       int ivsize)
+{
+	if (hash_alg->digestsize < essiv_cipher_alg->cra_cipher.cia_min_keysize ||
+	    hash_alg->digestsize > essiv_cipher_alg->cra_cipher.cia_max_keysize)
+		return false;
+
+	if (ivsize != essiv_cipher_alg->cra_blocksize)
+		return false;
+
+	if (crypto_shash_alg_has_setkey(hash_alg))
+		return false;
+
+	return true;
+}
+
+static int essiv_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	struct crypto_attr_type *algt;
+	const char *inner_cipher_name;
+	const char *essiv_cipher_name;
+	const char *shash_name;
+	struct skcipher_instance *skcipher_inst = NULL;
+	struct aead_instance *aead_inst = NULL;
+	struct crypto_instance *inst;
+	struct crypto_alg *base, *block_base;
+	struct essiv_instance_ctx *ictx;
+	struct skcipher_alg *skcipher_alg = NULL;
+	struct aead_alg *aead_alg = NULL;
+	struct crypto_alg *essiv_cipher_alg;
+	struct crypto_alg *_hash_alg;
+	struct shash_alg *hash_alg;
+	int ivsize;
+	u32 type;
+	int err;
+
+	algt = crypto_get_attr_type(tb);
+	if (IS_ERR(algt))
+		return PTR_ERR(algt);
+
+	inner_cipher_name = crypto_attr_alg_name(tb[1]);
+	if (IS_ERR(inner_cipher_name))
+		return PTR_ERR(inner_cipher_name);
+
+	essiv_cipher_name = crypto_attr_alg_name(tb[2]);
+	if (IS_ERR(essiv_cipher_name))
+		return PTR_ERR(essiv_cipher_name);
+
+	shash_name = crypto_attr_alg_name(tb[3]);
+	if (IS_ERR(shash_name))
+		return PTR_ERR(shash_name);
+
+	type = algt->type & algt->mask;
+
+	switch (type) {
+	case CRYPTO_ALG_TYPE_BLKCIPHER:
+		skcipher_inst = kzalloc(sizeof(*skcipher_inst) +
+					sizeof(*ictx), GFP_KERNEL);
+		if (!skcipher_inst)
+			return -ENOMEM;
+		inst = skcipher_crypto_instance(skcipher_inst);
+		base = &skcipher_inst->alg.base;
+		ictx = crypto_instance_ctx(inst);
+
+		/* Block cipher, e.g. "cbc(aes)" */
+		crypto_set_skcipher_spawn(&ictx->u.skcipher_spawn, inst);
+		err = crypto_grab_skcipher(&ictx->u.skcipher_spawn,
+					   inner_cipher_name, 0,
+					   crypto_requires_sync(algt->type,
+								algt->mask));
+		if (err)
+			goto out_free_inst;
+		skcipher_alg = crypto_spawn_skcipher_alg(&ictx->u.skcipher_spawn);
+		block_base = &skcipher_alg->base;
+		ivsize = crypto_skcipher_alg_ivsize(skcipher_alg);
+		break;
+
+	case CRYPTO_ALG_TYPE_AEAD:
+		aead_inst = kzalloc(sizeof(*aead_inst) +
+				    sizeof(*ictx), GFP_KERNEL);
+		if (!aead_inst)
+			return -ENOMEM;
+		inst = aead_crypto_instance(aead_inst);
+		base = &aead_inst->alg.base;
+		ictx = crypto_instance_ctx(inst);
+
+		/* AEAD cipher, e.g. "authenc(hmac(sha256),cbc(aes))" */
+		crypto_set_aead_spawn(&ictx->u.aead_spawn, inst);
+		err = crypto_grab_aead(&ictx->u.aead_spawn,
+				       inner_cipher_name, 0,
+				       crypto_requires_sync(algt->type,
+							    algt->mask));
+		if (err)
+			goto out_free_inst;
+		aead_alg = crypto_spawn_aead_alg(&ictx->u.aead_spawn);
+		block_base = &aead_alg->base;
+		ivsize = aead_alg->ivsize;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Block cipher, e.g. "aes" */
+	crypto_set_spawn(&ictx->essiv_cipher_spawn, inst);
+	err = crypto_grab_spawn(&ictx->essiv_cipher_spawn, essiv_cipher_name,
+				CRYPTO_ALG_TYPE_CIPHER, CRYPTO_ALG_TYPE_MASK);
+	if (err)
+		goto out_drop_skcipher;
+	essiv_cipher_alg = ictx->essiv_cipher_spawn.alg;
+
+	/* Synchronous hash, e.g., "sha256" */
+	_hash_alg = crypto_alg_mod_lookup(shash_name,
+					  CRYPTO_ALG_TYPE_SHASH,
+					  CRYPTO_ALG_TYPE_MASK);
+	if (IS_ERR(_hash_alg)) {
+		err = PTR_ERR(_hash_alg);
+		goto out_drop_essiv_cipher;
+	}
+	hash_alg = __crypto_shash_alg(_hash_alg);
+	err = crypto_init_shash_spawn(&ictx->hash_spawn, hash_alg, inst);
+	if (err)
+		goto out_put_hash;
+
+	/* Check the set of algorithms */
+	if (!essiv_supported_algorithms(essiv_cipher_alg, hash_alg, ivsize)) {
+		pr_warn("Unsupported essiv instantiation: essiv(%s,%s,%s)\n",
+			block_base->cra_name,
+			essiv_cipher_alg->cra_name,
+			hash_alg->base.cra_name);
+		err = -EINVAL;
+		goto out_drop_hash;
+	}
+
+	/* Instance fields */
+
+	err = -ENAMETOOLONG;
+	if (snprintf(base->cra_name, CRYPTO_MAX_ALG_NAME,
+		     "essiv(%s,%s,%s)", block_base->cra_name,
+		     essiv_cipher_alg->cra_name,
+		     hash_alg->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
+		goto out_drop_hash;
+	if (snprintf(base->cra_driver_name, CRYPTO_MAX_ALG_NAME,
+		     "essiv(%s,%s,%s)",
+		     block_base->cra_driver_name,
+		     essiv_cipher_alg->cra_driver_name,
+		     hash_alg->base.cra_driver_name) >= CRYPTO_MAX_ALG_NAME)
+		goto out_drop_hash;
+
+	base->cra_flags		= block_base->cra_flags & CRYPTO_ALG_ASYNC;
+	base->cra_blocksize	= block_base->cra_blocksize;
+	base->cra_ctxsize	= sizeof(struct essiv_tfm_ctx);
+	base->cra_alignmask	= block_base->cra_alignmask;
+	base->cra_priority	= block_base->cra_priority;
+
+	if (type == CRYPTO_ALG_TYPE_BLKCIPHER) {
+		skcipher_inst->alg.setkey	= essiv_skcipher_setkey;
+		skcipher_inst->alg.encrypt	= essiv_skcipher_encrypt;
+		skcipher_inst->alg.decrypt	= essiv_skcipher_decrypt;
+		skcipher_inst->alg.init		= essiv_skcipher_init_tfm;
+		skcipher_inst->alg.exit		= essiv_skcipher_exit_tfm;
+
+		skcipher_inst->alg.min_keysize	= crypto_skcipher_alg_min_keysize(skcipher_alg);
+		skcipher_inst->alg.max_keysize	= crypto_skcipher_alg_max_keysize(skcipher_alg);
+		skcipher_inst->alg.ivsize	= crypto_skcipher_alg_ivsize(skcipher_alg);
+		skcipher_inst->alg.chunksize	= crypto_skcipher_alg_chunksize(skcipher_alg);
+		skcipher_inst->alg.walksize	= crypto_skcipher_alg_walksize(skcipher_alg);
+
+		skcipher_inst->free		= essiv_skcipher_free_instance;
+
+		err = skcipher_register_instance(tmpl, skcipher_inst);
+	} else {
+		aead_inst->alg.setkey		= essiv_aead_setkey;
+		aead_inst->alg.setauthsize	= essiv_aead_setauthsize;
+		aead_inst->alg.encrypt		= essiv_aead_encrypt;
+		aead_inst->alg.decrypt		= essiv_aead_decrypt;
+		aead_inst->alg.init		= essiv_aead_init_tfm;
+		aead_inst->alg.exit		= essiv_aead_exit_tfm;
+
+		aead_inst->alg.ivsize		= crypto_aead_alg_ivsize(aead_alg);
+		aead_inst->alg.maxauthsize	= crypto_aead_alg_maxauthsize(aead_alg);
+		aead_inst->alg.chunksize	= crypto_aead_alg_chunksize(aead_alg);
+
+		aead_inst->free			= essiv_aead_free_instance;
+
+		err = aead_register_instance(tmpl, aead_inst);
+	}
+
+	if (err)
+		goto out_drop_hash;
+
+	crypto_mod_put(_hash_alg);
+	return 0;
+
+out_drop_hash:
+	crypto_drop_shash(&ictx->hash_spawn);
+out_put_hash:
+	crypto_mod_put(_hash_alg);
+out_drop_essiv_cipher:
+	crypto_drop_spawn(&ictx->essiv_cipher_spawn);
+out_drop_skcipher:
+	if (type == CRYPTO_ALG_TYPE_BLKCIPHER)
+		crypto_drop_skcipher(&ictx->u.skcipher_spawn);
+	else
+		crypto_drop_aead(&ictx->u.aead_spawn);
+out_free_inst:
+	kfree(skcipher_inst);
+	kfree(aead_inst);
+	return err;
+}
+
+/* essiv(inner_cipher_name, essiv_cipher_name, shash_name) */
+static struct crypto_template essiv_tmpl = {
+	.name	= "essiv",
+	.create	= essiv_create,
+	.module	= THIS_MODULE,
+};
+
+static int __init essiv_module_init(void)
+{
+	return crypto_register_template(&essiv_tmpl);
+}
+
+static void __exit essiv_module_exit(void)
+{
+	crypto_unregister_template(&essiv_tmpl);
+}
+
+subsys_initcall(essiv_module_init);
+module_exit(essiv_module_exit);
+
+MODULE_DESCRIPTION("ESSIV skcipher/aead wrapper for block encryption");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("essiv");
-- 
2.20.1

