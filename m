Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735AE18C5EE
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2020 04:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTDja (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Mar 2020 23:39:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33746 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgCTDja (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Mar 2020 23:39:30 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jF8VJ-0001KJ-2M; Fri, 20 Mar 2020 14:39:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Mar 2020 14:39:24 +1100
Date:   Fri, 20 Mar 2020 14:39:24 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: bool type cosmetics
Message-ID: <20200320033924.GA22682@gondor.apana.org.au>
References: <CAFXKEHahNKcjoU2Zd0XZBPvrSAW87xN5T5DR+rXzQ9uXH6zmPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXKEHahNKcjoU2Zd0XZBPvrSAW87xN5T5DR+rXzQ9uXH6zmPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Mar 15, 2020 at 06:42:07PM +0100, Lothar Rubusch wrote:
> >From d7e37962c530927952aa0f0601711fba75a3ddf2 Mon Sep 17 00:00:00 2001
> From: Lothar Rubusch <l.rubusch@gmail.com>
> Date: Sun, 15 Mar 2020 17:34:22 +0000
> Subject: [PATCH] crypto: bool type cosmetics
> 
> When working with bool values the true and false definitions should be used
> instead of 1 and 0.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  crypto/af_alg.c     | 10 +++++-----
>  crypto/algif_hash.c |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)

Sorry but your patch is corrupted.  Please fix your mailer and
resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
