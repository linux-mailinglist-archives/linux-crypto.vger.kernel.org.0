Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18431211DA9
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Jul 2020 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgGBIAt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jul 2020 04:00:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38040 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgGBIAs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jul 2020 04:00:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jqu9F-00034t-Qx; Thu, 02 Jul 2020 18:00:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Jul 2020 18:00:45 +1000
Date:   Thu, 2 Jul 2020 18:00:45 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: Re: [PATCH] crypto: caam - Remove broken arc4 support
Message-ID: <20200702080045.GA4472@gondor.apana.org.au>
References: <20200702043648.GA21823@gondor.apana.org.au>
 <CAMj1kXFKkCSf06d4eKRZvdPzxCsVsYhOjRk221XpmLxvrrdKMw@mail.gmail.com>
 <CAMj1kXGEvumaCaQivdZjTFBMMctePWuvoEupENaUbjbdiqmr8Q@mail.gmail.com>
 <CAMj1kXGvMe_A_iQ43Pmygg9xaAM-RLy=_M=v+eg--8xNmv9P+w@mail.gmail.com>
 <20200702074533.GC4253@gondor.apana.org.au>
 <CAMj1kXHT9Puv2tC4_J2kVMjSF5es_9k+URVwsvao6TReS_5aJA@mail.gmail.com>
 <20200702075616.GA4394@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702075616.GA4394@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 02, 2020 at 05:56:16PM +1000, Herbert Xu wrote:
>
> For XTS I haven't decided whether to go this way or not.  If it
> does work out though we could even extend it to AEAD.

But there is clearly a need for this functionality, and it's
not just af_alg.  Have a look at net/sunrpc/auth_gss/gss_krb5_crypto.c,
it has three versions of the same crypto code (arc4, cts, and
everything else), in order to deal with continuing requests just
like algif_skcipher.

Perhaps at the end of this we could distill it down to just one.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
