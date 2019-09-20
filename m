Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33293B9092
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Sep 2019 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfITNXc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Sep 2019 09:23:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34640 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfITNXc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Sep 2019 09:23:32 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBIVj-0007oG-OP; Fri, 20 Sep 2019 22:59:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Sep 2019 22:59:40 +1000
Date:   Fri, 20 Sep 2019 22:59:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: talitos - fix missing break in switch statement
Message-ID: <20190920125940.GA23242@gondor.apana.org.au>
References: <20190909052952.GA32131@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909052952.GA32131@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 09, 2019 at 12:29:52AM -0500, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to case CRYPTO_ALG_TYPE_AHASH.
> 
> Fixes: aeb4c132f33d ("crypto: talitos - Convert to new AEAD interface")
> Cc: stable@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/crypto/talitos.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
