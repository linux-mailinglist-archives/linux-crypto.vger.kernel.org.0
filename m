Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204C14450C
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Jun 2019 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfFMQlV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Jun 2019 12:41:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49950 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbfFMGyc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Jun 2019 02:54:32 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJd0-0006Ci-I5; Thu, 13 Jun 2019 14:54:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJd0-00050z-EA; Thu, 13 Jun 2019 14:54:30 +0800
Date:   Thu, 13 Jun 2019 14:54:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] crypto: doc - improve the skcipher API example code
Message-ID: <20190613065430.wocmr33a4mi4gxfr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603054408.5903-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.doc
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Rewrite the skcipher API example, changing it to encrypt a buffer with
> AES-256-XTS.  This addresses various problems with the previous example:
> 
> - It requests a specific driver "cbc-aes-aesni", which is unusual.
>  Normally users ask for "cbc(aes)", not a specific driver.
> 
> - It encrypts only a single AES block.  For the reader, that doesn't
>  clearly distinguish the "skcipher" API from the "cipher" API.
> 
> - Showing how to encrypt something with bare CBC is arguably a poor
>  choice of example, as it doesn't follow modern crypto trends.  Now,
>  usually authenticated encryption is recommended, in which case the
>  user would use the AEAD API, not skcipher.  Disk encryption is still a
>  legitimate use for skcipher, but for that usually XTS is recommended.
> 
> - Many other bugs and poor coding practices, such as not setting
>  CRYPTO_TFM_REQ_MAY_SLEEP, unnecessarily allocating a heap buffer for
>  the IV, unnecessary NULL checks, using a pointless wrapper struct, and
>  forgetting to set an error code in one case.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> Documentation/crypto/api-samples.rst | 176 ++++++++++++---------------
> 1 file changed, 77 insertions(+), 99 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
