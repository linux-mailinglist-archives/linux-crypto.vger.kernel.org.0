Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77CF316009
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBJHZ7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:25:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50332 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhBJHYs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:24:48 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jqr-0001IU-17; Wed, 10 Feb 2021 18:23:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:23:52 +1100
Date:   Wed, 10 Feb 2021 18:23:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: hisilicon - some updates to adapt Kunpeng930
Message-ID: <20210210072352.GK4493@gondor.apana.org.au>
References: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 04, 2021 at 04:59:32PM +0800, Hui Tang wrote:
> 1.Update clusters number for both Kunpeng920 and Kunpeng930.
> 2.Some bugfixs only on Kunpeng920, so added hardware version wrap.
> 3.Fix use of 'dma_map_single'.
> 4.Fix PASID on Kunpeng930.
> 
> Hui Tang (2):
>   crypto: hisilicon/hpre - adapt the number of clusters
>   crypto: hisilicon/hpre - tiny fix
> 
> Weili Qian (2):
>   crypto:hisilicon/qm - fix use of "dma_map_single"
>   crypto:hisilicon - PASID fixed on Kupeng 930
> 
>  drivers/crypto/hisilicon/hpre/hpre.h      |   8 ++-
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 100 +++++++++++++++++++-----------
>  drivers/crypto/hisilicon/qm.c             |  61 +++++++++++-------
>  drivers/crypto/hisilicon/qm.h             |   1 +
>  drivers/crypto/hisilicon/sec2/sec_main.c  |   2 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   |   2 +-
>  6 files changed, 110 insertions(+), 64 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
