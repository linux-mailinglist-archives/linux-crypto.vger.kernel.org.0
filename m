Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEC41A91A
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Sep 2021 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhI1GzV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Sep 2021 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhI1GzV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Sep 2021 02:55:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1091C061575
        for <linux-crypto@vger.kernel.org>; Mon, 27 Sep 2021 23:53:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so3542982lfa.9
        for <linux-crypto@vger.kernel.org>; Mon, 27 Sep 2021 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RkjMpeIuQ6aVWCs6FPMVIVUmVZwq7aWhwwHDvLPHoTA=;
        b=SLi+XioDaqQmTbd630gCbmYjBtTXmeNWxear1oZVVOrDzXw485dutYdbXHdz3DwhhS
         DFl7QLLqs0pOVMouWddiTvjlKMSJR/sgvGcxvsFLC7krX2zyYVYmUYTxBDBS9hxCz5JF
         r+YUpLNU8JsswOVSZTX6BcTwyjFXcMg6pSMFWB/Uq+0vf9vdPDE3qCIwxe5zNzROPQF6
         LnMZAw7gE2JZldtZ/c6rVoZGIttFZQjlltq1ACdnTaNIPn8mEPX3Mx9OZyz8wvcKZl/J
         PiZKfIlXAI1dWvhJF0QKLh102kSv1IOlxArEcJAbvBFJObcSRjr2fbe5DHe+/+gz5XJm
         cC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=RkjMpeIuQ6aVWCs6FPMVIVUmVZwq7aWhwwHDvLPHoTA=;
        b=yqN3Vmr0Kfx6arUvCwmAlFxzFLpTpUUKLiAEwq67Joz8sWaXSVLqUNsmL+WHRP5LIC
         Hwe+JlolHwDk91BuQoCUhjjP3V5jkSkOiyxVWbk3UxHJ9rRSWTfJ74qsbUG6MH6brVBZ
         iGK+lIBnVcKAbE3Qb64hfHy5bxe49KBUIVPqx8pjAC9yGjxlSnx7e4M4GzzTUuSGbh1U
         p6/cEAyMBjFhOOVLoOJVw2oe37ZNmAO6tTlixxr0OF40xAcIrLl4sN/jM6g08GOx1VtX
         w/CuumkduDOqiKJ55mClgzuaAREbBxTu/mmb5F/nGTxx53ahHJBW8QgxIFfmpg6Tdlhn
         nDyg==
X-Gm-Message-State: AOAM531aLG74VkmK33b4fsu10kxaLfQaukpw0Q8wjhlpst/mDqCrjW2M
        JakbB61tLq89siAnPnR8/DtabZfv9WnKZsQel4g=
X-Google-Smtp-Source: ABdhPJxmfUqau1QxG28+nbebSaJEsTs13AS5vBA2TVnI644R0xpV3hOVPmfW5Ecy7q6/4kW/fVOTA+oOSuaVTq5+rPc=
X-Received: by 2002:a2e:8603:: with SMTP id a3mr4273692lji.142.1632812020147;
 Mon, 27 Sep 2021 23:53:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsdaniella.kyle@yandex.com
Sender: mrsrachealgoodluck1@gmail.com
Received: by 2002:a9a:6c41:0:b0:147:34b8:29a8 with HTTP; Mon, 27 Sep 2021
 23:53:39 -0700 (PDT)
From:   Mrs Daniella Kyle <mrsdaniellakyle6@gmail.com>
Date:   Mon, 27 Sep 2021 23:53:39 -0700
X-Google-Sender-Auth: Ue4yDyvuqd_Y9_0fcdE4K2iK1Xo
Message-ID: <CAAQ9gCf9-W1fRoEy+zp_XLPiDkaMApbvugXGq8TdY2rkCBW-EQ@mail.gmail.com>
Subject: Re:ATM Visa card compensation, Thanks for your past effort
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Good Day,

This message may actually come to you as surprises today, To be very
honest with you, It is a joyful moment for me and my family right now,
so therefore am using this opportunity to inform you that have
successfully move to Vietnam where am currently living with my
business partner who assisted me to complete the transfer, but due to
the willingness and acceptance you showed during my pain have decided
to willingly compensated you and show my gratitude to you with these
sum of $950,000.00 Nine Hundred and fifty Thousand US Dollars).

I want you to accept this amount it=E2=80=99s from the bottom of my heart,
have issued the check and instructed the bank to roll the fund on a
master card for security reasons, you can use the card to withdraw
money from any ATM machine worldwide with a maximum of US$10,000 per
day. My bank account manager said you can receive the card and use it
anywhere in this global world.

 Go ahead contact the Global ATM Alliance directly with this below
information. Email Address:   maastercarddeptme20@yahoo.com

The Company Name: ........... ....... Global Alliance Burkina Faso
Company Address; ...... 01BP 23 Rue Des Grands Moulins.Ouagadougou, Burkina=
 Faso
Email Address: ..... [maastercarddeptme20@yahoo.com]
Name of Manager In charge: Mrs Zoure Gueratou

Presently, I am very busy here in Vietnam because of the investment
projects which I and my new partner are having at hand, I have given
instructions to the ATM Visa card office on your behalf to release the
ATM card which I gave to you as compensation. Therefore feel free and
get in touch with her and she will send the card and the pin code to
you in your location in order for you to start withdrawing the
compensation money without delay.

Let me know as soon you received the card together with the pin code.

Thank you
Yours Sincerely
Daniela Angelo Kyle
