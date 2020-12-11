Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF762D73CB
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgLKKO6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 05:14:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33414 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgLKKOe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 05:14:34 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knfQk-0004wQ-Dh; Fri, 11 Dec 2020 21:13:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Dec 2020 21:13:42 +1100
Date:   Fri, 11 Dec 2020 21:13:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     xuzaibo@huawei.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/trng replace atomic_add_return()
Message-ID: <20201211101342.GB3266@gondor.apana.org.au>
References: <1606805418-4739-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606805418-4739-1-git-send-email-yejune.deng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 01, 2020 at 02:50:18PM +0800, Yejune Deng wrote:
> a set of atomic_inc_return() looks more neater
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/crypto/hisilicon/trng/trng.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
