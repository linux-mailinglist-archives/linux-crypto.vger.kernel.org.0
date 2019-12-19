Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA9125FD1
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Dec 2019 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLSKtg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Dec 2019 05:49:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35489 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSKtf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Dec 2019 05:49:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so4629459qka.2
        for <linux-crypto@vger.kernel.org>; Thu, 19 Dec 2019 02:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deId2JVQ12jlGeQHYsi9LkbuFlqPgIP/ixlZ7XgRV7I=;
        b=W54SHQ5dlTm6SThWjY6Bc5SCBNejl/zWftJRnsauXNSyNMSdUA2HX7Q9hbbKpOmyE6
         lBPZXrRNUT0G5Dhea3G7dyDt5gVpYE4CknR0ofVlj+TBFuiqi5w/Ox2hX93OkAzwWewx
         zlY1BmrW997a+ZNGk4lECZBdofKldism9dtxUfd3bOZfPKfLioHTJAQ26aCJMicC/4z5
         ijuY7OAnvYvCoG/VgM39BURMYHeO1cPruRHJIOqPhXqbpsfGPv9rHQzMglUx/cAu+F4j
         k6FFeRNotAB9W0Ae3zjq5eg6nvI1JwAFmxtBAsObUEtiYfu30ehBlm4FXWc/tOtMHfJp
         CI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deId2JVQ12jlGeQHYsi9LkbuFlqPgIP/ixlZ7XgRV7I=;
        b=hQxLQEIKcxaobdGdvXqVbn5Qi99+hHkIHBYseT3F+5qTWBpY2LnY4MQOhxCZZE5P3p
         8m7iRTqSEnza9ECBgynr4kZrOKq6HO+y0nsPdrpvKaF78/lvXhuuG0tCNBZ00jF9LqYI
         NNqnZ0BOB1t2/G7T22A2WeQZnCQ7ML+fAB1GwRHv7iOM62HsRYDriZxwy878h1YZBQl+
         GMcEsv7YJBA1cKmW7GeXIXocSsQgnj+MmjpdhcrsPSNuzbA+8UwW8Of2WAI5cW9ERh9O
         QzwUhKrmb1noDY8XjiqaSY4h8sU9qbKPjK3eRIpmkEsTjisCkR2Mw9XOBYBJXi/VLywK
         xkgA==
X-Gm-Message-State: APjAAAXMcsMpCxZsliwisRtuUuTD5eH4A3AH6C6JOrKBkfGHjr+RNvF6
        P847ucjnNTdUEPTLO1ePkFS07iohM7PGUHalPqqZWbZjlTk=
X-Google-Smtp-Source: APXvYqzwhtA5yupYMnkUb/LMNdluvQ09zvtZWL+0pPgsXyWCWFF/OnGQd/gYwoadTMrw8erMOsfI9zjM4+SudhHRHf0=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr7186389qkg.43.1576752574661;
 Thu, 19 Dec 2019 02:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20191208232734.225161-1-Jason@zx2c4.com> <CACT4Y+bsJVmgbD-WogwU=LfWiPN1JgjBrwx4s8Y14hDd7vqqhQ@mail.gmail.com>
 <CAHmME9o0AparjaaOSoZD14RAW8_AJTfKfcx3Y2ndDAPFNC-MeQ@mail.gmail.com>
 <CACT4Y+Zssd6OZ2-U4kjw18mNthQyzPWZV_gkH3uATnSv1SVDfA@mail.gmail.com>
 <CAHmME9oM=YHMZyg23WEzmZAof=7iv-A01VazB3ihhR99f6X1cg@mail.gmail.com>
 <CACT4Y+aCEZm_BA5mmVTnK2cR8CQUky5w1qvmb2KpSR4-Pzp4Ow@mail.gmail.com>
 <CAHmME9rYstVLCBOgdMLqMeVDrX1V-f92vRKDqWsREROWdPbb6g@mail.gmail.com> <CAHmME9qUWr69o0r+Mtm8tRSeQq3P780DhWAhpJkNWBfZ+J5OYA@mail.gmail.com>
In-Reply-To: <CAHmME9qUWr69o0r+Mtm8tRSeQq3P780DhWAhpJkNWBfZ+J5OYA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 11:49:23 +0100
Message-ID: <CACT4Y+YfBDvQHdK24ybyyy5p07MXNMnLA7+gq9axq-EizN6jhA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 19, 2019 at 11:11 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Dec 19, 2019 at 11:07 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Thu, Dec 19, 2019 at 10:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > That's exciting about syzcaller having at it with WireGuard. Is there
> > some place where I can "see" it fuzzing WireGuard, or do I just wait
> > for the bug reports to come rolling in?
>
> Ahh, found it: https://storage.googleapis.com/syzkaller/cover/ci-upstream-net-kasan-gce.html
> Looks like we're at 1% and counting. :)

Yes, that's it. But that's mostly stray coverage.
wg_netdevice_notification I guess mostly because it tested _other_ device types.
And a bit of netlink because it sends random garbage into netlink.

For netlink part it would require something along these lines:
https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_devlink.txt
https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_crypto.txt
https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_fou.txt
https://github.com/google/syzkaller/blob/master/sys/linux/socket_netlink_generic_seg6.txt

And for device setup, harder to say. Either pre-create one here:
https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/executor/common_linux.h#L668
or teach it how to create them on the fly or both or something else.

Probably some wire packet formats here:
https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/sys/linux/vnet.txt
