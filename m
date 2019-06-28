Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C80305979B
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jun 2019 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF1Jfs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 05:35:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40050 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfF1Jfs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 05:35:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so5535659wre.7
        for <linux-crypto@vger.kernel.org>; Fri, 28 Jun 2019 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8cozxp6Xii9yB6DFN4x0vfTCcaxHuhUPOIZlSSDZJs=;
        b=gY1RcBtVeSmaeK2JwBw4azY0/038ytn50aEb5jF37R6pDaYZO/FwbsN6xlFUhqvEmN
         xcXw6mXMdIQ9prWvTbZjnLtedp1gdF2lIYJbPcpAjQObDibMAbge1s6t9U/nPlR+Igr0
         Km2KIWD5ysRQ6FNY7BPy9ZzcbSs7gogfU5oPk/3V8O+hSd07L8xMcklpseHlRjMTUj4u
         9376Vrnjlt1/D8CjnPjuC584a0HxSHzzAY5usvk3oodlS4paek2S3bhoz6SagNFsykv4
         IbU07nP0wdpcPyeWuZ9l2/QzG22so4u90QuqvT5tIzOt1k8lG2WUdKUgH8N5GTOsinYq
         TZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8cozxp6Xii9yB6DFN4x0vfTCcaxHuhUPOIZlSSDZJs=;
        b=NYvk2UPECcKU2YeKRTXj81aXLfo6wX89IsphQUHqsi5WaB85auvLUTphtuvskDd5sW
         objA4hhRjxR9E+aQiuAMkhgF6xAL4w+0mPmv5FUgtNDngFSjY7nS/EnvwBREmP1H7Uou
         p/4TLby7d5gG13KbPEIQDP0AtuE0E5hDboeX30eFERCvh1loJUiF9tZAE5KPkKIUYFkZ
         2nMHVIzo/g9/Zak5tjp74SVUm4oNdCosXVmkeoBMh9DwuTQ7s2BTQhMR2bNDHrYIJSIY
         yuI64P3rmy1oU2Uoa1UZgS0s5/gsMP7F+lgFUQ3rL43u3j3vEnhLkdzgKJkV2g6kaWj3
         aOpA==
X-Gm-Message-State: APjAAAXfW7zRAd69azJpGLIEGgWXSxkHi+I+8YFssHS2qoAurs6O015F
        dX1Mf5+MtEtSYONW18IgC3p/GjwZf1FDNQ==
X-Google-Smtp-Source: APXvYqz3CDBjRTpc1vubu4RJ/jv03tWzbiHMNoOSxQT/sQ9u+nzgcswwvDwRjIAdcoLkyGDolZGrXw==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr484455wrh.230.1561714546055;
        Fri, 28 Jun 2019 02:35:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id m24sm1709910wmi.39.2019.06.28.02.35.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 02:35:44 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        horia.geanta@nxp.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 07/30] crypto: cpt/des - switch to new verification routines
Date:   Fri, 28 Jun 2019 11:35:06 +0200
Message-Id: <20190628093529.12281-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628093529.12281-1-ard.biesheuvel@linaro.org>
References: <20190628093529.12281-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/cavium/cpt/cptvf_algs.c | 26 ++++----------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index f6b0c9df12ed..a42b531c12d0 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -10,7 +10,7 @@
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/authenc.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/xts.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
@@ -325,31 +325,15 @@ static int cvm_cfb_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 static int cvm_cbc_des3_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 			       u32 keylen)
 {
-	u32 flags = crypto_ablkcipher_get_flags(cipher);
-	int err;
-
-	err = __des3_verify_key(&flags, key);
-	if (unlikely(err)) {
-		crypto_ablkcipher_set_flags(cipher, flags);
-		return err;
-	}
-
-	return cvm_setkey(cipher, key, keylen, DES3_CBC);
+	return crypto_des3_ede_verify_key(crypto_ablkcipher_tfm(cipher), key) ?:
+	       cvm_setkey(cipher, key, keylen, DES3_CBC);
 }
 
 static int cvm_ecb_des3_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 			       u32 keylen)
 {
-	u32 flags = crypto_ablkcipher_get_flags(cipher);
-	int err;
-
-	err = __des3_verify_key(&flags, key);
-	if (unlikely(err)) {
-		crypto_ablkcipher_set_flags(cipher, flags);
-		return err;
-	}
-
-	return cvm_setkey(cipher, key, keylen, DES3_ECB);
+	return crypto_des3_ede_verify_key(crypto_ablkcipher_tfm(cipher), key) ?:
+	       cvm_setkey(cipher, key, keylen, DES3_ECB);
 }
 
 static int cvm_enc_dec_init(struct crypto_tfm *tfm)
-- 
2.20.1

