Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0938C1AA
	for <lists+linux-crypto@lfdr.de>; Fri, 21 May 2021 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhEUIYO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 04:24:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56076 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEUIYN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 04:24:13 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lk0Qf-00051X-Lp; Fri, 21 May 2021 16:22:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lk0Qf-0007WU-I1; Fri, 21 May 2021 16:22:45 +0800
Date:   Fri, 21 May 2021 16:22:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: hisilicon/hpre - fix unmapping invalid dma
 address
Message-ID: <20210521082245.af6x2lotbrfbkanu@gondor.apana.org.au>
References: <1620637375-39155-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620637375-39155-1-git-send-email-tanghui20@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 10, 2021 at 05:02:55PM +0800, Hui Tang wrote:
> Currently, an invalid dma address may be unmapped when calling
> 'xx_data_clr_all' in error path, so check dma address of sqe in/out
> if initialized before calling 'dma_free_coherent' or 'dma_unmap_single'.
> 
> Fixes: a9214b0b6ed2(crypto: hisilicon - fix the check on dma address)
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
> v1 -> v2: Fix sparse warning.
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
