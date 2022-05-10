Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723C52226E
	for <lists+linux-crypto@lfdr.de>; Tue, 10 May 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbiEJR2f (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 May 2022 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348016AbiEJR20 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 May 2022 13:28:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B7270C90
        for <linux-crypto@vger.kernel.org>; Tue, 10 May 2022 10:24:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dee8688cso151791717b3.16
        for <linux-crypto@vger.kernel.org>; Tue, 10 May 2022 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WSrbFKwerqUI/JN21WT4vWHxZo+4QVu8EVmPg9AsedY=;
        b=dn53xNxtndc3Wo/QopfBacQVAft2M3HAC07bBCpp92gwMrMdr5ZodMvkKCL76gzVpL
         8aFLztiIZ47Gzqbu/ZsXbwBtJFM1GCmaIuaKJIGvn3j6vyC4EEdnu9TZfZc9RP7UXe8m
         pZcljHGRKbCyiMLcSfA0UTy4Haearn/iHtsmg4LCzbPEVw0wqAZqDdsxcHL2nvm5HEJD
         eWwcYzD4cD4O1AEEOZao7FQiZ4j1Wp6Kk+BgSKLfOER27SBuB9xv3yJt/wEIv/Ht2R2Y
         kKPvLGyJtNTQnL5gGuskbmDhG4k2XLwU65W/CZIwoC+EuNCIlkyzXqEcNxOHKyMmnJGG
         ErOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WSrbFKwerqUI/JN21WT4vWHxZo+4QVu8EVmPg9AsedY=;
        b=E1iIwLkTPaOeSb7QwatAWEYX6mmKFDDAkfH+Gd9ZngKzor+4ZHEFPXe9BNm/shDeWE
         Em7YLRkjRUjBPimV7UlfGTUbZNld+ZiT6CRlAweqOgHpsx04/8vo2rgID9x8OxgX8WUy
         qya+1L7mth92YAP+2lIMXhB0jUdWG8tecIZxFZMYk7mRtlmofWhPiUhfKkn8GXcU1iVs
         dBYZ+9lbBJ+S0foo8Hr2DjPcIYMt/95uY8DuEY4kJ5su5fgvY3w3Fsw3L2jQZBWKKSbu
         4o+megLm2dpU+NxyaWnXs5WcjtulnLFXS3H1wVw2/uq/oCXvorrBNvM1sgda9QmYnizh
         drKQ==
X-Gm-Message-State: AOAM531yXac9jTrPbB0Jbdf7XAHcUJPA6RwIUDBfV71F2zNWNaMB6Rik
        iEZ4ikCJsoJBa6i8/ntcdrVWkdEXTe+YxDhSrtxNiFMwzlU8QjBVDPPh5evVZnmeeTQVn8QYPUx
        tirTz3TmsAnwq7Iwl8c/AUhEIQ7DEl/bVgB7fabX0kF3OFKlygrviywSXtta+nzhSJbk=
X-Google-Smtp-Source: ABdhPJyAFtSEgdhII4m5ZP9iW97b/cOWK2Wa4/r0RZC1QoMb0DhvnnmONQ5uHJMm+M7+ibQ0Zv6xFcNQVg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a81:1215:0:b0:2f4:e248:844c with SMTP id
 21-20020a811215000000b002f4e248844cmr19982672yws.205.1652203465929; Tue, 10
 May 2022 10:24:25 -0700 (PDT)
Date:   Tue, 10 May 2022 17:23:56 +0000
In-Reply-To: <20220510172359.3720527-1-nhuck@google.com>
Message-Id: <20220510172359.3720527-7-nhuck@google.com>
Mime-Version: 1.0
References: <20220510172359.3720527-1-nhuck@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v8 6/9] crypto: arm64/aes-xctr: Improve readability of XCTR
 and CTR modes
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Paul Crowley <paulcrowley@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Added some clarifying comments, changed the register allocations to make
the code clearer, and added register aliases.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/aes-glue.c  |  16 +++
 arch/arm64/crypto/aes-modes.S | 237 ++++++++++++++++++++++++----------
 2 files changed, 185 insertions(+), 68 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index b6883288234c..162787c7aa86 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -464,6 +464,14 @@ static int __maybe_unused xctr_encrypt(struct skcipher_request *req)
 		u8 *dst = walk.dst.virt.addr;
 		u8 buf[AES_BLOCK_SIZE];
 
+		/*
+		 * If given less than 16 bytes, we must copy the partial block
+		 * into a temporary buffer of 16 bytes to avoid out of bounds
+		 * reads and writes.  Furthermore, this code is somewhat unusual
+		 * in that it expects the end of the data to be at the end of
+		 * the temporary buffer, rather than the start of the data at
+		 * the start of the temporary buffer.
+		 */
 		if (unlikely(nbytes < AES_BLOCK_SIZE))
 			src = dst = memcpy(buf + sizeof(buf) - nbytes,
 					   src, nbytes);
@@ -501,6 +509,14 @@ static int __maybe_unused ctr_encrypt(struct skcipher_request *req)
 		u8 *dst = walk.dst.virt.addr;
 		u8 buf[AES_BLOCK_SIZE];
 
+		/*
+		 * If given less than 16 bytes, we must copy the partial block
+		 * into a temporary buffer of 16 bytes to avoid out of bounds
+		 * reads and writes.  Furthermore, this code is somewhat unusual
+		 * in that it expects the end of the data to be at the end of
+		 * the temporary buffer, rather than the start of the data at
+		 * the start of the temporary buffer.
+		 */
 		if (unlikely(nbytes < AES_BLOCK_SIZE))
 			src = dst = memcpy(buf + sizeof(buf) - nbytes,
 					   src, nbytes);
diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 9a027200bdba..5e0f0e51557c 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -322,32 +322,60 @@ AES_FUNC_END(aes_cbc_cts_decrypt)
 	 * This macro generates the code for CTR and XCTR mode.
 	 */
 .macro ctr_encrypt xctr
+	// Arguments
+	OUT		.req x0
+	IN		.req x1
+	KEY		.req x2
+	ROUNDS_W	.req w3
+	BYTES_W		.req w4
+	IV		.req x5
+	BYTE_CTR_W 	.req w6		// XCTR only
+	// Intermediate values
+	CTR_W		.req w11	// XCTR only
+	CTR		.req x11	// XCTR only
+	IV_PART		.req x12
+	BLOCKS		.req x13
+	BLOCKS_W	.req w13
+
 	stp		x29, x30, [sp, #-16]!
 	mov		x29, sp
 
-	enc_prepare	w3, x2, x12
-	ld1		{vctr.16b}, [x5]
+	enc_prepare	ROUNDS_W, KEY, IV_PART
+	ld1		{vctr.16b}, [IV]
 
+	/*
+	 * Keep 64 bits of the IV in a register.  For CTR mode this lets us
+	 * easily increment the IV.  For XCTR mode this lets us efficiently XOR
+	 * the 64-bit counter with the IV.
+	 */
 	.if \xctr
-		umov		x12, vctr.d[0]
-		lsr		w11, w6, #4
+		umov		IV_PART, vctr.d[0]
+		lsr		CTR_W, BYTE_CTR_W, #4
 	.else
-		umov		x12, vctr.d[1] /* keep swabbed ctr in reg */
-		rev		x12, x12
+		umov		IV_PART, vctr.d[1]
+		rev		IV_PART, IV_PART
 	.endif
 
 .LctrloopNx\xctr:
-	add		w7, w4, #15
-	sub		w4, w4, #MAX_STRIDE << 4
-	lsr		w7, w7, #4
+	add		BLOCKS_W, BYTES_W, #15
+	sub		BYTES_W, BYTES_W, #MAX_STRIDE << 4
+	lsr		BLOCKS_W, BLOCKS_W, #4
 	mov		w8, #MAX_STRIDE
-	cmp		w7, w8
-	csel		w7, w7, w8, lt
+	cmp		BLOCKS_W, w8
+	csel		BLOCKS_W, BLOCKS_W, w8, lt
 
+	/*
+	 * Set up the counter values in v0-v{MAX_STRIDE-1}.
+	 *
+	 * If we are encrypting less than MAX_STRIDE blocks, the tail block
+	 * handling code expects the last keystream block to be in
+	 * v{MAX_STRIDE-1}.  For example: if encrypting two blocks with
+	 * MAX_STRIDE=5, then v3 and v4 should have the next two counter blocks.
+	 */
 	.if \xctr
-		add		x11, x11, x7
+		add		CTR, CTR, BLOCKS
 	.else
-		adds		x12, x12, x7
+		adds		IV_PART, IV_PART, BLOCKS
 	.endif
 	mov		v0.16b, vctr.16b
 	mov		v1.16b, vctr.16b
@@ -355,16 +383,16 @@ AES_FUNC_END(aes_cbc_cts_decrypt)
 	mov		v3.16b, vctr.16b
 ST5(	mov		v4.16b, vctr.16b		)
 	.if \xctr
-		sub		x6, x11, #MAX_STRIDE - 1
-		sub		x7, x11, #MAX_STRIDE - 2
-		sub		x8, x11, #MAX_STRIDE - 3
-		sub		x9, x11, #MAX_STRIDE - 4
-ST5(		sub		x10, x11, #MAX_STRIDE - 5	)
-		eor		x6, x6, x12
-		eor		x7, x7, x12
-		eor		x8, x8, x12
-		eor		x9, x9, x12
-ST5(		eor		x10, x10, x12			)
+		sub		x6, CTR, #MAX_STRIDE - 1
+		sub		x7, CTR, #MAX_STRIDE - 2
+		sub		x8, CTR, #MAX_STRIDE - 3
+		sub		x9, CTR, #MAX_STRIDE - 4
+ST5(		sub		x10, CTR, #MAX_STRIDE - 5	)
+		eor		x6, x6, IV_PART
+		eor		x7, x7, IV_PART
+		eor		x8, x8, IV_PART
+		eor		x9, x9, IV_PART
+ST5(		eor		x10, x10, IV_PART		)
 		mov		v0.d[0], x6
 		mov		v1.d[0], x7
 		mov		v2.d[0], x8
@@ -373,17 +401,32 @@ ST5(		mov		v4.d[0], x10			)
 	.else
 		bcs		0f
 		.subsection	1
-		/* apply carry to outgoing counter */
+		/*
+		 * This subsection handles carries.
+		 *
+		 * Conditional branching here is allowed with respect to time
+		 * invariance since the branches are dependent on the IV instead
+		 * of the plaintext or key.  This code is rarely executed in
+		 * practice anyway.
+		 */
+
+		/* Apply carry to outgoing counter. */
 0:		umov		x8, vctr.d[0]
 		rev		x8, x8
 		add		x8, x8, #1
 		rev		x8, x8
 		ins		vctr.d[0], x8
 
-		/* apply carry to N counter blocks for N := x12 */
-		cbz		x12, 2f
+		/*
+		 * Apply carry to counter blocks if needed.
+		 *
+		 * Since the carry flag was set, we know 0 <= IV_PART <
+		 * MAX_STRIDE.  Using the value of IV_PART we can determine how
+		 * many counter blocks need to be updated.
+		 */
+		cbz		IV_PART, 2f
 		adr		x16, 1f
-		sub		x16, x16, x12, lsl #3
+		sub		x16, x16, IV_PART, lsl #3
 		br		x16
 		bti		c
 		mov		v0.d[0], vctr.d[0]
@@ -398,71 +441,88 @@ ST5(		mov		v4.d[0], vctr.d[0]		)
 1:		b		2f
 		.previous
 
-2:		rev		x7, x12
+2:		rev		x7, IV_PART
 		ins		vctr.d[1], x7
-		sub		x7, x12, #MAX_STRIDE - 1
-		sub		x8, x12, #MAX_STRIDE - 2
-		sub		x9, x12, #MAX_STRIDE - 3
+		sub		x7, IV_PART, #MAX_STRIDE - 1
+		sub		x8, IV_PART, #MAX_STRIDE - 2
+		sub		x9, IV_PART, #MAX_STRIDE - 3
 		rev		x7, x7
 		rev		x8, x8
 		mov		v1.d[1], x7
 		rev		x9, x9
-ST5(		sub		x10, x12, #MAX_STRIDE - 4	)
+ST5(		sub		x10, IV_PART, #MAX_STRIDE - 4	)
 		mov		v2.d[1], x8
 ST5(		rev		x10, x10			)
 		mov		v3.d[1], x9
 ST5(		mov		v4.d[1], x10			)
 	.endif
-	tbnz		w4, #31, .Lctrtail\xctr
-    	ld1		{v5.16b-v7.16b}, [x1], #48
+
+	/*
+	 * If there are at least MAX_STRIDE blocks left, XOR the data with
+	 * keystream and store.  Otherwise jump to tail handling.
+	 */
+	tbnz		BYTES_W, #31, .Lctrtail\xctr
+    	ld1		{v5.16b-v7.16b}, [IN], #48
 ST4(	bl		aes_encrypt_block4x		)
 ST5(	bl		aes_encrypt_block5x		)
 	eor		v0.16b, v5.16b, v0.16b
-ST4(	ld1		{v5.16b}, [x1], #16		)
+ST4(	ld1		{v5.16b}, [IN], #16		)
 	eor		v1.16b, v6.16b, v1.16b
-ST5(	ld1		{v5.16b-v6.16b}, [x1], #32	)
+ST5(	ld1		{v5.16b-v6.16b}, [IN], #32	)
 	eor		v2.16b, v7.16b, v2.16b
 	eor		v3.16b, v5.16b, v3.16b
 ST5(	eor		v4.16b, v6.16b, v4.16b		)
-	st1		{v0.16b-v3.16b}, [x0], #64
-ST5(	st1		{v4.16b}, [x0], #16		)
-	cbz		w4, .Lctrout\xctr
+	st1		{v0.16b-v3.16b}, [OUT], #64
+ST5(	st1		{v4.16b}, [OUT], #16		)
+	cbz		BYTES_W, .Lctrout\xctr
 	b		.LctrloopNx\xctr
 
 .Lctrout\xctr:
 	.if !\xctr
-		st1		{vctr.16b}, [x5] /* return next CTR value */
+		st1		{vctr.16b}, [IV] /* return next CTR value */
 	.endif
 	ldp		x29, x30, [sp], #16
 	ret
 
 .Lctrtail\xctr:
+	/*
+	 * Handle up to MAX_STRIDE * 16 - 1 bytes of plaintext
+	 *
+	 * This code expects the last keystream block to be in v{MAX_STRIDE-1}.
+	 * For example: if encrypting two blocks with MAX_STRIDE=5, then v3 and
+	 * v4 should have the next two counter blocks.
+	 *
+	 * This allows us to store the ciphertext by writing to overlapping
+	 * regions of memory.  Any invalid ciphertext blocks get overwritten by
+	 * correctly computed blocks.  This approach greatly simplifies the
+	 * logic for storing the ciphertext.
+	 */
 	mov		x16, #16
-	ands		x6, x4, #0xf
-	csel		x13, x6, x16, ne
+	ands		w7, BYTES_W, #0xf
+	csel		x13, x7, x16, ne
 
-ST5(	cmp		w4, #64 - (MAX_STRIDE << 4)	)
+ST5(	cmp		BYTES_W, #64 - (MAX_STRIDE << 4))
 ST5(	csel		x14, x16, xzr, gt		)
-	cmp		w4, #48 - (MAX_STRIDE << 4)
+	cmp		BYTES_W, #48 - (MAX_STRIDE << 4)
 	csel		x15, x16, xzr, gt
-	cmp		w4, #32 - (MAX_STRIDE << 4)
+	cmp		BYTES_W, #32 - (MAX_STRIDE << 4)
 	csel		x16, x16, xzr, gt
-	cmp		w4, #16 - (MAX_STRIDE << 4)
+	cmp		BYTES_W, #16 - (MAX_STRIDE << 4)
 
-	adr_l		x12, .Lcts_permute_table
-	add		x12, x12, x13
+	adr_l		x9, .Lcts_permute_table
+	add		x9, x9, x13
 	ble		.Lctrtail1x\xctr
 
-ST5(	ld1		{v5.16b}, [x1], x14		)
-	ld1		{v6.16b}, [x1], x15
-	ld1		{v7.16b}, [x1], x16
+ST5(	ld1		{v5.16b}, [IN], x14		)
+	ld1		{v6.16b}, [IN], x15
+	ld1		{v7.16b}, [IN], x16
 
 ST4(	bl		aes_encrypt_block4x		)
 ST5(	bl		aes_encrypt_block5x		)
 
-	ld1		{v8.16b}, [x1], x13
-	ld1		{v9.16b}, [x1]
-	ld1		{v10.16b}, [x12]
+	ld1		{v8.16b}, [IN], x13
+	ld1		{v9.16b}, [IN]
+	ld1		{v10.16b}, [x9]
 
 ST4(	eor		v6.16b, v6.16b, v0.16b		)
 ST4(	eor		v7.16b, v7.16b, v1.16b		)
@@ -477,35 +537,70 @@ ST5(	eor		v7.16b, v7.16b, v2.16b		)
 ST5(	eor		v8.16b, v8.16b, v3.16b		)
 ST5(	eor		v9.16b, v9.16b, v4.16b		)
 
-ST5(	st1		{v5.16b}, [x0], x14		)
-	st1		{v6.16b}, [x0], x15
-	st1		{v7.16b}, [x0], x16
-	add		x13, x13, x0
+ST5(	st1		{v5.16b}, [OUT], x14		)
+	st1		{v6.16b}, [OUT], x15
+	st1		{v7.16b}, [OUT], x16
+	add		x13, x13, OUT
 	st1		{v9.16b}, [x13]		// overlapping stores
-	st1		{v8.16b}, [x0]
+	st1		{v8.16b}, [OUT]
 	b		.Lctrout\xctr
 
 .Lctrtail1x\xctr:
-	sub		x7, x6, #16
-	csel		x6, x6, x7, eq
-	add		x1, x1, x6
-	add		x0, x0, x6
-	ld1		{v5.16b}, [x1]
-	ld1		{v6.16b}, [x0]
+	/*
+	 * Handle <= 16 bytes of plaintext
+	 *
+	 * This code always reads and writes 16 bytes.  To avoid out of bounds
+	 * accesses, XCTR and CTR modes must use a temporary buffer when
+	 * encrypting/decrypting less than 16 bytes.
+	 *
+	 * This code is unusual in that it loads the input and stores the output
+	 * relative to the end of the buffers rather than relative to the start.
+	 * This causes unusual behaviour when encrypting/decrypting less than 16
+	 * bytes; the end of the data is expected to be at the end of the
+	 * temporary buffer rather than the start of the data being at the start
+	 * of the temporary buffer.
+	 */
+	sub		x8, x7, #16
+	csel		x7, x7, x8, eq
+	add		IN, IN, x7
+	add		OUT, OUT, x7
+	ld1		{v5.16b}, [IN]
+	ld1		{v6.16b}, [OUT]
 ST5(	mov		v3.16b, v4.16b			)
-	encrypt_block	v3, w3, x2, x8, w7
-	ld1		{v10.16b-v11.16b}, [x12]
+	encrypt_block	v3, ROUNDS_W, KEY, x8, w7
+	ld1		{v10.16b-v11.16b}, [x9]
 	tbl		v3.16b, {v3.16b}, v10.16b
 	sshr		v11.16b, v11.16b, #7
 	eor		v5.16b, v5.16b, v3.16b
 	bif		v5.16b, v6.16b, v11.16b
-	st1		{v5.16b}, [x0]
+	st1		{v5.16b}, [OUT]
 	b		.Lctrout\xctr
+
+	// Arguments
+	.unreq OUT
+	.unreq IN
+	.unreq KEY
+	.unreq ROUNDS_W
+	.unreq BYTES_W
+	.unreq IV
+	.unreq BYTE_CTR_W	// XCTR only
+	// Intermediate values
+	.unreq CTR_W		// XCTR only
+	.unreq CTR		// XCTR only
+	.unreq IV_PART
+	.unreq BLOCKS
+	.unreq BLOCKS_W
 .endm
 
 	/*
 	 * aes_ctr_encrypt(u8 out[], u8 const in[], u8 const rk[], int rounds,
 	 *		   int bytes, u8 ctr[])
+	 *
+	 * The input and output buffers must always be at least 16 bytes even if
+	 * encrypting/decrypting less than 16 bytes.  Otherwise out of bounds
+	 * accesses will occur.  The data to be encrypted/decrypted is expected
+	 * to be at the end of this 16-byte temporary buffer rather than the
+	 * start.
 	 */
 
 AES_FUNC_START(aes_ctr_encrypt)
@@ -515,6 +610,12 @@ AES_FUNC_END(aes_ctr_encrypt)
 	/*
 	 * aes_xctr_encrypt(u8 out[], u8 const in[], u8 const rk[], int rounds,
 	 *		   int bytes, u8 const iv[], int byte_ctr)
+	 *
+	 * The input and output buffers must always be at least 16 bytes even if
+	 * encrypting/decrypting less than 16 bytes.  Otherwise out of bounds
+	 * accesses will occur.  The data to be encrypted/decrypted is expected
+	 * to be at the end of this 16-byte temporary buffer rather than the
+	 * start.
 	 */
 
 AES_FUNC_START(aes_xctr_encrypt)
-- 
2.36.0.512.ge40c2bad7a-goog

