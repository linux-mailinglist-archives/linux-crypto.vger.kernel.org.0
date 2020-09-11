Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0C265768
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 05:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgIKD0q (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 23:26:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58406 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgIKD0q (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 23:26:46 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGZhP-0005PW-Tx; Fri, 11 Sep 2020 13:26:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 13:26:07 +1000
Date:   Fri, 11 Sep 2020 13:26:07 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiaoliang Pang <dawning.pang@gmail.com>
Cc:     davem@davemloft.net, matthias.bgg@gmail.com, swboyd@chromium.org,
        yuehaibing@huawei.com, tianjia.zhang@linux.alibaba.com,
        ryder.lee@mediatek.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cypto: mediatek - fix leaks in mtk_desc_ring_alloc
Message-ID: <20200911032607.GA5096@gondor.apana.org.au>
References: <20200911013619.9809-1-dawning.pang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911013619.9809-1-dawning.pang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 11, 2020 at 09:36:19AM +0800, Xiaoliang Pang wrote:
>
> diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
> index 7e3ad085b5bd..ebb3bdef0dbe 100644
> --- a/drivers/crypto/mediatek/mtk-platform.c
> +++ b/drivers/crypto/mediatek/mtk-platform.c
> @@ -469,13 +469,13 @@ static int mtk_desc_ring_alloc(struct mtk_cryp *cryp)
>  	return 0;
>  
>  err_cleanup:
> -	for (; i--; ) {
> +	do {
>  		dma_free_coherent(cryp->dev, MTK_DESC_RING_SZ,
>  				  ring[i]->res_base, ring[i]->res_dma);
>  		dma_free_coherent(cryp->dev, MTK_DESC_RING_SZ,
>  				  ring[i]->cmd_base, ring[i]->cmd_dma);
>  		kfree(ring[i]);
> -	}
> +	}while(i--);

Please add spaces before and after while.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
