Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81B589B7B
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Aug 2022 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiHDML2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Aug 2022 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDML1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Aug 2022 08:11:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4125E98;
        Thu,  4 Aug 2022 05:11:26 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4fa7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4fa7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A09BE1EC056A;
        Thu,  4 Aug 2022 14:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659615080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dnIT6BfnSCaKhEYKVBp/iA/Xm7t6NZGreWnaebbwv6k=;
        b=W0AeNaoVM6CH3GtewEuI+fIELWnyUWnbtPopu0teCfDVXAA+IY0af/WCp/fUXMNVQlR+TK
        T7iY6EHSMJ5d5w6FvIBUxFmeoZ0H7X7gmQt0AFqnck6ptA9thEH0t2Ga6yTQM2/CzR8WOk
        nJnFZXaVIpDqFzGDdrWHxjYY2fcrKx4=
Date:   Thu, 4 Aug 2022 14:11:16 +0200
From:   Borislav Petkov <bp@alien8.de>
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
Subject: Re: [PATCH Part2 v6 07/49] x86/sev: Invalid pages from direct map
 when adding it to RMP table
Message-ID: <Yuu3ZK+/hL+saV27@zn.tnic>
References: <cover.1655761627.git.ashish.kalra@amd.com>
 <243778c282cd55a554af9c11d2ecd3ff9ea6820f.1655761627.git.ashish.kalra@amd.com>
 <YuFvbm/Zck9Tr5pq@zn.tnic>
 <SN6PR12MB27676E6CEDF242F2D33CA2AB8E9A9@SN6PR12MB2767.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB27676E6CEDF242F2D33CA2AB8E9A9@SN6PR12MB2767.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 01, 2022 at 11:57:09PM +0000, Kalra, Ashish wrote:
> You mean set_memory_present() ?

Right, that.

We have set_memory_np() but set_memory_present(). Talk about
consistence... ;-\

> But again, calling set_direct_map_invalid_noflush() is easier to
> understand from the calling function's point of view as it correlates
> to the functionality of invalidating the page from kernel direct map ?

You mean, we prefer easy to understand to performance?

set_direct_map_invalid_noflush() means crap to me. I have to go look it
up - set memory P or NP is much clearer.

The patch which added those things you consider easier to understand is:

commit d253ca0c3865a8d9a8c01143cf20425e0be4d0ce
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date:   Thu Apr 25 17:11:34 2019 -0700

    x86/mm/cpa: Add set_direct_map_*() functions
    
    Add two new functions set_direct_map_default_noflush() and
    set_direct_map_invalid_noflush() for setting the direct map alias for the
    page to its default valid permissions and to an invalid state that cannot
    be cached in a TLB, respectively. These functions do not flush the TLB.

I don't see how this fits with your use case...

Also, your helpers are called restore_direct_map and
invalidate_direct_map. That's already explaining what this is supposed
to do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
