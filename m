Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F95F04B6
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Sep 2022 08:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiI3GRX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Sep 2022 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiI3GRF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Sep 2022 02:17:05 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC59184829
        for <linux-crypto@vger.kernel.org>; Thu, 29 Sep 2022 23:17:03 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe9KM-00A5FN-C4; Fri, 30 Sep 2022 16:16:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 14:16:50 +0800
Date:   Fri, 30 Sep 2022 14:16:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     davem@davemloft.net, ardb@kernel.org, t-kristo@ti.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/3] A few cleanup patches for crypto
Message-ID: <YzaJ0i9olyIdpQt1@gondor.apana.org.au>
References: <20220923090823.509656-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923090823.509656-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 23, 2022 at 05:08:20PM +0800, Gaosheng Cui wrote:
> This series contains a few cleanup patches, to remove orphan
> inline functions and simplify some code. Thanks!
> 
> Gaosheng Cui (3):
>   crypto: bcm - Simplify obtain the name for cipher
>   crypto: aead - Remove unused inline functions from aead
>   crypto: scatterwalk - Remove unused inline function
>     scatterwalk_aligned()
> 
>  drivers/crypto/bcm/cipher.c    |  4 ++--
>  include/crypto/internal/aead.h | 25 -------------------------
>  include/crypto/scatterwalk.h   |  6 ------
>  3 files changed, 2 insertions(+), 33 deletions(-)
> 
> -- 
> 2.25.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
