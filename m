Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31779522661
	for <lists+linux-crypto@lfdr.de>; Tue, 10 May 2022 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiEJVdn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 May 2022 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiEJVdj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 May 2022 17:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00D42185CBF
        for <linux-crypto@vger.kernel.org>; Tue, 10 May 2022 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652218418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLGf+NuJ1hkzNkgtKj/5di7e25KMw+geo5HNi0Tx2nk=;
        b=IllTouDeDWyuuii3FEw/SFS7SbKUxuI/KRe6yxmzPM69f+BEphvzmS2hIA5dopj/KYSem2
        nOseFtDds5Zf5IIOlLVw/4wH3vsT8RJVGPNZNjymO7uX3ZT/G1EgA9h6SDaIyylfAySbp6
        5Bg4L92hvfvwwKCQi32PfLajPr6gK/A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-b7PtpWKfOjKPBMnmJBcyLQ-1; Tue, 10 May 2022 17:33:36 -0400
X-MC-Unique: b7PtpWKfOjKPBMnmJBcyLQ-1
Received: by mail-qk1-f198.google.com with SMTP id c84-20020a379a57000000b0069fcf83c373so281574qke.20
        for <linux-crypto@vger.kernel.org>; Tue, 10 May 2022 14:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=HLGf+NuJ1hkzNkgtKj/5di7e25KMw+geo5HNi0Tx2nk=;
        b=w3WlZbMaQJu0a9ez6vWXojT28xfQkWx55vDIxF6m8uMQT/k5wprNihIsAVcOx2ShB7
         nJJ6uCAQDAsySgqMJqdPhibjzWBLiN8tBn8vv/aWqMK6I/oT68ZWqjdyX7EhK/rU9N9n
         qV9fWO95eK351qDQjQ8SyHkOTNUpNCkpxxiccwQvAHuOdMvq9ONWLN9xiNIFU3nljNmN
         PrIOdXUPi82H+4625r6YgCuYkx7zII0x9atGSYGSjDwcjTGy9eC5EE2ogS3XmUaEiInO
         jiPoqmCoUogIqGsdZQSBlLYvuYIlCVjCCveI9f9A33tHsu4yuQahOs88eaRiZHdXZFIf
         smaA==
X-Gm-Message-State: AOAM531Ss2EuTrHazYWvmWfxgKNUMc2SoI8UIOAyMqBt90aZeIpuJBz1
        VRjF5z3Q2gf/ItHBPd3zoZ3G5HhTgwwGwA9nlQU/KsQUQ3xtYGPGMaTVTgGG6GVIfr2SILkjTv0
        V+/R/GUgBM33bqUSmdYOusaaS
X-Received: by 2002:ac8:5745:0:b0:2f3:e231:bc12 with SMTP id 5-20020ac85745000000b002f3e231bc12mr5525731qtx.291.1652218416254;
        Tue, 10 May 2022 14:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCqYVgaYDvYJ1YgN8Xi0ySx91V66DHix7zN4MtUt1dANUAWaEB9Mt7T3gVjhpX2VPgo7Umrw==
X-Received: by 2002:ac8:5745:0:b0:2f3:e231:bc12 with SMTP id 5-20020ac85745000000b002f3e231bc12mr5525702qtx.291.1652218416011;
        Tue, 10 May 2022 14:33:36 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id z21-20020ac87115000000b002f39b99f6adsm43257qto.71.2022.05.10.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:33:35 -0700 (PDT)
Message-ID: <5b63a8a37b415db66ffe6b660859e3900c054909.camel@redhat.com>
Subject: Re: is "premature next" a real world rng concern, or just an
 academic exercise?
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, dodis@cs.nyu.edu,
        tytso@mit.edu, nadiah@cs.ucsd.edu, noahsd@gmail.com,
        tessaro@cs.washington.edu, torvalds@linux-foundation.org,
        jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, "D. J. Bernstein" <djb@cr.yp.to>
Date:   Tue, 10 May 2022 17:33:34 -0400
In-Reply-To: <YnrGYMyEL8qPMRGt@zx2c4.com>
References: <YmlMGx6+uigkGiZ0@zx2c4.com> <Ym3ZM1P+uYYABtRm@mit.edu>
         <Ym5sICj5iBMn2w/E@zx2c4.com>
         <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
         <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
         <YnqDC25iR8mcL3XB@zx2c4.com> <20220510185123.80607.qmail@cr.yp.to>
         <YnrGYMyEL8qPMRGt@zx2c4.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2022-05-10 at 22:09 +0200, Jason A. Donenfeld wrote:
> For 5.19 (or at this point, more likely 5.20), there's a userspace
> notifier in store, maybe, if I can figure out how to do it right.
> There's a pretty bikesheddy thread here on what shape that interface
> should take: https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
> But basically there are some details about how an async interface should
> work, and what the virtual hardware future, if any, looks like for a
> memory mapped race-free polling interface. Plus some considerations on
> how much we should care etc.

Perhaps it might be simpler to add an "epoch" number or similar exposed
via something like a vDSO that proper user space implementations can
then check before returning numbers from PRNGs and will immediately
reseed from /dev/random if it ever changes (rare event).

It is much simpler to poll for this information in user space crypto
libraries than using notifications of any kind given libraries are
generally not in full control of what the process does.

This needs to be polled fast as well, because the whole point of
initializing a PRNG in the library is that asking /dev/urandom all the
time is too slow (due to context switches and syscall overhead), so
anything that would require a context switch in order to pull data from
the PRNG would not really fly.

Note that a generic "epoch" exposed via vDSO would be useful beyond
RNGs, as it would be usable by any other user space that needs to know
that "I have been cloned and I need to do something now" and would be
able to use it immediately w/o the kernel needing to grow any other
specific interface for it.

HTH.
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



