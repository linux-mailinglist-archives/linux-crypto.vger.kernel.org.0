Return-Path: <linux-crypto+bounces-638-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE2809B09
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B65281D73
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572B111AA
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A81718
	for <linux-crypto@vger.kernel.org>; Thu,  7 Dec 2023 20:08:13 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS9o-008Ijs-UI; Fri, 08 Dec 2023 12:08:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:08:18 +0800
Date: Fri, 8 Dec 2023 12:08:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: linux-crypto@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	gatien.chevallier@foss.st.com, yangyingliang@huawei.com
Subject: Re: [PATCH] hwrng: stm32 - add missing clk_disable_unprepare() in
 stm32_rng_init()
Message-ID: <ZXKWsq/+td8HUmVQ@gondor.apana.org.au>
References: <20231201082048.1975940-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201082048.1975940-1-yangyingliang@huaweicloud.com>

On Fri, Dec 01, 2023 at 04:20:48PM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> Add clk_disable_unprepare() in the error path in stm32_rng_init().
> 
> Fixes: 6b85a7e141cb ("hwrng: stm32 - implement STM32MP13x support")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/char/hw_random/stm32-rng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

