Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2B57E6F9
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jul 2022 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGVTEc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jul 2022 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVTEb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jul 2022 15:04:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA29AA7204
        for <linux-crypto@vger.kernel.org>; Fri, 22 Jul 2022 12:04:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w205so1868367pfc.8
        for <linux-crypto@vger.kernel.org>; Fri, 22 Jul 2022 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PY64yvYmGtR5KBgIEH0kskaa/Mhm9isORQuQT/+qOTg=;
        b=B2Av3DaoGRaE0kFsKvMfcCX99AkXfypknaWDXFb9SFwhHEv5JLdnDSAkfaX11dJGqo
         38jEKQz554GRe3APlFdff074TrX3y2o35LNMi0grD5vMsxZBSdK8XPybeBXqrlkLioaF
         6dFZxQQc7eoqXr6kzGWGceR/t4+aNbOPCNPgCd2lRG+Lahkdc1kih3rCqlEs45lXTpOh
         Z0Cq8DQqwON7l2Qh/AaLS8smpDrui6seUrMpJBw93tUooNboZt18afPmk4fle6cJ+lIW
         7UDCjbm12Ec/v9+695QP6sQLn8d6aYLp3cOOPmBGmXKyuKSpihx4qvYz3VBRIr2q1/la
         F6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PY64yvYmGtR5KBgIEH0kskaa/Mhm9isORQuQT/+qOTg=;
        b=No3a8+/p/vF74dYU2SPtzU21xBNGOsbhBHVSC7FVxjpPUJLhULBeCvjLgab6g7PEFR
         e3ZqrOoRvPAtbp6PCosjNS7emDLOjVHKE990X6wrFVk/6mopZ/3z1ugMWl9P1O7f69vC
         lwti8IwLVGbPnu0Yk4J23CeLPAbvvgecI80AbaofhZUdF/FHVhwt64p0bc2bZTgGseZI
         +kbfoJX/aDYOIbSHasHBgI7WC97ZOti95rcHszQi18R7RC7aaTlZ7FpMRGu5Gb9LmjfL
         UldxlDvezlo2owIB/99YXofuBM2czOQ1HrJqkaY8qcOUo/7ZrqmYfVTeFtI2MLUzS4RV
         T+LQ==
X-Gm-Message-State: AJIora/4Izb4AQJO05ZDOm+g11Bfg9cqgkRp2Or1i17NkRu4nWlwGdD6
        NC8PqWeN0sVskL2syPCQac0C/w==
X-Google-Smtp-Source: AGRyM1tXJ6+8d199UVPj6kD7+qncEimaUl/b0ptp5tdmerCUqKDRy2ff6UYP5+QOI8loO5mEiiiOrQ==
X-Received: by 2002:a05:6a00:e8f:b0:528:a1c7:3d00 with SMTP id bo15-20020a056a000e8f00b00528a1c73d00mr1329285pfb.25.1658516670031;
        Fri, 22 Jul 2022 12:04:30 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id 186-20020a6215c3000000b0052536c695c0sm4365547pfv.170.2022.07.22.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:04:28 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:04:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kalra, Ashish" <Ashish.Kalra@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "slp@redhat.com" <slp@redhat.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "tobin@ibm.com" <tobin@ibm.com>,
        "Roth, Michael" <Michael.Roth@amd.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "marcorr@google.com" <marcorr@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alpergun@google.com" <alpergun@google.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
Subject: Re: [PATCH Part2 v6 05/49] x86/sev: Add RMP entry lookup helpers
Message-ID: <Ytr0t119QrZ8PUBB@google.com>
References: <BYAPR12MB27599BCEA9F692E173911C3B8EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
 <681e4e45-eff1-600c-9b81-1fa9bdf24232@intel.com>
 <BYAPR12MB27595CF4328B15F0F9573D188EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
 <99d72d58-a9bb-d75c-93af-79d497dfe176@intel.com>
 <BYAPR12MB275984F14B1E103935A103D98EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
 <5db37cc2-4fb1-7a73-c39a-3531260414d0@intel.com>
 <BYAPR12MB2759AA368C8B6A5F1C31642F8EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
 <YrTq3WfOeA6ehsk6@google.com>
 <SN6PR12MB276743CBEAD5AFE9033AFE558EB59@SN6PR12MB2767.namprd12.prod.outlook.com>
 <YtqLhHughuh3KDzH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtqLhHughuh3KDzH@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 22, 2022, Borislav Petkov wrote:
> On Thu, Jun 23, 2022 at 10:43:40PM +0000, Kalra, Ashish wrote:
> > Yes, that's a nice way to hide it from the rest of the kernel which
> > does not require access to this structure anyway, in essence, it
> > becomes a private structure.
> 
> So this whole discussion whether there should be a model check or not
> in case a new RMP format gets added in the future is moot - when a new
> model format comes along, *then* the distinction should be done and
> added in code - not earlier.

I disagree.  Running an old kernel on new hardware with a different RMP layout
should refuse to use SNP, not read/write garbage and likely corrupt the RMP and/or
host memory.

And IMO, hiding the non-architectural RMP format in SNP-specific code so that we
don't have to churn a bunch of call sites that don't _need_ access to the raw RMP
format is a good idea regardless of whether we want to be optimistic or pessimistic
about future formats.

> This is nothing else but normal CPU enablement work - it should be done
> when it is really needed.
> 
> Because the opposite can happen: you can add a model check which
> excludes future model X, future model X comes along but does *not*
> change the RMP format and then you're going to have to relax that model
> check again to fix SNP on the new model X.
> 
> So pls add the model checks only when really needed.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
