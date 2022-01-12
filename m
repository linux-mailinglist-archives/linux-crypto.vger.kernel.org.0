Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9C48BC16
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jan 2022 01:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbiALA6D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jan 2022 19:58:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59376 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234143AbiALA6C (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jan 2022 19:58:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n7Rxf-0004Nt-Ns; Wed, 12 Jan 2022 11:58:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 12 Jan 2022 11:58:00 +1100
Date:   Wed, 12 Jan 2022 11:58:00 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: testmgr - Move crypto_simd_disabled_for_test out
Message-ID: <Yd4nmLgFr8XTxCo6@gondor.apana.org.au>
References: <Yd0jA4VOjysrdOu7@gondor.apana.org.au>
 <Yd36HsgI+ya6P7RF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd36HsgI+ya6P7RF@gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 11, 2022 at 01:43:58PM -0800, Eric Biggers wrote:
>
> Maybe CRYPTO_MANAGER_EXTRA_TESTS should select CRYPTO_SIMD?

You're right.  I was focusing only on the module dependencies
but neglected to change the Kconfig dependencies.

I'll fix this in the next version.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
