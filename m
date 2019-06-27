Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7B58211
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfF0MDo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 08:03:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfF0MDm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 08:03:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so5396632wmj.3
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HboD4VROuuvSQnBndoFi8xj33eFhhiW3nT7m1ffU7k=;
        b=GJhQ+FpqiHab2q5JhLnWlOyLkAry3iAr9aalzJlVBsh1Hcjxv325F1Bf9LzD/qa0Ea
         4rPX2/Vxhz/pWtDM396oz6BFsNIazAXKh7qW+Z7pzZmyQ5L/rJUc7qzA3hCOEQ+PkoDz
         C+rn1fpBNo5ZTMccCSSFAkyaZgRm8jTHG3FejczhsXeymnD6ruiTuh1fLc+Ye2L+johb
         7wrzfuz5zh9WEaQfyG3DFuH25HJDeRosEI3E0gSx1gHoXIQj76YjKiIbybzQmbizzN8q
         hO7Xv8Lt8MpC5MlYcbv5j37b5ynKWQVLUCjUikNQ/kqsOfOZEJF/f5rM4N7f4fRxMo3J
         nPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HboD4VROuuvSQnBndoFi8xj33eFhhiW3nT7m1ffU7k=;
        b=oDizvcdMuAj1fS58AjTWNntq5qlANn2XqDGBxZsFrfZ46hpZlM89ye7PM3QJ4OmlA1
         8A7UvIODkPwl57x/9Jf+zcd6xc3oDmGCNT6lwmFKsKk3JdBNbegEj6cYlgs4CzNpcTBe
         5fg1vA/M6/omP8JcZEBkci6v5+ABEeawQkeVCesIgyR2Bqj3ha1QzFyNFa5undmTw119
         h635Qx1ktR7hXNZYS0aMtyWt07Cb+/Lw6mG4cSgFDazapxOMvQYJOU22zI2rAZkH2O/e
         owsQW5mmdWHUNUKm+cyhOm+vSlw/9G3MmbXILPagcS3DLDx4PQ6ZmlQYgMZuTC8EIi88
         jleg==
X-Gm-Message-State: APjAAAUUWl0OP4vKKrtLid+zEagSn8Wrb9nQU1Ns6drtwNjBHvOyrfSd
        CaNhbAMgtSw1nrTiIa5Nho5wOsNyrN8hgg==
X-Google-Smtp-Source: APXvYqxRGX7qMGGXNnxv+9+iPyGKEsW4YxFd2CsebIVmeJG2of2g/FesOSYdVfusDAWnlofB/bAtLw==
X-Received: by 2002:a1c:a483:: with SMTP id n125mr2957518wme.3.1561637019648;
        Thu, 27 Jun 2019 05:03:39 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id z126sm7732431wmb.32.2019.06.27.05.03.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 05:03:38 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        horia.geanta@nxp.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 12/30] crypto: hisilicon/des - switch to new verification routines
Date:   Thu, 27 Jun 2019 14:02:56 +0200
Message-Id: <20190627120314.7197-13-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627120314.7197-1-ard.biesheuvel@linaro.org>
References: <20190627120314.7197-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/hisilicon/sec/sec_algs.c | 34 ++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec/sec_algs.c b/drivers/crypto/hisilicon/sec/sec_algs.c
index 02768af0dccd..0dc828b9c4a1 100644
--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -9,7 +9,7 @@
 
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/skcipher.h>
 #include <crypto/xts.h>
 #include <crypto/internal/skcipher.h>
@@ -347,8 +347,11 @@ static int sec_alg_skcipher_setkey_aes_xts(struct crypto_skcipher *tfm,
 static int sec_alg_skcipher_setkey_des_ecb(struct crypto_skcipher *tfm,
 					   const u8 *key, unsigned int keylen)
 {
-	if (keylen != DES_KEY_SIZE)
-		return -EINVAL;
+	int err;
+
+	err = crypto_des_verify_key(crypto_skcipher_tfm(tfm), key);
+	if (unlikely(err))
+		return err;
 
 	return sec_alg_skcipher_setkey(tfm, key, keylen, SEC_C_DES_ECB_64);
 }
@@ -356,8 +359,11 @@ static int sec_alg_skcipher_setkey_des_ecb(struct crypto_skcipher *tfm,
 static int sec_alg_skcipher_setkey_des_cbc(struct crypto_skcipher *tfm,
 					   const u8 *key, unsigned int keylen)
 {
-	if (keylen != DES_KEY_SIZE)
-		return -EINVAL;
+	int err;
+
+	err = crypto_des_verify_key(crypto_skcipher_tfm(tfm), key);
+	if (unlikely(err))
+		return err;
 
 	return sec_alg_skcipher_setkey(tfm, key, keylen, SEC_C_DES_CBC_64);
 }
@@ -365,16 +371,26 @@ static int sec_alg_skcipher_setkey_des_cbc(struct crypto_skcipher *tfm,
 static int sec_alg_skcipher_setkey_3des_ecb(struct crypto_skcipher *tfm,
 					    const u8 *key, unsigned int keylen)
 {
-	return unlikely(des3_verify_key(tfm, key)) ?:
-	       sec_alg_skcipher_setkey(tfm, key, keylen,
+	int err;
+
+	err = crypto_des3_ede_verify_key(crypto_skcipher_tfm(tfm), key);
+	if (unlikely(err))
+		return err;
+
+	return sec_alg_skcipher_setkey(tfm, key, keylen,
 				       SEC_C_3DES_ECB_192_3KEY);
 }
 
 static int sec_alg_skcipher_setkey_3des_cbc(struct crypto_skcipher *tfm,
 					    const u8 *key, unsigned int keylen)
 {
-	return unlikely(des3_verify_key(tfm, key)) ?:
-	       sec_alg_skcipher_setkey(tfm, key, keylen,
+	int err;
+
+	err = crypto_des3_ede_verify_key(crypto_skcipher_tfm(tfm), key);
+	if (unlikely(err))
+		return err;
+
+	return sec_alg_skcipher_setkey(tfm, key, keylen,
 				       SEC_C_3DES_CBC_192_3KEY);
 }
 
-- 
2.20.1

