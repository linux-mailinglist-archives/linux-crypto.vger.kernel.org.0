Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9567C352D
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Oct 2019 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJANIA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Oct 2019 09:08:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59040 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJANH7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Oct 2019 09:07:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iFHsh-00010Y-2b; Tue, 01 Oct 2019 23:07:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Oct 2019 23:07:53 +1000
Date:   Tue, 1 Oct 2019 23:07:53 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2] crypto: arm/aes-ce - build for v8 architecture
 explicitly
Message-ID: <20191001130753.GA3434@gondor.apana.org.au>
References: <20190917085001.792-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917085001.792-1-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 17, 2019 at 09:50:00AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> The NEON/Crypto Extensions based AES implementation for 32-bit ARM
> can be built in a kernel that targets ARMv6 CPUs and higher, even
> though the actual code will not be able to run on that generation,
> but it allows for a portable image to be generated that can will
> use the special instructions only when they are available.
> 
> Since those instructions are part of a FPU profile rather than a
> CPU profile, we don't override the architecture in the assembler
> code, and most of the scalar code is simple enough to be ARMv6
> compatible. However, that changes with commit c61b1607ed4fbbf2,
> which introduces calls to the movw/movt instructions, which are
> v7+ only.
> 
> So override the architecture in the .S file to armv8-a, which
> matches the architecture specification in the crypto-neon-fp-armv8
> FPU specificier that we already using. Note that using armv7-a
> here may trigger an issue with the upcoming Clang 10 release,
> which no longer permits .arch/.fpu combinations it views as
> incompatible.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: c61b1607ed4fbbf2("crypto: arm/aes-ce - implement ciphertext stealing ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/crypto/aes-ce-core.S | 1 +
>  1 file changed, 1 insertion(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
