Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88737CBF37
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbfJDPcW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:32:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42426 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDPcW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:32:22 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPZ5-0000xZ-L7; Sat, 05 Oct 2019 01:32:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:32:19 +1000
Date:   Sat, 5 Oct 2019 01:32:19 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, yvan.roux@linaro.org,
        maxim.kuvyrkov@linaro.org
Subject: Re: [PATCH] crypto: aegis128-neon - use Clang compatible cflags for
 ARM
Message-ID: <20191004153219.GH5148@gondor.apana.org.au>
References: <20190913183618.6817-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913183618.6817-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 07:36:18PM +0100, Ard Biesheuvel wrote:
> The next version of Clang will start policing compiler command line
> options, and will reject combinations of -march and -mfpu that it
> thinks are incompatible.
> 
> This results in errors like
> 
>   clang-10: warning: ignoring extension 'crypto' because the 'armv7-a'
>   architecture does not support it [-Winvalid-command-line-argument]
>   /tmp/aegis128-neon-inner-5ee428.s: Assembler messages:
>             /tmp/aegis128-neon-inner-5ee428.s:73: Error: selected
>   processor does not support `aese.8 q2,q14' in ARM mode
> 
> when buiding the SIMD aegis128 code for 32-bit ARM, given that the
> 'armv7-a' -march argument is considered to be compatible with the
> ARM crypto extensions. Instead, we should use armv8-a, which does
> allow the crypto extensions to be enabled.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  crypto/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
