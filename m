Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB81AB7B3
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407714AbgDPGHH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:07:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41134 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407208AbgDPGHD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:07:03 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOxfd-0004Sf-5S; Thu, 16 Apr 2020 16:06:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:06:41 +1000
Date:   Thu, 16 Apr 2020 16:06:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/7] crypto: rng - add missing __crypto_rng_cast to the
 rng header
Message-ID: <20200416060640.GA19267@gondor.apana.org.au>
References: <1585943438-862-1-git-send-email-clabbe@baylibre.com>
 <1585943438-862-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585943438-862-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 03, 2020 at 07:50:32PM +0000, Corentin Labbe wrote:
> This patch add __crypto_rng_cast() to the rng header like other
> __algo_cast functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/crypto/rng.h | 5 +++++
>  1 file changed, 5 insertions(+)

This should never be exported.  Either change the driver to use
use crypto_tfm_ctx instead of crypto_rng_ctx, or if you have the
time please convert the rng API over to the new way of doing things
like aead/skcipher.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
