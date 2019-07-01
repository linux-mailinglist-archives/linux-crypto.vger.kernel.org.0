Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652145B0BA
	for <lists+linux-crypto@lfdr.de>; Sun, 30 Jun 2019 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF3Quu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 30 Jun 2019 12:50:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36182 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfF3Qut (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 30 Jun 2019 12:50:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so10610474ljj.3
        for <linux-crypto@vger.kernel.org>; Sun, 30 Jun 2019 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4XDiRwr0aHVRkLWQQCgeTSBtYJpjmW8rdjsu1QHcjw=;
        b=dPFLklD9EKlm+7rK6cd1hlJu4wGWEa2uyZEZDTeWTBE9p7FIGAiDRm0t88lxDdE+34
         GjqYkwhKr8kQLa8UYYBNaFjG0hVcabvxRn1mRKOlOaH2Vs6dqqPbMUNqwsh2IU/X8X7U
         0Y4SYhOQ5+MWX7+MyhEHXIAIMSSr2PPBmyU3XvqmJZaX3S4ptXrqlFAq34kNlBECPpBf
         SqSKQE6hIHynqQTpMuQqOdLL5gIA/0Ih/oBdHhb6hYw8whctspGG9d82j+zQKBJkzLJf
         Wb4E88Y9oj1vBlZvY7ak1kzfag5eRoub+6tE9utKxcf0p0LhWhJgpEPtpYUFMyLnRsTZ
         KDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4XDiRwr0aHVRkLWQQCgeTSBtYJpjmW8rdjsu1QHcjw=;
        b=FBZeKPd7wchbvDMk1Yu9fX2Wpmc0AwXufsh6y9aLvF25EKGlQfCXg1KpDD8shbVkaX
         WXEfifd4u1Gbr1Y+/jamaXfR8Q4AdQIPZ/Jdp7foQSQLS3MRiSPu3mHb82mCeynNqdx8
         h6G2qgFmXlcA0DFqcBNSY+PloV4QHbSMdxM1MDxOZnxXdw1474QvPDc6ONxxUH5Sznsm
         XwKWJmK80FoQoYkZa6mcum4K0r5rE9oOmBm1UI2JiEoL0kVzTkvx8efU9sHWg90mo9eN
         013mt5vgcdxtNATP5cWgdV7PsLPCMBDPqr/TMJ2KNnJ2X7//bJEnCd7Li9l/F8sVTohn
         uRNA==
X-Gm-Message-State: APjAAAWfP02zJtZeVoA9wXI5PPNwlr+gvzq6RAqsKGJfS9MgN1WmrbAZ
        fVkFjESBj5bHAsL2QYxXqwXfIAA43QLezA==
X-Google-Smtp-Source: APXvYqx0+LRF/qvN4jxdRSTvl96roAIGzL4DUOo+lk9B8zE6sVU9ojY7RMOQGvHZ3h6I8unATd/rwQ==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr11693351ljm.69.1561913446442;
        Sun, 30 Jun 2019 09:50:46 -0700 (PDT)
Received: from e111045-lin.arm.com (89-212-78-239.static.t-2.net. [89.212.78.239])
        by smtp.gmail.com with ESMTPSA id t15sm2097367lff.94.2019.06.30.09.50.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 09:50:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steve Capper <steve.capper@arm.com>,
        Milan Broz <gmazyland@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 5/7] crypto: aegis128 - add support for SIMD acceleration
Date:   Sun, 30 Jun 2019 18:50:29 +0200
Message-Id: <20190630165031.26365-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190630165031.26365-1-ard.biesheuvel@linaro.org>
References: <20190630165031.26365-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add some plumbing to allow the AEGIS128 code to be built with SIMD
routines for acceleration.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/Makefile                        |  1 +
 crypto/aegis.h                         | 14 +++----
 crypto/{aegis128.c => aegis128-core.c} | 42 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index 93375e124ff7..362a36f0bd2f 100644
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
diff --git a/crypto/aegis.h b/crypto/aegis.h
index 3308066ddde0..6cb65a497ba2 100644
--- a/crypto/aegis.h
+++ b/crypto/aegis.h
@@ -35,23 +35,23 @@ static const union aegis_block crypto_aegis_const[2] = {
 	} },
 };
 
-static void crypto_aegis_block_xor(union aegis_block *dst,
-				   const union aegis_block *src)
+static inline void crypto_aegis_block_xor(union aegis_block *dst,
+					  const union aegis_block *src)
 {
 	dst->words64[0] ^= src->words64[0];
 	dst->words64[1] ^= src->words64[1];
 }
 
-static void crypto_aegis_block_and(union aegis_block *dst,
-				   const union aegis_block *src)
+static inline void crypto_aegis_block_and(union aegis_block *dst,
+					  const union aegis_block *src)
 {
 	dst->words64[0] &= src->words64[0];
 	dst->words64[1] &= src->words64[1];
 }
 
-static void crypto_aegis_aesenc(union aegis_block *dst,
-				const union aegis_block *src,
-				const union aegis_block *key)
+static inline void crypto_aegis_aesenc(union aegis_block *dst,
+				       const union aegis_block *src,
+				       const union aegis_block *key)
 {
 	const u8  *s  = src->bytes;
 	const u32 *t = crypto_ft_tab[0];
diff --git a/crypto/aegis128.c b/crypto/aegis128-core.c
similarity index 89%
rename from crypto/aegis128.c
rename to crypto/aegis128-core.c
index 32840d5e7f65..f815b4685156 100644
--- a/crypto/aegis128.c
+++ b/crypto/aegis128-core.c
@@ -8,6 +8,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/internal/aead.h>
+#include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
 #include <linux/err.h>
@@ -15,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
+#include <asm/simd.h>
 
 #include "aegis.h"
 
@@ -40,6 +42,15 @@ struct aegis128_ops {
 			    const u8 *src, unsigned int size);
 };
 
+static bool have_simd;
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
@@ -55,12 +66,22 @@ static void crypto_aegis128_update(struct aegis_state *state)
 static void crypto_aegis128_update_a(struct aegis_state *state,
 				     const union aegis_block *msg)
 {
+	if (have_simd && crypto_simd_usable()) {
+		crypto_aegis128_update_simd(state, msg);
+		return;
+	}
+
 	crypto_aegis128_update(state);
 	crypto_aegis_block_xor(&state->blocks[0], msg);
 }
 
 static void crypto_aegis128_update_u(struct aegis_state *state, const void *msg)
 {
+	if (have_simd && crypto_simd_usable()) {
+		crypto_aegis128_update_simd(state, msg);
+		return;
+	}
+
 	crypto_aegis128_update(state);
 	crypto_xor(state->blocks[0].bytes, msg, AEGIS_BLOCK_SIZE);
 }
@@ -365,7 +386,7 @@ static void crypto_aegis128_crypt(struct aead_request *req,
 
 static int crypto_aegis128_encrypt(struct aead_request *req)
 {
-	static const struct aegis128_ops ops = {
+	const struct aegis128_ops *ops = &(struct aegis128_ops){
 		.skcipher_walk_init = skcipher_walk_aead_encrypt,
 		.crypt_chunk = crypto_aegis128_encrypt_chunk,
 	};
@@ -375,7 +396,12 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	unsigned int cryptlen = req->cryptlen;
 
-	crypto_aegis128_crypt(req, &tag, cryptlen, &ops);
+	if (have_simd && crypto_simd_usable())
+		ops = &(struct aegis128_ops){
+			.skcipher_walk_init = skcipher_walk_aead_encrypt,
+			.crypt_chunk = crypto_aegis128_encrypt_chunk_simd };
+
+	crypto_aegis128_crypt(req, &tag, cryptlen, ops);
 
 	scatterwalk_map_and_copy(tag.bytes, req->dst, req->assoclen + cryptlen,
 				 authsize, 1);
@@ -384,7 +410,7 @@ static int crypto_aegis128_encrypt(struct aead_request *req)
 
 static int crypto_aegis128_decrypt(struct aead_request *req)
 {
-	static const struct aegis128_ops ops = {
+	const struct aegis128_ops *ops = &(struct aegis128_ops){
 		.skcipher_walk_init = skcipher_walk_aead_decrypt,
 		.crypt_chunk = crypto_aegis128_decrypt_chunk,
 	};
@@ -398,7 +424,12 @@ static int crypto_aegis128_decrypt(struct aead_request *req)
 	scatterwalk_map_and_copy(tag.bytes, req->src, req->assoclen + cryptlen,
 				 authsize, 0);
 
-	crypto_aegis128_crypt(req, &tag, cryptlen, &ops);
+	if (have_simd && crypto_simd_usable())
+		ops = &(struct aegis128_ops){
+			.skcipher_walk_init = skcipher_walk_aead_decrypt,
+			.crypt_chunk = crypto_aegis128_decrypt_chunk_simd };
+
+	crypto_aegis128_crypt(req, &tag, cryptlen, ops);
 
 	return crypto_memneq(tag.bytes, zeros, authsize) ? -EBADMSG : 0;
 }
@@ -429,6 +460,9 @@ static struct aead_alg crypto_aegis128_alg = {
 
 static int __init crypto_aegis128_module_init(void)
 {
+	if (IS_ENABLED(CONFIG_CRYPTO_AEGIS128_SIMD))
+		have_simd = crypto_aegis128_have_simd();
+
 	return crypto_register_aead(&crypto_aegis128_alg);
 }
 
-- 
2.17.1

