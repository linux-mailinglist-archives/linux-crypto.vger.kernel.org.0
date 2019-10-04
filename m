Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BECBF3B
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbfJDPdA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:33:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42444 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDPdA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:33:00 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPZb-0000zt-Cj; Sat, 05 Oct 2019 01:32:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:32:50 +1000
Date:   Sat, 5 Oct 2019 01:32:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv2 0/3] crypto: inside-secure - Add (HMAC) SHA3 support
Message-ID: <20191004153250.GJ5148@gondor.apana.org.au>
References: <1568401009-29762-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568401009-29762-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 08:56:46PM +0200, Pascal van Leeuwen wrote:
> This patchset adds support for all flavours of sha3-xxx and hmac(sha3-xxx)
> ahash algorithms.
> 
> The patchset has been tested with the eip197c_iewxkbc configuration on the
> Xilinx VCU118 development board, including the testmgr extra tests.
> 
> changes snce v1:
> - fixed crypto/Kconfig so that generic fallback is compiled as well 
> 
> Pascal van Leeuwen (3):
>   crypto: inside-secure - Add SHA3 family of basic hash algorithms
>   crypto: inside-secure - Add HMAC-SHA3 family of authentication
>     algorithms
>   crypto: Kconfig - Add CRYPTO_SHA3 to CRYPTO_DEV_SAFEXCEL
> 
>  drivers/crypto/Kconfig                       |   1 +
>  drivers/crypto/inside-secure/safexcel.c      |   8 +
>  drivers/crypto/inside-secure/safexcel.h      |  13 +
>  drivers/crypto/inside-secure/safexcel_hash.c | 790 ++++++++++++++++++++++++++-
>  4 files changed, 800 insertions(+), 12 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
