Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2725868F73B
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Feb 2023 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBHSjA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Feb 2023 13:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjBHSia (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Feb 2023 13:38:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB4526F
        for <linux-crypto@vger.kernel.org>; Wed,  8 Feb 2023 10:38:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so21673187eda.11
        for <linux-crypto@vger.kernel.org>; Wed, 08 Feb 2023 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAHs+SDEqt1ZZjAtte39FysEWDFBUT1+AZHfiDgMVRA=;
        b=vv1ZJQWkIkONSmBeiG7pNI6Hcoa1H5TWQgwTku3Ls7bWSOGrTQ2UbnakOB2iEOU5qw
         TQGS1xg3ryBP44LpW6DKJ77W7o/28DgqjkM2tC6TYyvRe4dRVzRt1wwCucx9vUIvXhbj
         SnwlCmBQLC/9raKFEuMnwpTyBtGNxlBWf0FV0+YnH+kNnms2eoBJiC/m+GQzZ17//Kgj
         kECKyKT/xjFEePdH2ncrCqV7S5jLZ8dI4RawW98403Q/N47P+Hk5+du996GwvdSQBJuq
         4+lY7A537y3Q/aFaYwJ6kMLykSa4VJzU5ApoArKuULOSLfR39p8rrJQbjGIPA9NEPlrs
         G0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAHs+SDEqt1ZZjAtte39FysEWDFBUT1+AZHfiDgMVRA=;
        b=jYj83IW3EMu/VhjODFUcArgsJlPN03zRDK72fJEDC0t31Zf9GpHrE35T9SSPM1SuGR
         uKO+kKWE0h3NPIkPr5rM1matnJXNZksLJHixapf3ub5XJqPWPOrt8jVlMbze8rIBN+9j
         GwlUS+jshCnsLoEvgNsbKw0podIdzzaOfNPD+LIlhVkThViIG3bZ0pnzQib2mVq2a9g6
         hp97bHX6G0jZxK+FHm+pBYSfFNJr3FE+I/f+HrySSmzHCh6gKFuj17AX1ywBJV6P8ccs
         hBxD2GLIa1MFZQCyDIcpDDjjS1WndNn4ehItyhNHEpCawOux4FmclnYgYe6BcAgsxHxE
         nUlg==
X-Gm-Message-State: AO0yUKXN09HgCwJE2ivMXpkYpL1FfCJQOTy9A8bBPGFIB21z4blEo994
        6cgL+sEarQdBwqzTw28sskM5Hg==
X-Google-Smtp-Source: AK7set8jvWeiiJ8HRdxUE5ZrOm82+hU2lb7t7t3pIj64LRTS7tZjtkDo5HvxOnQgD5fbQGhW7Riykw==
X-Received: by 2002:a05:6402:510f:b0:49d:fd2a:39cd with SMTP id m15-20020a056402510f00b0049dfd2a39cdmr10566704edd.1.1675881509329;
        Wed, 08 Feb 2023 10:38:29 -0800 (PST)
Received: from localhost.localdomain (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id d22-20020a50cd56000000b004aaa8e65d0esm5179663edj.84.2023.02.08.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:38:28 -0800 (PST)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v9 13/14] crypto: qce: core: Make clocks optional
Date:   Wed,  8 Feb 2023 20:37:54 +0200
Message-Id: <20230208183755.2907771-14-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230208183755.2907771-1-vladimir.zapolskiy@linaro.org>
References: <20230208183755.2907771-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Thara Gopinath <thara.gopinath@gmail.com>

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware and the driver should not handle the clocks.
Make acquiring of all the clocks optional in crypto engine driver, so that
the driver initializes properly even if no clocks are specified in the dt.

Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Bhupesh: Massage the commit log]
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/crypto/qce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 336edba2513e..8e496fb2d5e2 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -209,15 +209,15 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	qce->core = devm_clk_get(qce->dev, "core");
+	qce->core = devm_clk_get_optional(qce->dev, "core");
 	if (IS_ERR(qce->core))
 		return PTR_ERR(qce->core);
 
-	qce->iface = devm_clk_get(qce->dev, "iface");
+	qce->iface = devm_clk_get_optional(qce->dev, "iface");
 	if (IS_ERR(qce->iface))
 		return PTR_ERR(qce->iface);
 
-	qce->bus = devm_clk_get(qce->dev, "bus");
+	qce->bus = devm_clk_get_optional(qce->dev, "bus");
 	if (IS_ERR(qce->bus))
 		return PTR_ERR(qce->bus);
 
-- 
2.33.0

