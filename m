Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522C31EDBC7
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2020 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFDDjj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 23:39:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35698 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgFDDjj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 23:39:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jggis-0000jQ-Bm; Thu, 04 Jun 2020 13:39:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2020 13:39:18 +1000
Date:   Thu, 4 Jun 2020 13:39:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     =?iso-8859-1?Q?=A0Greg_Kroah-Hartman=A0?= 
        <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?=A0Jonathan_Cameron=A0?= 
        <Jonathan.Cameron@huawei.com>,
        =?iso-8859-1?Q?=A0wangzhou1=A0?= <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
Message-ID: <20200604033918.GA2286@gondor.apana.org.au>
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 04, 2020 at 11:32:04AM +0800, Zhangfei Gao wrote:
> Use strlcpy to fix the warning
> warning: 'strncpy' specified bound 64 equals destination size
>          [-Wstringop-truncation]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/crypto/hisilicon/qm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index f795fb5..224f3e2 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1574,7 +1574,7 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
>  		.ops = &uacce_qm_ops,
>  	};
>  
> -	strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
> +	strlcpy(interface.name, pdev->driver->name, sizeof(interface.name));

Should this even allow truncation? Perhaps it'd be better to fail
in case of an overrun?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
