Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C524B5A9A15
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Sep 2022 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiIAOX5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 1 Sep 2022 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiIAOXl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 1 Sep 2022 10:23:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDC72FDE
        for <linux-crypto@vger.kernel.org>; Thu,  1 Sep 2022 07:23:15 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 435203F495
        for <linux-crypto@vger.kernel.org>; Thu,  1 Sep 2022 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662042192;
        bh=0pValQemCvGX1LEq88UuNr8omRZeEtwxwFj8CYGFUUk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tbxhzmPqBTixnRFsFnJM2I7Y6WYR3dBghMd+YxJPxOuuPjUkLweDKVzolAXPQvJEw
         X0/BGPLuDBjQuoSj1IEUVH0031lXFoQ9cNrVMSKHIFfuPALRkw2sozNj11PgSuEzZq
         wEXlCZBkn8BzhZHJjzv2FNMdWHPtnzbkyNvVg7mATDqvGQws8ZEYuyxWNaQ02Z+Yam
         aYW/HIHUjYleFbGPUmSKHGmW2PFTm70Mcl4V/1z8ZB0GIRoDXjh1cbmz/Zxkj6iLVX
         chlIZDxQrlZ3FJVnSY/qr0iBishbT2VFljxTyRGPbvDPkg6CECHu2Z6CydnAF5gGfV
         yd5r7nkLsMnPw==
Received: by mail-ed1-f70.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso11934057eda.17
        for <linux-crypto@vger.kernel.org>; Thu, 01 Sep 2022 07:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0pValQemCvGX1LEq88UuNr8omRZeEtwxwFj8CYGFUUk=;
        b=nOCmiX9Y5ym9l/qs+yAuElZzjSTvdKL8CWTUpOFZCdZHg/z5EsWl3xdGGu5n/piKIS
         BBzeRSnslZxTVil6mu26QxZRdlsR+kJqhDE2A5/Zki6nS/E2y4U4H7ZhT6Yf+hgl8W1H
         itYCTVQqRAWdEvXrbkU5BWtE1+Q8/0+MUK2txqUx56x0zoaUVv2Np4R6C3PoEkmZQPtp
         BcANe23JSOoKkUm7stIYb8QyJKJ6PVtaJ+O7RQjqXoN4qxdrn+l2todZrKwUpC6jQAg2
         8d+WSk/u0Me1gRb5b8sm2HuaxyN+vhcPyaywT073KgoPSRaMIa4YT8q69Z1s8WvBwr+p
         SzcQ==
X-Gm-Message-State: ACgBeo0qalPHG24kgva3PSHRoRRdaalyssDbhDC0r4Fx2ku81U3Za7Va
        A5yNIRqsj0kDjiLH4FaUdXVMtV9KE3ZwBiNJvEnCfmZEkG0z+E3SCGoGMBc/bo+sWl0C8aP1cuC
        iw8oq5adwGoTV57vfKHo1JQQd1pV9+pbpsO7RAB3yKx/ZyJ0xH1djFDBIfA==
X-Received: by 2002:a17:907:a40f:b0:730:c4ce:631c with SMTP id sg15-20020a170907a40f00b00730c4ce631cmr22980394ejc.362.1662042191768;
        Thu, 01 Sep 2022 07:23:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6dHZiBfcopnPXJIfA5GSHw2vUA5qpfnN2mvP2jawWAAaOlWxzZ7hqBDDEokKvraMfzduYbvBcwVBBAMcsW9dQ=
X-Received: by 2002:a17:907:a40f:b0:730:c4ce:631c with SMTP id
 sg15-20020a170907a40f00b00730c4ce631cmr22980376ejc.362.1662042191485; Thu, 01
 Sep 2022 07:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220901021628.1130985-1-koba.ko@canonical.com>
 <a15ab3e6-249d-af48-b4d5-25840b72a933@amd.com> <CAJB-X+V-D0Es+5=KJQYdv6DKVK48jYzyU_4y6qvfY=H55y6oHQ@mail.gmail.com>
In-Reply-To: <CAJB-X+V-D0Es+5=KJQYdv6DKVK48jYzyU_4y6qvfY=H55y6oHQ@mail.gmail.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 1 Sep 2022 22:23:00 +0800
Message-ID: <CAJB-X+V+ZTxKt_hs_jXYhPkKhbK0brqByo6H536BD=PJf4kH=A@mail.gmail.com>
Subject: Re: [PATCH V2] crypto: ccp - Release dma channels before dmaengine unrgister
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 1, 2022 at 9:57 PM Koba Ko <koba.ko@canonical.com> wrote:
>
> On Thu, Sep 1, 2022 at 9:42 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 8/31/22 21:16, Koba Ko wrote:
> > > A warning is shown during shutdown,
> > >
> > > __dma_async_device_channel_unregister called while 2 clients hold a reference
> > > WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 __dma_async_device_channel_unregister+0xb7/0xc0
> > >
> > > Call dma_release_channel for occupied channles before dma_async_device_unregister.
> > >
> > > Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
> >
> > I can't find this Fixes: tag. I did find:
> >
> > 54cce8ecb925 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
> >
> > Not sure if Herbert can take care of that or if you'll need a v3.
>
> Sorry, it should be 54cce8ecb925("crypto: ccp -
> ccp_dmaengine_unregister release dma channels")
>
> >
> > With the change to the Fixes: tag
> >
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Should I add acked-by in V3 by myself? thanks

> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > ---
> > > V2: Fix the unused warning
> > > ---
> > >   drivers/crypto/ccp/ccp-dmaengine.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> > > index 7d4b4ad1db1f3..9f753cb4f5f18 100644
> > > --- a/drivers/crypto/ccp/ccp-dmaengine.c
> > > +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> > > @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
> > >       for (i = 0; i < ccp->cmd_q_count; i++) {
> > >               chan = ccp->ccp_dma_chan + i;
> > >               dma_chan = &chan->dma_chan;
> > > +
> > > +             if (dma_chan->client_count)
> > > +                     dma_release_channel(dma_chan);
> > > +
> > >               tasklet_kill(&chan->cleanup_tasklet);
> > >               list_del_rcu(&dma_chan->device_node);
> > >       }
> > > @@ -766,8 +770,8 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
> > >       if (!dmaengine)
> > >               return;
> > >
> > > -     dma_async_device_unregister(dma_dev);
> > >       ccp_dma_release(ccp);
> > > +     dma_async_device_unregister(dma_dev);
> > >
> > >       kmem_cache_destroy(ccp->dma_desc_cache);
> > >       kmem_cache_destroy(ccp->dma_cmd_cache);
