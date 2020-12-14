Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249472D91C5
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Dec 2020 03:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437916AbgLNC0D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Dec 2020 21:26:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44646 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437830AbgLNC0C (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Dec 2020 21:26:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kodY8-0006BV-G5; Mon, 14 Dec 2020 13:25:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 14 Dec 2020 13:25:20 +1100
Date:   Mon, 14 Dec 2020 13:25:20 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm/chacha-neon - add missing counter
 increment
Message-ID: <20201214022520.GA13534@gondor.apana.org.au>
References: <20201213143929.7088-1-ardb@kernel.org>
 <X9bMij4eGOXn2XJv@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9bMij4eGOXn2XJv@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Dec 13, 2020 at 06:23:06PM -0800, Eric Biggers wrote:
>
> This part doesn't seem to be true, since the chacha implementations don't
> implement the "output IV" thing.  It's only cbc and ctr that do (or at least
> those are the only algorithms it's tested for).

If this algorithm can be used through algif_skcipher then it will
be making use of the output IV.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
