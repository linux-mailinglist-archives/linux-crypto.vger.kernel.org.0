Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024151E948
	for <lists+linux-crypto@lfdr.de>; Sat,  7 May 2022 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352775AbiEGS4D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 May 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiEGS4B (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 May 2022 14:56:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B46353;
        Sat,  7 May 2022 11:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A4B7B80BA3;
        Sat,  7 May 2022 18:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7B7C385A6;
        Sat,  7 May 2022 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651949530;
        bh=9z+0Uhzj5HvNSbWx5E2/P4ju5NxGmTVepjaKhY7U7aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hF3XHaR4bzcqjVTTDMGuwcsYwob+vCce124Wf0CpxQ9hf4H+qDXwA0bNai6fo+Nys
         SnyCvvIF0E5quKbHYFTBQpmzhh4FJcgHqMQn5m3BINdR7wofX/nk80XIlpGKEbVRsm
         B04vQpYiXuNJuDrE2nUUDopaeAFCQQPBcXKBB5tcwuVS9qyzZwYMprI/8aPHvuiZ/M
         3CdM5LYsmH3eQKfP/ghop8NOlv1Ajt3CM8/Rl4BZMYaTdgLE7o51PJ5xL/79FjFJVN
         x/XBjn0Al0JyjnHX6eVGzp/Elrmmph243QssvChVAzh8lcR6wm+tQ6A9l+KuGcVZz9
         qEgem64Y6kH9g==
Date:   Sat, 7 May 2022 11:52:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, vdronov@redhat.com, stable@vger.kernel.org,
        Adam Guerin <adam.guerin@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: [PATCH 07/12] crypto: qat - set to zero DH parameters before free
Message-ID: <Yna/2Iwdr8zcwi+q@sol.localdomain>
References: <20220506082327.21605-1-giovanni.cabiddu@intel.com>
 <20220506082327.21605-8-giovanni.cabiddu@intel.com>
 <YnTpJkTXwmYyE9lQ@kroah.com>
 <YnTx7fs30scrrjmQ@silpixa00400314>
 <YnUzsAQd682pJjMt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnUzsAQd682pJjMt@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 06, 2022 at 04:41:52PM +0200, Greg KH wrote:
> On Fri, May 06, 2022 at 11:01:17AM +0100, Giovanni Cabiddu wrote:
> > On Fri, May 06, 2022 at 11:23:50AM +0200, Greg KH wrote:
> > > On Fri, May 06, 2022 at 09:23:22AM +0100, Giovanni Cabiddu wrote:
> > > > Set to zero the DH context buffers containing the DH key before they are
> > > > freed.
> > > 
> > > That says what, but not why.
> > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: c9839143ebbf ("crypto: qat - Add DH support")
> > > > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > > > Reviewed-by: Adam Guerin <adam.guerin@intel.com>
> > > > Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
> > > > ---
> > > >  drivers/crypto/qat/qat_common/qat_asym_algs.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
> > > > index d75eb77c9fb9..2fec89b8a188 100644
> > > > --- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
> > > > +++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
> > > > @@ -421,14 +421,17 @@ static int qat_dh_set_params(struct qat_dh_ctx *ctx, struct dh *params)
> > > >  static void qat_dh_clear_ctx(struct device *dev, struct qat_dh_ctx *ctx)
> > > >  {
> > > >  	if (ctx->g) {
> > > > +		memzero_explicit(ctx->g, ctx->p_size);
> > > >  		dma_free_coherent(dev, ctx->p_size, ctx->g, ctx->dma_g);
> > > 
> > > Why is a memset() not sufficient here?
> > Based on the previous conversation a memset() should be sufficient.
> > 
> > > And what is this solving?  Who would get this stale data?
> > This is to make sure the buffer containing sensitive data (i.e. a key)
> > is not leaked out by a subsequent allocation.
> 
> But as all sane distros have CONFIG_INIT_ON_ALLOC_DEFAULT_ON enabled,
> right?  That should handle any worries you have with secrets being on
> the heap.  But even then, are you trying to protect yourself against
> other kernel modules?  Think this through...
> 

This patch looks fine to me; it's always recommended to zero out crypto keys at
the end of their lifetime so that they can't be recovered from free memory if
system memory is compromised before the memory happens to be allocated and
overwritten again.  See the hundreds of existing callers of kfree_sensitive(),
which exist for exactly this reason.

Note that preventing the key from being "leaked out by a subsequent allocation"
is *not* the point, and thus CONFIG_INIT_ON_ALLOC_DEFAULT_ON is irrelevant.

- Eric
