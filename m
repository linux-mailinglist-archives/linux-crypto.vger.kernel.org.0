Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF94297870
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Oct 2020 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756402AbgJWUvK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Oct 2020 16:51:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41358 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756401AbgJWUvJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Oct 2020 16:51:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kW41b-0005iu-Pu; Sat, 24 Oct 2020 07:51:01 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Oct 2020 07:50:59 +1100
Date:   Sat, 24 Oct 2020 07:50:59 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] crypto: Use memzero_explicit() for clearing state
Message-ID: <20201023205059.GD27708@gondor.apana.org.au>
References: <20201023192203.400040-1-nivedita@alum.mit.edu>
 <20201023192203.400040-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023192203.400040-2-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 23, 2020 at 03:21:59PM -0400, Arvind Sankar wrote:
> Without the barrier_data() inside memzero_explicit(), the compiler may
> optimize away the state-clearing if it can tell that the state is not
> used afterwards. At least in lib/crypto/sha256.c:__sha256_final(), the
> function can get inlined into sha256(), in which case the memset is
> optimized away.

Please only convert sha256 and not everything.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
