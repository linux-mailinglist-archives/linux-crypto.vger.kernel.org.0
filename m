Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E60697A77
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Feb 2023 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBOLNQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Feb 2023 06:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBOLNP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Feb 2023 06:13:15 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B403645E
        for <linux-crypto@vger.kernel.org>; Wed, 15 Feb 2023 03:13:13 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h10so9400400vsu.11
        for <linux-crypto@vger.kernel.org>; Wed, 15 Feb 2023 03:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676459592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9lP4MvG5k1EpDumXLwfDIbMIO5VvOfCG8n4ZwEIYRA=;
        b=LrC6OAsRg8g1C233qVSu2aTQsjJukMSr9kJugX5eEv5xTztxZNBGMYdnJtZL4A3I20
         FoLBUysjf9I+puYCWrbSuqo18hn0vqoPJL/cUrror+NRaNEDJyZ3FV73Mb3RKJ5gxrUm
         doCRxywsnNkhtbu6FZMJIpFRgYhTSkEwnzvw8bRm76R+noLjOzx1LDCmPmiRSHG2fvso
         ELFjfxQfq8GOCff+Anilfx36Xa62SovbSw6qbo8+Grwykib0TwZ2Cc5QFZJb/qgNfGhE
         GfmbPEfktti6g6oROelZgHi/02PwL6GGew43sdomc4f8fWfJDqXSSIFCj1u96PRDbLcp
         idQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676459592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9lP4MvG5k1EpDumXLwfDIbMIO5VvOfCG8n4ZwEIYRA=;
        b=H5dViyQUjXSSf7V08+SnSB/KV+LPXOdpRIIxCBHGMkUwiWozw9F7pzQTbB7pXMdDZX
         1zwh+NUVhjW+yHf1ShtpIHzM5R1KNqIBJPhtbTPNpePA0DNY6hvztsc6ykIPxBCuohdE
         uo5W+9im214YsGL3l3T+XBekxHynnkpf1K1QyEwZx9IJub+km2J7DtHLHtvbCvnuHaqR
         urFYRGFUtgdphYi+nBNqlTYfBN0XSOwPs4a3PeLqGJWFWOi5EEz9ICSidtJaCZ10B9/b
         +4r5P3jTuePQf43xempDcBAx57AWIlXdURLNBhAvPufnApEto0KlkbC1CN4O1Cgkd5wv
         gHCw==
X-Gm-Message-State: AO0yUKVnFyJe0z/qERcDQ40wWJDZnBBiWCT2eW7l1gyXxVzcEYj7QCCv
        Jn9faGtDvK2YtlHdAnxQpZMJibqKPYZ+gG2QeuZkAw==
X-Google-Smtp-Source: AK7set+3UZH4rvUHU7q81fVFwnGAXPrl5eO9z6mdY/NTSmUYUwUrPc1QZupIIazj9JL9bT4f4FTNcpxlotuAc3guJtA=
X-Received: by 2002:a67:6081:0:b0:3ee:65e3:af84 with SMTP id
 u123-20020a676081000000b003ee65e3af84mr325407vsb.77.1676459592133; Wed, 15
 Feb 2023 03:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20230209223811.4993-1-mario.limonciello@amd.com> <20230209223811.4993-3-mario.limonciello@amd.com>
In-Reply-To: <20230209223811.4993-3-mario.limonciello@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 Feb 2023 16:43:01 +0530
Message-ID: <CAFA6WYMJosUrE0BzQe6xFOaofZZWGiRBPBqoGk4Cvhm5s30VEQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] crypto: ccp: Add a header for multiple drivers to use `__psp_pa`
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Thomas Rijo-john <Rijo-john.Thomas@amd.com>,
        Lendacky Thomas <Thomas.Lendacky@amd.com>,
        herbert@gondor.apana.org.au,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        kvm@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 10 Feb 2023 at 04:08, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
> drivers all include `psp-sev.h` even though they don't use SEV
> functionality.
>
> Move the definition of `__psp_pa` into a common header to be included
> by all of these drivers.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c                     |  1 +
>  drivers/crypto/ccp/sev-dev.c               |  1 +
>  drivers/crypto/ccp/tee-dev.c               |  2 +-
>  drivers/i2c/busses/i2c-designware-amdpsp.c |  2 +-

>  drivers/tee/amdtee/call.c                  |  2 +-
>  drivers/tee/amdtee/shm_pool.c              |  2 +-

For TEE subsystem bits:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  include/linux/psp-sev.h                    |  8 --------
>  include/linux/psp.h                        | 14 ++++++++++++++
>  8 files changed, 20 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/psp.h
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 86d6897f48068..ee8e9053f4468 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -11,6 +11,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/kernel.h>
>  #include <linux/highmem.h>
> +#include <linux/psp.h>
>  #include <linux/psp-sev.h>
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index e2f25926eb514..28945ca7c8563 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/fs.h>
>  #include <linux/fs_struct.h>
> +#include <linux/psp.h>
>
>  #include <asm/smp.h>
>  #include <asm/cacheflush.h>
> diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
> index 5c9d47f3be375..f24fc953718a0 100644
> --- a/drivers/crypto/ccp/tee-dev.c
> +++ b/drivers/crypto/ccp/tee-dev.c
> @@ -13,7 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/gfp.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include <linux/psp-tee.h>
>
>  #include "psp-dev.h"
> diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/busses/i2c-designware-amdpsp.c
> index 8f36167bce624..80f28a1bbbef6 100644
> --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> @@ -4,7 +4,7 @@
>  #include <linux/bits.h>
>  #include <linux/i2c.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index cec6e70f0ac92..e8cd9aaa34675 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -8,7 +8,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/psp-tee.h>
>  #include <linux/slab.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include "amdtee_if.h"
>  #include "amdtee_private.h"
>
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f87f96a291c99..f0303126f199d 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -5,7 +5,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> -#include <linux/psp-sev.h>
> +#include <linux/psp.h>
>  #include "amdtee_private.h"
>
>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index 1595088c428b4..7fd17e82bab43 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -14,14 +14,6 @@
>
>  #include <uapi/linux/psp-sev.h>
>
> -#ifdef CONFIG_X86
> -#include <linux/mem_encrypt.h>
> -
> -#define __psp_pa(x)    __sme_pa(x)
> -#else
> -#define __psp_pa(x)    __pa(x)
> -#endif
> -
>  #define SEV_FW_BLOB_MAX_SIZE   0x4000  /* 16KB */
>
>  /**
> diff --git a/include/linux/psp.h b/include/linux/psp.h
> new file mode 100644
> index 0000000000000..202162487ec3b
> --- /dev/null
> +++ b/include/linux/psp.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __PSP_H
> +#define __PSP_H
> +
> +#ifdef CONFIG_X86
> +#include <linux/mem_encrypt.h>
> +
> +#define __psp_pa(x)    __sme_pa(x)
> +#else
> +#define __psp_pa(x)    __pa(x)
> +#endif
> +
> +#endif /* __PSP_H */
> --
> 2.34.1
>
