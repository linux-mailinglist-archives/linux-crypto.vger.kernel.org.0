Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6522D5910
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Dec 2020 12:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgLJLPU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 06:15:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57786 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733308AbgLJLPP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 06:15:15 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knJtz-00046Q-Td; Thu, 10 Dec 2020 22:14:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Dec 2020 22:14:27 +1100
Date:   Thu, 10 Dec 2020 22:14:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steve deRosier <derosier@cal-sierra.com>
Subject: Re: [PATCH v2] crypto: aesni - add ccm(aes) algorithm implementation
Message-ID: <20201210111427.GA28014@gondor.apana.org.au>
References: <CAMj1kXHb27ugTWuQZhPD0DvjtgYC8t_pj+igqK7dNfh+WsUS4w@mail.gmail.com>
 <20201201220431.GA32072@gondor.apana.org.au>
 <CAMj1kXGO+kbZ+2VmUQKxLYos2nR5vqZKjengxPxPjSXudG-zLw@mail.gmail.com>
 <20201201221628.GA32130@gondor.apana.org.au>
 <CAMj1kXFrLiHfv1S1AM=5pc1J9gWwZVuoGvmFoTT0-+oREoojTA@mail.gmail.com>
 <20201201231158.GA32274@gondor.apana.org.au>
 <CAMj1kXHwD5ktJTUrh8sndMY7P0kSFhgkGT66YJN1-ONUaU05-g@mail.gmail.com>
 <20201210024342.GA26428@gondor.apana.org.au>
 <e02fe07e-8cb6-f889-3228-60e4fabf4e40@candelatech.com>
 <CAMj1kXF05XZtyakdpLixpP9Lroy0D3_gEcY2SFbSshD8ERUU7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF05XZtyakdpLixpP9Lroy0D3_gEcY2SFbSshD8ERUU7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 10, 2020 at 08:30:47AM +0100, Ard Biesheuvel wrote:
>
> I would argue that these are orthogonal. My patch improves both the
> accelerated and the fallback path, given that the latter does not have
> to walk the input data twice anymore, and go through 3 layers of
> templates and the associated indirect calls for each 16 bytes of
> input.

As I told your before, your patch introduces a new model into aesni
that is different to every other algorithm there for the sole purpose
of catering for legacy hardware in a subsystem that refuses to do
the right thing.

That is not acceptable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
