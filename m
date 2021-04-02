Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB44352903
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Apr 2021 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDBJsF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Apr 2021 05:48:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33730 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbhDBJsF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Apr 2021 05:48:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGPG-0003Us-5B; Fri, 02 Apr 2021 20:47:59 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:47:57 +1100
Date:   Fri, 2 Apr 2021 20:47:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
        xuzaibo@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH] crypto: hisilicon - use the correct HiSilicon copyright
Message-ID: <20210402094757.GE24509@gondor.apana.org.au>
References: <1616748159-22049-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616748159-22049-1-git-send-email-fanghao11@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 26, 2021 at 04:42:39PM +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g,
> according to https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec/sec_algs.c | 2 +-
>  drivers/crypto/hisilicon/sec/sec_drv.c  | 6 +++---
>  drivers/crypto/hisilicon/sec/sec_drv.h  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
