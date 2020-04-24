Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA31B6F45
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Apr 2020 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDXHqc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Apr 2020 03:46:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43324 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgDXHqc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Apr 2020 03:46:32 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jRt2T-0000bA-J6; Fri, 24 Apr 2020 17:46:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Apr 2020 17:46:21 +1000
Date:   Fri, 24 Apr 2020 17:46:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: crypto: Consistently enable extension
Message-ID: <20200424074621.GA24682@gondor.apana.org.au>
References: <20200414182008.31417-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414182008.31417-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 14, 2020 at 07:20:08PM +0100, Mark Brown wrote:
> Currently most of the crypto files enable the crypto extension using the
> .arch directive but crct10dif-ce-core.S uses .cpu instead. Move that over
> to .arch for consistency.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/crypto/crct10dif-ce-core.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
