Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B9824AFB7
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgHTHPs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 03:15:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48934 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgHTHPs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 03:15:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k8enC-000612-KO; Thu, 20 Aug 2020 17:15:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 20 Aug 2020 17:15:22 +1000
Date:   Thu, 20 Aug 2020 17:15:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     trix@redhat.com
Cc:     davem@davemloft.net, smueller@chronox.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: drbg: check blocklen is non zero
Message-ID: <20200820071522.GA21511@gondor.apana.org.au>
References: <20200802171247.16558-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802171247.16558-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Aug 02, 2020 at 10:12:47AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> 
> crypto/drbg.c:441:40: warning: Division by zero
>         padlen = (inputlen + sizeof(L_N) + 1) % (drbg_blocklen(drbg));
>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> 
> When drbg_bocklen fails it returns 0.
> 
> 	if (drbg && drbg->core)
> 		return drbg->core->blocklen_bytes;
> 	return 0;

Yes but it can only fail if the drbg is not instantiated.  If
you're hitting the generate path with an uninstantiated drbg you've
got bigger problems than a divide by zero.

So how is this even possible?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
