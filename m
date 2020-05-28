Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A311E58BB
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2020 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1Hfb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 May 2020 03:35:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35318 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1Hfa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 May 2020 03:35:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeD4T-0000qe-BJ; Thu, 28 May 2020 17:35:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 May 2020 17:35:21 +1000
Date:   Thu, 28 May 2020 17:35:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH] crypto:hisilicon - fix driver compatibility issue with
 different versions of devices
Message-ID: <20200528073521.GC32600@gondor.apana.org.au>
References: <1589966390-37030-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589966390-37030-1-git-send-email-tanshukun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 20, 2020 at 05:19:50PM +0800, Shukun Tan wrote:
> From: Weili Qian <qianweili@huawei.com>
> 
> In order to be compatible with devices of different versions, V1 in the
> accelerator driver is now isolated, and other versions are the previous
> V2 processing flow.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 10 +---
>  drivers/crypto/hisilicon/qm.c             | 89 ++++++++++---------------------
>  drivers/crypto/hisilicon/qm.h             | 13 ++---
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 19 ++-----
>  drivers/crypto/hisilicon/zip/zip_main.c   | 20 ++-----
>  5 files changed, 39 insertions(+), 112 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
