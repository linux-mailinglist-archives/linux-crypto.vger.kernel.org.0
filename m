Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E362710D
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Nov 2022 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKMQ5K (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Nov 2022 11:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiKMQ5H (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Nov 2022 11:57:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177F12083
        for <linux-crypto@vger.kernel.org>; Sun, 13 Nov 2022 08:57:06 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so8328911pgc.10
        for <linux-crypto@vger.kernel.org>; Sun, 13 Nov 2022 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lW3Ih77+Np3zfBtxFApT83lIg2H7bPwCv6kYYxAC0h4=;
        b=nuBAsXGrCYiH7EUR42N0q0+/2yilDvWGPi2FeesW9fXpwVd7rT2rSrQcFqLarl+l0Y
         FwT/Y0OJJVghajxh4Nsy6sQSXu3u/8DiHA6v4duK2nesIdtrn7Vam87tknvC7vaVxlXq
         VyqGUKDHolBD0XDm7UQBCfUrWBrbO+3iTKpDacsNmYD9mKxO3oMsqLB9LwBHzCXOahZO
         Ney8vnZ60SAAo549RNA9+XQKxdKI/zrvKl2qmlc8D3tEoQx5zQst8eJW03jSFRdez2YO
         35bXavbrQzyu8usiJADunXpwW++jIj+T+vcKhLKFuZN8G9XYqV5plcuKzphNGMo6VMVi
         rZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lW3Ih77+Np3zfBtxFApT83lIg2H7bPwCv6kYYxAC0h4=;
        b=YoTq8NaYYus523srrM/xLIvk5X7ZTBAPbEoo3TKCRwvSlJcXD3PY+TS2HhUUd0b19/
         V/OxatgFIJFLE3OTq3qtyYM83zGL9LZN4LPbuqN3gaYub5gnlKoZH6qpOSHLsn9x5WS5
         H5p4UVH8YGM/JuTE3FLyHprBrc86QjxBBjSYV5MMQhr+3/LO+0yT9zPco6ggfHORTkq/
         5ensZYP+/DGFKqa4RfnCV6rsHyAw+S5JdupJz2+dcC6LyxMzBE0xrAqYRwXzXK9iTDdL
         39yaI6+2PZLOEcuFZZ7tjWTmhS7hRxaZ5vuGgVDn6bLfGEF8wITKdzuiatb0V4Kek3vy
         64hg==
X-Gm-Message-State: ANoB5pmIeUeNLZjsj2zxP+IiZ/nwwKBBDDw3mXbG08DDkIbXZker2CEP
        v5C5kMsK438qCA28kF2mVAy77mL/JqeHhg==
X-Google-Smtp-Source: AA0mqf4P3ivE9QSf5ulcXZbI4E+WyADJofCnpDT684zedeNbED4EnSDi2sxUIHInwKDKzSicLagG4w==
X-Received: by 2002:a63:e20:0:b0:456:f79e:4e95 with SMTP id d32-20020a630e20000000b00456f79e4e95mr8664347pgl.607.1668358625786;
        Sun, 13 Nov 2022 08:57:05 -0800 (PST)
Received: from localhost.localdomain ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id qi18-20020a17090b275200b001f8c532b93dsm4910477pjb.15.2022.11.13.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:57:05 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, richard@nod.at,
        viro@zeniv.linux.org.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@kernel.org,
        elliott@hpe.com, x86@kernel.org, jussi.kivilinna@iki.fi
Cc:     ap420073@gmail.com
Subject: [PATCH v4 2/4] crypto: aria: do not use magic number offsets of aria_ctx
Date:   Sun, 13 Nov 2022 16:56:43 +0000
Message-Id: <20221113165645.4652-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221113165645.4652-1-ap420073@gmail.com>
References: <20221113165645.4652-1-ap420073@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

aria-avx assembly code accesses members of aria_ctx with magic number
offset. If the shape of struct aria_ctx is changed carelessly,
aria-avx will not work.
So, we need to ensure accessing members of aria_ctx with correct
offset values, not with magic numbers.

It adds ARIA_CTX_enc_key, ARIA_CTX_dec_key, and ARIA_CTX_rounds in the
asm-offsets.c So, correct offset definitions will be generated.
aria-avx assembly code can access members of aria_ctx safely with
these definitions.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Add BUILD_BUG_ON() to check size of fields of aria_ctx.

v3:
 - Patch introduced.

 arch/x86/crypto/aria-aesni-avx-asm_64.S | 26 +++++++++++--------------
 arch/x86/kernel/asm-offsets.c           | 11 +++++++++++
 crypto/aria_generic.c                   |  4 ++++
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/crypto/aria-aesni-avx-asm_64.S b/arch/x86/crypto/aria-aesni-avx-asm_64.S
index c75fd7d015ed..e47e7e54e08f 100644
--- a/arch/x86/crypto/aria-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/aria-aesni-avx-asm_64.S
@@ -8,11 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/frame.h>
-
-/* struct aria_ctx: */
-#define enc_key 0
-#define dec_key 272
-#define rounds 544
+#include <asm/asm-offsets.h>
 
 /* register macros */
 #define CTX %rdi
@@ -873,7 +869,7 @@ SYM_FUNC_START_LOCAL(__aria_aesni_avx_crypt_16way)
 	aria_fo(%xmm9, %xmm8, %xmm11, %xmm10, %xmm12, %xmm13, %xmm14, %xmm15,
 		%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		%rax, %r9, 10);
-	cmpl $12, rounds(CTX);
+	cmpl $12, ARIA_CTX_rounds(CTX);
 	jne .Laria_192;
 	aria_ff(%xmm1, %xmm0, %xmm3, %xmm2, %xmm4, %xmm5, %xmm6, %xmm7,
 		%xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -886,7 +882,7 @@ SYM_FUNC_START_LOCAL(__aria_aesni_avx_crypt_16way)
 	aria_fo(%xmm9, %xmm8, %xmm11, %xmm10, %xmm12, %xmm13, %xmm14, %xmm15,
 		%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		%rax, %r9, 12);
-	cmpl $14, rounds(CTX);
+	cmpl $14, ARIA_CTX_rounds(CTX);
 	jne .Laria_256;
 	aria_ff(%xmm1, %xmm0, %xmm3, %xmm2, %xmm4, %xmm5, %xmm6, %xmm7,
 		%xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -922,7 +918,7 @@ SYM_FUNC_START(aria_aesni_avx_encrypt_16way)
 
 	FRAME_BEGIN
 
-	leaq enc_key(CTX), %r9;
+	leaq ARIA_CTX_enc_key(CTX), %r9;
 
 	inpack16_pre(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		     %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -947,7 +943,7 @@ SYM_FUNC_START(aria_aesni_avx_decrypt_16way)
 
 	FRAME_BEGIN
 
-	leaq dec_key(CTX), %r9;
+	leaq ARIA_CTX_dec_key(CTX), %r9;
 
 	inpack16_pre(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		     %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -1055,7 +1051,7 @@ SYM_FUNC_START(aria_aesni_avx_ctr_crypt_16way)
 	leaq (%rdx), %r11;
 	leaq (%rcx), %rsi;
 	leaq (%rcx), %rdx;
-	leaq enc_key(CTX), %r9;
+	leaq ARIA_CTX_enc_key(CTX), %r9;
 
 	call __aria_aesni_avx_crypt_16way;
 
@@ -1156,7 +1152,7 @@ SYM_FUNC_START_LOCAL(__aria_aesni_avx_gfni_crypt_16way)
 		     %xmm0, %xmm1, %xmm2, %xmm3,
 		     %xmm4, %xmm5, %xmm6, %xmm7,
 		     %rax, %r9, 10);
-	cmpl $12, rounds(CTX);
+	cmpl $12, ARIA_CTX_rounds(CTX);
 	jne .Laria_gfni_192;
 	aria_ff_gfni(%xmm1, %xmm0, %xmm3, %xmm2, %xmm4, %xmm5, %xmm6, %xmm7,
 		%xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -1173,7 +1169,7 @@ SYM_FUNC_START_LOCAL(__aria_aesni_avx_gfni_crypt_16way)
 		     %xmm0, %xmm1, %xmm2, %xmm3,
 		     %xmm4, %xmm5, %xmm6, %xmm7,
 		     %rax, %r9, 12);
-	cmpl $14, rounds(CTX);
+	cmpl $14, ARIA_CTX_rounds(CTX);
 	jne .Laria_gfni_256;
 	aria_ff_gfni(%xmm1, %xmm0, %xmm3, %xmm2,
 		     %xmm4, %xmm5, %xmm6, %xmm7,
@@ -1217,7 +1213,7 @@ SYM_FUNC_START(aria_aesni_avx_gfni_encrypt_16way)
 
 	FRAME_BEGIN
 
-	leaq enc_key(CTX), %r9;
+	leaq ARIA_CTX_enc_key(CTX), %r9;
 
 	inpack16_pre(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		     %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -1242,7 +1238,7 @@ SYM_FUNC_START(aria_aesni_avx_gfni_decrypt_16way)
 
 	FRAME_BEGIN
 
-	leaq dec_key(CTX), %r9;
+	leaq ARIA_CTX_dec_key(CTX), %r9;
 
 	inpack16_pre(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		     %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14,
@@ -1274,7 +1270,7 @@ SYM_FUNC_START(aria_aesni_avx_gfni_ctr_crypt_16way)
 	leaq (%rdx), %r11;
 	leaq (%rcx), %rsi;
 	leaq (%rcx), %rdx;
-	leaq enc_key(CTX), %r9;
+	leaq ARIA_CTX_enc_key(CTX), %r9;
 
 	call __aria_aesni_avx_gfni_crypt_16way;
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index cb50589a7102..32192a91c65b 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -7,6 +7,7 @@
 #define COMPILE_OFFSETS
 
 #include <linux/crypto.h>
+#include <crypto/aria.h>
 #include <linux/sched.h>
 #include <linux/stddef.h>
 #include <linux/hardirq.h>
@@ -109,6 +110,16 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 
+#if defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64) ||  \
+	defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64_MODULE)
+
+	/* Offset for fields in aria_ctx */
+	BLANK();
+	OFFSET(ARIA_CTX_enc_key, aria_ctx, enc_key);
+	OFFSET(ARIA_CTX_dec_key, aria_ctx, dec_key);
+	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
+#endif
+
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
 		OFFSET(VMX_spec_ctrl, vcpu_vmx, spec_ctrl);
diff --git a/crypto/aria_generic.c b/crypto/aria_generic.c
index 4cc29b82b99d..d96dfc4fdde6 100644
--- a/crypto/aria_generic.c
+++ b/crypto/aria_generic.c
@@ -178,6 +178,10 @@ int aria_set_key(struct crypto_tfm *tfm, const u8 *in_key, unsigned int key_len)
 	if (key_len != 16 && key_len != 24 && key_len != 32)
 		return -EINVAL;
 
+	BUILD_BUG_ON(sizeof(ctx->enc_key) != 272);
+	BUILD_BUG_ON(sizeof(ctx->dec_key) != 272);
+	BUILD_BUG_ON(sizeof(int) != sizeof(ctx->rounds));
+
 	ctx->key_length = key_len;
 	ctx->rounds = (key_len + 32) / 4;
 
-- 
2.17.1

