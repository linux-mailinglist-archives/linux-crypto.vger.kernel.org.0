Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC430C10
	for <lists+linux-crypto@lfdr.de>; Fri, 31 May 2019 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaJxg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 May 2019 05:53:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41574 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaJxg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 May 2019 05:53:36 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so7628810ioc.8
        for <linux-crypto@vger.kernel.org>; Fri, 31 May 2019 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ai6iFpYmtM8MFBjASserTn9RG0APCv4fkrpDT2QH0s=;
        b=sYTsig4iu/OL18DOUgnOo7s11OsbQjWZfDA2inJ93Fsa1/fEGuacCqp90wGkhnIm78
         VNLtmLH9aCmUv65+RYs7yxtNhVl8CR6psqS7mm2OpbXhOwl/CyQzmvcX7r6HfbqFRjYr
         3pDdDMRCDa0a1C3GV55e7L5G9ZYk+InzFulrFnV7Qyjw55Fk4bSJuD7C7wIX46y0/+9p
         74XbwgbUrDw1cC6OWzcl3dPe6JQ+EjOz21SwJeHAkLUKMo3YE3DpjLvL8tXCJH+iPyAV
         NgKaIMn93CTdzQuQNsNex9dAr5t//KWJMF5zz4ys6kE3KdGy20+LZ4/nVuAXPLsTj/59
         v6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ai6iFpYmtM8MFBjASserTn9RG0APCv4fkrpDT2QH0s=;
        b=IgzjiYPL/E/3Xwyy9eUPVMpZmC2lq3U96yIeg0lXTn2z3WDdVrp8wmJAXiEKwELeOw
         qHKz7H1Yc64ahpnBO+u7w7ORTr0eOyaz0ER/vNeLHvX17XKKWlo34rsM4bKJUnejp3Iz
         l4KUphkMXXFY1RJ5EhN8EguMdLTq8LLNRHXtPTkiqDFpwbTwGfY4PbPy4shfFtUyHQuh
         7xx/gn1qdJbgrga9OM+ylpCnCIwk14r+kRKQzXIyCaJDKYurenjxicidujeGlkNmSy25
         Fp90tJQnn4Z4e7qfHHkCaosWAmCQI05MZT78fcfWF8CSTyA/1akA8YEyvV0LNsKTTzNO
         qC/A==
X-Gm-Message-State: APjAAAWFnLPl+vv6z6dp7maPWVn9o1Q/Bqh1JdrwiosMTU7RxzqcXJun
        oReNj1i3bvXIQKKSnEBk/kwJxpJR5SL9KRcuh7XPY9pAm8E=
X-Google-Smtp-Source: APXvYqw2mpipHKZXc6j5mvS5ExdEGILYRJ56MCHegbdi7Qcl/Zhz9ajUgzEptekDjCANHQgyjVBYn5LJ1l9Sak42td0=
X-Received: by 2002:a5d:9402:: with SMTP id v2mr5804806ion.128.1559296415235;
 Fri, 31 May 2019 02:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190531094900.12708-1-yuehaibing@huawei.com>
In-Reply-To: <20190531094900.12708-1-yuehaibing@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 31 May 2019 11:53:22 +0200
Message-ID: <CAKv+Gu9G_gLUWJrkKrDJkV74BBk9rizAGd1RCzaxniTJrTY7BA@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: atmel-i2c - Fix build error while CRC16 set
 to m
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, 31 May 2019 at 11:50, YueHaibing <yuehaibing@huawei.com> wrote:
>
> If CRYPTO_DEV_ATMEL_ECC is set m, which select CRC16 to m,
> while CRYPTO_DEV_ATMEL_SHA204A is set to y, building fails.
>
> drivers/crypto/atmel-i2c.o: In function `atmel_i2c_checksum':
> atmel-i2c.c:(.text+0x16): undefined reference to `crc16'
>
> Add CRC16 dependency to CRYPTO_DEV_ATMEL_SHA204A, and also make
> CRYPTO_DEV_ATMEL_ECC depends on CRC16.
>

Please use 'select' in both cases, not 'depends on'


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index fe01a99..7aebff8 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -528,7 +528,7 @@ config CRYPTO_DEV_ATMEL_ECC
>         depends on I2C
>         select CRYPTO_DEV_ATMEL_I2C
>         select CRYPTO_ECDH
> -       select CRC16
> +       depends on CRC16
>         help
>           Microhip / Atmel ECC hw accelerator.
>           Select this if you want to use the Microchip / Atmel module for
> @@ -540,6 +540,7 @@ config CRYPTO_DEV_ATMEL_ECC
>  config CRYPTO_DEV_ATMEL_SHA204A
>         tristate "Support for Microchip / Atmel SHA accelerator and RNG"
>         depends on I2C
> +       depends on CRC16
>         select CRYPTO_DEV_ATMEL_I2C
>         select HW_RANDOM
>         help
> --
> 2.7.4
>
>
