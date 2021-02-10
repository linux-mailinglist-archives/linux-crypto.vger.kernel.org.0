Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21587316002
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBJHYk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:24:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50314 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232459AbhBJHYf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:24:35 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jqf-0001IO-1v; Wed, 10 Feb 2021 18:23:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:23:40 +1100
Date:   Wed, 10 Feb 2021 18:23:40 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     gcherian@marvell.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium: remove casting dma_alloc_coherent
Message-ID: <20210210072340.GJ4493@gondor.apana.org.au>
References: <20210204071133.83921-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204071133.83921-1-vulab@iscas.ac.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 04, 2021 at 07:11:33AM +0000, Xu Wang wrote:
> Remove casting the values returned by dma_alloc_coherent.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/cavium/cpt/cptvf_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
