Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC5393DC3
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhE1H1b (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:27:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50228 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhE1H1a (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:27:30 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWsV-0003bH-Ai; Fri, 28 May 2021 15:25:55 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWsV-0001xw-1E; Fri, 28 May 2021 15:25:55 +0800
Date:   Fri, 28 May 2021 15:25:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-crypto@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: [PATCH] hwrng: core - remove redundant initialization of
 variable err
Message-ID: <20210528072554.GF7392@gondor.apana.org.au>
References: <1621497371-14746-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621497371-14746-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 20, 2021 at 03:56:11PM +0800, Shaokun Zhang wrote:
> 'err' will be assigned later and cleanup the redundant initialization.
> 
> Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
