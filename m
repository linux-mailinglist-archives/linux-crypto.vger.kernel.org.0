Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7B3076BC
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Jan 2021 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhA1NHk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 Jan 2021 08:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231736AbhA1NHf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 Jan 2021 08:07:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58B5C64DCE;
        Thu, 28 Jan 2021 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611839213;
        bh=C83nzGZUUKSkv/8BI2w4723y++kWv7r8HeCsJgHyjds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjUCAn1/xVCtiktoSxX7AiIbWmEkg4IkgMOCRgYNkHLMTG98CmKkoenz7voVnANdo
         xuB5ns5A7yVaygKM5JmNRruwqqEEnWvX+3Xcr7TzQFAAToQQMFLZ0XOUX/mFjhavHx
         SLsUuarc5iCw4TJtR7JGGBPknz5U4DHkAHcE5Lt96mhvCIukYOW8EcdgdHVAmrFRZ0
         VnxN7Jon4D/GCHWWe5s3tnINCEY1oobjBR4t7va1ot3s5xhsxSHgbJ0Z7rXHKHeB+X
         xaUhykTaK0ephMm9uK8/cTEOkXw+8v02NxGj5Hpi45Eu553ZqgEdkQSVpQ4ZZQjeOU
         zfltMRobYH2Fg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5/9] crypto: arm64/sha512-ce - simplify NEON yield
Date:   Thu, 28 Jan 2021 14:06:21 +0100
Message-Id: <20210128130625.54076-6-ardb@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128130625.54076-1-ardb@kernel.org>
References: <20210128130625.54076-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Instead of calling into kernel_neon_end() and kernel_neon_begin() (and
potentially into schedule()) from the assembler code when running in
task mode and a reschedule is pending, perform only the preempt count
check in assembler, but simply return early in this case, and let the C
code deal with the consequences.

This reverts commit 6caf7adc5e458f77f550b6c6ca8effa152d61b4a.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sha512-ce-core.S | 29 +++--------
 arch/arm64/crypto/sha512-ce-glue.c | 53 ++++++++++----------
 2 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/crypto/sha512-ce-core.S b/arch/arm64/crypto/sha512-ce-core.S
index cde606c0323e..d6e7f6c95fa6 100644
--- a/arch/arm64/crypto/sha512-ce-core.S
+++ b/arch/arm64/crypto/sha512-ce-core.S
@@ -107,23 +107,17 @@
 	 */
 	.text
 SYM_FUNC_START(sha512_ce_transform)
-	frame_push	3
-
-	mov		x19, x0
-	mov		x20, x1
-	mov		x21, x2
-
 	/* load state */
-0:	ld1		{v8.2d-v11.2d}, [x19]
+	ld1		{v8.2d-v11.2d}, [x0]
 
 	/* load first 4 round constants */
 	adr_l		x3, .Lsha512_rcon
 	ld1		{v20.2d-v23.2d}, [x3], #64
 
 	/* load input */
-1:	ld1		{v12.2d-v15.2d}, [x20], #64
-	ld1		{v16.2d-v19.2d}, [x20], #64
-	sub		w21, w21, #1
+0:	ld1		{v12.2d-v15.2d}, [x1], #64
+	ld1		{v16.2d-v19.2d}, [x1], #64
+	sub		w2, w2, #1
 
 CPU_LE(	rev64		v12.16b, v12.16b	)
 CPU_LE(	rev64		v13.16b, v13.16b	)
@@ -201,19 +195,12 @@ CPU_LE(	rev64		v19.16b, v19.16b	)
 	add		v10.2d, v10.2d, v2.2d
 	add		v11.2d, v11.2d, v3.2d
 
+	cond_yield	3f, x4
 	/* handled all input blocks? */
-	cbz		w21, 3f
-
-	if_will_cond_yield_neon
-	st1		{v8.2d-v11.2d}, [x19]
-	do_cond_yield_neon
-	b		0b
-	endif_yield_neon
-
-	b		1b
+	cbnz		w2, 0b
 
 	/* store new state */
-3:	st1		{v8.2d-v11.2d}, [x19]
-	frame_pop
+3:	st1		{v8.2d-v11.2d}, [x0]
+	mov		w0, w2
 	ret
 SYM_FUNC_END(sha512_ce_transform)
diff --git a/arch/arm64/crypto/sha512-ce-glue.c b/arch/arm64/crypto/sha512-ce-glue.c
index a6b1adf31c56..e62a094a9d52 100644
--- a/arch/arm64/crypto/sha512-ce-glue.c
+++ b/arch/arm64/crypto/sha512-ce-glue.c
@@ -26,11 +26,25 @@ MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_CRYPTO("sha384");
 MODULE_ALIAS_CRYPTO("sha512");
 
-asmlinkage void sha512_ce_transform(struct sha512_state *sst, u8 const *src,
-				    int blocks);
+asmlinkage int sha512_ce_transform(struct sha512_state *sst, u8 const *src,
+				   int blocks);
 
 asmlinkage void sha512_block_data_order(u64 *digest, u8 const *src, int blocks);
 
+static void __sha512_ce_transform(struct sha512_state *sst, u8 const *src,
+				  int blocks)
+{
+	while (blocks) {
+		int rem;
+
+		kernel_neon_begin();
+		rem = sha512_ce_transform(sst, src, blocks);
+		kernel_neon_end();
+		src += (blocks - rem) * SHA512_BLOCK_SIZE;
+		blocks = rem;
+	}
+}
+
 static void __sha512_block_data_order(struct sha512_state *sst, u8 const *src,
 				      int blocks)
 {
@@ -40,45 +54,30 @@ static void __sha512_block_data_order(struct sha512_state *sst, u8 const *src,
 static int sha512_ce_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int len)
 {
-	if (!crypto_simd_usable())
-		return sha512_base_do_update(desc, data, len,
-					     __sha512_block_data_order);
-
-	kernel_neon_begin();
-	sha512_base_do_update(desc, data, len, sha512_ce_transform);
-	kernel_neon_end();
+	sha512_block_fn *fn = crypto_simd_usable() ? __sha512_ce_transform
+						   : __sha512_block_data_order;
 
+	sha512_base_do_update(desc, data, len, fn);
 	return 0;
 }
 
 static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
 			   unsigned int len, u8 *out)
 {
-	if (!crypto_simd_usable()) {
-		if (len)
-			sha512_base_do_update(desc, data, len,
-					      __sha512_block_data_order);
-		sha512_base_do_finalize(desc, __sha512_block_data_order);
-		return sha512_base_finish(desc, out);
-	}
+	sha512_block_fn *fn = crypto_simd_usable() ? __sha512_ce_transform
+						   : __sha512_block_data_order;
 
-	kernel_neon_begin();
-	sha512_base_do_update(desc, data, len, sha512_ce_transform);
-	sha512_base_do_finalize(desc, sha512_ce_transform);
-	kernel_neon_end();
+	sha512_base_do_update(desc, data, len, fn);
+	sha512_base_do_finalize(desc, fn);
 	return sha512_base_finish(desc, out);
 }
 
 static int sha512_ce_final(struct shash_desc *desc, u8 *out)
 {
-	if (!crypto_simd_usable()) {
-		sha512_base_do_finalize(desc, __sha512_block_data_order);
-		return sha512_base_finish(desc, out);
-	}
+	sha512_block_fn *fn = crypto_simd_usable() ? __sha512_ce_transform
+						   : __sha512_block_data_order;
 
-	kernel_neon_begin();
-	sha512_base_do_finalize(desc, sha512_ce_transform);
-	kernel_neon_end();
+	sha512_base_do_finalize(desc, fn);
 	return sha512_base_finish(desc, out);
 }
 
-- 
2.29.2

