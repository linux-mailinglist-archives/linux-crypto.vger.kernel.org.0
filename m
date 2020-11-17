Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF352B62E3
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Nov 2020 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgKQNcl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Nov 2020 08:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbgKQNck (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Nov 2020 08:32:40 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EAB24199;
        Tue, 17 Nov 2020 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605619960;
        bh=N2U9menlQv60P/GBM6E2+KMGks+534jhCdZlvYWzxB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKPVzja5YoK7XofHAZxTxQ/DGxLHzSjEqySpSLFgK5fc2AmvwaJHcZyNbw27y4l5c
         V7gQ/5t6bowjPoVOzi7Qp6awGuCdSouQEjjdJviXABMcumpBCpzkwoG05doRNjHS+O
         PfW+p8looZ3MznGkxkMvaNIvG42T7dblVPSPajbw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 2/4] crypto: aegis128/neon - optimize tail block handling
Date:   Tue, 17 Nov 2020 14:32:12 +0100
Message-Id: <20201117133214.29114-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117133214.29114-1-ardb@kernel.org>
References: <20201117133214.29114-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Avoid copying the tail block via a stack buffer if the total size
exceeds a single AEGIS block. In this case, we can use overlapping
loads and stores and NEON permutation instructions instead, which
leads to a modest performance improvement on some cores (< 5%),
and is slightly cleaner. Note that we still need to use a stack
buffer if the entire input is smaller than 16 bytes, given that
we cannot use 16 byte NEON loads and stores safely in this case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aegis128-neon-inner.c | 89 +++++++++++++++++---
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/crypto/aegis128-neon-inner.c b/crypto/aegis128-neon-inner.c
index 2a660ac1bc3a..cd1b3ad1d1f3 100644
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -20,7 +20,6 @@
 extern int aegis128_have_aes_insn;
 
 void *memcpy(void *dest, const void *src, size_t n);
-void *memset(void *s, int c, size_t n);
 
 struct aegis128_state {
 	uint8x16_t v[5];
@@ -173,10 +172,46 @@ void crypto_aegis128_update_neon(void *state, const void *msg)
 	aegis128_save_state_neon(st, state);
 }
 
+#ifdef CONFIG_ARM
+/*
+ * AArch32 does not provide these intrinsics natively because it does not
+ * implement the underlying instructions. AArch32 only provides 64-bit
+ * wide vtbl.8/vtbx.8 instruction, so use those instead.
+ */
+static uint8x16_t vqtbl1q_u8(uint8x16_t a, uint8x16_t b)
+{
+	union {
+		uint8x16_t	val;
+		uint8x8x2_t	pair;
+	} __a = { a };
+
+	return vcombine_u8(vtbl2_u8(__a.pair, vget_low_u8(b)),
+			   vtbl2_u8(__a.pair, vget_high_u8(b)));
+}
+
+static uint8x16_t vqtbx1q_u8(uint8x16_t v, uint8x16_t a, uint8x16_t b)
+{
+	union {
+		uint8x16_t	val;
+		uint8x8x2_t	pair;
+	} __a = { a };
+
+	return vcombine_u8(vtbx2_u8(vget_low_u8(v), __a.pair, vget_low_u8(b)),
+			   vtbx2_u8(vget_high_u8(v), __a.pair, vget_high_u8(b)));
+}
+#endif
+
+static const uint8_t permute[] __aligned(64) = {
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+};
+
 void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
 					unsigned int size)
 {
 	struct aegis128_state st = aegis128_load_state_neon(state);
+	const int short_input = size < AEGIS_BLOCK_SIZE;
 	uint8x16_t msg;
 
 	preload_sbox();
@@ -186,7 +221,8 @@ void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
 
 		msg = vld1q_u8(src);
 		st = aegis128_update_neon(st, msg);
-		vst1q_u8(dst, msg ^ s);
+		msg ^= s;
+		vst1q_u8(dst, msg);
 
 		size -= AEGIS_BLOCK_SIZE;
 		src += AEGIS_BLOCK_SIZE;
@@ -195,13 +231,26 @@ void crypto_aegis128_encrypt_chunk_neon(void *state, void *dst, const void *src,
 
 	if (size > 0) {
 		uint8x16_t s = st.v[1] ^ (st.v[2] & st.v[3]) ^ st.v[4];
-		uint8_t buf[AEGIS_BLOCK_SIZE] = {};
+		uint8_t buf[AEGIS_BLOCK_SIZE];
+		const void *in = src;
+		void *out = dst;
+		uint8x16_t m;
 
-		memcpy(buf, src, size);
-		msg = vld1q_u8(buf);
-		st = aegis128_update_neon(st, msg);
-		vst1q_u8(buf, msg ^ s);
-		memcpy(dst, buf, size);
+		if (__builtin_expect(short_input, 0))
+			in = out = memcpy(buf + AEGIS_BLOCK_SIZE - size, src, size);
+
+		m = vqtbl1q_u8(vld1q_u8(in + size - AEGIS_BLOCK_SIZE),
+			       vld1q_u8(permute + 32 - size));
+
+		st = aegis128_update_neon(st, m);
+
+		vst1q_u8(out + size - AEGIS_BLOCK_SIZE,
+			 vqtbl1q_u8(m ^ s, vld1q_u8(permute + size)));
+
+		if (__builtin_expect(short_input, 0))
+			memcpy(dst, out, size);
+		else
+			vst1q_u8(out - AEGIS_BLOCK_SIZE, msg);
 	}
 
 	aegis128_save_state_neon(st, state);
@@ -211,6 +260,7 @@ void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
 					unsigned int size)
 {
 	struct aegis128_state st = aegis128_load_state_neon(state);
+	const int short_input = size < AEGIS_BLOCK_SIZE;
 	uint8x16_t msg;
 
 	preload_sbox();
@@ -228,14 +278,25 @@ void crypto_aegis128_decrypt_chunk_neon(void *state, void *dst, const void *src,
 	if (size > 0) {
 		uint8x16_t s = st.v[1] ^ (st.v[2] & st.v[3]) ^ st.v[4];
 		uint8_t buf[AEGIS_BLOCK_SIZE];
+		const void *in = src;
+		void *out = dst;
+		uint8x16_t m;
 
-		vst1q_u8(buf, s);
-		memcpy(buf, src, size);
-		msg = vld1q_u8(buf) ^ s;
-		vst1q_u8(buf, msg);
-		memcpy(dst, buf, size);
+		if (__builtin_expect(short_input, 0))
+			in = out = memcpy(buf + AEGIS_BLOCK_SIZE - size, src, size);
 
-		st = aegis128_update_neon(st, msg);
+		m = s ^ vqtbx1q_u8(s, vld1q_u8(in + size - AEGIS_BLOCK_SIZE),
+				   vld1q_u8(permute + 32 - size));
+
+		st = aegis128_update_neon(st, m);
+
+		vst1q_u8(out + size - AEGIS_BLOCK_SIZE,
+			 vqtbl1q_u8(m, vld1q_u8(permute + size)));
+
+		if (__builtin_expect(short_input, 0))
+			memcpy(dst, out, size);
+		else
+			vst1q_u8(out - AEGIS_BLOCK_SIZE, msg);
 	}
 
 	aegis128_save_state_neon(st, state);
-- 
2.17.1

