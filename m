Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B973ECBF36
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbfJDPbk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:31:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42408 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389556AbfJDPbk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:31:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPYP-0000wZ-Tq; Sat, 05 Oct 2019 01:31:39 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:31:37 +1000
Date:   Sat, 5 Oct 2019 01:31:37 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv3 0/3] crypto: inside-secure - Add support for (HMAC) SM3
Message-ID: <20191004153137.GG5148@gondor.apana.org.au>
References: <1568388038-1268-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568388038-1268-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 05:20:35PM +0200, Pascal van Leeuwen wrote:
> Extend driver support with sm3 and hmac(sm3) ahash support.
> Also add GM/T 0042-2015 hmac(sm3) testvectors to the testmgr.
> The patchset has been tested with the eip197c_iewxkbc configuration
> on the Xilinx VCU118 development board, including the crypto extra tests.
> 
> Note that this patchset applies on top of the earlier submitted
> "Add support for the Chacha20 kcipher and the Chacha20-Poly..." series.
> 
> changes since v1:
> - incorporated feedback by Antoine Tenart, see individual patches for
>   details
> 
> changes since v2:
> - allow compilation if CONFIG_CRYPTO_SM3 is not set
> 
> Pascal van Leeuwen (3):
>   crypto: inside-secure - Added support for basic SM3 ahash
>   crypto: inside-secure - Added support for HMAC-SM3 ahash
>   crypto: testmgr - Added testvectors for the hmac(sm3) ahash
> 
>  crypto/testmgr.c                             |   6 ++
>  crypto/testmgr.h                             |  56 +++++++++++
>  drivers/crypto/inside-secure/safexcel.c      |   2 +
>  drivers/crypto/inside-secure/safexcel.h      |   9 ++
>  drivers/crypto/inside-secure/safexcel_hash.c | 134 +++++++++++++++++++++++++++
>  5 files changed, 207 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
