Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172A834A46B
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCZJas (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:30:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35346 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhCZJag (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:30:36 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPinW-0003TZ-Jj; Fri, 26 Mar 2021 20:30:31 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:30:30 +1100
Date:   Fri, 26 Mar 2021 20:30:30 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-crypto@vger.kernel.org, tangzihao1@hisilicon.com,
        huangdaode@huawei.com
Subject: Re: [PATCH] hwrng: core - convert sysfs sprintf/snprintf family to
 sysfs_emit
Message-ID: <20210326093030.GD12658@gondor.apana.org.au>
References: <1615898052-31279-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615898052-31279-1-git-send-email-f.fangjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 16, 2021 at 08:34:12PM +0800, Jay Fang wrote:
> From: Zihao Tang <tangzihao1@hisilicon.com>
> 
> Fix the following coccicheck warning:
> 
> drivers/char/hw_random/core.c:399:8-16: WARNING: use scnprintf or sprintf.
> 
> Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
