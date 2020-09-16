Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C526CA58
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Sep 2020 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIPT4K (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Sep 2020 15:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgIPRfk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:40 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD6422249
        for <linux-crypto@vger.kernel.org>; Wed, 16 Sep 2020 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264433;
        bh=jOr1ILBrH0hsIe4Uxj0HglLHNtHLCgPAOSI7lD6Bk0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p9VWVOxqy0ZOpY6zV+lgUxPY3vw6KIsl7EKpGzi/f5TJiOJuxEkiQ/G4gh/h5EzHS
         RF68RygSMJzp1/h8NeBPg+O7beXq7pBMA/m7hUDQMMXJocOkwnecFGmmYzMf7uZb0o
         AGOuxHWQwZXx2lQ+zyA8jN8N/CcUyUTP+mpFQPzA=
Received: by mail-wm1-f45.google.com with SMTP id d4so2867777wmd.5
        for <linux-crypto@vger.kernel.org>; Wed, 16 Sep 2020 06:53:53 -0700 (PDT)
X-Gm-Message-State: AOAM531qSsMdHvocHBjoM5CB0tLVeFQfiC80sHpm9JnJ9skJTiALM/GQ
        mzeLd6VNkTC30duJt3nyrHcInPeMO5HbzHjTzjW0hg==
X-Google-Smtp-Source: ABdhPJwsFxAlLKwvcgub1p7xhg7wLnttUhWDVhNNq6UFPkr9RccoakwAwNYCTooMbhwj5JmFeJr/NfK4O+SpA8c8x0E=
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr4760326wmi.36.1600264432116;
 Wed, 16 Sep 2020 06:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916043652.96640-1-ebiggers@kernel.org>
In-Reply-To: <20200916043652.96640-1-ebiggers@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Sep 2020 06:53:41 -0700
X-Gmail-Original-Message-ID: <CALCETrU-D=b-oGE3+zjoYFP5dBU7ur41dqwkz1BifOzN2=jV7g@mail.gmail.com>
Message-ID: <CALCETrU-D=b-oGE3+zjoYFP5dBU7ur41dqwkz1BifOzN2=jV7g@mail.gmail.com>
Subject: Re: [PATCH] random: remove dead code left over from blocking pool
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 15, 2020 at 9:38 PM Eric Biggers <ebiggers@kernel.org> wrote:>
> From: Eric Biggers <ebiggers@google.com>
>
> Remove some dead code that was left over following commit 90ea1c6436d2
> ("random: remove the blocking pool").
>

Looks good to me.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
