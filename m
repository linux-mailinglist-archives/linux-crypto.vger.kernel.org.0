Return-Path: <linux-crypto+bounces-863-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDE814571
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4578D1C2303A
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Dec 2023 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC45288B0;
	Fri, 15 Dec 2023 10:22:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76C25553;
	Fri, 15 Dec 2023 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rE4v0-00BCeU-Rb; Fri, 15 Dec 2023 17:55:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Dec 2023 17:55:53 +0800
Date: Fri, 15 Dec 2023 17:55:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: starfive - Fix dev_err_probe return error
Message-ID: <ZXwiqSs06bm+ei7s@gondor.apana.org.au>
References: <20231204030413.989243-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204030413.989243-1-jiajie.ho@starfivetech.com>

On Mon, Dec 04, 2023 at 11:04:13AM +0800, Jia Jie Ho wrote:
> Current dev_err_probe will return 0 instead of proper error code if
> driver failed to get irq number. Fix the return code.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  drivers/crypto/starfive/jh7110-cryp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

