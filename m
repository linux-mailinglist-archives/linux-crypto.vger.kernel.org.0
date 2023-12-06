Return-Path: <linux-crypto+bounces-607-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8922806515
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Dec 2023 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA721F21683
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Dec 2023 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237C182B3
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Dec 2023 02:36:49 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4661D69
	for <linux-crypto@vger.kernel.org>; Tue,  5 Dec 2023 17:44:07 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rAgxG-007NYP-Dj; Wed, 06 Dec 2023 09:44:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Dec 2023 09:44:12 +0800
Date: Wed, 6 Dec 2023 09:44:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 4/8] crypto: skcipher - Add lskcipher
Message-ID: <ZW/R7EVE6Rg+w4Ct@gondor.apana.org.au>
References: <20230914082828.895403-1-herbert@gondor.apana.org.au>
 <20230914082828.895403-5-herbert@gondor.apana.org.au>
 <20230920062551.GB2739@sol.localdomain>
 <ZQvHUc9rd4ud2NCB@gondor.apana.org.au>
 <20230922031030.GB935@sol.localdomain>
 <ZW7iKEs+GNOrkvxf@gondor.apana.org.au>
 <20231205201757.GB1093@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205201757.GB1093@sol.localdomain>

On Tue, Dec 05, 2023 at 12:17:57PM -0800, Eric Biggers wrote:
>
> Note that 'cryptsetup benchmark' uses AF_ALG, and there are recommendations
> floating around the internet to use it to benchmark the various algorithms that
> can be used with dm-crypt, including Adiantum.  Perhaps it's a bit late to take
> away support for algorithms that are already supported?  AFAICS, algif_skcipher
> only splits up operations if userspace does something like write(8192) followed
> by read(4096), i.e. reading less than it wrote.  Why not just make
> algif_skcipher return an error in that case if the algorithm doesn't support it?

Yes that should be possible to implement.

Also I've changed my mind on the two-pass strategy.  I think
I am going to try to implement it at least internally in the
layer between skcipher and lskcihper.  Let me see whether this
is worth persuing or not for adiantum.

The reason is because after everything else switches over to
lskcipher, it'd be silly to have adiantum remain as skcipher
only.  But if adiantum moves over to lskcipher, then we'd need
to disable the skcipher version of it or linearise the input.

Both seem unpalatable and perhaps a two-pass approach won't
be that bad.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

