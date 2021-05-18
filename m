Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A938823D
	for <lists+linux-crypto@lfdr.de>; Tue, 18 May 2021 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbhERVkJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 May 2021 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352521AbhERVkJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 May 2021 17:40:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C0C06175F
        for <linux-crypto@vger.kernel.org>; Tue, 18 May 2021 14:38:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v6so13190468ljj.5
        for <linux-crypto@vger.kernel.org>; Tue, 18 May 2021 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W1+DjjDR1PzHAHB0iKIOBjqYLk0N/OCWglAnEURxiU=;
        b=XqonLZtzFwD9xdcn38HwBYY4vD6yrVbdymfeBBbcMFYaXsW/826cqUlemFTFHt0fMA
         Ci8cJvxNl9KEmUe6ckfjpfYtuRLVKVfRxw0O7608KrlKv13OIV8QqtCYntAYRQBowJQQ
         pjb5RSJSX6zxH49Hif78cQ4DtPv3UejY3vn7XDhiCBmZp/c9c1BFnb8fYYno0bNIe4Zw
         swFh8N4Z124VSQirOR0fq8CqhchL6vSSZRhsvhXG66JP3qR44/ZrqdJTTeXaKlP3iFrE
         t3uib9NKcaND1NOifZF6DuUcwbrUJrAxs0J58UbUBvx157a5aeh8jb7to2Yk/fETbrgs
         UZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W1+DjjDR1PzHAHB0iKIOBjqYLk0N/OCWglAnEURxiU=;
        b=tSreSF3pOn0mk6rjmvLi53o9/OY2EMkO0BEn+1ktgh/8WF6WtevgG/IYgUfR8gfVKW
         g6cqANTWSPc09xAZs2OHcG9pLFkRbs5BVMox+Tb5wxHRkI1YyE5aAoEPHmK428shF6MV
         rbbkek0CDuUVHA80fYtz3DYbc4rj+SXQnTAJ+GSD+GGg4PtNECOThUGTFX/VNvharEeQ
         kE52ncNlgU1SIDuVE3+SafPdAjJ4Kmr0bWdxLCFRfCz56DQwSYdqD7jtWTSUvNlTCFjn
         W1JRtmfFB5WERBzxivzI3XXM73LUwozeOXBV5saclveAIvnxwXM1HnXR2JgNf6AieSX9
         fOLA==
X-Gm-Message-State: AOAM532t0MHRhIpcB0c1qWKcOqCZQ3qeh5AYMICqeh/KPmdiX4hiSwVK
        LwfxqSR4TvVX/wPXCm1szXLTAjz03K1w+McVsouPmQ==
X-Google-Smtp-Source: ABdhPJwRq7lDUNPROHEDF3nFQT2fbxp88IB7Z6nRtmRVI5xugU4a27mWVnbK4uJcIJfR10aiX4AiRMKIg9kg99+34Fc=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr5624837lji.273.1621373929345;
 Tue, 18 May 2021 14:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210518151655.125153-1-clabbe@baylibre.com> <20210518151655.125153-2-clabbe@baylibre.com>
In-Reply-To: <20210518151655.125153-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:38:38 +0200
Message-ID: <CACRpkdZ5ced+S6fQBAMeMuYhC3RN1q88DLyEr=gaPO6h=i26vA@mail.gmail.com>
Subject: Re: [PATCH 1/5] db-dinding: crypto: Add DT bindings documentation for sl3516-ce
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 18, 2021 at 5:17 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> This patch adds documentation for Device-Tree bindings for the
> SL3516-ce cryptographic offloader driver.
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Apart from misspelled subject "db-binding" I don't see any problems
so
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
