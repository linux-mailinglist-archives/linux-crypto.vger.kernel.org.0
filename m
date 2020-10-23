Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B0F297864
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Oct 2020 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbgJWUpt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Oct 2020 16:45:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41342 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbgJWUpt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Oct 2020 16:45:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kW3wO-0005cy-JB; Sat, 24 Oct 2020 07:45:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Oct 2020 07:45:36 +1100
Date:   Sat, 24 Oct 2020 07:45:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] crypto: Use memzero_explicit() for clearing state
Message-ID: <20201023204536.GB27708@gondor.apana.org.au>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-2-nivedita@alum.mit.edu>
 <20201022043633.GD857@sol.localdomain>
 <20201023153927.GA217686@rani.riverdale.lan>
 <20201023155604.GA3908702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023155604.GA3908702@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 23, 2020 at 08:56:04AM -0700, Eric Biggers wrote:
>
> When clearing memory because "it may be sensitive" rather than "it's needed for
> the code to behave correctly", I think it's best to use memzero_explicit() to
> make the intent clear, even if it seems that memset() is sufficient.  Also keep
> in mind that support for compiling the kernel with LTO (link-time optimization)
> is being worked on (and some people already do it), which results in more code
> being optimized out.

The rule up until now has been that we only use memzero_explicit for
stack variables.  At this point please don't convert anything else
as it will cause too much churn.

If LTO did arrive we should do a global conversion.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
