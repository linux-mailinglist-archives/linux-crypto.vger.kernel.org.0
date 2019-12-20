Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B012764B
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2019 08:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLTHJ5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Dec 2019 02:09:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59044 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfLTHJ5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Dec 2019 02:09:57 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCQ7-0000B9-JX; Fri, 20 Dec 2019 15:09:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCQ7-0007uV-CL; Fri, 20 Dec 2019 15:09:55 +0800
Date:   Fri, 20 Dec 2019 15:09:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: algapi - make unregistration functions return
 void
Message-ID: <20191220070955.h7vcx2bghfamz55v@gondor.apana.org.au>
References: <20191215235119.123636-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215235119.123636-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Dec 15, 2019 at 11:51:19PM +0000, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Some of the algorithm unregistration functions return -ENOENT when asked
> to unregister a non-registered algorithm, while others always return 0
> or always return void.  But no users check the return value, except for
> two of the bulk unregistration functions which print a message on error
> but still always return 0 to their caller, and crypto_del_alg() which
> calls crypto_unregister_instance() which always returns 0.
> 
> Since unregistering a non-registered algorithm is always a kernel bug
> but there isn't anything callers should do to handle this situation at
> runtime, let's simplify things by making all the unregistration
> functions return void, and moving the error message into
> crypto_unregister_alg() and upgrading it to a WARN().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/crypto/devel-algos.rst | 34 ++++++++++------------------
>  crypto/acompress.c                   |  4 ++--
>  crypto/ahash.c                       |  4 ++--
>  crypto/algapi.c                      | 25 +++++++-------------
>  crypto/crypto_user_base.c            |  3 ++-
>  crypto/scompress.c                   |  4 ++--
>  crypto/shash.c                       | 19 +++++-----------
>  include/crypto/algapi.h              |  2 +-
>  include/crypto/internal/acompress.h  |  4 +---
>  include/crypto/internal/hash.h       |  6 ++---
>  include/crypto/internal/scompress.h  |  4 +---
>  include/linux/crypto.h               |  4 ++--
>  12 files changed, 42 insertions(+), 71 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
