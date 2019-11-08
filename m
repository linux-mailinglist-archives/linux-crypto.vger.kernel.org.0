Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6DF4B5D
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 13:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfKHMXI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 07:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfKHMXI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 07:23:08 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFE221848;
        Fri,  8 Nov 2019 12:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573215786;
        bh=pIcJbaOPmfUL3JSabIQNnnEiPr8aYPwzAyLW7GYg0JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNE5s5p0BfQypnQAeJmq4JmRXYYD4jSHKv0+3dK+wQWHARa2hd+f9m03D3LHthbp9
         qlD29FwCQEMXnKcia5e0Z7vDljw16kL6Rv285S6sInh2ypuOcpWn7C9RBM2u+qPbXf
         pnz0cQI8A1fKBXHwlRjH37oO2lf0uNNTKRRsiEPU=
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
Subject: [PATCH v5 02/34] crypto: chacha - move existing library code into lib/crypto
Date:   Fri,  8 Nov 2019 13:22:08 +0100
Message-Id: <20191108122240.28479-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108122240.28479-1-ardb@kernel.org>
References: <20191108122240.28479-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently, our generic ChaCha implementation consists of a permute
function in lib/chacha.c that operates on the 64-byte ChaCha state
directly [and which is always included into the core kernel since it
is used by the /dev/random driver], and the crypto API plumbing to
expose it as a skcipher.

In order to support in-kernel users that need the ChaCha streamcipher
but have no need [or tolerance] for going through the abstractions of
the crypto API, let's expose the streamcipher bits via a library API
as well, in a way that permits the implementation to be superseded by
an architecture specific one if provided.

So move the streamcipher code into a separate module in lib/crypto,
and expose the init() and crypt() routines to users of the library.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/crypto/chacha-neon-glue.c   |  2 +-
 arch/arm64/crypto/chacha-neon-glue.c |  2 +-
 arch/x86/crypto/chacha_glue.c        |  2 +-
 crypto/Kconfig                       |  1 +
 crypto/chacha_generic.c              | 60 ++-------------
 include/crypto/chacha.h              | 77 +++++++++++++++-----
 include/crypto/internal/chacha.h     | 53 ++++++++++++++
 lib/Makefile                         |  3 +-
 lib/crypto/Kconfig                   | 26 +++++++
 lib/crypto/Makefile                  |  4 +
 lib/{ => crypto}/chacha.c            | 20 ++---
 lib/crypto/libchacha.c               | 35 +++++++++
 12 files changed, 199 insertions(+), 86 deletions(-)

diff --git a/arch/arm/crypto/chacha-neon-glue.c b/arch/arm/crypto/chacha-neon-glue.c
index a8e9b534c8da..26576772f18b 100644
--- a/arch/arm/crypto/chacha-neon-glue.c
+++ b/arch/arm/crypto/chacha-neon-glue.c
@@ -20,7 +20,7 @@
  */
 
 #include <crypto/algapi.h>
-#include <crypto/chacha.h>
+#include <crypto/internal/chacha.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/kernel.h>
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
index 1495d2b18518..d4cc61bfe79d 100644
--- a/arch/arm64/crypto/chacha-neon-glue.c
+++ b/arch/arm64/crypto/chacha-neon-glue.c
@@ -20,7 +20,7 @@
  */
 
 #include <crypto/algapi.h>
-#include <crypto/chacha.h>
+#include <crypto/internal/chacha.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 388f95a4ec24..bc62daa8dafd 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -7,7 +7,7 @@
  */
 
 #include <crypto/algapi.h>
-#include <crypto/chacha.h>
+#include <crypto/internal/chacha.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/kernel.h>
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9def945e9549..ae4495ae003f 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1412,6 +1412,7 @@ config CRYPTO_SALSA20
 
 config CRYPTO_CHACHA20
 	tristate "ChaCha stream cipher algorithms"
+	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_SKCIPHER
 	help
 	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms.
diff --git a/crypto/chacha_generic.c b/crypto/chacha_generic.c
index 085d8d219987..ebae6d9d9b32 100644
--- a/crypto/chacha_generic.c
+++ b/crypto/chacha_generic.c
@@ -8,29 +8,10 @@
 
 #include <asm/unaligned.h>
 #include <crypto/algapi.h>
-#include <crypto/chacha.h>
+#include <crypto/internal/chacha.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/module.h>
 
-static void chacha_docrypt(u32 *state, u8 *dst, const u8 *src,
-			   unsigned int bytes, int nrounds)
-{
-	/* aligned to potentially speed up crypto_xor() */
-	u8 stream[CHACHA_BLOCK_SIZE] __aligned(sizeof(long));
-
-	while (bytes >= CHACHA_BLOCK_SIZE) {
-		chacha_block(state, stream, nrounds);
-		crypto_xor_cpy(dst, src, stream, CHACHA_BLOCK_SIZE);
-		bytes -= CHACHA_BLOCK_SIZE;
-		dst += CHACHA_BLOCK_SIZE;
-		src += CHACHA_BLOCK_SIZE;
-	}
-	if (bytes) {
-		chacha_block(state, stream, nrounds);
-		crypto_xor_cpy(dst, src, stream, bytes);
-	}
-}
-
 static int chacha_stream_xor(struct skcipher_request *req,
 			     const struct chacha_ctx *ctx, const u8 *iv)
 {
@@ -48,8 +29,8 @@ static int chacha_stream_xor(struct skcipher_request *req,
 		if (nbytes < walk.total)
 			nbytes = round_down(nbytes, CHACHA_BLOCK_SIZE);
 
-		chacha_docrypt(state, walk.dst.virt.addr, walk.src.virt.addr,
-			       nbytes, ctx->nrounds);
+		chacha_crypt_generic(state, walk.dst.virt.addr,
+				     walk.src.virt.addr, nbytes, ctx->nrounds);
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 
@@ -58,41 +39,10 @@ static int chacha_stream_xor(struct skcipher_request *req,
 
 void crypto_chacha_init(u32 *state, const struct chacha_ctx *ctx, const u8 *iv)
 {
-	state[0]  = 0x61707865; /* "expa" */
-	state[1]  = 0x3320646e; /* "nd 3" */
-	state[2]  = 0x79622d32; /* "2-by" */
-	state[3]  = 0x6b206574; /* "te k" */
-	state[4]  = ctx->key[0];
-	state[5]  = ctx->key[1];
-	state[6]  = ctx->key[2];
-	state[7]  = ctx->key[3];
-	state[8]  = ctx->key[4];
-	state[9]  = ctx->key[5];
-	state[10] = ctx->key[6];
-	state[11] = ctx->key[7];
-	state[12] = get_unaligned_le32(iv +  0);
-	state[13] = get_unaligned_le32(iv +  4);
-	state[14] = get_unaligned_le32(iv +  8);
-	state[15] = get_unaligned_le32(iv + 12);
+	chacha_init_generic(state, ctx->key, iv);
 }
 EXPORT_SYMBOL_GPL(crypto_chacha_init);
 
-static int chacha_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			 unsigned int keysize, int nrounds)
-{
-	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int i;
-
-	if (keysize != CHACHA_KEY_SIZE)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(ctx->key); i++)
-		ctx->key[i] = get_unaligned_le32(key + i * sizeof(u32));
-
-	ctx->nrounds = nrounds;
-	return 0;
-}
-
 int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			   unsigned int keysize)
 {
@@ -126,7 +76,7 @@ int crypto_xchacha_crypt(struct skcipher_request *req)
 
 	/* Compute the subkey given the original key and first 128 nonce bits */
 	crypto_chacha_init(state, ctx, req->iv);
-	hchacha_block(state, subctx.key, ctx->nrounds);
+	hchacha_block_generic(state, subctx.key, ctx->nrounds);
 	subctx.nrounds = ctx->nrounds;
 
 	/* Build the real IV */
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index d1e723c6a37d..5c662f8fecac 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -15,9 +15,8 @@
 #ifndef _CRYPTO_CHACHA_H
 #define _CRYPTO_CHACHA_H
 
-#include <crypto/skcipher.h>
+#include <asm/unaligned.h>
 #include <linux/types.h>
-#include <linux/crypto.h>
 
 /* 32-bit stream position, then 96-bit nonce (RFC7539 convention) */
 #define CHACHA_IV_SIZE		16
@@ -29,26 +28,70 @@
 /* 192-bit nonce, then 64-bit stream position */
 #define XCHACHA_IV_SIZE		32
 
-struct chacha_ctx {
-	u32 key[8];
-	int nrounds;
-};
-
-void chacha_block(u32 *state, u8 *stream, int nrounds);
+void chacha_block_generic(u32 *state, u8 *stream, int nrounds);
 static inline void chacha20_block(u32 *state, u8 *stream)
 {
-	chacha_block(state, stream, 20);
+	chacha_block_generic(state, stream, 20);
 }
-void hchacha_block(const u32 *in, u32 *out, int nrounds);
 
-void crypto_chacha_init(u32 *state, const struct chacha_ctx *ctx, const u8 *iv);
+void hchacha_block_arch(const u32 *state, u32 *out, int nrounds);
+void hchacha_block_generic(const u32 *state, u32 *out, int nrounds);
+
+static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
+		hchacha_block_arch(state, out, nrounds);
+	else
+		hchacha_block_generic(state, out, nrounds);
+}
 
-int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			   unsigned int keysize);
-int crypto_chacha12_setkey(struct crypto_skcipher *tfm, const u8 *key,
-			   unsigned int keysize);
+void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
+static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+{
+	state[0]  = 0x61707865; /* "expa" */
+	state[1]  = 0x3320646e; /* "nd 3" */
+	state[2]  = 0x79622d32; /* "2-by" */
+	state[3]  = 0x6b206574; /* "te k" */
+	state[4]  = key[0];
+	state[5]  = key[1];
+	state[6]  = key[2];
+	state[7]  = key[3];
+	state[8]  = key[4];
+	state[9]  = key[5];
+	state[10] = key[6];
+	state[11] = key[7];
+	state[12] = get_unaligned_le32(iv +  0);
+	state[13] = get_unaligned_le32(iv +  4);
+	state[14] = get_unaligned_le32(iv +  8);
+	state[15] = get_unaligned_le32(iv + 12);
+}
 
-int crypto_chacha_crypt(struct skcipher_request *req);
-int crypto_xchacha_crypt(struct skcipher_request *req);
+static inline void chacha_init(u32 *state, const u32 *key, const u8 *iv)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
+		chacha_init_arch(state, key, iv);
+	else
+		chacha_init_generic(state, key, iv);
+}
+
+void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
+		       unsigned int bytes, int nrounds);
+void chacha_crypt_generic(u32 *state, u8 *dst, const u8 *src,
+			  unsigned int bytes, int nrounds);
+
+static inline void chacha_crypt(u32 *state, u8 *dst, const u8 *src,
+				unsigned int bytes, int nrounds)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA))
+		chacha_crypt_arch(state, dst, src, bytes, nrounds);
+	else
+		chacha_crypt_generic(state, dst, src, bytes, nrounds);
+}
+
+static inline void chacha20_crypt(u32 *state, u8 *dst, const u8 *src,
+				  unsigned int bytes)
+{
+	chacha_crypt(state, dst, src, bytes, 20);
+}
 
 #endif /* _CRYPTO_CHACHA_H */
diff --git a/include/crypto/internal/chacha.h b/include/crypto/internal/chacha.h
new file mode 100644
index 000000000000..c0e40b245431
--- /dev/null
+++ b/include/crypto/internal/chacha.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _CRYPTO_INTERNAL_CHACHA_H
+#define _CRYPTO_INTERNAL_CHACHA_H
+
+#include <crypto/chacha.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/crypto.h>
+
+struct chacha_ctx {
+	u32 key[8];
+	int nrounds;
+};
+
+void crypto_chacha_init(u32 *state, const struct chacha_ctx *ctx, const u8 *iv);
+
+static inline int chacha_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				unsigned int keysize, int nrounds)
+{
+	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int i;
+
+	if (keysize != CHACHA_KEY_SIZE)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->key); i++)
+		ctx->key[i] = get_unaligned_le32(key + i * sizeof(u32));
+
+	ctx->nrounds = nrounds;
+	return 0;
+}
+
+static inline int chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				  unsigned int keysize)
+{
+	return chacha_setkey(tfm, key, keysize, 20);
+}
+
+static int inline chacha12_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				  unsigned int keysize)
+{
+	return chacha_setkey(tfm, key, keysize, 12);
+}
+
+int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			   unsigned int keysize);
+int crypto_chacha12_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			   unsigned int keysize);
+
+int crypto_chacha_crypt(struct skcipher_request *req);
+int crypto_xchacha_crypt(struct skcipher_request *req);
+
+#endif /* _CRYPTO_CHACHA_H */
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..5af38fd5cc60 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -26,8 +26,7 @@ endif
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
-	 idr.o extable.o \
-	 sha1.o chacha.o irq_regs.o argv_split.o \
+	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 261430051595..6a11931ae105 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -8,6 +8,32 @@ config CRYPTO_LIB_AES
 config CRYPTO_LIB_ARC4
 	tristate
 
+config CRYPTO_ARCH_HAVE_LIB_CHACHA
+	tristate
+	help
+	  Declares whether the architecture provides an arch-specific
+	  accelerated implementation of the ChaCha library interface,
+	  either builtin or as a module.
+
+config CRYPTO_LIB_CHACHA_GENERIC
+	tristate
+	select CRYPTO_ALGAPI
+	help
+	  This symbol can be depended upon by arch implementations of the
+	  ChaCha library interface that require the generic code as a
+	  fallback, e.g., for SIMD implementations. If no arch specific
+	  implementation is enabled, this implementation serves the users
+	  of CRYPTO_LIB_CHACHA.
+
+config CRYPTO_LIB_CHACHA
+	tristate "ChaCha library interface"
+	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
+	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+	help
+	  Enable the ChaCha library interface. This interface may be fulfilled
+	  by either the generic implementation or an arch-specific one, if one
+	  is available and enabled.
+
 config CRYPTO_LIB_DES
 	tristate
 
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 63de4cb3fcf8..0ce40604e104 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# chacha is used by the /dev/random driver which is always builtin
+obj-y						+= chacha.o
+obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
+
 obj-$(CONFIG_CRYPTO_LIB_AES)			+= libaes.o
 libaes-y					:= aes.o
 
diff --git a/lib/chacha.c b/lib/crypto/chacha.c
similarity index 88%
rename from lib/chacha.c
rename to lib/crypto/chacha.c
index c7c9826564d3..65ead6b0c7e0 100644
--- a/lib/chacha.c
+++ b/lib/crypto/chacha.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2015 Martin Willi
  */
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/cryptohash.h>
 #include <asm/unaligned.h>
 #include <crypto/chacha.h>
@@ -72,7 +74,7 @@ static void chacha_permute(u32 *x, int nrounds)
  * The caller has already converted the endianness of the input.  This function
  * also handles incrementing the block counter in the input matrix.
  */
-void chacha_block(u32 *state, u8 *stream, int nrounds)
+void chacha_block_generic(u32 *state, u8 *stream, int nrounds)
 {
 	u32 x[16];
 	int i;
@@ -86,11 +88,11 @@ void chacha_block(u32 *state, u8 *stream, int nrounds)
 
 	state[12]++;
 }
-EXPORT_SYMBOL(chacha_block);
+EXPORT_SYMBOL(chacha_block_generic);
 
 /**
- * hchacha_block - abbreviated ChaCha core, for XChaCha
- * @in: input state matrix (16 32-bit words)
+ * hchacha_block_generic - abbreviated ChaCha core, for XChaCha
+ * @state: input state matrix (16 32-bit words)
  * @out: output (8 32-bit words)
  * @nrounds: number of rounds (20 or 12; 20 is recommended)
  *
@@ -99,15 +101,15 @@ EXPORT_SYMBOL(chacha_block);
  * skips the final addition of the initial state, and outputs only certain words
  * of the state.  It should not be used for streaming directly.
  */
-void hchacha_block(const u32 *in, u32 *out, int nrounds)
+void hchacha_block_generic(const u32 *state, u32 *stream, int nrounds)
 {
 	u32 x[16];
 
-	memcpy(x, in, 64);
+	memcpy(x, state, 64);
 
 	chacha_permute(x, nrounds);
 
-	memcpy(&out[0], &x[0], 16);
-	memcpy(&out[4], &x[12], 16);
+	memcpy(&stream[0], &x[0], 16);
+	memcpy(&stream[4], &x[12], 16);
 }
-EXPORT_SYMBOL(hchacha_block);
+EXPORT_SYMBOL(hchacha_block_generic);
diff --git a/lib/crypto/libchacha.c b/lib/crypto/libchacha.c
new file mode 100644
index 000000000000..dabc3accae05
--- /dev/null
+++ b/lib/crypto/libchacha.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The ChaCha stream cipher (RFC7539)
+ *
+ * Copyright (C) 2015 Martin Willi
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/module.h>
+
+#include <crypto/algapi.h> // for crypto_xor_cpy
+#include <crypto/chacha.h>
+
+void chacha_crypt_generic(u32 *state, u8 *dst, const u8 *src,
+			  unsigned int bytes, int nrounds)
+{
+	/* aligned to potentially speed up crypto_xor() */
+	u8 stream[CHACHA_BLOCK_SIZE] __aligned(sizeof(long));
+
+	while (bytes >= CHACHA_BLOCK_SIZE) {
+		chacha_block_generic(state, stream, nrounds);
+		crypto_xor_cpy(dst, src, stream, CHACHA_BLOCK_SIZE);
+		bytes -= CHACHA_BLOCK_SIZE;
+		dst += CHACHA_BLOCK_SIZE;
+		src += CHACHA_BLOCK_SIZE;
+	}
+	if (bytes) {
+		chacha_block_generic(state, stream, nrounds);
+		crypto_xor_cpy(dst, src, stream, bytes);
+	}
+}
+EXPORT_SYMBOL(chacha_crypt_generic);
+
+MODULE_LICENSE("GPL");
-- 
2.20.1

