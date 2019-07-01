Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6567A2FC7D
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfE3Nk4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:40:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37938 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3Nk4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:40:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLId-0005WC-3k; Thu, 30 May 2019 21:40:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLIc-0003cs-QZ; Thu, 30 May 2019 21:40:54 +0800
Date:   Thu, 30 May 2019 21:40:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Daniel Axtens <dja@axtens.net>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Subject: Re: [PATCH] crypto: vmx - convert to skcipher API
Message-ID: <20190530134054.uhx3b32x7twpkk6t@gondor.apana.org.au>
References: <20190520164448.160430-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520164448.160430-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 20, 2019 at 09:44:48AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Convert the VMX implementations of AES-CBC, AES-CTR, and AES-XTS from
> the deprecated "blkcipher" API to the "skcipher" API.
> 
> As part of this, I moved the skcipher_request for the fallback algorithm
> off the stack and into the request context of the parent algorithm.
> 
> I tested this in a PowerPC VM with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/crypto/vmx/aes_cbc.c   | 183 ++++++++++++---------------------
>  drivers/crypto/vmx/aes_ctr.c   | 165 +++++++++++++----------------
>  drivers/crypto/vmx/aes_xts.c   | 175 ++++++++++++++-----------------
>  drivers/crypto/vmx/aesp8-ppc.h |   2 -
>  drivers/crypto/vmx/vmx.c       |  72 +++++++------
>  5 files changed, 252 insertions(+), 345 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
