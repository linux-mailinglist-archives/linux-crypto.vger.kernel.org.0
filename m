Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB18D859B
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Oct 2019 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJPBvs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Oct 2019 21:51:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58390 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfJPBvr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Oct 2019 21:51:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iKYTY-0004PM-JA; Wed, 16 Oct 2019 12:51:45 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Oct 2019 12:51:42 +1100
Date:   Wed, 16 Oct 2019 12:51:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] drivers,crypto/cavium: Fix barrier barrier usage after
 atomic_set()
Message-ID: <20191016015142.GA7389@gondor.apana.org.au>
References: <20191015161657.10760-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015161657.10760-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 15, 2019 at 09:16:57AM -0700, Davidlohr Bueso wrote:
> Because it is not a Rmw operation, atomic_set() is not serialized,
> and therefore the 'upgradable' smp_mb__after_atomic() call after
> the atomic_set() is completely bogus (not to mention the comment
> could also use some love, but that's a different matter).
> 
> This patch replaces these with smp_mb(), which seems like the
> original intent of when the code was written.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

So what does this actually synchronise against?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
