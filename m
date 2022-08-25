Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441FE5A05A0
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Aug 2022 03:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiHYBan (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 24 Aug 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiHYBak (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 24 Aug 2022 21:30:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD082D20;
        Wed, 24 Aug 2022 18:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3C91B824CF;
        Thu, 25 Aug 2022 01:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28307C433D6;
        Thu, 25 Aug 2022 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661391036;
        bh=AIi+WB+TlhHAhAH6LiPvV1XFm+WV2u4SODERl2ylZH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAQB5VWXYYKZ8tErqSiheGgiURg99+M043/Yb9HrvZCkWeiVR3iWc7+LvhFmTn+e8
         HbHRXTt917nXlviebHmNlN+AaqWsirwij7iaaCwJdqghmYdMXcjvLfNwz2bX99ZeeF
         Mca1vW8EQQsrCTnFvLnpJqSjCTI3G92AYbjBcJ+2joeEZwMPuiePy5VwMZHm22I3kJ
         YQrKtVjJIENDlaug6amebL0DZbGC2VSH28nkDcr9h4yHUSxF2vKaMfXvHGmllYv8Eq
         ugR8IrvUtBgJvO0z3i8X/cpcG1guIFJ/1v6Z3AW+Qw643aXXYfVz9pMoW01H/YGK3O
         aQVm9iDHl/4HA==
Date:   Thu, 25 Aug 2022 04:30:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Gonda <pgonda@google.com>
Cc:     "Kalra, Ashish" <Ashish.Kalra@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        "Roth, Michael" <Michael.Roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alper Gun <alpergun@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH Part2 v6 02/49] iommu/amd: Introduce function to check
 SEV-SNP support
Message-ID: <YwbQtaaCkBwezpB+@kernel.org>
References: <cover.1655761627.git.ashish.kalra@amd.com>
 <12df64394b1788156c8a3c2ee8dfd62b51ab3a81.1655761627.git.ashish.kalra@amd.com>
 <CAMkAt6r+WSYXLZj-Bs5jpo4CR3+H5cpND0GHjsmgPacBK1GH_Q@mail.gmail.com>
 <SN6PR12MB2767A51D40E7F53395770DE58EB39@SN6PR12MB2767.namprd12.prod.outlook.com>
 <CAMkAt6qorwbAXaPaCaSm0SC9o2uQ9ZQzB6s1kBkvAv2D4tkUug@mail.gmail.com>
 <YwbQKeDRQF0XGWo7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwbQKeDRQF0XGWo7@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 25, 2022 at 04:28:12AM +0300, jarkko@kernel.org wrote:
> On Tue, Jun 21, 2022 at 11:50:59AM -0600, Peter Gonda wrote:
> > On Tue, Jun 21, 2022 at 11:45 AM Kalra, Ashish <Ashish.Kalra@amd.com> wrote:
> > >
> > > [AMD Official Use Only - General]
> > >
> > > Hello Peter,
> > >
> > > >> +bool iommu_sev_snp_supported(void)
> > > >> +{
> > > >> +       struct amd_iommu *iommu;
> > > >> +
> > > >> +       /*
> > > >> +        * The SEV-SNP support requires that IOMMU must be enabled, and is
> > > >> +        * not configured in the passthrough mode.
> > > >> +        */
> > > >> +       if (no_iommu || iommu_default_passthrough()) {
> > > >> +               pr_err("SEV-SNP: IOMMU is either disabled or
> > > >> + configured in passthrough mode.\n");
> > >
> > > > Like below could this say something like snp support is disabled because of iommu settings.
> > >
> > > Here we may need to be more precise with the error information indicating why SNP is not enabled.
> > > Please note that this patch may actually become part of the IOMMU + SNP patch series, where
> > > additional checks are done, for example, not enabling SNP if IOMMU v2 page tables are enabled,
> > > so precise error information will be useful here.
> > 
> > I agree we should be more precise. I just thought we should explicitly
> > state something like: "SEV-SNP: IOMMU is either disabled or configured
> > in passthrough mode, SNP cannot be supported".
> 
> It really should be, in order to have any practical use:
> 
> 	if (no_iommu) {
> 		pr_err("SEV-SNP: IOMMU is disabled.\n");
> 		return false;
> 	}
> 
> 	if (iommu_default_passthrough()) {
> 		pr_err("SEV-SNP: IOMMU is configured in passthrough mode.\n");
> 		return false;
> 	}
> 
> The comment is *completely* redundant, it absolutely does
> not serve any sane purpose. It just tells what the code
> already clearly stating.
> 
> The combo error message on the other hand leaves you to
> the question "which one was it", and for that reason
> combining the checks leaves you to a louse debugging
> experience.

Also, are those really *errors*? That implies that there
is something wrong.

Since you can have a legit configuration, IMHO they should
be either warn or info. What do you think?

They are definitely not errors.

BR, Jarkko
