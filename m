Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386D341AF9
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Mar 2021 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCSLDz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Mar 2021 07:03:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60744 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhCSLDu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Mar 2021 07:03:50 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lNCuo-00086n-6m; Fri, 19 Mar 2021 22:03:39 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Mar 2021 22:03:38 +1100
Date:   Fri, 19 Mar 2021 22:03:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: arm/blake2s - fix for big endian
Message-ID: <20210319110337.GA8394@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310072726.288252-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The new ARM BLAKE2s code doesn't work correctly (fails the self-tests)
> in big endian kernel builds because it doesn't swap the endianness of
> the message words when loading them.  Fix this.
> 
> Fixes: 5172d322d34c ("crypto: arm/blake2s - add ARM scalar optimized BLAKE2s")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/arm/crypto/blake2s-core.S | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
