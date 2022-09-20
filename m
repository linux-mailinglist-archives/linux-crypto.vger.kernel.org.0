Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFA5BE4C6
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Sep 2022 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiITLmW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Sep 2022 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiITLlv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B474CD8
        for <linux-crypto@vger.kernel.org>; Tue, 20 Sep 2022 04:41:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v1so2064949plo.9
        for <linux-crypto@vger.kernel.org>; Tue, 20 Sep 2022 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D43FriF8Yk+RihV3AWvTxjGj5RlLxuv/h0UaxwnK8oA=;
        b=Xt3mmDnB0Fy/kdjE3kI0pr2/x7Ufm9o+2BQi4KB7VmXXabMETDcW3W4aTYQTZO+o/f
         izusB4jAHKkmo9rtqpoLuoUIzNnlVsuCkyIHDdtC2DK6iw+L954bi+N6MiJaI/VEGeVv
         igSVhb/eWT3dd7jqEtuaQh0LUIBBWTmDb50TpAdQpwPlHz/2CZOJTGCwW17W1wqoCl5Y
         coBwQQ+d7Kz5ybL6exXtyvG74qMA9wYjjuTej58/Vs/ts0kSt1xfTRwN7S6plLjF1uGR
         6qD2Loc9fdBYTppSvrBV1EJR3gQ6MKwy4Y2pouX1rflakIoJ7O+5z5RKnXdjZtTzYWwH
         xXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D43FriF8Yk+RihV3AWvTxjGj5RlLxuv/h0UaxwnK8oA=;
        b=3hIvZbe79z91Ke+psmislD7zacB7OZFW52NotDimcnolZHP7GXVvRrU6Jnsyhdh5kF
         K53+UjBoUI23rg5EmlOX1cdnCamRqSdNVRTAQV6YS9J81hwtdUup7/UmJdupA2VOJFPt
         76kON2JZn84P22zlHPRKNfIeZPOT3pB4IG5TDMsWgII+IlCnIByk4QsacM3MgzNfoJbc
         R6KUzmsbY0vBnGxKsZX+mGXWMqHWLZd/GsustYm51IyqfnlMK8v+HI8KdlgVmsTL8R7p
         tcod3zy4/JP+qOn9RFH9DiBtIM4ax8D5BUDdcjA9cXh4sjcADw1l6s4fQixvhn3wjMKV
         Xcbg==
X-Gm-Message-State: ACrzQf3F2HVsBgHaAwBD4OvE0bmMRgrYCrz5rr1e5Mj15Yhk1/kQ6bmw
        FZ5dGP5G49+VqxX+juUZJ0B8KVEMVvmLMQ==
X-Google-Smtp-Source: AMsMyM4AZPh3YDSHRT3YIht1HfYwq0DAw5iIaYkk+BSBsv7+zyZaoOS15BR1BEQy9nwX4a7rJ1Qlqw==
X-Received: by 2002:a17:90b:46d3:b0:203:ab28:9e78 with SMTP id jx19-20020a17090b46d300b00203ab289e78mr3471744pjb.188.1663674099909;
        Tue, 20 Sep 2022 04:41:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:39 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 7/9] crypto: qce: core: Make clocks optional
Date:   Tue, 20 Sep 2022 17:10:49 +0530
Message-Id: <20220920114051.1116441-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Thara Gopinath <thara.gopinath@gmail.com>

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware and the driver need not/ should not handle the
clocks. Make acquiring of all the clocks optional in crypto engine driver
so that the driver initializes properly even if no clocks are specified in
the dt.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: herbert@gondor.apana.org.au
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Bhupesh: Massage the commit log]
---
 drivers/crypto/qce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 99ed540611ab..ef774f6edb5a 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -213,15 +213,15 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->mem_path))
 		return PTR_ERR(qce->mem_path);
 
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
2.37.1

