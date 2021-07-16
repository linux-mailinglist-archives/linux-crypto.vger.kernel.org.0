Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4B3CB3DD
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Jul 2021 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhGPIRP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Jul 2021 04:17:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51402 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236342AbhGPIRP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Jul 2021 04:17:15 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m4IzB-0005eJ-Ij; Fri, 16 Jul 2021 16:14:17 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m4Iz6-0000Xc-29; Fri, 16 Jul 2021 16:14:12 +0800
Date:   Fri, 16 Jul 2021 16:14:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     sachinp@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: DRBG - select SHA512
Message-ID: <20210716081411.GA2062@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304ee0376383d9ceecddbfd216c035215bbff861.camel@chronox.de>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Stephan Mueller <smueller@chronox.de> wrote:
> With the swtich to use HMAC(SHA-512) as the default DRBG type, the
> configuration must now also select SHA-512.
> 
> Fixes: 9b7b94683a9b "crypto: DRBG - switch to HMAC SHA512 DRBG as default
> DRBG"
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.com>
> ---
> crypto/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
