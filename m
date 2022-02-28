Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4F4C7A02
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Feb 2022 21:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiB1ULl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Feb 2022 15:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiB1ULi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Feb 2022 15:11:38 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4728A6CA
        for <linux-crypto@vger.kernel.org>; Mon, 28 Feb 2022 12:10:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o6so18991510ljp.3
        for <linux-crypto@vger.kernel.org>; Mon, 28 Feb 2022 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeZ8UzRXrDw4d1M4BG6ctt9COK0EF5j9qtOsLWtMfJg=;
        b=Jhdls+DdmLi+4DWS7o2GehQ/Yg8vWPth9HxY0ymuDsFhiEF5hlRLzgd1PV4wJ4dLVJ
         JdRWd6PhVxu3cPtesSY0XREEgjw/sVhI1zgx2ECNJUHRlykk7MmbqhfMtkifVM/LmgYS
         6chNfwYqW0eu75y5MSRY9nnHOEZnFkvhMXNYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeZ8UzRXrDw4d1M4BG6ctt9COK0EF5j9qtOsLWtMfJg=;
        b=XCc2PWwgx4BxK/jm+pXtqN+m0so0ofVdLT94fqabYFfo9cJq0BOu9/UWuOssNlHlXT
         ospvpYilmtekH/QMdEx9CNnqbd32x+PJdQVZ+T70+uFJTtvABiyRheE9Zr0QBka9MWmg
         kYxVqEJXWJLRWzxhzpSzSlSk+NE4XWV9PudiUjI8A3leWhwVppa4an8+PvoagmtiiyHa
         2qY539Zm0ecmjwH2/QHeHtB+Gci12rlLNlMoSeHGxnF7RNjvCX0oiE5j/lct6KniGsSv
         FH++WW3pSdH6tQFS6uSULZ59phxtEx3oZ/vhUxwYBaCFnDMtzuMQbZvRzCnaYB/vdBBN
         4VRQ==
X-Gm-Message-State: AOAM532aBwP3ELW/Fakt0BlbuGdqAIA/Ra1k7fCkxvbtExj5gC1W/9qb
        h2bUK2ufRP4kB8XCQQI+VZw3EAwXdO1to0hoS6c=
X-Google-Smtp-Source: ABdhPJwS8LMj8IISIWl/4id7I8+I83KXPsslYyHmTt7coOiB4fMPdUcVq9PRsSaNQOI81Iha72Bo5w==
X-Received: by 2002:a2e:91cf:0:b0:246:292f:943a with SMTP id u15-20020a2e91cf000000b00246292f943amr15212440ljg.47.1646079055457;
        Mon, 28 Feb 2022 12:10:55 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y19-20020a2eb013000000b002461d6e19e8sm1502649ljk.119.2022.02.28.12.10.51
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:10:52 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f37so23263439lfv.8
        for <linux-crypto@vger.kernel.org>; Mon, 28 Feb 2022 12:10:51 -0800 (PST)
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr14027806lfe.542.1646079041191; Mon, 28
 Feb 2022 12:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com> <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 12:10:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
Message-ID: <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008601b205d919a4ad"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--0000000000008601b205d919a4ad
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 28, 2022 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Side note: we do need *some* way to do it.

Ooh.

This patch is a work of art.

And I mean that in the worst possible way.

We can do

        typeof(pos) pos

in the 'for ()' loop, and never use __iter at all.

That means that inside the for-loop, we use a _different_ 'pos' than outside.

And then the compiler will not see some "might be uninitialized", but
the outer 'pos' *will* be uninitialized.

Unless, of course, the outer 'pos' had that pointless explicit initializer.

Here - can somebody poke holes in this "work of art" patch?

                     Linus

--0000000000008601b205d919a4ad
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l074y7ca0>
X-Attachment-Id: f_l074y7ca0

IE1ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0KIGFyY2gveDg2L2tlcm5lbC9j
cHUvc2d4L2VuY2wuYyB8IDIgKy0KIGluY2x1ZGUvbGludXgvbGlzdC5oICAgICAgICAgICB8IDYg
KysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGRhZWI1Yzg4YjUwYi4uY2M0
YjBhMjY2YWYwIDEwMDY0NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNTE1LDcg
KzUxNSw3IEBAIEtCVUlMRF9DRkxBR1MgICA6PSAtV2FsbCAtV3VuZGVmIC1XZXJyb3I9c3RyaWN0
LXByb3RvdHlwZXMgLVduby10cmlncmFwaHMgXAogCQkgICAtZm5vLXN0cmljdC1hbGlhc2luZyAt
Zm5vLWNvbW1vbiAtZnNob3J0LXdjaGFyIC1mbm8tUElFIFwKIAkJICAgLVdlcnJvcj1pbXBsaWNp
dC1mdW5jdGlvbi1kZWNsYXJhdGlvbiAtV2Vycm9yPWltcGxpY2l0LWludCBcCiAJCSAgIC1XZXJy
b3I9cmV0dXJuLXR5cGUgLVduby1mb3JtYXQtc2VjdXJpdHkgXAotCQkgICAtc3RkPWdudTg5CisJ
CSAgIC1zdGQ9Z251MTEKIEtCVUlMRF9DUFBGTEFHUyA6PSAtRF9fS0VSTkVMX18KIEtCVUlMRF9B
RkxBR1NfS0VSTkVMIDo9CiBLQlVJTERfQ0ZMQUdTX0tFUk5FTCA6PQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5j
bC5jCmluZGV4IDQ4YWZlOTZhZTBmMC4uODdkYjJmMzkzNmIwIDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NneC9lbmNsLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5j
bC5jCkBAIC00NTAsNyArNDUwLDcgQEAgc3RhdGljIHZvaWQgc2d4X21tdV9ub3RpZmllcl9yZWxl
YXNlKHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLAogCQkJCSAgICAgc3RydWN0IG1tX3N0cnVjdCAq
bW0pCiB7CiAJc3RydWN0IHNneF9lbmNsX21tICplbmNsX21tID0gY29udGFpbmVyX29mKG1uLCBz
dHJ1Y3Qgc2d4X2VuY2xfbW0sIG1tdV9ub3RpZmllcik7Ci0Jc3RydWN0IHNneF9lbmNsX21tICp0
bXAgPSBOVUxMOworCXN0cnVjdCBzZ3hfZW5jbF9tbSAqdG1wOwogCiAJLyoKIAkgKiBUaGUgZW5j
bGF2ZSBpdHNlbGYgY2FuIHJlbW92ZSBlbmNsX21tLiAgTm90ZSwgb2JqZWN0cyBjYW4ndCBiZSBt
b3ZlZApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9saXN0LmggYi9pbmNsdWRlL2xpbnV4L2xp
c3QuaAppbmRleCBkZDZjMjA0MWQwOWMuLjcwODA3OGIyZjI0ZCAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9saXN0LmgKKysrIGIvaW5jbHVkZS9saW51eC9saXN0LmgKQEAgLTYzNCw5ICs2MzQs
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbGlzdF9zcGxpY2VfdGFpbF9pbml0KHN0cnVjdCBsaXN0
X2hlYWQgKmxpc3QsCiAgKiBAaGVhZDoJdGhlIGhlYWQgZm9yIHlvdXIgbGlzdC4KICAqIEBtZW1i
ZXI6CXRoZSBuYW1lIG9mIHRoZSBsaXN0X2hlYWQgd2l0aGluIHRoZSBzdHJ1Y3QuCiAgKi8KLSNk
ZWZpbmUgbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsIGhlYWQsIG1lbWJlcikJCQkJXAotCWZvciAo
cG9zID0gbGlzdF9maXJzdF9lbnRyeShoZWFkLCB0eXBlb2YoKnBvcyksIG1lbWJlcik7CVwKLQkg
ICAgICFsaXN0X2VudHJ5X2lzX2hlYWQocG9zLCBoZWFkLCBtZW1iZXIpOwkJCVwKKyNkZWZpbmUg
bGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsIGhlYWQsIG1lbWJlcikJCQkJCVwKKwlmb3IgKHR5cGVv
Zihwb3MpIHBvcyA9IGxpc3RfZmlyc3RfZW50cnkoaGVhZCwgdHlwZW9mKCpwb3MpLCBtZW1iZXIp
OwlcCisJICAgICAhbGlzdF9lbnRyeV9pc19oZWFkKHBvcywgaGVhZCwgbWVtYmVyKTsJXAogCSAg
ICAgcG9zID0gbGlzdF9uZXh0X2VudHJ5KHBvcywgbWVtYmVyKSkKIAogLyoqCg==
--0000000000008601b205d919a4ad--
