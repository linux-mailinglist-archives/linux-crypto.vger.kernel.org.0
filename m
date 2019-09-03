Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FBDA633D
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Sep 2019 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfICH7X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Sep 2019 03:59:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33300 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICH7W (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Sep 2019 03:59:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id s18so3636509vsa.0
        for <linux-crypto@vger.kernel.org>; Tue, 03 Sep 2019 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0EIbhIJ7hKKOu+M281PD3WDdpKkR/xA5QEVwHRycTR0=;
        b=Lz8LMQhaTxdacgyadkkNlBcEe9tBTF6g2Stqiw+ggeQ7ZvzWzCXwwFaRgbu9gGjYIl
         lgs+jWRb+B//qn14IUPCm+BKxLLp6MDvUFnr48zd67gqoulkvMMMO7QSPs3Qkbd7v8P2
         JzYL1VGYv+8pWnDDfFUDPiWQQkJiYEnRnCJaSBagiDgg9QOVn4SMhr8aBCHZIfuaqxsA
         CNJLraj+UCdJwt91JZNtqo7j1SepslMoRtYWz4L1i680RXznMVpqYXudJKJl0rieosxa
         hHtqI/xZz2533ni8GMtVguyDb49VMP0btKTr1dDiPWMatQC9ufxj7i/+rXCJRzbDPl7G
         McwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0EIbhIJ7hKKOu+M281PD3WDdpKkR/xA5QEVwHRycTR0=;
        b=UBDVvWoQBDnNJJ2KTfitbpR8vCTykQiuamqZ98vwJhd6r5zT30q1+WTeuDYTC6nXVr
         GSGmitOudzC8XR7vV8SSBF4ZceI+4OJthNww8EbJRdYfkXoggTUNxcwBn/OD3W/33Lu3
         pfpfUsNHvu4SU25Ee9gCOqgjdPwdUih+9fT6Y4oPIraf8DnM8Ch70tQATtggmMWXIxIn
         ZpbN3zX3hfgxmY56WuAm3QRp5333HJowZIfUlgBLRPZvI3zpADFO5aIpTOb6gkc6ZS3O
         JTPAA1s6vA3PMgdGmTwz8LUMeRpMnAV5+C4VwmZdkDvl9wwZR1iOmNlWHW2aeYVkYN4i
         TnVw==
X-Gm-Message-State: APjAAAU2ZF5sON6gEoyL+ldQCTT3XVbELJIq9tWlWalnQAZJDZNpI+PH
        R8e4O/egL9EccPkgnSVUg4+mSoSnSzDXKlRNB8U0MQ==
X-Google-Smtp-Source: APXvYqzLbfk+7QC7rLnbvGPNJsbo//EE9HrvhMXGdOD64gG+wjNiviukUFKpbMwLXQphsPJJIcfQjKXRlkCVUjoLzNE=
X-Received: by 2002:a67:f546:: with SMTP id z6mr17083944vsn.136.1567497561775;
 Tue, 03 Sep 2019 00:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190901203532.2615-1-hdegoede@redhat.com> <20190901203532.2615-6-hdegoede@redhat.com>
 <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com> <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
In-Reply-To: <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 3 Sep 2019 10:59:10 +0300
Message-ID: <CAOtvUMeK2+29PJBm6L1S0dqM8JXEZYUy1qKiP9H=xDEJjnO7mA@mail.gmail.com>
Subject: Re: [PATCH 5/9] crypto: ccree - Rename arrays to avoid conflict with crypto/sha256.h
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 3, 2019 at 10:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-09-19 09:45, Gilad Ben-Yossef wrote:
> > On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wro=
te:
> >>
> >> Rename the algo_init arrays to cc_algo_init so that they do not confli=
ct
> >> with the functions declared in crypto/sha256.h.
> >>
> >> This is a preparation patch for folding crypto/sha256.h into crypto/sh=
a.h.
> >
> > I'm fine with the renaming.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Your Signed-off-by is only used when the patches passes through your hand=
s,
> since Herbert will likely apply this directly that is not the case.
>
> You want either Acked-by or Reviewed-by to signal that you are ok with th=
is patch.
>

Yes, you are right of course. Wrong macro... sorry about that.

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
