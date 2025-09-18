Return-Path: <linux-crypto+bounces-16325-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D808B55103
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Sep 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92C47C53B7
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Sep 2025 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965331283E;
	Fri, 12 Sep 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8bJWuWo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E71F92E
	for <linux-crypto@vger.kernel.org>; Fri, 12 Sep 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686863; cv=none; b=XdpQbEVq7a5HcQSU96Nj++gff7YoaLJwVPdBR75fcrinc/AuBc6h55JH+/arVa9gJm649WarTp4i1Zcdk8i5ciajyapjg89Ex2l95+5HYiqTTSqvGBm0ZSmxZ64i4X7vjnjh/b5S+7a4ojU1H6IuoP9ErpQE0x70NjcqXHW6AwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686863; c=relaxed/simple;
	bh=LhFvZeUZESo+BqKcF+l1lftDAN8nJvGBnxH4OQlr4Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPyJA04lLyGE++SOM/f5JVKpHlJojqDpwziCl4m2QLQzDTPn0W/vuEHVNbgaHJudOQXdWw5dsKwXP5EQKjwjX+Sv1RbvTMW4givQpsSOtED6jLp49rEetdE/HwrdCw3/aALpA/VdEFm2kdpTBWfKZmecp//q48lDuJdTqwE/sDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8bJWuWo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1139860f8f.2
        for <linux-crypto@vger.kernel.org>; Fri, 12 Sep 2025 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686860; x=1758291660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4cur4X75SOX+L9Hbv3cU7NjYIOtP0WJSnDy9zZzynTY=;
        b=b8bJWuWoQT98KnHA+pT3gitJeCu0mmyBmd5H6yoIbZW/KT5S/VipU+HlTqGXT8cy/f
         0dAKCJde9nepMrRilLmKKW1cZxI6pfTtEgPh5YhnwK/pRWTdXpgsYOAsxhosKwn/jRc1
         OJsR9W8c5oSo2y+bqhvRMJqY+tLIC21elJhj1M+T064a3OLSzrDGETrMt2sbu/HTpGf0
         SQt/scjPtpjY/YZNcBBuDEFQXgQlT9q7DhzPIcdNUJ7BnDVF+fkN6wbm2a3K7xjHrSwv
         qFd7Pflb0ScCfELi7EkM8/BJFbF0FMKgib3sLr+VRTFisfP60ulqYfoFIWSNjVDEHkD9
         dLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686860; x=1758291660;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cur4X75SOX+L9Hbv3cU7NjYIOtP0WJSnDy9zZzynTY=;
        b=ll622a6Yy+UgBUIqfakrQ2GHOGgc5CLEGmUJFR4g4+mckzGfzWesSaKQ9KF1X7k0t0
         NJQurLwyT/yMHLOTNuH4/M2va+WMsJcdeGhE4Fmv+20nS0jHoe6bjaryoD8vizNHlUEj
         AMYtofkZs5UGa/PWcM6SqSqIMXxGxSiCwi7ingF2IDeQDiBdDgIqZILHImtMJ05KweEg
         7lZ8+BYYFI5hM0uo8eVAHMONWdqJVOTcWj3A+f2lEIDxVculGxSqUcBUSZDGbchSXuHB
         v3BUkC2obuND+OE8n90MfLEPvlagO9KkcJaGNNGN47uvJ7qvqrfDI0YXIRPBvBIeldpl
         Fnag==
X-Forwarded-Encrypted: i=1; AJvYcCVhDflQtZ9sYx7yPBjr/EuXlDibeqPrDxOVCyRIkYtEUNUpMM8/b4/0RJ9unh4ZVE3axOSTfSjDjaeTrcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3u6QbycpuiQvuOkxPyabcVCM3QoFPi1KLgTJHmeZTRcVFK7y
	U9McqI2erqVwijh2xr7kzaslOryMXQDuyAFXZrg9MHSfwu/0jaLx6naA
X-Gm-Gg: ASbGncu/njFCNVhagFJ3nds+eifNnlbzp05s3kBnTQ5E4t+NzLWoCHt7rYld8ijgsDd
	GpbpTn0YTHpOa5dkkevsSgur+3hY3GAzUKKDjIkLtPQTPK+kVZlXQXX3RKD2UezpMtVJZJ36mXM
	LvlPATzdp3tyNLxqSBLF8ScgJReIRjN8/mNwfkp/n0Yppvmj4ttZ9oHxVWAOTlDCtOUUB/ihTTP
	/2GQ0R62r0oxTwLb2qKzVciS+V6a8O7sFmkPJzCWdiZJzHEPOjeQZnSuRwJqUlZr/FJCXHFTYj7
	MM8oQ0q+Oiyw7flrMbT8rJhdSkvddukyFdpcLQmK5hcu1dTq7R2wImuLRntEBrxYHNYQue8+jDM
	L/KGUl0hkZ9NGhZGdH8NpzrhdCIJVXH+GPM3sHB+dYrNGPzHZVR77
X-Google-Smtp-Source: AGHT+IETnSVaOaRKN/Bmr4IDnznOAwChZ2qQ4ywH5VxUBMfTXYJEq367ON+ECBnG0YBYE/RxZE/ipA==
X-Received: by 2002:a05:6000:2012:b0:3e7:441e:c9e1 with SMTP id ffacd0b85a97d-3e765793127mr2932126f8f.18.1757686859589;
        Fri, 12 Sep 2025 07:20:59 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6697435f8f.30.2025.09.12.07.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:20:58 -0700 (PDT)
Message-ID: <cda40929-12d7-4206-a4d9-3a74314c6b2e@gmail.com>
Date: Fri, 12 Sep 2025 16:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/38] arm64: dts: mediatek: mt7986a-bpi-r3: Set
 interrupt-parent to mdio switch
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, robh@kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, krzk+dt@kernel.org,
 conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jassisinghbrar@gmail.com,
 mchehab@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
 kishon@kernel.org, sean.wang@kernel.org, linus.walleij@linaro.org,
 lgirdwood@gmail.com, broonie@kernel.org, andersson@kernel.org,
 mathieu.poirier@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
 atenart@kernel.org, jitao.shi@mediatek.com, ck.hu@mediatek.com,
 houlong.wei@mediatek.com, kyrie.wu@mediatek.corp-partner.google.com,
 andy.teng@mediatek.com, tinghan.shen@mediatek.com, jiaxin.yu@mediatek.com,
 shane.chien@mediatek.com, olivia.wen@mediatek.com, granquet@baylibre.com,
 eugen.hristev@linaro.org, arnd@arndb.de, sam.shih@mediatek.com,
 jieyy.yang@mediatek.com, frank-w@public-files.de, mwalle@kernel.org,
 fparent@baylibre.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com>
 <20250724083914.61351-26-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRd1TlIARAAm78mTny44Hwd
 IYNK4ZQH6U5pxcJtU45LLBmSr4DK/7er9chpvJ5pgzCGuI25ceNTEg5FChYcgfNMKqwCAekk
 V9Iegzi6UK448W1eOp8QeQDS6sHpLSOe8np6/zvmUvhiLokk7tZBhGz+Xs5qQmJPXcag7AMi
 fuEcf88ZSpChmUB3WflJV2DpxF3sSon5Ew2i53umXLqdRIJEw1Zs2puDJaMqwP3wIyMdrfdI
 H1ZBBJDIWV/53P52mKtYQ0Khje+/AolpKl96opi6o9VLGeqkpeqrKM2cb1bjo5Zmn4lXl6Nv
 JRH/ZT68zBtOKUtwhSlOB2bE8IDonQZCOYo2w0opiAgyfpbij8uiI7siBE6bWx2fQpsmi4Jr
 ZBmhDT6n/uYleGW0DRcZmE2UjeekPWUumN13jaVZuhThV65SnhU05chZT8vU1nATAwirMVeX
 geZGLwxhscduk3nNb5VSsV95EM/KOtilrH69ZL6Xrnw88f6xaaGPdVyUigBTWc/fcWuw1+nk
 GJDNqjfSvB7ie114R08Q28aYt8LCJRXYM1WuYloTcIhRSXUohGgHmh7usl469/Ra5CFaMhT3
 yCVciuHdZh3u+x+O1sRcOhaFW3BkxKEy+ntxw8J7ZzhgFOgi2HGkOGgM9R03A6ywc0sPwbgk
 gF7HCLirshP2U/qxWy3C8DkAEQEAAcLBdgQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TlIAhsMAAoJENkUC7JWEwLxtdcP/jHJ9vI8adFi1HQoWUKCQbZdZ5ZJHayFKIzU9kZE
 /FHzzzMDZYFgcCTs2kmUVyGloStXpZ0WtdCMMB31jBoQe5x9LtICHEip0irNXm80WsyPCEHU
 3wx91QkOmDJftm6T8+F3lqhlc3CwJGpoPY7AVlevzXNJfATZR0+Yh9NhON5Ww4AjsZntqQKx
 E8rrieLRd+he57ZdRKtRRNGKZOS4wetNhodjfnjhr4Z25BAssD5q+x4uaO8ofGxTjOdrSnRh
 vhzPCgmP7BKRUZA0wNvFxjboIw8rbTiOFGb1Ebrzuqrrr3WFuK4C1YAF4CyXUBL6Z1Lto//i
 44ziQUK9diAgfE/8GhXP0JlMwRUBlXNtErJgItR/XAuFwfO6BOI43P19YwEsuyQq+rubW2Wv
 rWY2Bj2dXDAKUxS4TuLUf2v/b9Rct36ljzbNxeEWt+Yq4IOY6QHnE+w4xVAkfwjT+Vup8sCp
 +zFJv9fVUpo/bjePOL4PMP1y+PYrp4PmPmRwoklBpy1ep8m8XURv46fGUHUEIsTwPWs2Q87k
 7vjYyrcyAOarX2X5pvMQvpAMADGf2Z3wrCsDdG25w2HztweUNd9QEprtJG8GNNzMOD4cQ82T
 a7eGvPWPeXauWJDLVR9jHtWT9Ot3BQgmApLxACvwvD1a69jaFKov28SPHxUCQ9Y1Y/Ct
In-Reply-To: <20250724083914.61351-26-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2025 10:39, AngeloGioacchino Del Regno wrote:
> Being this an interrupt controller, the binding forbids to use
> interrupts-extended and wants an `interrupts` property instead.
> 
> Since this interrupt controller's parent is on the GPIO controller
> set it as interrupt-parent and change interrupts-extended to just
> interrupts to silence a dtbs_check warning.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> index 6d2762866a1a..e7654dc9a1c9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -200,8 +200,9 @@ switch: switch@31 {
>   		compatible = "mediatek,mt7531";
>   		reg = <31>;
>   		interrupt-controller;
> +		interrupt-parent = <&pio>;
> +		interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
>   		#interrupt-cells = <1>;
> -		interrupts-extended = <&pio 66 IRQ_TYPE_LEVEL_HIGH>;
>   		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
>   	};
>   };


