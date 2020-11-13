Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78852B2503
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMT6M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 14:58:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35640 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKMT6M (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 14:58:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kdfCz-00029Y-34; Sat, 14 Nov 2020 06:58:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Nov 2020 06:58:09 +1100
Date:   Sat, 14 Nov 2020 06:58:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH crypto] crypto: Kconfig - CRYPTO_MANAGER_EXTRA_TESTS
 requires the manager
Message-ID: <20201113195809.GA18628@gondor.apana.org.au>
References: <20201102134815.512866-1-Jason@zx2c4.com>
 <20201113050949.GA8350@gondor.apana.org.au>
 <CAHmME9r=myLmSJMvjDff_VG4ya2_Q-22=F+=kOucnYwqzZTxWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r=myLmSJMvjDff_VG4ya2_Q-22=F+=kOucnYwqzZTxWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 13, 2020 at 03:34:36PM +0100, Jason A. Donenfeld wrote:
> Thanks. FYI, I intended this for crypto-2.6.git rather than
> cryptodev-2.6.git, since it fixes a build failure and is a trivial
> fix.

Well this has been broken since January so I don't see the urgency
in it going in right away.  It'll be backported eventually.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
