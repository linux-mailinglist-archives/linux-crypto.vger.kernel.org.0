Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E275E8A07
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Sep 2022 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiIXISn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 24 Sep 2022 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiIXISJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 24 Sep 2022 04:18:09 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57061131
        for <linux-crypto@vger.kernel.org>; Sat, 24 Sep 2022 01:16:49 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oc0L7-007wck-5k; Sat, 24 Sep 2022 18:16:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Sep 2022 16:16:45 +0800
Date:   Sat, 24 Sep 2022 16:16:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Harliman Liem <pliem@maxlinear.com>
Cc:     atenart@kernel.org, linux-crypto@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 1/2] crypto: inside_secure - Avoid dma map if size is
 zero
Message-ID: <Yy687arNycXkbXED@gondor.apana.org.au>
References: <c10f8274fafd4f6afe92d0a2716ec5a38ca02cc8.1663055663.git.pliem@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10f8274fafd4f6afe92d0a2716ec5a38ca02cc8.1663055663.git.pliem@maxlinear.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 13, 2022 at 04:03:47PM +0800, Peter Harliman Liem wrote:
> >From commit d03c54419274 ("dma-mapping: disallow .map_sg
> operations from returning zero on error"), dma_map_sg()
> produces warning if size is 0. This results in visible
> warnings if crypto length is zero.
> To avoid that, we avoid calling dma_map_sg if size is zero.
> 
> Signed-off-by: Peter Harliman Liem <pliem@maxlinear.com>
> ---
> v3:
>  Remove fixes tag
>  Add corresponding change for dma_unmap_sg
> v2:
>  Add fixes tag
> 
>  .../crypto/inside-secure/safexcel_cipher.c    | 44 +++++++++++++------
>  1 file changed, 31 insertions(+), 13 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
