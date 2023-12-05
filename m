Return-Path: <linux-crypto+bounces-560-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D46805089
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38561C20BAB
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AAC4F216
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 10:37:57 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D7D3
	for <linux-crypto@vger.kernel.org>; Tue,  5 Dec 2023 00:41:08 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rAQzH-0070gh-0o; Tue, 05 Dec 2023 16:41:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 Dec 2023 16:41:12 +0800
Date: Tue, 5 Dec 2023 16:41:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 4/8] crypto: skcipher - Add lskcipher
Message-ID: <ZW7iKEs+GNOrkvxf@gondor.apana.org.au>
References: <20230914082828.895403-1-herbert@gondor.apana.org.au>
 <20230914082828.895403-5-herbert@gondor.apana.org.au>
 <20230920062551.GB2739@sol.localdomain>
 <ZQvHUc9rd4ud2NCB@gondor.apana.org.au>
 <20230922031030.GB935@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922031030.GB935@sol.localdomain>

On Thu, Sep 21, 2023 at 08:10:30PM -0700, Eric Biggers wrote:
> 
> Yes, wide-block modes such as Adiantum and HCTR2 require multiple passes over
> the data.  As do SIV modes such as AES-GCM-SIV (though AES-GCM-SIV isn't yet
> supported by the kernel, and it would be an "aead", not an "skcipher").

Right, AEAD algorithms have never supported incremental processing,
as one of the first algorithms CCM required two-pass processing.

We could support incremental processing if we really wanted to.  It
would require a model where the user passes the data to the API twice
(or more if future algorithms requires so).  However, I see no
pressing need for this so I'm happy with just marking such algorithms
as unsupported with algif_skcipher for now.  There is also an
alternative of adding an AEAD-like mode fo algif_skcipher for these
algorithms but again I don't see the need to do this.

As such I'm going to add a field to indicate that adiantum and hctr2
cannot be used by algif_skcipher.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

