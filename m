Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B26393DEB
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhE1Hbb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:31:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50404 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbhE1Hb1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:31:27 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWvj-0003q7-QY; Fri, 28 May 2021 15:29:15 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWvj-00022Z-LG; Fri, 28 May 2021 15:29:15 +0800
Date:   Fri, 28 May 2021 15:29:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - support address prefetching
Message-ID: <20210528072915.GR7392@gondor.apana.org.au>
References: <1621668604-14973-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621668604-14973-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, May 22, 2021 at 03:30:04PM +0800, Weili Qian wrote:
> From: Longfang Liu <liulongfang@huawei.com>
> 
> Kunpeng930 hardware supports address prefetching to improve performance
> before doing tasks in SVA scenario.
> 
> This patch enables this function in device initialization by writing
> hardware registers. In the process of reset, address prefetching is
> disabled to avoid the failure of interaction between accelerator device
> and SMMU.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 50 +++++++++++++++++++++++++++++++
>  drivers/crypto/hisilicon/qm.c             | 35 ++++++++++++++++++++++
>  drivers/crypto/hisilicon/qm.h             |  2 ++
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 45 ++++++++++++++++++++++++++++
>  drivers/crypto/hisilicon/zip/zip_main.c   | 50 +++++++++++++++++++++++++++++++
>  5 files changed, 182 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
