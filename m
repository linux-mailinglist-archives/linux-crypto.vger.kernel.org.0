Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89416B3D9F
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 12:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCJLZM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Mar 2023 06:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCJLZM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Mar 2023 06:25:12 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780DBC6EB
        for <linux-crypto@vger.kernel.org>; Fri, 10 Mar 2023 03:25:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paarv-002XuH-Rf; Fri, 10 Mar 2023 19:25:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:25:03 +0800
Date:   Fri, 10 Mar 2023 19:25:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/3] hwrng: xgene - Some improvements
Message-ID: <ZAsTj2J/rX2cle68@gondor.apana.org.au>
References: <20230214162829.113148-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214162829.113148-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 14, 2023 at 05:28:26PM +0100, Uwe Kleine-K�nig wrote:
> Hello,
> 
> while working on the quest to make struct platform_driver::remove() return void
> I stumbled over the xgene-rng driver because it didn't return 0 in .remove().
> 
> Looking at it I found two other patch opportunities, here is the result.
> 
> I think the driver has some more problems:
> 
>  - device_init_wakeup() is only called after devm_hwrng_register(). After the
>    latter returns the respective callbacks can be called. Is the device already
>    in the right state before device_init_wakeup(..., 1)?
> 
>  - Similar problem on .remove(): device_init_wakeup(..., 0) is called before
>    hwrng_unregister() happens.
> 
>  - If there are two (or more) devices of that type, .probe() for the 2nd overwrites
>    xgene_rng_func.priv of the first one.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-K�nig (3):
>   hwrng: xgene - Simplify using dev_err_probe()
>   hwrng: xgene - Simplify using devm_clk_get_optional_enabled()
>   hwrng: xgene - Improve error reporting for problems during .remove()
> 
>  drivers/char/hw_random/xgene-rng.c | 44 ++++++++----------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
> 
> base-commit: e05dec85e78317f251eddd27e0357b2253d9dfc4
> -- 
> 2.39.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
