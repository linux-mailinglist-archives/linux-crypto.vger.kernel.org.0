Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9944FE0A
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Nov 2021 06:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhKOFIB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Nov 2021 00:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhKOFH7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Nov 2021 00:07:59 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C6C061746
        for <linux-crypto@vger.kernel.org>; Sun, 14 Nov 2021 21:05:03 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so24566071otg.4
        for <linux-crypto@vger.kernel.org>; Sun, 14 Nov 2021 21:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHrhWAX2hQVCS39Z0qh/1XKWuVoHM9rjZxjvoaThtm4=;
        b=aILiIugcaxhFkz3Nv9I61TgKO/mhDAT2DpqhXBmzZvwpInxER6q8uCXDKhUQsBtP4s
         mHnfUBz2QjAteqw1TFsiUEqViSJusVWfCgDyC8YQCKodu82MA08vFS02wWN7DZdfNMv1
         OycmASRw1mX/idzy0l0GVziq0dpvLnuUamBKyF9dkf9Lz8PAK4bETXpEiRRULTVL/CPn
         yTniX78IJl7CvccCGYGVY1CblkzOSWT0YxB+ZMM96ZGIrq9bhiAeieefIq9cEM3kLlyw
         XuHsPMQHHGF8G+xh4fcZ03xT87bDLDruBy3d3YY2zLB9cn9VvgIkb5M/KDtSnF44rop8
         0jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHrhWAX2hQVCS39Z0qh/1XKWuVoHM9rjZxjvoaThtm4=;
        b=VkvuNzcGf5RA29Fvy1h1rqey15NTWmRHXGbVZ9b5KW13I4TLNieqUawJ2wdkHhbN24
         igWc0VNdh6yjWb7NNrHHlk6ELAL5gA7F1pfNGZoCzhwYJoIVfPqeVfj+cP6W8SY0Q3ID
         8rQMUYRkDSjWPfLxyyRJG9lithZ1h5PEWL6W8hgc5tckQRsLWCa93LXhXmA0y6TQd9X4
         zDZrKJ/9sJHj8UCZLgUGBI4XpKkaLsyKVtAtOljEk6LtDAMOlTXLEzWobIZa19RB0tOk
         6l0qk4uss5hAyWlYlVCWLFTVgiz8JGD7d6h2aCrGF9CPAyLAlPQ0Jf9bxQi7QavTbFqN
         GO5Q==
X-Gm-Message-State: AOAM532syj4LHy8Yv1mfJfa+tz97IMOEmi63qKAfXL44JkU5O/ssf+E4
        R7p1Mkp9WfENt0LYZNqpbep/ci6erek+Fmj04vL8Jg==
X-Google-Smtp-Source: ABdhPJyx/NXeuruSZYCP6RmBQ2IDicSOu74/i/SA2lHFYkeHg16bF7PA87Kk/p/fQVfbS0fqYA74Mtgt/o1d6X3iHv8=
X-Received: by 2002:a9d:63d2:: with SMTP id e18mr15410715otl.28.1636952701274;
 Sun, 14 Nov 2021 21:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-13-bhupesh.sharma@linaro.org> <7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org>
In-Reply-To: <7328ae17-1dc7-eaa1-5993-411b986e5e02@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 15 Nov 2021 10:34:50 +0530
Message-ID: <CAH=2Ntw7Npzrba7xnu--GHh1-ofVXKU8SEe9hLj8bt-gQQMBsQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] arm64/dts: qcom: Use new compatibles for crypto nodes
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Vladimir,

On Fri, 12 Nov 2021 at 15:56, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> > Since we are using soc specific qce crypto IP compatibles
> > in the bindings now, use the same in the device tree files
> > which include the crypto nodes.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
> >   arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > index 933b56103a46..f477d026c949 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > @@ -204,7 +204,7 @@ cryptobam: dma-controller@704000 {
> >               };
> >
> >               crypto: crypto@73a000 {
> > -                     compatible = "qcom,crypto-v5.1";
> > +                     compatible = "qcom,ipq6018-qce";
> >                       reg = <0x0 0x0073a000 0x0 0x6000>;
> >                       clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
> >                               <&gcc GCC_CRYPTO_AXI_CLK>,
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 526087586ba4..8e7cbadff25a 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2329,7 +2329,7 @@ cryptobam: dma-controller@1dc4000 {
> >               };
> >
> >               crypto: crypto@1dfa000 {
> > -                     compatible = "qcom,crypto-v5.4";
> > +                     compatible = "qcom,sdm845-qce";
> >                       reg = <0 0x01dfa000 0 0x6000>;
> >                       clocks = <&gcc GCC_CE1_AHB_CLK>,
> >                                <&gcc GCC_CE1_AXI_CLK>,
> >
>
> and in connection to my review comment on v5 11/22 there should be done
> similar changes for ipq8074.dtsi and msm8996.dtsi.

Ok, I will fix this in v6.

Thanks,
Bhupesh
