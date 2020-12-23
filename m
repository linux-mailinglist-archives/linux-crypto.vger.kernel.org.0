Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE22E1A5E
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLWJJp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 04:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgLWJJo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 04:09:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AAE0224B2
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608714542;
        bh=z7+GtbSormFIKP5wpWsSQ4fFvkB4kRhJlV/erbIlrhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u4phV1JFVzIzDq5WxV2LWuxvCaJA6+T3W75nZ4mTWsDS8LKdguk7mOMgN9fKuS7Im
         ZHx4CU463LYVMV7GjYLUK/0JDn37CnyB0zfGLp707kviQG1q+/3KXXBFKypM0MKeMj
         kdBl58OSllzD+6DhGprvDA0YWBxYM84TCNJLZp+leas4PyaFe/kNsR69n3OMb6NAg+
         xG04Ho3D95JckKQho5IsvJReXi3XGW3ZA1W0tbIG++7YTkS6jxBWgTC0RWj2pSzdlt
         PfDe82gGDxQ4FDN0ekJQ7hetVE9OtJBId71dhBThO07DYOrfBty7Bp3qW8uotq7+x0
         YcSWwLWIR9omQ==
Received: by mail-oo1-f50.google.com with SMTP id j8so3565174oon.3
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 01:09:02 -0800 (PST)
X-Gm-Message-State: AOAM532+yRuhoDW29nMREq7ggwWzzPegvYmDrzgbwm9Vnbaa4SXEwaDE
        na3aF0ZRIj2aXLoUQHwMzt5u+NGEa1MEQL6/6TY=
X-Google-Smtp-Source: ABdhPJxed4LzwqLZquGywmSn5wUqDNs/LCmeL2x81/cS56DLGaUCDAMJN8X/Tkzo5VdlIn4UWP8k97fU36IztSnejCQ=
X-Received: by 2002:a4a:ea5a:: with SMTP id j26mr7629653ooe.45.1608714541593;
 Wed, 23 Dec 2020 01:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20201223081003.373663-1-ebiggers@kernel.org> <20201223081003.373663-11-ebiggers@kernel.org>
In-Reply-To: <20201223081003.373663-11-ebiggers@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Dec 2020 10:08:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqNBU4Rg82graxafVnrS96njMgvLHPSoqfc_AyNBxhcw@mail.gmail.com>
Message-ID: <CAMj1kXGqNBU4Rg82graxafVnrS96njMgvLHPSoqfc_AyNBxhcw@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] crypto: arm/blake2s - add ARM scalar optimized BLAKE2s
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 23 Dec 2020 at 09:12, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add an ARM scalar optimized implementation of BLAKE2s.
>
> NEON isn't very useful for BLAKE2s because the BLAKE2s block size is too
> small for NEON to help.  Each NEON instruction would depend on the
> previous one, resulting in poor performance.
>
> With scalar instructions, on the other hand, we can take advantage of
> ARM's "free" rotations (like I did in chacha-scalar-core.S) to get an
> implementation get runs much faster than the C implementation.
>
> Performance results on Cortex-A7 in cycles per byte using the shash API:
>
>         4096-byte messages:
>                 blake2s-256-arm:     18.8
>                 blake2s-256-generic: 26.0
>
>         500-byte messages:
>                 blake2s-256-arm:     20.3
>                 blake2s-256-generic: 27.9
>
>         100-byte messages:
>                 blake2s-256-arm:     29.7
>                 blake2s-256-generic: 39.2
>
>         32-byte messages:
>                 blake2s-256-arm:     50.6
>                 blake2s-256-generic: 66.2
>
> Except on very short messages, this is still slower than the NEON
> implementation of BLAKE2b which I've written; that is 14.0, 16.4, 25.8,
> and 76.1 cpb on 4096, 500, 100, and 32-byte messages, respectively.
> However, optimized BLAKE2s is useful for cases where BLAKE2s is used
> instead of BLAKE2b, such as WireGuard.
>
> This new implementation is added in the form of a new module
> blake2s-arm.ko, which is analogous to blake2s-x86_64.ko in that it
> provides blake2s_compress_arch() for use by the library API as well as
> optionally register the algorithms with the shash API.
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Tested-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/crypto/Kconfig        |   9 ++
>  arch/arm/crypto/Makefile       |   2 +
>  arch/arm/crypto/blake2s-core.S | 285 +++++++++++++++++++++++++++++++++
>  arch/arm/crypto/blake2s-glue.c |  78 +++++++++
>  4 files changed, 374 insertions(+)
>  create mode 100644 arch/arm/crypto/blake2s-core.S
>  create mode 100644 arch/arm/crypto/blake2s-glue.c
>
> diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
> index c9bf2df85cb90..281c829c12d0b 100644
> --- a/arch/arm/crypto/Kconfig
> +++ b/arch/arm/crypto/Kconfig
> @@ -62,6 +62,15 @@ config CRYPTO_SHA512_ARM
>           SHA-512 secure hash standard (DFIPS 180-2) implemented
>           using optimized ARM assembler and NEON, when available.
>
> +config CRYPTO_BLAKE2S_ARM
> +       tristate "BLAKE2s digest algorithm (ARM)"
> +       select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> +       help
> +         BLAKE2s digest algorithm optimized with ARM scalar instructions.  This
> +         is faster than the generic implementations of BLAKE2s and BLAKE2b, but
> +         slower than the NEON implementation of BLAKE2b.  (There is no NEON
> +         implementation of BLAKE2s, since NEON doesn't really help with it.)
> +
>  config CRYPTO_AES_ARM
>         tristate "Scalar AES cipher for ARM"
>         select CRYPTO_ALGAPI
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index b745c17d356fe..5ad1e985a718b 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_CRYPTO_SHA1_ARM) += sha1-arm.o
>  obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
>  obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
>  obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
> +obj-$(CONFIG_CRYPTO_BLAKE2S_ARM) += blake2s-arm.o
>  obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
>  obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
>  obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
> @@ -29,6 +30,7 @@ sha256-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha256_neon_glue.o
>  sha256-arm-y   := sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
>  sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
>  sha512-arm-y   := sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
> +blake2s-arm-y   := blake2s-core.o blake2s-glue.o
>  sha1-arm-ce-y  := sha1-ce-core.o sha1-ce-glue.o
>  sha2-arm-ce-y  := sha2-ce-core.o sha2-ce-glue.o
>  aes-arm-ce-y   := aes-ce-core.o aes-ce-glue.o
> diff --git a/arch/arm/crypto/blake2s-core.S b/arch/arm/crypto/blake2s-core.S
> new file mode 100644
> index 0000000000000..bed897e9a181a
> --- /dev/null
> +++ b/arch/arm/crypto/blake2s-core.S
> @@ -0,0 +1,285 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * BLAKE2s digest algorithm, ARM scalar implementation
> + *
> + * Copyright 2020 Google LLC
> + *
> + * Author: Eric Biggers <ebiggers@google.com>
> + */
> +
> +#include <linux/linkage.h>
> +
> +       // Registers used to hold message words temporarily.  There aren't
> +       // enough ARM registers to hold the whole message block, so we have to
> +       // load the words on-demand.
> +       M_0             .req    r12
> +       M_1             .req    r14
> +
> +// The BLAKE2s initialization vector
> +.Lblake2s_IV:
> +       .word   0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A
> +       .word   0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19
> +
> +.macro __ldrd          a, b, src, offset
> +#if __LINUX_ARM_ARCH__ >= 6
> +       ldrd            \a, \b, [\src, #\offset]
> +#else
> +       ldr             \a, [\src, #\offset]
> +       ldr             \b, [\src, #\offset + 4]
> +#endif
> +.endm
> +
> +.macro __strd          a, b, dst, offset
> +#if __LINUX_ARM_ARCH__ >= 6
> +       strd            \a, \b, [\dst, #\offset]
> +#else
> +       str             \a, [\dst, #\offset]
> +       str             \b, [\dst, #\offset + 4]
> +#endif
> +.endm
> +
> +// Execute a quarter-round of BLAKE2s by mixing two columns or two diagonals.
> +// (a0, b0, c0, d0) and (a1, b1, c1, d1) give the registers containing the two
> +// columns/diagonals.  s0-s1 are the word offsets to the message words the first
> +// column/diagonal needs, and likewise s2-s3 for the second column/diagonal.
> +// M_0 and M_1 are free to use, and the message block can be found at sp + 32.
> +//
> +// Note that to save instructions, the rotations don't happen when the
> +// pseudocode says they should, but rather they are delayed until the values are
> +// used.  See the comment above _blake2s_round().
> +.macro _blake2s_quarterround  a0, b0, c0, d0,  a1, b1, c1, d1,  s0, s1, s2, s3
> +
> +       ldr             M_0, [sp, #32 + 4 * \s0]
> +       ldr             M_1, [sp, #32 + 4 * \s2]
> +
> +       // a += b + m[blake2s_sigma[r][2*i + 0]];
> +       add             \a0, \a0, \b0, ror #brot
> +       add             \a1, \a1, \b1, ror #brot
> +       add             \a0, \a0, M_0
> +       add             \a1, \a1, M_1
> +
> +       // d = ror32(d ^ a, 16);
> +       eor             \d0, \a0, \d0, ror #drot
> +       eor             \d1, \a1, \d1, ror #drot
> +
> +       // c += d;
> +       add             \c0, \c0, \d0, ror #16
> +       add             \c1, \c1, \d1, ror #16
> +
> +       // b = ror32(b ^ c, 12);
> +       eor             \b0, \c0, \b0, ror #brot
> +       eor             \b1, \c1, \b1, ror #brot
> +
> +       ldr             M_0, [sp, #32 + 4 * \s1]
> +       ldr             M_1, [sp, #32 + 4 * \s3]
> +
> +       // a += b + m[blake2s_sigma[r][2*i + 1]];
> +       add             \a0, \a0, \b0, ror #12
> +       add             \a1, \a1, \b1, ror #12
> +       add             \a0, \a0, M_0
> +       add             \a1, \a1, M_1
> +
> +       // d = ror32(d ^ a, 8);
> +       eor             \d0, \a0, \d0, ror#16
> +       eor             \d1, \a1, \d1, ror#16
> +
> +       // c += d;
> +       add             \c0, \c0, \d0, ror#8
> +       add             \c1, \c1, \d1, ror#8
> +
> +       // b = ror32(b ^ c, 7);
> +       eor             \b0, \c0, \b0, ror#12
> +       eor             \b1, \c1, \b1, ror#12
> +.endm
> +
> +// Execute one round of BLAKE2s by updating the state matrix v[0..15].  v[0..9]
> +// are in r0..r9.  The stack pointer points to 8 bytes of scratch space for
> +// spilling v[8..9], then to v[9..15], then to the message block.  r10-r12 and
> +// r14 are free to use.  The macro arguments s0-s15 give the order in which the
> +// message words are used in this round.
> +//
> +// All rotates are performed using the implicit rotate operand accepted by the
> +// 'add' and 'eor' instructions.  This is faster than using explicit rotate
> +// instructions.  To make this work, we allow the values in the second and last
> +// rows of the BLAKE2s state matrix (rows 'b' and 'd') to temporarily have the
> +// wrong rotation amount.  The rotation amount is then fixed up just in time
> +// when the values are used.  'brot' is the number of bits the values in row 'b'
> +// need to be rotated right to arrive at the correct values, and 'drot'
> +// similarly for row 'd'.  (brot, drot) start out as (0, 0) but we make it such
> +// that they end up as (7, 8) after every round.
> +.macro _blake2s_round  s0, s1, s2, s3, s4, s5, s6, s7, \
> +                       s8, s9, s10, s11, s12, s13, s14, s15
> +
> +       // Mix first two columns:
> +       // (v[0], v[4], v[8], v[12]) and (v[1], v[5], v[9], v[13]).
> +       __ldrd          r10, r11, sp, 16        // load v[12] and v[13]
> +       _blake2s_quarterround   r0, r4, r8, r10,  r1, r5, r9, r11, \
> +                               \s0, \s1, \s2, \s3
> +       __strd          r8, r9, sp, 0
> +       __strd          r10, r11, sp, 16
> +
> +       // Mix second two columns:
> +       // (v[2], v[6], v[10], v[14]) and (v[3], v[7], v[11], v[15]).
> +       __ldrd          r8, r9, sp, 8           // load v[10] and v[11]
> +       __ldrd          r10, r11, sp, 24        // load v[14] and v[15]
> +       _blake2s_quarterround   r2, r6, r8, r10,  r3, r7, r9, r11, \
> +                               \s4, \s5, \s6, \s7
> +       str             r10, [sp, #24]          // store v[14]
> +       // v[10], v[11], and v[15] are used below, so no need to store them yet.
> +
> +       .set brot, 7
> +       .set drot, 8
> +
> +       // Mix first two diagonals:
> +       // (v[0], v[5], v[10], v[15]) and (v[1], v[6], v[11], v[12]).
> +       ldr             r10, [sp, #16]          // load v[12]
> +       _blake2s_quarterround   r0, r5, r8, r11,  r1, r6, r9, r10, \
> +                               \s8, \s9, \s10, \s11
> +       __strd          r8, r9, sp, 8
> +       str             r11, [sp, #28]
> +       str             r10, [sp, #16]
> +
> +       // Mix second two diagonals:
> +       // (v[2], v[7], v[8], v[13]) and (v[3], v[4], v[9], v[14]).
> +       __ldrd          r8, r9, sp, 0           // load v[8] and v[9]
> +       __ldrd          r10, r11, sp, 20        // load v[13] and v[14]
> +       _blake2s_quarterround   r2, r7, r8, r10,  r3, r4, r9, r11, \
> +                               \s12, \s13, \s14, \s15
> +       __strd          r10, r11, sp, 20
> +.endm
> +
> +//
> +// void blake2s_compress_arch(struct blake2s_state *state,
> +//                           const u8 *block, size_t nblocks, u32 inc);
> +//
> +// Only the first three fields of struct blake2s_state are used:
> +//     u32 h[8];       (inout)
> +//     u32 t[2];       (inout)
> +//     u32 f[2];       (in)
> +//
> +       .align          5
> +ENTRY(blake2s_compress_arch)
> +       push            {r0-r2,r4-r11,lr}       // keep this an even number
> +
> +.Lnext_block:
> +       // r0 is 'state'
> +       // r1 is 'block'
> +       // r3 is 'inc'
> +
> +       // Load and increment the counter t[0..1].
> +       __ldrd          r10, r11, r0, 32
> +       adds            r10, r10, r3
> +       adc             r11, r11, #0
> +       __strd          r10, r11, r0, 32
> +
> +       // _blake2s_round is very short on registers, so copy the message block
> +       // to the stack to save a register during the rounds.  This also has the
> +       // advantage that misalignment only needs to be dealt with in one place.
> +       sub             sp, sp, #64
> +       mov             r12, sp
> +       tst             r1, #3
> +       bne             .Lcopy_block_misaligned
> +       ldmia           r1!, {r2-r9}
> +       stmia           r12!, {r2-r9}
> +       ldmia           r1!, {r2-r9}
> +       stmia           r12, {r2-r9}
> +.Lcopy_block_done:
> +       str             r1, [sp, #68]           // Update message pointer
> +
> +       // Calculate v[8..15].  Push v[9..15] onto the stack, and leave space
> +       // for spilling v[8..9].  Leave v[8..9] in r8-r9.
> +       mov             r14, r0                 // r14 = state
> +       adr             r12, .Lblake2s_IV
> +       ldmia           r12!, {r8-r9}           // load IV[0..1]
> +       __ldrd          r0, r1, r14, 40         // load f[0..1]
> +       ldm             r12, {r2-r7}            // load IV[3..7]
> +       eor             r4, r4, r10             // v[12] = IV[4] ^ t[0]
> +       eor             r5, r5, r11             // v[13] = IV[5] ^ t[1]
> +       eor             r6, r6, r0              // v[14] = IV[6] ^ f[0]
> +       eor             r7, r7, r1              // v[15] = IV[7] ^ f[1]
> +       push            {r2-r7}                 // push v[9..15]
> +       sub             sp, sp, #8              // leave space for v[8..9]
> +
> +       // Load h[0..7] == v[0..7].
> +       ldm             r14, {r0-r7}
> +
> +       // Execute the rounds.  Each round is provided the order in which it
> +       // needs to use the message words.
> +       .set brot, 0
> +       .set drot, 0
> +       _blake2s_round  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +       _blake2s_round  14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3
> +       _blake2s_round  11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4
> +       _blake2s_round  7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8
> +       _blake2s_round  9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13
> +       _blake2s_round  2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9
> +       _blake2s_round  12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11
> +       _blake2s_round  13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10
> +       _blake2s_round  6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5
> +       _blake2s_round  10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0
> +
> +       // Fold the final state matrix into the hash chaining value:
> +       //
> +       //      for (i = 0; i < 8; i++)
> +       //              h[i] ^= v[i] ^ v[i + 8];
> +       //
> +       ldr             r14, [sp, #96]          // r14 = &h[0]
> +       add             sp, sp, #8              // v[8..9] are already loaded.
> +       pop             {r10-r11}               // load v[10..11]
> +       eor             r0, r0, r8
> +       eor             r1, r1, r9
> +       eor             r2, r2, r10
> +       eor             r3, r3, r11
> +       ldm             r14, {r8-r11}           // load h[0..3]
> +       eor             r0, r0, r8
> +       eor             r1, r1, r9
> +       eor             r2, r2, r10
> +       eor             r3, r3, r11
> +       stmia           r14!, {r0-r3}           // store new h[0..3]
> +       ldm             r14, {r0-r3}            // load old h[4..7]
> +       pop             {r8-r11}                // load v[12..15]
> +       eor             r0, r0, r4, ror #brot
> +       eor             r1, r1, r5, ror #brot
> +       eor             r2, r2, r6, ror #brot
> +       eor             r3, r3, r7, ror #brot
> +       eor             r0, r0, r8, ror #drot
> +       eor             r1, r1, r9, ror #drot
> +       eor             r2, r2, r10, ror #drot
> +       eor             r3, r3, r11, ror #drot
> +         add           sp, sp, #64             // skip copy of message block
> +       stm             r14, {r0-r3}            // store new h[4..7]
> +
> +       // Advance to the next block, if there is one.  Note that if there are
> +       // multiple blocks, then 'inc' (the counter increment amount) must be
> +       // 64.  So we can simply set it to 64 without re-loading it.
> +       ldm             sp, {r0, r1, r2}        // load (state, block, nblocks)
> +       mov             r3, #64                 // set 'inc'
> +       subs            r2, r2, #1              // nblocks--
> +       str             r2, [sp, #8]
> +       bne             .Lnext_block            // nblocks != 0?
> +
> +       pop             {r0-r2,r4-r11,pc}
> +
> +       // The next message block (pointed to by r1) isn't 4-byte aligned, so it
> +       // can't be loaded using ldmia.  Copy it to the stack buffer (pointed to
> +       // by r12) using an alternative method.  r2-r9 are free to use.
> +.Lcopy_block_misaligned:
> +       mov             r2, #64
> +1:
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +       ldr             r3, [r1], #4
> +#else
> +       ldrb            r3, [r1, #0]
> +       ldrb            r4, [r1, #1]
> +       ldrb            r5, [r1, #2]
> +       ldrb            r6, [r1, #3]
> +       add             r1, r1, #4
> +       orr             r3, r3, r4, lsl #8
> +       orr             r3, r3, r5, lsl #16
> +       orr             r3, r3, r6, lsl #24
> +#endif
> +       subs            r2, r2, #4
> +       str             r3, [r12], #4
> +       bne             1b
> +       b               .Lcopy_block_done
> +ENDPROC(blake2s_compress_arch)
> diff --git a/arch/arm/crypto/blake2s-glue.c b/arch/arm/crypto/blake2s-glue.c
> new file mode 100644
> index 0000000000000..f2cc1e5fc9ec1
> --- /dev/null
> +++ b/arch/arm/crypto/blake2s-glue.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BLAKE2s digest algorithm, ARM scalar implementation
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <crypto/internal/blake2s.h>
> +#include <crypto/internal/hash.h>
> +
> +#include <linux/module.h>
> +
> +/* defined in blake2s-core.S */
> +EXPORT_SYMBOL(blake2s_compress_arch);
> +
> +static int crypto_blake2s_update_arm(struct shash_desc *desc,
> +                                    const u8 *in, unsigned int inlen)
> +{
> +       return crypto_blake2s_update(desc, in, inlen, blake2s_compress_arch);
> +}
> +
> +static int crypto_blake2s_final_arm(struct shash_desc *desc, u8 *out)
> +{
> +       return crypto_blake2s_final(desc, out, blake2s_compress_arch);
> +}
> +
> +#define BLAKE2S_ALG(name, driver_name, digest_size)                    \
> +       {                                                               \
> +               .base.cra_name          = name,                         \
> +               .base.cra_driver_name   = driver_name,                  \
> +               .base.cra_priority      = 200,                          \
> +               .base.cra_flags         = CRYPTO_ALG_OPTIONAL_KEY,      \
> +               .base.cra_blocksize     = BLAKE2S_BLOCK_SIZE,           \
> +               .base.cra_ctxsize       = sizeof(struct blake2s_tfm_ctx), \
> +               .base.cra_module        = THIS_MODULE,                  \
> +               .digestsize             = digest_size,                  \
> +               .setkey                 = crypto_blake2s_setkey,        \
> +               .init                   = crypto_blake2s_init,          \
> +               .update                 = crypto_blake2s_update_arm,    \
> +               .final                  = crypto_blake2s_final_arm,     \
> +               .descsize               = sizeof(struct blake2s_state), \
> +       }
> +
> +static struct shash_alg blake2s_arm_algs[] = {
> +       BLAKE2S_ALG("blake2s-128", "blake2s-128-arm", BLAKE2S_128_HASH_SIZE),
> +       BLAKE2S_ALG("blake2s-160", "blake2s-160-arm", BLAKE2S_160_HASH_SIZE),
> +       BLAKE2S_ALG("blake2s-224", "blake2s-224-arm", BLAKE2S_224_HASH_SIZE),
> +       BLAKE2S_ALG("blake2s-256", "blake2s-256-arm", BLAKE2S_256_HASH_SIZE),
> +};
> +
> +static int __init blake2s_arm_mod_init(void)
> +{
> +       return IS_REACHABLE(CONFIG_CRYPTO_HASH) ?
> +               crypto_register_shashes(blake2s_arm_algs,
> +                                       ARRAY_SIZE(blake2s_arm_algs)) : 0;
> +}
> +
> +static void __exit blake2s_arm_mod_exit(void)
> +{
> +       if (IS_REACHABLE(CONFIG_CRYPTO_HASH))
> +               crypto_unregister_shashes(blake2s_arm_algs,
> +                                         ARRAY_SIZE(blake2s_arm_algs));
> +}
> +
> +module_init(blake2s_arm_mod_init);
> +module_exit(blake2s_arm_mod_exit);
> +
> +MODULE_DESCRIPTION("BLAKE2s digest algorithm, ARM scalar implementation");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Eric Biggers <ebiggers@google.com>");
> +MODULE_ALIAS_CRYPTO("blake2s-128");
> +MODULE_ALIAS_CRYPTO("blake2s-128-arm");
> +MODULE_ALIAS_CRYPTO("blake2s-160");
> +MODULE_ALIAS_CRYPTO("blake2s-160-arm");
> +MODULE_ALIAS_CRYPTO("blake2s-224");
> +MODULE_ALIAS_CRYPTO("blake2s-224-arm");
> +MODULE_ALIAS_CRYPTO("blake2s-256");
> +MODULE_ALIAS_CRYPTO("blake2s-256-arm");
> --
> 2.29.2
>
