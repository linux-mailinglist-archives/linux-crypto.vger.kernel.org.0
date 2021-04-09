Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4B3596E8
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhDIHzs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 03:55:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52126 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhDIHzr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 03:55:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlz6-0006Q3-Kw; Fri, 09 Apr 2021 17:55:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:55:20 +1000
Date:   Fri, 9 Apr 2021 17:55:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     giovanni.cabiddu@intel.com, davem@davemloft.net,
        andriy.shevchenko@linux.intel.com, wojciech.ziemba@intel.com,
        fiona.trahe@intel.com, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat: Fix a double free in adf_create_ring
Message-ID: <20210409075520.GL31447@gondor.apana.org.au>
References: <20210402171348.3581-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402171348.3581-1-lyl2019@mail.ustc.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 02, 2021 at 10:13:48AM -0700, Lv Yunlong wrote:
> In adf_create_ring, if the callee adf_init_ring() failed, the callee will
> free the ring->base_addr by dma_free_coherent() and return -EFAULT. Then
> adf_create_ring will goto err and the ring->base_addr will be freed again
> in adf_cleanup_ring().
> 
> My patch sets ring->base_addr to NULL after the first freed to avoid the
> double free.
> 
> Fixes: a672a9dc872ec ("crypto: qat - Intel(R) QAT transport code")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/crypto/qat/qat_common/adf_transport.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
