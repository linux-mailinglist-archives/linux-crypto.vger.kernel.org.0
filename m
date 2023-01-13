Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1557C669D99
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Jan 2023 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAMQXu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Jan 2023 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAMQXD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Jan 2023 11:23:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1466727AB
        for <linux-crypto@vger.kernel.org>; Fri, 13 Jan 2023 08:17:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so16540239pfe.2
        for <linux-crypto@vger.kernel.org>; Fri, 13 Jan 2023 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJeOsX7rqE6g0mVRSRHk5yMoUKpARELqW20Sskbk42I=;
        b=IQ4NJUEEXnGK+4TAeAUhUDbJE39b5ZeOp1OkVTltv8wQ+Xw/ab4dZJsfeAjbFFROcM
         t68CuD5zBGt1Hw9j0S/xUGh9mzMnECcJveODqqLxEdLoGsZtXfi33tXPnJw1uXZyMSBw
         U/4qJwAZBR1xOV8LlKyaG6WbPNsOmhhzRLLYzskRVN3UbSxyKeBJ7w/m1F9d4GyOgXdb
         3oGx9CtiHVr1s/ibzcusJma+EtZaQOARrir1OLiel8qyu0IWpN2bkwMxcTJXnpzafR9W
         iSJbpvsbPUKzW/e0ZnGsOQLM3n1qdnhrQ3HRe/qcqutpi1rYQdcy1s3ckztjiRSdYTUe
         WkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJeOsX7rqE6g0mVRSRHk5yMoUKpARELqW20Sskbk42I=;
        b=KAIAPD4YQJH1sAVp6u3/pqDbNRxuaGy5Td/2LtInu+CHr7A1V925YAKvioioymQVgQ
         Q2utDzOy1yM9sEK/sE9YytYgvugvXI3Pcd1vV/1w9haotstZZgZFK8gleg0Q4C8cQEoV
         UUXakpxPUQgs0BQ0aHqBZJ1bURdYJgLB4u2/AHqVYAqqbxisamab0vJqNPuTc/sdA4Kv
         GTyBx39G5RinLZl3XoXCI0c7OBcw1VM37tMNA8UIOXqZSfJ8xYKHXd/Kl6M37T/GhyhN
         RmbkaiEZxwVhLnBCgMdDOwg9lE9upzFNDc0KH6lhJjoZw/BHG6FlB2mRipl3winp82CR
         vWGA==
X-Gm-Message-State: AFqh2kqywYKx4zhGPnqxuBV4fXafi3FcSJDpvVgFHYdX0uV08H0IrqkR
        3QPwahw+l5ldlhYG3Ws/Ay8jjg==
X-Google-Smtp-Source: AMrXdXuXHVHcsxtYERQM+5pjJq9HKtQ+w/9gzosLvtojx6mjzh7D5LxDRnQ8J2KS7JQnIjIk3czM+g==
X-Received: by 2002:aa7:8148:0:b0:576:9252:d06 with SMTP id d8-20020aa78148000000b0057692520d06mr1269277pfn.0.1673626655147;
        Fri, 13 Jan 2023 08:17:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm1555298pfk.132.2023.01.13.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:17:34 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:17:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        harald@profian.com, Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH RFC v7 07/64] KVM: SEV: Handle KVM_HC_MAP_GPA_RANGE
 hypercall
Message-ID: <Y8GEGnmD90bySl8C@google.com>
References: <20221214194056.161492-1-michael.roth@amd.com>
 <20221214194056.161492-8-michael.roth@amd.com>
 <Y8GAGB73ZKElDYPI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GAGB73ZKElDYPI@zn.tnic>
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

On Fri, Jan 13, 2023, Borislav Petkov wrote:
> On Wed, Dec 14, 2022 at 01:39:59PM -0600, Michael Roth wrote:
> > From: Nikunj A Dadhania <nikunj@amd.com>
> > 
> > KVM_HC_MAP_GPA_RANGE hypercall is used by the SEV guest to notify a
> > change in the page encryption status to the hypervisor.
> > 
> > The hypercall exits to userspace with KVM_EXIT_HYPERCALL exit code,
> > currently this is used for explicit memory conversion between
> > shared/private for memfd based private memory.
> 
> So Tom and I spent a while to figure out what this is doing...
> 
> Please explain in more detail what that is. Like the hypercall gets ignored for
> memslots which cannot be private...?

Don't bother, just drop the patch.  It's perfectly legal for userspace to create
the private memslot in response to a guest request.
