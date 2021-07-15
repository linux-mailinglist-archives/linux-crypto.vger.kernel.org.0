Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B263CAB79
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Jul 2021 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbhGOTUX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Jul 2021 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbhGOTSa (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Jul 2021 15:18:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BCC05BD43
        for <linux-crypto@vger.kernel.org>; Thu, 15 Jul 2021 12:02:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so5146116pjo.3
        for <linux-crypto@vger.kernel.org>; Thu, 15 Jul 2021 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oe0BZYoHi++518OmcwQpv+uyHbR3qsM3BitMXqojLoA=;
        b=KkSoOuy20ieZTTXspwwIJZ/qwvEcmIUCW96k3EuDRkw1sCkqqKfcmfbO91AF6k1qhS
         8qnpkDZ6aWj0wfJH/0hAVGRBjnP0q0JPwZg61NCU6R+M8HCzy6OVuMROhqb2IxlGGoCv
         h1+17kiQAK58iY2HB5gvPlpH+s2RiLYwdKFn4epefcWw4HfC7qk7/xXjY8aVibZ26rts
         AoJs2gHmC4xTh18jlPJvspNV3vIEX4rBUvYS8GYD11eUpQ7dqa57tcEImxEXNrBDBqn0
         pwW57P75F9EH0EvkFeWxKfIN17JyRtO8gcNDpqmXT6o+6jdGBDLaigPBdnc8a1FhTSz1
         yzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oe0BZYoHi++518OmcwQpv+uyHbR3qsM3BitMXqojLoA=;
        b=cE4pv6Ixgo0JnrQ5AV/dBnWppyHetzSI5VfCIFvplDpqxf3b0vzafsOzecqPYTDlvC
         hHQy3dPxIjcT/hXatSU/lCZ9uCZQHUyy8URG0i0cvOkmSGmegoG/xTIZTvm15MNIy9NO
         lxvcTGM0arOH6VJjcvnQ0fFwoZMkgoVCVieZ5p0c/FpaSbcRAhzxv/QxSNIP8R36X2w9
         JQ56LaTL/W611T885O4q01MDDLnnhUCGpDYhs+CiPc9xg4OJO4p5tgZwLBUDfe4tZw3r
         tRPusVO4e5b+Uv7eWHGBNAy9JJDzt57jH0GQrqc/wkZ13PxLV0q2ODniadvjup/iLHDa
         f1Iw==
X-Gm-Message-State: AOAM533fpI5mqc+//u6YUpstw8YO1t1y0ON6n1nzOeMb1BvLwcxBxLiG
        a+ozPeM9EyP3c/83RHRyGQbI7Q==
X-Google-Smtp-Source: ABdhPJw1dGPTVY/rw4APz9cGy+L54ppHFLemTQp3wX/mwVOXEld90LmZMJamyx8+JoKLrw9sxnMJtQ==
X-Received: by 2002:a17:90a:738e:: with SMTP id j14mr11741420pjg.227.1626375768822;
        Thu, 15 Jul 2021 12:02:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s20sm10639941pjn.23.2021.07.15.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 12:02:48 -0700 (PDT)
Date:   Thu, 15 Jul 2021 19:02:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 08/40] x86/traps: Define RMP violation #PF
 error code
Message-ID: <YPCGVKESqZFWwdyB@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-9-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-9-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> Bit 31 in the page fault-error bit will be set when processor encounters
> an RMP violation.
> 
> While at it, use the BIT() macro.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/include/asm/trap_pf.h | 18 +++++++++++-------
>  arch/x86/mm/fault.c            |  1 +
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
> index 10b1de500ab1..29f678701753 100644
> --- a/arch/x86/include/asm/trap_pf.h
> +++ b/arch/x86/include/asm/trap_pf.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_TRAP_PF_H
>  #define _ASM_X86_TRAP_PF_H
>  
> +#include <vdso/bits.h>  /* BIT() macro */

What are people's thoughts on using linux/bits.h instead of vdso.bits.h, even
though the vDSO version is technically sufficient?  Seeing the "vdso" reference
definitely made me blink slowly a few times.

> +
>  /*
>   * Page fault error code bits:
>   *
> @@ -12,15 +14,17 @@
>   *   bit 4 ==				1: fault was an instruction fetch
>   *   bit 5 ==				1: protection keys block access
>   *   bit 15 ==				1: SGX MMU page-fault
> + *   bit 31 ==				1: fault was an RMP violation
>   */
>  enum x86_pf_error_code {
> -	X86_PF_PROT	=		1 << 0,
> -	X86_PF_WRITE	=		1 << 1,
> -	X86_PF_USER	=		1 << 2,
> -	X86_PF_RSVD	=		1 << 3,
> -	X86_PF_INSTR	=		1 << 4,
> -	X86_PF_PK	=		1 << 5,
> -	X86_PF_SGX	=		1 << 15,
> +	X86_PF_PROT	=		BIT(0),
> +	X86_PF_WRITE	=		BIT(1),
> +	X86_PF_USER	=		BIT(2),
> +	X86_PF_RSVD	=		BIT(3),
> +	X86_PF_INSTR	=		BIT(4),
> +	X86_PF_PK	=		BIT(5),
> +	X86_PF_SGX	=		BIT(15),
> +	X86_PF_RMP	=		BIT(31),
>  };
>  
>  #endif /* _ASM_X86_TRAP_PF_H */
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 1c548ad00752..2715240c757e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -545,6 +545,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
>  		 !(error_code & X86_PF_PROT) ? "not-present page" :
>  		 (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
>  		 (error_code & X86_PF_PK)    ? "protection keys violation" :
> +		 (error_code & X86_PF_RMP)   ? "rmp violation" :
>  					       "permissions violation");
>  
>  	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
> -- 
> 2.17.1
> 
