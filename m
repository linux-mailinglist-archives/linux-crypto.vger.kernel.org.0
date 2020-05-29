Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96941E7288
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2020 04:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbgE2CUP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 May 2020 22:20:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39476 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390679AbgE2CUO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 May 2020 22:20:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeUcz-0001zP-2z; Fri, 29 May 2020 12:20:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2020 12:20:09 +1000
Date:   Fri, 29 May 2020 12:20:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     sbuisson.ddn@gmail.com
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        Sebastien Buisson <sbuisson@whamcloud.com>
Subject: Re: [PATCH] crypto: add adler32 to CryptoAPI
Message-ID: <20200529022009.GA26969@gondor.apana.org.au>
References: <20200528170051.7361-1-sbuisson@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528170051.7361-1-sbuisson@whamcloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 28, 2020 at 07:00:51PM +0200, sbuisson.ddn@gmail.com wrote:
> From: Sebastien Buisson <sbuisson@whamcloud.com>
> 
> Add adler32 to CryptoAPI so that it can be used with the normal kernel
> API, and potentially accelerated if architecture-specific
> optimizations are available.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@whamcloud.com>
> ---
>  crypto/Kconfig        |   7 +
>  crypto/Makefile       |   1 +
>  crypto/adler32_zlib.c | 117 ++++++++++++++++
>  crypto/testmgr.c      |   7 +
>  crypto/testmgr.h      | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 494 insertions(+)
>  create mode 100644 crypto/adler32_zlib.c

Who is going to use this inside the kernel?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
