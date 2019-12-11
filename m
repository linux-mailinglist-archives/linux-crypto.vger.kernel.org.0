Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC511A7F6
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfLKJqA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:46:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55450 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfLKJqA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:46:00 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyZ9-0000X1-Hb; Wed, 11 Dec 2019 17:45:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyZ7-0003F3-TU; Wed, 11 Dec 2019 17:45:53 +0800
Date:   Wed, 11 Dec 2019 17:45:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: chacha - fix warning message in header file
Message-ID: <20191211094553.z7pemzak6gycfd26@gondor.apana.org.au>
References: <31579.1575597516@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31579.1575597516@turing-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 05, 2019 at 08:58:36PM -0500, Valdis Klētnieks wrote:
> Building with W=1 causes a warning:
> 
>   CC [M]  arch/x86/crypto/chacha_glue.o
> In file included from arch/x86/crypto/chacha_glue.c:10:
> ./include/crypto/internal/chacha.h:37:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>    37 | static int inline chacha12_setkey(struct crypto_skcipher *tfm, const u8 *key,
>       | ^~~~~~
>  
> Straighten out the order to match the rest of the header file.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
