Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947AA662874
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Jan 2023 15:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAIO3W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Jan 2023 09:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjAIO3T (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Jan 2023 09:29:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51365D6
        for <linux-crypto@vger.kernel.org>; Mon,  9 Jan 2023 06:29:18 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z12so7900087qtv.5
        for <linux-crypto@vger.kernel.org>; Mon, 09 Jan 2023 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Yy00juT6YLJ5oWGMT9Wza1I0KabYl3KuXLE2Ym30r8=;
        b=hqu1WUIKQ7nelxjitmtslt7P2HWICJ6UQhItkE1DxGc9pYkqGv2Z3jzXfiUQ7oN+jD
         woMH988I6TyAfP/DcKz8zY/EqQvJsbpUwPmosnHsPhhtYjp/+7T4/iB5/v0fZx5jhews
         EgJ65v8od4MS0eHGmvOkk88QhVj1ogj0TwlYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Yy00juT6YLJ5oWGMT9Wza1I0KabYl3KuXLE2Ym30r8=;
        b=m4J+praBgqmWK9rFNBaV0imBncI3k/rCH8CM1sDQKqshfH4aBhx2k7EQRJNXR0aRoM
         U53rvM7cBbngIGUugwb9VYz6YG3pI0NkNuyvLCVvE2AEcyZT2rarkjC0jGilElOIQ9Tz
         0X56mXn6A7HyiLKudvyUG0y0h6NdIejdCuvlmzmWOPkVvsolPlyhCyzFvqrzU3fZdNAh
         scfGzAV7Z6dfQqXXwk144k2l7YNsImTDb+HH6HiYnkg6VHKwLsxG+Q2nX8WMpCxXRoEq
         ToAVKmQEM1XOZ1uQ2fV1uexJpMdUE4AWHUPKIXFCGssRtex126c1iCt6/N6GxJc5MkoR
         IgBw==
X-Gm-Message-State: AFqh2kob+1eJrZh9bzYTFfuOXKNqS112ShjVETW7aZvHYW/DVBoxEF7G
        iQSsLTlzei/xC9cMwc8zAG3tC9gx6nke2/BNCgw=
X-Google-Smtp-Source: AMrXdXv0mtxnr3FmJLzozvp4VPCNr2G/xG+SDx1NYrUcrxQX2CSAO+KZ56sUQ306jVyQ0yb/WutBaA==
X-Received: by 2002:a05:622a:2514:b0:3a8:3d4:f14c with SMTP id cm20-20020a05622a251400b003a803d4f14cmr90415036qtb.5.1673274557141;
        Mon, 09 Jan 2023 06:29:17 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id cb15-20020a05622a1f8f00b003a5c60686b0sm4638951qtb.22.2023.01.09.06.29.14
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:29:14 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id k2so4220412qkk.7
        for <linux-crypto@vger.kernel.org>; Mon, 09 Jan 2023 06:29:14 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr3220519qkg.594.1673274554214; Mon, 09
 Jan 2023 06:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <874jt0kndq.fsf@oldenburg.str.redhat.com>
In-Reply-To: <874jt0kndq.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jan 2023 08:28:58 -0600
X-Gmail-Original-Message-ID: <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
Message-ID: <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        mlichvar@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 9, 2023 at 4:34 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> We did these changes on the glibc side because Jason sounded very
> confident that he's able to deliver vDSO acceleration for getrandom.  If
> that fails to materialize, we'll just have to add back userspace
> buffering in glibc.

My whole argument has been that user-space buffering is the sane thing
to do. Most definitely for something like glibc.

The number of people who go "oh, no, my buffer or randomness could be
exposed by insert-odd-situation-here" is approximately zero, and then
the onus should be on *them* to do something special.

Because *they* are special. Precious little snowflake special.

             Linus
