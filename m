Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0352A5E7B
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Nov 2020 08:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKDHB0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Nov 2020 02:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKDHB0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Nov 2020 02:01:26 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB843C061A4D
        for <linux-crypto@vger.kernel.org>; Tue,  3 Nov 2020 23:01:25 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id i6so25754403lfd.1
        for <linux-crypto@vger.kernel.org>; Tue, 03 Nov 2020 23:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0+geSVfngHw7V1gJiU5CRyKN92E5ZY/77T95s5S89Cc=;
        b=cGz6lfnzAtWinfumR8utHxHPY1Yna6vD8cfkMr2aE1yYstnyScsLKXWOKwrvE5lc3s
         OIyEWb20WgwDM9gWZ/HQVwmPMx70fDnV3Yw7F+mB7Yk3RpWY1OEvmiCfN59FGS5h2hE9
         YFYCMrLmbTjuR993AZT2UY+NO/a2SaKKjn+Gx2LIKetZuZXojsKQ2SQIaIh9pcScAO0k
         RUAUiwacn4TXn4S0yKSf/MUsw6PS6/YkGGWO5rDsBAOXKfDM2f8iwx84LWzqJ79Di2mX
         sofT19/QMzKSsiYrqaH2ZgYllULCbDKhGbknY1LTSXNpFhK4E84CoQHS5LtlLh66WaBI
         JuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0+geSVfngHw7V1gJiU5CRyKN92E5ZY/77T95s5S89Cc=;
        b=a70IQHo1zdo+ZAzOhh9HdtwAYcp6mI9rUkkf8P3utW45p7r3t4VTLMDhzBIq36RuML
         JohPPEeEJZuhZGuIwU1lc9MWUC5SLc5qLkZMNrkViC0s3Di0p5Hcrx0WpDFu8vhGnDH4
         RwhBY6h1dPRnRjz16VAtKM+ZmS/Qh5uhDHeoTR4x5bFN1rXMyBL/dMuZGH3/1SUHZ94G
         G3TysoDHXRV7rKFtWjB9RFv7hPYy2A9V39pi3eJowccYqxNC+2DZYzN4v9N7vIie/2Zb
         r8IV0YjNle2McARzg3yTaijxvE7SQq7RTrBJKFRezkL9gW3Ga5pnEzIytE5NM4YtuW8/
         vwGQ==
X-Gm-Message-State: AOAM531YF9SHNdxmrLEvyvxhxw1s+ezpZiEcUtXruZtyBE/exY8vhlH2
        xum4IF1/Dp7aMe5tUu0Mu3BjPISOyqvbEJqjD34=
X-Google-Smtp-Source: ABdhPJyjWBZldZlB6GdbZiLNEOHfIQ52AZ0t9Jn1RA5yXiAiR6qNNO7ofppVq0tQHHUPFPRf326yPou+OM5Q389MsU4=
X-Received: by 2002:a19:420d:: with SMTP id p13mr8500011lfa.422.1604473284263;
 Tue, 03 Nov 2020 23:01:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:cc58:0:0:0:0:0 with HTTP; Tue, 3 Nov 2020 23:01:23 -0800 (PST)
Reply-To: miss.jeannettebryan@yandex.com
From:   Miss Jeannette Bryan <misslindajones11@gmail.com>
Date:   Tue, 3 Nov 2020 23:01:23 -0800
Message-ID: <CAKYjb0iHL9wnzU9ReUCXW0_0JjSkYWWEC9atCFUvupoKh2kLkg@mail.gmail.com>
Subject: Greetings from Miss Jeannette Bryan.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings from Miss Jeannette Bryan.

How are you and your family doing today?Hope fine? I would like to use
this opportunity to introduce myself to you. I am Miss Jeannette
Bryan. My parents are Mr. and Mrs. Dikko Bryan ; my father was a
highly reputable business magnet who operated  Sao Tome & Principe
during his days.

I am writing this mail to you with tears and sorrow from my heart.
With due respect, trust and humanity, I know this mail will come to
you as a surprise since we don=E2=80=99t know  each other before, and also
considering the fact that I sourced your email contact through the
Internet in search of a trusted person who can assist me.

It is sad to say that my dad passed away mysteriously in France during
one of his business trips abroad. Though his sudden death was linked
or rather suspected to have been masterminded by his half brother who
traveled with him at that time. But God knows the truth! My mother
died when I was just 6yrs old, and since then my father took me so
special.

A month before his death, he told me that he had money left in a fixed
deposit account in one of the leading banks. He further told me that
he deposited the money in my name. He gave me the file to this fund
with the bank.

I am 21 years old and a university undergraduate. I really don't know
what to do or who to turn to here. My uncles are only after what to
get from my dad=E2=80=99s properties. They have shared the landed propertie=
s
amongst themselves claiming that our tradition does not permit a woman
to inherit anything. Now I want an account overseas where I can
transfer this funds and after the transaction I will come and reside
permanently in your country till such a time that it will be
convenient for me to return back home if I so desire.

The death of my father actually brought sorrow to my life. I also want
to invest the fund under your care because I am ignorant of the
business world. I am in a sincere desire for your humble assistance in
this regard. Your suggestions and ideas will be highly regarded. Reply
me on this email for more information: (
miss.jeannettebryan@yandex.com )

Now permit me to ask these few questions:

1. Can you honestly help me from your heart?
2. Can I completely trust you?
3. What percentage of the total amount in question will be good for
you after the money is in your account?

Please, consider this and get back to me as soon as possible.
Immediately I confirm your willingness, I will send you my Picture and
also inform you more details involved in this matter.

Kind Regards,
Miss Jeannette Bryan
