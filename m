Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16F5BABB5
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Sep 2022 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIPKyH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Sep 2022 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIPKxv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:51 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD714AFAC6
        for <linux-crypto@vger.kernel.org>; Fri, 16 Sep 2022 03:36:38 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oZ8i3-005GwM-1K; Fri, 16 Sep 2022 20:36:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Sep 2022 18:36:34 +0800
Date:   Fri, 16 Sep 2022 18:36:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Harliman Liem <pliem@maxlinear.com>
Cc:     atenart@kernel.org, linux-crypto@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v2] crypto: inside_secure - Change swab to swab32
Message-ID: <YyRRsoGIm/eg0b2X@gondor.apana.org.au>
References: <e25e423595ead12913c9d6444438d89d85270a37.1662430815.git.pliem@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25e423595ead12913c9d6444438d89d85270a37.1662430815.git.pliem@maxlinear.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 06, 2022 at 10:51:28AM +0800, Peter Harliman Liem wrote:
> The use of swab() is causing failures in 64-bit arch, as it
> translates to __swab64() instead of the intended __swab32().
> It eventually causes wrong results in xcbcmac & cmac algo.
> 
> Fixes: 78cf1c8bfcb8 ("crypto: inside-secure - Move ipad/opad into safexcel_context")
> Signed-off-by: Peter Harliman Liem <pliem@maxlinear.com>
> ---
> v2:
>  Add fixes tag
> 
>  drivers/crypto/inside-secure/safexcel_hash.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
