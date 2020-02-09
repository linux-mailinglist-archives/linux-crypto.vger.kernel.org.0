Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214DE1569C4
	for <lists+linux-crypto@lfdr.de>; Sun,  9 Feb 2020 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgBIJMQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 9 Feb 2020 04:12:16 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33681 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgBIJMP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 9 Feb 2020 04:12:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id n27so2279205vsa.0
        for <linux-crypto@vger.kernel.org>; Sun, 09 Feb 2020 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaRo0DyGZ3JEibnWQUuqaMdipbBAOildr4YngTtGzS4=;
        b=za6voBik9xca17vJt6IsXS/BJA6UkpR54wHiykt8Wa3L3RuwWMjeyWnE4wK+Sgk0a6
         SWR/57/jufqmiPnd2sY05aZvDyFo/FlJGdF8jGkxdimq7knamxOqOGM2+FcaD6JAvlGO
         Bl/zZnoCJ2J3yyZBYvHUVY15kgsU9eABQW0B267mCQD+QihfC+/FQ31fvuQfk6TuhimA
         07rF4zU7KigBu98Url7eE/REbC3mSwnmVq0TEJc8Y9quuhnmEXRR5EOzVaYJuhXBbfmi
         rpHEzhdA/DDZQ5QNnjCYE2gseqrOaddsy3JFLk6fAckP7pdPsaCFuspQCPUTZCOUBdKt
         1JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaRo0DyGZ3JEibnWQUuqaMdipbBAOildr4YngTtGzS4=;
        b=O3xY4MxLCAPHoQUDzYpImaOS/6dv4w8hbwsRqwAo5pywhVEBWSGjCVnXkdLsDhTEEa
         Qs6QbiVb5SU5MIVNxFRTCFEML1f0iPNFzPSQZs5hEWxR7sTCC2r2yQ7Ef4D5Gk8vPHyv
         bC8CGel/VJxcJDkGMoYK6P45yjFLcp2XuJfmlUSbqIZvLpOntkagRPy4PsgxDlnjNj4E
         CYZCWSHDfQygx0mDRC8g8If9f9G4o8tMAJ09djnHHzG6TCYibgs0wV3wRi+kjADSkYf/
         mlkAM+ohemj0RxguFJonr7dibYBJR5PSrPAnCP8xSXWU3A7/ZoZ0O8m4jEDFkb/by3D3
         frvg==
X-Gm-Message-State: APjAAAVMsp54YS/rYHv+LBsxe2n9KDXZKVo4GS8PTSy6+S5buIGEqdFS
        OWzwYJHKEhw4TENHZjX31RFCUExhQq9prxizmGJtBQ==
X-Google-Smtp-Source: APXvYqwQexAgKAy3Dlat76o1Ft/+eitvGa8VRzFGeqWMYrG+oxpDX33F2OG0XGAzXbA1+OrWD1M4P+PylDNemJcaWd0=
X-Received: by 2002:a67:6746:: with SMTP id b67mr3658804vsc.193.1581239532982;
 Sun, 09 Feb 2020 01:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20200202161914.9551-1-gilad@benyossef.com> <CAMuHMdVgxBx2x7=nTK0HtvufMNBGLruUD6Y1a0pSnX+CDsvCDA@mail.gmail.com>
In-Reply-To: <CAMuHMdVgxBx2x7=nTK0HtvufMNBGLruUD6Y1a0pSnX+CDsvCDA@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 9 Feb 2020 11:11:58 +0200
Message-ID: <CAOtvUMdE-5DiLAKBM1bPXme+EmGrmjK+AYzN0Zz2LsF4WBQ9Xg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - dec auth tag size from cryptlen map
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        stable <stable@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 6, 2020 at 4:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Gilad,
>
> On Sun, Feb 2, 2020 at 5:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > Remove the auth tag size from cryptlen before mapping the destination
> > in out-of-place AEAD decryption thus resolving a crash with
> > extended testmgr tests.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: stable@vger.kernel.org # v4.19+
>
> Thanks, this fixes the crash seen on R-Car H3 ES2.0 with renesas_defconfig,
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n, and CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks again for your help.

>
> Remaining issues reported during boot:
>   1. alg: skcipher: blocksize for xts-aes-ccree (1) doesn't match
> generic impl (16)

Yes, this is actually a known issue with the generic XTS implementation.
See: https://lore.kernel.org/linux-crypto/VI1PR0402MB34858E4EF0ACA7CDB446FF5798CE0@VI1PR0402MB3485.eurprd04.prod.outlook.com/


>   2. alg: aead: rfc4543-gcm-aes-ccree decryption unexpectedly
> succeeded on test vector "random: alen=16 plen=39 authsize=16 klen=20
> novrfy=1"; expected_error=-EBADMSG or -22, cfg="random: may_sleep
> use_digest src_divs=[4.47%@+3553, 30.80%@+4065, 12.0%@+11,
> 6.22%@+2999, 46.51%@alignmask+3468]"

Yes, I am working on this one right now.

Many thanks,
Gilad
