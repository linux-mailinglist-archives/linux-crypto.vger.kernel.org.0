Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD84B913
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Jun 2019 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfFSMtO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Jun 2019 08:49:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33043 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfFSMtN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Jun 2019 08:49:13 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so37913417iop.0
        for <linux-crypto@vger.kernel.org>; Wed, 19 Jun 2019 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faG/I5L5O64iZX3wK/LK9TkDFfK1KrG3bylwNO9vZC4=;
        b=EYvm4nLNVkbxf6Y1mBcvQpptZxhwgHOw6SalKjBwSA32lrfQuYQl5YtvzpCYgeFeKx
         IFqAcXWlttp+HyRzjlxYr7e4r5J2BZb2Fkf/MfGYZGodfNYyjKRO1xRE0PziFs3VdRs4
         kCDyCXXMWlkA10KcD9W10q/CfcVxHQ92vFCBTiPCfzBKU64C5K/SRbe9W1+jIa3h6hUT
         Mj7YuAnbSpH5RCJbj/e9bNU09TC9KXjHAeFm2mlHk+GjTKUYCweN25CHi2dpLhp13+l3
         h8NCm29DEOAR9tIponJt/dmAfOWegPDesYC0IptaYLABEEuDncclzrqT8AUq+K/bkRs/
         J3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faG/I5L5O64iZX3wK/LK9TkDFfK1KrG3bylwNO9vZC4=;
        b=AWx2M9zzYOatzUTtprGA/N0raZrzhU+x6CLgqqfYyT481L/32XiTWKSc/kEVHAWDnq
         YqnKEbOmRALXa3dKD5U8XdesGwwTi3bHrdTFiFCDcEJuxWI9tPixYCpX6zM0DtAEx3RW
         t872zUyCOYUuhTJGIEZoYl3y6mg4Uh2PsvOAO4/F9CMxyjcQgV1Hf0BQNuZXpoe9lzhG
         1nUnWSLbwtwoJ/CNOIxBEAY/63GTtXF4yxRoDGW2uRFIx97RXEAUDTzIEzZYrDkWNSrM
         HCq9NiIjyjIJTI+Gn+suNKs4MjlCq15o7dlLdbhIEXzaiNzhjGGznhFHLTr9LXBq++kU
         sTJg==
X-Gm-Message-State: APjAAAWp4exmJwibLksaY7IS3sDCvdOrBD+t+C1TVEplKYTX/+2XdqHl
        MNIz16zD2OVRDhNfnyPm5eBsPwW9KIHpDX+WXv6+zw==
X-Google-Smtp-Source: APXvYqzRcMuq5XNUWEu3mtRfQNKEUWRpNvECOkLF4wsGTX9R6rUHP5bFIhp2tdX4fWQk7lgXXRGthPuc22K5D78gFgw=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr82030868ion.65.1560948552949;
 Wed, 19 Jun 2019 05:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190618212749.8995-1-ard.biesheuvel@linaro.org>
 <099346ee-af6e-a560-079d-3fb68fb4eeba@gmail.com> <CAKv+Gu9MTGSwZgaHyxJKwfiBQzqgNhTs5ue+TC1Ehte-+VBXqg@mail.gmail.com>
 <CAKv+Gu9q5qTgEeTLCW6ZM6Wu6RK559SjFhsgWis72_6-p6RrZA@mail.gmail.com>
 <f5de99dd-0b6a-9f7e-46b7-cd3c5ed3100e@gmail.com> <CAKv+Gu9NW2H-TDd66quKSUMpEWGwqEjN-vmf_zueo1tEJLa-xg@mail.gmail.com>
 <b5b013eb-9cab-4985-9c24-563cc57c140e@gmail.com> <CAKv+Gu91RHpwE6XzdFYcsN77DRJ-4OsFRjxNAyKk92Q3q6dCYw@mail.gmail.com>
In-Reply-To: <CAKv+Gu91RHpwE6XzdFYcsN77DRJ-4OsFRjxNAyKk92Q3q6dCYw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Jun 2019 14:49:02 +0200
Message-ID: <CAKv+Gu_XFbB9TTjMO+=QmZ40H1LV5DB57-zeUEb9dN3yNyia=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] crypto: switch to crypto API for ESSIV generation
To:     Milan Broz <gmazyland@gmail.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fscrypt@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 19 Jun 2019 at 14:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 19 Jun 2019 at 13:33, Milan Broz <gmazyland@gmail.com> wrote:
> >
> > On 19/06/2019 13:16, Ard Biesheuvel wrote:
> > >> Try
> > >>   cryptsetup open --type plain -c null /dev/sdd test -q
> > >> or
> > >>   dmsetup create test --table " 0 417792 crypt cipher_null-ecb - 0 /dev/sdd 0"
> > >>
> > >> (or just run full cryptsetup testsuite)
> > >>
> > >
> > > Is that your mode-test script?
> > >
> > > I saw some errors about the null cipher, but tbh, it looked completely
> > > unrelated to me, so i skipped those for the moment. But now, it looks
> > > like it is related after all.
> >
> > This was triggered by align-test, mode-test fails the same though.
> >
> > It is definitely related, I think you just changed the mode parsing in dm-crypt.
> > (cipher null contains only one dash I guess).
> >
>
> On my unpatched 4.19 kernel, mode-test gives me
>
> $ sudo ./mode-test
> aes                            PLAIN:[table OK][status OK]
> LUKS1:[table OK][status OK] CHECKSUM:[OK]
> aes-plain                      PLAIN:[table OK][status OK]
> LUKS1:[table OK][status OK] CHECKSUM:[OK]
> null                           PLAIN:[table OK][status OK]
> LUKS1:[table OK][status OK] CHECKSUM:[OK]
> cipher_null                    PLAIN:[table FAIL]
>  Expecting cipher_null-ecb got cipher_null-cbc-plain.
> FAILED at line 64 ./mode-test
>
> which is why I commented out those tests in the first place.
>
> I can reproduce the crash after I re-enable them again, so I will need
> to look into that. But something seems to be broken already.
> Note that this is running on arm64 using a kconfig based on the Debian kernel.

Actually, could this be an issue with cryptsetup being out of date? On
another arm64 system with a more recent distro, it works fine
