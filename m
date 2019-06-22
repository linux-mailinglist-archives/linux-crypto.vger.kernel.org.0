Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66B84F2B5
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Jun 2019 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFVAcJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Jun 2019 20:32:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53126 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVAcG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Jun 2019 20:32:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so7718179wms.2
        for <linux-crypto@vger.kernel.org>; Fri, 21 Jun 2019 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvCQRfOP2GyB1vKcLOKImMUkTNgEYkoALm6jTAaS9J0=;
        b=gM+yZUpfvZpOXxitltEj8QbMED7HtH4P9DQTqE5klWQneC+cIt+BpcCD7onChWs/TX
         pEnlISLoj0GmzasJepkdmokCbHg4IJInny5yTaPkMGdc8MQPuHU6guKyL+PY4dHWCApq
         Otd76Ufn2vbMHN7JRnITDycPlhlx2Fssz7QzdelgyYQH+luzfKdpdUOBB9e/4itb5Bfm
         GQNyFvu0Uy0J+Qc4eVDNEUBIQ2UdWD5judY3di2Xj9EmlJreLwYIVlk2ZcfNIvwQ3Tp+
         Igis90rpESdkxLqwmlP5KQuut38RFM4sS5cdgBgEWz0JoKjcBxO9dWnOlUtyT6Yt+3M0
         kCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvCQRfOP2GyB1vKcLOKImMUkTNgEYkoALm6jTAaS9J0=;
        b=WNyqEI+iZuRDZVJdApqHN17hjzmunnk3FdjCJrDzu2C0Os3of6JK3oudwkw2uWFbLd
         9QwPSjj7UltDWZYWSiL6ufkuso9l7W4sx1ydK2tEMONXD8orNMWv3refe3R0XJggMKgj
         A7qWhcCzjkJKBfY1QxGo8yDEUhp6hsD4n6xI+TUB9KOOk/BzqTskZ1fizxVZq7K4nuB8
         yZreBni5dln6yyS3bTzk7bjzOylKL6GOOjitDyMAPks87g3qa/5rFKc4UXThDK1HDIQ+
         84bn88m1WAXEfQbyD0KN1lbfAOU4+5zHDA9jzFySrb6TjsqN2wl+ZG7g+vuy92E9gyZ1
         A0aw==
X-Gm-Message-State: APjAAAWePLIyYo6XwJvFEc7/GklK+kBKy8MoZ8x3gnIJ5ptFVJFDZmnx
        ss2m2PZVvsfODHqOTbFXGLRcyzX5IbBY09s6
X-Google-Smtp-Source: APXvYqzPEfc6XimIxoXxYSdbc3Nc04hHfBE9R6piG5vGIPaxRS3Zi6hNDKGHb4rmJogk5m5d5kGgdg==
X-Received: by 2002:a1c:7a01:: with SMTP id v1mr5876112wmc.10.1561163525372;
        Fri, 21 Jun 2019 17:32:05 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:99d4:1ff0:ed6:dfbb])
        by smtp.gmail.com with ESMTPSA id v18sm4792019wrd.51.2019.06.21.17.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 17:32:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@google.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 20/30] crypto: rk3288/des - switch to new verification routines
Date:   Sat, 22 Jun 2019 02:31:02 +0200
Message-Id: <20190622003112.31033-21-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622003112.31033-1-ard.biesheuvel@linaro.org>
References: <20190622003112.31033-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/rockchip/rk3288_crypto.h            |  2 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 54ee5b3ed9db..18e2b3f29336 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -3,7 +3,7 @@
 #define __RK3288_CRYPTO_H__
 
 #include <crypto/aes.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/algapi.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c b/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
index 313759521a0f..1c24602bac83 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
@@ -50,14 +50,11 @@ static int rk_des_setkey(struct crypto_ablkcipher *cipher,
 			 const u8 *key, unsigned int keylen)
 {
 	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 tmp[DES_EXPKEY_WORDS];
+	int err;
 
-	if (!des_ekey(tmp, key) &&
-	    (tfm->crt_flags & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_WEAK_KEY;
-		return -EINVAL;
-	}
+	err = crypto_des_verify_key(crypto_ablkcipher_tfm(cipher), key, keylen);
+	if (unlikely(err))
+		return err;
 
 	ctx->keylen = keylen;
 	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
@@ -68,15 +65,12 @@ static int rk_tdes_setkey(struct crypto_ablkcipher *cipher,
 			  const u8 *key, unsigned int keylen)
 {
 	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(cipher);
-	u32 flags;
 	int err;
 
-	flags = crypto_ablkcipher_get_flags(cipher);
-	err = __des3_verify_key(&flags, key);
-	if (unlikely(err)) {
-		crypto_ablkcipher_set_flags(cipher, flags);
+	err = crypto_des3_ede_verify_key(crypto_ablkcipher_tfm(cipher), key,
+					 keylen);
+	if (unlikely(err))
 		return err;
-	}
 
 	ctx->keylen = keylen;
 	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
-- 
2.20.1

