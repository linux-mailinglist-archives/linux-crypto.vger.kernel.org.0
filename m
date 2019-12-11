Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1191D11A79C
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfLKJmA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:42:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54622 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfLKJmA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:42:00 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyVL-0000Jv-8m; Wed, 11 Dec 2019 17:41:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyVK-0008L4-W0; Wed, 11 Dec 2019 17:41:59 +0800
Date:   Wed, 11 Dec 2019 17:41:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/6] crypto: skcipher - simplifications due to
 {,a}blkcipher removal
Message-ID: <20191211094158.v763ukolpv3yfq5o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129182308.53961-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> This series makes some simplifications to the skcipher algorithm type
> that are possible now that blkcipher and ablkcipher (and hence also the
> compatibility code to expose them via the skcipher API) were removed.
> 
> Eric Biggers (6):
>  crypto: skcipher - remove crypto_skcipher::ivsize
>  crypto: skcipher - remove crypto_skcipher::keysize
>  crypto: skcipher - remove crypto_skcipher::setkey
>  crypto: skcipher - remove crypto_skcipher::encrypt
>  crypto: skcipher - remove crypto_skcipher::decrypt
>  crypto: skcipher - remove crypto_skcipher_extsize()
> 
> crypto/skcipher.c         | 22 ++++++----------------
> crypto/testmgr.c          | 10 ++++++----
> fs/ecryptfs/crypto.c      |  2 +-
> fs/ecryptfs/keystore.c    |  4 ++--
> include/crypto/skcipher.h | 20 +++++---------------
> 5 files changed, 20 insertions(+), 38 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
