Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1854AA788
	for <lists+linux-crypto@lfdr.de>; Sat,  5 Feb 2022 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbiBEIGV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 5 Feb 2022 03:06:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36158 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiBEIGU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 5 Feb 2022 03:06:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489B661516
        for <linux-crypto@vger.kernel.org>; Sat,  5 Feb 2022 08:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D2DC340E8
        for <linux-crypto@vger.kernel.org>; Sat,  5 Feb 2022 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644048379;
        bh=MF8J9y8iUeIr5Go3p0DGizAQXHh0QGXt9ukDRfnKy9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hIf0G9dquh4fgLBlD7Ugc9AdIxLoTdOTHRJGQBAvRniLSGuTySnAB+9mx0mgD4l9l
         CyyCGvrnxnkNFi2Zcm7dGZ2B1zTKaizJCIoYKdHVfCbI9OVq3oFRQku1Q4TbU0NmPQ
         qXL8SSUphuuvfSNrhhqixylWSigIp4U+1TANMVsFRAkMO30B/2c76wcM3quT+qo3Gw
         lIJTVHlWDPJC+Z0XvUlw1+sDg5YI8XNPbQSRH6PLkpiLIdSqso8ZZzEd5vQPr0YeaH
         FHSzbRNbvDzP0+5SmgLu7mizWfd/6q+SfwoUwNwYsRwvLGqt5G5Y+77Pu/3tGew1dA
         INVB1JZqnVUPg==
Received: by mail-wr1-f46.google.com with SMTP id h6so2381641wrb.9
        for <linux-crypto@vger.kernel.org>; Sat, 05 Feb 2022 00:06:19 -0800 (PST)
X-Gm-Message-State: AOAM531R/l+peWNqpIGIZVbIjcHGom1mKNGtzv8C9JNXiQ9ijkd7qQ6h
        r48OeQ320F/TXBa7Jl+LeX+f0Shwu/zsprCk6WM=
X-Google-Smtp-Source: ABdhPJwD5TYErMgts6HucgUf8HeI3pkUsYr+paP+jQPUug8yZayoMtYKbhMA8hf5HrlveCGX96i59d9XbYmZfo/TAoA=
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr2130118wrx.550.1644048377425;
 Sat, 05 Feb 2022 00:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20220205075837.153418-1-ardb@kernel.org> <20220205075837.153418-2-ardb@kernel.org>
In-Reply-To: <20220205075837.153418-2-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 5 Feb 2022 09:06:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEeUO3pfUdAW2YQMTQO3i3+8H=UhOoAqVSO5Y47p+Fafg@mail.gmail.com>
Message-ID: <CAMj1kXEeUO3pfUdAW2YQMTQO3i3+8H=UhOoAqVSO5Y47p+Fafg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/xor: make xor prototypes more friendely to
 compiler vectorization
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, 5 Feb 2022 at 08:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Modern compilers are perfectly capable of extracting parallelism from
> the XOR routines, provided that the prototypes reflect the nature of the
> input accurately, in particular, the fact that the input vectors are
> expected not to overlap. This is not documented explicitly, but is
> implied by the interchangeability of the various C routines, some of
> which use temporary variables while others don't: this means that these
> routines only behave identically for non-overlapping inputs.
>
> So let's decorate these input vectors with the __restrict modifier,
> which informs the compiler that there is no overlap. While at it, make
> the input-only vectors pointer-to-const as well.
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/563

Apologies, I sent this out too quickly. Please disregard.

> ---
>  arch/alpha/include/asm/xor.h           | 53 ++++++++----
>  arch/arm/include/asm/xor.h             | 42 ++++++----
>  arch/arm64/include/asm/xor.h           | 21 +++--
>  arch/arm64/lib/xor-neon.c              | 46 +++++++----
>  arch/ia64/include/asm/xor.h            | 21 +++--
>  arch/powerpc/include/asm/xor_altivec.h | 25 +++---
>  arch/powerpc/lib/xor_vmx.c             | 28 ++++---
>  arch/powerpc/lib/xor_vmx.h             | 27 ++++---
>  arch/powerpc/lib/xor_vmx_glue.c        | 32 ++++----
>  arch/s390/lib/xor.c                    | 21 +++--
>  arch/sparc/include/asm/xor_32.h        | 21 +++--
>  arch/sparc/include/asm/xor_64.h        | 42 ++++++----
>  arch/x86/include/asm/xor.h             | 42 ++++++----
>  arch/x86/include/asm/xor_32.h          | 42 ++++++----
>  arch/x86/include/asm/xor_avx.h         | 21 +++--
>  include/asm-generic/xor.h              | 84 +++++++++++++-------
>  include/linux/raid/xor.h               | 21 +++--
>  17 files changed, 381 insertions(+), 208 deletions(-)
>
> diff --git a/arch/alpha/include/asm/xor.h b/arch/alpha/include/asm/xor.h
> index 5aeb4fb3cb7c..e0de0c233ab9 100644
> --- a/arch/alpha/include/asm/xor.h
> +++ b/arch/alpha/include/asm/xor.h
> @@ -5,24 +5,43 @@
>   * Optimized RAID-5 checksumming functions for alpha EV5 and EV6
>   */
>
> -extern void xor_alpha_2(unsigned long, unsigned long *, unsigned long *);
> -extern void xor_alpha_3(unsigned long, unsigned long *, unsigned long *,
> -                       unsigned long *);
> -extern void xor_alpha_4(unsigned long, unsigned long *, unsigned long *,
> -                       unsigned long *, unsigned long *);
> -extern void xor_alpha_5(unsigned long, unsigned long *, unsigned long *,
> -                       unsigned long *, unsigned long *, unsigned long *);
> +extern void
> +xor_alpha_2(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2);
> +extern void
> +xor_alpha_3(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3);
> +extern void
> +xor_alpha_4(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3,
> +           const unsigned long * __restrict p4);
> +extern void
> +xor_alpha_5(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3,
> +           const unsigned long * __restrict p4,
> +           const unsigned long * __restrict p5);
>
> -extern void xor_alpha_prefetch_2(unsigned long, unsigned long *,
> -                                unsigned long *);
> -extern void xor_alpha_prefetch_3(unsigned long, unsigned long *,
> -                                unsigned long *, unsigned long *);
> -extern void xor_alpha_prefetch_4(unsigned long, unsigned long *,
> -                                unsigned long *, unsigned long *,
> -                                unsigned long *);
> -extern void xor_alpha_prefetch_5(unsigned long, unsigned long *,
> -                                unsigned long *, unsigned long *,
> -                                unsigned long *, unsigned long *);
> +extern void
> +xor_alpha_prefetch_2(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2);
> +extern void
> +xor_alpha_prefetch_3(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3);
> +extern void
> +xor_alpha_prefetch_4(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4);
> +extern void
> +xor_alpha_prefetch_5(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4,
> +                    const unsigned long * __restrict p5);
>
>  asm("                                                          \n\
>         .text                                                   \n\
> diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> index aefddec79286..669cad5194d3 100644
> --- a/arch/arm/include/asm/xor.h
> +++ b/arch/arm/include/asm/xor.h
> @@ -44,7 +44,8 @@
>                 : "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
>
>  static void
> -xor_arm4regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_arm4regs_2(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2)
>  {
>         unsigned int lines = bytes / sizeof(unsigned long) / 4;
>         register unsigned int a1 __asm__("r4");
> @@ -64,8 +65,9 @@ xor_arm4regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_arm4regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3)
> +xor_arm4regs_3(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3)
>  {
>         unsigned int lines = bytes / sizeof(unsigned long) / 4;
>         register unsigned int a1 __asm__("r4");
> @@ -86,8 +88,10 @@ xor_arm4regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_arm4regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4)
> +xor_arm4regs_4(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4)
>  {
>         unsigned int lines = bytes / sizeof(unsigned long) / 2;
>         register unsigned int a1 __asm__("r8");
> @@ -105,8 +109,11 @@ xor_arm4regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_arm4regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_arm4regs_5(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4,
> +              const unsigned long * __restrict p5)
>  {
>         unsigned int lines = bytes / sizeof(unsigned long) / 2;
>         register unsigned int a1 __asm__("r8");
> @@ -146,7 +153,8 @@ static struct xor_block_template xor_block_arm4regs = {
>  extern struct xor_block_template const xor_block_neon_inner;
>
>  static void
> -xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2)
>  {
>         if (in_interrupt()) {
>                 xor_arm4regs_2(bytes, p1, p2);
> @@ -158,8 +166,9 @@ xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3)
> +xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3)
>  {
>         if (in_interrupt()) {
>                 xor_arm4regs_3(bytes, p1, p2, p3);
> @@ -171,8 +180,10 @@ xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4)
> +xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3,
> +          const unsigned long * __restrict p4)
>  {
>         if (in_interrupt()) {
>                 xor_arm4regs_4(bytes, p1, p2, p3, p4);
> @@ -184,8 +195,11 @@ xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3,
> +          const unsigned long * __restrict p4,
> +          const unsigned long * __restrict p5)
>  {
>         if (in_interrupt()) {
>                 xor_arm4regs_5(bytes, p1, p2, p3, p4, p5);
> diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
> index 947f6a4f1aa0..befcd8a7abc9 100644
> --- a/arch/arm64/include/asm/xor.h
> +++ b/arch/arm64/include/asm/xor.h
> @@ -16,7 +16,8 @@
>  extern struct xor_block_template const xor_block_inner_neon;
>
>  static void
> -xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2)
>  {
>         kernel_neon_begin();
>         xor_block_inner_neon.do_2(bytes, p1, p2);
> @@ -24,8 +25,9 @@ xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3)
> +xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3)
>  {
>         kernel_neon_begin();
>         xor_block_inner_neon.do_3(bytes, p1, p2, p3);
> @@ -33,8 +35,10 @@ xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4)
> +xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3,
> +          const unsigned long * __restrict p4)
>  {
>         kernel_neon_begin();
>         xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
> @@ -42,8 +46,11 @@ xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -               unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
> +          const unsigned long * __restrict p2,
> +          const unsigned long * __restrict p3,
> +          const unsigned long * __restrict p4,
> +          const unsigned long * __restrict p5)
>  {
>         kernel_neon_begin();
>         xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
> diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
> index d189cf4e70ea..96b171995d19 100644
> --- a/arch/arm64/lib/xor-neon.c
> +++ b/arch/arm64/lib/xor-neon.c
> @@ -10,8 +10,8 @@
>  #include <linux/module.h>
>  #include <asm/neon-intrinsics.h>
>
> -void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
> -       unsigned long *p2)
> +void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -37,8 +37,9 @@ void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
>         } while (--lines > 0);
>  }
>
> -void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
> -       unsigned long *p2, unsigned long *p3)
> +void xor_arm64_neon_3(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -72,8 +73,10 @@ void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
>         } while (--lines > 0);
>  }
>
> -void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
> -       unsigned long *p2, unsigned long *p3, unsigned long *p4)
> +void xor_arm64_neon_4(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -115,9 +118,11 @@ void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
>         } while (--lines > 0);
>  }
>
> -void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
> -       unsigned long *p2, unsigned long *p3,
> -       unsigned long *p4, unsigned long *p5)
> +void xor_arm64_neon_5(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4,
> +       const unsigned long * __restrict p5)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -186,8 +191,10 @@ static inline uint64x2_t eor3(uint64x2_t p, uint64x2_t q, uint64x2_t r)
>         return res;
>  }
>
> -static void xor_arm64_eor3_3(unsigned long bytes, unsigned long *p1,
> -                            unsigned long *p2, unsigned long *p3)
> +static void xor_arm64_eor3_3(unsigned long bytes,
> +       unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -219,9 +226,11 @@ static void xor_arm64_eor3_3(unsigned long bytes, unsigned long *p1,
>         } while (--lines > 0);
>  }
>
> -static void xor_arm64_eor3_4(unsigned long bytes, unsigned long *p1,
> -                            unsigned long *p2, unsigned long *p3,
> -                            unsigned long *p4)
> +static void xor_arm64_eor3_4(unsigned long bytes,
> +       unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> @@ -261,9 +270,12 @@ static void xor_arm64_eor3_4(unsigned long bytes, unsigned long *p1,
>         } while (--lines > 0);
>  }
>
> -static void xor_arm64_eor3_5(unsigned long bytes, unsigned long *p1,
> -                            unsigned long *p2, unsigned long *p3,
> -                            unsigned long *p4, unsigned long *p5)
> +static void xor_arm64_eor3_5(unsigned long bytes,
> +       unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4,
> +       const unsigned long * __restrict p5)
>  {
>         uint64_t *dp1 = (uint64_t *)p1;
>         uint64_t *dp2 = (uint64_t *)p2;
> diff --git a/arch/ia64/include/asm/xor.h b/arch/ia64/include/asm/xor.h
> index 673051bf9d7d..6785f70d3208 100644
> --- a/arch/ia64/include/asm/xor.h
> +++ b/arch/ia64/include/asm/xor.h
> @@ -4,13 +4,20 @@
>   */
>
>
> -extern void xor_ia64_2(unsigned long, unsigned long *, unsigned long *);
> -extern void xor_ia64_3(unsigned long, unsigned long *, unsigned long *,
> -                      unsigned long *);
> -extern void xor_ia64_4(unsigned long, unsigned long *, unsigned long *,
> -                      unsigned long *, unsigned long *);
> -extern void xor_ia64_5(unsigned long, unsigned long *, unsigned long *,
> -                      unsigned long *, unsigned long *, unsigned long *);
> +extern void xor_ia64_2(unsigned long bytes, unsigned long * __restrict p1,
> +                      const unsigned long * __restrict p2);
> +extern void xor_ia64_3(unsigned long bytes, unsigned long * __restrict p1,
> +                      const unsigned long * __restrict p2,
> +                      const unsigned long * __restrict p3);
> +extern void xor_ia64_4(unsigned long bytes, unsigned long * __restrict p1,
> +                      const unsigned long * __restrict p2,
> +                      const unsigned long * __restrict p3,
> +                      const unsigned long * __restrict p4);
> +extern void xor_ia64_5(unsigned long bytes, unsigned long * __restrict p1,
> +                      const unsigned long * __restrict p2,
> +                      const unsigned long * __restrict p3,
> +                      const unsigned long * __restrict p4,
> +                      const unsigned long * __restrict p5);
>
>  static struct xor_block_template xor_block_ia64 = {
>         .name = "ia64",
> diff --git a/arch/powerpc/include/asm/xor_altivec.h b/arch/powerpc/include/asm/xor_altivec.h
> index 6ca923510b59..294620a25f80 100644
> --- a/arch/powerpc/include/asm/xor_altivec.h
> +++ b/arch/powerpc/include/asm/xor_altivec.h
> @@ -3,17 +3,20 @@
>  #define _ASM_POWERPC_XOR_ALTIVEC_H
>
>  #ifdef CONFIG_ALTIVEC
> -
> -void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
> -                  unsigned long *v2_in);
> -void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in);
> -void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in,
> -                  unsigned long *v4_in);
> -void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in,
> -                  unsigned long *v4_in, unsigned long *v5_in);
> +void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2);
> +void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3);
> +void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4);
> +void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4,
> +                  const unsigned long * __restrict p5);
>
>  #endif
>  #endif /* _ASM_POWERPC_XOR_ALTIVEC_H */
> diff --git a/arch/powerpc/lib/xor_vmx.c b/arch/powerpc/lib/xor_vmx.c
> index 54e61979e80e..958cd30b0fb6 100644
> --- a/arch/powerpc/lib/xor_vmx.c
> +++ b/arch/powerpc/lib/xor_vmx.c
> @@ -49,8 +49,9 @@ typedef vector signed char unative_t;
>                 V1##_3 = vec_xor(V1##_3, V2##_3);       \
>         } while (0)
>
> -void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
> -                    unsigned long *v2_in)
> +void __xor_altivec_2(unsigned long bytes,
> +                    unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2)
>  {
>         DEFINE(v1);
>         DEFINE(v2);
> @@ -67,8 +68,10 @@ void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>         } while (--lines > 0);
>  }
>
> -void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
> -                    unsigned long *v2_in, unsigned long *v3_in)
> +void __xor_altivec_3(unsigned long bytes,
> +                    unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3)
>  {
>         DEFINE(v1);
>         DEFINE(v2);
> @@ -89,9 +92,11 @@ void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>         } while (--lines > 0);
>  }
>
> -void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
> -                    unsigned long *v2_in, unsigned long *v3_in,
> -                    unsigned long *v4_in)
> +void __xor_altivec_4(unsigned long bytes,
> +                    unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4)
>  {
>         DEFINE(v1);
>         DEFINE(v2);
> @@ -116,9 +121,12 @@ void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>         } while (--lines > 0);
>  }
>
> -void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
> -                    unsigned long *v2_in, unsigned long *v3_in,
> -                    unsigned long *v4_in, unsigned long *v5_in)
> +void __xor_altivec_5(unsigned long bytes,
> +                    unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4,
> +                    const unsigned long * __restrict p5)
>  {
>         DEFINE(v1);
>         DEFINE(v2);
> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
> index 5c2b0839b179..573c41d90dac 100644
> --- a/arch/powerpc/lib/xor_vmx.h
> +++ b/arch/powerpc/lib/xor_vmx.h
> @@ -6,16 +6,17 @@
>   * outside of the enable/disable altivec block.
>   */
>
> -void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
> -                            unsigned long *v2_in);
> -
> -void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
> -                            unsigned long *v2_in, unsigned long *v3_in);
> -
> -void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
> -                            unsigned long *v2_in, unsigned long *v3_in,
> -                            unsigned long *v4_in);
> -
> -void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
> -                            unsigned long *v2_in, unsigned long *v3_in,
> -                            unsigned long *v4_in, unsigned long *v5_in);
> +void __xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2);
> +void __xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3);
> +void __xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4);
> +void __xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4,
> +                    const unsigned long * __restrict p5);
> diff --git a/arch/powerpc/lib/xor_vmx_glue.c b/arch/powerpc/lib/xor_vmx_glue.c
> index 80dba916c367..35d917ece4d1 100644
> --- a/arch/powerpc/lib/xor_vmx_glue.c
> +++ b/arch/powerpc/lib/xor_vmx_glue.c
> @@ -12,47 +12,51 @@
>  #include <asm/xor_altivec.h>
>  #include "xor_vmx.h"
>
> -void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
> -                  unsigned long *v2_in)
> +void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2)
>  {
>         preempt_disable();
>         enable_kernel_altivec();
> -       __xor_altivec_2(bytes, v1_in, v2_in);
> +       __xor_altivec_2(bytes, p1, p2);
>         disable_kernel_altivec();
>         preempt_enable();
>  }
>  EXPORT_SYMBOL(xor_altivec_2);
>
> -void xor_altivec_3(unsigned long bytes,  unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in)
> +void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3)
>  {
>         preempt_disable();
>         enable_kernel_altivec();
> -       __xor_altivec_3(bytes, v1_in, v2_in, v3_in);
> +       __xor_altivec_3(bytes, p1, p2, p3);
>         disable_kernel_altivec();
>         preempt_enable();
>  }
>  EXPORT_SYMBOL(xor_altivec_3);
>
> -void xor_altivec_4(unsigned long bytes,  unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in,
> -                  unsigned long *v4_in)
> +void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4)
>  {
>         preempt_disable();
>         enable_kernel_altivec();
> -       __xor_altivec_4(bytes, v1_in, v2_in, v3_in, v4_in);
> +       __xor_altivec_4(bytes, p1, p2, p3, p4);
>         disable_kernel_altivec();
>         preempt_enable();
>  }
>  EXPORT_SYMBOL(xor_altivec_4);
>
> -void xor_altivec_5(unsigned long bytes,  unsigned long *v1_in,
> -                  unsigned long *v2_in, unsigned long *v3_in,
> -                  unsigned long *v4_in, unsigned long *v5_in)
> +void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4,
> +                  const unsigned long * __restrict p5)
>  {
>         preempt_disable();
>         enable_kernel_altivec();
> -       __xor_altivec_5(bytes, v1_in, v2_in, v3_in, v4_in, v5_in);
> +       __xor_altivec_5(bytes, p1, p2, p3, p4, p5);
>         disable_kernel_altivec();
>         preempt_enable();
>  }
> diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
> index a963c3d8ad0d..fb924a8041dc 100644
> --- a/arch/s390/lib/xor.c
> +++ b/arch/s390/lib/xor.c
> @@ -11,7 +11,8 @@
>  #include <linux/raid/xor.h>
>  #include <asm/xor.h>
>
> -static void xor_xc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2)
>  {
>         asm volatile(
>                 "       larl    1,2f\n"
> @@ -32,8 +33,9 @@ static void xor_xc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>                 : "0", "1", "cc", "memory");
>  }
>
> -static void xor_xc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -                    unsigned long *p3)
> +static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3)
>  {
>         asm volatile(
>                 "       larl    1,2f\n"
> @@ -58,8 +60,10 @@ static void xor_xc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>                 : : "0", "1", "cc", "memory");
>  }
>
> -static void xor_xc_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -                    unsigned long *p3, unsigned long *p4)
> +static void xor_xc_4(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4)
>  {
>         asm volatile(
>                 "       larl    1,2f\n"
> @@ -88,8 +92,11 @@ static void xor_xc_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>                 : : "0", "1", "cc", "memory");
>  }
>
> -static void xor_xc_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -                    unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +static void xor_xc_5(unsigned long bytes, unsigned long * __restrict p1,
> +                    const unsigned long * __restrict p2,
> +                    const unsigned long * __restrict p3,
> +                    const unsigned long * __restrict p4,
> +                    const unsigned long * __restrict p5)
>  {
>         asm volatile(
>                 "       larl    1,2f\n"
> diff --git a/arch/sparc/include/asm/xor_32.h b/arch/sparc/include/asm/xor_32.h
> index 3e5af37e4b9c..0351813cf3af 100644
> --- a/arch/sparc/include/asm/xor_32.h
> +++ b/arch/sparc/include/asm/xor_32.h
> @@ -13,7 +13,8 @@
>   */
>
>  static void
> -sparc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +sparc_2(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2)
>  {
>         int lines = bytes / (sizeof (long)) / 8;
>
> @@ -50,8 +51,9 @@ sparc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -sparc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -       unsigned long *p3)
> +sparc_3(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3)
>  {
>         int lines = bytes / (sizeof (long)) / 8;
>
> @@ -101,8 +103,10 @@ sparc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -sparc_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -       unsigned long *p3, unsigned long *p4)
> +sparc_4(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4)
>  {
>         int lines = bytes / (sizeof (long)) / 8;
>
> @@ -165,8 +169,11 @@ sparc_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -sparc_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -       unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +sparc_5(unsigned long bytes, unsigned long * __restrict p1,
> +       const unsigned long * __restrict p2,
> +       const unsigned long * __restrict p3,
> +       const unsigned long * __restrict p4,
> +       const unsigned long * __restrict p5)
>  {
>         int lines = bytes / (sizeof (long)) / 8;
>
> diff --git a/arch/sparc/include/asm/xor_64.h b/arch/sparc/include/asm/xor_64.h
> index 16169f3edcd5..caaddea8ad79 100644
> --- a/arch/sparc/include/asm/xor_64.h
> +++ b/arch/sparc/include/asm/xor_64.h
> @@ -12,13 +12,20 @@
>
>  #include <asm/spitfire.h>
>
> -void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
> -void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
> -              unsigned long *);
> -void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
> -              unsigned long *, unsigned long *);
> -void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
> -              unsigned long *, unsigned long *, unsigned long *);
> +void xor_vis_2(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2);
> +void xor_vis_3(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3);
> +void xor_vis_4(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4);
> +void xor_vis_5(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4,
> +              const unsigned long * __restrict p5);
>
>  /* XXX Ugh, write cheetah versions... -DaveM */
>
> @@ -30,13 +37,20 @@ static struct xor_block_template xor_block_VIS = {
>          .do_5  = xor_vis_5,
>  };
>
> -void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
> -void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
> -                  unsigned long *);
> -void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
> -                  unsigned long *, unsigned long *);
> -void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
> -                  unsigned long *, unsigned long *, unsigned long *);
> +void xor_niagara_2(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2);
> +void xor_niagara_3(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3);
> +void xor_niagara_4(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4);
> +void xor_niagara_5(unsigned long bytes, unsigned long * __restrict p1,
> +                  const unsigned long * __restrict p2,
> +                  const unsigned long * __restrict p3,
> +                  const unsigned long * __restrict p4,
> +                  const unsigned long * __restrict p5);
>
>  static struct xor_block_template xor_block_niagara = {
>          .name  = "Niagara",
> diff --git a/arch/x86/include/asm/xor.h b/arch/x86/include/asm/xor.h
> index 2ee95a7769e6..7b0307acc410 100644
> --- a/arch/x86/include/asm/xor.h
> +++ b/arch/x86/include/asm/xor.h
> @@ -57,7 +57,8 @@
>                                         op(i + 3, 3)
>
>  static void
> -xor_sse_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_sse_2(unsigned long bytes, unsigned long * __restrict p1,
> +         const unsigned long * __restrict p2)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -108,7 +109,8 @@ xor_sse_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_sse_2_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_sse_2_pf64(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -142,8 +144,9 @@ xor_sse_2_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_sse_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -         unsigned long *p3)
> +xor_sse_3(unsigned long bytes, unsigned long * __restrict p1,
> +         const unsigned long * __restrict p2,
> +         const unsigned long * __restrict p3)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -201,8 +204,9 @@ xor_sse_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_sse_3_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -              unsigned long *p3)
> +xor_sse_3_pf64(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -238,8 +242,10 @@ xor_sse_3_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_sse_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -         unsigned long *p3, unsigned long *p4)
> +xor_sse_4(unsigned long bytes, unsigned long * __restrict p1,
> +         const unsigned long * __restrict p2,
> +         const unsigned long * __restrict p3,
> +         const unsigned long * __restrict p4)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -304,8 +310,10 @@ xor_sse_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_sse_4_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -              unsigned long *p3, unsigned long *p4)
> +xor_sse_4_pf64(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -343,8 +351,11 @@ xor_sse_4_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_sse_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -         unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_sse_5(unsigned long bytes, unsigned long * __restrict p1,
> +         const unsigned long * __restrict p2,
> +         const unsigned long * __restrict p3,
> +         const unsigned long * __restrict p4,
> +         const unsigned long * __restrict p5)
>  {
>         unsigned long lines = bytes >> 8;
>
> @@ -416,8 +427,11 @@ xor_sse_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_sse_5_pf64(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -              unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_sse_5_pf64(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4,
> +              const unsigned long * __restrict p5)
>  {
>         unsigned long lines = bytes >> 8;
>
> diff --git a/arch/x86/include/asm/xor_32.h b/arch/x86/include/asm/xor_32.h
> index 67ceb790e639..7a6b9474591e 100644
> --- a/arch/x86/include/asm/xor_32.h
> +++ b/arch/x86/include/asm/xor_32.h
> @@ -21,7 +21,8 @@
>  #include <asm/fpu/api.h>
>
>  static void
> -xor_pII_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_pII_mmx_2(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2)
>  {
>         unsigned long lines = bytes >> 7;
>
> @@ -64,8 +65,9 @@ xor_pII_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_pII_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -             unsigned long *p3)
> +xor_pII_mmx_3(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3)
>  {
>         unsigned long lines = bytes >> 7;
>
> @@ -113,8 +115,10 @@ xor_pII_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_pII_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -             unsigned long *p3, unsigned long *p4)
> +xor_pII_mmx_4(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3,
> +             const unsigned long * __restrict p4)
>  {
>         unsigned long lines = bytes >> 7;
>
> @@ -168,8 +172,11 @@ xor_pII_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>
>
>  static void
> -xor_pII_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -             unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_pII_mmx_5(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3,
> +             const unsigned long * __restrict p4,
> +             const unsigned long * __restrict p5)
>  {
>         unsigned long lines = bytes >> 7;
>
> @@ -248,7 +255,8 @@ xor_pII_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  #undef BLOCK
>
>  static void
> -xor_p5_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_p5_mmx_2(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2)
>  {
>         unsigned long lines = bytes >> 6;
>
> @@ -295,8 +303,9 @@ xor_p5_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_p5_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -            unsigned long *p3)
> +xor_p5_mmx_3(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3)
>  {
>         unsigned long lines = bytes >> 6;
>
> @@ -352,8 +361,10 @@ xor_p5_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_p5_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -            unsigned long *p3, unsigned long *p4)
> +xor_p5_mmx_4(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3,
> +            const unsigned long * __restrict p4)
>  {
>         unsigned long lines = bytes >> 6;
>
> @@ -418,8 +429,11 @@ xor_p5_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_p5_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -            unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_p5_mmx_5(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3,
> +            const unsigned long * __restrict p4,
> +            const unsigned long * __restrict p5)
>  {
>         unsigned long lines = bytes >> 6;
>
> diff --git a/arch/x86/include/asm/xor_avx.h b/arch/x86/include/asm/xor_avx.h
> index 0c4e5b5e3852..7f81dd5897f4 100644
> --- a/arch/x86/include/asm/xor_avx.h
> +++ b/arch/x86/include/asm/xor_avx.h
> @@ -26,7 +26,8 @@
>                 BLOCK4(8) \
>                 BLOCK4(12)
>
> -static void xor_avx_2(unsigned long bytes, unsigned long *p0, unsigned long *p1)
> +static void xor_avx_2(unsigned long bytes, unsigned long * __restrict p0,
> +                     const unsigned long * __restrict p1)
>  {
>         unsigned long lines = bytes >> 9;
>
> @@ -52,8 +53,9 @@ do { \
>         kernel_fpu_end();
>  }
>
> -static void xor_avx_3(unsigned long bytes, unsigned long *p0, unsigned long *p1,
> -       unsigned long *p2)
> +static void xor_avx_3(unsigned long bytes, unsigned long * __restrict p0,
> +                     const unsigned long * __restrict p1,
> +                     const unsigned long * __restrict p2)
>  {
>         unsigned long lines = bytes >> 9;
>
> @@ -82,8 +84,10 @@ do { \
>         kernel_fpu_end();
>  }
>
> -static void xor_avx_4(unsigned long bytes, unsigned long *p0, unsigned long *p1,
> -       unsigned long *p2, unsigned long *p3)
> +static void xor_avx_4(unsigned long bytes, unsigned long * __restrict p0,
> +                     const unsigned long * __restrict p1,
> +                     const unsigned long * __restrict p2,
> +                     const unsigned long * __restrict p3)
>  {
>         unsigned long lines = bytes >> 9;
>
> @@ -115,8 +119,11 @@ do { \
>         kernel_fpu_end();
>  }
>
> -static void xor_avx_5(unsigned long bytes, unsigned long *p0, unsigned long *p1,
> -       unsigned long *p2, unsigned long *p3, unsigned long *p4)
> +static void xor_avx_5(unsigned long bytes, unsigned long * __restrict p0,
> +            const unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3,
> +            const unsigned long * __restrict p4)
>  {
>         unsigned long lines = bytes >> 9;
>
> diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
> index b62a2a56a4d4..44509d48fca2 100644
> --- a/include/asm-generic/xor.h
> +++ b/include/asm-generic/xor.h
> @@ -8,7 +8,8 @@
>  #include <linux/prefetch.h>
>
>  static void
> -xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_8regs_2(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -27,8 +28,9 @@ xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_8regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3)
> +xor_8regs_3(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -48,8 +50,10 @@ xor_8regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_8regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4)
> +xor_8regs_4(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3,
> +           const unsigned long * __restrict p4)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -70,8 +74,11 @@ xor_8regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_8regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_8regs_5(unsigned long bytes, unsigned long * __restrict p1,
> +           const unsigned long * __restrict p2,
> +           const unsigned long * __restrict p3,
> +           const unsigned long * __restrict p4,
> +           const unsigned long * __restrict p5)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -93,7 +100,8 @@ xor_8regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_32regs_2(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -129,8 +137,9 @@ xor_32regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_32regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3)
> +xor_32regs_3(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -175,8 +184,10 @@ xor_32regs_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4)
> +xor_32regs_4(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3,
> +            const unsigned long * __restrict p4)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -230,8 +241,11 @@ xor_32regs_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_32regs_5(unsigned long bytes, unsigned long * __restrict p1,
> +            const unsigned long * __restrict p2,
> +            const unsigned long * __restrict p3,
> +            const unsigned long * __restrict p4,
> +            const unsigned long * __restrict p5)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> @@ -294,7 +308,8 @@ xor_32regs_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_8regs_p_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_8regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>         prefetchw(p1);
> @@ -320,8 +335,9 @@ xor_8regs_p_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_8regs_p_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3)
> +xor_8regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>         prefetchw(p1);
> @@ -350,8 +366,10 @@ xor_8regs_p_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_8regs_p_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4)
> +xor_8regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3,
> +             const unsigned long * __restrict p4)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> @@ -384,8 +402,11 @@ xor_8regs_p_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_8regs_p_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_8regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
> +             const unsigned long * __restrict p2,
> +             const unsigned long * __restrict p3,
> +             const unsigned long * __restrict p4,
> +             const unsigned long * __restrict p5)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> @@ -421,7 +442,8 @@ xor_8regs_p_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_p_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +xor_32regs_p_2(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> @@ -466,8 +488,9 @@ xor_32regs_p_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  }
>
>  static void
> -xor_32regs_p_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3)
> +xor_32regs_p_3(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> @@ -523,8 +546,10 @@ xor_32regs_p_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_p_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4)
> +xor_32regs_p_4(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> @@ -591,8 +616,11 @@ xor_32regs_p_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
>  }
>
>  static void
> -xor_32regs_p_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> -           unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +xor_32regs_p_5(unsigned long bytes, unsigned long * __restrict p1,
> +              const unsigned long * __restrict p2,
> +              const unsigned long * __restrict p3,
> +              const unsigned long * __restrict p4,
> +              const unsigned long * __restrict p5)
>  {
>         long lines = bytes / (sizeof (long)) / 8 - 1;
>
> diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
> index 2a9fee8ddae3..51b811b62322 100644
> --- a/include/linux/raid/xor.h
> +++ b/include/linux/raid/xor.h
> @@ -11,13 +11,20 @@ struct xor_block_template {
>          struct xor_block_template *next;
>          const char *name;
>          int speed;
> -       void (*do_2)(unsigned long, unsigned long *, unsigned long *);
> -       void (*do_3)(unsigned long, unsigned long *, unsigned long *,
> -                    unsigned long *);
> -       void (*do_4)(unsigned long, unsigned long *, unsigned long *,
> -                    unsigned long *, unsigned long *);
> -       void (*do_5)(unsigned long, unsigned long *, unsigned long *,
> -                    unsigned long *, unsigned long *, unsigned long *);
> +       void (*do_2)(unsigned long, unsigned long * __restrict,
> +                    const unsigned long * __restrict);
> +       void (*do_3)(unsigned long, unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict);
> +       void (*do_4)(unsigned long, unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict);
> +       void (*do_5)(unsigned long, unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict,
> +                    const unsigned long * __restrict);
>  };
>
>  #endif
> --
> 2.30.2
>
