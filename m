Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1926F6F1
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIRH27 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 03:28:59 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57612 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgIRH26 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 03:28:58 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kJApC-0003VY-BT; Fri, 18 Sep 2020 17:28:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Sep 2020 17:28:54 +1000
Date:   Fri, 18 Sep 2020 17:28:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pvanleeuwen@rambus.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net
Subject: Re: [PATCH] crypto: inside-secure - Prevent missing of processing
 errors
Message-ID: <20200918072854.GD23319@gondor.apana.org.au>
References: <1599545445-5716-1-git-send-email-pvanleeuwen@rambus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599545445-5716-1-git-send-email-pvanleeuwen@rambus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 08, 2020 at 08:10:45AM +0200, Pascal van Leeuwen wrote:
> On systems with coherence issues, packet processed could succeed while
> it should have failed, e.g. because of an authentication fail.
> This is because the driver would read stale status information that had
> all error bits initialised to zero = no error.
> Since this is potential a security risk, we want to prevent it from being
> a possibility at all. So initialize all error bits to error state, so
> that reading stale status information will always result in errors.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@rambus.com>
> ---
>  drivers/crypto/inside-secure/safexcel_ring.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
