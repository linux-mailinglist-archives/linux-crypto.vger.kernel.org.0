Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1211A54613B
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jun 2022 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348682AbiFJJPR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jun 2022 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347894AbiFJJOx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jun 2022 05:14:53 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32823C64E;
        Fri, 10 Jun 2022 02:14:26 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nzaiX-005MTC-7Y; Fri, 10 Jun 2022 19:14:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jun 2022 17:14:09 +0800
Date:   Fri, 10 Jun 2022 17:14:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ss - fix error codes in allocate_flows()
Message-ID: <YqMLYeOXpGc3fNUw@gondor.apana.org.au>
References: <YoUt+LNsM8qFZYgL@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUt+LNsM8qFZYgL@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 18, 2022 at 08:33:44PM +0300, Dan Carpenter wrote:
> These failure paths should return -ENOMEM.  Currently they return
> success.
> 
> Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
> Fixes: 8eec4563f152 ("crypto: sun8i-ss - do not allocate memory when handling hash requests")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
