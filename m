Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839302CE864
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgLDHGI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 02:06:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60932 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLDHGI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 02:06:08 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl59h-0006V1-PB; Fri, 04 Dec 2020 18:05:26 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 18:05:25 +1100
Date:   Fri, 4 Dec 2020 18:05:25 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: hisilicon - add some new algorithms
Message-ID: <20201204070525.GA26479@gondor.apana.org.au>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Nov 26, 2020 at 10:18:01AM +0800, Longfang Liu wrote:
> As the new Kunpeng930 supports some new algorithms,
> the driver needs to be updated
> 
> Longfang Liu (4):
>   crypto: hisilicon/sec - add new type of sqe for Kunpeng930
>   crypto: hisilicon/sec - add new skcipher mode for SEC
>   crypto: hisilicon/sec - add new AEAD mode for SEC
>   crypto: hisilicon/sec - fixes some coding style
> 
> Meng Yu (1):
>   crypto: hisilicon/hpre - add version adapt to new algorithms

Please include details on whether this has been tested with the
self-tests, including the extra fuzz tests.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
