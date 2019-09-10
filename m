Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0883EAE1E0
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2019 03:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbfIJBVt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 21:21:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33100 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfIJBVt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 21:21:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7Uqg-0000xr-4u; Tue, 10 Sep 2019 11:21:39 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Sep 2019 11:21:34 +1000
Date:   Tue, 10 Sep 2019 11:21:34 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Uri Shir <uri.shir@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccree - enable CTS support in AES-XTS
Message-ID: <20190910012134.GA24413@gondor.apana.org.au>
References: <1567929866-7089-1-git-send-email-uri.shir@arm.com>
 <CAKv+Gu9tVkES12fA0cauMhUV+EZ6HZZwMopJo47qE6j8hsFv4w@mail.gmail.com>
 <CAOtvUMfqyYNEa6N32eKn=cVaOyEezYeiA1o-6fTrjxrzVHM80Q@mail.gmail.com>
 <CAKv+Gu_c2rp6JT4dzy8a_ubd5Jorsnfc8ra3kfocAHmyMTLTNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_c2rp6JT4dzy8a_ubd5Jorsnfc8ra3kfocAHmyMTLTNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 09, 2019 at 03:38:02PM +0100, Ard Biesheuvel wrote:
>
> The blocksize is primarily used by the walking code to ensure that the
> input is a round multiple. In the XTS case, we can't blindly use the
> skcipher walk interface to go over the data anyway, since the last
> full block needs special handling as well.
> 
> So the answer is really that we had no reason to change it for the
> other drivers, and changing it here will trigger a failure in the
> testing code that compares against the generic implementations.

I think it should be changed because this is no different than
CTR where only the last block is allowed to be an arbitrary size.
Of course we should change everything in one go due to the testing
code.

This does raise the issue that we may be using blocksize in places
where we should be using chunksize instead, e.g., in algif_skcipher.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
