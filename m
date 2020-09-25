Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C1278275
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgIYIQa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:16:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53356 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgIYIQa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:16:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLitu-0007Kk-Q2; Fri, 25 Sep 2020 18:16:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:16:18 +1000
Date:   Fri, 25 Sep 2020 18:16:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] crypto: hisilicon/qm - Convert to
 DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200925081617.GO6381@gondor.apana.org.au>
References: <20200918013113.82740-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918013113.82740-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 18, 2020 at 09:31:13AM +0800, Qinglang Miao wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
> v2: based on linux-next(20200917), and can be applied to
>     mainline cleanly now.
> 
>  drivers/crypto/hisilicon/qm.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
