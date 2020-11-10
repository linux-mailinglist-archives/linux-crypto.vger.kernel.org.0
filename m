Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59972AD736
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Nov 2020 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKJNMn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Nov 2020 08:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730357AbgKJNMd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Nov 2020 08:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605013952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
        b=Di+p8tHpuaV5rtMlatp24D6j8+WKmCUBtqz8yv0zCEdrS6sGXtBKp/ajiNQKnRgk1iVbBf
        EPgPhQ0oDcmNLweqKLA2uf1G287zKEdUoDcJ+SAJtNZ7ElvnOQlZ77m+OxtwtGg6hoPAvK
        H8JUZjK8UjW7EnlIU91t9XZBpHRi/X8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-AHssqmPvOC--iyU2pnHhSw-1; Tue, 10 Nov 2020 08:12:30 -0500
X-MC-Unique: AHssqmPvOC--iyU2pnHhSw-1
Received: by mail-qv1-f70.google.com with SMTP id a1so8038763qvj.3
        for <linux-crypto@vger.kernel.org>; Tue, 10 Nov 2020 05:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
        b=kQSCO3kvsopRPOaeky0nU4apqo9hSAmGYJWme2n1Uwt4PYL6yJ55nHTz3q2Bpk38JG
         8xd6tK0Z0fgxgPXaogGZeEzyw/POMQv6zoQg9Ep8feGfx9X+oM/fkZUr6IsMX8mIu7bz
         ohY8VHBzHyqKPeW+37ftBImHyqDfM7ahwK2Q3mu6ahN5dirbwABizQkgMzH9kaneJaXu
         1Mg/7+ya93QKPCnliRxBCbkiA4gz5mc9H+GiaPfGR8XixlzCRE88BvlmyKJe0SYnLPky
         8dNixVTj6QwEN3MdBWn9Pf9DO1feZvrtnc7Kk2nfjR1AkvnlXIgAQnsSwLdhzxOjzbOR
         3wAw==
X-Gm-Message-State: AOAM531zEQXNlJOhKjenVAcbA7N7lrA9q42sP+Po1WIOYbbpS3IJFg1q
        d1gYj3mz3WPoTWa6WH0ezZm2W3LxiUkErsA/1K84xpB7fsesHdL65msLbO+9HOvlU02FHbEaonw
        vSZ2/uYwUFA3CVyUpp+z+Bgeq
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787100qtb.168.1605013950438;
        Tue, 10 Nov 2020 05:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRnI1rUF5eW2rST1vImtIogpOlMRBum2fO0dVCe+zUlRqVIaRBqmVo31rjlhOk2kmW2Hr8dQ==
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787064qtb.168.1605013950178;
        Tue, 10 Nov 2020 05:12:30 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e8sm7658678qti.28.2020.11.10.05.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 05:12:29 -0800 (PST)
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, cocci <cocci@systeme.lip6.fr>
Cc:     linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20201027164255.1573301-1-trix@redhat.com>
 <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cc512954-2e1d-a165-f1f1-2c489fd6d3a9@redhat.com>
Date:   Tue, 10 Nov 2020 05:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


On 11/9/20 6:52 PM, Joe Perches wrote:
> On Tue, 2020-10-27 at 09:42 -0700, trix@redhat.com wrote:
>> This rfc will describe
>> An upcoming treewide cleanup.
>> How clang tooling was used to programatically do the clean up.
>> Solicit opinions on how to generally use clang tooling.
>>
>> The clang warning -Wextra-semi-stmt produces about 10k warnings.
>> Reviewing these, a subset of semicolon after a switch looks safe to
>> fix all the time.  An example problem
>>
>> void foo(int a) {
>>      switch(a) {
>>      	       case 1:
>> 	       ...
>>      }; <--- extra semicolon
>> }
>>
>> Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
>> These fixes will be the upcoming cleanup.
> coccinelle already does some of these.
>
> For instance: scripts/coccinelle/misc/semicolon.cocci
>
> Perhaps some tool coordination can be done here as
> coccinelle/checkpatch/clang/Lindent call all be used
> to do some facet or another of these cleanup issues.

Thanks for pointing this out.

I will take a look at it.

Tom

>
>

