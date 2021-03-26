Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270EF34A492
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCZJfh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:35:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35630 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhCZJfQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:35:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPiro-0003ea-N5; Fri, 26 Mar 2021 20:34:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:34:56 +1100
Date:   Fri, 26 Mar 2021 20:34:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        corbet@lwn.net, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org, leitao@debian.org,
        nayna@linux.ibm.com, pfsmorigo@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: nx: fix incorrect kernel-doc comment syntax in
 files
Message-ID: <20210326093456.GS12658@gondor.apana.org.au>
References: <20210321123007.15505-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321123007.15505-1-yashsri421@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Mar 21, 2021 at 06:00:07PM +0530, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in drivers/crypto/nx, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in the header lines for
> drivers/crypto/nx/nx-sha256.c at header causes these warnings:
> "warning: Function parameter or member 'tfm' not described in 'nx_crypto_ctx_sha256_init'"
> "warning: expecting prototype for SHA(). Prototype was for nx_crypto_ctx_sha256_init() instead"
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> * Applies perfectly on next-20210319
> 
>  drivers/crypto/nx/nx-aes-cbc.c  | 2 +-
>  drivers/crypto/nx/nx-aes-ccm.c  | 2 +-
>  drivers/crypto/nx/nx-aes-ctr.c  | 2 +-
>  drivers/crypto/nx/nx-aes-ecb.c  | 2 +-
>  drivers/crypto/nx/nx-aes-gcm.c  | 2 +-
>  drivers/crypto/nx/nx-aes-xcbc.c | 2 +-
>  drivers/crypto/nx/nx-sha256.c   | 2 +-
>  drivers/crypto/nx/nx-sha512.c   | 2 +-
>  drivers/crypto/nx/nx.c          | 2 +-
>  drivers/crypto/nx/nx_debugfs.c  | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
