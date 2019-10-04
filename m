Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1DCBF1E
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbfJDP1p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:27:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42338 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389210AbfJDP1o (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:27:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPUb-0000nh-KS; Sat, 05 Oct 2019 01:27:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:27:41 +1000
Date:   Sat, 5 Oct 2019 01:27:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 0/3] crypto: inside-secure - Add support for the CBCMAC
Message-ID: <20191004152741.GB5148@gondor.apana.org.au>
References: <1568027588-31997-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568027588-31997-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 09, 2019 at 01:13:05PM +0200, Pascal van Leeuwen wrote:
> This patchset adds support for the (AES) CBCMAC family of authentication
> algorithms: AES-CBCMAC, AES-XCBCMAC and AES-MAC
> It has been verified with a Xilinx PCIE FPGA board as well as the Marvell
> Armada A8K based Macchiatobin development board.
> 
> Pascal van Leeuwen (3):
>   crypto: inside-secure - Added support for the AES CBCMAC ahash
>   crypto: inside-secure - Added support for the AES XCBC ahash
>   crypto: inside-secure - Added support for the AES-CMAC ahash
> 
>  drivers/crypto/inside-secure/safexcel.c      |   3 +
>  drivers/crypto/inside-secure/safexcel.h      |   3 +
>  drivers/crypto/inside-secure/safexcel_hash.c | 462 ++++++++++++++++++++++++---
>  3 files changed, 427 insertions(+), 41 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
