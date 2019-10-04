Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484AECBF1A
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbfJDP1Y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:27:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42330 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389210AbfJDP1Y (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:27:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPUH-0000mn-O8; Sat, 05 Oct 2019 01:27:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:27:16 +1000
Date:   Sat, 5 Oct 2019 01:27:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH] crypto: inside-secure - Added support for CRC32
Message-ID: <20191004152716.GA5148@gondor.apana.org.au>
References: <1568027429-26974-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568027429-26974-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 09, 2019 at 01:10:29PM +0200, Pascal van Leeuwen wrote:
> This patch adds support for the CRC32 "hash" algorithm
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c      |   1 +
>  drivers/crypto/inside-secure/safexcel.h      |   2 +
>  drivers/crypto/inside-secure/safexcel_hash.c | 115 +++++++++++++++++++++++++--
>  3 files changed, 111 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
