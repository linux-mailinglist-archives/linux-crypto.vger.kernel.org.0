Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D262766C5
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Sep 2020 05:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIXDME (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Sep 2020 23:12:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48790 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgIXDME (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Sep 2020 23:12:04 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLHfm-0000kW-NC; Thu, 24 Sep 2020 13:11:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 24 Sep 2020 13:11:54 +1000
Date:   Thu, 24 Sep 2020 13:11:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: inside-secure - Fix corruption on not fully
 coherent systems
Message-ID: <20200924031154.GA8282@gondor.apana.org.au>
References: <1599466784-23596-1-git-send-email-pvanleeuwen@rambus.com>
 <20200918065806.GA9698@gondor.apana.org.au>
 <CY4PR0401MB365283BF192613FD82EC0C12C33F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200918080127.GA24222@gondor.apana.org.au>
 <CY4PR0401MB365268AA17E35E5B55ABF7E6C33F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0401MB365268AA17E35E5B55ABF7E6C33F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 18, 2020 at 08:21:44AM +0000, Van Leeuwen, Pascal wrote:
>
> > Can this alignment exceed ARCH_DMA_MINALIGN? If not then the
> > macro CRYPTO_MINALIGN should cover it.
>
> I don't know. I'm not familiar with that macro and I have not been able to dig up any
> clear description on what it should convey.

I'm pretty sure it is because that's the reason kmalloc uses it
as its minimum as otherwise memory returned by kmalloc may cross
cache-lines.

> In any case, aligning to the worst cache cacheline for a CPU architecture may mean
> you end up wasting a lot of space on a system with a much smaller cacheline.

It won't waste any memory because kmalloc is already using it as
a minimum.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
