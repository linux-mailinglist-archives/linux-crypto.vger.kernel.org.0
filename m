Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008B58F841
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2019 03:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfHPBCg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 21:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHPBCg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 21:02:36 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 508A62089E;
        Fri, 16 Aug 2019 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565917355;
        bh=9/3990cgztYn0WP0j+SqEh7L0sgp7HYgybgtQs5Jyqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljn+MK4yC25FZWORSE5Qi54z9M3uGxotJRNus9Vjoh9oK/xXgpAf7UPwvvOdXfIA7
         VnbDStyxqhRfxBEFQUIa4w1W8IViw48gyviS0R2D2mGnvHhvJygvWDb7Ith6PsK8eZ
         ZuLl4+m2VSeHxgENBD+X/bdD6VeU4xuW8CPFq0LA=
Date:   Thu, 15 Aug 2019 18:02:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, gmazyland@gmail.com,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2] crypto: xts - add support for ciphertext stealing
Message-ID: <20190816010233.GA653@sol.localdomain>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, gmazyland@gmail.com,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <20190809171457.12400-1-ard.biesheuvel@linaro.org>
 <20190815120800.GI29355@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815120800.GI29355@gondor.apana.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 15, 2019 at 10:08:00PM +1000, Herbert Xu wrote:
> On Fri, Aug 09, 2019 at 08:14:57PM +0300, Ard Biesheuvel wrote:
> > Add support for the missing ciphertext stealing part of the XTS-AES
> > specification, which permits inputs of any size >= the block size.
> > 
> > Cc: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > Tested-by: Milan Broz <gmazyland@gmail.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > v2: fix scatterlist issue in async handling
> >     remove stale comment
> > 
> >  crypto/xts.c | 152 +++++++++++++++++---
> >  1 file changed, 132 insertions(+), 20 deletions(-)
> 
> Patch applied.  Thanks.
> -- 

I'm confused why this was applied as-is, since there are no test vectors for
this added yet.  Nor were any other XTS implementations updated yet, so now
users see inconsistent behavior, and all the XTS comparison fuzz tests fail.
What is the plan for addressing these?  I had assumed that as much as possible
would be fixed up at once.

- Eric
