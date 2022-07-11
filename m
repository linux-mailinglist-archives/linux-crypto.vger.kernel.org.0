Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B75682A5
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Jul 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiGFJHS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Jul 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiGFJGG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Jul 2022 05:06:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F761FCE7
        for <linux-crypto@vger.kernel.org>; Wed,  6 Jul 2022 02:04:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so21081596wrc.2
        for <linux-crypto@vger.kernel.org>; Wed, 06 Jul 2022 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1ZryWow92c9hwwvz5Hh3ukn+dkdomJWMwO/HyG9hMQ=;
        b=1hvxm1lYCf3dt/kNWqZz5AZEreEizX7NEtB62mDJGcxhqDzVDR6GsNQjJEw6hU3Li5
         DiiKB9lR7xHFHTLRAdNpWSWuQbSURbNkL4ltJzXpRwp/LO7NlZUKRyuZNF5Er/bAPBjH
         fHTn0cTIeLflHz8GDaigTuF2B018PZUuJJJ4xtbR6ZbHJTTNqJHyMKENGJ+uiSownI2k
         CD5lvOVAK4ovTpy9ILkL1b2htX61KzBLOSOsgPiYEkLzX9zQDN5FUXrVf9eJk04sXXFR
         j9ASqPnC7sBOK4hXbpnemsRssUwnMlNqTMG60Jpoqpbr/89/GDSIcxJ2Q4T3Chwgbbus
         lRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ZryWow92c9hwwvz5Hh3ukn+dkdomJWMwO/HyG9hMQ=;
        b=ihIPVzkVKyFeLTEzxgtgjbbmuYdIPHcvIooSJY7hZH6irChn8myCsbSSIFm4LpnTDx
         fSlDxOpX//YiNagAokFhmZPr28R8S5LQoGjnfUJPy01+rMp22J6Xm20jRHjCBEGDzSY5
         ser6kIzENhdZtpgirv717jXxXpkW4flgY29TxD6T88YJwT6RAMk4BQqfux4+stI45fyP
         5o/NW8pw85Lmw4AjeL6U5Z3YMkxaUA9z/kx5ZW1uEo6ZSLSBqGRnzpgv5XaxZcxezhAl
         g+7jA0vWkR1Vt1o2Ja22JONH4aKHr9m57mrgVkK0RSU+MFUlG5hn58jesMdfsJPJ/eMN
         V9pQ==
X-Gm-Message-State: AJIora9Suns8ekjZycTyevS0eFs59PJdwcuMI+NvPhmejh1AMbSVDCPF
        M81fhX71LJmxAPa8/DcaoUJ7Yw==
X-Google-Smtp-Source: AGRyM1uabznHJAkndj0/PP8wr1qRzCNfHAe31LWA6AzcW1fqDJpCvWnIpQT9vAyuXkgDBlb3NHxJMw==
X-Received: by 2002:a5d:59a9:0:b0:21d:7ee2:8f90 with SMTP id p9-20020a5d59a9000000b0021d7ee28f90mr1317827wrr.598.1657098297942;
        Wed, 06 Jul 2022 02:04:57 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:57 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 24/33] dt-bindings: crypto: convert rockchip-crypto to YAML
Date:   Wed,  6 Jul 2022 09:04:03 +0000
Message-Id: <20220706090412.806101-25-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Convert rockchip-crypto to YAML.

Reviewed-by: John Keeping <john@metanate.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 64 +++++++++++++++++++
 .../bindings/crypto/rockchip-crypto.txt       | 28 --------
 2 files changed, 64 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
new file mode 100644
index 000000000000..8a219d439d02
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Electronics Security Accelerator
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3288-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: sclk
+      - const: apb_pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: crypto-rst
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3288-cru.h>
+    crypto@ff8a0000 {
+      compatible = "rockchip,rk3288-crypto";
+      reg = <0xff8a0000 0x4000>;
+      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
+               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
+      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
+      resets = <&cru SRST_CRYPTO>;
+      reset-names = "crypto-rst";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
deleted file mode 100644
index 5e2ba385b8c9..000000000000
--- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Rockchip Electronics And Security Accelerator
-
-Required properties:
-- compatible: Should be "rockchip,rk3288-crypto"
-- reg: Base physical address of the engine and length of memory mapped
-       region
-- interrupts: Interrupt number
-- clocks: Reference to the clocks about crypto
-- clock-names: "aclk" used to clock data
-	       "hclk" used to clock data
-	       "sclk" used to clock crypto accelerator
-	       "apb_pclk" used to clock dma
-- resets: Must contain an entry for each entry in reset-names.
-	  See ../reset/reset.txt for details.
-- reset-names: Must include the name "crypto-rst".
-
-Examples:
-
-	crypto: cypto-controller@ff8a0000 {
-		compatible = "rockchip,rk3288-crypto";
-		reg = <0xff8a0000 0x4000>;
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
-			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
-		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
-		resets = <&cru SRST_CRYPTO>;
-		reset-names = "crypto-rst";
-	};
-- 
2.35.1

