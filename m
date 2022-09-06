Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44A5AED4B
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Sep 2022 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbiIFOaB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Sep 2022 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiIFO3a (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Sep 2022 10:29:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E392F45
        for <linux-crypto@vger.kernel.org>; Tue,  6 Sep 2022 06:55:44 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k80so5601311ybk.10
        for <linux-crypto@vger.kernel.org>; Tue, 06 Sep 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=itCXU38GNPssCt/WSnoeX0ePqT6vjs+McfV7VfLaXm0=;
        b=RzruAzofCMQISZ7x90frSvdR83WhvBYVnd/FIbkqRMYnbBjNIgunhHzImKxDheGcpL
         OmES4oqH+U6hqJ0648JvYJZ5FJ+XnQkpvpnXYgB/FZ2GHPLpJQ0QN43GPHin/l08XpS+
         yD6NvtTAv9ASEpDarkUwqQ7XPSv/6B2AnCvhwYXuozzv1drCaTJQx0wM6RSbsfiLp8vS
         hTI5vh/Nq7+qwYVeRC0+Wi0CLMRGz4IGkt+KOWpO0jt1yWsiz3o5zKR+ITp0n8AwZI8N
         LAlFx6LxeWUT6fQvRdtU5fvX6dnqt4hhTbzzQFbyflygaMAJQ3a1DrvR1p63UgA9p9fv
         B9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=itCXU38GNPssCt/WSnoeX0ePqT6vjs+McfV7VfLaXm0=;
        b=16p/QyZWv0oFrzcQYmhiXqxWQf4ES2ijnrwZhix+mrikNwW4KqiwURyt83BdakzS2y
         456heXfeFKHNC1I7s9esFCnUOWdEXt3QIVjTxOd/lTxHmm0A/OWjPyThM1BaUxSwDkDa
         qWhUxb/N/Wvz2ts1zxmVrTsRHc0EzlBTWdoNilv2DOg6BAHvaWViWnTwP0F0IvZStHBB
         wFojD3yn7E0yAiX4yqwOKO18PEaBhwHQK61BR6h6O0iDI2n7YBoV29VuuKdoqSu18UPt
         BrSxSunllEeu+QnXMzjqM/8KCt6dVg2cx2RB1EYPIhsOj5xaIdXPpj6LwfsofP1xLq3u
         hugg==
X-Gm-Message-State: ACgBeo3AMg958xcnV1rpLQTZbpJdpUokc2VS07jN4Qo91+2db3NeXMBH
        07+BxVJEGf9wdGBMCGjlkQo0YWRRGvNH9RW9loIV3A==
X-Google-Smtp-Source: AA6agR6QNbWksDmoi7tCjaXWjvMyjPy9pFFuRtJzEHIb64zO9pawVP7ef2xQZqgbZnq01U/6FcMtKbhZEmVMfTewxmY=
X-Received: by 2002:a25:83d2:0:b0:696:1071:1a01 with SMTP id
 v18-20020a2583d2000000b0069610711a01mr37353558ybm.335.1662472481680; Tue, 06
 Sep 2022 06:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655761627.git.ashish.kalra@amd.com> <0ecb0a4781be933fcadeb56a85070818ef3566e7.1655761627.git.ashish.kalra@amd.com>
 <YvKRjxgipxLSNCLe@zn.tnic> <YxcgAk7AHWZVnSCJ@kernel.org>
In-Reply-To: <YxcgAk7AHWZVnSCJ@kernel.org>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 6 Sep 2022 06:54:30 -0700
Message-ID: <CAA03e5FgiLoixmqpKtfNOXM_0P5Y7LQzr3_oQe+2Z=GJ6kw32g@mail.gmail.com>
Subject: Re: [PATCH Part2 v6 09/49] x86/fault: Add support to handle the RMP
 fault for user address
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Ashish Kalra <Ashish.Kalra@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        "Roth, Michael" <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alper Gun <alpergun@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 6, 2022 at 3:25 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Aug 09, 2022 at 06:55:43PM +0200, Borislav Petkov wrote:
> > On Mon, Jun 20, 2022 at 11:03:43PM +0000, Ashish Kalra wrote:
> > > +   pfn = pte_pfn(*pte);
> > > +
> > > +   /* If its large page then calculte the fault pfn */
> > > +   if (level > PG_LEVEL_4K) {
> > > +           unsigned long mask;
> > > +
> > > +           mask = pages_per_hpage(level) - pages_per_hpage(level - 1);
> > > +           pfn |= (address >> PAGE_SHIFT) & mask;
> >
> > Oh boy, this is unnecessarily complicated. Isn't this
> >
> >       pfn |= pud_index(address);
> >
> > or
> >       pfn |= pmd_index(address);
>
> I played with this a bit and ended up with
>
>         pfn = pte_pfn(*pte) | PFN_DOWN(address & page_level_mask(level - 1));
>
> Unless I got something terribly wrong, this should do the
> same (see the attached patch) as the existing calculations.

Actually, I don't think they're the same. I think Jarkko's version is
correct. Specifically:
- For level = PG_LEVEL_2M they're the same.
- For level = PG_LEVEL_1G:
The current code calculates a garbage mask:
mask = pages_per_hpage(level) - pages_per_hpage(level - 1);
translates to:
>>> hex(262144 - 512)
'0x3fe00'

But I believe Jarkko's version calculates the correct mask (below),
incorporating all 18 offset bits into the 1G page.
>>> hex(262144 -1)
'0x3ffff'
