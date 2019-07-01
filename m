Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4FE4F3CB
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Jun 2019 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFVFG0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 Jun 2019 01:06:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54772 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfFVFG0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 Jun 2019 01:06:26 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1heYEL-0001Yo-2q; Sat, 22 Jun 2019 13:06:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1heYEI-0000rj-AE; Sat, 22 Jun 2019 13:06:22 +0800
Date:   Sat, 22 Jun 2019 13:06:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@google.com
Subject: Re: [RFC PATCH 01/30] crypto: des/3des_ede - add new helpers to
 verify key length
Message-ID: <20190622050622.zztsonohpmjvrovn@gondor.apana.org.au>
References: <20190622003112.31033-1-ard.biesheuvel@linaro.org>
 <20190622003112.31033-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622003112.31033-2-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jun 22, 2019 at 02:30:43AM +0200, Ard Biesheuvel wrote:
> The recently added helper routines to perform key strength validation
> of 3ede_keys is slightly inadequate, since it doesn't check the key
> length, and it comes in two versions, neither of which are highly

The skcipher helper doesn't need to check the key length because
it's the responsibility of the crypto API to check the key length
through min_keysize/max_keysize.

But yes if you're going to do a helper for lib/des then you'd need
to check the key length but please keep it separate from the skcipher
helper.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
