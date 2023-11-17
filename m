Return-Path: <linux-crypto+bounces-164-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9927EF2CE
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EAC2811F9
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711230F83
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7465A6;
	Fri, 17 Nov 2023 03:23:59 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wwv-000dKl-1v; Fri, 17 Nov 2023 19:23:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 19:23:56 +0800
Date: Fri, 17 Nov 2023 19:23:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>, smueller@chronox.de,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drbg small fixes
Message-ID: <ZVdNTF/PSJ+QblPN@gondor.apana.org.au>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231030120517.39424-1-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030120517.39424-1-dimitri.ledkov@canonical.com>

On Mon, Oct 30, 2023 at 02:05:12PM +0200, Dimitri John Ledkov wrote:
> This is v2 update of the
> https://lore.kernel.org/linux-crypto/5821221.9qqs2JS0CK@tauon.chronox.de/T/#u
> patch series.
> 
> Added Review-by Stephan, and changed patch descriptions to drop Fixes:
> metadata and explicitely mention that backporting this patches to
> stable series will not bring any benefits per se (as they patch dead
> code, fips_enabled only code, that doesn't affect certification).
> 
> Dimitri John Ledkov (4):
>   crypto: drbg - ensure most preferred type is FIPS health checked
>   crypto: drbg - update FIPS CTR self-checks to aes256
>   crypto: drbg - ensure drbg hmac sha512 is used in FIPS selftests
>   crypto: drbg - Remove SHA1 from drbg
> 
>  crypto/drbg.c    | 40 +++++++++++++---------------------------
>  crypto/testmgr.c | 25 ++++---------------------
>  2 files changed, 17 insertions(+), 48 deletions(-)
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

