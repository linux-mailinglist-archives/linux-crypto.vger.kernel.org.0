Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3627744BF7D
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Nov 2021 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKJLDW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Nov 2021 06:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhKJLDL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1459C061193
        for <linux-crypto@vger.kernel.org>; Wed, 10 Nov 2021 03:00:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so2710998plf.3
        for <linux-crypto@vger.kernel.org>; Wed, 10 Nov 2021 03:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kl/T88F25r8f4Ku0pHT3jWyyjVwCGP8jBzT3ZsV+t6c=;
        b=cZXAnuf5k/IaNtyS5xogwOnFGddfjeXy7FVrckHL/XkVQAltqf4O2YUBDIWecT/xgr
         DPOJ8G+7rhFubWhLel9+sL9/mnAEWwJXI9SkCl8ESFwNZ+dTFLHMxevhYhD4wY4MRk7q
         xPInEzuRdjEGLOAB9o+UqCp+4SQz41QtL8OPsbwo0cELuWwMLxd6O4gluLZek/2zcpxl
         FUxoThR9sNfTAZovZhQHsLQdhDTIKBgXNaE/1JRofeRdJ6q+otonl0NAqoACbJ/FtDYM
         h4BstBIKTc1jJUSovCOtIyDsxLKbZXQM54G4XWAqsYY/kJdhohp/ZFM3SAj+40WRaQ3S
         qP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kl/T88F25r8f4Ku0pHT3jWyyjVwCGP8jBzT3ZsV+t6c=;
        b=gUnJrkmjtZwCcK9T7E7BFuwe4Bu9pjzJkvjB2jdhleRNWuFBgVN+e9CCCNe1MTp46N
         i1y3pDjD7Tont17DA0B4nGzkP3ip8q1ndKHhfW5x2mqEancRgKXeIhsoZtClqhNqv//U
         SVzF7VkVHQqD4+1F7CvkE7ETwgozehmAvLF7XjY5tL4d1hcAitTko8yWiQEKD3vUIXQT
         5GILaaPsi9yu6viTqc8/sg89jJO/q6PWH3mJ6+lsHkiBc/VRTtIaYED2uWefL2AcvWu9
         W/dekKnn0x9jeLboSBFGCuuhmgmjplrOYsFOkLKC8xFwCzCiNvrrlbopR+uQqiiBAvjB
         Sqtw==
X-Gm-Message-State: AOAM532C/+YtjYPWYw59UvsN/Mw+or251AXZxCqBcqbPxNdw3LADoS/C
        yZAkJ5TURt3q08rqCmpz6yPlnw==
X-Google-Smtp-Source: ABdhPJxkWOikxhyUtXSLsL3VUZ6v0b0KfyIBRDafoSEW3dx1tECA+0pQKG7eR+nvHaC7OlOZqJFMdQ==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr15759231pjb.47.1636542017193;
        Wed, 10 Nov 2021 03:00:17 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:16 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 07/22] dt-bindings: qcom-qce: Convert bindings to yaml
Date:   Wed, 10 Nov 2021 16:29:07 +0530
Message-Id: <20211110105922.217895-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Convert Qualcomm QCE crypto devicetree binding to YAML.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/crypto/qcom-qce.txt   | 25 -------
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
deleted file mode 100644
index fdd53b184ba8..000000000000
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm crypto engine driver
-
-Required properties:
-
-- compatible  : should be "qcom,crypto-v5.1"
-- reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- clock-names : "iface" clocks register interface
-                "bus" clocks data transfer interface
-                "core" clocks rest of the crypto block
-- dmas        : DMA specifiers for tx and rx dma channels. For more see
-                Documentation/devicetree/bindings/dma/dma.txt
-- dma-names   : DMA request names should be "rx" and "tx"
-
-Example:
-	crypto@fd45a000 {
-		compatible = "qcom,crypto-v5.1";
-		reg = <0xfd45a000 0x6000>;
-		clocks = <&gcc GCC_CE2_AHB_CLK>,
-			 <&gcc GCC_CE2_AXI_CLK>,
-			 <&gcc GCC_CE2_CLK>;
-		clock-names = "iface", "bus", "core";
-		dmas = <&cryptobam 2>, <&cryptobam 3>;
-		dma-names = "rx", "tx";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
new file mode 100644
index 000000000000..3a839c159d92
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/qcom-qce.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm crypto engine driver
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description: |
+  This document defines the binding for the QCE crypto
+  controller found on Qualcomm parts.
+
+properties:
+  compatible:
+    const: qcom,crypto-v5.1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: iface clocks register interface.
+      - description: bus clocks data transfer interface.
+      - description: core clocks rest of the crypto block.
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: core
+
+  dmas:
+    items:
+      - description: DMA specifiers for rx dma channel.
+      - description: DMA specifiers for tx dma channel.
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-apq8084.h>
+    crypto-engine@fd45a000 {
+        compatible = "qcom,crypto-v5.1";
+        reg = <0xfd45a000 0x6000>;
+        clocks = <&gcc GCC_CE2_AHB_CLK>,
+                 <&gcc GCC_CE2_AXI_CLK>,
+                 <&gcc GCC_CE2_CLK>;
+        clock-names = "iface", "bus", "core";
+        dmas = <&cryptobam 2>, <&cryptobam 3>;
+        dma-names = "rx", "tx";
+    };
-- 
2.31.1

