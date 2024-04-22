Return-Path: <linux-crypto+bounces-3768-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0278AD5E7
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Apr 2024 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CB61F21AA4
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Apr 2024 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463C1C69C;
	Mon, 22 Apr 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La5j9vId"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81F1BF3A;
	Mon, 22 Apr 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818163; cv=none; b=UNE3Bwk9HnqC+ossTphLYQeOpIrLND47g8AjwvRfJ1p/Olf3FXpyf4y1cIshRswib+ZEszRnMbkHsR9Q6lQpU34upCLRGmqZbsoaclC4exO6xY0sIjDODC5EhmVesFmb0ajeRu3sl4/L04UqUOMG6QJbJ95HXgGrcO+HSooFPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818163; c=relaxed/simple;
	bh=G+NBMVxus0f5e2bbgdlefiZNWwtsKtPBwwOy3E02WiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcRsBXn5HxwwEF+eKhRMQJfiFd2p5HkMq80Psq1LLMLoH+SE1mCscrNoFleBVUW5YbMtvkpwFyS+9JLsz8sba5MyGgwUK+Ht/81wQerHs3kCzaYC0SOOZCSfSE2Z117J+NuQ8BgQQs8QCDCc0vPKXg3nCc4XBZO3etv36wQ524M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La5j9vId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5935C32782;
	Mon, 22 Apr 2024 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713818163;
	bh=G+NBMVxus0f5e2bbgdlefiZNWwtsKtPBwwOy3E02WiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=La5j9vIdrI37PDvEMdH2xCJKgcWDtMSGXCC/A/Nhw3XGG01YobNrqrbsQYbJVSKKv
	 WZ6N+F/MxDAk4O6OSMBxFxUY82WA0QilqF35J2kb344qcKagBnnbNqJVajq5jg1JBd
	 Npj1bzhgd/mGUIZ0dKTAgdlzRAkqnkDXop7ip+F5dHIO6TzRFKnlfzOd4BIRHyItSt
	 /tK7NuD987CDC2MBg2mxXz52D8DdYR5+CkuQghPcNYqhCRcVmhQ7RmDDPLuOgcrWlD
	 Puzj/Vg6Ufl15/YdmDqB9+S7RNjy81n74OyScdKE1qxCoRwL4Ni9kJ+iE3NVVslJaO
	 P3F+XdyEzlLuQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	fsverity@lists.linux.dev,
	dm-devel@lists.linux.dev
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 4/8] crypto: x86/sha256-ni - add support for finup2x
Date: Mon, 22 Apr 2024 13:35:40 -0700
Message-ID: <20240422203544.195390-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422203544.195390-1-ebiggers@kernel.org>
References: <20240422203544.195390-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add an implementation of finup2x to sha256-ni.  finup2x interleaves a
finup operation for two equal-length messages that share a common
prefix.  dm-verity and fs-verity will take advantage of this for
significantly improved performance on capable CPUs.

This increases the throughput of SHA-256 hashing 4096-byte messages by
the following amounts on the following CPUs:

    AMD Zen 1:                  84%
    AMD Zen 4:                  98%
    Intel Ice Lake:              4%
    Intel Sapphire Rapids:      20%

For now, this seems to benefit AMD much more than Intel.  This seems to
be because current AMD CPUs support concurrent execution of the SHA-NI
instructions, but unfortunately current Intel CPUs don't, except for the
sha256msg2 instruction.  Hopefully future Intel CPUs will support SHA-NI
on more execution ports.  Zen 1 supports 2 concurrent sha256rnds2, and
Zen 4 supports 4 concurrent sha256rnds2, which suggests that even better
performance may be achievable on Zen 4 by interleaving more than two
hashes; however, doing so poses a number of trade-offs.

It's been reported that the method that achieves the highest SHA-256
throughput on Intel CPUs is actually computing 16 hashes simultaneously
using AVX512.  That method would be quite different to the SHA-NI method
used in this patch.  However, such a high interleaving factor isn't
practical for the use cases being targeted in the kernel.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S     | 368 ++++++++++++++++++++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c |  41 ++++
 2 files changed, 409 insertions(+)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index d515a55a3bc1..5e97922a24e4 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -172,10 +172,378 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 .Ldone_hash:
 
 	RET
 SYM_FUNC_END(sha256_ni_transform)
 
+#undef DIGEST_PTR
+#undef DATA_PTR
+#undef NUM_BLKS
+#undef SHA256CONSTANTS
+#undef MSG
+#undef STATE0
+#undef STATE1
+#undef MSG0
+#undef MSG1
+#undef MSG2
+#undef MSG3
+#undef TMP
+#undef SHUF_MASK
+#undef ABEF_SAVE
+#undef CDGH_SAVE
+
+// parameters for __sha256_ni_finup2x()
+#define SCTX		%rdi
+#define DATA1		%rsi
+#define DATA2		%rdx
+#define LEN		%ecx
+#define LEN8		%cl
+#define LEN64		%rcx
+#define OUT1		%r8
+#define OUT2		%r9
+
+// other scalar variables
+#define SHA256CONSTANTS	%rax
+#define COUNT		%r10
+#define COUNT32		%r10d
+#define FINAL_STEP	%r11d
+
+// rbx is used as a temporary.
+
+#define MSG		%xmm0	// sha256rnds2 implicit operand
+#define STATE0_A	%xmm1
+#define STATE1_A	%xmm2
+#define STATE0_B	%xmm3
+#define STATE1_B	%xmm4
+#define TMP_A		%xmm5
+#define TMP_B		%xmm6
+#define MSG0_A		%xmm7
+#define MSG1_A		%xmm8
+#define MSG2_A		%xmm9
+#define MSG3_A		%xmm10
+#define MSG0_B		%xmm11
+#define MSG1_B		%xmm12
+#define MSG2_B		%xmm13
+#define MSG3_B		%xmm14
+#define SHUF_MASK	%xmm15
+
+#define OFFSETOF_STATE	0	// offsetof(struct sha256_state, state)
+#define OFFSETOF_COUNT	32	// offsetof(struct sha256_state, count)
+#define OFFSETOF_BUF	40	// offsetof(struct sha256_state, buf)
+
+// Do 4 rounds of SHA-256 for each of two messages (interleaved).  m0_a and m0_b
+// contain the current 4 message schedule words for the first and second message
+// respectively.
+//
+// If not all the message schedule words have been computed yet, then this also
+// computes 4 more message schedule words for each message.  m1_a-m3_a contain
+// the next 3 groups of 4 message schedule words for the first message, and
+// likewise m1_b-m3_b for the second.  After consuming the current value of
+// m0_a, this macro computes the group after m3_a and writes it to m0_a, and
+// likewise for *_b.  This means that the next (m0_a, m1_a, m2_a, m3_a) is the
+// current (m1_a, m2_a, m3_a, m0_a), and likewise for *_b, so the caller must
+// cycle through the registers accordingly.
+.macro	do_4rounds_2x	i, m0_a, m1_a, m2_a, m3_a,  m0_b, m1_b, m2_b, m3_b
+	movdqa		(\i-32)*4(SHA256CONSTANTS), TMP_A
+	movdqa		TMP_A, TMP_B
+	paddd		\m0_a, TMP_A
+	paddd		\m0_b, TMP_B
+.if \i < 48
+	sha256msg1	\m1_a, \m0_a
+	sha256msg1	\m1_b, \m0_b
+.endif
+	movdqa		TMP_A, MSG
+	sha256rnds2	STATE0_A, STATE1_A
+	movdqa		TMP_B, MSG
+	sha256rnds2	STATE0_B, STATE1_B
+	pshufd 		$0x0E, TMP_A, MSG
+	sha256rnds2	STATE1_A, STATE0_A
+	pshufd 		$0x0E, TMP_B, MSG
+	sha256rnds2	STATE1_B, STATE0_B
+.if \i < 48
+	movdqa		\m3_a, TMP_A
+	movdqa		\m3_b, TMP_B
+	palignr		$4, \m2_a, TMP_A
+	palignr		$4, \m2_b, TMP_B
+	paddd		TMP_A, \m0_a
+	paddd		TMP_B, \m0_b
+	sha256msg2	\m3_a, \m0_a
+	sha256msg2	\m3_b, \m0_b
+.endif
+.endm
+
+//
+// void __sha256_ni_finup2x(const struct sha256_state *sctx,
+//			    const u8 *data1, const u8 *data2, int len,
+//			    u8 out1[SHA256_DIGEST_SIZE],
+//			    u8 out2[SHA256_DIGEST_SIZE]);
+//
+// This function computes the SHA-256 digests of two messages |data1| and
+// |data2| that are both |len| bytes long, starting from the initial state
+// |sctx|.  |len| must be at least SHA256_BLOCK_SIZE.
+//
+// The instructions for the two SHA-256 operations are interleaved.  On many
+// CPUs, this is almost twice as fast as hashing each message individually due
+// to taking better advantage of the CPU's SHA-256 and SIMD throughput.
+//
+SYM_FUNC_START(__sha256_ni_finup2x)
+	// Allocate 128 bytes of stack space, 16-byte aligned.
+	push		%rbx
+	push		%rbp
+	mov		%rsp, %rbp
+	sub		$128, %rsp
+	and		$~15, %rsp
+
+	// Load the shuffle mask for swapping the endianness of 32-bit words.
+	movdqa		PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
+
+	// Set up pointer to the round constants.
+	lea		K256+32*4(%rip), SHA256CONSTANTS
+
+	// Initially we're not processing the final blocks.
+	xor		FINAL_STEP, FINAL_STEP
+
+	// Load the initial state from sctx->state.
+	movdqu		OFFSETOF_STATE+0*16(SCTX), STATE0_A	// DCBA
+	movdqu		OFFSETOF_STATE+1*16(SCTX), STATE1_A	// HGFE
+	movdqa		STATE0_A, TMP_A
+	punpcklqdq	STATE1_A, STATE0_A			// FEBA
+	punpckhqdq	TMP_A, STATE1_A				// DCHG
+	pshufd		$0x1B, STATE0_A, STATE0_A		// ABEF
+	pshufd		$0xB1, STATE1_A, STATE1_A		// CDGH
+
+	// Load sctx->count.  Take the mod 64 of it to get the number of bytes
+	// that are buffered in sctx->buf.  Also save it in a register with LEN
+	// added to it.
+	mov		LEN, LEN
+	mov		OFFSETOF_COUNT(SCTX), %rbx
+	lea		(%rbx, LEN64, 1), COUNT
+	and		$63, %ebx
+	jz		.Lfinup2x_enter_loop	// No bytes buffered?
+
+	// %ebx bytes (1 to 63) are currently buffered in sctx->buf.  Load them
+	// followed by the first 64 - %ebx bytes of data.  Since LEN >= 64, we
+	// just load 64 bytes from each of sctx->buf, DATA1, and DATA2
+	// unconditionally and rearrange the data as needed.
+
+	movdqu		OFFSETOF_BUF+0*16(SCTX), MSG0_A
+	movdqu		OFFSETOF_BUF+1*16(SCTX), MSG1_A
+	movdqu		OFFSETOF_BUF+2*16(SCTX), MSG2_A
+	movdqu		OFFSETOF_BUF+3*16(SCTX), MSG3_A
+	movdqa		MSG0_A, 0*16(%rsp)
+	movdqa		MSG1_A, 1*16(%rsp)
+	movdqa		MSG2_A, 2*16(%rsp)
+	movdqa		MSG3_A, 3*16(%rsp)
+
+	movdqu		0*16(DATA1), MSG0_A
+	movdqu		1*16(DATA1), MSG1_A
+	movdqu		2*16(DATA1), MSG2_A
+	movdqu		3*16(DATA1), MSG3_A
+	movdqu		MSG0_A, 0*16(%rsp,%rbx)
+	movdqu		MSG1_A, 1*16(%rsp,%rbx)
+	movdqu		MSG2_A, 2*16(%rsp,%rbx)
+	movdqu		MSG3_A, 3*16(%rsp,%rbx)
+	movdqa		0*16(%rsp), MSG0_A
+	movdqa		1*16(%rsp), MSG1_A
+	movdqa		2*16(%rsp), MSG2_A
+	movdqa		3*16(%rsp), MSG3_A
+
+	movdqu		0*16(DATA2), MSG0_B
+	movdqu		1*16(DATA2), MSG1_B
+	movdqu		2*16(DATA2), MSG2_B
+	movdqu		3*16(DATA2), MSG3_B
+	movdqu		MSG0_B, 0*16(%rsp,%rbx)
+	movdqu		MSG1_B, 1*16(%rsp,%rbx)
+	movdqu		MSG2_B, 2*16(%rsp,%rbx)
+	movdqu		MSG3_B, 3*16(%rsp,%rbx)
+	movdqa		0*16(%rsp), MSG0_B
+	movdqa		1*16(%rsp), MSG1_B
+	movdqa		2*16(%rsp), MSG2_B
+	movdqa		3*16(%rsp), MSG3_B
+
+	sub		$64, %rbx 	// rbx = buffered - 64
+	sub		%rbx, DATA1	// DATA1 += 64 - buffered
+	sub		%rbx, DATA2	// DATA2 += 64 - buffered
+	add		%ebx, LEN	// LEN += buffered - 64
+	movdqa		STATE0_A, STATE0_B
+	movdqa		STATE1_A, STATE1_B
+	jmp		.Lfinup2x_loop_have_data
+
+.Lfinup2x_enter_loop:
+	sub		$64, LEN
+	movdqa		STATE0_A, STATE0_B
+	movdqa		STATE1_A, STATE1_B
+.Lfinup2x_loop:
+	// Load the next two data blocks.
+	movdqu		0*16(DATA1), MSG0_A
+	movdqu		0*16(DATA2), MSG0_B
+	movdqu		1*16(DATA1), MSG1_A
+	movdqu		1*16(DATA2), MSG1_B
+	movdqu		2*16(DATA1), MSG2_A
+	movdqu		2*16(DATA2), MSG2_B
+	movdqu		3*16(DATA1), MSG3_A
+	movdqu		3*16(DATA2), MSG3_B
+	add		$64, DATA1
+	add		$64, DATA2
+.Lfinup2x_loop_have_data:
+	// Convert the words of the data blocks from big endian.
+	pshufb		SHUF_MASK, MSG0_A
+	pshufb		SHUF_MASK, MSG0_B
+	pshufb		SHUF_MASK, MSG1_A
+	pshufb		SHUF_MASK, MSG1_B
+	pshufb		SHUF_MASK, MSG2_A
+	pshufb		SHUF_MASK, MSG2_B
+	pshufb		SHUF_MASK, MSG3_A
+	pshufb		SHUF_MASK, MSG3_B
+.Lfinup2x_loop_have_bswapped_data:
+
+	// Save the original state for each block.
+	movdqa		STATE0_A, 0*16(%rsp)
+	movdqa		STATE0_B, 1*16(%rsp)
+	movdqa		STATE1_A, 2*16(%rsp)
+	movdqa		STATE1_B, 3*16(%rsp)
+
+	// Do the SHA-256 rounds on each block.
+.irp i, 0, 16, 32, 48
+	do_4rounds_2x	(\i + 0),  MSG0_A, MSG1_A, MSG2_A, MSG3_A, \
+				   MSG0_B, MSG1_B, MSG2_B, MSG3_B
+	do_4rounds_2x	(\i + 4),  MSG1_A, MSG2_A, MSG3_A, MSG0_A, \
+				   MSG1_B, MSG2_B, MSG3_B, MSG0_B
+	do_4rounds_2x	(\i + 8),  MSG2_A, MSG3_A, MSG0_A, MSG1_A, \
+				   MSG2_B, MSG3_B, MSG0_B, MSG1_B
+	do_4rounds_2x	(\i + 12), MSG3_A, MSG0_A, MSG1_A, MSG2_A, \
+				   MSG3_B, MSG0_B, MSG1_B, MSG2_B
+.endr
+
+	// Add the original state for each block.
+	paddd		0*16(%rsp), STATE0_A
+	paddd		1*16(%rsp), STATE0_B
+	paddd		2*16(%rsp), STATE1_A
+	paddd		3*16(%rsp), STATE1_B
+
+	// Update LEN and loop back if more blocks remain.
+	sub		$64, LEN
+	jge		.Lfinup2x_loop
+
+	// Check if any final blocks need to be handled.
+	// FINAL_STEP = 2: all done
+	// FINAL_STEP = 1: need to do count-only padding block
+	// FINAL_STEP = 0: need to do the block with 0x80 padding byte
+	cmp		$1, FINAL_STEP
+	jg		.Lfinup2x_done
+	je		.Lfinup2x_finalize_countonly
+	add		$64, LEN
+	jz		.Lfinup2x_finalize_blockaligned
+
+	// Not block-aligned; 1 <= LEN <= 63 data bytes remain.  Pad the block.
+	// To do this, write the padding starting with the 0x80 byte to
+	// &sp[64].  Then for each message, copy the last 64 data bytes to sp
+	// and load from &sp[64 - LEN] to get the needed padding block.  This
+	// code relies on the data buffers being >= 64 bytes in length.
+	mov		$64, %ebx
+	sub		LEN, %ebx		// ebx = 64 - LEN
+	sub		%rbx, DATA1		// DATA1 -= 64 - LEN
+	sub		%rbx, DATA2		// DATA2 -= 64 - LEN
+	mov		$0x80, FINAL_STEP   // using FINAL_STEP as a temporary
+	movd		FINAL_STEP, MSG0_A
+	pxor		MSG1_A, MSG1_A
+	movdqa		MSG0_A, 4*16(%rsp)
+	movdqa		MSG1_A, 5*16(%rsp)
+	movdqa		MSG1_A, 6*16(%rsp)
+	movdqa		MSG1_A, 7*16(%rsp)
+	cmp		$56, LEN
+	jge		1f	// will COUNT spill into its own block?
+	shl		$3, COUNT
+	bswap		COUNT
+	mov		COUNT, 56(%rsp,%rbx)
+	mov		$2, FINAL_STEP	// won't need count-only block
+	jmp		2f
+1:
+	mov		$1, FINAL_STEP	// will need count-only block
+2:
+	movdqu		0*16(DATA1), MSG0_A
+	movdqu		1*16(DATA1), MSG1_A
+	movdqu		2*16(DATA1), MSG2_A
+	movdqu		3*16(DATA1), MSG3_A
+	movdqa		MSG0_A, 0*16(%rsp)
+	movdqa		MSG1_A, 1*16(%rsp)
+	movdqa		MSG2_A, 2*16(%rsp)
+	movdqa		MSG3_A, 3*16(%rsp)
+	movdqu		0*16(%rsp,%rbx), MSG0_A
+	movdqu		1*16(%rsp,%rbx), MSG1_A
+	movdqu		2*16(%rsp,%rbx), MSG2_A
+	movdqu		3*16(%rsp,%rbx), MSG3_A
+
+	movdqu		0*16(DATA2), MSG0_B
+	movdqu		1*16(DATA2), MSG1_B
+	movdqu		2*16(DATA2), MSG2_B
+	movdqu		3*16(DATA2), MSG3_B
+	movdqa		MSG0_B, 0*16(%rsp)
+	movdqa		MSG1_B, 1*16(%rsp)
+	movdqa		MSG2_B, 2*16(%rsp)
+	movdqa		MSG3_B, 3*16(%rsp)
+	movdqu		0*16(%rsp,%rbx), MSG0_B
+	movdqu		1*16(%rsp,%rbx), MSG1_B
+	movdqu		2*16(%rsp,%rbx), MSG2_B
+	movdqu		3*16(%rsp,%rbx), MSG3_B
+	jmp		.Lfinup2x_loop_have_data
+
+	// Prepare a padding block, either:
+	//
+	//	{0x80, 0, 0, 0, ..., count (as __be64)}
+	//	This is for a block aligned message.
+	//
+	//	{   0, 0, 0, 0, ..., count (as __be64)}
+	//	This is for a message whose length mod 64 is >= 56.
+	//
+	// Pre-swap the endianness of the words.
+.Lfinup2x_finalize_countonly:
+	pxor		MSG0_A, MSG0_A
+	jmp		1f
+
+.Lfinup2x_finalize_blockaligned:
+	mov		$0x80000000, %ebx
+	movd		%ebx, MSG0_A
+1:
+	pxor		MSG1_A, MSG1_A
+	pxor		MSG2_A, MSG2_A
+	ror		$29, COUNT
+	movq		COUNT, MSG3_A
+	pslldq		$8, MSG3_A
+	movdqa		MSG0_A, MSG0_B
+	pxor		MSG1_B, MSG1_B
+	pxor		MSG2_B, MSG2_B
+	movdqa		MSG3_A, MSG3_B
+	mov		$2, FINAL_STEP
+	jmp		.Lfinup2x_loop_have_bswapped_data
+
+.Lfinup2x_done:
+	// Write the two digests with all bytes in the correct order.
+	movdqa		STATE0_A, TMP_A
+	movdqa		STATE0_B, TMP_B
+	punpcklqdq	STATE1_A, STATE0_A		// GHEF
+	punpcklqdq	STATE1_B, STATE0_B
+	punpckhqdq	TMP_A, STATE1_A			// ABCD
+	punpckhqdq	TMP_B, STATE1_B
+	pshufd		$0xB1, STATE0_A, STATE0_A	// HGFE
+	pshufd		$0xB1, STATE0_B, STATE0_B
+	pshufd		$0x1B, STATE1_A, STATE1_A	// DCBA
+	pshufd		$0x1B, STATE1_B, STATE1_B
+	pshufb		SHUF_MASK, STATE0_A
+	pshufb		SHUF_MASK, STATE0_B
+	pshufb		SHUF_MASK, STATE1_A
+	pshufb		SHUF_MASK, STATE1_B
+	movdqu		STATE0_A, 1*16(OUT1)
+	movdqu		STATE0_B, 1*16(OUT2)
+	movdqu		STATE1_A, 0*16(OUT1)
+	movdqu		STATE1_B, 0*16(OUT2)
+
+	mov		%rbp, %rsp
+	pop		%rbp
+	pop		%rbx
+	RET
+SYM_FUNC_END(__sha256_ni_finup2x)
+
 .section	.rodata.cst256.K256, "aM", @progbits, 256
 .align 64
 K256:
 	.long	0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5
 	.long	0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index e04a43d9f7d5..de027bb240e2 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -331,10 +331,15 @@ static void unregister_sha256_avx2(void)
 
 #ifdef CONFIG_AS_SHA256_NI
 asmlinkage void sha256_ni_transform(struct sha256_state *digest,
 				    const u8 *data, int rounds);
 
+asmlinkage void __sha256_ni_finup2x(const struct sha256_state *sctx,
+				    const u8 *data1, const u8 *data2, int len,
+				    u8 out1[SHA256_DIGEST_SIZE],
+				    u8 out2[SHA256_DIGEST_SIZE]);
+
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return _sha256_update(desc, data, len, sha256_ni_transform);
 }
@@ -355,17 +360,53 @@ static int sha256_ni_digest(struct shash_desc *desc, const u8 *data,
 {
 	return sha256_base_init(desc) ?:
 	       sha256_ni_finup(desc, data, len, out);
 }
 
+static noinline_for_stack int
+sha256_finup2x_fallback(struct sha256_state *sctx, const u8 *data1,
+			const u8 *data2, unsigned int len, u8 *out1, u8 *out2)
+{
+	struct sha256_state sctx2 = *sctx;
+
+	sha256_update(sctx, data1, len);
+	sha256_final(sctx, out1);
+	sha256_update(&sctx2, data2, len);
+	sha256_final(&sctx2, out2);
+	return 0;
+}
+
+static int sha256_ni_finup2x(struct shash_desc *desc,
+			     const u8 *data1, const u8 *data2,
+			     unsigned int len, u8 *out1, u8 *out2)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	if (unlikely(!crypto_simd_usable() || len < SHA256_BLOCK_SIZE ||
+		     len > INT_MAX))
+		return sha256_finup2x_fallback(sctx, data1, data2, len,
+					       out1, out2);
+
+	/* __sha256_ni_finup2x() assumes the following offsets. */
+	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
+	BUILD_BUG_ON(offsetof(struct sha256_state, count) != 32);
+	BUILD_BUG_ON(offsetof(struct sha256_state, buf) != 40);
+
+	kernel_fpu_begin();
+	__sha256_ni_finup2x(sctx, data1, data2, len, out1, out2);
+	kernel_fpu_end();
+	return 0;
+}
+
 static struct shash_alg sha256_ni_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	sha256_ni_update,
 	.final		=	sha256_ni_final,
 	.finup		=	sha256_ni_finup,
 	.digest		=	sha256_ni_digest,
+	.finup2x	=	sha256_ni_finup2x,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
 		.cra_driver_name =	"sha256-ni",
 		.cra_priority	=	250,
-- 
2.44.0


