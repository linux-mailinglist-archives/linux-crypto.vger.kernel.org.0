Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E51CBFA0
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbfJDPpd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:45:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42652 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389807AbfJDPpd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:45:33 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPlk-0001V9-Mg; Sat, 05 Oct 2019 01:45:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:45:22 +1000
Date:   Sat, 5 Oct 2019 01:45:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Phani Kiran Hemadri <phemadri@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: cavium/nitrox - fix firmware assignment to AE
 cores
Message-ID: <20191004154522.GA5148@gondor.apana.org.au>
References: <20190920063439.26486-1-phemadri@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920063439.26486-1-phemadri@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 20, 2019 at 06:35:19AM +0000, Phani Kiran Hemadri wrote:
> This patch fixes assigning UCD block number of Asymmetric crypto
> firmware to AE cores of CNN55XX device.
> 
> Fixes: a7268c4d4205 ("crypto: cavium/nitrox - Add support for loading asymmetric crypto firmware")
> Signed-off-by: Phani Kiran Hemadri <phemadri@marvell.com>
> Reviewed-by: Srikanth Jampala <jsrikanth@marvell.com>
> 
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
