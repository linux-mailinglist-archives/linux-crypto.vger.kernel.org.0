Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA9DBF62
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Oct 2019 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJRIGS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Oct 2019 04:06:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37402 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfJRIGS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Oct 2019 04:06:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLNH2-0001zp-G3; Fri, 18 Oct 2019 19:06:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 19:06:12 +1100
Date:   Fri, 18 Oct 2019 19:06:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Subject: Re: [PATCH 0/4] crypto: nx - convert to skcipher API
Message-ID: <20191018080612.GM25128@gondor.apana.org.au>
References: <20191013043918.337113-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013043918.337113-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Oct 12, 2019 at 09:39:14PM -0700, Eric Biggers wrote:
> This series converts the PowerPC Nest (NX) implementations of AES modes
> from the deprecated "blkcipher" API to the "skcipher" API.  This is
> needed in order for the blkcipher API to be removed.
> 
> This patchset is compile-tested only, as I don't have this hardware.
> If anyone has this hardware, please test this patchset with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
> Eric Biggers (4):
>   crypto: nx - don't abuse blkcipher_desc to pass iv around
>   crypto: nx - convert AES-ECB to skcipher API
>   crypto: nx - convert AES-CBC to skcipher API
>   crypto: nx - convert AES-CTR to skcipher API
> 
>  drivers/crypto/nx/nx-aes-cbc.c | 81 ++++++++++++++-----------------
>  drivers/crypto/nx/nx-aes-ccm.c | 40 ++++++----------
>  drivers/crypto/nx/nx-aes-ctr.c | 87 +++++++++++++++-------------------
>  drivers/crypto/nx/nx-aes-ecb.c | 76 +++++++++++++----------------
>  drivers/crypto/nx/nx-aes-gcm.c | 24 ++++------
>  drivers/crypto/nx/nx.c         | 64 ++++++++++++++-----------
>  drivers/crypto/nx/nx.h         | 19 ++++----
>  7 files changed, 176 insertions(+), 215 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
