Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9199F3A423C
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Jun 2021 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFKMsW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Jun 2021 08:48:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50566 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhFKMsU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Jun 2021 08:48:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lrgYH-00037O-FJ; Fri, 11 Jun 2021 20:46:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lrgYG-0002P6-7b; Fri, 11 Jun 2021 20:46:20 +0800
Date:   Fri, 11 Jun 2021 20:46:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: x86/curve25519 - fix cpu feature checking logic
 in mod_exit
Message-ID: <20210611124620.GA9125@gondor.apana.org.au>
References: <20210603055341.24473-1-liuhangbin@gmail.com>
 <20210611072312.GE23016@gondor.apana.org.au>
 <CAHmME9qE=CAtNjTPTwapUf0eGALkwbL+qVGRi3F88J_sE2-1vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qE=CAtNjTPTwapUf0eGALkwbL+qVGRi3F88J_sE2-1vQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 11, 2021 at 12:07:43PM +0200, Jason A. Donenfeld wrote:
> Hi Herbert,
> 
> Is there a reason why in
> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/patch/?id=1b82435d17774f3eaab35dce239d354548aa9da2
> you didn't mark it with the Cc: stable@ line that I included above my
> Reviewed-by? Netdev no longer has their own stable process. Do you
> have something else in mind for this?

Hi Jason:

This patch has a Fixes header set and it'll be automatically pushed
to stable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
