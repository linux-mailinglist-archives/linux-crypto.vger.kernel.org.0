Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA26E887
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jul 2019 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfGSQQK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Jul 2019 12:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfGSQQK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Jul 2019 12:16:10 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8A32184E;
        Fri, 19 Jul 2019 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563552969;
        bh=wJnT+B2QEGr39J2Vpdt4EBBxIgOGj7241XVFhdejpF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvbRyJ5L6Q5wW3atoi3O1XxLsnwxdZ21fv9Ek51X34DpvHvxN061j6AQhsS4/L0y/
         DTfCP3PtO3lFZKK1COl0Ea5OT6mnqOXK7bvNzXvSonmv0sEdZjm5ZXEfovODZwqRJf
         eYnw8TyopPJJ2KZG9Of2tEO/iASppRmV8mKQ0Ygs=
Date:   Fri, 19 Jul 2019 09:16:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: ghash
Message-ID: <20190719161606.GA1422@gmail.com>
Mail-Followup-To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <MN2PR20MB29737F1F60B3CBACBC4BD287CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB29737F1F60B3CBACBC4BD287CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 19, 2019 at 02:05:01PM +0000, Pascal Van Leeuwen wrote:
> Hi,
> 
> While implementing GHASH support for the inside-secure driver and wondering why I couldn't get 
> the test vectors to pass I have come to the conclusion that ghash-generic.c actually does *not*
> implement GHASH at all. It merely implements the underlying chained GF multiplication, which,
> I understand, is convenient as a building block for e.g. aes-gcm but is is NOT the full GHASH.
> Most importantly, it does NOT actually close the hash, so you can trivially add more data to the
> authenticated block (i.e. the resulting output cannot be used directly without external closing)
> 
> GHASH is defined as GHASH(H,A,C) whereby you do this chained GF multiply on a block of AAD
> data padded to 16 byte alignment with zeroes, followed by a block of ciphertext padded to 16
> byte alignment with zeroes, followed by a block that contains both AAD and cipher length.
> 
> See also https://en.wikipedia.org/wiki/Galois/Counter_Mode
> 
> Regards,
> Pascal van Leeuwen
> Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
> www.insidesecure.com
> 

Yes that's correct.  The hash APIs don't support multi-argument hashes, so
there's no natural way for it to be "full GHASH".  So it relies on the caller to
format the AAD and ciphertext into a single stream.  IMO it really should be
called something like "ghash_core".

Do you have some question or suggestion, or was this just an observation?

- Eric
