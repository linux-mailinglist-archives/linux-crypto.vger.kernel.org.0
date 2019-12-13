Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FCD11E7E5
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Dec 2019 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfLMQPo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Dec 2019 11:15:44 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:42043 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfLMQPo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Dec 2019 11:15:44 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6496c69e;
        Fri, 13 Dec 2019 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=mail; bh=IJGLjR/jsXq9
        nFZgtA6xSnrurPA=; b=keQbMEqDWh0DaxOs2XBdn50RFexY06GhMSy7zUPELH9f
        I7L/qN9On3FL1YbkZpgNOYncp0ZUnAlta10QfT6O6G6EYZP16RyldEo9rLZxsYH1
        XhAofeB2kgpLMLGMm0H1AH+bXqTcjKA9nNuF5ZOGMkKbOkktkEc435rRFx69jZt+
        24MqotODVPL4+h5NqS84EzhhS3whc0vYkRnm96IGXZZGFlMwq52+LEQvGpb026Gb
        cBEdRN0xg5SSi5KCFfxvzigX0dDHomIpuZJ+LgCEq2eEg7AatleKLYWfyc7XVGv4
        dcugdCAfg6StQVs8cKU/hGX1yZ0e6afACypJgsY2Ug==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a60f4e0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 13 Dec 2019 15:19:37 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] crypto: arm/arm64/mips/poly1305 - remove redundant non-reduction from emit
Date:   Fri, 13 Dec 2019 17:15:23 +0100
Message-Id: <20191213161523.843442-3-Jason@zx2c4.com>
In-Reply-To: <20191213161523.843442-1-Jason@zx2c4.com>
References: <20191213161523.843442-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This appears to be some kind of copy and paste error, and is actually
dead code.

Pre: f = 0 ⇒ (f >> 32) = 0
    f = (f >> 32) + le32_to_cpu(digest[0]);
Post: 0 ≤ f < 2³²
    put_unaligned_le32(f, dst);

Pre: 0 ≤ f < 2³² ⇒ (f >> 32) = 0
    f = (f >> 32) + le32_to_cpu(digest[1]);
Post: 0 ≤ f < 2³²
    put_unaligned_le32(f, dst + 4);

Pre: 0 ≤ f < 2³² ⇒ (f >> 32) = 0
    f = (f >> 32) + le32_to_cpu(digest[2]);
Post: 0 ≤ f < 2³²
    put_unaligned_le32(f, dst + 8);

Pre: 0 ≤ f < 2³² ⇒ (f >> 32) = 0
    f = (f >> 32) + le32_to_cpu(digest[3]);
Post: 0 ≤ f < 2³²
    put_unaligned_le32(f, dst + 12);

Therefore this sequence is redundant. And Andy's code appears to handle
misalignment acceptably.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/crypto/poly1305-glue.c   | 18 ++----------------
 arch/arm64/crypto/poly1305-glue.c | 18 ++----------------
 arch/mips/crypto/poly1305-glue.c  | 18 ++----------------
 3 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/arch/arm/crypto/poly1305-glue.c b/arch/arm/crypto/poly1305-glue.c
index abe3f2d587dc..ceec04ec2f40 100644
--- a/arch/arm/crypto/poly1305-glue.c
+++ b/arch/arm/crypto/poly1305-glue.c
@@ -20,7 +20,7 @@
 
 void poly1305_init_arm(void *state, const u8 *key);
 void poly1305_blocks_arm(void *state, const u8 *src, u32 len, u32 hibit);
-void poly1305_emit_arm(void *state, __le32 *digest, const u32 *nonce);
+void poly1305_emit_arm(void *state, u8 *digest, const u32 *nonce);
 
 void __weak poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit)
 {
@@ -179,9 +179,6 @@ EXPORT_SYMBOL(poly1305_update_arch);
 
 void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 {
-	__le32 digest[4];
-	u64 f = 0;
-
 	if (unlikely(dctx->buflen)) {
 		dctx->buf[dctx->buflen++] = 1;
 		memset(dctx->buf + dctx->buflen, 0,
@@ -189,18 +186,7 @@ void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 		poly1305_blocks_arm(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
 	}
 
-	poly1305_emit_arm(&dctx->h, digest, dctx->s);
-
-	/* mac = (h + s) % (2^128) */
-	f = (f >> 32) + le32_to_cpu(digest[0]);
-	put_unaligned_le32(f, dst);
-	f = (f >> 32) + le32_to_cpu(digest[1]);
-	put_unaligned_le32(f, dst + 4);
-	f = (f >> 32) + le32_to_cpu(digest[2]);
-	put_unaligned_le32(f, dst + 8);
-	f = (f >> 32) + le32_to_cpu(digest[3]);
-	put_unaligned_le32(f, dst + 12);
-
+	poly1305_emit_arm(&dctx->h, dst, dctx->s);
 	*dctx = (struct poly1305_desc_ctx){};
 }
 EXPORT_SYMBOL(poly1305_final_arch);
diff --git a/arch/arm64/crypto/poly1305-glue.c b/arch/arm64/crypto/poly1305-glue.c
index 83a2338a8826..e97b092f56b8 100644
--- a/arch/arm64/crypto/poly1305-glue.c
+++ b/arch/arm64/crypto/poly1305-glue.c
@@ -21,7 +21,7 @@
 asmlinkage void poly1305_init_arm64(void *state, const u8 *key);
 asmlinkage void poly1305_blocks(void *state, const u8 *src, u32 len, u32 hibit);
 asmlinkage void poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit);
-asmlinkage void poly1305_emit(void *state, __le32 *digest, const u32 *nonce);
+asmlinkage void poly1305_emit(void *state, u8 *digest, const u32 *nonce);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
 
@@ -162,9 +162,6 @@ EXPORT_SYMBOL(poly1305_update_arch);
 
 void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 {
-	__le32 digest[4];
-	u64 f = 0;
-
 	if (unlikely(dctx->buflen)) {
 		dctx->buf[dctx->buflen++] = 1;
 		memset(dctx->buf + dctx->buflen, 0,
@@ -172,18 +169,7 @@ void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 		poly1305_blocks(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
 	}
 
-	poly1305_emit(&dctx->h, digest, dctx->s);
-
-	/* mac = (h + s) % (2^128) */
-	f = (f >> 32) + le32_to_cpu(digest[0]);
-	put_unaligned_le32(f, dst);
-	f = (f >> 32) + le32_to_cpu(digest[1]);
-	put_unaligned_le32(f, dst + 4);
-	f = (f >> 32) + le32_to_cpu(digest[2]);
-	put_unaligned_le32(f, dst + 8);
-	f = (f >> 32) + le32_to_cpu(digest[3]);
-	put_unaligned_le32(f, dst + 12);
-
+	poly1305_emit(&dctx->h, dst, dctx->s);
 	*dctx = (struct poly1305_desc_ctx){};
 }
 EXPORT_SYMBOL(poly1305_final_arch);
diff --git a/arch/mips/crypto/poly1305-glue.c b/arch/mips/crypto/poly1305-glue.c
index b37d29cf5d0a..fc881b46d911 100644
--- a/arch/mips/crypto/poly1305-glue.c
+++ b/arch/mips/crypto/poly1305-glue.c
@@ -15,7 +15,7 @@
 
 asmlinkage void poly1305_init_mips(void *state, const u8 *key);
 asmlinkage void poly1305_blocks_mips(void *state, const u8 *src, u32 len, u32 hibit);
-asmlinkage void poly1305_emit_mips(void *state, __le32 *digest, const u32 *nonce);
+asmlinkage void poly1305_emit_mips(void *state, u8 *digest, const u32 *nonce);
 
 void poly1305_init_arch(struct poly1305_desc_ctx *dctx, const u8 *key)
 {
@@ -134,9 +134,6 @@ EXPORT_SYMBOL(poly1305_update_arch);
 
 void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 {
-	__le32 digest[4];
-	u64 f = 0;
-
 	if (unlikely(dctx->buflen)) {
 		dctx->buf[dctx->buflen++] = 1;
 		memset(dctx->buf + dctx->buflen, 0,
@@ -144,18 +141,7 @@ void poly1305_final_arch(struct poly1305_desc_ctx *dctx, u8 *dst)
 		poly1305_blocks_mips(&dctx->h, dctx->buf, POLY1305_BLOCK_SIZE, 0);
 	}
 
-	poly1305_emit_mips(&dctx->h, digest, dctx->s);
-
-	/* mac = (h + s) % (2^128) */
-	f = (f >> 32) + le32_to_cpu(digest[0]);
-	put_unaligned_le32(f, dst);
-	f = (f >> 32) + le32_to_cpu(digest[1]);
-	put_unaligned_le32(f, dst + 4);
-	f = (f >> 32) + le32_to_cpu(digest[2]);
-	put_unaligned_le32(f, dst + 8);
-	f = (f >> 32) + le32_to_cpu(digest[3]);
-	put_unaligned_le32(f, dst + 12);
-
+	poly1305_emit_mips(&dctx->h, dst, dctx->s);
 	*dctx = (struct poly1305_desc_ctx){};
 }
 EXPORT_SYMBOL(poly1305_final_arch);
-- 
2.24.1

