Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E2231836
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Jul 2020 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgG2Dia (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 23:38:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58090 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dia (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 23:38:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0cv9-0002BV-04; Wed, 29 Jul 2020 13:38:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 29 Jul 2020 13:38:22 +1000
Date:   Wed, 29 Jul 2020 13:38:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH 8/31] crypto: skcipher - Initialise requests to zero
Message-ID: <20200729033822.GA8440@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0Jt1-0006LB-SV@fornost.hmeau.com>
 <20200728171059.GA4053562@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171059.GA4053562@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 10:10:59AM -0700, Eric Biggers wrote:
>
> Does this really work?  Some users allocate memory themselves without using
> *_request_alloc().

Yes good point.  I will instead add a second request flag used to
indicate that we should retain the internal state.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
