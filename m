Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA06B381F
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCJIIO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Mar 2023 03:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCJIIL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Mar 2023 03:08:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A267F6017
        for <linux-crypto@vger.kernel.org>; Fri, 10 Mar 2023 00:07:22 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5384ff97993so83648057b3.2
        for <linux-crypto@vger.kernel.org>; Fri, 10 Mar 2023 00:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678435637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw1klYT9RaIWxpFazeGMYob5ys/brYArmV5raMNaLPc=;
        b=Gyc+E3EVSuLRdPKcP7zO4yGyJhJPPLrVEpotEuxtrRoeDB5XL15J8EAqBlwRFVeCxY
         cuqAMfGM6nFKWutRwH4Q9WkgWvYK0o7yLqO94zXVS75wP/r/74/+ED4gpHdwexm4s3fb
         wkulb28BmXAbcjbuTKSFN+wT+eRn9ooHM1NOyzKk3RXTDc3xzba6fdcBAPXWH5Bw8nqt
         oXEfhxYQW1kVfNWskUbDHg/ijZLc49YYo1sTgwFtoz5YTyxOJ6K0TGqSMLGq1gRTt9ur
         sgK/LGn6LH7z43r0U2sSlCeJA/pl1nnPat9xu70I5YDlvHlmeg7fwvpOdjpPiB0sRB4k
         zb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678435637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw1klYT9RaIWxpFazeGMYob5ys/brYArmV5raMNaLPc=;
        b=QitYGcXhUbddVQbMYHUWXnaRj+GTM6qkyh+5zFhKHr8mKX7mCe+FlHZcsTEmvn4xlq
         ZqYqmcd3jSkv/RnAQegkL4Ojw8Ngay1oBkqBZm6/11uUeg0vF1aeczgTVmJKRMmN0GVv
         0vLls5FEE3KiawvWQv0ELoCmluf31ObnAwckuvIliUM5ejcDp4M2aCOkB63vmHoBxkt+
         zBAndmTdebvlB4DWKWQFG4bNuciXWD7FJH++8a8cQqPa27N0F2u0lqWoiAmbQ4K4BrlD
         XDd0vqvalX3nHZF0yo53gmtjgb2mZwP76QRTwJaXqzqtV4a9aSd/C5KnU6noPlJuyCdc
         0XUQ==
X-Gm-Message-State: AO0yUKVkrOx8uOtdgDZXuo4Ignl5/K6m6PhG0LYNJehoJ2qA52AAv0pA
        CEqGrxvHlndb61I4zviKRFMWFdfITkudMfGw79feOA==
X-Google-Smtp-Source: AK7set/1koA4JEyi13DQbf+nUH3Kr7dvQ7DrCg729Ix0wUh5BWCsFSbfKhGq3T1AbjISUEnBRDgBCNrqZ05XlO9SRII=
X-Received: by 2002:a81:4317:0:b0:52e:dddf:82b9 with SMTP id
 q23-20020a814317000000b0052edddf82b9mr16304287ywa.10.1678435636785; Fri, 10
 Mar 2023 00:07:16 -0800 (PST)
MIME-Version: 1.0
References: <E1pZ2fs-000e27-4H@formenos.hmeau.com> <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au> <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au> <ZAgDku9htWcetafb@gondor.apana.org.au>
 <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
 <ZAhfBmlNHUpGEwW3@gondor.apana.org.au> <ZAhhGch6TtI8LA6x@gondor.apana.org.au>
 <CACRpkdabjrpsiVgm=EyGrTK7PGXth6FdvxSp=QULA+LyqtdBgg@mail.gmail.com>
 <ZAl1gGCv51FKOXtm@gondor.apana.org.au> <CACRpkdY4gAT7RUtL6ctcsqxEX2_rZMyjMktPta7e4UB19OyGow@mail.gmail.com>
 <dac62e9452a5417e9de00546d1aae1f4@AcuMS.aculab.com>
In-Reply-To: <dac62e9452a5417e9de00546d1aae1f4@AcuMS.aculab.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:07:04 +0100
Message-ID: <CACRpkdZZ8ZoKjo-inJi7pwxF8FvfVn_ow1rgo0gdMCnok7ZmCw@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
To:     David Laight <David.Laight@aculab.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 9, 2023 at 11:19=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:

> > But actually I think the bug will never trigger, because the datasheet
> > for the DB8500 (Ux500) says this:
> >
> > "Then the message can be sent, by writing it word per word into the
> > HASH_DIN register.
> > When a block of 512 bits, i.e. 16 words have been written, a partial
> > digest computation will
> > start upon writing the first data of the next block. The AHB bus will
> > be busy for 82 cycles for
> > SHA-1 algorithm (66 cycles for SHA-256 algorithm)."
>
> What speed clock is that?

133 MHz.

> 4 or 5 extra clocks/word may (or may not) be significant.
>
> In terms of latency it may be noise compared to some PCIe
> reads done by hardware interrupt handlers.
> Some slow PCIe targets (like the fpga one we use) pretty
> much take 1us to handle a read cycle.

So in this case it's 1/133M s =3D 8ns cycle time, 82 in worst case,
so 82*8 =3D 656 ns < 1 us.

Yours,
Linus Walleij
