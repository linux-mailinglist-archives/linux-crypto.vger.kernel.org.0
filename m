Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA61A3238
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Aug 2019 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfH3IZE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Aug 2019 04:25:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59666 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfH3IZD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Aug 2019 04:25:03 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i3cDL-0005gh-8q; Fri, 30 Aug 2019 18:25:00 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Aug 2019 18:24:57 +1000
Date:   Fri, 30 Aug 2019 18:24:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: Re: [PATCH] crypto: ccp - invoke fallback for XTS ciphertext stealing
Message-ID: <20190830082457.GH8033@gondor.apana.org.au>
References: <20190822154731.13301-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822154731.13301-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 22, 2019 at 06:47:31PM +0300, Ard Biesheuvel wrote:
> For correctness and compliance with the XTS-AES specification, we are
> adding support for ciphertext stealing to XTS implementations, even
> though no use cases are known that will be enabled by this.
> 
> Since the ccp driver already has a fallback skcipher standby for
> dealing with input sizes other than [16, 512, 1024, 2048, 4096],
> just drop the check against the block size.
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gary Hook <gary.hook@amd.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/crypto/ccp/ccp-crypto-aes-xts.c | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
