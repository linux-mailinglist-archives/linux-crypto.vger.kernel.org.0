Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1362D5804E
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF0K2H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfF0K2H (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so5180115wme.4
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+abpCskFH64uUUzWz6MrJWQeWRPxd08F5mJmqOJSaY=;
        b=viSwP1JpAfPU32uHnw8rlxaTAk71HLe27U7d0CvdMB42udDUtWCIH+YutMCEZueel6
         qWQNzI5bwZj2h5AdUeyLgE6RQvg6+3oHq+QvzNbz8lguMVEPy4MO7tecZKbGEwag5OKT
         HiHjZg0zSAJ7lYKY2AyvRbrKSnKb7WL02IF4lxRgrLkXxgv1Vp2K4z9hEAtt2MbsHJLA
         DjDbbqYpw451jWHd8pVCtKBhwTQ37ggNSnWbaNg4vmbabHBGLqBoDgiDtPNrgNo9FPD6
         89vKsVVIyTWtKv/s/FUTy0VidzNUlLL9vIPb5xbFR9xkCaiIWwlj/Zho+6O/PqiiGmBQ
         uvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+abpCskFH64uUUzWz6MrJWQeWRPxd08F5mJmqOJSaY=;
        b=OGaMHhzNgF8SnXRIjHJOoRgzAoVSVO1jyYgCDIjQu2HVN+oejkIQs43yf8hNha9dP0
         SD485wembMlw49RlGD8hll+eesjYbFqbSeTCMTMDNSQmWrrw2+5rlkcTDn80w9LhMUUF
         8s/TwfseB960gDzw/3DogFcV0roO6aXxlyXAlZYyJNxeA63jYYGJlrzpx66zuP0TIKHc
         YIlmXi6Mf8ubM/ZiY6MNU5hAW31BpTRPUEqrGdu5PoKXC1Rw1VDwF7C3eXBO4ZNO5eyZ
         MdQ3oCM9bSLGtu/LxsWutgaS4E9zNCX44hvGmwrkj+ZuWTbPzD0wfcnjgSedV3V77haX
         s4bA==
X-Gm-Message-State: APjAAAXBQ+WgcyhSvB7LH7dZJmJ9f0CpdzSddHhAkL+ltJ9W9EKZWbTi
        yh2jV2YNghnF/c81y8ggEfcMmD4gF8s=
X-Google-Smtp-Source: APXvYqy/JARs2dxBkGzT91BM8CxLSNBsqnGAPqFrh9Rb5aMWguKZ3mAPdoy1V/o8tb4U56LibKwJyg==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr2891110wma.34.1561631284769;
        Thu, 27 Jun 2019 03:28:04 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 13/32] crypto: arm64/aes-neonbs - switch to library version of key expansion routine
Date:   Thu, 27 Jun 2019 12:26:28 +0200
Message-Id: <20190627102647.2992-14-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Switch to the new AES library that also provides an implementation of
the AES key expansion routine. This removes the dependency on the
generic AES cipher, allowing it to be omitted entirely in the future.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/Kconfig           | 1 +
 arch/arm64/crypto/aes-neonbs-glue.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index c6032bfb44fb..17bf5dc10aad 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -116,6 +116,7 @@ config CRYPTO_AES_ARM64_BS
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_AES_ARM64
+	select CRYPTO_LIB_AES
 	select CRYPTO_SIMD
 
 endif
diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index 02b65d9eb947..cb8d90f795a0 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -77,7 +77,7 @@ static int aesbs_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 	struct crypto_aes_ctx rk;
 	int err;
 
-	err = crypto_aes_expand_key(&rk, in_key, key_len);
+	err = aes_expandkey(&rk, in_key, key_len);
 	if (err)
 		return err;
 
@@ -136,7 +136,7 @@ static int aesbs_cbc_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 	struct crypto_aes_ctx rk;
 	int err;
 
-	err = crypto_aes_expand_key(&rk, in_key, key_len);
+	err = aes_expandkey(&rk, in_key, key_len);
 	if (err)
 		return err;
 
@@ -208,7 +208,7 @@ static int aesbs_ctr_setkey_sync(struct crypto_skcipher *tfm, const u8 *in_key,
 	struct aesbs_ctr_ctx *ctx = crypto_skcipher_ctx(tfm);
 	int err;
 
-	err = crypto_aes_expand_key(&ctx->fallback, in_key, key_len);
+	err = aes_expandkey(&ctx->fallback, in_key, key_len);
 	if (err)
 		return err;
 
@@ -274,7 +274,7 @@ static int aesbs_xts_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 		return err;
 
 	key_len /= 2;
-	err = crypto_aes_expand_key(&rk, in_key + key_len, key_len);
+	err = aes_expandkey(&rk, in_key + key_len, key_len);
 	if (err)
 		return err;
 
-- 
2.20.1

