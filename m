Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA3F3CF86F
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jul 2021 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhGTKOl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Jul 2021 06:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237810AbhGTKJP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Jul 2021 06:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626778191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcBvlM0PO1J96UyBHCfK10rZCKfHKQT2nt9cT4JhOkc=;
        b=Zs+oZxAIGVaza3actmYjaLOR1qXwJjBNtB9h92IjTdnp2G6I0O/Az6DIsarM40niEY0407
        fsGal3/ai/UUMnmr2NQgjq/xG96RQrfxL9718sTgn/HzD9teYBc/871TqVO6YFefiwi7X0
        aN4fV6kleVzG1vUYreCj99hgXzs5/rk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-n4N1gjaUMI2AKgTKHIGR8A-1; Tue, 20 Jul 2021 06:49:50 -0400
X-MC-Unique: n4N1gjaUMI2AKgTKHIGR8A-1
Received: by mail-ed1-f72.google.com with SMTP id j25-20020aa7ca590000b029039c88110440so10662701edt.15
        for <linux-crypto@vger.kernel.org>; Tue, 20 Jul 2021 03:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TcBvlM0PO1J96UyBHCfK10rZCKfHKQT2nt9cT4JhOkc=;
        b=gw4XeIln9hftVNkaYhmdBNr7OTiZUK8bLkF7bykwc497qhrxT0/cr/Pnuqz5RR4Q+7
         oTtsK4AUMbw5p7gmc5Jlic1lPR3HG2p3R+f141D14EJ2Bfzt/9ahev5KlWl6DQe912zm
         DI/vITtZC7ir10DboqV/2Nure7v7FNPoBztRjzJbOydVK7ZsPUDU3xs6eIrFTsTxByei
         3DGOOmONw/8t6UqLActbzqf60BG/lF7hg5iFeZ9qsk+WQvWUh5wcU2hK31eVsi09VmI9
         Jsq79ZEAv6blml/C9Yv7Xd1wmHHjNx6r9zCjeik+N893lVJytTbeCSHXJ8q1HI46FUDN
         y4sA==
X-Gm-Message-State: AOAM5336GkIbtKkuf1xJ9b2CMDBjCoHPFaFbCx9RXQ/Lg0o6/Qab7MTc
        Fdp5AzUazb7VgM4vu0IIdrMxMd1nbtsrG/QsLMwkriayl/uzajK5dMymBPHcl4NrK6DOsMxdTRK
        A6dwNxVwoR8TtAs5ffuHmtskJ
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr31809067ejz.151.1626778189287;
        Tue, 20 Jul 2021 03:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXHUaumf3OMlJJfhNbDCWjmzsvW/jhdU3wQzuyevW25yMPJY14KDyl1R/Rc9dW4c7kv+JjmA==
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr31809052ejz.151.1626778189116;
        Tue, 20 Jul 2021 03:49:49 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([93.56.160.10])
        by smtp.gmail.com with ESMTPSA id i10sm8964149edf.12.2021.07.20.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:49:48 -0700 (PDT)
Message-ID: <11ab4001f580a6b2c3cce959282259c1f9095f63.camel@redhat.com>
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
From:   Simo Sorce <simo@redhat.com>
To:     Hannes Reinecke <hare@suse.de>,
        Stephan Mueller <smueller@chronox.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Date:   Tue, 20 Jul 2021 06:49:47 -0400
In-Reply-To: <aac9448e-29e9-6d03-1077-148be3c10f50@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
         <2510347.locV8n3378@positron.chronox.de>
         <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
         <6538288.aohFRl0Q45@positron.chronox.de>
         <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
         <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
         <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
         <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
         <1eab1472-3b7b-307b-62ae-8bed39603b96@suse.de>
         <24d115c9b68ca98a3cf363e1cfcb961cc6b38069.camel@chronox.de>
         <aac9448e-29e9-6d03-1077-148be3c10f50@suse.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2021-07-20 at 12:14 +0200, Hannes Reinecke wrote:
> On 7/19/21 1:52 PM, Stephan Mueller wrote:
> > Am Montag, dem 19.07.2021 um 13:10 +0200 schrieb Hannes Reinecke:
> > > On 7/19/21 12:19 PM, Stephan Mueller wrote:
> > > > Am Montag, dem 19.07.2021 um 11:57 +0200 schrieb Hannes Reinecke:
> > > > > On 7/19/21 10:51 AM, Stephan Mueller wrote:
> [ .. ]
> > > > > > 
> > > > > > Thank you for clarifying that. It sounds to me that there is no
> > > > > > defined protocol (or if there, I would be wondering how the code would have
> > > > > > worked
> > > > > > with a different implementation). Would it make sense to first specify
> > > > > > a protocol for authentication and have it discussed? I personally think
> > > > > > it is a bit difficult to fully understand the protocol from the code and
> > > > > > discuss protocol-level items based on the code.
> > > > > > 
> > > > > Oh, the protocol _is_ specified:
> > > > > 
> > > > >  
> > > > > https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2_0-2021.06.02-Ratified-5.pdf
> > > > > 
> > > > > It's just that I have issues translating that spec onto what the kernel
> > > > > provides.
> > > > 
> > > > according to the naming conventions there in figures 447 and following:
> > > > 
> > > > - x and y: DH private key (kernel calls it secret set with dh_set_secret
> > > > or
> > > > encoded into param.key)
> > > > 
> > > 
> > > But that's were I got confused; one needs a private key here, but there
> > > is no obvious candidate for it. But reading it more closely I guess the
> > > private key is just a random number (cf the spec: g^y mod p, where y is
> > > a random number selected by the host that shall be at least 256 bits
> > > long). So I'll fix it up with the next round.
> > 
> > Here comes the crux: the kernel has an ECC private key generation function
> > ecdh_set_secret triggered with crypto_kpp_set_secret using a NULL key, but it
> > has no FFC-DH counterpart.
> > 
> > That said, generating a random number is the most obvious choice, but not the
> > right one.
> > 
> > The correct one would be following SP800-56A rev 3 and here either section
> > 5.6.1.1.3 or 5.6.1.1.4.
> > 
> Hmm. Okay. But after having read section 5.6.1.1.4, I still do have some
> questions.
> 
> Assume we will be using a bit length of 512 for FFDHE, then we will
> trivially pass Step 2 for all supported FFDHE groups (the maximum
> symmetric-equivalent strength for ffdhe8192 is 192 bits).

N = 512 is not a good choice, minimum length these days for DH should
be 2048 or more.

> From my understanding, the random number generator will fill out all
> available bytes in the string (and nothing more), so we trivially
> satisfy step 3 and 4.
> 
> And as q is always larger than the random number, step 6 reduces to
> 'if (c > 2^N - 2)',

Where is this coming from ?
It seem you assume M = 2^N but M = min(2^N, q)

The point here is to make sure the number X you return is:
0 < X < (q-1)

>  ie we just need to check if the random number is a
> string of 0xff characters. Which hardly is a random number at all, so
> it'll be impossible to get this.
> 
> Which then would mean that our 'x' is simply the random number + 1,

This is an artifact due to the random number being 0 <= c < 2^N - 1,
therefore 1 needs to be added to make sure you never return 0.

> which arguably is slightly pointless (one more than a random number is
> as random as the number itself), so I do feel justified with just
> returning a random number here.
> 
> Am I wrong with that reasoning?

Looks to me you are not accounting for the fact that N = 512 is too
small and a random number falling in the interval (q - 2) < X < 2^N is
unsuitable?

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




