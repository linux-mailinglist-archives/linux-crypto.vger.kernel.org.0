Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117302CE886
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 08:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgLDHQZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 02:16:25 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60982 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgLDHQY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 02:16:24 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl5Jc-0006dM-UF; Fri, 04 Dec 2020 18:15:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 18:15:40 +1100
Date:   Fri, 4 Dec 2020 18:15:40 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] crypto: x86/aesni-intel: Use TEST %reg,%reg instead of
 CMP $0,%reg
Message-ID: <20201204071540.GC31775@gondor.apana.org.au>
References: <20201127094452.7721-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127094452.7721-1-ubizjak@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 27, 2020 at 10:44:52AM +0100, Uros Bizjak wrote:
> CMP $0,%reg can't set overflow flag, so we can use shorter TEST %reg,%reg
> instruction when only zero and sign flags are checked (E,L,LE,G,GE conditions).
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/crypto/aesni-intel_asm.S        | 20 ++++++++++----------
>  arch/x86/crypto/aesni-intel_avx-x86_64.S | 20 ++++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
