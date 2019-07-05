Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E3607F6
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jul 2019 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGEOgb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Jul 2019 10:36:31 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43025 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfGEOgb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Jul 2019 10:36:31 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0D8581BF210;
        Fri,  5 Jul 2019 14:36:24 +0000 (UTC)
Date:   Fri, 5 Jul 2019 16:36:24 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@insidesecure.com>,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 2/9] crypto: inside-secure - silently return -EINVAL for
 input error cases
Message-ID: <20190705143624.GF3926@kwain>
References: <1562078400-969-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1562078400-969-5-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562078400-969-5-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Tue, Jul 02, 2019 at 04:39:53PM +0200, Pascal van Leeuwen wrote:
> From: Pascal van Leeuwen <pvanleeuwen@insidesecure.com>
> 
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index 503fef0..8e8c01d 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -694,16 +694,31 @@ void safexcel_dequeue(struct safexcel_crypto_priv *priv, int ring)
>  inline int safexcel_rdesc_check_errors(struct safexcel_crypto_priv *priv,
>  				       struct safexcel_result_desc *rdesc)
>  {
> -	if (likely(!rdesc->result_data.error_code))
> +	if (likely((!rdesc->descriptor_overflow) &&
> +		   (!rdesc->buffer_overflow) &&
> +		   (!rdesc->result_data.error_code)))

You don't need the extra () here.

> +	if (rdesc->descriptor_overflow)
> +		dev_err(priv->dev, "Descriptor overflow detected");
> +
> +	if (rdesc->buffer_overflow)
> +		dev_err(priv->dev, "Buffer overflow detected");

You're not returning an error here, is there a reason for that?

I also remember having issues when adding those checks a while ago, Did
you see any of those two error messages when using the crypto engine?

Thanks!
Antoine

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
