Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADD31F44B
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Feb 2021 05:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSEC7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Feb 2021 23:02:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:41010 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSEC6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Feb 2021 23:02:58 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lCwzD-0000s7-Jq; Fri, 19 Feb 2021 15:01:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Feb 2021 15:01:47 +1100
Date:   Fri, 19 Feb 2021 15:01:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     yumeng <yumeng18@huawei.com>
Cc:     davem@davemloft.net, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, tudor.ambarus@microchip.com,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/9] crypto: hisilicon/hpre - add 'ECDH' algorithm
Message-ID: <20210219040147.GA2074@gondor.apana.org.au>
References: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
 <1612777137-51067-8-git-send-email-yumeng18@huawei.com>
 <20210210045756.GB7510@gondor.apana.org.au>
 <a92a1b89-75f2-e275-9a84-004072aadf66@huawei.com>
 <20210218200121.GA932@gondor.apana.org.au>
 <5e1264cf-30ae-cbbd-21bc-90b09b8aa8f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1264cf-30ae-cbbd-21bc-90b09b8aa8f2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Feb 19, 2021 at 09:25:13AM +0800, yumeng wrote:
>
> And p224 and p521 are the same as p384 (has no user and no
> generic implementation), so they should be supported by HPRE later,
> is it?

Right.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
