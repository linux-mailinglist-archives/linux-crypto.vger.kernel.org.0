Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953131B043F
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2020 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTIWu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Apr 2020 04:22:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42586 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIWu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Apr 2020 04:22:50 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jQRhN-0001i7-9Z; Mon, 20 Apr 2020 18:22:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 20 Apr 2020 18:22:37 +1000
Date:   Mon, 20 Apr 2020 18:22:37 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH] crypto: hisilicon - fix Kbuild warning
Message-ID: <20200420082237.GA22231@gondor.apana.org.au>
References: <1587107311-52310-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587107311-52310-1-git-send-email-tanshukun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 17, 2020 at 03:08:31PM +0800, Shukun Tan wrote:
> Add Kconfig dependency to fix kbuild warnings.
> 
> Fixes: 6c6dd580 ("crypto: hisilicon/qm - add controller reset interface")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
> ---
>  drivers/crypto/hisilicon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
