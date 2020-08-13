Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8C24347D
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Aug 2020 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMHL4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Aug 2020 03:11:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55244 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHMHL4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Aug 2020 03:11:56 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k67Ou-0003gl-ES; Thu, 13 Aug 2020 17:11:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 13 Aug 2020 17:11:48 +1000
Date:   Thu, 13 Aug 2020 17:11:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-crypto@vger.kernel.org, Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v2] crypto: algif_aead - fix uninitialized ctx->init
Message-ID: <20200813071148.GA3894@gondor.apana.org.au>
References: <20200812125825.436733-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812125825.436733-1-omosnace@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 12, 2020 at 02:58:25PM +0200, Ondrej Mosnacek wrote:
> In skcipher_accept_parent_nokey() the whole af_alg_ctx structure is
> cleared by memset() after allocation, so add such memset() also to
> aead_accept_parent_nokey() so that the new "init" field is also
> initialized to zero. Without that the initial ctx->init checks might
> randomly return true and cause errors.
> 
> While there, also remove the redundant zero assignments in both
> functions.
> 
> Found via libkcapi testsuite.
> 
> Cc: Stephan Mueller <smueller@chronox.de>
> Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when ctx->more is zero")
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
> v2:
>  - intead add missing memset() to algif_aead and remove the redundant
>    zero assignments (suggested by Herbert)
> 
>  crypto/algif_aead.c     | 6 ------
>  crypto/algif_skcipher.c | 7 +------
>  2 files changed, 1 insertion(+), 12 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
