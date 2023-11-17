Return-Path: <linux-crypto+bounces-142-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A87EEC43
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 07:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354CC280C47
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE5D52F
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F50127
	for <linux-crypto@vger.kernel.org>; Thu, 16 Nov 2023 21:19:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3rGU-000XOX-SS; Fri, 17 Nov 2023 13:19:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 13:19:46 +0800
Date: Fri, 17 Nov 2023 13:19:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 4/8] crypto: skcipher - Add lskcipher
Message-ID: <ZVb38sHNJYJ9x0po@gondor.apana.org.au>
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
> Well, IV is *initialization vector*: a value that the algorithm uses as input.
> It shouldn't be overloaded to represent some internal intermediate state.  We
> already made this mistake with the iv vs. iv_out thing, which only ever got
> implemented by CBC and CTR, and people repeatedly get confused by.  So we know
> it technically works for those two algorithms, but not anything else.
> 
> With ChaCha, for example, it makes more sense to use 16-word state matrix as the
> intermediate state instead of the 4-word "IV".  (See chacha_crypt().)
> Especially for XChaCha, so that the HChaCha step doesn't need to be repeated.

Fair enough, but what's the point of keeping the internal state
across two lskcipher calls? The whole point of lskcipher is that the
input is linear and can be processed in one go.

With shash we must keep the internal state because the API operates
on the update/final model so we need multiple suboperations to finish
each hashing operation.

With ciphers we haven't traditionally done it that way.  Are you
thinking of extending lskcipher so that it is more like hashing, with
an explicit finalisation step?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

