Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F012763C
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2019 08:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLTHIH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Dec 2019 02:08:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58970 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfLTHIG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Dec 2019 02:08:06 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCOH-00007K-Bt; Fri, 20 Dec 2019 15:08:01 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCOH-0007rr-4J; Fri, 20 Dec 2019 15:08:01 +0800
Date:   Fri, 20 Dec 2019 15:08:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor.Ambarus@microchip.com
Cc:     dan.carpenter@oracle.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: atmel-aes - Fix CTR counter overflow when
 multiple fragments
Message-ID: <20191220070801.is2wplradsjjjejg@gondor.apana.org.au>
References: <20191213123800.dsnxfh4tja2q5kbv@kili.mountain>
 <20191213144529.9613-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213144529.9613-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 13, 2019 at 02:45:44PM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The CTR transfer works in fragments of data of maximum 1 MByte because
> of the 16 bit CTR counter embedded in the IP. Fix the CTR counter
> overflow handling for messages larger than 1 MByte.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 781a08d9740a ("crypto: atmel-aes - Fix counter overflow in CTR mode")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> Thanks, Dan.
> 
>  drivers/crypto/atmel-aes.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
