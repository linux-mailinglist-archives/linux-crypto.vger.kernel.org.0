Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC88B64047B
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Dec 2022 11:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiLBKU6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Dec 2022 05:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiLBKUx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Dec 2022 05:20:53 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B94CCFFE
        for <linux-crypto@vger.kernel.org>; Fri,  2 Dec 2022 02:20:52 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p139w-003CKu-Ge; Fri, 02 Dec 2022 18:20:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:20:44 +0800
Date:   Fri, 2 Dec 2022 18:20:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     davem@davemloft.net, mgreer@animalcreek.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: omap-sham - Use pm_runtime_resume_and_get() in
 omap_sham_probe()
Message-ID: <Y4nRfKFjZT5JS6eU@gondor.apana.org.au>
References: <20221124064940.19845-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124064940.19845-1-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Nov 24, 2022 at 02:49:40PM +0800, Shang XiaoJing wrote:
> omap_sham_probe() calls pm_runtime_get_sync() and calls
> pm_runtime_put_sync() latter to put usage_counter. However,
> pm_runtime_get_sync() will increment usage_counter even it failed. Fix
> it by replacing it with pm_runtime_resume_and_get() to keep usage
> counter balanced.
> 
> Fixes: b359f034c8bf ("crypto: omap-sham - Convert to use pm_runtime API")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  drivers/crypto/omap-sham.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
