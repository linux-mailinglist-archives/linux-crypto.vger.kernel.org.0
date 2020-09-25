Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F96278250
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIYILw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:11:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53206 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgIYILo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:11:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLipR-00073P-AT; Fri, 25 Sep 2020 18:11:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:11:41 +1000
Date:   Fri, 25 Sep 2020 18:11:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>
Subject: Re: [PATCH v2 0/2] crypto: arm/sha-neon - avoid ADRL instructions
Message-ID: <20200925081141.GE6381@gondor.apana.org.au>
References: <20200916061418.9197-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916061418.9197-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 16, 2020 at 09:14:16AM +0300, Ard Biesheuvel wrote:
> Remove some occurrences of ADRL in the SHA NEON code adopted from the
> OpenSSL project.
> 
> I will leave it to the Clang folks to decide whether this needs to be
> backported and how far, but a Cc stable seems reasonable here.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Peter Smith <Peter.Smith@arm.com>
> 
> Ard Biesheuvel (2):
>   crypto: arm/sha256-neon - avoid ADRL pseudo instruction
>   crypto: arm/sha512-neon - avoid ADRL pseudo instruction
> 
>  arch/arm/crypto/sha256-armv4.pl       | 4 ++--
>  arch/arm/crypto/sha256-core.S_shipped | 4 ++--
>  arch/arm/crypto/sha512-armv4.pl       | 4 ++--
>  arch/arm/crypto/sha512-core.S_shipped | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
