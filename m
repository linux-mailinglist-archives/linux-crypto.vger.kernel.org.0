Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31096B3DB2
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 12:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCJL1p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Mar 2023 06:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCJL1Z (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Mar 2023 06:27:25 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479ACD58B1
        for <linux-crypto@vger.kernel.org>; Fri, 10 Mar 2023 03:27:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paate-002Xw7-Tc; Fri, 10 Mar 2023 19:26:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:26:50 +0800
Date:   Fri, 10 Mar 2023 19:26:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 0/5] hwrng: meson: simplify driver
Message-ID: <ZAsT+mlr4ij69RNs@gondor.apana.org.au>
References: <26216f60-d9b9-f40c-2c2a-95b3fde6c3bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26216f60-d9b9-f40c-2c2a-95b3fde6c3bc@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Feb 18, 2023 at 09:54:25PM +0100, Heiner Kallweit wrote:
> This series simplifies the driver. No functional change intended.
> 
> Heiner Kallweit (5):
>   hwrng: meson: remove unused member of struct meson_rng_data
>   hwrng: meson: use devm_clk_get_optional_enabled
>   hwrng: meson: remove not needed call to platform_set_drvdata
>   hwrng: meson: use struct hw_random priv data
>   hwrng: meson: remove struct meson_rng_data
> 
>  drivers/char/hw_random/meson-rng.c | 59 +++++++++---------------------
>  1 file changed, 17 insertions(+), 42 deletions(-)
> 
> -- 
> 2.39.2

Patches 1-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
