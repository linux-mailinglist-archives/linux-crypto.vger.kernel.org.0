Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059FC2E88E2
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhABWIg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 17:08:36 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37336 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbhABWIf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 17:08:35 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvp3c-0000bI-Fl; Sun, 03 Jan 2021 09:07:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:07:32 +1100
Date:   Sun, 3 Jan 2021 09:07:32 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     arnd@arndb.de, davem@davemloft.net, jernej.skrabec@siol.net,
        mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 0/8] crypto: sun4i-ss: prevent always fallback for
 ciphers
Message-ID: <20210102220732.GK12767@gondor.apana.org.au>
References: <20201214200232.17357-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214200232.17357-1-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 14, 2020 at 08:02:24PM +0000, Corentin Labbe wrote:
> Hello
> 
> For help testing on "crypto: sun4i-ss - Fix sparse endianness markers",
> I have added "stats" support like other allwinner's crypto drivers.
> Seeing stats showed a clear problem, the ciphers function were not used
> at all.
> This is due to the not-inialized need_fallback which is "init" as true
> everytime.
> So basicly, since the patch introduced it, this probem hidden some bugs.
> 
> This serie fixes all hidden problems, then fix the initialization of
> "need_fallback" and then add the stats like other allwinner drivers.
> 
> Regards
> 
> changes since v3:
> - patch #2: Rewrite test as suggested by David Laight
> - patch #7: removed all ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG
> - added kmap patch
> 
> Changes since v2:
> - patch #1: move buf/bufo out of function for reducing stack usage
> - patch #4: use writesl()
> - patch #6: use IS_ENABLED instead of #ifdef
> 
> Changes since v1:
> - patch #4 is sufficient to fix BE problem (removed todo)
> 
> Corentin Labbe (8):
>   crypto: sun4i-ss: linearize buffers content must be kept
>   crypto: sun4i-ss: checking sg length is not sufficient
>   crypto: sun4i-ss: IV register does not work on A10 and A13
>   crypto: sun4i-ss: handle BigEndian for cipher
>   crypto: sun4i-ss: initialize need_fallback
>   crypto: sun4i-ss: fix kmap usage
>   crypto: sun4i-ss: enabled stats via debugfs
>   crypto: sun4i-ss: add SPDX header and remove blank lines
> 
>  drivers/crypto/allwinner/Kconfig              |   9 +
>  .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 196 +++++++++++-------
>  .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c |  52 +++++
>  .../crypto/allwinner/sun4i-ss/sun4i-ss-hash.c |   6 +
>  .../crypto/allwinner/sun4i-ss/sun4i-ss-prng.c |   6 +
>  drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |   8 +
>  6 files changed, 207 insertions(+), 70 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
