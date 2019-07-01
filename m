Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBF2BA96
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfE0TPy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 15:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfE0TPx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 15:15:53 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550CE208C3;
        Mon, 27 May 2019 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558984553;
        bh=mIZEOAo28ilFQHB1s5QFB2cR7tMS7AafmOGavuYZsjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mxStrsN/czETnQglowYNZX7jKBmGiXIoGSvFk+sQr1WNBkxXoehQPm8r3Z4q3qtJl
         tKRecL4I93NsLnrE5xzkd7ykgO1o8edw1xkhdu1sMrKoHcmDjTkZh5QMMODpOe7+wC
         Lr3iA96eSE3RzvXTxIwNh3iu+v8IkVrXHfU6Lb3Q=
Date:   Mon, 27 May 2019 12:15:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Nikolay Borisov <nborisov@suse.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org, terrelln@fb.com,
        jthumshirn@suse.de
Subject: Re: [PATCH] crypto: xxhash - Implement xxhash support
Message-ID: <20190527191550.GC9394@sol.localdomain>
References: <20190527142810.31472-1-nborisov@suse.com>
 <1582734.iyJbpUVI2p@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582734.iyJbpUVI2p@tauon.chronox.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 27, 2019 at 05:06:53PM +0200, Stephan Mueller wrote:
> >  obj-$(CONFIG_CRYPTO_JITTERENTROPY) += jitterentropy_rng.o
> >  CFLAGS_jitterentropy.o = -O0
> >  jitterentropy_rng-y := jitterentropy.o jitterentropy-kcapi.o
> > diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> > index 8386038d67c7..322e906b6b6a 100644
> > --- a/crypto/testmgr.c
> > +++ b/crypto/testmgr.c
> > @@ -3879,6 +3879,13 @@ static const struct alg_test_desc alg_test_descs[] =
> > { .alg = "xts512(paes)",
> >  		.test = alg_test_null,
> >  		.fips_allowed = 1,
> > +	}, {
> > +		.alg = "xxhash64",
> > +		.test = alg_test_hash,
> > +		.fips_allowed = 1,
> 
> Why is this intended to be allowed in FIPS mode? This does not seem to be a 
> FIPS approved cipher.
> 

The other non-cryptographic algorithms like crc32, crc32c, crct10dif, zstd,
zlib-deflate, lzo, lzohc have the fips_allowed flag set too, the argument being
the FIPS restrictions don't apply to non-cryptographic algorithms.  I'm not very
familiar with FIPS, but I'd assume the same would be true for xxhash.

- Eric
