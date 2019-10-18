Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964A5DBF61
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Oct 2019 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442129AbfJRIF5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Oct 2019 04:05:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37392 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfJRIF5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Oct 2019 04:05:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLNGi-0001yw-4P; Fri, 18 Oct 2019 19:05:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 19:05:52 +1100
Date:   Fri, 18 Oct 2019 19:05:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Jamie Heilman <jamie@audible.transient.net>
Subject: Re: [PATCH] crypto: padlock-aes - convert to skcipher API
Message-ID: <20191018080551.GL25128@gondor.apana.org.au>
References: <20191013041741.265150-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013041741.265150-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Oct 12, 2019 at 09:17:41PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Convert the VIA PadLock implementations of AES-ECB and AES-CBC from the
> deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> order for the blkcipher API to be removed.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> This is compile-tested only, as I don't have this hardware.
> If anyone has this hardware, please test it with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
>  drivers/crypto/padlock-aes.c | 157 +++++++++++++++++------------------
>  1 file changed, 74 insertions(+), 83 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
