Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C52591C0
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Sep 2020 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIAOyx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Sep 2020 10:54:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38554 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgIALqR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Sep 2020 07:46:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kD4jP-0000Tt-2r; Tue, 01 Sep 2020 21:45:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Sep 2020 21:45:43 +1000
Date:   Tue, 1 Sep 2020 21:45:43 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: arm/aes-neonbs - Use generic cbc encryption
 path
Message-ID: <20200901114542.GA2441@gondor.apana.org.au>
References: <20200901062804.GA1533@gondor.apana.org.au>
 <CAMj1kXGDPTbhs_2FkvHROMmp+j7eON43r8muWgMGJpFQKpTjSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGDPTbhs_2FkvHROMmp+j7eON43r8muWgMGJpFQKpTjSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 01, 2020 at 11:47:03AM +0300, Ard Biesheuvel wrote:
> On Tue, 1 Sep 2020 at 09:28, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > Since commit b56f5cbc7e08ec7d31c42fc41e5247677f20b143 ("crypto:
> > arm/aes-neonbs - resolve fallback cipher at runtime") the CBC
> > encryption path in aes-neonbs is now identical to that obtained
> > through the cbc template.  This means that it can simply call
> > the generic cbc template instead of doing its own thing.
> >
> > This patch removes the custom encryption path and simply invokes
> > the generic cbc template.
> >
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> 
> Aren't we ending up with a cbc(aes) implementation that allocates a
> cbc(aes) implementation as a fallback?

Good catch, I meant to make the fallback sync only.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
