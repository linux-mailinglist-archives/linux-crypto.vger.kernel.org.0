Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636FA2A8FC2
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 08:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgKFHAl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 02:00:41 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34998 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKFHAl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 02:00:41 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kavji-0007yw-SY; Fri, 06 Nov 2020 18:00:40 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Nov 2020 18:00:38 +1100
Date:   Fri, 6 Nov 2020 18:00:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: testmgr - always print the actual driver name
Message-ID: <20201106070038.GA11666@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026161702.39201-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> When alg_test() is called from tcrypt.ko rather than from the algorithm
> registration code, "driver" is actually the algorithm name, not the
> driver name.  So it shouldn't be used in places where a driver name is
> wanted, e.g. when reporting a test failure or when checking whether the
> driver is the generic driver or not.
> 
> See https://lkml.kernel.org/r/20200910122248.GA22506@Red for an example
> where this caused a problem.  The self-tests reported "alg: ahash: md5
> test failed", but it wasn't mentioned which md5 implementation it was.
> 
> Fix this by getting the driver name from the crypto tfm object that
> actually got allocated.
> 
> Eric Biggers (4):
>  crypto: aead - add crypto_aead_driver_name()
>  crypto: testmgr - always print the actual hash driver name
>  crypto: testmgr - always print the actual AEAD driver name
>  crypto: testmgr - always print the actual skcipher driver name
> 
> crypto/testmgr.c      | 121 +++++++++++++++++++-----------------------
> include/crypto/aead.h |   5 ++
> 2 files changed, 59 insertions(+), 67 deletions(-)
> 
> 
> base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
