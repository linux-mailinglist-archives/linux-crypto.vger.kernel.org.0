Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF32E1A64
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgLWJLI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 04:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgLWJLH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 04:11:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E51F224B0
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608714625;
        bh=FFY8R+L5BMgCO0leZBB2UI3Q1sJeR6aKZ0FDFwbhQdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FbznS57xXZSWiZfEhlgXrnYs3iWSvGQRH/E7gT8XZEN+mx8p8IZ66PjcgXqAO7iZ7
         4AGjUJgjtsCPHIjaHMAaNMTgj64u3PAnATPivpWd+ED0T4jgKBjuj1U/IfDZhPfSAV
         A0lPz7kEGW8ND8wg+f5AfCROQBe9k9PCH1z6zus+gpEHiES0Sv9fH8fGjSwQfFCzaZ
         wY/Kv9Unfkn3X6Hjy0jwYDm1KfiH0irIEj9RZwcsqu//CqPZUflgRihN3WvK5Zy3pO
         hb6NlJio94VwZrpy4qfioCI2h5AXRR4g2upLotdJi+2H2XK/8cu+YzKdh2QXAniYsQ
         ejFg7cd09zpRg==
Received: by mail-ot1-f44.google.com with SMTP id d20so14477695otl.3
        for <linux-crypto@vger.kernel.org>; Wed, 23 Dec 2020 01:10:25 -0800 (PST)
X-Gm-Message-State: AOAM530yuew98xZ4FytR0MFU+s8gIlVWp/sMbKf3JVHFhDhASCsnnRbB
        q4KYvUNnN0h/d2+2c6mm1YJM9gTcWgbZdGR+5fU=
X-Google-Smtp-Source: ABdhPJwIvJNY19eOYfmbrVLN2kOGQ1vDSOBMeUk3C9a8aocHnVd9vrvzG4/GHGwEAsyjyeIDRXev1K9x9+uSLal23h0=
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr18797256oto.90.1608714624170;
 Wed, 23 Dec 2020 01:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20201223081003.373663-1-ebiggers@kernel.org> <20201223081003.373663-15-ebiggers@kernel.org>
In-Reply-To: <20201223081003.373663-15-ebiggers@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Dec 2020 10:10:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrkLBCYTfhrYUCNcBZBdZ4gxdwgRSc4VjXPsWeMOFRXw@mail.gmail.com>
Message-ID: <CAMj1kXHrkLBCYTfhrYUCNcBZBdZ4gxdwgRSc4VjXPsWeMOFRXw@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] crypto: arm/blake2b - add NEON-accelerated BLAKE2b
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

On Wed, 23 Dec 2020 at 09:13, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add a NEON-accelerated implementation of BLAKE2b.
>
> On Cortex-A7 (which these days is the most common ARM processor that
> doesn't have the ARMv8 Crypto Extensions), this is over twice as fast as
> SHA-256, and slightly faster than SHA-1.  It is also almost three times
> as fast as the generic implementation of BLAKE2b:
>
>         Algorithm            Cycles per byte (on 4096-byte messages)
>         ===================  =======================================
>         blake2b-256-neon     14.0
>         sha1-neon            16.3
>         blake2s-256-arm      18.8
>         sha1-asm             20.8
>         blake2s-256-generic  26.0
>         sha256-neon          28.9
>         sha256-asm           32.0
>         blake2b-256-generic  38.9
>
> This implementation isn't directly based on any other implementation,
> but it borrows some ideas from previous NEON code I've written as well
> as from chacha-neon-core.S.  At least on Cortex-A7, it is faster than
> the other NEON implementations of BLAKE2b I'm aware of (the
> implementation in the BLAKE2 official repository using intrinsics, and
> Andrew Moon's implementation which can be found in SUPERCOP).  It does
> only one block at a time, so it performs well on short messages too.
>
> NEON-accelerated BLAKE2b is useful because there is interest in using
> BLAKE2b-256 for dm-verity on low-end Android devices (specifically,
> devices that lack the ARMv8 Crypto Extensions) to replace SHA-1.  On
> these devices, the performance cost of upgrading to SHA-256 may be
> unacceptable, whereas BLAKE2b-256 would actually improve performance.
>
> Although BLAKE2b is intended for 64-bit platforms (unlike BLAKE2s which
> is intended for 32-bit platforms), on 32-bit ARM processors with NEON,
> BLAKE2b is actually faster than BLAKE2s.  This is because NEON supports
> 64-bit operations, and because BLAKE2s's block size is too small for
> NEON to be helpful for it.  The best I've been able to do with BLAKE2s
> on Cortex-A7 is 18.8 cpb with an optimized scalar implementation.
>
> (I didn't try BLAKE2sp and BLAKE3, which in theory would be faster, but
> they're more complex as they require running multiple hashes at once.
> Note that BLAKE2b already uses all the NEON bandwidth on the Cortex-A7,
> so I expect that any speedup from BLAKE2sp or BLAKE3 would come only
> from the smaller number of rounds, not from the extra parallelism.)
>
> For now this BLAKE2b implementation is only wired up to the shash API,
> since there is no library API for BLAKE2b yet.  However, I've tried to
> keep things consistent with BLAKE2s, e.g. by defining
> blake2b_compress_arch() which is analogous to blake2s_compress_arch()
> and could be exported for use by the library API later if needed.
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Tested-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/crypto/Kconfig             |  10 +
>  arch/arm/crypto/Makefile            |   2 +
>  arch/arm/crypto/blake2b-neon-core.S | 347 ++++++++++++++++++++++++++++
>  arch/arm/crypto/blake2b-neon-glue.c | 105 +++++++++
>  4 files changed, 464 insertions(+)
>  create mode 100644 arch/arm/crypto/blake2b-neon-core.S
>  create mode 100644 arch/arm/crypto/blake2b-neon-glue.c
>
> diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
> index 281c829c12d0b..2b575792363e5 100644
> --- a/arch/arm/crypto/Kconfig
> +++ b/arch/arm/crypto/Kconfig
> @@ -71,6 +71,16 @@ config CRYPTO_BLAKE2S_ARM
>           slower than the NEON implementation of BLAKE2b.  (There is no NEON
>           implementation of BLAKE2s, since NEON doesn't really help with it.)
>
> +config CRYPTO_BLAKE2B_NEON
> +       tristate "BLAKE2b digest algorithm (ARM NEON)"
> +       depends on KERNEL_MODE_NEON
> +       select CRYPTO_BLAKE2B
> +       help
> +         BLAKE2b digest algorithm optimized with ARM NEON instructions.
> +         On ARM processors that have NEON support but not the ARMv8
> +         Crypto Extensions, typically this BLAKE2b implementation is
> +         much faster than SHA-2 and slightly faster than SHA-1.
> +
>  config CRYPTO_AES_ARM
>         tristate "Scalar AES cipher for ARM"
>         select CRYPTO_ALGAPI
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index 5ad1e985a718b..8f26c454ea12e 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
>  obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
>  obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
>  obj-$(CONFIG_CRYPTO_BLAKE2S_ARM) += blake2s-arm.o
> +obj-$(CONFIG_CRYPTO_BLAKE2B_NEON) += blake2b-neon.o
>  obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
>  obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
>  obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
> @@ -31,6 +32,7 @@ sha256-arm-y  := sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
>  sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
>  sha512-arm-y   := sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
>  blake2s-arm-y   := blake2s-core.o blake2s-glue.o
> +blake2b-neon-y  := blake2b-neon-core.o blake2b-neon-glue.o
>  sha1-arm-ce-y  := sha1-ce-core.o sha1-ce-glue.o
>  sha2-arm-ce-y  := sha2-ce-core.o sha2-ce-glue.o
>  aes-arm-ce-y   := aes-ce-core.o aes-ce-glue.o
> diff --git a/arch/arm/crypto/blake2b-neon-core.S b/arch/arm/crypto/blake2b-neon-core.S
> new file mode 100644
> index 0000000000000..0406a186377fb
> --- /dev/null
> +++ b/arch/arm/crypto/blake2b-neon-core.S
> @@ -0,0 +1,347 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * BLAKE2b digest algorithm, NEON accelerated
> + *
> + * Copyright 2020 Google LLC
> + *
> + * Author: Eric Biggers <ebiggers@google.com>
> + */
> +
> +#include <linux/linkage.h>
> +
> +       .text
> +       .fpu            neon
> +
> +       // The arguments to blake2b_compress_neon()
> +       STATE           .req    r0
> +       BLOCK           .req    r1
> +       NBLOCKS         .req    r2
> +       INC             .req    r3
> +
> +       // Pointers to the rotation tables
> +       ROR24_TABLE     .req    r4
> +       ROR16_TABLE     .req    r5
> +
> +       // The original stack pointer
> +       ORIG_SP         .req    r6
> +
> +       // NEON registers which contain the message words of the current block.
> +       // M_0-M_3 are occasionally used for other purposes too.
> +       M_0             .req    d16
> +       M_1             .req    d17
> +       M_2             .req    d18
> +       M_3             .req    d19
> +       M_4             .req    d20
> +       M_5             .req    d21
> +       M_6             .req    d22
> +       M_7             .req    d23
> +       M_8             .req    d24
> +       M_9             .req    d25
> +       M_10            .req    d26
> +       M_11            .req    d27
> +       M_12            .req    d28
> +       M_13            .req    d29
> +       M_14            .req    d30
> +       M_15            .req    d31
> +
> +       .align          4
> +       // Tables for computing ror64(x, 24) and ror64(x, 16) using the vtbl.8
> +       // instruction.  This is the most efficient way to implement these
> +       // rotation amounts with NEON.  (On Cortex-A53 it's the same speed as
> +       // vshr.u64 + vsli.u64, while on Cortex-A7 it's faster.)
> +.Lror24_table:
> +       .byte           3, 4, 5, 6, 7, 0, 1, 2
> +.Lror16_table:
> +       .byte           2, 3, 4, 5, 6, 7, 0, 1
> +       // The BLAKE2b initialization vector
> +.Lblake2b_IV:
> +       .quad           0x6a09e667f3bcc908, 0xbb67ae8584caa73b
> +       .quad           0x3c6ef372fe94f82b, 0xa54ff53a5f1d36f1
> +       .quad           0x510e527fade682d1, 0x9b05688c2b3e6c1f
> +       .quad           0x1f83d9abfb41bd6b, 0x5be0cd19137e2179
> +
> +// Execute one round of BLAKE2b by updating the state matrix v[0..15] in the
> +// NEON registers q0-q7.  The message block is in q8..q15 (M_0-M_15).  The stack
> +// pointer points to a 32-byte aligned buffer containing a copy of q8 and q9
> +// (M_0-M_3), so that they can be reloaded if they are used as temporary
> +// registers.  The macro arguments s0-s15 give the order in which the message
> +// words are used in this round.  'final' is 1 if this is the final round.
> +.macro _blake2b_round  s0, s1, s2, s3, s4, s5, s6, s7, \
> +                       s8, s9, s10, s11, s12, s13, s14, s15, final=0
> +
> +       // Mix the columns:
> +       // (v[0], v[4], v[8], v[12]), (v[1], v[5], v[9], v[13]),
> +       // (v[2], v[6], v[10], v[14]), and (v[3], v[7], v[11], v[15]).
> +
> +       // a += b + m[blake2b_sigma[r][2*i + 0]];
> +       vadd.u64        q0, q0, q2
> +       vadd.u64        q1, q1, q3
> +       vadd.u64        d0, d0, M_\s0
> +       vadd.u64        d1, d1, M_\s2
> +       vadd.u64        d2, d2, M_\s4
> +       vadd.u64        d3, d3, M_\s6
> +
> +       // d = ror64(d ^ a, 32);
> +       veor            q6, q6, q0
> +       veor            q7, q7, q1
> +       vrev64.32       q6, q6
> +       vrev64.32       q7, q7
> +
> +       // c += d;
> +       vadd.u64        q4, q4, q6
> +       vadd.u64        q5, q5, q7
> +
> +       // b = ror64(b ^ c, 24);
> +       vld1.8          {M_0}, [ROR24_TABLE, :64]
> +       veor            q2, q2, q4
> +       veor            q3, q3, q5
> +       vtbl.8          d4, {d4}, M_0
> +       vtbl.8          d5, {d5}, M_0
> +       vtbl.8          d6, {d6}, M_0
> +       vtbl.8          d7, {d7}, M_0
> +
> +       // a += b + m[blake2b_sigma[r][2*i + 1]];
> +       //
> +       // M_0 got clobbered above, so we have to reload it if any of the four
> +       // message words this step needs happens to be M_0.  Otherwise we don't
> +       // need to reload it here, as it will just get clobbered again below.
> +.if \s1 == 0 || \s3 == 0 || \s5 == 0 || \s7 == 0
> +       vld1.8          {M_0}, [sp, :64]
> +.endif
> +       vadd.u64        q0, q0, q2
> +       vadd.u64        q1, q1, q3
> +       vadd.u64        d0, d0, M_\s1
> +       vadd.u64        d1, d1, M_\s3
> +       vadd.u64        d2, d2, M_\s5
> +       vadd.u64        d3, d3, M_\s7
> +
> +       // d = ror64(d ^ a, 16);
> +       vld1.8          {M_0}, [ROR16_TABLE, :64]
> +       veor            q6, q6, q0
> +       veor            q7, q7, q1
> +       vtbl.8          d12, {d12}, M_0
> +       vtbl.8          d13, {d13}, M_0
> +       vtbl.8          d14, {d14}, M_0
> +       vtbl.8          d15, {d15}, M_0
> +
> +       // c += d;
> +       vadd.u64        q4, q4, q6
> +       vadd.u64        q5, q5, q7
> +
> +       // b = ror64(b ^ c, 63);
> +       //
> +       // This rotation amount isn't a multiple of 8, so it has to be
> +       // implemented using a pair of shifts, which requires temporary
> +       // registers.  Use q8-q9 (M_0-M_3) for this, and reload them afterwards.
> +       veor            q8, q2, q4
> +       veor            q9, q3, q5
> +       vshr.u64        q2, q8, #63
> +       vshr.u64        q3, q9, #63
> +       vsli.u64        q2, q8, #1
> +       vsli.u64        q3, q9, #1
> +       vld1.8          {q8-q9}, [sp, :256]
> +
> +       // Mix the diagonals:
> +       // (v[0], v[5], v[10], v[15]), (v[1], v[6], v[11], v[12]),
> +       // (v[2], v[7], v[8], v[13]), and (v[3], v[4], v[9], v[14]).
> +       //
> +       // There are two possible ways to do this: use 'vext' instructions to
> +       // shift the rows of the matrix so that the diagonals become columns,
> +       // and undo it afterwards; or just use 64-bit operations on 'd'
> +       // registers instead of 128-bit operations on 'q' registers.  We use the
> +       // latter approach, as it performs much better on Cortex-A7.
> +
> +       // a += b + m[blake2b_sigma[r][2*i + 0]];
> +       vadd.u64        d0, d0, d5
> +       vadd.u64        d1, d1, d6
> +       vadd.u64        d2, d2, d7
> +       vadd.u64        d3, d3, d4
> +       vadd.u64        d0, d0, M_\s8
> +       vadd.u64        d1, d1, M_\s10
> +       vadd.u64        d2, d2, M_\s12
> +       vadd.u64        d3, d3, M_\s14
> +
> +       // d = ror64(d ^ a, 32);
> +       veor            d15, d15, d0
> +       veor            d12, d12, d1
> +       veor            d13, d13, d2
> +       veor            d14, d14, d3
> +       vrev64.32       d15, d15
> +       vrev64.32       d12, d12
> +       vrev64.32       d13, d13
> +       vrev64.32       d14, d14
> +
> +       // c += d;
> +       vadd.u64        d10, d10, d15
> +       vadd.u64        d11, d11, d12
> +       vadd.u64        d8, d8, d13
> +       vadd.u64        d9, d9, d14
> +
> +       // b = ror64(b ^ c, 24);
> +       vld1.8          {M_0}, [ROR24_TABLE, :64]
> +       veor            d5, d5, d10
> +       veor            d6, d6, d11
> +       veor            d7, d7, d8
> +       veor            d4, d4, d9
> +       vtbl.8          d5, {d5}, M_0
> +       vtbl.8          d6, {d6}, M_0
> +       vtbl.8          d7, {d7}, M_0
> +       vtbl.8          d4, {d4}, M_0
> +
> +       // a += b + m[blake2b_sigma[r][2*i + 1]];
> +.if \s9 == 0 || \s11 == 0 || \s13 == 0 || \s15 == 0
> +       vld1.8          {M_0}, [sp, :64]
> +.endif
> +       vadd.u64        d0, d0, d5
> +       vadd.u64        d1, d1, d6
> +       vadd.u64        d2, d2, d7
> +       vadd.u64        d3, d3, d4
> +       vadd.u64        d0, d0, M_\s9
> +       vadd.u64        d1, d1, M_\s11
> +       vadd.u64        d2, d2, M_\s13
> +       vadd.u64        d3, d3, M_\s15
> +
> +       // d = ror64(d ^ a, 16);
> +       vld1.8          {M_0}, [ROR16_TABLE, :64]
> +       veor            d15, d15, d0
> +       veor            d12, d12, d1
> +       veor            d13, d13, d2
> +       veor            d14, d14, d3
> +       vtbl.8          d12, {d12}, M_0
> +       vtbl.8          d13, {d13}, M_0
> +       vtbl.8          d14, {d14}, M_0
> +       vtbl.8          d15, {d15}, M_0
> +
> +       // c += d;
> +       vadd.u64        d10, d10, d15
> +       vadd.u64        d11, d11, d12
> +       vadd.u64        d8, d8, d13
> +       vadd.u64        d9, d9, d14
> +
> +       // b = ror64(b ^ c, 63);
> +       veor            d16, d4, d9
> +       veor            d17, d5, d10
> +       veor            d18, d6, d11
> +       veor            d19, d7, d8
> +       vshr.u64        q2, q8, #63
> +       vshr.u64        q3, q9, #63
> +       vsli.u64        q2, q8, #1
> +       vsli.u64        q3, q9, #1
> +       // Reloading q8-q9 can be skipped on the final round.
> +.if ! \final
> +       vld1.8          {q8-q9}, [sp, :256]
> +.endif
> +.endm
> +
> +//
> +// void blake2b_compress_neon(struct blake2b_state *state,
> +//                           const u8 *block, size_t nblocks, u32 inc);
> +//
> +// Only the first three fields of struct blake2b_state are used:
> +//     u64 h[8];       (inout)
> +//     u64 t[2];       (inout)
> +//     u64 f[2];       (in)
> +//
> +       .align          5
> +ENTRY(blake2b_compress_neon)
> +       push            {r4-r10}
> +
> +       // Allocate a 32-byte stack buffer that is 32-byte aligned.
> +       mov             ORIG_SP, sp
> +       sub             ip, sp, #32
> +       bic             ip, ip, #31
> +       mov             sp, ip
> +
> +       adr             ROR24_TABLE, .Lror24_table
> +       adr             ROR16_TABLE, .Lror16_table
> +
> +       mov             ip, STATE
> +       vld1.64         {q0-q1}, [ip]!          // Load h[0..3]
> +       vld1.64         {q2-q3}, [ip]!          // Load h[4..7]
> +.Lnext_block:
> +         adr           r10, .Lblake2b_IV
> +       vld1.64         {q14-q15}, [ip]         // Load t[0..1] and f[0..1]
> +       vld1.64         {q4-q5}, [r10]!         // Load IV[0..3]
> +         vmov          r7, r8, d28             // Copy t[0] to (r7, r8)
> +       vld1.64         {q6-q7}, [r10]          // Load IV[4..7]
> +         adds          r7, r7, INC             // Increment counter
> +       bcs             .Lslow_inc_ctr
> +       vmov.i32        d28[0], r7
> +       vst1.64         {d28}, [ip]             // Update t[0]
> +.Linc_ctr_done:
> +
> +       // Load the next message block and finish initializing the state matrix
> +       // 'v'.  Fortunately, there are exactly enough NEON registers to fit the
> +       // entire state matrix in q0-q7 and the entire message block in q8-15.
> +       //
> +       // However, _blake2b_round also needs some extra registers for rotates,
> +       // so we have to spill some registers.  It's better to spill the message
> +       // registers than the state registers, as the message doesn't change.
> +       // Therefore we store a copy of the first 32 bytes of the message block
> +       // (q8-q9) in an aligned buffer on the stack so that they can be
> +       // reloaded when needed.  (We could just reload directly from the
> +       // message buffer, but it's faster to use aligned loads.)
> +       vld1.8          {q8-q9}, [BLOCK]!
> +         veor          q6, q6, q14     // v[12..13] = IV[4..5] ^ t[0..1]
> +       vld1.8          {q10-q11}, [BLOCK]!
> +         veor          q7, q7, q15     // v[14..15] = IV[6..7] ^ f[0..1]
> +       vld1.8          {q12-q13}, [BLOCK]!
> +       vst1.8          {q8-q9}, [sp, :256]
> +         mov           ip, STATE
> +       vld1.8          {q14-q15}, [BLOCK]!
> +
> +       // Execute the rounds.  Each round is provided the order in which it
> +       // needs to use the message words.
> +       _blake2b_round  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +       _blake2b_round  14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3
> +       _blake2b_round  11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4
> +       _blake2b_round  7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8
> +       _blake2b_round  9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13
> +       _blake2b_round  2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9
> +       _blake2b_round  12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11
> +       _blake2b_round  13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10
> +       _blake2b_round  6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5
> +       _blake2b_round  10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0
> +       _blake2b_round  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +       _blake2b_round  14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 \
> +                       final=1
> +
> +       // Fold the final state matrix into the hash chaining value:
> +       //
> +       //      for (i = 0; i < 8; i++)
> +       //              h[i] ^= v[i] ^ v[i + 8];
> +       //
> +         vld1.64       {q8-q9}, [ip]!          // Load old h[0..3]
> +       veor            q0, q0, q4              // v[0..1] ^= v[8..9]
> +       veor            q1, q1, q5              // v[2..3] ^= v[10..11]
> +         vld1.64       {q10-q11}, [ip]         // Load old h[4..7]
> +       veor            q2, q2, q6              // v[4..5] ^= v[12..13]
> +       veor            q3, q3, q7              // v[6..7] ^= v[14..15]
> +       veor            q0, q0, q8              // v[0..1] ^= h[0..1]
> +       veor            q1, q1, q9              // v[2..3] ^= h[2..3]
> +         mov           ip, STATE
> +         subs          NBLOCKS, NBLOCKS, #1    // nblocks--
> +         vst1.64       {q0-q1}, [ip]!          // Store new h[0..3]
> +       veor            q2, q2, q10             // v[4..5] ^= h[4..5]
> +       veor            q3, q3, q11             // v[6..7] ^= h[6..7]
> +         vst1.64       {q2-q3}, [ip]!          // Store new h[4..7]
> +
> +       // Advance to the next block, if there is one.
> +       bne             .Lnext_block            // nblocks != 0?
> +
> +       mov             sp, ORIG_SP
> +       pop             {r4-r10}
> +       mov             pc, lr
> +
> +.Lslow_inc_ctr:
> +       // Handle the case where the counter overflowed its low 32 bits, by
> +       // carrying the overflow bit into the full 128-bit counter.
> +       vmov            r9, r10, d29
> +       adcs            r8, r8, #0
> +       adcs            r9, r9, #0
> +       adc             r10, r10, #0
> +       vmov            d28, r7, r8
> +       vmov            d29, r9, r10
> +       vst1.64         {q14}, [ip]             // Update t[0] and t[1]
> +       b               .Linc_ctr_done
> +ENDPROC(blake2b_compress_neon)
> diff --git a/arch/arm/crypto/blake2b-neon-glue.c b/arch/arm/crypto/blake2b-neon-glue.c
> new file mode 100644
> index 0000000000000..34d73200e7fa6
> --- /dev/null
> +++ b/arch/arm/crypto/blake2b-neon-glue.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * BLAKE2b digest algorithm, NEON accelerated
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#include <crypto/internal/blake2b.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/simd.h>
> +
> +#include <linux/module.h>
> +#include <linux/sizes.h>
> +
> +#include <asm/neon.h>
> +#include <asm/simd.h>
> +
> +asmlinkage void blake2b_compress_neon(struct blake2b_state *state,
> +                                     const u8 *block, size_t nblocks, u32 inc);
> +
> +static void blake2b_compress_arch(struct blake2b_state *state,
> +                                 const u8 *block, size_t nblocks, u32 inc)
> +{
> +       if (!crypto_simd_usable()) {
> +               blake2b_compress_generic(state, block, nblocks, inc);
> +               return;
> +       }
> +
> +       do {
> +               const size_t blocks = min_t(size_t, nblocks,
> +                                           SZ_4K / BLAKE2B_BLOCK_SIZE);
> +
> +               kernel_neon_begin();
> +               blake2b_compress_neon(state, block, blocks, inc);
> +               kernel_neon_end();
> +
> +               nblocks -= blocks;
> +               block += blocks * BLAKE2B_BLOCK_SIZE;
> +       } while (nblocks);
> +}
> +
> +static int crypto_blake2b_update_neon(struct shash_desc *desc,
> +                                     const u8 *in, unsigned int inlen)
> +{
> +       return crypto_blake2b_update(desc, in, inlen, blake2b_compress_arch);
> +}
> +
> +static int crypto_blake2b_final_neon(struct shash_desc *desc, u8 *out)
> +{
> +       return crypto_blake2b_final(desc, out, blake2b_compress_arch);
> +}
> +
> +#define BLAKE2B_ALG(name, driver_name, digest_size)                    \
> +       {                                                               \
> +               .base.cra_name          = name,                         \
> +               .base.cra_driver_name   = driver_name,                  \
> +               .base.cra_priority      = 200,                          \
> +               .base.cra_flags         = CRYPTO_ALG_OPTIONAL_KEY,      \
> +               .base.cra_blocksize     = BLAKE2B_BLOCK_SIZE,           \
> +               .base.cra_ctxsize       = sizeof(struct blake2b_tfm_ctx), \
> +               .base.cra_module        = THIS_MODULE,                  \
> +               .digestsize             = digest_size,                  \
> +               .setkey                 = crypto_blake2b_setkey,        \
> +               .init                   = crypto_blake2b_init,          \
> +               .update                 = crypto_blake2b_update_neon,   \
> +               .final                  = crypto_blake2b_final_neon,    \
> +               .descsize               = sizeof(struct blake2b_state), \
> +       }
> +
> +static struct shash_alg blake2b_neon_algs[] = {
> +       BLAKE2B_ALG("blake2b-160", "blake2b-160-neon", BLAKE2B_160_HASH_SIZE),
> +       BLAKE2B_ALG("blake2b-256", "blake2b-256-neon", BLAKE2B_256_HASH_SIZE),
> +       BLAKE2B_ALG("blake2b-384", "blake2b-384-neon", BLAKE2B_384_HASH_SIZE),
> +       BLAKE2B_ALG("blake2b-512", "blake2b-512-neon", BLAKE2B_512_HASH_SIZE),
> +};
> +
> +static int __init blake2b_neon_mod_init(void)
> +{
> +       if (!(elf_hwcap & HWCAP_NEON))
> +               return -ENODEV;
> +
> +       return crypto_register_shashes(blake2b_neon_algs,
> +                                      ARRAY_SIZE(blake2b_neon_algs));
> +}
> +
> +static void __exit blake2b_neon_mod_exit(void)
> +{
> +       return crypto_unregister_shashes(blake2b_neon_algs,
> +                                        ARRAY_SIZE(blake2b_neon_algs));
> +}
> +
> +module_init(blake2b_neon_mod_init);
> +module_exit(blake2b_neon_mod_exit);
> +
> +MODULE_DESCRIPTION("BLAKE2b digest algorithm, NEON accelerated");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Eric Biggers <ebiggers@google.com>");
> +MODULE_ALIAS_CRYPTO("blake2b-160");
> +MODULE_ALIAS_CRYPTO("blake2b-160-neon");
> +MODULE_ALIAS_CRYPTO("blake2b-256");
> +MODULE_ALIAS_CRYPTO("blake2b-256-neon");
> +MODULE_ALIAS_CRYPTO("blake2b-384");
> +MODULE_ALIAS_CRYPTO("blake2b-384-neon");
> +MODULE_ALIAS_CRYPTO("blake2b-512");
> +MODULE_ALIAS_CRYPTO("blake2b-512-neon");
> --
> 2.29.2
>
