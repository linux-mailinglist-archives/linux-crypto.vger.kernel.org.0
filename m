Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F46EC8A
	for <lists+linux-crypto@lfdr.de>; Sat, 20 Jul 2019 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfGSWfJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Jul 2019 18:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfGSWfI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Jul 2019 18:35:08 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F27E2089C;
        Fri, 19 Jul 2019 22:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563575708;
        bh=gtuiGxAPm/qgMS5kxt+B9PJoMT8HsQJPbYl2+kU0dUQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=r5l78GLefutzMcejeQllY9YG1rwyHRB6ob/1Yedym5A2jMh7SdMptd3B8/7GBu1gq
         zi8ZnAaiYNOgk3q9nmCvO++aSbY4ipzlyNwNKrsM7iF+F0vdyAXTmUvyTHbEKQps2e
         /gcOJZWSi0XFvXDdRwJXtKxgZVTYN1Hkmm1nD6ks=
Date:   Fri, 19 Jul 2019 15:35:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: ghash
Message-ID: <20190719223505.GF1422@gmail.com>
Mail-Followup-To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <MN2PR20MB29737F1F60B3CBACBC4BD287CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190719161606.GA1422@gmail.com>
 <MN2PR20MB297309BE544695C1B7B3CB21CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190719195652.GC1422@gmail.com>
 <MN2PR20MB2973FF077218AB3C2DF2E4A0CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190719214811.GE1422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719214811.GE1422@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 19, 2019 at 02:48:11PM -0700, Eric Biggers wrote:
> > 
> > > So are you proposing that it be renamed?  Or are you proposing that a multi
> > > argument hashing API be added?  Or are you proposing that universal functions
> > > not be exposed through the crypto API?  What specifically is your constructive
> > > suggestion to improve things?
> > > 
> > I guess my constructive suggestion *for the future* would be to be more careful
> > with the naming. Don't give something a "known" name if it does not comply with
> > the matching specification. Renaming stuff now is probably counter-productive,
> > but putting some remarks somewhere (near the actual test vectors may work?)
> > about implementation x not actually being known entity X would be nice.
> > (Or even just some reference on where the test vectors came from!)
> > 
> 
> I think a comment at the top of ghash-generic.c would be helpful, similar to the
> one I wrote in nhpoly1305.c explaining that particular algorithm.
> 
> I'm surprised that you spent "days" debugging this, though.  Since the API gives
> you a single data stream, surely you would have had to check at some point how
> the two formal arguments (AAD, ciphertext) were encoded into it?  Were you just
> passing the whole thing as the AAD or something?  Also to reiterate, it actually
> does implement the GHASH algorithm correctly; the two formal parameters just
> have to be encoded into the single data stream in a particular way.
> 

Hmm, NIST SP 800-38D actually defines GHASH to take one argument, same as the
Linux version.  So even outside Linux, there is no consensus on whether "GHASH"
refers to the one argument or two argument versions.

I.e. even if we had an API where the AAD and ciphertext were passed in
separately, which is apparently what you'd prefer, people would complain that it
doesn't match the NIST standard version.

Of course, in the end the actually important thing is that everyone agrees on
GCM, not that they agree on GHASH.

- Eric
