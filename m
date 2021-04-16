Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED962361E99
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhDPL1W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:27:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53000 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235012AbhDPL1V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:27:21 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMcR-0003H7-3K; Fri, 16 Apr 2021 21:26:40 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:26:38 +1000
Date:   Fri, 16 Apr 2021 21:26:38 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - fix unmapping invalid dma
 address
Message-ID: <20210416112638.GA14703@gondor.apana.org.au>
References: <1618048157-6289-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618048157-6289-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 10, 2021 at 05:49:17PM +0800, Hui Tang wrote:
> Currently, an invalid dma address may be unmapped when calling
> 'xx_data_clr_all' in error path, so check dma address of sqe in/out
> whether it has been mapped before calling 'dma_free_coherent' or
> 'dma_unmap_single'.
> 
> An abnormal case is as follows:
> hpre_curve25519_compute_value
> 	-> hpre_curve25519_src_init
> 	-> hpre_curve25519_hw_data_clr_all
> 
> Fixes: a9214b0b6ed2(crypto: hisilicon - fix the check on dma address)
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

This triggers new sparse warnings.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
