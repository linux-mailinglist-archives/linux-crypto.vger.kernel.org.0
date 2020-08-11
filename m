Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACC24173A
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Aug 2020 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHKHeM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Aug 2020 03:34:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49686 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKHeM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Aug 2020 03:34:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k5OnL-0001eF-1X; Tue, 11 Aug 2020 17:34:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Aug 2020 17:34:03 +1000
Date:   Tue, 11 Aug 2020 17:34:03 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [v3 PATCH 19/31] crypto: caam - Remove rfc3686 implementations
Message-ID: <20200811073402.GA25873@gondor.apana.org.au>
References: <20200728071746.GA22352@gondor.apana.org.au>
 <E1k0JtR-0006Rx-Oq@fornost.hmeau.com>
 <92042403-0379-55ab-ccbc-4610555f0a93@nxp.com>
 <20200811005903.GB24901@gondor.apana.org.au>
 <f8fcd0d8-eabe-b27a-0c8b-a3cfb9f4ecef@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8fcd0d8-eabe-b27a-0c8b-a3cfb9f4ecef@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 11, 2020 at 10:32:28AM +0300, Horia Geantă wrote:
>
> Would it be possible in the meantime to set final_chunksize = -1,
> then I'd follow-up with chaining support?

I don't think there's much point.  IPsec is going to be using
the authenc entry anyway so this doesn't make that much of a
difference.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
