Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5610679A
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVINm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 03:13:42 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43464 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVINl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 03:13:41 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY44S-0007hc-MT; Fri, 22 Nov 2019 16:13:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY44Q-0004u8-Ip; Fri, 22 Nov 2019 16:13:38 +0800
Date:   Fri, 22 Nov 2019 16:13:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH 2/3] s390/crypto: Rework on paes implementation
Message-ID: <20191122081338.6bdjevtyttpdzzwl@gondor.apana.org.au>
References: <20191113105523.8007-1-freude@linux.ibm.com>
 <20191113105523.8007-3-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113105523.8007-3-freude@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 13, 2019 at 11:55:22AM +0100, Harald Freudenberger wrote:
>
> @@ -129,6 +128,7 @@ static int ecb_paes_init(struct crypto_skcipher *tfm)
>  	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->kb.key = NULL;
> +	spin_lock_init(&ctx->pk_lock);

This makes no sense.  The context is per-tfm, and each tfm should
have a single key at any time.  The synchronisation of setkey vs.
crypto operations is left to the user of the tfm, not the
implementor.

So why do you need this spin lock at all?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
