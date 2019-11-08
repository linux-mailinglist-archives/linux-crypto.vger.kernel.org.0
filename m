Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F0F4B70
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 13:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfKHMXs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 07:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732402AbfKHMXs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 07:23:48 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51232247B;
        Fri,  8 Nov 2019 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573215827;
        bh=YybXw4hEuOFV9nIYdKrVGJv7ow5eYJx1Wczbt7Su7qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulHeo6qL4OjG5X70aOCJWJoxpEJIVHTpb3aw0Gss8hfuZIF2vY01ktPnxV4OO01xq
         5H09IGMl2fYT/IoshQs0mQmqisakkZ/+eHCu2h6l1conVlx3CCQvKi7utcMwJFgHWv
         /EKh7CiZwDasXk09vSCVPn+QWXBrpeu1xkRqOd58=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5 16/34] crypto: x86/poly1305 - depend on generic library not generic shash
Date:   Fri,  8 Nov 2019 13:22:22 +0100
Message-Id: <20191108122240.28479-17-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108122240.28479-1-ardb@kernel.org>
References: <20191108122240.28479-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove the dependency on the generic Poly1305 driver. Instead, depend
on the generic library so that we only reuse code without pulling in
the generic skcipher implementation as well.

While at it, remove the logic that prefers the non-SIMD path for short
inputs - this is no longer necessary after recent FPU handling changes
on x86.

Since this removes the last remaining user of the routines exported
by the generic shash driver, unexport them and make them static.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/poly1305_glue.c    | 66 ++++++++++++++++----
 crypto/Kconfig                     |  2 +-
 crypto/poly1305_generic.c          | 11 ++--
 include/crypto/internal/poly1305.h |  9 ---
 4 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index b43b93c95e79..a5b3a054604c 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -34,6 +34,24 @@ static void poly1305_simd_mult(u32 *a, const u32 *b)
 	poly1305_block_sse2(a, m, b, 1);
 }
 
+static unsigned int poly1305_scalar_blocks(struct poly1305_desc_ctx *dctx,
+					   const u8 *src, unsigned int srclen)
+{
+	unsigned int datalen;
+
+	if (unlikely(!dctx->sset)) {
+		datalen = crypto_poly1305_setdesckey(dctx, src, srclen);
+		src += srclen - datalen;
+		srclen = datalen;
+	}
+	if (srclen >= POLY1305_BLOCK_SIZE) {
+		poly1305_core_blocks(&dctx->h, dctx->r, src,
+				     srclen / POLY1305_BLOCK_SIZE, 1);
+		srclen %= POLY1305_BLOCK_SIZE;
+	}
+	return srclen;
+}
+
 static unsigned int poly1305_simd_blocks(struct poly1305_desc_ctx *dctx,
 					 const u8 *src, unsigned int srclen)
 {
@@ -91,12 +109,6 @@ static int poly1305_simd_update(struct shash_desc *desc,
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 	unsigned int bytes;
 
-	/* kernel_fpu_begin/end is costly, use fallback for small updates */
-	if (srclen <= 288 || !crypto_simd_usable())
-		return crypto_poly1305_update(desc, src, srclen);
-
-	kernel_fpu_begin();
-
 	if (unlikely(dctx->buflen)) {
 		bytes = min(srclen, POLY1305_BLOCK_SIZE - dctx->buflen);
 		memcpy(dctx->buf + dctx->buflen, src, bytes);
@@ -105,25 +117,57 @@ static int poly1305_simd_update(struct shash_desc *desc,
 		dctx->buflen += bytes;
 
 		if (dctx->buflen == POLY1305_BLOCK_SIZE) {
-			poly1305_simd_blocks(dctx, dctx->buf,
-					     POLY1305_BLOCK_SIZE);
+			if (likely(crypto_simd_usable())) {
+				kernel_fpu_begin();
+				poly1305_simd_blocks(dctx, dctx->buf,
+						     POLY1305_BLOCK_SIZE);
+				kernel_fpu_end();
+			} else {
+				poly1305_scalar_blocks(dctx, dctx->buf,
+						       POLY1305_BLOCK_SIZE);
+			}
 			dctx->buflen = 0;
 		}
 	}
 
 	if (likely(srclen >= POLY1305_BLOCK_SIZE)) {
-		bytes = poly1305_simd_blocks(dctx, src, srclen);
+		if (likely(crypto_simd_usable())) {
+			kernel_fpu_begin();
+			bytes = poly1305_simd_blocks(dctx, src, srclen);
+			kernel_fpu_end();
+		} else {
+			bytes = poly1305_scalar_blocks(dctx, src, srclen);
+		}
 		src += srclen - bytes;
 		srclen = bytes;
 	}
 
-	kernel_fpu_end();
-
 	if (unlikely(srclen)) {
 		dctx->buflen = srclen;
 		memcpy(dctx->buf, src, srclen);
 	}
+}
+
+static int crypto_poly1305_init(struct shash_desc *desc)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	poly1305_core_init(&dctx->h);
+	dctx->buflen = 0;
+	dctx->rset = 0;
+	dctx->sset = false;
+
+	return 0;
+}
+
+static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
+{
+	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (unlikely(!dctx->sset))
+		return -ENOKEY;
 
+	poly1305_final_generic(dctx, dst);
 	return 0;
 }
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 362dd6ae6aca..2c7327a5b28e 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -714,7 +714,7 @@ config CRYPTO_POLY1305
 config CRYPTO_POLY1305_X86_64
 	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
 	depends on X86 && 64BIT
-	select CRYPTO_POLY1305
+	select CRYPTO_LIB_POLY1305_GENERIC
 	help
 	  Poly1305 authenticator algorithm, RFC7539.
 
diff --git a/crypto/poly1305_generic.c b/crypto/poly1305_generic.c
index afe9a9e576dd..21edbd8c99fb 100644
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <asm/unaligned.h>
 
-int crypto_poly1305_init(struct shash_desc *desc)
+static int crypto_poly1305_init(struct shash_desc *desc)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 
@@ -30,7 +30,6 @@ int crypto_poly1305_init(struct shash_desc *desc)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(crypto_poly1305_init);
 
 static void poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
 			    unsigned int srclen)
@@ -47,8 +46,8 @@ static void poly1305_blocks(struct poly1305_desc_ctx *dctx, const u8 *src,
 			     srclen / POLY1305_BLOCK_SIZE, 1);
 }
 
-int crypto_poly1305_update(struct shash_desc *desc,
-			   const u8 *src, unsigned int srclen)
+static int crypto_poly1305_update(struct shash_desc *desc,
+				  const u8 *src, unsigned int srclen)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 	unsigned int bytes;
@@ -80,9 +79,8 @@ int crypto_poly1305_update(struct shash_desc *desc,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(crypto_poly1305_update);
 
-int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
+static int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
 
@@ -92,7 +90,6 @@ int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 	poly1305_final_generic(dctx, dst);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(crypto_poly1305_final);
 
 static struct shash_alg poly1305_alg = {
 	.digestsize	= POLY1305_DIGEST_SIZE,
diff --git a/include/crypto/internal/poly1305.h b/include/crypto/internal/poly1305.h
index 04fa269e5534..479b0cab2a1a 100644
--- a/include/crypto/internal/poly1305.h
+++ b/include/crypto/internal/poly1305.h
@@ -10,8 +10,6 @@
 #include <linux/types.h>
 #include <crypto/poly1305.h>
 
-struct shash_desc;
-
 /*
  * Poly1305 core functions.  These implement the ε-almost-∆-universal hash
  * function underlying the Poly1305 MAC, i.e. they don't add an encrypted nonce
@@ -28,13 +26,6 @@ void poly1305_core_blocks(struct poly1305_state *state,
 			  unsigned int nblocks, u32 hibit);
 void poly1305_core_emit(const struct poly1305_state *state, void *dst);
 
-/* Crypto API helper functions for the Poly1305 MAC */
-int crypto_poly1305_init(struct shash_desc *desc);
-
-int crypto_poly1305_update(struct shash_desc *desc,
-			   const u8 *src, unsigned int srclen);
-int crypto_poly1305_final(struct shash_desc *desc, u8 *dst);
-
 /*
  * Poly1305 requires a unique key for each tag, which implies that we can't set
  * it on the tfm that gets accessed by multiple users simultaneously. Instead we
-- 
2.20.1

