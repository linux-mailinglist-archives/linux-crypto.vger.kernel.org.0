Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54A714524B
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jan 2020 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVKPu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jan 2020 05:15:50 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39210 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVKPu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jan 2020 05:15:50 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iuD37-0000aN-Bc; Wed, 22 Jan 2020 18:15:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iuD37-00044z-6T; Wed, 22 Jan 2020 18:15:49 +0800
Date:   Wed, 22 Jan 2020 18:15:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, Jason@zx2c4.com
Subject: Re: [PATCH] crypto: x86/poly1305 - emit does base conversion itself
Message-ID: <20200122101549.46pa6a5v2kq5bjzh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117104222.303112-1-Jason@zx2c4.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The emit code does optional base conversion itself in assembly, so we
> don't need to do that here. Also, neither one of these functions uses
> simd instructions, so checking for that doesn't make sense either.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> arch/x86/crypto/poly1305_glue.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
