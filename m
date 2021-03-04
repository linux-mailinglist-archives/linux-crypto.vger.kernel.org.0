Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F079832CCE5
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 07:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhCDGgQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Mar 2021 01:36:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52370 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235259AbhCDGgD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Mar 2021 01:36:03 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHhZm-0007PG-Ha; Thu, 04 Mar 2021 17:35:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 17:35:10 +1100
Date:   Thu, 4 Mar 2021 17:35:10 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     mpm@selenic.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: ba431 - Use device-managed registration
Message-ID: <20210304063510.GB15863@gondor.apana.org.au>
References: <1612834534-59383-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612834534-59383-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 09, 2021 at 09:35:34AM +0800, Tian Tao wrote:
> Use device-managed registration, so we can delete the ba431_trng_remove.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/char/hw_random/ba431-rng.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
