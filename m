Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3087C11A7BD
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfLKJn5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:43:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54950 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfLKJn5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:43:57 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyXD-0000Of-Rw; Wed, 11 Dec 2019 17:43:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyXD-0001Yz-L2; Wed, 11 Dec 2019 17:43:55 +0800
Date:   Wed, 11 Dec 2019 17:43:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: api - remove crypto_tfm::crt_u
Message-ID: <20191211094355.zupn3bxqaalra54v@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202214230.164997-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> This series removes the per-algorithm-type union from struct crypto_tfm
> now that its only remaining users are the "compress" and "cipher"
> algorithm types, and it's not really needed for them.
> 
> This shrinks every crypto transform for every algorithm by 28 bytes on
> 64-bit platforms (12 bytes on 32-bit), and also removes some code.
> 
> Note that the new-style strongly-typed algorithms (i.e. everything other
> than "compress" and "cipher") don't need crt_u, since they embed struct
> crypto_tfm in a per-algorithm-type custom struct instead.
> 
> Eric Biggers (2):
>  crypto: compress - remove crt_u.compress (struct compress_tfm)
>  crypto: cipher - remove crt_u.cipher (struct cipher_tfm)
> 
> crypto/api.c           | 15 +------
> crypto/cipher.c        | 92 +++++++++++++++++-------------------------
> crypto/compress.c      | 31 ++++++--------
> crypto/internal.h      |  3 --
> include/linux/crypto.h | 91 ++++++-----------------------------------
> 5 files changed, 61 insertions(+), 171 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
