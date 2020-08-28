Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAE2554FA
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Aug 2020 09:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgH1HUI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Aug 2020 03:20:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35312 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1HUH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Aug 2020 03:20:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kBYfk-0003gb-9Y; Fri, 28 Aug 2020 17:19:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Aug 2020 17:19:40 +1000
Date:   Fri, 28 Aug 2020 17:19:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree - fix runtime PM imbalance on error
Message-ID: <20200828071940.GC28064@gondor.apana.org.au>
References: <5fe48e8a.e845.1741016074a.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe48e8a.e845.1741016074a.Coremail.dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 21, 2020 at 04:15:13PM +0800, dinghao.liu@zju.edu.cn wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter
> even when it returns an error code. However, users of cc_pm_get(),
> a direct wrapper of pm_runtime_get_sync(), assume that PM usage
> counter will not change on error. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.
> 
> Fixes: 8c7849a30255c ("crypto: ccree - simplify Runtime PM handling")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/crypto/ccree/cc_pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
