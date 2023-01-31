Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305E6822AF
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Jan 2023 04:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAaDT0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Jan 2023 22:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAaDT0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Jan 2023 22:19:26 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D173A5EB
        for <linux-crypto@vger.kernel.org>; Mon, 30 Jan 2023 19:19:23 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMhB2-005rvu-S6; Tue, 31 Jan 2023 11:19:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 31 Jan 2023 11:19:20 +0800
Date:   Tue, 31 Jan 2023 11:19:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] crypto: arm64/aes-ccm - Rewrite skcipher walker loop
Message-ID: <Y9iIuEHsaU8PBuxR@gondor.apana.org.au>
References: <Y9eGyzZ+JAqRQvtm@gondor.apana.org.au>
 <CAMj1kXE55nxow37PEBWv8qTa8BcWwmwN2nwEwi1sQGTCkRsx9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE55nxow37PEBWv8qTa8BcWwmwN2nwEwi1sQGTCkRsx9Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 30, 2023 at 11:42:41AM +0100, Ard Biesheuvel wrote:
>
> > diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
> > index c4f14415f5f0..25cd3808ecbe 100644
> > --- a/arch/arm64/crypto/aes-ce-ccm-glue.c
> > +++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
> > @@ -161,43 +161,39 @@ static int ccm_encrypt(struct aead_request *req)
> >         memcpy(buf, req->iv, AES_BLOCK_SIZE);
> >
> >         err = skcipher_walk_aead_encrypt(&walk, req, false);
> > -       if (unlikely(err))
> > -               return err;
> >
> 
> Should we keep this? No point in carrying on, and calling
> ce_aes_ccm_final() and scatterwalk_map_and_copy() in this state is
> best avoided.

First of all I don't think there is any risk of information leaks
in this case.  We're simply hashing the associated data by itself
as if the message was zero-length.

So it's a question of doing unnecessary work on the error-path.
The Linux way is to optimise for the common case so adding a
short-circuit solely to improve the error case would seems to be
unnecessary.

For context the errors that we're expecting at this point are
memory allocation failures, not anything untoward in the input
data.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
