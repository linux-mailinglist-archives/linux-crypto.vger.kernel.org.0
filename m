Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A9D58050
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF0K2L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37182 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfF0K2J (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so5110682wme.2
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8xE/gQHhxeiNIomdxtjEbSnrgED29gmEg1crTL/DPU=;
        b=OejxQjIB89BU767t4fgihO4UHbWl0rBGHTZQd3ZnLY881ZcQJ0ntfukXV4fHgYcCuy
         ndpnYg/d0svy9LXIllcwqjm+6s7pgrFo43EZ0HyL9AQZ+snX9awFlASOiS57xNl0w8wF
         0OSdh8WvgqrNF/68j4LZQk8OI/rTKJ2DBvxdT5OPYSleBls80ueI0kDI0Ttw7VB0H7BA
         64r73PyWeq3YCGCYatu9gz7WgmVxXTLCkRlbRVSZJyjPAG17CJkbZITq1+qm6pEp+eDX
         qonMTEDOjWPEqFixD/kkk4FWL9dLAgIu7Wefb4nFehxGSB08DzBV38oiJlqCIdo1lm/G
         S4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8xE/gQHhxeiNIomdxtjEbSnrgED29gmEg1crTL/DPU=;
        b=qDTsTLGcVf4K53BIj1a/fk56Cz4RN6J75tn+NfBaGiWeT/uaaMkT/7RTTCJEG4Zyjd
         4P/U93tvswy7wzgY35SY7m0iaEw7/v+RQg1D0mwWpLIbDEMvKrohyaYuMrK/g93Qec7e
         egMvvt6aaImrK2S5PwYGtpZApLMUyTZDJImETjgnUkqdCVtjtXKDW7uoM1zSXqhI2+eY
         jsC/p0hxuNkKVMpHt1YDshb19VD+Hx+7igH1hG9G5hdxhMWiNWzEeWryuI/ofr8glbGG
         xlPrdjjSmimzs0JSDvIrxjRZIFUU2kzMRHsOnGrJjEh+bi2BRvG0N+Huf+iPa2fwoNRb
         f8pg==
X-Gm-Message-State: APjAAAUExuM2K4j2vvOv3idN817GtIzCP0spWv+gl1celM8LHLIaa0Lx
        ZvCI1406JPO5hGor1HV1+tuPQdx1Mts=
X-Google-Smtp-Source: APXvYqx6Cw8vTLGZ79Y4fnpv7UD4+xe7tqiQY7STSaDkNwxsRwKAxbmsVPZb77HefOwEhM+7ylK6IA==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr2804977wmt.109.1561631286922;
        Thu, 27 Jun 2019 03:28:06 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:06 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 15/32] crypto: generic/aes - drop key expansion routine in favor of library version
Date:   Thu, 27 Jun 2019 12:26:30 +0200
Message-Id: <20190627102647.2992-16-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Drop aes-generic's version of crypto_aes_expand_key(), and switch to
the key expansion routine provided by the AES library. AES key expansion
is not performance critical, and it is better to have a single version
shared by all AES implementations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/Kconfig       |   1 +
 crypto/aes_generic.c | 153 +-------------------
 include/crypto/aes.h |   2 -
 3 files changed, 3 insertions(+), 153 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index df6f0be66574..80ea118600ab 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1072,6 +1072,7 @@ config CRYPTO_LIB_AES
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
 	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
 	  algorithm.
diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 3aa4a715c216..426deb437f19 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -1125,155 +1125,6 @@ EXPORT_SYMBOL_GPL(crypto_fl_tab);
 EXPORT_SYMBOL_GPL(crypto_it_tab);
 EXPORT_SYMBOL_GPL(crypto_il_tab);
 
-/* initialise the key schedule from the user supplied key */
-
-#define star_x(x) (((x) & 0x7f7f7f7f) << 1) ^ ((((x) & 0x80808080) >> 7) * 0x1b)
-
-#define imix_col(y, x)	do {		\
-	u	= star_x(x);		\
-	v	= star_x(u);		\
-	w	= star_x(v);		\
-	t	= w ^ (x);		\
-	(y)	= u ^ v ^ w;		\
-	(y)	^= ror32(u ^ t, 8) ^	\
-		ror32(v ^ t, 16) ^	\
-		ror32(t, 24);		\
-} while (0)
-
-#define ls_box(x)		\
-	crypto_fl_tab[0][byte(x, 0)] ^	\
-	crypto_fl_tab[1][byte(x, 1)] ^	\
-	crypto_fl_tab[2][byte(x, 2)] ^	\
-	crypto_fl_tab[3][byte(x, 3)]
-
-#define loop4(i)	do {		\
-	t = ror32(t, 8);		\
-	t = ls_box(t) ^ rco_tab[i];	\
-	t ^= ctx->key_enc[4 * i];		\
-	ctx->key_enc[4 * i + 4] = t;		\
-	t ^= ctx->key_enc[4 * i + 1];		\
-	ctx->key_enc[4 * i + 5] = t;		\
-	t ^= ctx->key_enc[4 * i + 2];		\
-	ctx->key_enc[4 * i + 6] = t;		\
-	t ^= ctx->key_enc[4 * i + 3];		\
-	ctx->key_enc[4 * i + 7] = t;		\
-} while (0)
-
-#define loop6(i)	do {		\
-	t = ror32(t, 8);		\
-	t = ls_box(t) ^ rco_tab[i];	\
-	t ^= ctx->key_enc[6 * i];		\
-	ctx->key_enc[6 * i + 6] = t;		\
-	t ^= ctx->key_enc[6 * i + 1];		\
-	ctx->key_enc[6 * i + 7] = t;		\
-	t ^= ctx->key_enc[6 * i + 2];		\
-	ctx->key_enc[6 * i + 8] = t;		\
-	t ^= ctx->key_enc[6 * i + 3];		\
-	ctx->key_enc[6 * i + 9] = t;		\
-	t ^= ctx->key_enc[6 * i + 4];		\
-	ctx->key_enc[6 * i + 10] = t;		\
-	t ^= ctx->key_enc[6 * i + 5];		\
-	ctx->key_enc[6 * i + 11] = t;		\
-} while (0)
-
-#define loop8tophalf(i)	do {			\
-	t = ror32(t, 8);			\
-	t = ls_box(t) ^ rco_tab[i];		\
-	t ^= ctx->key_enc[8 * i];			\
-	ctx->key_enc[8 * i + 8] = t;			\
-	t ^= ctx->key_enc[8 * i + 1];			\
-	ctx->key_enc[8 * i + 9] = t;			\
-	t ^= ctx->key_enc[8 * i + 2];			\
-	ctx->key_enc[8 * i + 10] = t;			\
-	t ^= ctx->key_enc[8 * i + 3];			\
-	ctx->key_enc[8 * i + 11] = t;			\
-} while (0)
-
-#define loop8(i)	do {				\
-	loop8tophalf(i);				\
-	t  = ctx->key_enc[8 * i + 4] ^ ls_box(t);	\
-	ctx->key_enc[8 * i + 12] = t;			\
-	t ^= ctx->key_enc[8 * i + 5];			\
-	ctx->key_enc[8 * i + 13] = t;			\
-	t ^= ctx->key_enc[8 * i + 6];			\
-	ctx->key_enc[8 * i + 14] = t;			\
-	t ^= ctx->key_enc[8 * i + 7];			\
-	ctx->key_enc[8 * i + 15] = t;			\
-} while (0)
-
-/**
- * crypto_aes_expand_key - Expands the AES key as described in FIPS-197
- * @ctx:	The location where the computed key will be stored.
- * @in_key:	The supplied key.
- * @key_len:	The length of the supplied key.
- *
- * Returns 0 on success. The function fails only if an invalid key size (or
- * pointer) is supplied.
- * The expanded key size is 240 bytes (max of 14 rounds with a unique 16 bytes
- * key schedule plus a 16 bytes key which is used before the first round).
- * The decryption key is prepared for the "Equivalent Inverse Cipher" as
- * described in FIPS-197. The first slot (16 bytes) of each key (enc or dec) is
- * for the initial combination, the second slot for the first round and so on.
- */
-int crypto_aes_expand_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-		unsigned int key_len)
-{
-	u32 i, t, u, v, w, j;
-
-	if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
-			key_len != AES_KEYSIZE_256)
-		return -EINVAL;
-
-	ctx->key_length = key_len;
-
-	ctx->key_enc[0] = get_unaligned_le32(in_key);
-	ctx->key_enc[1] = get_unaligned_le32(in_key + 4);
-	ctx->key_enc[2] = get_unaligned_le32(in_key + 8);
-	ctx->key_enc[3] = get_unaligned_le32(in_key + 12);
-
-	ctx->key_dec[key_len + 24] = ctx->key_enc[0];
-	ctx->key_dec[key_len + 25] = ctx->key_enc[1];
-	ctx->key_dec[key_len + 26] = ctx->key_enc[2];
-	ctx->key_dec[key_len + 27] = ctx->key_enc[3];
-
-	switch (key_len) {
-	case AES_KEYSIZE_128:
-		t = ctx->key_enc[3];
-		for (i = 0; i < 10; ++i)
-			loop4(i);
-		break;
-
-	case AES_KEYSIZE_192:
-		ctx->key_enc[4] = get_unaligned_le32(in_key + 16);
-		t = ctx->key_enc[5] = get_unaligned_le32(in_key + 20);
-		for (i = 0; i < 8; ++i)
-			loop6(i);
-		break;
-
-	case AES_KEYSIZE_256:
-		ctx->key_enc[4] = get_unaligned_le32(in_key + 16);
-		ctx->key_enc[5] = get_unaligned_le32(in_key + 20);
-		ctx->key_enc[6] = get_unaligned_le32(in_key + 24);
-		t = ctx->key_enc[7] = get_unaligned_le32(in_key + 28);
-		for (i = 0; i < 6; ++i)
-			loop8(i);
-		loop8tophalf(i);
-		break;
-	}
-
-	ctx->key_dec[0] = ctx->key_enc[key_len + 24];
-	ctx->key_dec[1] = ctx->key_enc[key_len + 25];
-	ctx->key_dec[2] = ctx->key_enc[key_len + 26];
-	ctx->key_dec[3] = ctx->key_enc[key_len + 27];
-
-	for (i = 4; i < key_len + 24; ++i) {
-		j = key_len + 24 - (i & ~3) + (i & 3);
-		imix_col(ctx->key_dec[j], ctx->key_enc[i]);
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(crypto_aes_expand_key);
-
 /**
  * crypto_aes_set_key - Set the AES key.
  * @tfm:	The %crypto_tfm that is used in the context.
@@ -1281,7 +1132,7 @@ EXPORT_SYMBOL_GPL(crypto_aes_expand_key);
  * @key_len:	The size of the key.
  *
  * Returns 0 on success, on failure the %CRYPTO_TFM_RES_BAD_KEY_LEN flag in tfm
- * is set. The function uses crypto_aes_expand_key() to expand the key.
+ * is set. The function uses aes_expand_key() to expand the key.
  * &crypto_aes_ctx _must_ be the private data embedded in @tfm which is
  * retrieved with crypto_tfm_ctx().
  */
@@ -1292,7 +1143,7 @@ int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 	u32 *flags = &tfm->crt_flags;
 	int ret;
 
-	ret = crypto_aes_expand_key(ctx, in_key, key_len);
+	ret = aes_expandkey(ctx, in_key, key_len);
 	if (!ret)
 		return 0;
 
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index d0067fca0cd0..0a64a977f9b3 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -35,8 +35,6 @@ extern const u32 crypto_il_tab[4][256] ____cacheline_aligned;
 
 int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
-int crypto_aes_expand_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-		unsigned int key_len);
 
 /**
  * aes_expandkey - Expands the AES key as described in FIPS-197
-- 
2.20.1

