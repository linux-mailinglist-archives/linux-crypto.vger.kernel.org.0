Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0ED894C3
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Aug 2019 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKW72 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 11 Aug 2019 18:59:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39835 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHKW71 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 11 Aug 2019 18:59:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so12925074wra.6
        for <linux-crypto@vger.kernel.org>; Sun, 11 Aug 2019 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WBpXCKjdfq1yPU+OJBvQfW6gPuB8RZ7Tc8kFP902ZIM=;
        b=kCofGDQRD+qKmOAJWzOnSnR6Wwz3Y9bYdcIfvJWQa1nk/Nnm8BgcQvgttireKoC9i4
         ZhRJBbwXTXAil6kuWzTLxLgxUBrB4DqBxWjDgKCnT0jNVaRnvTUkm/pa9qLwCMx3EQA+
         slZ+LKH/Z3EDpse+Qr0PhDq5mMt10BPSx2FSaGL2OfjZFMdCiZWaZPQSHrHpoYaqcm2d
         4Mv5K/NUqtSUGqJslAsSTRtrSrK4FKGWKxXrngRBx147X5CwzS1m71p3gu4zXxHeuBLt
         t47ZnwSxcebtwTrcRbjsboIR8EHe3FYQKtFEv+pRVMNlPVkM18VWZ/mqpUE6enpUFZy1
         gbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WBpXCKjdfq1yPU+OJBvQfW6gPuB8RZ7Tc8kFP902ZIM=;
        b=STMNTzDavXuJCiAb3bPdb2bDn9NJDoat1SuHjlalRtEAfZvE49mphA4dJqaRjNgMYF
         87vStBem2m//qqMd7JFjMTXtUA6OhUHmdL1QIXMeO0VI95PD74lzbcwpWUqCClwGGxTj
         7FWuR2fdG0Mh3p5QbhuNZ+LSGhmapiQSgaXelbJW2HUZc/Y68KHKcQsFe4/uZPSaWefr
         hhBrcp++3TTxlllrs3OiafSWf9toWmAUHLWIBLudjiGWiNJr+EWuQmneX0Khrg4SbZQ5
         u2tT32E5kaVdI9D0/dZnjgV8joljP/xcUqpe70V923cwshkMKp0pii1RRT3molXg5Mal
         5IKQ==
X-Gm-Message-State: APjAAAWO1+9rODBJO23Ou1dZp9WHPV5h9R5nXqAxtBOeIF4CHbUAGfRV
        KMhkFLYOKePlmztcZIX1Z2Obykiq6WXZug==
X-Google-Smtp-Source: APXvYqwNeOvn8OGLFcFwne3f/5KXZFeXbvl/XTwD3j+KLcZuFebcUFtpjmrkX1JUouUphdHFACnecA==
X-Received: by 2002:adf:9224:: with SMTP id 33mr23351134wrj.238.1565564364796;
        Sun, 11 Aug 2019 15:59:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:5df1:4fcc:7bd1:4860])
        by smtp.gmail.com with ESMTPSA id a17sm5930888wmm.47.2019.08.11.15.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 15:59:24 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 1/3] crypto: aegis128 - add support for SIMD acceleration
Date:   Mon, 12 Aug 2019 01:59:10 +0300
Message-Id: <20190811225912.19412-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190811225912.19412-1-ard.biesheuvel@linaro.org>
References: <20190811225912.19412-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add some plumbing to allow the AEGIS128 code to be built with SIMD
routines for acceleration.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/Makefile                        |  1 +
 crypto/{aegis128.c => aegis128-core.c} | 52 ++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index cfcc954e59f9..92e985714ff6 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_CRYPTO_GCM) += gcm.o
 obj-$(CONFIG_CRYPTO_CCM) += ccm.o
 obj-$(CONFIG_CRYPTO_CHACHA20POLY1305) += chacha20poly1305.o
 obj-$(CONFIG_CRYPTO_AEGIS128) += aegis128.o
+aegis128-y := aegis128-core.o
 obj-$(CONFIG_CRYPTO_PCRYPT) += pcrypt.o
 obj-$(CONFIG_CRYPTO_CRYPTD) += cryptd.o
 obj-$(CONFIG_CRYPTO_DES) += des_generic.o
diff --git a/crypto/aegis128.c b/crypto/aegis128-core.c
similarity index 89%
rename from crypto/aegis128.c
rename to crypto/aegis128-core.c
index 32840d5e7f65..fa69e99968e2 100644
--- a/crypto/aegis128.c
+++ b/crypto/aegis128-core.c
@@ -8,6 +8,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/internal/aead.h>
+#include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
 #include <linux/err.h>
@@ -16,6 +17,8 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 
+#include <asm/simd.h>
+
 #include "aegis.h"
 
 #define AEGIS128_NONCE_SIZE 16
@@ -40,6 +43,24 @@ struct aegis128_ops {
 			    const u8 *src, unsigned int size);
 };
 
+static bool have_simd;
+
+static bool aegis128_do_simd(void)
+{
+#ifdef CONFIG_CRYPTO_AEGIS128_SIMD
+	if (have_simd)
+		return crypto_simd_usable();
+#endif
+	return false;
+}
+
+bool crypto_aegis128_have_simd(void);
+void crypto_aegis128_update_simd(struct aegis_state *state, const void *msg);
+void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *dst,
+					const u8 *src, unsigned int size);
+void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *dst,
+					const u8 *src, unsigned int size);
+
 static void crypto_aegis128_update(struct aegis_state *state)
 {
 	union aegis_block tmp;
@@ -55,12 +76,22 @@ static void crypto_aegis128_update(struct aegis_state *state)
 static void crypto_aegis128_update_a(struct aegis_state *state,
 				     const union aegis_block *msg)
 {
+	if (aegis128_do_simd()) {
+		crypto_aegis128_update_simd(state, msg);
+		return;
+	}
+
 	crypto_aegis128_update(state);
 	crypto_aegis_block_xor(&state->blocks[0], msg);
 }
 
 static void crypto_aegis128_update_u(struct aegis_state *state, const void *msg)
 {
+	if (aegis128_do_simd()) {
+		crypto_aegis128_update_simd(state, msg);
+		return;
+	}
+
 	crypto_aegis128_update(state);
 	crypto_xor(state->blocks[0].bytes, msg, AEGIS_BLOCK_SIZE);
 }
@@ -365,7 +396,7 @@ static void crypto_aegis128_crypt(struct aead_request *req,
 
 static int crypto_aegis128_encrypt(struct aead_request *req)
 {
-	static const struct aegis128_ops ops = {
+	const struct aegis128_ops *ops = &(struct aegis128_ops){
 		.skcipher_walk_init = skcipher_walk_aead_encrypt,
 		.crypt_chunk = crypto_aegis128_encrypt_chunk,
 	};
@@ -375,7 +406,12 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	unsigned int cryptlen = req->cryptlen;
 
-	crypto_aegis128_crypt(req, &tag, cryptlen, &ops);
+	if (aegis128_do_simd())
+		ops = &(struct aegis128_ops){
+			.skcipher_walk_init = skcipher_walk_aead_encrypt,
+			.crypt_chunk = crypto_aegis128_encrypt_chunk_simd };
+
+	crypto_aegis128_crypt(req, &tag, cryptlen, ops);
 
 	scatterwalk_map_and_copy(tag.bytes, req->dst, req->assoclen + cryptlen,
 				 authsize, 1);
@@ -384,7 +420,7 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 
 static int crypto_aegis128_decrypt(struct aead_request *req)
 {
-	static const struct aegis128_ops ops = {
+	const struct aegis128_ops *ops = &(struct aegis128_ops){
 		.skcipher_walk_init = skcipher_walk_aead_decrypt,
 		.crypt_chunk = crypto_aegis128_decrypt_chunk,
 	};
@@ -398,7 +434,12 @@ static int crypto_aegis128_decrypt(struct aead_request *req)
 	scatterwalk_map_and_copy(tag.bytes, req->src, req->assoclen + cryptlen,
 				 authsize, 0);
 
-	crypto_aegis128_crypt(req, &tag, cryptlen, &ops);
+	if (aegis128_do_simd())
+		ops = &(struct aegis128_ops){
+			.skcipher_walk_init = skcipher_walk_aead_decrypt,
+			.crypt_chunk = crypto_aegis128_decrypt_chunk_simd };
+
+	crypto_aegis128_crypt(req, &tag, cryptlen, ops);
 
 	return crypto_memneq(tag.bytes, zeros, authsize) ? -EBADMSG : 0;
 }
@@ -429,6 +470,9 @@ static struct aead_alg crypto_aegis128_alg = {
 
 static int __init crypto_aegis128_module_init(void)
 {
+	if (IS_ENABLED(CONFIG_CRYPTO_AEGIS128_SIMD))
+		have_simd = crypto_aegis128_have_simd();
+
 	return crypto_register_aead(&crypto_aegis128_alg);
 }
 
-- 
2.17.1

