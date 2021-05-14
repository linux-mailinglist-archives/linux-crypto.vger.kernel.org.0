Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA193804D8
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhENIHL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 04:07:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36258 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENIHL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 04:07:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhSpY-0007zl-Qd; Fri, 14 May 2021 16:05:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhSpV-00025g-Ux; Fri, 14 May 2021 16:05:53 +0800
Date:   Fri, 14 May 2021 16:05:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Mike Brooks <m@ib.tc>, Ard Biesheuvel <ardb@kernel.org>,
        Kestrel seventyfour <kestrelseventyfour@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: or should block size for xts.c set to 1 instead of AES block
 size?
Message-ID: <20210514080553.bogfwvq6vs6wvdch@gondor.apana.org.au>
References: <CAE9cyGTQZXW-6YsmHu3mGSHonTztBszqaYske7PKgz0pWHxQKA@mail.gmail.com>
 <CAMj1kXHOVRDAt7-C8UKi=5=MAgQ9kQz=HUtiuK_gt7ch_i950w@mail.gmail.com>
 <CALFqKjQVz7xyEZN0XWdGGHOfP4wRMsnU6amN11ege0XXbhQq8Q@mail.gmail.com>
 <YJrbhR/EruMOMHd9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJrbhR/EruMOMHd9@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 11, 2021 at 12:31:17PM -0700, Eric Biggers wrote:
>
> Well, the problem is that it isn't well defined what the cra_blocksize property
> actually means.  Depending on the algorithm, it can mean either the minimum
> input size, the required alignment of the input size, the exact input size that
> is required (in the case of block ciphers), or the input size that is required
> by the algorithm's internal compression function (in the case of hashes).
> 
> "xts" follows the convention of cra_blocksize meaning the "minimum input size",
> as do "cts" and "adiantum" which have the same constraints on input sizes as
> "xts".
> 
> So I'm not sure that changing cra_blocksize for xts to 1 would accomplish
> anything useful, other than confuse things further.

At this point we can't change the blocksize of cts/xts to 1 without
breaking af_alg because it needs to treat them differently than it
would for a stream cipher like ctr.

But to properly support af_alg on cts/xts we do need to do this.
I have a patch-set that adds the final chunk size to do exactly
that but I haven't had the time to finish it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
