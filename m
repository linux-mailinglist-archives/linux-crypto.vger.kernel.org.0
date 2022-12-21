Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9036A6538FF
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Dec 2022 23:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLUWuR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 21 Dec 2022 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLUWuQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 21 Dec 2022 17:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B907422533
        for <linux-crypto@vger.kernel.org>; Wed, 21 Dec 2022 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671662968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x93bjXectChC3bGAT4/VH1LjHa7gigd0V1M4FXwPnRI=;
        b=cnxpnRcmDS1JACA1fozeKyTEv8PFtNVJhufoT0mv6y34sZ+9zaI3G7Odrj37OF59zaXh8i
        nOsxIGlZRDztnZ3Kmh5uuYaHlCXChDf7n1Y5vAPs2ZAcY/5xktS1/k12IURU8cS5mrWkcW
        BIHBQ37Hbdi7UDgN49AZ9uNokn5IR7Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-2TLA8J-BNyq_xqqZH_TX0Q-1; Wed, 21 Dec 2022 17:49:26 -0500
X-MC-Unique: 2TLA8J-BNyq_xqqZH_TX0Q-1
Received: by mail-qk1-f197.google.com with SMTP id q20-20020a05620a0d9400b006fcaa1eac9bso74720qkl.23
        for <linux-crypto@vger.kernel.org>; Wed, 21 Dec 2022 14:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x93bjXectChC3bGAT4/VH1LjHa7gigd0V1M4FXwPnRI=;
        b=seylw4AYwdM5nyAFztRdanqjaVabqZWJkpPtxFcWljkjEb1iazoKcW8Vny9G8mWUxY
         vP+IEBUjDJUT51C+1sziruVsN5RYSEpDSmH4D5/Xkn3tPfV7+MMF7I+ZY2OuZAnZnBWj
         w/pfAx04bFS4QLNhT6lZaiZbaqtoNalXX2sMrR2Y2ns2aRyfhvAgAv8VEPC4vL7b8pIU
         VMNcr/xOAeA74pwogGkRuv9WUn5OcYgn/bwWoDACRX7k+4gioJyNoLtCN0CuZ8kYolf3
         jwN41RuqReM3rKzwcgIi/Fg9ukP6/3V7udWtRXFd7NvuoSSHsQQ1He5Q2O7tc7rQn3R8
         pnPA==
X-Gm-Message-State: AFqh2koxKe3g/Zuu6R1kdvus6zRKnHFix32ODB29Ev9akS969bvtA40i
        wqn4bn8k84gJW74yY2iINKx9oB1aozG1U8WcdnIkRgfl2ff9di86RIpuai0y5zhC+3kbaJDiqS8
        5YmymZ9WaEXLXGpcw8w5xH1J4o2DFq4kLzZRKMUch
X-Received: by 2002:a05:622a:393:b0:3a5:2615:5698 with SMTP id j19-20020a05622a039300b003a526155698mr99038qtx.275.1671662966351;
        Wed, 21 Dec 2022 14:49:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEPBejw7tWeGEe7bWZix+g9hgQv/lB8tzg4S51hWHYQa7o6wf0ARWSUUJkWnHcidWVtWU3DGHKPaaKlTrl0S4=
X-Received: by 2002:a05:622a:393:b0:3a5:2615:5698 with SMTP id
 j19-20020a05622a039300b003a526155698mr99033qtx.275.1671662966140; Wed, 21 Dec
 2022 14:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20221108142025.13461-1-nstange@suse.de> <20221221152400.8515-1-vdronov@redhat.com>
 <Y6NwqFQqlszdheYZ@sol.localdomain>
In-Reply-To: <Y6NwqFQqlszdheYZ@sol.localdomain>
From:   Vladis Dronov <vdronov@redhat.com>
Date:   Wed, 21 Dec 2022 23:49:15 +0100
Message-ID: <CAMusb+ScLnBVJxZt8BkAKxDjEvqh85VZRhbhf=Q2zu0KRi2tbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Trivial set of FIPS 140-3 related changes
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     nstange@suse.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

On Wed, Dec 21, 2022 at 9:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Dec 21, 2022 at 04:24:00PM +0100, Vladis Dronov wrote:
> > Hi Nicolai, Robert, Herbert, all,
> >
> > I would like to revive this older upstream email thread. I would like
> > to address notes from reviewers (namely, Robert) by additional patches
> > so the whole patchset can be accepted. This should ease our future
> > kernel work re: FIPS.
> >
> > The below 2 patches address (I hope) both notes Robert and Herbert have
> > provided (thanks!). I hope the whole patchset can be accepted then.
> >
> > Logically my 2 patches should follow [PATCH 1/4] and be patches 2 and 3.
> > Herbert is it possible to reorder them when accepting?
> >
> > Thank you! and
> >
> > Best regards,
> > Vladis
>
> Please just resend the whole series, with the --base option to git format-patch
> used, so that reviewers don't have to try to piece it together.

Thank you, Eric, the patchset was resend with a proper ordering:

https://lore.kernel.org/linux-crypto/20221221224111.19254-1-vdronov@redhat.com/T/#t
with a subject: [PATCH 0/6] Trivial set of FIPS 140-3 related changes

Best regards,
Vladis

