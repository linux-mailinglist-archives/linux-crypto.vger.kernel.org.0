Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1432659D0
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKG7T (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 02:59:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59022 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgIKG7P (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 02:59:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGd1W-0007xV-Fl; Fri, 11 Sep 2020 16:59:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:59:06 +1000
Date:   Fri, 11 Sep 2020 16:59:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: s5p-sss - Add and fix kerneldoc
Message-ID: <20200911065906.GI32150@gondor.apana.org.au>
References: <20200903180400.2865-1-krzk@kernel.org>
 <20200903180400.2865-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903180400.2865-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 03, 2020 at 08:03:59PM +0200, Krzysztof Kozlowski wrote:
> Add missing and fix existing kerneldoc to silence W=1 warnings:
> 
>   drivers/crypto/s5p-sss.c:333: warning: Function parameter or member 'pclk' not described in 's5p_aes_dev'
>   drivers/crypto/s5p-sss.c:373: warning: Function parameter or member 'sgl' not described in 's5p_hash_reqctx'
>   drivers/crypto/s5p-sss.c:373: warning: Function parameter or member 'buffer' not described in 's5p_hash_reqctx'
>   drivers/crypto/s5p-sss.c:1143: warning: Function parameter or member 'new_len' not described in 's5p_hash_prepare_sgs'
>   drivers/crypto/s5p-sss.c:1143: warning: Excess function parameter 'nbytes' description in 's5p_hash_prepare_sgs'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/crypto/s5p-sss.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
