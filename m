Return-Path: <linux-crypto+bounces-168-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F657EF2D6
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 13:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90BA1F289A8
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52F30FA0
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC306A6
	for <linux-crypto@vger.kernel.org>; Fri, 17 Nov 2023 03:25:09 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wy4-000dPy-Fl; Fri, 17 Nov 2023 19:25:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 19:25:08 +0800
Date: Fri, 17 Nov 2023 19:25:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chanho Park <chanho61.park@samsung.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jia Jie Ho <jiajie.ho@starfivetech.com>,
	William Qiu <william.qiu@starfivetech.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: jh7110 - Correct deferred probe return
Message-ID: <ZVdNlHH2FQbuc66g@gondor.apana.org.au>
References: <CGME20231109063323epcas2p13d88ce8e8251dfa4eba4662c38cc08c9@epcas2p1.samsung.com>
 <20231109063259.3427055-1-chanho61.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109063259.3427055-1-chanho61.park@samsung.com>

On Thu, Nov 09, 2023 at 03:32:59PM +0900, Chanho Park wrote:
> This fixes list_add corruption error when the driver is returned
> with -EPROBE_DEFER. It is also required to roll back the previous
> probe sequences in case of deferred_probe. So, this removes
> 'err_probe_defer" goto label and just use err_dma_init instead.
> 
> Fixes: 42ef0e944b01 ("crypto: starfive - Add crypto engine support")
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/crypto/starfive/jh7110-cryp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

