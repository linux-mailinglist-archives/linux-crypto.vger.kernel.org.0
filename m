Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16933241459
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Aug 2020 02:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgHKA7L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Aug 2020 20:59:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48798 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHKA7K (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Aug 2020 20:59:10 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k5Id6-0006MR-3x; Tue, 11 Aug 2020 10:59:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Aug 2020 10:59:04 +1000
Date:   Tue, 11 Aug 2020 10:59:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 19/31] crypto: caam - Remove rfc3686 implementations
Message-ID: <20200811005903.GB24901@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0JtR-0006Rx-Oq@fornost.hmeau.com>
 <92042403-0379-55ab-ccbc-4610555f0a93@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92042403-0379-55ab-ccbc-4610555f0a93@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 10, 2020 at 07:47:40PM +0300, Horia Geantă wrote:
>
> I would prefer keeping the caam rfc3686(ctr(aes)) implementation.
> It's almost cost-free when compared to ctr(aes), since:
> -there are no (accelerator-)external DMAs generated
> -shared descriptors are constructed at .setkey time
> -code complexity is manageable

The reason I'm removing it is because it doesn't support chaining.
We could keep it by adding chaining support which should be trivial
but it's something that I can't test.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
