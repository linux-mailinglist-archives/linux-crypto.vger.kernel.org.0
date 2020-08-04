Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7974323B2AF
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHDCSQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 3 Aug 2020 22:18:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54370 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHDCSQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 3 Aug 2020 22:18:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k2mWo-0006YH-Ew; Tue, 04 Aug 2020 12:18:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Aug 2020 12:18:10 +1000
Date:   Tue, 4 Aug 2020 12:18:10 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Elena Petrova <lenaptr@google.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH v4] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200804021810.GA10584@gondor.apana.org.au>
References: <20200729154501.2461888-1-lenaptr@google.com>
 <20200731072338.GA17285@gondor.apana.org.au>
 <CABvBcwY-F6Euo2SAY6MKpT0KP7OtyswLhUmShPNPfB0qqL6heQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvBcwY-F6Euo2SAY6MKpT0KP7OtyswLhUmShPNPfB0qqL6heQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 03, 2020 at 03:48:02PM +0100, Elena Petrova wrote:
>
> sendmsg is used for "Additional Data" input, and unlike entropy, it
> could be useful outside of testing. But if you confirm it's not
> useful, then yes, I can decouple the testing parts.

Unless there is someone asking for it then I'd rather not export
it to user-space.

> Depends on the comment above, but otherwise, my only concern is that
> the testing variant of rng_recvmsg would be largely copy-pasted from
> the normal rng_recvmsg, apart from a few lines of lock/release and
> crypto_rng_generate/crypto_rng_get_bytes.

They could certainly share code through the use of functions.

Chers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
