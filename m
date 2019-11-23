Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D63107C11
	for <lists+linux-crypto@lfdr.de>; Sat, 23 Nov 2019 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWAjw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 19:39:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37214 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAjw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 19:39:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so7797925otp.4;
        Fri, 22 Nov 2019 16:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEgHxCiyiX1vvVmymHFYVTUbODIbpTwPwyJWeOdOzsw=;
        b=qb5tY8LSdp1kdAtsevy+g4bauZLPdinL756/2GiLNpXLZETJYA83hlhms2DY1froNX
         5OlnvVVKn+hli0yPq52cWpGdv/Dm+x7WTB58g5qYHW3L3UNMPWDMpE4/IJMmADNeNBli
         cbbiIWiYGcnWPf2iwFMViWvP2UTgYg5YTxM7J2h5fPxMx6Z90hfz15nSnHT7lHZ49SFm
         gATydOT5isq0f7mYsW22zUacoUjPF8pMZYv+bY9HNpnMPiqxaMpvGu3RJmP/kbUsqk0A
         XzNePINk0pibQxidy1jt7cr9aWD5l/2hou70Q4qshFcbgM3XiLfdA+JECDBveuvAaawa
         8sig==
X-Gm-Message-State: APjAAAUCJfOieUHOWltiNgo0tUpL7AqH35lN5S+TmUPvgAhrcXfpV2CA
        swAEf6kfrrP/C5olUdC79g==
X-Google-Smtp-Source: APXvYqxyABAixVX6UI5qvZ5b6JowXXc/TuRvG5WegziVxYCjLu6SH7n/ghlJ1SoD2w77Id8T2Mgupg==
X-Received: by 2002:a05:6830:2006:: with SMTP id e6mr13247748otp.260.1574469590171;
        Fri, 22 Nov 2019 16:39:50 -0800 (PST)
Received: from localhost (ip-70-5-93-147.ftwttx.spcsdns.net. [70.5.93.147])
        by smtp.gmail.com with ESMTPSA id u143sm2632482oia.14.2019.11.22.16.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:39:49 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:39:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     stephen@brennan.io, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: rng: add BCM2711 RNG compatible
Message-ID: <20191123003948.GA13973@bogus>
References: <20191120031622.88949-1-stephen@brennan.io>
 <20191120031622.88949-2-stephen@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120031622.88949-2-stephen@brennan.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 19 Nov 2019 19:16:19 -0800, Stephen Brennan wrote:
> From: Stefan Wahren <wahrenst@gmx.net>
> 
> The BCM2711 has a RNG200 block, so document its compatible string.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stephen Brennan <stephen@brennan.io>
> ---
>  Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
