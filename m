Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA62232DD
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jul 2020 07:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgGQFVx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jul 2020 01:21:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42760 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGQFVx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jul 2020 01:21:53 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jwIoV-0003XX-Rm; Fri, 17 Jul 2020 15:21:40 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jul 2020 15:21:39 +1000
Date:   Fri, 17 Jul 2020 15:21:39 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: xts: use memmove to avoid overlapped memory copy
Message-ID: <20200717052139.GB2045@gondor.apana.org.au>
References: <20200716152900.1709694-1-colin.king@canonical.com>
 <CAMj1kXEWyweZ0E3WHthEG9oiOpOS9UxtTB7xskAsF8FeinNg9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEWyweZ0E3WHthEG9oiOpOS9UxtTB7xskAsF8FeinNg9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 16, 2020 at 06:56:30PM +0300, Ard Biesheuvel wrote:
> On Thu, 16 Jul 2020 at 18:29, Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a memcpy that performs a potential overlapped memory copy
> > from source b to destination b + 1.  Fix this by using the safer
> > memmove instead.
> >
> > Addresses-Coverity: ("Overlapping buffer in memory copy")
> > Fixes: 8083b1bf8163 ("crypto: xts - add support for ciphertext stealing")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  crypto/xts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/crypto/xts.c b/crypto/xts.c
> > index 3565f3b863a6..fa3e6e7b7043 100644
> > --- a/crypto/xts.c
> > +++ b/crypto/xts.c
> > @@ -169,7 +169,7 @@ static int cts_final(struct skcipher_request *req,
> >                                       offset - XTS_BLOCK_SIZE);
> >
> >         scatterwalk_map_and_copy(b, rctx->tail, 0, XTS_BLOCK_SIZE, 0);
> > -       memcpy(b + 1, b, tail);
> > +       memmove(b + 1, b, tail);
> 
> This is a false positive: tail is guaranteed to be smaller than
> sizeof(*b), so memmove() is unnecessary here.
> 
> If changing to memcpy(&b[1], &b[0], tail) makes the warning go away, i
> am fine with it, but otherwise we should just leave it as is.

How about a comment perhaps?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
