Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB046F8B6
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Dec 2021 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhLJBsY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Dec 2021 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhLJBsX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Dec 2021 20:48:23 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED0C061D60
        for <linux-crypto@vger.kernel.org>; Thu,  9 Dec 2021 17:44:49 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so8194006otj.7
        for <linux-crypto@vger.kernel.org>; Thu, 09 Dec 2021 17:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eO70K6UpvUWOOZ26eI9byqpsVA1ZqLATKw9Ubqfa08=;
        b=vwyKOTWHjgLrit+GLm9IJ66Zn1fCOfM1L+YBmfjIKF1WCwaK3dzS3Olklz2j83VtRo
         T4jlfQ0ubaLPKehFAlrC5ij37ETxxxsBxSQnoBTcj8pr2AENLzTyfqQps4Lke9spO05l
         xk4vf9rHG9Ijo3AkNslw7pY7KKVDKQ5kmk/XOcky9KW+dCp1njcukQO+fH1g5yqUNVkm
         eq2GwY8m1SEXsiDwtX55G9M3F0XmWaufzrVVBA9fIbADOXtbBGVaLVD7JUHJhraR9vAY
         ClB67OR58t4WytNRPFup+KydBuZ0oEjeceswc8C+g4c3wFfNF5RQoLM+yd69ac1wWbi1
         nugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eO70K6UpvUWOOZ26eI9byqpsVA1ZqLATKw9Ubqfa08=;
        b=wwtBrxhkzHikzIHTHW+ZI9dxwjcub/MRoFNzyP7nTvQrYVSc8xo9MtT0wSn0Hy+jb5
         /MsnIweuHc1foFA31aNNYke6nqCdr+iJDuht836ZNb+cUaKRgClR/HruL3OlpY8Wxod9
         DcwqLLHau3rVgS9ZA7YftK5z/sKrTNmQiu/zGNXJXNc/1zcmoJF7boXFFZi3L06/8V9+
         evrFCexfMtEuh8TFVikCuu42pimHrnSFgTd9sU1c9WHYegtXP7feG+V6mcVr1mnOX9u2
         LglZRwwmtTSXn84/Du8d6GZrSP/RbuuRasOqNelizXR9ec0oGOVxqIuG2aw9rsaYyMR9
         kalg==
X-Gm-Message-State: AOAM533uHy1FkRPrp9kVwWeKC13HxV+vA/T7ReMgonPoXXdyOLHIn5K+
        0t5P6JtZu/Jww4t1Tp/z8RC8TaYKluaECr+jzWXkew==
X-Google-Smtp-Source: ABdhPJwGGn/Iig24LM6iz+DDamWnJx6uVjLFPjLZrobVVHzAlLnv6hIu3SxbsvwG+AZSo3Ul47rGkcksDTGd/v0hlu4=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr8654576otl.237.1639100688280;
 Thu, 09 Dec 2021 17:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20211208003727.3596577-1-f.fainelli@gmail.com> <20211208003727.3596577-6-f.fainelli@gmail.com>
In-Reply-To: <20211208003727.3596577-6-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 02:44:36 +0100
Message-ID: <CACRpkdYmCT9imMFY_0ZHebAYj40D3m48X+DZnjPUGgAqHEpZqg@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Gregory Fong <gregory.0xf0@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 8, 2021 at 1:37 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
> validation.
>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
