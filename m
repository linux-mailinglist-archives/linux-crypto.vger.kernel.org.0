Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD8CBF31
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbfJDPav (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:30:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42398 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389815AbfJDPav (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:30:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPXb-0000si-H9; Sat, 05 Oct 2019 01:30:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:30:45 +1000
Date:   Sat, 5 Oct 2019 01:30:45 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv2 0/7] crypto: inside-secure - Add support for SM4 ciphers
Message-ID: <20191004153045.GF5148@gondor.apana.org.au>
References: <1568365842-19905-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568365842-19905-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 11:10:35AM +0200, Pascal van Leeuwen wrote:
> Extend driver support with ecb(sm4), cbc(sm4), ofb(sm4), cfb(sm4) and
> rfc3686(ctr(sm4)) skcipher algorithms.
> Also add ofb(sm4), cfb(sm4) and rfc3686(ctr(sm4)) testvectors to testmgr.
> The patchset has been tested with the eip197c_iewxkbc configuration
> on the Xilinx VCU118 development board, including the crypto extra tests.
> 
> Note that this patchset applies on top of the earlier submitted
> "Add support for (HMAC) SM3" series.
> 
> changes since v1:
> - rebased on top of v2 of "Added support for the CHACHA20 skcipher",
>   fixing an issue that caused SM4 to no longer function
> 
> Pascal van Leeuwen (7):
>   crypto: inside-secure - Add support for the ecb(sm4) skcipher
>   crypto: inside-secure - Add support for the cbc(sm4) skcipher
>   crypto: inside-secure - Add support for the ofb(sm4) skcipher
>   crypto: testmgr - Added testvectors for the ofb(sm4) & cfb(sm4)
>     skciphers
>   crypto: inside-secure - Add support for the cfb(sm4) skcipher
>   crypto: inside-secure - Add support for the rfc3685(ctr(sm4)) skcipher
>   crypto: testmgr - Added testvectors for the rfc3686(ctr(sm4)) skcipher
> 
>  crypto/testmgr.c                               |  18 ++
>  crypto/testmgr.h                               | 127 +++++++++++++
>  drivers/crypto/inside-secure/safexcel.c        |   5 +
>  drivers/crypto/inside-secure/safexcel.h        |   6 +
>  drivers/crypto/inside-secure/safexcel_cipher.c | 253 +++++++++++++++++++++++++
>  5 files changed, 409 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
