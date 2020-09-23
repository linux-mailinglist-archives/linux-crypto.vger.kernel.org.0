Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A658275F6C
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Sep 2020 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWSGN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Sep 2020 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgIWSGN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Sep 2020 14:06:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30714C0613D2
        for <linux-crypto@vger.kernel.org>; Wed, 23 Sep 2020 11:06:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so940396wmi.3
        for <linux-crypto@vger.kernel.org>; Wed, 23 Sep 2020 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rBQqEcNI4qmQoA7TvV4cKxPn9VpIANl2GdIqii9bNbU=;
        b=ueL9XXI+GUUtrlNnir3mOL/bIGZr6jNjX0YvFnEppBB+t7oi2t723yNVDI4ZUdLeJt
         pPeQBRbm2R0RiKsD9uUrcCUGcW/svCrTyfuR2+8cWGmx7WXu0lfuJDGbNB/lE+P7CcE6
         vrDbP5b1klSs3fbRQAFv4SBuSTZp66AhBw/NCzFv1EOtSvTHJx00A/+aZ1Ho0qh3Fs8+
         MBrmy2t4ZKhOqI2P8MDOI78ActrU+Q9nRQ8C0TNaiBw/BkMPj6LdX7ZSRP1wADeQ4OUy
         aRAJ3r2mgYe4Lno0nLsE0KMOSNfN9asYiR+2Y0tqt0e9fKSMoXl9aGOk2U6h6OkOE70D
         RsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBQqEcNI4qmQoA7TvV4cKxPn9VpIANl2GdIqii9bNbU=;
        b=pGN40C5Bu0iC+9BMayLJCK51B9TpY5Wlp6M9/pPT+GJ2bXjfwRCYJ4SOBdkRgVp1Wr
         6AX8iq29fSIG2xZJLs9PefLfusTwwIrlW/YIg2rfYZwf3ApwEUxw4uL9ZXH6uI0+q9v+
         9xgLQFIEEEwl9fPqC8Xkd3ReMOIt0HorWfSSDZPozLZrYDnfPlPw3CgbSnaBRkaD8wlm
         MnuvlObjqXf547i6FebUGlPDSQtOzUuokjT8Crdghh9huznBwQNJXaBLJ61RBa68kD4a
         rZ1jxqByCQ/xWwJlcg4k8U3YyaRLdpH74QuddGqtWpRG0YENC3IkGg6VAaKJDoQqzb6Q
         fClw==
X-Gm-Message-State: AOAM533rXcGC6NjYZmmQcjbs552y4KIbJTnyxeAlc6BHDhX+UPXcrStH
        5dkB10yLxsQXB8obTLOxFTN9HA==
X-Google-Smtp-Source: ABdhPJytV9q3vh1dokw73NDu8zEDyQey80TL3qbLRsyGW990BMBCXndofi3MAqXrMN/rc9rF3zxoNA==
X-Received: by 2002:a1c:152:: with SMTP id 79mr800490wmb.90.1600884371787;
        Wed, 23 Sep 2020 11:06:11 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o16sm541123wrp.52.2020.09.23.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 11:06:10 -0700 (PDT)
Date:   Wed, 23 Sep 2020 20:06:08 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] crypto: sun4i-ss: handle BigEndian for cipher
Message-ID: <20200923180608.GA26666@Red>
References: <1600627038-40000-1-git-send-email-clabbe@baylibre.com>
 <1600627038-40000-5-git-send-email-clabbe@baylibre.com>
 <CAK8P3a34V16PUoVJjoUOVCik_rdb6vAy=54qRzWdO+aJcwUwsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a34V16PUoVJjoUOVCik_rdb6vAy=54qRzWdO+aJcwUwsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 23, 2020 at 04:00:32PM +0200, Arnd Bergmann wrote:
> On Sun, Sep 20, 2020 at 8:37 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> > Ciphers produce invalid results on BE.
> > Key and IV need to be written in LE.
> >
> > Fixes: 6298e948215f2 ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
> > index c6c25204780d..a05889745097 100644
> > --- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
> > +++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
> > @@ -52,13 +52,13 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
> >
> >         spin_lock_irqsave(&ss->slock, flags);
> >
> > -       for (i = 0; i < op->keylen; i += 4)
> > -               writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
> > +       for (i = 0; i < op->keylen / 4; i++)
> > +               writel(cpu_to_le32(op->key[i]), ss->base + SS_KEY0 + i * 4);
> 
> I suspect what you actually want here is writesl() in place of the
> loop. This skips the byteswap on big-endian, rather than swapping
> each word twice.
> 
> The point is that this register seems to act as a FIFO for a byte-stream
> rather than a 32-bit fixed-endian register.
> 
>      Arnd

Thanks, using writesl() fixes the warning, but I need to keep the loop since the register is different each time.
Or does it is better to use directly __raw_writel() ?
