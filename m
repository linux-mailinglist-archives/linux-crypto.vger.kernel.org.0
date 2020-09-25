Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170EE27824D
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIYILn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:11:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53194 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgIYILj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:11:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLip3-000725-Lq; Fri, 25 Sep 2020 18:11:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:11:17 +1000
Date:   Fri, 25 Sep 2020 18:11:17 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiaoliang Pang <dawning.pang@gmail.com>
Cc:     davem@davemloft.net, matthias.bgg@gmail.com, swboyd@chromium.org,
        yuehaibing@huawei.com, tianjia.zhang@linux.alibaba.com,
        ryder.lee@mediatek.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] cypto: mediatek - fix leaks in mtk_desc_ring_alloc
Message-ID: <20200925081117.GB6381@gondor.apana.org.au>
References: <20200914030051.16956-1-dawning.pang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914030051.16956-1-dawning.pang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 14, 2020 at 11:00:51AM +0800, Xiaoliang Pang wrote:
> In the init loop, if an error occurs in function 'dma_alloc_coherent',
> then goto the err_cleanup section, after run i--,
> in the array ring, the struct mtk_ring with index i will not be released,
> causing memory leaks
> 
> Fixes: 785e5c616c849 ("crypto: mediatek - Add crypto driver support for some MediaTek chips")
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Xiaoliang Pang <dawning.pang@gmail.com>
> ---
>  drivers/crypto/mediatek/mtk-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
