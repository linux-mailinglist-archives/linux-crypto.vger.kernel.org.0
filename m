Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A01462D46
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Nov 2021 08:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhK3HGz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Nov 2021 02:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhK3HGz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Nov 2021 02:06:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CCC061574
        for <linux-crypto@vger.kernel.org>; Mon, 29 Nov 2021 23:03:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r138so18731598pgr.13
        for <linux-crypto@vger.kernel.org>; Mon, 29 Nov 2021 23:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zC9NSf7C+Sd9VsOuPnj6yc8Mzbcb3eklQvox37KbRBI=;
        b=fHo9izik2jHuftHuQxohxLfoZzTc7/HPsOjuLHJrF25p69I2cc3/VpkHip2d6txbu/
         YJckxYpgZiAYmocFJ/RWJ2iJdxNi0bTd3c3e14jmUrRLs3QYxsxuq0088YsZ2PYjG55V
         E7PO8KxdlmB1EudEHJG0XZYjsJi7184lpDQhono0usu7GV1Bg5tSZbqCzdfdogkBj2WJ
         SXI5PidKnYgyAQU0A8jF8z+VjwfaISJRnhdWU2Jg9upFiYovyIswJPV7UwRjGtAYy4zi
         wQZTFEq/Zi/Px1K7brs6sphNQBAVhWWeOFQVvd8whYu4932WgnOu0oUpS5QuN3NcBIcr
         248A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zC9NSf7C+Sd9VsOuPnj6yc8Mzbcb3eklQvox37KbRBI=;
        b=r/+jHfCYhC3osuEOMg30j1XOGw4/JM1s0EgTtpQvhyw+nYmYntW27Kiw9MEiROn5Op
         HHKzVzrciOkR+ZS8JzYWeM5/a2RSiPHv4D9n7e2ZKSf206QKgsfTjqdqjXmHXpLngjSF
         JqOr+o9eKck/6c0NhWpp1BmmlyMMpNKFoz6JQv2xVVntwoRaJMqJxlsebGfuPCtPhWxf
         3Tdc3PdQ6uPQykd2ajUoc1X90cQyPYJNyBBnzoc5t6SfmCvmsDad1gPqEn+gD5AY5JoJ
         uY0z8lvYbt33k5O96g/4N2CFzYaOv1mFf6ZqX9QAjWVtrxzrSxKc5Ay1TaCJjYLaAHWI
         5SCA==
X-Gm-Message-State: AOAM531JwKjxKb9+X682U8FM6jLofMFVf/TGZbwHYiulCLCQYCNcto7B
        68Y+s2Gv7k+iPlOTt8ETM3RBFQROXgkCkbk87+abng==
X-Google-Smtp-Source: ABdhPJxidEYMsrLZxmzvvFQre312YLryI7QVOW4rmfMtK9pfuQXgb14cQ9PMCZqF4V+wAnvw8lvc8sTv88wWocOJdvE=
X-Received: by 2002:a63:d915:: with SMTP id r21mr39558221pgg.40.1638255815643;
 Mon, 29 Nov 2021 23:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com> <YaWfKB+k66MzNtIi@sol.localdomain>
 <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
In-Reply-To: <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 23:03:24 -0800
Message-ID: <CAPcyv4jst3PSPU5HFdcrzQ2Bxt1uXd_-cbundYRP_i=fUsd5-g@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 29, 2021 at 10:57 PM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
> On Nov 29, 2021, at 19:48, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, Nov 24, 2021 at 12:06:56PM -0800, Chang S. Bae wrote:
> >> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> >> index ef6c0b9f69c6..f696b037faa5 100644
> >> --- a/arch/x86/crypto/Makefile
> >> +++ b/arch/x86/crypto/Makefile
> >> @@ -50,6 +50,9 @@ obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
> >> aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o aes-intel_glue.o
> >> aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
> >>
> >> +obj-$(CONFIG_CRYPTO_AES_KL) += aeskl-intel.o
> >> +aeskl-intel-y := aeskl-intel_asm.o aesni-intel_asm.o aeskl-intel_glue.o aes-intel_glue.o
> >
> > This makes the object files aesni-intel_asm.o and aes-intel_glue.o each be built
> > into two separate kernel modules.  My understanding is that duplicating code
> > like that is generally frowned upon.  These files should either be built into a
> > separate module, which both aesni-intel.ko and aeskl-intel.ko would depend on,
> > or aeskl-intel.ko should depend on aesni-intel.ko.
>
> The only reason to include the AES-NI object here is that AES-KL does not
> support the 192-bit key.
>
> Maybe the fallback can be the aes-generic driver [1] instead of AES-NI here.
>
> >> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
> >> new file mode 100644
> >> index 000000000000..d56ec8dd6644
> >> --- /dev/null
> >> +++ b/arch/x86/crypto/aeskl-intel_asm.S
> >
> > This file gets very long after all the modes are added (> 1100 lines).  Is there
> > really no feasible way to share code between this and aesni-intel_asm.S, similar
> > to how the arm64 AES implementations work?  Surely most of the logic is the
> > same, and it's just the actual AES instructions that differ?
>
> No, these two instruction sets are separate. So I think no room to share the
> ASM code.
>
> >> +config CRYPTO_AES_KL
> >> +    tristate "AES cipher algorithms (AES-KL)"
> >> +    depends on (LD_VERSION >= 23600) || (LLD_VERSION >= 120000)
> >> +    depends on DM_CRYPT
> >
> > 'depends on DM_CRYPT' doesn't really make sense here, since there is no actual
> > dependency on dm-crypt in the code.
>
> I think the intention here is to build a policy that the library is available
> only when there is a clear use case.
>
> But maybe putting such restriction is too much here.
>

Yeah, my bad the "depends on DM_CRYPT" can go. Even though the Key
Locker support has no real pressing reason to be built without it,
there is still no actual code dependency.
