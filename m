Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19E04F2B4
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Jun 2019 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfFVAcF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Jun 2019 20:32:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35815 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVAcF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Jun 2019 20:32:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so8142425wrv.2
        for <linux-crypto@vger.kernel.org>; Fri, 21 Jun 2019 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8daLmjOEf04g8WjHQNmRajwguwqmG3XocInKtjiqrg=;
        b=w51YrzvCWbrepL3Q6zlCS5U778Lf7vRAL7MmEwnPFOwHpAZbu+UkJ2HnMNiGbn+/Gg
         GHbnKPg1kXazV4Uk0yrOckglvRWQ5uhez8LrIT25teYPTQUt6n6xQpnmi8dgsK+Y0z01
         tZI37rPOBs177RTsRxXa54NJ/UuFIILtpCF1GZRAyPnjB/+ug3+96Ljy2PJBMsRr3jwE
         flN1eT95sgreJpTLXDWc1NTLd6wQTkxfP6wP/HqVereLAZwFvqSnzJFic5gyvGiOipFL
         MF1o2qKCb2gs/hVXKDAB53I16jCxqVqGoJpx7C10dUwKUkiRRo/fQWTKMuXt8X0rmOuF
         ExTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8daLmjOEf04g8WjHQNmRajwguwqmG3XocInKtjiqrg=;
        b=LNdGLP09zdEp1fvxRH5v13+S14UyCfxPu/Y7v5FtawjYP2wD7YLUN8swTPqeJNu8yy
         IfMuU0oMGPd8a/Ho1o+9BMw3ShnuqJKxd6DYMMaSkmb3usOdDnrSN3keMidef/f9RWrx
         yHoQLqxjPILW8N//2c+3msMKt4Y1Vlir/inMmxGQT4KLx0QWG4Q6WJ5uxuTqNM6Swdrz
         RebKjMYU4Y77zhjDDq4tXL71lpzZXKCOMLsI9CqctLp4ruug9M4xn07IkDghI2nTnFuZ
         fOU2m9OgDzgLNYkdeCrJINdPa9OgIuE21TGD/nMVnG0shmMqgQ2E7qYwARcv1PXZXAEd
         cG1w==
X-Gm-Message-State: APjAAAXUNtUSgMnuY3Ucu+C3+KJC6PhfD/6QnUNKXmbqcl5edHtC29ug
        EJeyumaLWbV4BAQLrcIewDITOziY6WonD4co
X-Google-Smtp-Source: APXvYqz7uEk4hZtoNfMWI6RriFgHFsvPVLWHB5BcpiV+nLH5KAx+reoNJRxzUl2K6Pz+GUecNUvONg==
X-Received: by 2002:a5d:430c:: with SMTP id h12mr14668897wrq.163.1561163523178;
        Fri, 21 Jun 2019 17:32:03 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:99d4:1ff0:ed6:dfbb])
        by smtp.gmail.com with ESMTPSA id v18sm4792019wrd.51.2019.06.21.17.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 17:32:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@google.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH 18/30] crypto: picoxcell/des - switch to new verification routines
Date:   Sat, 22 Jun 2019 02:31:00 +0200
Message-Id: <20190622003112.31033-19-ard.biesheuvel@linaro.org>
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
 drivers/crypto/picoxcell_crypto.c | 23 +++++++-------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 05b89e703903..a7ee17e475ae 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -19,7 +19,7 @@
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/authenc.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/md5.h>
 #include <crypto/sha.h>
 #include <crypto/internal/skcipher.h>
@@ -749,16 +749,12 @@ static void spacc_aead_cra_exit(struct crypto_aead *tfm)
 static int spacc_des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 			    unsigned int len)
 {
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
 	struct spacc_ablk_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 tmp[DES_EXPKEY_WORDS];
+	int err;
 
-	if (unlikely(!des_ekey(tmp, key)) &&
-	    (crypto_ablkcipher_get_flags(cipher) &
-	     CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_WEAK_KEY;
-		return -EINVAL;
-	}
+	err = crypto_des_verify_key(crypto_ablkcipher_tfm(cipher), key, keylen);
+	if (unlikely(err))
+		return err;
 
 	memcpy(ctx->key, key, len);
 	ctx->key_len = len;
@@ -774,15 +770,12 @@ static int spacc_des3_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 			     unsigned int len)
 {
 	struct spacc_ablk_ctx *ctx = crypto_ablkcipher_ctx(cipher);
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
 
 	memcpy(ctx->key, key, len);
 	ctx->key_len = len;
-- 
2.20.1

