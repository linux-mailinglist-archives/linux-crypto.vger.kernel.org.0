Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538A57AB26
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfG3Ohz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 10:37:55 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55805 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfG3Ohz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 10:37:55 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0485B1BF21F;
        Tue, 30 Jul 2019 14:37:52 +0000 (UTC)
Date:   Tue, 30 Jul 2019 16:37:52 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 2/2] crypto: inside-secure: This fixes a mistake in a
 comment for XTS
Message-ID: <20190730143752.GJ3108@kwain>
References: <1564493232-30733-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564493232-30733-3-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564493232-30733-3-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Tue, Jul 30, 2019 at 03:27:12PM +0200, Pascal van Leeuwen wrote:
> This fixes a copy-paste (and forgot to edit) mistake in a comment
> for XTS regarding the key length specification.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
>  drivers/crypto/inside-secure/safexcel_cipher.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
> index a30fdd5..56dc8f9 100644
> --- a/drivers/crypto/inside-secure/safexcel_cipher.c
> +++ b/drivers/crypto/inside-secure/safexcel_cipher.c
> @@ -1847,7 +1847,7 @@ struct safexcel_alg_template safexcel_alg_xts_aes = {
>  		.setkey = safexcel_skcipher_aesxts_setkey,
>  		.encrypt = safexcel_encrypt,
>  		.decrypt = safexcel_decrypt,
> -		/* Add 4 to include the 4 byte nonce! */
> +		/* XTS actually uses 2 AES keys glued together */
>  		.min_keysize = AES_MIN_KEY_SIZE * 2,
>  		.max_keysize = AES_MAX_KEY_SIZE * 2,
>  		.ivsize = 16,
> -- 
> 1.8.3.1
> 

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
