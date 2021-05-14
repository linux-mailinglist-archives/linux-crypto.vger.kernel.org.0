Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E238088E
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhENLgz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 07:36:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37260 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhENLgz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 07:36:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhW6W-0002zo-9Y; Fri, 14 May 2021 19:35:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhW6V-0002YK-I6; Fri, 14 May 2021 19:35:39 +0800
Date:   Fri, 14 May 2021 19:35:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] hwrng: exynos - Fix runtime PM imbalance on error
Message-ID: <20210514113539.2zgidvassvrnq3ig@gondor.apana.org.au>
References: <CGME20210505182918eucas1p18a11263e5d214e3356ac65d79504e430@eucas1p1.samsung.com>
 <20210505182914.13394-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505182914.13394-1-l.stelmach@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 05, 2021 at 08:29:14PM +0200, Łukasz Stelmach wrote:
> pm_runtime_resume_and_get() wraps around pm_runtime_get_sync() and
> decrements the runtime PM usage counter in case the latter function
> fails and keeps the counter balanced.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes in v3:
>   - use pm_runtime_resume_and_get()
> 
> Changes in v2:
>   - removed Change-Id from the commit message
> 
>  drivers/char/hw_random/exynos-trng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
