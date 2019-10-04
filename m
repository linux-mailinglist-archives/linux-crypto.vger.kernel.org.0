Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9048BCBF3C
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbfJDPdM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:33:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42454 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDPdM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:33:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPZs-00010Q-If; Sat, 05 Oct 2019 01:33:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:33:08 +1000
Date:   Sat, 5 Oct 2019 01:33:08 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv2 0/3] crypto: inside-secure - Added more authenc w/
 (3)DES
Message-ID: <20191004153308.GK5148@gondor.apana.org.au>
References: <1568405086-7898-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568405086-7898-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 10:04:43PM +0200, Pascal van Leeuwen wrote:
> This patchset adds the remaining authencs with DES or 3DES currently
> supported with vectors by testmgr.
> 
> The patchset has been tested with the eip197c_iewxkbc configuration on the
> Xilinx VCU118 development boardi as well as on the Macchiatobin board,
> including the testmgr extra tests.
> 
> changes since v1:
> - rebased on top of DES changes made to cryptodev/master
> 
> Pascal van Leeuwen (3):
>   crypto: inside-secure - Added support for authenc HMAC-SHA1/DES-CBC
>   crypto: inside-secure - Added support for authenc HMAC-SHA2/3DES-CBC
>   crypto: inside-secure - Added support for authenc HMAC-SHA2/DES-CBC
> 
>  drivers/crypto/inside-secure/safexcel.c        |   9 +
>  drivers/crypto/inside-secure/safexcel.h        |   9 +
>  drivers/crypto/inside-secure/safexcel_cipher.c | 311 +++++++++++++++++++++++++
>  3 files changed, 329 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
