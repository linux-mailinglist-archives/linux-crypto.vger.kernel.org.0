Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5B42FB7E
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Oct 2021 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbhJOTAv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Oct 2021 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhJOTAu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Oct 2021 15:00:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6251C061764
        for <linux-crypto@vger.kernel.org>; Fri, 15 Oct 2021 11:58:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s136so6138309pgs.4
        for <linux-crypto@vger.kernel.org>; Fri, 15 Oct 2021 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQM6iseqNr527XMaI35HFwel5PilmxiFDRjsypqPjJY=;
        b=OWTVpv7FF2Ibi9JFu8PskmJJXobmWCskKm13NYVXbiD1hh6KL51VFSmJ6MbJbWtQA2
         L3y+YLr3YYr5u1dNm/ZbLKZIYjxIuDeGnTF4yR2kPBwTo98FZNh9lN0vRR6mf4YSGdYg
         OjKQn7XkYoD1m1UZ1fk8JA2Nvl709DHiWTxtZpbGclYN5l0Lq5XDMVN3rFndlv3X4zdJ
         Znat97o7ahqtZ3IFR8Znsqs7FR9dYuKbAtSZa9rM4UoKyN7N/HcFoQtLEL6TobpdavVO
         30UwYM/ReX1Nrybgj4EzVstae47oOfiIo678d3bZiHDwtKtfkklUcguMl56tPWgGAxo9
         CbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQM6iseqNr527XMaI35HFwel5PilmxiFDRjsypqPjJY=;
        b=VNomgLtVsQd6BKR58b8D/Fz5tV6Z5U90YhaR/I881gKQOLHhI3U0jAOns3OsJ/7e0z
         xHY55ibTia204AanshyzbprCrpg3fLw41UfdPIwB8j4zt+c2pzouaabdkZpAmfnUH/ob
         dnaqo272CTNsNhVyDxT708rEBZUcZ9Ha5lFT/qKuxcjYhnUituLKRU1YkwVWZ6Sn9uzG
         1SI1lQcwzVPJ7T5I0Wh7XOBKpsZnt1IgP2BHSQIS4Jbr56c9yjngHGO0d79dCqVKQ4Cl
         Bcz3VfDk1q+7bwjd02K/72FsvFDbFS5ro3hGtOl/z+2kscY5HfttiSmhrB9D0xTNOzwV
         uoaw==
X-Gm-Message-State: AOAM531WXxXuUqqgDrMDx2lix4xqA+Dp3U/SNZcUrjbgp0vd3CfjeWcC
        H8yGCn7Oa3wpc5j4Ouw3pT4MWo62jO/sGA==
X-Google-Smtp-Source: ABdhPJz11NQ8k8O3sx0w8Jmw/mT7h0gCT45pHlT7hh3N0P78+0UiDdOgcHDso4OmHjjXvEL1tZbORQ==
X-Received: by 2002:a63:3714:: with SMTP id e20mr10506241pga.50.1634324322967;
        Fri, 15 Oct 2021 11:58:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66sm5517324pfu.185.2021.10.15.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:58:42 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:58:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 43/45] KVM: SVM: Use a VMSA physical address
 variable for populating VMCB
Message-ID: <YWnPXmB4BkEO7Yrb@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-44-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820155918.7518-44-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 20, 2021, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> In preparation to support SEV-SNP AP Creation, use a variable that holds
> the VMSA physical address rather than converting the virtual address.
> This will allow SEV-SNP AP Creation to set the new physical address that
> will be used should the vCPU reset path be taken.

The use of "variable" in the changelog and shortlog is really confusing.  I read
them multiple times and still didn't fully understand the change until I sussed
out that the change is to track the PA in vcpu_svm separately from vcpu_svm.vmsa.

It's somewhat of a moot point though, because I think this can and should be
simplified.

In the SEV-ES case, svm->vmcb->control.vmsa_pa is always __pa(svm->vmsa).  And
in the SNP case, svm->vmcb->control.vmsa_pa defaults to __pa(svm->vmsa), but is
not changed on INIT.  Rather than do this crazy 3-way dance, simply don't write
svm->vmcb->control.vmsa_pa on INIT.  Then SNP can change it at will without having
an unnecessary and confusing field.

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1e8b26b93b4f..0bec0b71577e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2593,13 +2593,6 @@ void sev_es_init_vmcb(struct vcpu_svm *svm)
        svm->vmcb->control.nested_ctl |= SVM_NESTED_CTL_SEV_ES_ENABLE;
        svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;

-       /*
-        * An SEV-ES guest requires a VMSA area that is a separate from the
-        * VMCB page. Do not include the encryption mask on the VMSA physical
-        * address since hardware will access it using the guest key.
-        */
-       svm->vmcb->control.vmsa_pa = __pa(svm->vmsa);
-
        /* Can't intercept CR register access, HV can't modify CR registers */
        svm_clr_intercept(svm, INTERCEPT_CR0_READ);
        svm_clr_intercept(svm, INTERCEPT_CR4_READ);
@@ -2633,6 +2626,13 @@ void sev_es_init_vmcb(struct vcpu_svm *svm)

 void sev_es_vcpu_reset(struct vcpu_svm *svm)
 {
+       /*
+        * An SEV-ES guest requires a VMSA area that is a separate from the
+        * VMCB page. Do not include the encryption mask on the VMSA physical
+        * address since hardware will access it using the guest key.
+        */
+       svm->vmcb->control.vmsa_pa = __pa(svm->vmsa);
+
        /*
         * Set the GHCB MSR value as per the GHCB specification when emulating
         * vCPU RESET for an SEV-ES guest.

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

This needs your SoB.
