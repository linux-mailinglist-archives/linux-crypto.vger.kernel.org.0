Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8844506
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Jun 2019 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfFMQlT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Jun 2019 12:41:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49976 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbfFMGzR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Jun 2019 02:55:17 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJdk-0006D5-20; Thu, 13 Jun 2019 14:55:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJdj-00052K-UG; Thu, 13 Jun 2019 14:55:15 +0800
Date:   Thu, 13 Jun 2019 14:55:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: skcipher - un-inline encrypt and decrypt
 functions
Message-ID: <20190613065515.maexyz5h6srlb3ii@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603054551.6182-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> crypto_skcipher_encrypt() and crypto_skcipher_decrypt() have grown to be
> more than a single indirect function call.  They now also check whether
> a key has been set, and with CONFIG_CRYPTO_STATS=y they also update the
> crypto statistics.  That can add up to a lot of bloat at every call
> site.  Moreover, these always involve a function call anyway, which
> greatly limits the benefits of inlining.
> 
> So change them to be non-inline.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> crypto/skcipher.c         | 34 ++++++++++++++++++++++++++++++++++
> include/crypto/skcipher.h | 32 ++------------------------------
> 2 files changed, 36 insertions(+), 30 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
