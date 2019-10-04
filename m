Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67005CBF38
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJDPcl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:32:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42432 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDPcl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:32:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPZN-0000y2-3K; Sat, 05 Oct 2019 01:32:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:32:35 +1000
Date:   Sat, 5 Oct 2019 01:32:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH] crypto: inside-secure - Add SM4 based authenc AEAD
 ciphersuites
Message-ID: <20191004153235.GI5148@gondor.apana.org.au>
References: <1568400290-5208-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568400290-5208-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 08:44:50PM +0200, Pascal van Leeuwen wrote:
> This patch adds support for the authenc(hmac(sha1),cbc(sm4)),
> authenc(hmac(sm3),cbc(sm4)), authenc(hmac(sha1),rfc3686(ctr(sm4))),
> and authenc(hmac(sm3),rfc3686(ctr(sm4))) aead ciphersuites.
> These are necessary to support IPsec according to the Chinese standard
> GM/T 022-1014 - IPsec VPN specification.
> 
> Note that there are no testvectors present in testmgr for these
> ciphersuites. However, considering all building blocks have already been
> verified elsewhere, it is fair to assume the generic implementation to be
> correct-by-construction.
> The hardware implementation has been fuzzed against this generic
> implementation by means of a locally modified testmgr. The intention is
> to upstream these testmgr changes but this is pending other testmgr changes
> being made by Eric Biggers.
> 
> The patch has been tested with the eip197c_iewxkbc configuration on the
> Xilinx VCU118 development board, using the abovementioned modified testmgr
> 
> This patch applies on top of "Add support for SM4 ciphers" and needs to
> be applied before "Add (HMAC) SHA3 support".
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c        |   4 +
>  drivers/crypto/inside-secure/safexcel.h        |   4 +
>  drivers/crypto/inside-secure/safexcel_cipher.c | 280 +++++++++++++++++++++++--
>  3 files changed, 274 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
