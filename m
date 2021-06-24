Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9763B2972
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Jun 2021 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhFXHjT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 03:39:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50850 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhFXHjT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 03:39:19 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwJut-0006H1-0t; Thu, 24 Jun 2021 15:36:51 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwJus-0004ha-2i; Thu, 24 Jun 2021 15:36:50 +0800
Date:   Thu, 24 Jun 2021 15:36:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        clabbe@baylibre.com, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] crypto: sl3516 - Fix build warning without
 CONFIG_PM
Message-ID: <20210624073650.GE17892@gondor.apana.org.au>
References: <20210618093551.23748-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618093551.23748-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 18, 2021 at 05:35:51PM +0800, YueHaibing wrote:
> drivers/crypto/gemini/sl3516-ce-core.c:345:12:
>  warning: ‘sl3516_ce_pm_resume’ defined but not used [-Wunused-function]
>  static int sl3516_ce_pm_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~
> 
> The driver needs PM, otherwise clock and resets are never set.
> So make it depends on PM to fix this warning.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Suggested-by: LABBE Corentin <clabbe@baylibre.com>
> ---
> v2: Using depends on PM instead of #ifdef macro
> 
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
