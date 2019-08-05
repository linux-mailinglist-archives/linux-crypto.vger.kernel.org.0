Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508FD8234F
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2019 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHERBD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Aug 2019 13:01:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55484 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHERBD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Aug 2019 13:01:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so75447699wmj.5
        for <linux-crypto@vger.kernel.org>; Mon, 05 Aug 2019 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7IS2nH8ZNOjec7mEagc+LEP/YCyqMciJcqRs9vNQlw=;
        b=fcqCksm5lit9oi2/1OGPdFzBlMKwMgaId+mPF4mn7jmbMZZ81XpK/Vj9npWbiHcoDm
         NI05MRlDY1wllLzna8Tm/PVR/ZH6sV0hnSZnvciuaJkKZgBMFblz5s0pcBG113tFV4/g
         kDfquONsAy297yDZ0GlzAKIpW9q+lWPvpZybeaCGDd1O2Z7rQjJ5TU/AuS01XAYEHWVc
         KlHahEgTgM8BsgQyTpab8S3Tf3QUJ+6ofoOKzXiPPq0a2OXrmDe2kMxbfrtWfsWKnLET
         5T0PtRjVouAOEewJ+prPwoO6XIKd07uyUvNDMd8zcIn/4tnx9PUKC+Gilc7+aI2JrNoR
         pPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7IS2nH8ZNOjec7mEagc+LEP/YCyqMciJcqRs9vNQlw=;
        b=F/3yh8mVBAXyPg1buEbOLyRX/igMZunXuEk1DVveSsBSm+QohtdGigR43Z0VtfW8HE
         5+ger/+1fRcLnfpkfMzfm7OLng1FuDZwTesXQEMo9/9WJGRikxhtfNzKfgZ9UTIEVWW+
         EaRRo1hrAJ8Xplc6p0xxHI24E1/W9WI1aMlQEYYXayc8AKd6JC5RjQiO/NulKn1XvlsA
         6ntNY9ZzAt4QsZtaOX8VRf+HL8IQnOnGurxFYWGvunKKDQ6+zWd+FA3I4XLHdqHCknsg
         p5h8OBbgTtduR7z68Vql4L/epg6HzbW2M8AW6hfxsKiwq4w9BGu07bp3+i9w7hUIrvsd
         STEw==
X-Gm-Message-State: APjAAAVMPNDrYywARCf2U3++q+eZGWtTpnXjrLsTmSH7jwo2wPw36UuG
        hShrV+PzbQBC+J/Bk+34dKxy8CW3VntKtA==
X-Google-Smtp-Source: APXvYqyhIuKlEMiQKf/InGeiULa5TYdGJSa0FBFVmU30KF5kJxIS0jBoww0rA4XK4dMjjp4f3ArwaQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr18953783wmj.71.1565024461266;
        Mon, 05 Aug 2019 10:01:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:582f:8334:9cd9:7241])
        by smtp.gmail.com with ESMTPSA id j9sm95669383wrn.81.2019.08.05.10.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:01:00 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        horia.geanta@nxp.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 02/30] crypto: s390/des - switch to new verification routines
Date:   Mon,  5 Aug 2019 20:00:09 +0300
Message-Id: <20190805170037.31330-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805170037.31330-1-ard.biesheuvel@linaro.org>
References: <20190805170037.31330-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Acked-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/crypto/des_s390.c | 25 +++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index 374b42fc7637..f56a84751fdb 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -16,7 +16,7 @@
 #include <linux/fips.h>
 #include <linux/mutex.h>
 #include <crypto/algapi.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <asm/cpacf.h>
 
 #define DES3_KEY_SIZE	(3 * DES_KEY_SIZE)
@@ -35,27 +35,24 @@ static int des_setkey(struct crypto_tfm *tfm, const u8 *key,
 		      unsigned int key_len)
 {
 	struct s390_des_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 tmp[DES_EXPKEY_WORDS];
+	int err;
 
-	/* check for weak keys */
-	if (!des_ekey(tmp, key) &&
-	    (tfm->crt_flags & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_WEAK_KEY;
-		return -EINVAL;
-	}
+	err = crypto_des_verify_key(tfm, key);
+	if (err)
+		return err;
 
 	memcpy(ctx->key, key, key_len);
 	return 0;
 }
 
-static void des_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+static void crypto_des_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	struct s390_des_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	cpacf_km(CPACF_KM_DEA, ctx->key, out, in, DES_BLOCK_SIZE);
 }
 
-static void des_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+static void crypto_des_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	struct s390_des_ctx *ctx = crypto_tfm_ctx(tfm);
 
@@ -76,8 +73,8 @@ static struct crypto_alg des_alg = {
 			.cia_min_keysize	=	DES_KEY_SIZE,
 			.cia_max_keysize	=	DES_KEY_SIZE,
 			.cia_setkey		=	des_setkey,
-			.cia_encrypt		=	des_encrypt,
-			.cia_decrypt		=	des_decrypt,
+			.cia_encrypt		=	crypto_des_encrypt,
+			.cia_decrypt		=	crypto_des_decrypt,
 		}
 	}
 };
@@ -227,8 +224,8 @@ static int des3_setkey(struct crypto_tfm *tfm, const u8 *key,
 	struct s390_des_ctx *ctx = crypto_tfm_ctx(tfm);
 	int err;
 
-	err = __des3_verify_key(&tfm->crt_flags, key);
-	if (unlikely(err))
+	err = crypto_des3_ede_verify_key(tfm, key);
+	if (err)
 		return err;
 
 	memcpy(ctx->key, key, key_len);
-- 
2.17.1

