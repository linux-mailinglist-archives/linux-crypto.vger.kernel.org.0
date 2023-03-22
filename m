Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC06C4970
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Mar 2023 12:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCVLpn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Mar 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCVLpj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Mar 2023 07:45:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6AA5F20C
        for <linux-crypto@vger.kernel.org>; Wed, 22 Mar 2023 04:45:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so18869585pjb.0
        for <linux-crypto@vger.kernel.org>; Wed, 22 Mar 2023 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/QZc9gZG9fueXODq2o89xljOdcpkBJcOX9/f1kD4r0=;
        b=or8ldxV5kusHSiQsQe6hGg43hc2lWIR9VMZIxoE14kX98zSmsLfczaENHd+hmCP3X4
         eB3d8d6ib/SP6DSz/XgWpnB4JuZhDgY/kk3Zjn8lFOFNJIeWyGWKdBK1AUD6CATWZvqP
         72mzMLQmI2BEI8gWJ5Fm00SDxWk1Sj9kwTmayohDd3fVB/Xy9YD+FxFrfI0tqqBt9ZjU
         6cug9Q8WmWVgwG9lyoKwbDNliFfUKl49IRfQM1DoFVdJDnR7x3CynO7H9ZfpVm+pS+KG
         fkR5qj232Rzb1hQfaCgqHsOrFhWH5h7ZSEAZaO/1FsDqMZXPGjSfvc6fhwA8PJWN90+H
         ePBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/QZc9gZG9fueXODq2o89xljOdcpkBJcOX9/f1kD4r0=;
        b=5hsJMWDGqIzHhWLB++nf6HKi3jTBcCUVyTeM+QQHX61DLrVI3C5/tbGMYHIGdaJ1cv
         PcWCV4kzD3YMlmYf0AAqtjBxIxp0mE+Fr0C9JR6VO1VX0AedRALJl+xvYN7JDpfCnlPc
         I8gd9tB4LubEAVJhFNFuJcgBKjzwTpOg3CW5nmsoiK7kp/OBdV9gfu5ah9zRSzoPCslY
         KwNb/JxLAQuHhWXfsyyaoMw4/GBr3+Xyb5xGmtz/ozBKhuBI9OhEmnu79zIuOXSCe/0N
         xNlfMducp8Z1OZ0BJ3ngfi8KrbrNd60HQL5ljDx34SLGCxALGbgE3BlcHn8d6UO0obFt
         XGGA==
X-Gm-Message-State: AO0yUKX9xsptpczp3dfsZ6jBoLZlRhuR0inDgbS/d0QFMh6laCCq6Bpg
        OfN9qLGTJbYFloFd4NOy6NWucA==
X-Google-Smtp-Source: AK7set8SrFPz7VfgccdksCeX1tta+eH6/BdIGuAiEvNleZK2KwK9fKdp7eS6t2vUpq9JrduepBlI2A==
X-Received: by 2002:a17:902:dacf:b0:19f:36b1:c35 with SMTP id q15-20020a170902dacf00b0019f36b10c35mr3257626plx.64.1679485537813;
        Wed, 22 Mar 2023 04:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:45:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 01/10] dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
Date:   Wed, 22 Mar 2023 17:15:10 +0530
Message-Id: <20230322114519.3412469-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
References: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index f1ddcf672261..624208d20a34 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -15,13 +15,21 @@ allOf:
 
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
+      - items:
+          - enum:
+              # APQ8064, IPQ8064 and MSM8960
+              - qcom,bam-v1.3.0
+              # MSM8974, APQ8074 and APQ8084
+              - qcom,bam-v1.4.0
+              # MSM8916
+              - qcom,bam-v1.7.0
+
+      - items:
+          - enum:
+              # SDM845, SM6115, SM8150, SM8250 and QCM2290
+              - qcom,bam-v1.7.4
+          - const: qcom,bam-v1.7.0
 
   clocks:
     maxItems: 1
-- 
2.38.1

