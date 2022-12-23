Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C6654C7C
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Dec 2022 07:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWG37 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Dec 2022 01:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWG37 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Dec 2022 01:29:59 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F51705E
        for <linux-crypto@vger.kernel.org>; Thu, 22 Dec 2022 22:29:58 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p8bZ2-009jOx-49; Fri, 23 Dec 2022 14:29:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Dec 2022 14:29:52 +0800
Date:   Fri, 23 Dec 2022 14:29:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] crypto: caam - Prevent fortify error
Message-ID: <Y6VK4IJkHiawAbJz@gondor.apana.org.au>
References: <20221222162513.4021928-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222162513.4021928-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 22, 2022 at 05:25:13PM +0100, Uwe Kleine-König wrote:
> When compiling arm64 allmodconfig  with gcc 10.2.1 I get
> 
> 	drivers/crypto/caam/desc_constr.h: In function ‘append_data.constprop’:
> 	include/linux/fortify-string.h:57:29: error: argument 2 null where non-null expected [-Werror=nonnull]
> 
> Fix this by skipping the memcpy if data is NULL and add a BUG_ON instead
> that triggers on a problematic call that is now prevented to trigger.
> After data == NULL && len != 0 is known to be false, logically
> 
> 	if (len)
> 		memcpy(...)
> 
> could be enough to know that memcpy is not called with dest=NULL, but
> gcc doesn't seem smart enough for that conclusion. gcc 12 doesn't have a
> problem with the original code.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/crypto/caam/desc_constr.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Does this patch fix your problem?

https://lore.kernel.org/all/Y4mHjKXnF%2F4Pfw5I@gondor.apana.org.au/

If not please send me your kconfig file.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
