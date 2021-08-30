Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F763FB738
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Aug 2021 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhH3NtL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Aug 2021 09:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236862AbhH3NtJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Aug 2021 09:49:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CA3660E98
        for <linux-crypto@vger.kernel.org>; Mon, 30 Aug 2021 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630331295;
        bh=hstOdeZmJtg0pgITB6j/BCG7KtHieJhNUh8u5fuKLbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kW2afjm9BT2MkdyZDDAT3WMPAE0Q4rUjwgIk7l1OnyOMxRMjJD6tZ56XZ6Ih9Lbo5
         4EBbx14OJjfPJt044zXYzAE+a1LjXf+xidY0gTk8YlAhlRJVo7PkydceuswxuVs939
         rxUsebKRATIP7mqWJQ6LnBhYz0AQVC+OV792LlAmRMKg/B5Aj72Zkru0l+InCAGu3y
         andYzz6FpkkQUK4Jm89YkD19sShP2BKRl8qUfC4pybmzkEOX2x9mueXum7SXl8wKtq
         kqwPfbervUZaEVLspMIo5G8H6vB+C6vvKmvYhAHTMwyPgdeR933lgK8JszmiYiCxpU
         ADnyzbbLqR0Mw==
Received: by mail-oi1-f182.google.com with SMTP id o185so19804544oih.13
        for <linux-crypto@vger.kernel.org>; Mon, 30 Aug 2021 06:48:15 -0700 (PDT)
X-Gm-Message-State: AOAM532WMaZo/+ykEDdabbTMgOVuOTiakhfKkhWcVElxOxPy+sfZtP+T
        e9tzDwNlOH7xlbzsgswtw9xya7rW8IadN9NUB5c=
X-Google-Smtp-Source: ABdhPJx0ClwtrJSpn0SmSpTucN//IotOZIMyttskDoGgTucdMJeaZWDl9wNVv8Q74QKoYhCySyjcqutNavt8KUJa6b8=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr15154423oih.174.1630331294986;
 Mon, 30 Aug 2021 06:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210827070342.218276-1-ardb@kernel.org> <CAMj1kXEUbPMadj1J7MWD_B-=2zRc2ir_zZQN3Puz3n+PjQw58Q@mail.gmail.com>
 <20210830062634.GA30356@gondor.apana.org.au>
In-Reply-To: <20210830062634.GA30356@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Aug 2021 15:48:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHa-iSm+=N+kQT9_qmT3=Tp7b1Xpk1T7Rzns+hf2SNoxg@mail.gmail.com>
Message-ID: <CAMj1kXHa-iSm+=N+kQT9_qmT3=Tp7b1Xpk1T7Rzns+hf2SNoxg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] running kernel mode SIMD with softirqs disabled
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 30 Aug 2021 at 08:26, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Sun, Aug 29, 2021 at 08:35:37AM +0200, Ard Biesheuvel wrote:
> >
> > Any chance we could get this queued for v5.15? If it's too late,
> > please consider taking only the first three patches as an alternative,
> > and I will resend the CCM ones for v5.16 once they have all been
> > reviewed.
>
> Sorry, it's too late for that.  If these are to serve as dependencies
> for other work, perhaps you can just add my acks to them and
> submit them to the trees where they are needed?
>

Fair enough. It would be nice to get rid of the crypto_simd dependency
at least for the aes-ce driver, but I might propose it as a backport
once it hits mainline.

Thanks,
Ard.
