Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E555811A3FB
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 06:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfLKFlk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 00:41:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43578 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfLKFlk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 00:41:40 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieukk-0004Z2-QK; Wed, 11 Dec 2019 13:41:38 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieukk-0006Gv-DM; Wed, 11 Dec 2019 13:41:38 +0800
Date:   Wed, 11 Dec 2019 13:41:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: api - Fix race condition in crypto_spawn_alg
Message-ID: <20191211054138.2jny27pguo5kkghc@gondor.apana.org.au>
References: <20191207141501.ims4xdv46ltykbwy@gondor.apana.org.au>
 <E1idarb-0002qH-Va@gondobar>
 <20191211033828.GH732@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211033828.GH732@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 10, 2019 at 07:38:28PM -0800, Eric Biggers wrote:
> On Sat, Dec 07, 2019 at 10:15:15PM +0800, Herbert Xu wrote:
> > The function crypto_spawn_alg is racy because it drops the lock
> > before shooting the dying algorithm.  The algorithm could disappear
> > altogether before we shoot it.
> > 
> > This patch fixes it by moving the shooting into the locked section.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Does this need Fixes and Cc stable tags?

Fixes: 6bfd48096ff8 ("[CRYPTO] api: Added spawns")

I don't think we want this to go through stable right away.  Perhaps
a few cycles down the track it could be pushed to stable.  It's
certainly not an urgent problem.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
