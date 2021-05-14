Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0714380887
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhENLgb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 07:36:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37224 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhENLga (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 07:36:30 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhW67-0002vn-LS; Fri, 14 May 2021 19:35:15 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhW65-0002Xs-RJ; Fri, 14 May 2021 19:35:13 +0800
Date:   Fri, 14 May 2021 19:35:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Colin King <colin.king@canonical.com>
Cc:     Matt Mackall <mpm@selenic.com>, linux-crypto@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: amd: remove redundant initialization of variable
 err
Message-ID: <20210514113513.humtmnda7y7s53p6@gondor.apana.org.au>
References: <20210429113253.63960-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429113253.63960-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 29, 2021 at 12:32:53PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/hw_random/amd-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
