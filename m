Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76C691BCF
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Feb 2023 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBJJqY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Feb 2023 04:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBJJqW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Feb 2023 04:46:22 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F5635BA
        for <linux-crypto@vger.kernel.org>; Fri, 10 Feb 2023 01:46:21 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQPyg-009c0p-3M; Fri, 10 Feb 2023 17:45:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Feb 2023 17:45:58 +0800
Date:   Fri, 10 Feb 2023 17:45:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] crypto: atmel-i2c: Drop unused id parameter from
 atmel_i2c_probe()
Message-ID: <Y+YSVm7B72Y7fGdq@gondor.apana.org.au>
References: <20230131081351.165235-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131081351.165235-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 31, 2023 at 09:13:51AM +0100, Uwe Kleine-K�nig wrote:
> id is unused in atmel_i2c_probe() and the callers have extra efforts to
> determine the right parameter. So drop the parameter simplifying both
> atmel_i2c_probe() and its callers.
> 
> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> just found a nice optimisation while grepping for something else in the
> tree ...
> 
> Best regards
> Uwe
> 
>  drivers/crypto/atmel-ecc.c     | 3 +--
>  drivers/crypto/atmel-i2c.c     | 2 +-
>  drivers/crypto/atmel-i2c.h     | 2 +-
>  drivers/crypto/atmel-sha204a.c | 3 +--
>  4 files changed, 4 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
