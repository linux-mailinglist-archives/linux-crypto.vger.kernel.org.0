Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEDDF20D6
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfKFVa4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Nov 2019 16:30:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50820 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKFVa4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Nov 2019 16:30:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id 11so5746627wmk.0
        for <linux-crypto@vger.kernel.org>; Wed, 06 Nov 2019 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDBZcXZuvlzCcxAcWPoIlsxHdAQXWoVKuQlc0wwPPI8=;
        b=QxDTzIQszo1Nx3bstlbRS9hdM62MG+LTNL7d0ZHv3xCiyU+be9fpCSDIT4YEOPByfE
         s+DkJkLSj+j8et1T0arUVeRPqch11/e+V5HCt+2jaR6qh15MZY0JRkqwDExqNMtR3Sp0
         DyeJQyL72+zHZfb8Z/693fryrLqzL+q3n64T403StMD9bcsnnBk3JqG0gNit9lI2ItKY
         kN6V61/GqQIjgcotqq61266QkgZEGvisShcO8tAcroyANgtoUpGZWHmovApFo4x4jot6
         a2WRsOTJFW5j2Tfs04vdBmsaR/4w7TnzIM8yWfFZQwCJW4XYT46MX9G4eMLfa8g5gpZ8
         m5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDBZcXZuvlzCcxAcWPoIlsxHdAQXWoVKuQlc0wwPPI8=;
        b=T7rmNAR0u0OnPqgAhbJExrKW61EvWdIzw7jPnv4oNjxBYT4czgF7+Ru4nvfGXw35Yp
         MhsxTruxODVneONbBm2WsCMsJLgU1fX/9zL4WG2hDjwr3UfD6EuITMtkMUS4Ljcq88Jg
         7KwQG3IeWVo87QqEvJKWIyMrqxkWIxzRucypX/qPNr616KbVcrwJOOFARglds6cXcHta
         uoD5cYWqEttybQwMKis7o1/ShSHF6pKcr6/wNpFGjmrPyyoQja0gZWHvm5HhCaqJeIdR
         tiAxS92ZIYv/8iA0ogNJ+9gnqPbMrM3mP+8gTkycH3w0HNIEH2XrK/i6iDhdJfiZF2fN
         DvBg==
X-Gm-Message-State: APjAAAWRqUY/Z/2FSaYiugMSZzcv0Z2myxDgmaqm0r+0ijXlf76Fa1X7
        to+epl+wMlXQBdo75timSh1hMYbSG8BHLfPyYknlGg==
X-Google-Smtp-Source: APXvYqywg7rEiAwTN9VllJ/ecYLzJNNjAq5be13P68bZ4gSPmhuaBElXl7hCkFYw1vh9GEIWWOhqlSszeDCzY1wJ9Bg=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr4129671wmb.136.1573075853166;
 Wed, 06 Nov 2019 13:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20191106141954.30657-1-rth@twiddle.net> <20191106141954.30657-2-rth@twiddle.net>
In-Reply-To: <20191106141954.30657-2-rth@twiddle.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 22:30:42 +0100
Message-ID: <CAKv+Gu8pb5pBFBg0wGoORmaS6yzmoX7L45LLnhuZhqw4JX7d+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 6 Nov 2019 at 15:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Expose the ID_AA64ISAR0.RNDR field to userspace, as the
> RNG system registers are always available at EL0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Use __mrs_s and fix missing cc clobber (Mark),
>     Log rng failures with pr_warn (Mark),
>     Use __must_check; put RNDR in arch_get_random_long and RNDRRS
>     in arch_get_random_seed_long (Ard),
>     Use ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE, and check this_cpu_has_cap
>     when reading random data.  Move everything out of line, now that
>     there are 5 other function calls involved, and to unify the rate
>     limiting on the pr_warn.
> v3: Keep arch_get_random{,_seed}_long in sync.
> v4: Use __cpus_have_const_cap before falling back to this_cpu_has_cap.
> ---
>  Documentation/arm64/cpu-feature-registers.rst |  2 +
>  arch/arm64/include/asm/archrandom.h           | 35 ++++++++
>  arch/arm64/include/asm/cpucaps.h              |  3 +-
>  arch/arm64/include/asm/sysreg.h               |  4 +
>  arch/arm64/kernel/cpufeature.c                | 13 +++
>  arch/arm64/kernel/random.c                    | 79 +++++++++++++++++++
>  arch/arm64/Kconfig                            | 12 +++
>  arch/arm64/kernel/Makefile                    |  1 +
>  drivers/char/Kconfig                          |  4 +-
>  9 files changed, 150 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/archrandom.h
>  create mode 100644 arch/arm64/kernel/random.c
>
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index 2955287e9acc..78d6f5c6e824 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -117,6 +117,8 @@ infrastructure:
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> +     | RNDR                         | [63-60] |    y    |
> +     +------------------------------+---------+---------+
>       | TS                           | [55-52] |    y    |
>       +------------------------------+---------+---------+
>       | FHM                          | [51-48] |    y    |
> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> new file mode 100644
> index 000000000000..e796a6de7421
> --- /dev/null
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARCHRANDOM_H
> +#define _ASM_ARCHRANDOM_H
> +
> +#ifdef CONFIG_ARCH_RANDOM
> +
> +bool __must_check arch_get_random_long(unsigned long *v);
> +bool __must_check arch_get_random_seed_long(unsigned long *v);
> +
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
> +{
> +       unsigned long val;
> +
> +       if (arch_get_random_long(&val)) {
> +               *v = val;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> +{
> +       unsigned long val;
> +
> +       if (arch_get_random_seed_long(&val)) {
> +               *v = val;
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +#endif /* CONFIG_ARCH_RANDOM */
> +#endif /* _ASM_ARCHRANDOM_H */
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index ac1dbca3d0cd..1dd7644bc59a 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -54,7 +54,8 @@
>  #define ARM64_WORKAROUND_1463225               44
>  #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM    45
>  #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM   46
> +#define ARM64_HAS_RNG                          47
>
> -#define ARM64_NCAPS                            47
> +#define ARM64_NCAPS                            48
>
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6e919fafb43d..5e718f279469 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -365,6 +365,9 @@
>  #define SYS_CTR_EL0                    sys_reg(3, 3, 0, 0, 1)
>  #define SYS_DCZID_EL0                  sys_reg(3, 3, 0, 0, 7)
>
> +#define SYS_RNDR_EL0                   sys_reg(3, 3, 2, 4, 0)
> +#define SYS_RNDRRS_EL0                 sys_reg(3, 3, 2, 4, 1)
> +
>  #define SYS_PMCR_EL0                   sys_reg(3, 3, 9, 12, 0)
>  #define SYS_PMCNTENSET_EL0             sys_reg(3, 3, 9, 12, 1)
>  #define SYS_PMCNTENCLR_EL0             sys_reg(3, 3, 9, 12, 2)
> @@ -539,6 +542,7 @@
>                          ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
>
>  /* id_aa64isar0 */
> +#define ID_AA64ISAR0_RNDR_SHIFT                60
>  #define ID_AA64ISAR0_TS_SHIFT          52
>  #define ID_AA64ISAR0_FHM_SHIFT         48
>  #define ID_AA64ISAR0_DP_SHIFT          44
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 80f459ad0190..456d5c461cbf 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -119,6 +119,7 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
>   * sync with the documentation of the CPU feature register ABI.
>   */
>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
> +       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TS_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
> @@ -1565,6 +1566,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .sign = FTR_UNSIGNED,
>                 .min_field_value = 1,
>         },
> +#endif
> +#ifdef CONFIG_ARCH_RANDOM
> +       {
> +               .desc = "Random Number Generator",
> +               .capability = ARM64_HAS_RNG,
> +               .type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> +               .matches = has_cpuid_feature,
> +               .sys_reg = SYS_ID_AA64ISAR0_EL1,
> +               .field_pos = ID_AA64ISAR0_RNDR_SHIFT,
> +               .sign = FTR_UNSIGNED,
> +               .min_field_value = 1,
> +       },
>  #endif
>         {},
>  };
> diff --git a/arch/arm64/kernel/random.c b/arch/arm64/kernel/random.c
> new file mode 100644
> index 000000000000..a13f082d88e6
> --- /dev/null
> +++ b/arch/arm64/kernel/random.c
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Random number generation using ARMv8.5-RNG.
> + */
> +
> +#include <linux/random.h>
> +#include <linux/ratelimit.h>
> +#include <linux/printk.h>
> +#include <linux/preempt.h>
> +#include <asm/cpufeature.h>
> +
> +static inline bool has_random(void)
> +{
> +       /*
> +        * We "have" RNG if either
> +        * (1) every cpu in the system has RNG, or
> +        * (2) in a non-preemptable context, current cpu has RNG.
> +        * Case 1 is the expected case when RNG is deployed, but
> +        * case 2 is present as a backup in case some big/little
> +        * system only has RNG on big cpus, we can still add entropy
> +        * from the interrupt handler of the big cpus.

I don't understand the reference to the interrupt handler here. It is
worth mentioning though that this arrangement permits
rand_initialize() to use the instructions regardless of whether they
are implemented only by the boot CPU or by all of them.

> +        * We can use __cpus_have_const_cap because we then fall
> +        * back to checking the current cpu.
> +        */
> +       return __cpus_have_const_cap(ARM64_HAS_RNG) ||
> +              (!preemptible() && this_cpu_has_cap(ARM64_HAS_RNG));
> +}
> +
> +bool arch_get_random_long(unsigned long *v)
> +{
> +       bool ok;
> +
> +       if (!has_random()) {
> +               return false;
> +       }
> +
> +       /*
> +        * Reads of RNDR set PSTATE.NZCV to 0b0000 on success,
> +        * and set PSTATE.NZCV to 0b0100 otherwise.
> +        */
> +       asm volatile(
> +               __mrs_s("%0", SYS_RNDR_EL0) "\n"
> +       "       cset %w1, ne\n"
> +       : "=r"(*v), "=r"(ok)
> +       :
> +       : "cc");
> +
> +       if (unlikely(!ok)) {
> +               pr_warn_ratelimited("cpu%d: sys_rndr failed\n",
> +                                   read_cpuid_id());
> +       }
> +       return ok;
> +}
> +
> +bool arch_get_random_seed_long(unsigned long *v)
> +{
> +       bool ok;
> +
> +       if (!has_random()) {
> +               return false;
> +       }
> +
> +       /*
> +        * Reads of RNDRRS set PSTATE.NZCV to 0b0000 on success,
> +        * and set PSTATE.NZCV to 0b0100 otherwise.
> +        */
> +       asm volatile(
> +               __mrs_s("%0", SYS_RNDRRS_EL0) "\n"
> +       "       cset %w1, ne\n"
> +       : "=r"(*v), "=r"(ok)
> +       :
> +       : "cc");
> +
> +       if (unlikely(!ok)) {
> +               pr_warn_ratelimited("cpu%d: sys_rndrrs failed\n",
> +                                   read_cpuid_id());
> +       }
> +       return ok;
> +}
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3f047afb982c..5bc88601f07b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1438,6 +1438,18 @@ config ARM64_PTR_AUTH
>
>  endmenu
>
> +menu "ARMv8.5 architectural features"
> +
> +config ARCH_RANDOM
> +       bool "Enable support for random number generation"
> +       default y
> +       help
> +         Random number generation (part of the ARMv8.5 Extensions)
> +         provides a high bandwidth, cryptographically secure
> +         hardware random number generator.
> +
> +endmenu
> +
>  config ARM64_SVE
>         bool "ARM Scalable Vector Extension support"
>         default y
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 478491f07b4f..a47c2b984da7 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE)              += crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)                += sdei.o
>  obj-$(CONFIG_ARM64_SSBD)               += ssbd.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)           += pointer_auth.o
> +obj-$(CONFIG_ARCH_RANDOM)              += random.o
>
>  obj-y                                  += vdso/ probes/
>  obj-$(CONFIG_COMPAT_VDSO)              += vdso32/
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index df0fc997dc3e..f26a0a8cc0d0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -539,7 +539,7 @@ endmenu
>
>  config RANDOM_TRUST_CPU
>         bool "Trust the CPU manufacturer to initialize Linux's CRNG"
> -       depends on X86 || S390 || PPC
> +       depends on X86 || S390 || PPC || ARM64
>         default n
>         help
>         Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
> @@ -559,4 +559,4 @@ config RANDOM_TRUST_BOOTLOADER
>         device randomness. Say Y here to assume the entropy provided by the
>         booloader is trustworthy so it will be added to the kernel's entropy
>         pool. Otherwise, say N here so it will be regarded as device input that
> -       only mixes the entropy pool.
> \ No newline at end of file
> +       only mixes the entropy pool.
> --
> 2.17.1
>
