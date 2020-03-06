Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6934E17B3FD
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2020 02:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCFBvh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Mar 2020 20:51:37 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:46120 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFBvh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Mar 2020 20:51:37 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jA29E-0005sU-9Y; Fri, 06 Mar 2020 12:51:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Mar 2020 12:51:32 +1100
Date:   Fri, 6 Mar 2020 12:51:32 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH v2] crypto: hisilicon - qm depends on UACCE
Message-ID: <20200306015132.GI30653@gondor.apana.org.au>
References: <1582787548-28201-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582787548-28201-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 27, 2020 at 03:12:28PM +0800, Zhou Wang wrote:
> From: Hongbo Yao <yaohongbo@huawei.com>
> 
> If UACCE=m and CRYPTO_DEV_HISI_QM=y, the following error
> is seen while building qm.o:
> 
> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_init':
> (.text+0x23c6): undefined reference to `uacce_alloc'
> (.text+0x2474): undefined reference to `uacce_remove'
> (.text+0x286b): undefined reference to `uacce_remove'
> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_uninit':
> (.text+0x2918): undefined reference to `uacce_remove'
> make[1]: *** [vmlinux] Error 1
> make: *** [autoksyms_recursive] Error 2
> 
> This patch fixes the config dependency for QM and ZIP.
> 
> reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
