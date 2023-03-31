Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A86D25F0
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Mar 2023 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjCaQpU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Mar 2023 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjCaQpD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Mar 2023 12:45:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EA49E9
        for <linux-crypto@vger.kernel.org>; Fri, 31 Mar 2023 09:43:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kq3so21732387plb.13
        for <linux-crypto@vger.kernel.org>; Fri, 31 Mar 2023 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkYOLIZ1gQIsCBl6zAcU/vVfG9FTwn+4rSwIFFFP8Dg=;
        b=wqtW98+ku0+HQRwv1TcLcEicaTFMNbl2bsY6DojBGjgami1tewYS/PgQ+IUsY4Mekv
         BbqYFe9+uoOwsRm0h9ZOgad3Tc91wfacrGjdXsK/qMajLM86t7pfrONbhX0eBCIg9HD4
         hQ6bIEH/3WLqB4H29xQfDpBl0bJuuu2H57hb3R/cVVQy6lim8gXqVxP5AiWTeZc1k1xn
         m8xvXpBiTwjek0BvAOneYc1xE9WRmqYnSVNiTWkGMlQunWvs1pKGOodEVaBJMUWYfn0n
         UOBFq930qTOH5XS8XBnHTV9odRoVOjHzXgWw8d8kJTwqvgumUAFBpVb64G+w8h2M0znM
         1wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkYOLIZ1gQIsCBl6zAcU/vVfG9FTwn+4rSwIFFFP8Dg=;
        b=TwB1X6MSz33mX8Imm+qYg8PUEA3L8cE86ckNB1bviY+UiZyYjGfi8MXtdNpQFBsGVe
         YheOX8LTVTOYCgrFLFxBzom5JEBu/pmnU6nAI2JqjTflA0Szn1rIswZd48ENycsg5dO8
         PWZbendHJ4DeJZ7NAzCVnZeoDvhqTZjGKHfKD004v/i8/E17l5N309AzHmi5/w/6Zejm
         AStlJPo7RMnfQnT5cZk5pTvViJjnaugXn3Gkay70vWLpvmI1OVhZNp6A/xR8hJZJZwpf
         tK7Zn3QPMbQcBG5h0/dEhw0yoa+FD/aSu6wDMEVZS5n1HMM8YQ3kDZT66ENSveFU9/Fe
         1TMQ==
X-Gm-Message-State: AAQBX9fFeih6gMkn87fZJ6WMPs3mYVLZWsRKHeUn04GS61EJeUVgQcqL
        qW9nVH9y+RiR/WvXY8QwOybuIw==
X-Google-Smtp-Source: AKy350ZyJ0JS14L44Ky05I+5j+M4dseLFMeyuEpha8SjsiKWFrmveoQQgbD+N8z66AflZcv8CnMZGg==
X-Received: by 2002:a17:903:1252:b0:1a2:37fc:b591 with SMTP id u18-20020a170903125200b001a237fcb591mr26219213plh.69.1680281019130;
        Fri, 31 Mar 2023 09:43:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:43:38 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org,
        Bhupesh Sharma <bhupesh.sharma@qcom-hackbox.linaro.org>
Subject: [PATCH v4 01/11] dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
Date:   Fri, 31 Mar 2023 22:13:13 +0530
Message-Id: <20230331164323.729093-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add new compatible for BAM DMA engine version v1.7.4 which is
found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
accordingly.

While at it, also update qcom,bam-dma bindings to add comments
which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
This provides an easy reference for identifying the actual BAM DMA
version available on Qualcomm SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@qcom-hackbox.linaro.org>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index f1ddcf672261..c663b6102f50 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -15,13 +15,19 @@ allOf:
 
 properties:
   compatible:
-    enum:
-        # APQ8064, IPQ8064 and MSM8960
-      - qcom,bam-v1.3.0
-        # MSM8974, APQ8074 and APQ8084
-      - qcom,bam-v1.4.0
-        # MSM8916 and SDM845
-      - qcom,bam-v1.7.0
+    oneOf:
+      - enum:
+          # APQ8064, IPQ8064 and MSM8960
+          - qcom,bam-v1.3.0
+          # MSM8974, APQ8074 and APQ8084
+          - qcom,bam-v1.4.0
+          # MSM8916, SDM630
+          - qcom,bam-v1.7.0
+      - items:
+          - enum:
+              # SDM845, SM6115, SM8150, SM8250 and QCM2290
+              - qcom,bam-v1.7.4
+          - const: qcom,bam-v1.7.0
 
   clocks:
     maxItems: 1
-- 
2.38.1

