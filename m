Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E457809F5
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Aug 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359078AbjHRKZK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Aug 2023 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359056AbjHRKYl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Aug 2023 06:24:41 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A92D65
        for <linux-crypto@vger.kernel.org>; Fri, 18 Aug 2023 03:24:40 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWweY-005Gcj-95; Fri, 18 Aug 2023 18:24:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 18:24:26 +0800
Date:   Fri, 18 Aug 2023 18:24:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     olivia@selenic.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH -next v2] hwrng: Remove duplicated include
Message-ID: <ZN9G2jR6QQFAH5gX@gondor.apana.org.au>
References: <20230810130043.19216-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810130043.19216-1-guozihua@huawei.com>
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

On Thu, Aug 10, 2023 at 09:00:43PM +0800, GUO Zihua wrote:
> Remove duplicated include of linux/random.h. Resolves checkincludes
> message. And adjust includes in alphabetical order.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> ---
> 
> v2:
>   Adjust incldues in alphabetical order as well.
> ---
>  drivers/char/hw_random/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
