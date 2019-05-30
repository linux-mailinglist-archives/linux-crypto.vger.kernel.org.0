Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110882FC85
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE3Nli (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:41:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37996 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3Nli (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:41:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLJJ-0005a3-BZ; Thu, 30 May 2019 21:41:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLJJ-0003eJ-7m; Thu, 30 May 2019 21:41:37 +0800
Date:   Thu, 30 May 2019 21:41:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: cryptd - move kcrypto_wq into cryptd
Message-ID: <20190530134137.oafbajcobfhumipc@gondor.apana.org.au>
References: <20190520165358.169396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520165358.169396-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 20, 2019 at 09:53:58AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> kcrypto_wq is only used by cryptd, so move it into cryptd.c and change
> the workqueue name from "crypto" to "cryptd".
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/Kconfig                         |  5 ----
>  crypto/Makefile                        |  2 --
>  crypto/cryptd.c                        | 24 ++++++++++++----
>  crypto/crypto_wq.c                     | 40 --------------------------
>  drivers/crypto/cavium/cpt/cptvf_algs.c |  1 -
>  include/crypto/crypto_wq.h             |  8 ------
>  6 files changed, 19 insertions(+), 61 deletions(-)
>  delete mode 100644 crypto/crypto_wq.c
>  delete mode 100644 include/crypto/crypto_wq.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
