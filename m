Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA442D3EB
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Oct 2021 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJNHmS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Oct 2021 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhJNHmS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Oct 2021 03:42:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4BC061753
        for <linux-crypto@vger.kernel.org>; Thu, 14 Oct 2021 00:40:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so7102418otk.3
        for <linux-crypto@vger.kernel.org>; Thu, 14 Oct 2021 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1E/kwe6KsaY7ajv8p7giaTw/a0T8vcfhIkutRN0RLxQ=;
        b=TVbBZX+yY6sVd38Qak+8ox+GerwvgJpdv/kYT/Mg3X1a3+QL2ojam0QroD1PTLSFgs
         gmWj8UfYcVkpZtHrJMV29kE3vaOczobGdtPWVcXHBoySlejzRkdJA2Fe+mIGJJ6PcKVB
         O4V7bss42my+9YdzKLtiK9ysslfFJmA6M0Y38yWfwAeDyMFzMBhnQ3YEO6A2Ybeq0ZQe
         RVP/ZqsEVgkDMHTW95hyp0URdfUYYfS5/TOq4XNx3NsCb2M2dbLT8gCcY5UTiCFWZ1+a
         /05W4xqn5NDvpWYKUUficMtjGQ1TEAIDX7DkzitWggZdk+lX/Y5B/5XMagKcrgayOboq
         MszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1E/kwe6KsaY7ajv8p7giaTw/a0T8vcfhIkutRN0RLxQ=;
        b=Pha5Ky8Hpwjf68vTouo7oVcm+fDnIRYnLNzDQ/GF09ZrHFis/4olVJqNdDygtB4Buk
         Tt6to/uol8y8wBM4ZZUMW51AO36bwDN2sLXsxrNoWFrO1k230XD7mMoidDL3w80JAqCI
         UM5u8Icl19ztz+P6zYBbsWMqukOXtbS6Ukg/vgEroQUWhfnQsDAN5kNsZ7KyMCz7CC+/
         +f1MZ2byHa9X38WRa2MEWzEOrxNBo5HSKVLGBRvqr2Y/WdflB+tYDtROc6CzfnB5DB1X
         xil0DwNAZqi+t/svU1A47GA9WbrFGnsdHeSYvL5OYl/7gUQ3oBu4bI0KnD1Mpvcf2Rqe
         oYyQ==
X-Gm-Message-State: AOAM531v/EobvuHvOnIZkuV1Qv94tMHt7Cux+FgK+Y6Brj28YVpW2EPu
        lhfz/0fcDS0ZqyvbGlasy/UAbslxV8Aq7O5F56e/3A==
X-Google-Smtp-Source: ABdhPJyVDnvknF6a/VWGZGtlXr5TH0OEv7HC+oDDN7r7z8ESc7w03hJmQpfuzuchf4yNT2muAQ8IMmISvz6K6FKgTME=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr1129554ote.28.1634197212897;
 Thu, 14 Oct 2021 00:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
 <20211013105541.68045-19-bhupesh.sharma@linaro.org> <74893e20-3dd8-9b57-69bb-025264f51186@linaro.org>
In-Reply-To: <74893e20-3dd8-9b57-69bb-025264f51186@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 14 Oct 2021 13:10:01 +0530
Message-ID: <CAH=2Ntw5_hycMqouneiU_Tb17OL0zxUpt8ecGZn+LxXEU_=ZQg@mail.gmail.com>
Subject: Re: [PATCH v4 18/20] crypto: qce: Defer probing if BAM dma channel is
 not yet initialized
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Vladimir,

On Thu, 14 Oct 2021 at 02:19, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 10/13/21 1:55 PM, Bhupesh Sharma wrote:
> > Since the Qualcomm qce crypto driver needs the BAM dma driver to be
> > setup first (to allow crypto operations), it makes sense to defer
> > the qce crypto driver probing in case the BAM dma driver is not yet
> > probed.
> >
> > Move the code leg requesting dma channels earlier in the
> > probe() flow. This fixes the qce probe failure issues when both qce
> > and BMA dma are compiled as static part of the kernel.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/crypto/qce/core.c | 20 ++++++++++++--------
> >   1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index cb8c77709e1e..c6f686126fc9 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -209,9 +209,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* qce driver requires BAM dma driver to be setup first.
>
> I believe a multi-line block of comments should be started with '/*' line,
> for reference please take a look at Documentation/process/coding-style.rst

There are exceptions to this rule as well. For e.g. see most of the
networking drivers and the multi-line comment styles there :) .

There is a very interesting LWN article on the same :
https://lwn.net/Articles/694755/
Note that 'crypto/' and 'drivers/crypto' use these non-standard
multi-line comments quite often as well.

That said, I have no strong opinion on using either style. Although, I
found one of the points raised by the networking maintainer during one
of my patch reviews earlier quite useful - 'keeping the top line in a
multi-line comment blank, wastes precious screen space while reading
and reviewing the patch'.

Regards,
Bhupesh

> > +      * In case the dma channel are not set yet, this check
> > +      * helps use to return -EPROBE_DEFER earlier.
> > +      */
> > +     ret = qce_dma_request(qce->dev, &qce->dma);
> > +     if (ret)
> > +             return ret;
> > +
> >       qce->mem_path = of_icc_get(qce->dev, "memory");
> > -     if (IS_ERR(qce->mem_path))
> > +     if (IS_ERR(qce->mem_path)) {
> > +             qce_dma_release(&qce->dma);
> >               return PTR_ERR(qce->mem_path);
> > +     }
> >
> >       qce->core = devm_clk_get_optional(qce->dev, "core");
> >       if (IS_ERR(qce->core)) {
> > @@ -247,10 +257,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto err_clks_iface;
> >
> > -     ret = qce_dma_request(qce->dev, &qce->dma);
> > -     if (ret)
> > -             goto err_clks;
> > -
> >       ret = qce_check_version(qce);
> >       if (ret)
> >               goto err_clks;
> > @@ -265,12 +271,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >
> >       ret = qce_register_algs(qce);
> >       if (ret)
> > -             goto err_dma;
> > +             goto err_clks;
> >
> >       return 0;
> >
> > -err_dma:
> > -     qce_dma_release(&qce->dma);
> >   err_clks:
> >       clk_disable_unprepare(qce->bus);
> >   err_clks_iface:
> >
>
> --
> Best wishes,
> Vladimir
