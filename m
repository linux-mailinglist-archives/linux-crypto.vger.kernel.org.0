Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9F34A47F
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCZJd1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:33:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35478 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhCZJdB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:33:01 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPipo-0003Xt-NQ; Fri, 26 Mar 2021 20:32:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:32:52 +1100
Date:   Fri, 26 Mar 2021 20:32:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: hisilicon/hpre - remove 'CONFIG_CRYPTO_DH'
Message-ID: <20210326093252.GK12658@gondor.apana.org.au>
References: <1616150659-10756-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616150659-10756-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 19, 2021 at 06:44:17PM +0800, Hui Tang wrote:
> Remove 'CONFIG_CRYPTO_DH' and optimise 'hpre_algs_register' error path.
> 
> Hui Tang (2):
>   crypto: hisilicon/hpre - delete wrap of 'CONFIG_CRYPTO_DH'
>   crypto: hisilicon/hpre - optimise 'hpre_algs_register' error path
> 
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 30 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
