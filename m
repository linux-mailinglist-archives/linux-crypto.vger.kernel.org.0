Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9A2E1A2D
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLWIx7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 03:53:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37094 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgLWIx7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 03:53:59 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1krztS-0007XT-Ol; Wed, 23 Dec 2020 19:53:15 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Dec 2020 19:53:14 +1100
Date:   Wed, 23 Dec 2020 19:53:14 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm/chacha-neon - add missing counter
 increment
Message-ID: <20201223085314.GA16670@gondor.apana.org.au>
References: <20201213143929.7088-1-ardb@kernel.org>
 <X9bMij4eGOXn2XJv@sol.localdomain>
 <20201214022520.GA13534@gondor.apana.org.au>
 <X9fNgQxS3jASW7C1@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9fNgQxS3jASW7C1@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 14, 2020 at 12:39:29PM -0800, Eric Biggers wrote:
>
> That doesn't make sense, given that most algorithms don't implement it...

It doesn't matter for chacha, but it's still true for the Crypto
API in general.

Yes I know that lots of algorithms get it wrong, but it is on my
list of things to fix.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
