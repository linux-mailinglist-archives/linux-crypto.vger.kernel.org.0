Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4151F04B
	for <lists+linux-crypto@lfdr.de>; Sun,  8 May 2022 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiEHTVz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 May 2022 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiEHTEg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 May 2022 15:04:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37FF23F
        for <linux-crypto@vger.kernel.org>; Sun,  8 May 2022 12:00:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r1-20020a1c2b01000000b00394398c5d51so7166344wmr.2
        for <linux-crypto@vger.kernel.org>; Sun, 08 May 2022 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XeJnNNlIllodvcVQo3PDKeXH2oW9QkUYejnaC12tvI=;
        b=EKLb8gFApnhW1NHMOvk+HTnlP5d2IGcAS2IJkExF+KZUAFIXqmLMINZEwKiXIcd+PX
         GeWTv2PjtyigU6V14+/nkFywTtyo65wizpAdkkboK8pdgfqzN+PzGMUwo4O1l2ZFgCFU
         Gy8ec67I/C7DsrhErMIpBYpCgTfcUA/6dX8jGmOGnHpN8G3MkSn1pDEhuGYLmWhHmGAX
         jURzzE1OSPkaJu8qL7qKeUR7DbunQnafGYNtKt2anQugwEOhiII0PZEqP1Lpbv/xMPnJ
         WGSXmsKx4Jci2WDX/6FJdn2c5T8pKFFRHO4jTyZab3ylxEMTT5HwUfC30hOIrfhkAsvp
         VsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XeJnNNlIllodvcVQo3PDKeXH2oW9QkUYejnaC12tvI=;
        b=hZXYlJ1DYMc0DdQgTtDZEiGLZjhGjwda/0oUtI/QkQpwgUK5SydqondiHH4c+IeivM
         yKqqjFMzesFdh0XYrgvHCkmh2nVXl5UUVFpgoV8AIxnxc2Dz1DOoNkyPjIAvTgk0xBP1
         v94VNoShM6ZZu5cBeki4rTeo8Q5I9mdx1PVZzR9drqY+NNWBTIBLaNU37OAmkDut3orB
         WEgB9E2VEQElchznXKO58ujejgkCEk8fTVA4ZiB2pZi/Q9/wyQuge6zjEYsicDDKGtpT
         7dRyRhmvke/aE6y8rkKer7btIFJPC69saip0dzwFBDmSEc7tIBPZIeC1bFDEQ4/8N2HO
         3OOA==
X-Gm-Message-State: AOAM5325YRxhNekdPkQ7Ri2kTB5Bvmkj3WkeUJ8gxC/GOma27X88iWws
        nkwxLctP7+++xcculX79k+3A9w==
X-Google-Smtp-Source: ABdhPJwwRntsdzFUuXKfkmpqvNijx908tSi2UxBRgQNCzWBUOaPaiLjRkknap7Jh4nyl+xg16ddrDg==
X-Received: by 2002:a05:600c:4994:b0:394:dcb:d66d with SMTP id h20-20020a05600c499400b003940dcbd66dmr19323600wmp.178.1652036431415;
        Sun, 08 May 2022 12:00:31 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:30 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Sun,  8 May 2022 18:59:49 +0000
Message-Id: <20220508185957.3629088-26-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The latest addition to the rockchip crypto driver need to update the
driver bindings.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index 8a219d439d02..5bb6bf4699ff 100644
--- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -13,6 +13,8 @@ properties:
   compatible:
     enum:
       - rockchip,rk3288-crypto
+      - rockchip,rk3328-crypto
+      - rockchip,rk3399-crypto
 
   reg:
     maxItems: 1
@@ -21,21 +23,88 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aclk
-      - const: hclk
-      - const: sclk
-      - const: apb_pclk
+    minItems: 3
+    maxItems: 4
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: crypto-rst
+    minItems: 1
+    maxItems: 3
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-crypto
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          items:
+            - const: aclk
+            - const: hclk
+            - const: sclk
+            - const: apb_pclk
+          minItems: 4
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+          maxItems: 3
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+          maxItems: 3
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: rst_master
+            - const: rst_slave
+            - const: crypto-rst
+          minItems: 3
 
 required:
   - compatible
-- 
2.35.1

