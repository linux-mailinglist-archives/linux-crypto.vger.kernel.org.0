Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC31D315F6B
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 07:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBJGZp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 01:25:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49708 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhBJGZj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 01:25:39 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9ivP-0000Xa-IE; Wed, 10 Feb 2021 17:24:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 17:24:31 +1100
Date:   Wed, 10 Feb 2021 17:24:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jamie@jamieiles.com, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: picoxcell - convert sysfs sprintf/snprintf
 family to sysfs_emit
Message-ID: <20210210062431.GA8075@gondor.apana.org.au>
References: <1612423453-78809-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612423453-78809-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 04, 2021 at 03:24:13PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
>  ./drivers/crypto/picoxcell_crypto.c:1201:8-16: WARNING: use scnprintf
> or sprintf.
> 
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/crypto/picoxcell_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This driver no longer exists.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
