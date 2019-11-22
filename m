Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E689D106EAF
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfKVLKs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 06:10:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54038 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfKVLKs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 06:10:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6pq-0005PY-Mv; Fri, 22 Nov 2019 19:10:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6pq-0002lN-Ix; Fri, 22 Nov 2019 19:10:46 +0800
Date:   Fri, 22 Nov 2019 19:10:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - use chacha20_crypt()
Message-ID: <20191122111046.wpawzcnso67kp23h@gondor.apana.org.au>
References: <20191118072216.467693-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118072216.467693-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 17, 2019 at 11:22:16PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Use chacha20_crypt() instead of chacha_crypt(), since it's not really
> appropriate for users of the ChaCha library API to be passing the number
> of rounds as an argument.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/crypto/chacha20poly1305.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
