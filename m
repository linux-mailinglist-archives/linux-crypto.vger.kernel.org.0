Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDCFD5BF
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKOGG4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:06:56 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57902 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOGG4 (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:06:56 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUkw-0004kS-Be; Fri, 15 Nov 2019 14:06:54 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUkv-000678-13; Fri, 15 Nov 2019 14:06:53 +0800
Date:   Fri, 15 Nov 2019 14:06:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv4] crypto: inside-secure - Fixed authenc w/ (3)DES fails
 on Macchiatobin
Message-ID: <20191115060652.yqrmvlc3iolavzzw@gondor.apana.org.au>
References: <1573203621-8641-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573203621-8641-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 08, 2019 at 10:00:21AM +0100, Pascal van Leeuwen wrote:
> Fixed 2 copy-paste mistakes in the commit mentioned below that caused
> authenc w/ (3)DES to consistently fail on Macchiatobin (but strangely
> work fine on x86+FPGA??).
> Now fully tested on both platforms.
> 
> Fixes: 13a1bb93f7b1c9 ("crypto: inside-secure - Fixed warnings on
> inconsistent byte order handling")
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
> 
> changes since v1:
> - added Fixes: tag
> 
> changes since v2:
> - moved Fixes: tag down near other tags
> 
> changes since v3:
> - moved changelog below the ---
> 
>  drivers/crypto/inside-secure/safexcel_cipher.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
