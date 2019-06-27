Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86558215
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfF0MDt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 08:03:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39862 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0MDs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 08:03:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so2256461wrt.6
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vzvpbNlXM/Hw5w4oquVPslvZ9C6Vbq9J597bSq4ZXo=;
        b=nQNVnBc++IKzmx+GBKKOODwi6wdMe/pZl/5pyH/5aDmHZ7kgYz5zrpcPmhAzl4gKCz
         CnBXNSm+XZY0ra6N8UJNVHXxJNw7Sz3tc7vua7CpfUlh7wc4Hs7lBoMxxETLH76FKFJK
         VSZD3I5SfaAIJJ5lHTQbu5+hvh++ly1DoWAjloTBq7bFaE/1Ei+c62bvAQ+jF6UYaDsf
         DMtjorNOZUIC5GfHtyh2YOSzsQKsuCimJrmw4UXk1kIUSLPjawYVzQxae7YWcV5QLYio
         bjF/F4b3rC4qcI2UJfSVMFQwDyRrxxZU9hWFV53OqmVvG0onWfEd/W3Zt5sxfk/1ernJ
         pToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vzvpbNlXM/Hw5w4oquVPslvZ9C6Vbq9J597bSq4ZXo=;
        b=I08tuTUFwblQnDBc4xB38Jrx/okfYfgK8lAzdJuWRwVTQhqDhYV5KFb36KD9w0hFvW
         EXxI+UU9Sn5oy1Egw4yNTnQZCRMJncXW61ve98tItPrkoERRDu1ZL5+9FEp/Jb8ntnJy
         xVJ3EH1eJgvNo+k+TXv8WBO8y1IWevz/wy7ymQjlTF0mEQKrzyuwbYE93jt6tHkqA5qF
         wBnAXVPOrRy8biXcXt/UceYgF+Oki2zi+PSC0vuIIC4aKCksi0y3pI2914ARnX88KYP9
         RAolJHrxzEAMAvFyjHoRzjqLSEoquQgdeUopmpx3YwMoeAC7qbqLQhRfyIWaPbBvnK5G
         2EUg==
X-Gm-Message-State: APjAAAVsrcFH4azkq24ph3i+RoOLyBV9H4334CjmxdqVPiBynywHGm2s
        mBkBWQ5xwRV++Ch8QbYsIQkTWD7d58mVfg==
X-Google-Smtp-Source: APXvYqzOMynScEFl/KEB3b5qJtKaQ5h9v+KdhdrN0LjJ7hJoRrnNr7TPL4vpi/0jfxkagvrUhRE3OQ==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr2915244wrx.167.1561637025942;
        Thu, 27 Jun 2019 05:03:45 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id z126sm7732431wmb.32.2019.06.27.05.03.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 05:03:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        horia.geanta@nxp.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 18/30] crypto: picoxcell/des - switch to new verification routines
Date:   Thu, 27 Jun 2019 14:03:02 +0200
Message-Id: <20190627120314.7197-19-ard.biesheuvel@linaro.org>
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
 drivers/crypto/picoxcell_crypto.c | 21 +++++++-------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 05b89e703903..31bc23665400 100644
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
@@ -751,14 +751,11 @@ static int spacc_des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 {
 	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
 	struct spacc_ablk_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 tmp[DES_EXPKEY_WORDS];
+	int err;
 
-	if (unlikely(!des_ekey(tmp, key)) &&
-	    (crypto_ablkcipher_get_flags(cipher) &
-	     CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
-		tfm->crt_flags |= CRYPTO_TFM_RES_WEAK_KEY;
-		return -EINVAL;
-	}
+	err = crypto_des_verify_key(tfm, key);
+	if (unlikely(err))
+		return err;
 
 	memcpy(ctx->key, key, len);
 	ctx->key_len = len;
@@ -774,15 +771,11 @@ static int spacc_des3_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 			     unsigned int len)
 {
 	struct spacc_ablk_ctx *ctx = crypto_ablkcipher_ctx(cipher);
-	u32 flags;
 	int err;
 
-	flags = crypto_ablkcipher_get_flags(cipher);
-	err = __des3_verify_key(&flags, key);
-	if (unlikely(err)) {
-		crypto_ablkcipher_set_flags(cipher, flags);
+	err = crypto_des3_ede_verify_key(crypto_ablkcipher_tfm(cipher), key);
+	if (unlikely(err))
 		return err;
-	}
 
 	memcpy(ctx->key, key, len);
 	ctx->key_len = len;
-- 
2.20.1

