Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7C7777F5
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Aug 2023 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHJMOz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Aug 2023 08:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJMOz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Aug 2023 08:14:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21843CE
        for <linux-crypto@vger.kernel.org>; Thu, 10 Aug 2023 05:14:53 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qU4Yh-001eMM-I9; Thu, 10 Aug 2023 20:14:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Aug 2023 20:14:31 +0800
Date:   Thu, 10 Aug 2023 20:14:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     olivia@selenic.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH -next] hwrng: Remove duplicated include
Message-ID: <ZNTUp37QJaGwt5d9@gondor.apana.org.au>
References: <20230810115858.24735-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810115858.24735-1-guozihua@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 10, 2023 at 07:58:58PM +0800, GUO Zihua wrote:
> Remove duplicated include of linux/random.h. Resolves checkincludes
> message.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  drivers/char/hw_random/core.c | 1 -
>  1 file changed, 1 deletion(-)

Please sort the header files alphabetically.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
