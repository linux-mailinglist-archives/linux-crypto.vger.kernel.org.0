Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E995864038F
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Dec 2022 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiLBJnv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Dec 2022 04:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLBJnu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Dec 2022 04:43:50 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BDEBE101
        for <linux-crypto@vger.kernel.org>; Fri,  2 Dec 2022 01:43:49 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12a9-003BPf-6L; Fri, 02 Dec 2022 17:43:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:43:45 +0800
Date:   Fri, 2 Dec 2022 17:43:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     olivia@selenic.com, mpm@selenic.com, mb@bu3sch.de,
        linux-crypto@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH] hwrng: amd - Fix PCI device refcount leak
Message-ID: <Y4nI0X0u01uiTCV0@gondor.apana.org.au>
References: <20221123093949.115579-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123093949.115579-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 23, 2022 at 05:39:49PM +0800, Xiongfeng Wang wrote:
>
> @@ -201,6 +207,8 @@ static void __exit amd_rng_mod_exit(void)
>  	release_region(priv->pmbase + PMBASE_OFFSET, PMBASE_SIZE);
>  
>  	kfree(priv);
> +
> +	pci_dev_put(priv->pcidev);

Oops, this doesn't look right.  Please fix and resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
