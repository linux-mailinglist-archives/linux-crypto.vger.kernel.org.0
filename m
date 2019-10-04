Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E57CBF7B
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfJDPmH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:42:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42506 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389690AbfJDPmH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:42:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPiQ-0001KC-Ef; Sat, 05 Oct 2019 01:41:59 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:41:58 +1000
Date:   Sat, 5 Oct 2019 01:41:58 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 0/3] crypto: inside-secure - Add ESP GCM/GMAC/CCM variants
Message-ID: <20191004154158.GP5148@gondor.apana.org.au>
References: <1568714881-30426-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568714881-30426-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 17, 2019 at 12:07:58PM +0200, Pascal van Leeuwen wrote:
> This patchset adds support for the rfc4106(gcm(aes)), rfc4543(gcm(aes))
> and rfc4309(ccm(aes)) ciphersuites intended for IPsec ESP acceleration.
> 
> The patchset has been tested with the eip197c_iewxkbc configuration on the
> Xilinx VCU118 development boardi as well as on the Macchiatobin board,
> including the testmgr extra tests.
> 
> Pascal van Leeuwen (3):
>   crypto: inside-secure - Added support for the rfc4106(gcm(aes)) AEAD
>   crypto: inside-secure - Added support for the rfc4543(gcm(aes)) "AEAD"
>   crypto: inside-secure - Added support for the rfc4309(ccm(aes)) AEAD
> 
>  drivers/crypto/inside-secure/safexcel.c        |   3 +
>  drivers/crypto/inside-secure/safexcel.h        |   8 +-
>  drivers/crypto/inside-secure/safexcel_cipher.c | 355 ++++++++++++++++++++-----
>  3 files changed, 295 insertions(+), 71 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
