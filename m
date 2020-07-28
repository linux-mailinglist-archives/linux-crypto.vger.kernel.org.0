Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A327E2303BC
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 09:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgG1HRv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 03:17:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54718 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgG1HRv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 03:17:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k0Jru-0006Fq-QC; Tue, 28 Jul 2020 17:17:47 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Jul 2020 17:17:46 +1000
Date:   Tue, 28 Jul 2020 17:17:46 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [v3 PATCH 0/31] crypto: skcipher - Add support for no chaining and
 partial chaining
Message-ID: <20200728071746.GA22352@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch-set adds support to the Crypto API and algif_skcipher
for algorithms that cannot be chained, as well as ones that can
be chained if you withhold a certain number of blocks at the end.

The vast majority of algorithms can be chained already, e.g., cbc
and lrw.  Everything else can either be modified to support chaining,
e.g., chacha and xts, or they cannot chain at all, e.g., keywrap.

Some drivers that implement algorithms which can be chained with
modification may not be able to support chaining due to hardware
limitations.  For now they're treated the same way as ones that
cannot be chained at all.

The algorithm arc4 has been left out of all this owing to ongoing
discussions regarding its future.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
