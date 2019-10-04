Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE9CBF8C
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbfJDPns (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:43:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42542 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDPnr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:43:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPj9-0001MW-HZ; Sat, 05 Oct 2019 01:42:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:42:42 +1000
Date:   Sat, 5 Oct 2019 01:42:42 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     linux-crypto@vger.kernel.org, smueller@chronox.de,
        patrakov@gmail.com
Subject: Re: [PATCH] jitterentropy: fix comments
Message-ID: <20191004154242.GA7330@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918072849.6749-1-patrakov@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Alexander E. Patrakov <patrakov@gmail.com> wrote:
> One should not say "ec can be NULL" and then dereference it.
> One cannot talk about the return value if the function returns void.
> 
> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
> ---
> crypto/jitterentropy.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
