Return-Path: <linux-crypto+bounces-441-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 930AA80086E
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 11:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25962B211CC
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBF20B18
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:37:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F91BD1;
	Fri,  1 Dec 2023 01:31:18 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8zrN-005glj-UX; Fri, 01 Dec 2023 17:30:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:31:07 +0800
Date: Fri, 1 Dec 2023 17:31:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: olivia@selenic.com, martin@kaiser.cx, jiajie.ho@starfivetech.com,
	jenny.zhang@starfivetech.com, mmyangfl@gmail.com, robh@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	x86@vger.kernel.org, CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com,
	YunShen@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <ZWmn2yDENnSjew4t@gondor.apana.org.au>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>

On Tue, Nov 21, 2023 at 11:29:39AM +0800, LeoLiu-oc wrote:
>
> +config HW_RANDOM_ZHAOXIN
> +	tristate "Zhaoxin HW Random Number Generator support"
> +	depends on X86
> +	default HW_RANDOM

Please remove this default.

> diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
> index a9a0a3b09c8b..6d1312845802 100644
> --- a/drivers/char/hw_random/via-rng.c
> +++ b/drivers/char/hw_random/via-rng.c
> @@ -35,9 +35,6 @@
>  #include <asm/cpufeature.h>
>  #include <asm/fpu/api.h>
>  
> -
> -
> -

Please don't make unrelated changes in a patch.

>  	pr_info("VIA RNG detected\n");
>  	err = hwrng_register(&via_rng);
>  	if (err) {
> -		pr_err(PFX "RNG registering failed (%d)\n",
> -		       err);
> +		pr_err(PFX "RNG registering failed (%d)\n", err);

Ditto.

> +#include <crypto/padlock.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hw_random.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/cpufeature.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/fpu/api.h>

Please sort this alphabetically.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

