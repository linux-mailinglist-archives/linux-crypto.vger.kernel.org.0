Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43507316007
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBJHZy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:25:54 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50334 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhBJHYx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:24:53 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jqw-0001IZ-Vu; Wed, 10 Feb 2021 18:24:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:23:58 +1100
Date:   Wed, 10 Feb 2021 18:23:58 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - enable Elliptic curve
 cryptography
Message-ID: <20210210072358.GL4493@gondor.apana.org.au>
References: <1612429224-30388-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612429224-30388-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 04, 2021 at 05:00:24PM +0800, Hui Tang wrote:
> Enable x25519/x448/ecdh/ecdsa/sm2 algorithm on Kunpeng 930.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
