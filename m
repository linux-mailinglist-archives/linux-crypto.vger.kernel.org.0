Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA92E354329
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Apr 2021 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhDEPHH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Apr 2021 11:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbhDEPHH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Apr 2021 11:07:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB6C06178C
        for <linux-crypto@vger.kernel.org>; Mon,  5 Apr 2021 08:06:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so7980485pjb.4
        for <linux-crypto@vger.kernel.org>; Mon, 05 Apr 2021 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nBPPSw2BQxZv3JDlctzmEukgrzYX1yJ+ZaCR4IZI8eQ=;
        b=NI+p1o0Q/CMmczfcVuoWxmf3Ag3le4FRp9YUh+wTgeNm7hm6t2SdT8SMhF/WhnqhDC
         1wyQSlMAxO1h7+9N1lc9VS8xbeqJc08aDb6XpltI6iXdgAVd0HdRaV5ia5X4EjAFxm/B
         LrUpy8vj7tP/zQs/Q5Ls670smqXpVWCu3FiSlgHfrNb1zfF6jiOQph4F6WiUIuroIjOS
         PDo1GG4V6wLhicRUHpO9Y2GYAcWInEE/+dsrVNfA4mlgiSC6ThfZgwsnOuI3DoPKRyT4
         /5M/RkaJM7acKMan4+n5DC2pg0N4qwFAYEw0TUq+jqElU0djXNimbQZC/OgHl+In/CiZ
         cGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nBPPSw2BQxZv3JDlctzmEukgrzYX1yJ+ZaCR4IZI8eQ=;
        b=UsTvHiwfWb3ljEq66Q1Qwk0MA6uomE8SG/pbvl4nUHVXIHwzXpH++Bd0hOduSo71rF
         QFir3mjaE0TtYDWHSD1SIzPrlCvSuA0gWS9t0J/5Zbm6ZlmRSivBJZF1wko7kzHhLGLD
         479QfjrrXASDRedAg8EfyJCKH9b8vrFiwehMKL0j+D9nhHKteo8ss/3FX26WZNBT3TXB
         FNOSEFivwjl5qyqrahaexHwV2e5lTFPUCjjjE+C+5CXeO3cZZH3Cq27cEp8YtE0NN8M4
         S+4XYPvRmIHkadJryPOLPgTQF1RDFz8YUQp12BWEJug75txaM5yGD3SU383LPLPilATs
         DjOA==
X-Gm-Message-State: AOAM530J+7kYVzRIVC5Knf+6rMrDeefArTje8JkGVq0OF45Iam279Pa2
        6cY30h0MAeTwNpBRyinhNkAO0A==
X-Google-Smtp-Source: ABdhPJxZ9W4I9YiyB5+kofac4gwyWUVlvz+/SY21ytvS8APwanRKo2/mW4wfgUZ3G4lS9DZXDflNYQ==
X-Received: by 2002:a17:902:988d:b029:e8:dd65:e2b5 with SMTP id s13-20020a170902988db02900e8dd65e2b5mr9896147plp.36.1617635218900;
        Mon, 05 Apr 2021 08:06:58 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id v13sm15319156pfu.54.2021.04.05.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 08:06:58 -0700 (PDT)
Date:   Mon, 5 Apr 2021 15:06:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/5] crypto: ccp: Play nice with vmalloc'd memory for SEV
 command structs
Message-ID: <YGsnjqFLoqXTrAHo@google.com>
References: <20210402233702.3291792-1-seanjc@google.com>
 <20210402233702.3291792-4-seanjc@google.com>
 <8ea3744f-fdf7-1704-2860-40c2b8fb47e1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ea3744f-fdf7-1704-2860-40c2b8fb47e1@csgroup.eu>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Apr 04, 2021, Christophe Leroy wrote:
> 
> Le 03/04/2021 � 01:37, Sean Christopherson a �crit�:
> > @@ -152,11 +153,21 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> >   	sev = psp->sev_data;
> >   	buf_len = sev_cmd_buffer_len(cmd);
> > -	if (WARN_ON_ONCE(!!data != !!buf_len))
> > +	if (WARN_ON_ONCE(!!__data != !!buf_len))
> >   		return -EINVAL;
> > -	if (WARN_ON_ONCE(data && is_vmalloc_addr(data)))
> > -		return -EINVAL;
> > +	if (__data && is_vmalloc_addr(__data)) {
> > +		/*
> > +		 * If the incoming buffer is virtually allocated, copy it to
> > +		 * the driver's scratch buffer as __pa() will not work for such
> > +		 * addresses, vmalloc_to_page() is not guaranteed to succeed,
> > +		 * and vmalloc'd data may not be physically contiguous.
> > +		 */
> > +		data = sev->cmd_buf;
> > +		memcpy(data, __data, buf_len);
> > +	} else {
> > +		data = __data;
> > +	}
> 
> I don't know how big commands are, but if they are small, it would probably
> be more efficient to inconditionnally copy them to the buffer rather then
> doing the test.

Brijesh, I assume SNP support will need to copy the commands unconditionally? If
yes, it probably makes sense to do so now and avoid vmalloc dependencies
completely.  And I think that would allow for the removal of status_cmd_buf and
init_cmd_buf, or is there another reason those dedicated buffers exist?

