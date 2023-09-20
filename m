Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81267A71D5
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Sep 2023 07:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjITFVK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 Sep 2023 01:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjITFVJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:09 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750DAF;
        Tue, 19 Sep 2023 22:21:03 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qipdt-00GD2o-Ox; Wed, 20 Sep 2023 13:20:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Sep 2023 13:20:56 +0800
Date:   Wed, 20 Sep 2023 13:20:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hwrng: imx-rngc - adjust the timeouts
Message-ID: <ZQqBOEufgrb9uxF0@gondor.apana.org.au>
References: <20230912143117.55965-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912143117.55965-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 12, 2023 at 04:31:16PM +0200, Martin Kaiser wrote:
> Set the timeouts for selftest and initial seed to approx. three times the
> maximum possible duration.
> 
> This replaces the series "hwrng: imx-rngc - use polling instead of interrupt".
> 
> Martin Kaiser (2):
>   hwrng: imx-rngc - reasonable timeout for selftest
>   hwrng: imx-rngc - reasonable timeout for initial seed
> 
>  drivers/char/hw_random/imx-rngc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
