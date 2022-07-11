Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B456B3F0
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Jul 2022 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiGHIAM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Jul 2022 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGHIAL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Jul 2022 04:00:11 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937E65D7E
        for <linux-crypto@vger.kernel.org>; Fri,  8 Jul 2022 01:00:10 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9itw-00FrrO-EQ; Fri, 08 Jul 2022 17:59:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 15:59:48 +0800
Date:   Fri, 8 Jul 2022 15:59:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liang He <windhl@126.com>
Cc:     davem@davemloft.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] crypto: amcc: Hold the reference returned by
 of_find_compatible_node
Message-ID: <Ysfj9CC6sFqL9cMN@gondor.apana.org.au>
References: <20220630083657.206122-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630083657.206122-1-windhl@126.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 30, 2022 at 04:36:56PM +0800, Liang He wrote:
> In crypto4xx_probe(), we should hold the reference returned by
> of_find_compatible_node() and use it to call of_node_put to keep
>  refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
>  
>  v2: split v1 into two commits, use short coding format for 'np=xx;'
>  v1: fix bugs in two directories (amcc,nx) of crypto
> 
>  v1-link: https://lore.kernel.org/all/20220621073742.4081013-1-windhl@126.com/
> 
>  drivers/crypto/amcc/crypto4xx_core.c | 40 +++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
