Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979842972F6
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Oct 2020 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464361AbgJWP4H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Oct 2020 11:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373640AbgJWP4H (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Oct 2020 11:56:07 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E2E20878;
        Fri, 23 Oct 2020 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603468566;
        bh=mGaS8wWdgjA4/u1RLqkRCcaeFZJUeOXQKmXulx07Tlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7A4lwhcWJ1GQQ3YMv3Ky2grgIzKwvznwF5BfTalilVcl0UjuGynoNokjFWoY/WOe
         4MZfwlY2ByZYq/w555eYJptk+UeCLkyB3a308uZk/SfEoNwMh/IQXQ8VEaUx84vQ/P
         xsBwZG2DPUdG7iewISoxpGF+L66KWZuu+HxJB85E=
Date:   Fri, 23 Oct 2020 08:56:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] crypto: Use memzero_explicit() for clearing state
Message-ID: <20201023155604.GA3908702@gmail.com>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-2-nivedita@alum.mit.edu>
 <20201022043633.GD857@sol.localdomain>
 <20201023153927.GA217686@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023153927.GA217686@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 23, 2020 at 11:39:27AM -0400, Arvind Sankar wrote:
> On Wed, Oct 21, 2020 at 09:36:33PM -0700, Eric Biggers wrote:
> > On Tue, Oct 20, 2020 at 04:39:52PM -0400, Arvind Sankar wrote:
> > > Without the barrier_data() inside memzero_explicit(), the compiler may
> > > optimize away the state-clearing if it can tell that the state is not
> > > used afterwards. At least in lib/crypto/sha256.c:__sha256_final(), the
> > > function can get inlined into sha256(), in which case the memset is
> > > optimized away.
> > > 
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > 
> > Maybe get the one in arch/arm64/crypto/sha3-ce-glue.c too?
> > 
> > - Eric
> 
> Hm, there are a few more as well like that. But now I'm thinking it's
> only the generic sha256.c that may be problematic. The rest of them are
> in _final() functions which will be stored as function pointers in a
> structure, so there should be no risk of them getting optimized away?

When clearing memory because "it may be sensitive" rather than "it's needed for
the code to behave correctly", I think it's best to use memzero_explicit() to
make the intent clear, even if it seems that memset() is sufficient.  Also keep
in mind that support for compiling the kernel with LTO (link-time optimization)
is being worked on (and some people already do it), which results in more code
being optimized out.

- Eric
