Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADE411A5D3
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfLKI2A (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 03:28:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49510 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLKI2A (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 03:28:00 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iexLj-0006yj-AT; Wed, 11 Dec 2019 16:27:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iexLi-0006ZC-Ad; Wed, 11 Dec 2019 16:27:58 +0800
Date:   Wed, 11 Dec 2019 16:27:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: api - Check spawn->alg under lock in
 crypto_drop_spawn
Message-ID: <20191211082758.ne35ulftvprmmsgk@gondor.apana.org.au>
References: <20191206055517.53o7xtpxdo2bx6qe@gondor.apana.org.au>
 <20191211033618.GG732@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211033618.GG732@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 10, 2019 at 07:36:18PM -0800, Eric Biggers wrote:
>
> Seems the Fixes tag is wrong.  It should be:
> 
> Fixes: 7ede5a5ba55a ("crypto: api - Fix crypto_drop_spawn crash on blank spawns")

Thanks, I'll change it when I apply this patch.  FWIW the patch
does need to all the way back to the original spawn commit but
of course you need to apply 7ede5a first before you can apply this
one.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
