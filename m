Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F82B752F
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Nov 2020 05:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgKREDA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Nov 2020 23:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKREDA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Nov 2020 23:03:00 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D37C061A51
        for <linux-crypto@vger.kernel.org>; Tue, 17 Nov 2020 20:03:00 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id w145so721838oie.9
        for <linux-crypto@vger.kernel.org>; Tue, 17 Nov 2020 20:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10leeznI+eRQpEgtqZRmaXQRvCAkSUBOaaabyov8Zyk=;
        b=G/0ZgiA7hEywvaEPWFtecw0QLSDpKMJHvoz6o5JoNX96b0KFZRw2ZHvpVB/ndhZsF1
         xv3AvfAL1qpRNGQePlszRP8yZdM3V/Ky+tghDeotunPykmulRfR/tk9DBVQi/tv56R2V
         oTG72vscrXztgI3DygNouk8vH0SnghoJ2MSfJ+78H16H7J3VYdJ7YotcSiTqEMMA0QxJ
         4qLwsB3CN0M5pgYGu3v4ivi3yfQGoSlpwV7nZSHkU4OAwQ+94OnJ9VqIY7NYaaUU9ipS
         WP7lMh88BqvxAUAv5zWgfdfrCZ5Gqy9R5hD4L6SILfRFU9EKpg49xkXjC5Wu9ckl9Thp
         ghaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10leeznI+eRQpEgtqZRmaXQRvCAkSUBOaaabyov8Zyk=;
        b=YhDDyavLlgLVDJethaGD2h8r5GUYM5AlbsrSTrTLkC2bSLQWPPB8x2lbHJQZbFPAVC
         XtAE3UtC8f8PQGMpvtWiIbFCTNYnZLmP1AvgUAm5axu04VB8+MqpreeKekTv2gCIvDcs
         7bfbuwUA2ltz07UBR3OUccIdWIQmLmscY4WWMQLvKViz4D5bRWgWejpSEb3R/7ThR6eh
         ma3YshAd3FMtbrEslROuNWF+ngGD0F71TpVDauwS2pX80butvQXtdOwjWq2F92menRTa
         h5crPtn8My1MyMBdAIrAmEx2VdasUIzsym1I10nVRtH3IVq9aksWT4d0swHiw1XRcBFF
         OLqw==
X-Gm-Message-State: AOAM532RPV6bmNeRuaOyIgQa4Cdly1YNPyqEWd+hxiub4D6U6Lo64mVU
        dG3Z5VMLkaRAF79rxCulYLpDJw==
X-Google-Smtp-Source: ABdhPJxpEctJk9SnEnIDl3wBD4ipEJV2BaRvejXJ4PLap1Heri7FtZG7cZSQLsofCdWgk1ptZOWSkQ==
X-Received: by 2002:aca:e155:: with SMTP id y82mr1612187oig.21.1605672179363;
        Tue, 17 Nov 2020 20:02:59 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d202sm7096825oig.3.2020.11.17.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:02:58 -0800 (PST)
Date:   Tue, 17 Nov 2020 22:02:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/6] drivers:crypto:qce: Enable support for crypto engine
 on sdm845.
Message-ID: <20201118040257.GC8532@builder.lan>
References: <20201117134714.3456446-1-thara.gopinath@linaro.org>
 <20201117134714.3456446-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134714.3456446-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue 17 Nov 07:47 CST 2020, Thara Gopinath wrote:

> Add support Qualcomm Crypto Engine accelerated encryption and
> authentication algorithms on sdm845.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index ea616b7259ae..67c3ca13e55b 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -160,7 +160,21 @@ static int qce_check_version(struct qce_device *qce)
>  		return -ENODEV;
>  
>  	qce->burst_size = QCE_BAM_BURST_SIZE;
> -	qce->pipe_pair_id = 1;
> +
> +	/*
> +	 * Rx and tx pipes are treated as a pair inside CE.
> +	 * Pipe pair number depended on the actual BAM dma pipe
> +	 * that is used for transfers. The BAM dma pipes are passed
> +	 * from the device tree and used to derive the pipe pair
> +	 * id in the CE driver as follows.
> +	 * 	BAM dma pipes(rx, tx)		CE pipe pair id
> +	 *		0,1				0
> +	 *		2,3				1
> +	 *		4,5				2
> +	 *		6,7				3
> +	 *		...
> +	 */
> +	qce->pipe_pair_id = qce->dma.rxchan->chan_id >> 1;
>  
>  	dev_dbg(qce->dev, "Crypto device found, version %d.%d.%d\n",
>  		major, minor, step);
> @@ -261,6 +275,7 @@ static int qce_crypto_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id qce_crypto_of_match[] = {
>  	{ .compatible = "qcom,crypto-v5.1", },
> +	{ .compatible = "qcom,crypto-v5.4", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
> -- 
> 2.25.1
> 
