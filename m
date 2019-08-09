Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4358713F
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfHIFKw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 01:10:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36758 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfHIFKw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 01:10:52 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvxAv-00064d-Oz; Fri, 09 Aug 2019 15:10:49 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvxAs-0002Ev-Ui; Fri, 09 Aug 2019 15:10:46 +1000
Date:   Fri, 9 Aug 2019 15:10:46 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 2/2] crypto: inside-secure: This fixes a mistake in a
 comment for XTS
Message-ID: <20190809051046.GA8571@gondor.apana.org.au>
References: <1564493232-30733-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564493232-30733-3-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564493232-30733-3-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 30, 2019 at 03:27:12PM +0200, Pascal van Leeuwen wrote:
> This fixes a copy-paste (and forgot to edit) mistake in a comment
> for XTS regarding the key length specification.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel_cipher.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch does not apply against cryptodev.  Please fold this
into your XTS patch instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
