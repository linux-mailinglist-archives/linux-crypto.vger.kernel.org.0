Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145217BEC4
	for <lists+linux-crypto@lfdr.de>; Wed, 31 Jul 2019 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfGaLA0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 31 Jul 2019 07:00:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40268 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfGaLA0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 31 Jul 2019 07:00:26 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hsmLF-00044E-BO; Wed, 31 Jul 2019 21:00:21 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hsmLE-0005Mi-SA; Wed, 31 Jul 2019 21:00:20 +1000
Date:   Wed, 31 Jul 2019 21:00:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: s390/aes - fix name clash after AES library
 refactor
Message-ID: <20190731110020.GA20613@gondor.apana.org.au>
References: <20190726181904.22467-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726181904.22467-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 26, 2019 at 09:19:04PM +0300, Ard Biesheuvel wrote:
> The newly introduced AES library exposes aes_encrypt/aes_decrypt
> routines so rename existing occurrences of those identifiers in
> the s390 driver.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/s390/crypto/aes_s390.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
