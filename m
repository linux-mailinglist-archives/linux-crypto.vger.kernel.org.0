Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769E0438AE7
	for <lists+linux-crypto@lfdr.de>; Sun, 24 Oct 2021 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhJXRU4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 24 Oct 2021 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhJXRUu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 24 Oct 2021 13:20:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19616C061348
        for <linux-crypto@vger.kernel.org>; Sun, 24 Oct 2021 10:18:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso11626792otl.4
        for <linux-crypto@vger.kernel.org>; Sun, 24 Oct 2021 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=txYKi9sgwISGvkox90OFDx/dPf5o5p1m4EHLibrC6+k=;
        b=ZDCjyQlmH0bbjBg7qQi8eYVRacNzNE0nhdwwXmQI9nlfP5gkvUud0QBvF6hJNZQAmk
         rTH5aeE/zHNnW6BSorJstcL70XqNZJk5YPvkOpbTC3wIstcE6YJc2ql7fRfV4Qn5JFfn
         CHlpQ+f3ZRA/Q3+up7i2KAt5kzTS1G5fL+fMXbxYj86+Po7VULRXuC1iYrkqrbfeHhEI
         5uUjjDVMzPA/IyPcxe0onwBA1KCAWxGMrRSMaG9Rk45Kf9LiUphExyLkA8Y9CM4RAU4T
         h1i9SQME97rejf6s5ZqFBQ5PmQU6LF8SnIt3wxXM1ZjwgMEgccXjIFy+sxZEwASrsKlq
         CsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txYKi9sgwISGvkox90OFDx/dPf5o5p1m4EHLibrC6+k=;
        b=rJZ9jDYuPPzTpKcp4VWWdsx6O3WDY8RVk63hvtPI1Fy1QhA9M5vf2aFhqDnQR32TgO
         5s0XLihMyOaq5rC+iR9FgKJOJqr10BS9CjXhMzq+aZ8O1420rTOUeaM5jrqHE+HslS+T
         TowDw/fkvGGHm6yixhsF0XXv0uQqRgOT/ds+6po2OjltLp9e2zcfd9AHNs931Cvo7X0j
         02tXLDHFGvEO1lonnbfijTPvzzptSG4quSAoWY1HbKU/O6ykbSvIFFYcHH1DjgLGrdmw
         WLFv3oLe3IN5D23QBP7rEyBmKPEX8byCvBhZXbplHOwXOw2yq0Rf9lduJ7I3RG6cBxn4
         JRxA==
X-Gm-Message-State: AOAM530FpyOxqsVJ0GbQzQAGbLZJYc34cQleWmZ4yt9Rxx7PvQX0jq/5
        3SD8BTt7vVOSfgRCjEsXDBdjmQ==
X-Google-Smtp-Source: ABdhPJyKfIy2F8ho6YM7INUo13hIYxiGaLLiSVqWfYHIs/FsTe87/gJYANKESAyc4MeOG4J5JQSxRg==
X-Received: by 2002:a05:6830:2a8c:: with SMTP id s12mr9977544otu.322.1635095908314;
        Sun, 24 Oct 2021 10:18:28 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x18sm2513000oov.13.2021.10.24.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:18:27 -0700 (PDT)
Date:   Sun, 24 Oct 2021 12:18:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 1/2] crypto: qce: Add 'sm8150-qce' compatible string check
Message-ID: <YXWVYZlCpkSRb7xv@builder.lan>
References: <20211013165823.88123-1-bhupesh.sharma@linaro.org>
 <20211013165823.88123-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165823.88123-2-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed 13 Oct 11:58 CDT 2021, Bhupesh Sharma wrote:

> Add 'sm8150-qce' compatible string check in qce crypto
> driver as we add support for sm8150 crypto device in the
> device-tree in the subsequent patch.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/crypto/qce/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 4c55eceb4e7f..ecbe9f7c6c0a 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -306,6 +306,7 @@ static int qce_crypto_remove(struct platform_device *pdev)
>  static const struct of_device_id qce_crypto_of_match[] = {
>  	{ .compatible = "qcom,ipq6018-qce", },
>  	{ .compatible = "qcom,sdm845-qce", },
> +	{ .compatible = "qcom,sm8150-qce", },
>  	{ .compatible = "qcom,sm8250-qce", },

When I look at linux-next I see qce_crypto_of_match defined as:

static const struct of_device_id qce_crypto_of_match[] = {
	{ .compatible = "qcom,crypto-v5.1", },
	{ .compatible = "qcom,crypto-v5.4", },
	{}
};

Can you please help me understand what I'm doing wrong?

Thanks,
Bjorn
