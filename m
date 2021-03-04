Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346C32CD09
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 07:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhCDGnM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Mar 2021 01:43:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52598 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhCDGmv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Mar 2021 01:42:51 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHhgI-0007Ye-KG; Thu, 04 Mar 2021 17:41:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 17:41:54 +1100
Date:   Thu, 4 Mar 2021 17:41:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     clabbe@baylibre.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: amlogic - Fix unnecessary check in
 meson_crypto_probe()
Message-ID: <20210304064154.GE15863@gondor.apana.org.au>
References: <20210210031637.19408-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210031637.19408-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 10, 2021 at 11:16:37AM +0800, Tang Bin wrote:
> The function meson_crypto_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-core.c | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
