Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C27241458
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Aug 2020 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgHKA6B (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Aug 2020 20:58:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48788 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHKA6B (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Aug 2020 20:58:01 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k5Ibw-0006Lw-6Y; Tue, 11 Aug 2020 10:57:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Aug 2020 10:57:52 +1000
Date:   Tue, 11 Aug 2020 10:57:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 10/31] crypto: chacha-generic - Add support for
 chaining
Message-ID: <20200811005752.GA24901@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jt6-0006MN-FB@fornost.hmeau.com>
 <cdc28bf5-69bf-5915-db6c-92f287ef8f07@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdc28bf5-69bf-5915-db6c-92f287ef8f07@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 10, 2020 at 06:20:16PM +0300, Horia Geantă wrote:
> On 7/28/2020 10:19 AM, Herbert Xu wrote:
> > @@ -40,30 +39,41 @@ static int chacha_stream_xor(struct skcipher_request *req,
> >  static int crypto_chacha_crypt(struct skcipher_request *req)
> >  {
> >  	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> > +	struct chacha_reqctx *rctx = skcipher_request_ctx(req);
> >  	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
> >  
> > -	return chacha_stream_xor(req, ctx, req->iv);
> > +	if (!rctx->init)
> > +		chacha_init_generic(rctx->state, ctx->key, req->iv);
> It would probably be better to rename "init" to "no_init" or "final".

This turns out to be broken so it'll disappear anyway.  It'll
be replaced with a request flag instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
