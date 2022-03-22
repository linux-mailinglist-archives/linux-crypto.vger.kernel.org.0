Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9027F4E3B83
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Mar 2022 10:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiCVJNj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Mar 2022 05:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiCVJNi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Mar 2022 05:13:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41D7E59C
        for <linux-crypto@vger.kernel.org>; Tue, 22 Mar 2022 02:12:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so6015086wrc.13
        for <linux-crypto@vger.kernel.org>; Tue, 22 Mar 2022 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qjT77DYYL/GJDwodJ6Rapm1bpiNcBpPlg2Vo7gCqJB8=;
        b=YHPUJUn3zIjNoMGTdwff2Vfop45kQtaHqwdMY6Nf8YYhoP7j4H4GyXGENtvzHBaohP
         F2MgM6pQidOA1F9Uq+q+SVMZR6AGKPBRf8tBeqoqe6Mdq2WTxk7cNHZ6zlePagEwmM91
         Yo3oMJuAk+OfT3Hp6pPqHN1iV5UhwJ7kJcjVRcnRF9bGo8WXBUr1dmWcuxv0rxlQ5WJx
         PRn8cHwW9Q2h2QVnvyff5uKC7pk3mUtYBsAzefyp7x9sdbToS2G+u8m4HdvZUkEXYVxS
         5IAnOPoa+Rog0P93TZ+oXkPfUbVVnlAqf4smHVGah/4oE00rlX/6OLWizehJas3RtOyt
         KXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qjT77DYYL/GJDwodJ6Rapm1bpiNcBpPlg2Vo7gCqJB8=;
        b=j6xjIGxeOkk1kuBnpMXbFLzrm7P/E1VNBrSL+/ZRh0ungdBqIQnRtNaDqB512GHT6O
         vBOspwG2OdJF0k5VnGAQg0L1qXdSoGFRQddnuPuCIp1ELvJXiWNlnQxmQoUxz+wCVygq
         8BUPJc8CLrLvwsks9mu7uBhJtIPSdR9ZTB6h/rR/TkcAQb10GgK6MNCVHsfx554eFFdX
         X3A050QfXMNyTXruo08TTActSbIL9Alq7wiRZojJF5J6wVJrEJzCDhTVsDVLg2CPMSXZ
         BPWjj6wzQU88mZoJApemdhC9sMRL++9SkuBJvR1T7lzBaEmNXQJTI7/7GjDgBKTy/DF2
         14CA==
X-Gm-Message-State: AOAM531IW+PdmXmUUeS47xGgW1IeyGnUm/vy7mz8hO/Dfdpfj0Pas/hD
        yU/Kg1rEYO1n6QA94nHEbi767Q==
X-Google-Smtp-Source: ABdhPJwLrFHSs/rg59Z4qNL8r8Ak6OWe1nu8EXetVqZllyP8jhyj2fCHM/JwIgFdiBq/bbrEdWHwGA==
X-Received: by 2002:a05:6000:2ca:b0:204:1e6a:d2a9 with SMTP id o10-20020a05600002ca00b002041e6ad2a9mr3768869wry.182.1647940327256;
        Tue, 22 Mar 2022 02:12:07 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm17176008wrs.73.2022.03.22.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:12:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:12:04 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-crypto@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        herbert@gondor.apana.org.au, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 21/26] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Message-ID: <YjmS5DE95xTuJMi7@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-22-clabbe@baylibre.com>
 <1647913851.207213.941032.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1647913851.207213.941032.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Le Mon, Mar 21, 2022 at 08:50:51PM -0500, Rob Herring a �crit :
> On Mon, 21 Mar 2022 20:07:34 +0000, Corentin Labbe wrote:
> > Convert rockchip-crypto to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 84 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 -------
> >  2 files changed, 84 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1607887
> 
> 
> cypto-controller@ff8a0000: 'reset-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
> 	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly.dt.yaml
> 	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
> 	arch/arm/boot/dts/rk3288-miqi.dt.yaml
> 	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
> 	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
> 	arch/arm/boot/dts/rk3288-r89.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
> 	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker.dt.yaml
> 	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
> 	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
> 	arch/arm/boot/dts/rk3288-vyasa.dt.yaml
> 

Hello

This should not happen since patch 20 remove it.

Regards
