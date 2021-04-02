Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D73529A9
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Apr 2021 12:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBKWf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Apr 2021 06:22:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33872 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBKWe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Apr 2021 06:22:34 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGwZ-00041L-U9; Fri, 02 Apr 2021 21:22:25 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 21:22:23 +1100
Date:   Fri, 2 Apr 2021 21:22:23 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     yumeng <yumeng18@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org, shenyang39@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/hpre - rsa key should not be empty
Message-ID: <20210402102223.GA24978@gondor.apana.org.au>
References: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
 <20210402071225.GA10423@gondor.apana.org.au>
 <7384e015-5514-d6b2-4215-beb1f4701adb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7384e015-5514-d6b2-4215-beb1f4701adb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 02, 2021 at 06:16:16PM +0800, yumeng wrote:
>
> I think it is not a real bug, and soft fallback setkey can always catch the
> error.
> But our original intention was to make it don't go to 'xxx_set_pub_key'
> when the key is null, and it can return an error earlier.
> But maybe it is not good.

It might make sense to check them twice if you were touching them
directly, e.g., poking inside the key.  However, it appears that
your driver simply palms off the key to rsa_helper.c which should
check the key/keylen too so I think there is no need for this patch
for now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
