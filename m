Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E3B0062
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Sep 2019 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfIKPk6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Sep 2019 11:40:58 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49349 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfIKPk6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Sep 2019 11:40:58 -0400
X-Originating-IP: 148.69.85.38
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A1788240010;
        Wed, 11 Sep 2019 15:40:56 +0000 (UTC)
Date:   Wed, 11 Sep 2019 16:40:55 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH 1/3] crypto: inside-secure - Added support for basic SM3
 ahash
Message-ID: <20190911154055.GC5492@kwain>
References: <1568187671-8540-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1568187671-8540-2-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568187671-8540-2-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Wed, Sep 11, 2019 at 09:41:09AM +0200, Pascal van Leeuwen wrote:
>  static int safexcel_register_algorithms(struct safexcel_crypto_priv *priv)
> diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
> index 282d59e..fc2aba2 100644
> --- a/drivers/crypto/inside-secure/safexcel.h
> +++ b/drivers/crypto/inside-secure/safexcel.h
> @@ -374,6 +374,7 @@ struct safexcel_context_record {
>  #define CONTEXT_CONTROL_CRYPTO_ALG_XCBC192	(0x2 << 23)
>  #define CONTEXT_CONTROL_CRYPTO_ALG_XCBC256	(0x3 << 23)
>  #define CONTEXT_CONTROL_CRYPTO_ALG_POLY1305	(0xf << 23)
> +#define CONTEXT_CONTROL_CRYPTO_ALG_SM3		(0x7 << 23)

Please order the definitions (0x7 before 0xf).

Otherwise the patch looks good, and with that you can add:

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
