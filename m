Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2719315FFA
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhBJHYY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:24:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50280 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhBJHYL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:24:11 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jqI-0001Hu-PB; Wed, 10 Feb 2021 18:23:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:23:18 +1100
Date:   Wed, 10 Feb 2021 18:23:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: optee: Use device-managed registration API
Message-ID: <20210210072318.GG4493@gondor.apana.org.au>
References: <1612355166-11824-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612355166-11824-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 03, 2021 at 08:26:06PM +0800, Tian Tao wrote:
> Use devm_hwrng_register to get rid of manual unregistration.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> v2:Fix up subject line as s/hwrng: optee -:/hwrng: optee:/
> ---
>  drivers/char/hw_random/optee-rng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
