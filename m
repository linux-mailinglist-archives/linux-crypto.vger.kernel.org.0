Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFA6C979
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jul 2019 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfGRGwc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 02:52:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35472 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfGRGwb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 02:52:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho0HD-00089G-Tk; Thu, 18 Jul 2019 14:52:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho0H9-0005lW-GX; Thu, 18 Jul 2019 14:52:23 +0800
Date:   Thu, 18 Jul 2019 14:52:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: xts fuzz testing and lack of ciphertext stealing support
Message-ID: <20190718065223.4xaefcwjoxvujntw@gondor.apana.org.au>
References: <VI1PR0402MB34858E4EF0ACA7CDB446FF5798CE0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190716221639.GA44406@gmail.com>
 <VI1PR0402MB34857BBB18C2BB8CBA2DEC7198C90@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190717172823.GA205944@gmail.com>
 <CAKv+Gu__offPaWvyURJr8v56ig58q-Deo16QhP26EJ32uf5m3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu__offPaWvyURJr8v56ig58q-Deo16QhP26EJ32uf5m3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 17, 2019 at 08:08:27PM +0200, Ard Biesheuvel wrote:
>
> Since the kernel does not support CTS for XTS any way, and since no
> AF_ALG users can portably rely on this, I agree with Eric that the
> only sensible way to address this is to disable this functionality in
> the driver.

But the whole point of XTS is that it supports sizes that are
not multiples of the block size.  So implementing it without
supporting ciphertext stealing is just wrong.

So let's fix the generic implementation rather than breaking
the caam driver.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
