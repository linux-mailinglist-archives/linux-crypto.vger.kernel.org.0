Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60B55D0A0
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jun 2022 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiF1Kut (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jun 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiF1Kus (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jun 2022 06:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7191C24F37
        for <linux-crypto@vger.kernel.org>; Tue, 28 Jun 2022 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656413446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fBnpEBJJsEjj4xp1XzlNmSDPEps8RE1TeLCO9pCV3b8=;
        b=Nh5/HTIO1DVp5K2HoxqI0LjyfaE3XWL7WDfmyZNVK+2bg42oD4Dm13FHxP6rPK1BQUiBRN
        xqTyifWfaTP9w5MF85p7aeEEYg0HMQREZhQzlKI4RYQXuJsd4saDPoenvpVPOJmnVxqDmO
        W+sOXi4gAOD7dJEwjXO4MeDM9E9UGus=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-8Q6xFcZ9M_Kq1Z4XaSt61w-1; Tue, 28 Jun 2022 06:50:44 -0400
X-MC-Unique: 8Q6xFcZ9M_Kq1Z4XaSt61w-1
Received: by mail-wr1-f71.google.com with SMTP id y18-20020adfdf12000000b0021b94ba4c37so1729607wrl.11
        for <linux-crypto@vger.kernel.org>; Tue, 28 Jun 2022 03:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBnpEBJJsEjj4xp1XzlNmSDPEps8RE1TeLCO9pCV3b8=;
        b=AIkZJVozUcJjLH2tlT91k2AWflo/jelP/FfzbRKzUrTuiM86UZCBbWpO+G2zzPY97J
         HG5lcvy/DWy/SAR4ZrzRikExcOGR+3kXfnBk4gK0rxCkHCsbtdU+Yo5Au/nOx4JM9qba
         CX+Xe9CAO1oiq8fy80smBp2KlLSLKbEa2xWMHO1B7Ya2mZlBZliXeGlV7pgaDDPDT9ME
         0iBOR6xvSv8rmxqKb2kNNXm4xBm2Q8VS02shxgUWqy5JY7xGb/P/haVbpHLGs4tKPVoX
         bbduTnIeHbQZbmsBUPxIm4O6384egPVm7iRMOnqAsK7HdD308rMihtnummL0dY3xqoNL
         Jppg==
X-Gm-Message-State: AJIora+y0/Ijce63uFoDRaq0amugcdvU634aRIn7vdabucUEvemshaF+
        eUa7++9pn6g3C09SNulTQL4id23KSP0aoPM/W+HSGJRjb14n8hzycuOi2x0t3W9iIXUUQFuWNwv
        KJbeiQtdbGt6FhluOjtY9aqp6
X-Received: by 2002:a05:600c:1547:b0:39c:7fc6:3082 with SMTP id f7-20020a05600c154700b0039c7fc63082mr26228165wmg.189.1656413442946;
        Tue, 28 Jun 2022 03:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOc62+TwZm4Lysu7PiidKj6NprJiStBGJ45lIax1y18ihr6TTIBSDrSl64O72de4xS9gTWfQ==
X-Received: by 2002:a05:600c:1547:b0:39c:7fc6:3082 with SMTP id f7-20020a05600c154700b0039c7fc63082mr26228150wmg.189.1656413442750;
        Tue, 28 Jun 2022 03:50:42 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d4ecb000000b0020fe61acd09sm13521418wrv.12.2022.06.28.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:50:42 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:50:39 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
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
        "seanjc@google.com" <seanjc@google.com>,
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
        "tobin@ibm.com" <tobin@ibm.com>, "bp@alien8.de" <bp@alien8.de>,
        "Roth, Michael" <Michael.Roth@amd.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "marcorr@google.com" <marcorr@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alpergun@google.com" <alpergun@google.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
Subject: Re: [PATCH Part2 v6 06/49] x86/sev: Add helper functions for
 RMPUPDATE and PSMASH instruction
Message-ID: <Yrrc/6x70wa14c5t@work-vm>
References: <cover.1655761627.git.ashish.kalra@amd.com>
 <e4643e9d37fcb025d0aec9080feefaae5e9245d5.1655761627.git.ashish.kalra@amd.com>
 <YrH0ca3Sam7Ru11c@work-vm>
 <SN6PR12MB2767FBF0848B906B9F0284D28EB39@SN6PR12MB2767.namprd12.prod.outlook.com>
 <BYAPR12MB2759910E715C69D1027CCE678EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2759910E715C69D1027CCE678EB29@BYAPR12MB2759.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

* Kalra, Ashish (Ashish.Kalra@amd.com) wrote:
> [AMD Official Use Only - General]
> 
> >>>  /*
> >>>   * The RMP entry format is not architectural. The format is defined 
> >>> in PPR @@ -126,6 +128,15 @@ struct snp_guest_platform_data {
> >>>  	u64 secrets_gpa;
> >>>  };
> >>>  
> >>> +struct rmpupdate {
> >>> +	u64 gpa;
> >>> +	u8 assigned;
> >>> +	u8 pagesize;
> >>> +	u8 immutable;
> >>> +	u8 rsvd;
> >>> +	u32 asid;
> >>> +} __packed;
> 
> >>I see above it says the RMP entry format isn't architectural; is this 'rmpupdate' structure? If not how is this going to get handled when we have a couple >of SNP capable CPUs with different layouts?
> 
> >Architectural implies that it is defined in the APM and shouldn't change in such a way as to not be backward compatible. 
> >I probably think the wording here should be architecture independent or more precisely platform independent.
> 
> Some more clarity on this: 
> 
> Actually, the PPR for family 19h Model 01h, Rev B1 defines the RMP entry format as below:
> 
> 2.1.4.2 RMP Entry Format
> Architecturally the format of RMP entries are not specified in APM. In order to assist software, the following table specifies select portions of the RMP entry format for this specific product. Each RMP entry is 16B in size and is formatted as follows. Software should not rely on any field definitions not specified in this table and the format of an RMP entry may change in future processors. 
> 
> Architectural implies that it is defined in the APM and shouldn't change in such a way as to not be backward compatible. So non-architectural in this context means that it is only defined in our PPR.
> 
> So actually this RPM entry definition is platform dependent and will need to be changed for different AMD processors and that change has to be handled correspondingly in the dump_rmpentry() code. 

You'll need a way to make that fail cleanly when run on a newer CPU
with different layout, and a way to build kernels that can handle
more than one layout.

Dave

> Thanks,
> Ashish
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

