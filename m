Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421FF78087C
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Aug 2023 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359177AbjHRJbg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Aug 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359214AbjHRJbP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:15 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F63C24
        for <linux-crypto@vger.kernel.org>; Fri, 18 Aug 2023 02:31:06 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWvof-005FTE-52; Fri, 18 Aug 2023 17:30:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 17:30:49 +0800
Date:   Fri, 18 Aug 2023 17:30:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     clabbe.montjoie@gmail.com, davem@davemloft.net, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH -next] crypto: allwinner - Remove unused function
 declarations
Message-ID: <ZN86SWHintk7Aga1@gondor.apana.org.au>
References: <20230809031443.39312-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809031443.39312-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 09, 2023 at 11:14:43AM +0800, Yue Haibing wrote:
> Commit 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
> declared but never implemented sun8i_ce_enqueue().
> Commit 56f6d5aee88d ("crypto: sun8i-ce - support hash algorithms")
> declared but never implemented sun8i_ce_hash().
> Commit f08fcced6d00 ("crypto: allwinner - Add sun8i-ss cryptographic offloader")
> declared but never implemented sun8i_ss_enqueue().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h | 3 ---
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 --
>  2 files changed, 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
