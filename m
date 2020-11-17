Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C28A2B648A
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Nov 2020 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbgKQNrz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Nov 2020 08:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733187AbgKQNrR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Nov 2020 08:47:17 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F5C0617A7
        for <linux-crypto@vger.kernel.org>; Tue, 17 Nov 2020 05:47:16 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so20302778qkb.7
        for <linux-crypto@vger.kernel.org>; Tue, 17 Nov 2020 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGZNfBnMhcoajJLQ/PaK163KVnh/WRfsEYaW7uieePg=;
        b=uITHCquF0CJt2Uab+/hGYZm0vWFhcGH9FRKGyQXczn6wRa24Wy4LVxkn98bIOrZVOh
         qKY0FmAmQLVAbapXIlEJsmkbgjcWmZvCvr8+EkkpNNOXelHLN9exGQ0OdpUkW/GQsXIo
         d/uIsmLcPBKghxGUHgSOGc6oy9mo4MyJnFCV5B/8DhL/l6wKzc1lEvIrTK4Bv881A2/T
         mz3hv1zc0NbhEgWLJLsTUemzWAH1rQE6ijp1+ntSy6/FrW56sYkQmYUqqeoGvgfpVhz4
         Y8CORkb3QWgvfNsuaYXbqBWgt3XxnUVuhR6YPLGLjpq2RovdyKq+Y2Q3spgD/zVWZBYq
         CSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGZNfBnMhcoajJLQ/PaK163KVnh/WRfsEYaW7uieePg=;
        b=qLTTKbn++hjaEBcFTG8OOP4okED5Ar3ZkfrYW5rBlH7XzHm81GlveA/zX+E57hmOw3
         tJbjo4KjbKOFGP2LCIgZHe04kdCg3Q97fC7DFQqRiJEYHeGKyKaLldEIokWR8TzDNqgp
         EJpwjJ5UlQCEXC01XS/UOPAmCcnzdhttKMObyrgJpgNHCYDZxJIGQRNEmZjGAR5Qu5Km
         PqyOMP40g/WQwJQsmFZRAWzIpJB+qUqJxpFaOf7JHZmFcQYOjTQuwUJLrR5JJebrMMpP
         NT1V5eUwO169eWqsRrTATadKxC/Jl2CFQD92CBoRW7+gvDFgoNIrJWogWIEVZZAeugmy
         lXNw==
X-Gm-Message-State: AOAM530oBdAuZF3/Kji0nhJiZdyR1CuLHBDAF6B5/tVHCscdOMRQ7Yus
        esrjclF+6fMiU0Utz06SgMrtJ9ITdsy+eQ==
X-Google-Smtp-Source: ABdhPJxWMKszw/F8jgG5+KqgSBxWMDaR48rZToh6p3HknBV2X6MaSjtNAp8Y/yTPmj5ZGMtKQ4xL+Q==
X-Received: by 2002:a05:620a:5f6:: with SMTP id z22mr19190467qkg.211.1605620835911;
        Tue, 17 Nov 2020 05:47:15 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id t133sm14607355qke.82.2020.11.17.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 05:47:15 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 0/6] Enable Qualcomm Crypto Engine on sdm845
Date:   Tue, 17 Nov 2020 08:47:08 -0500
Message-Id: <20201117134714.3456446-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Qualcomm crypto engine supports hardware accelerated algorithms for
encryption and authentication. Enable support for aes,des,3des encryption
algorithms and sha1,sha256, hmac(sha1),hmac(sha256) authentication
algorithms on sdm845.The patch series has been tested using the kernel
crypto testing module tcrypto.ko.

Thara Gopinath (6):
  dt-binding:clock: Add entry for crypto engine RPMH clock resource
  clk:qcom:rpmh: Add CE clock on sdm845.
  drivers:crypto:qce: Enable support for crypto engine on sdm845.
  drivers:crypto:qce: Fix SHA result buffer corruption issues.
  dts:qcom:sdm845: Add dt entries to support crypto engine.
  devicetree:bindings:crypto: Extend qcom-qce binding to add support for
    crypto engine version 5.4

 .../devicetree/bindings/crypto/qcom-qce.txt   |  4 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 30 +++++++++++++++++++
 drivers/clk/qcom/clk-rpmh.c                   |  2 ++
 drivers/crypto/qce/core.c                     | 17 ++++++++++-
 drivers/crypto/qce/sha.c                      |  2 +-
 include/dt-bindings/clock/qcom,rpmh.h         |  1 +
 6 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.25.1

