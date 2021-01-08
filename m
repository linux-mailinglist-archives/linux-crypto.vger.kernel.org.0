Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45D22EEF7A
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Jan 2021 10:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbhAHJXr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Jan 2021 04:23:47 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:41348 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbhAHJXq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Jan 2021 04:23:46 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kxnyp-0001tt-5Y; Fri, 08 Jan 2021 20:22:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jan 2021 20:22:47 +1100
Date:   Fri, 8 Jan 2021 20:22:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] crypto - shash: reduce minimum alignment of shash_desc
 structure
Message-ID: <20210108092246.GA13460@gondor.apana.org.au>
References: <20210107124128.19791-1-ardb@kernel.org>
 <X/daxUIwf8iXkbxr@gmail.com>
 <CAMj1kXE_qHkuk0zmhS=F4uFYWHnZumEB_XWyzo4SYXj1vjqKmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE_qHkuk0zmhS=F4uFYWHnZumEB_XWyzo4SYXj1vjqKmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 08, 2021 at 09:36:23AM +0100, Ard Biesheuvel wrote:
>
> scatterlists, and I don't think we permit pointing the scatterlist
> into request structures)

Not only do we allow that, we do that in lots of places.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
