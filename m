Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3A105DF5
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 02:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKVBEG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 21 Nov 2019 20:04:06 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35628 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfKVBDr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:47 -0500
Received: by mail-pl1-f172.google.com with SMTP id s10so2386345plp.2
        for <linux-crypto@vger.kernel.org>; Thu, 21 Nov 2019 17:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xI/dPXrrYqWegaSFAnlL3jgT7wQ+lhRdMLTgo6t8Ans=;
        b=RBA3HZTsQVNixmKnD00ysKCsEDYLlENk0r/mTUsZOUy2hD49/648riiImHjQvVx0UQ
         CVLu6vTL3NnJbZQsBBWrXdW9cDUAvmrEW95/8AV6i2Yx10wKLN21RO/l29TkxpEhsg3K
         LMUCtW6tqZ89BRUaz/wG5cnaSs+0EUGxfaLe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xI/dPXrrYqWegaSFAnlL3jgT7wQ+lhRdMLTgo6t8Ans=;
        b=PB9I7ohdexz5YAreBpOnYDaUYQr/5J5TgnehJgMC4zjZTGDRY8sUKQuE696kXlfS5H
         N7nY3htsPU8Nt6x/Tf9R8qRJf3hBHQHfoFsbG36Ar3usffpRPNaIQpGs370AFaiAMf+u
         z6Lz8iA8PWLmiriiZFT1skWYP9gkHxUGAc/HgkRGDWd3QMWYy6wQVLZB/tGeAbqPPPD3
         NoZnulTvqb41YoZDMcgwEmRkYitItGdfLjjs7rHbxb+2dqzOGfFCR4Q3/DV+ZL5S1riv
         d6TgFch8pDVrugYhiX6Wm9DnvRU/Qj1rozb25WM+K3thXqxqbRPfHll7vTBs4kzROzPM
         8/9g==
X-Gm-Message-State: APjAAAWkeYVtq6fQas7itA94Offy4IjsJi2abUS5ibX4HwKr9dvHbyMb
        d/lQU7dA1R3B1Rkj1YEmBFuHKA==
X-Google-Smtp-Source: APXvYqxvLuLvwOD7ySfWOmJmnhEcGvvulnrYgJt72BDggzBdZ0gfowf/Jw6lqUM9sF24EUx+wum6aQ==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11mr11529425plz.176.1574384624926;
        Thu, 21 Nov 2019 17:03:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 199sm4858587pfz.186.2019.11.21.17.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 7/8] crypto: x86/glue_helper: Remove function prototype cast helpers
Date:   Thu, 21 Nov 2019 17:03:33 -0800
Message-Id: <20191122010334.12081-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122010334.12081-1-keescook@chromium.org>
References: <20191122010334.12081-1-keescook@chromium.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that all users of the function prototype casting helpers have been
removed, delete the unused macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/crypto/glue_helper.h | 5 -----
 include/crypto/xts.h                      | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/crypto/glue_helper.h b/arch/x86/include/asm/crypto/glue_helper.h
index ba48d5af4f16..777c0f63418c 100644
--- a/arch/x86/include/asm/crypto/glue_helper.h
+++ b/arch/x86/include/asm/crypto/glue_helper.h
@@ -18,11 +18,6 @@ typedef void (*common_glue_ctr_func_t)(const void *ctx, u8 *dst, const u8 *src,
 typedef void (*common_glue_xts_func_t)(const void *ctx, u8 *dst, const u8 *src,
 				       le128 *iv);
 
-#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
-#define GLUE_CBC_FUNC_CAST(fn) ((common_glue_cbc_func_t)(fn))
-#define GLUE_CTR_FUNC_CAST(fn) ((common_glue_ctr_func_t)(fn))
-#define GLUE_XTS_FUNC_CAST(fn) ((common_glue_xts_func_t)(fn))
-
 struct common_glue_func_entry {
 	unsigned int num_blocks; /* number of blocks that @fn will process */
 	union {
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 75fd96ff976b..15ae7fdc0478 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -8,8 +8,6 @@
 
 #define XTS_BLOCK_SIZE 16
 
-#define XTS_TWEAK_CAST(x) ((void (*)(void *, u8*, const u8*))(x))
-
 static inline int xts_check_key(struct crypto_tfm *tfm,
 				const u8 *key, unsigned int keylen)
 {
-- 
2.17.1

