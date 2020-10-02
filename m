Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76752811C0
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Oct 2020 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgJBL4N (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Oct 2020 07:56:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49250 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbgJBL4J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Oct 2020 07:56:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJfD-0005Ws-Cv; Fri, 02 Oct 2020 21:55:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:55:51 +1000
Date:   Fri, 2 Oct 2020 21:55:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Matt Mackall <mpm@selenic.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] hwrng: iproc-rng200 - use semicolons rather than
 commas to separate statements
Message-ID: <20201002115551.GK1205@gondor.apana.org.au>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <1601233948-11629-7-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601233948-11629-7-git-send-email-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Sep 27, 2020 at 09:12:16PM +0200, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/char/hw_random/iproc-rng200.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
