Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC84EFB3F
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Apr 2022 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiDAUV0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Apr 2022 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351992AbiDAUVE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 Apr 2022 16:21:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030D275CAB
        for <linux-crypto@vger.kernel.org>; Fri,  1 Apr 2022 13:18:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h23so5778615wrb.8
        for <linux-crypto@vger.kernel.org>; Fri, 01 Apr 2022 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMuWbodJyhmCb7hmEWkoVY/bSgVMUfCQs2M7Z5YmUsI=;
        b=APv+8vZN/p43PEYAYXXkQ97MQMdsMXNOXBpZBk7wwh+Kgp2i8Q2CtF4FYZ5aWu9TRV
         s0c/zx8X06gV/OI180ba+mj0ypPHDr8mhDBivBxWCMnGs8fKjPmYQAj3OQGE2Yc8wm4c
         5y1eUxUYeAoEGew7Rj50TASiXH06CCMg/Asn5WLFwudAjq0pRIWrXgWTZ30cb20ReP6t
         OzWQg4s/UluvLBJCWObOwi7NEhtfgDmeMKwKYaDZYyfxj4BobHoNXpaiW73Q1903j8vl
         90nqxbW21xHChXWgvog5PImVlLBccj9EK2Bb65JPMeV10G8fGeh1bOPVMlVeUC6dtylX
         8WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMuWbodJyhmCb7hmEWkoVY/bSgVMUfCQs2M7Z5YmUsI=;
        b=7q7bLw9PxGlMaKLYHmyWt63Z2gQsjw3Zx3BQhMXu9ShCEukcHrVO5J2kK1KAUf7XKF
         FoGq0or3XT7Rzl1PsZ7kKxUXreH84Sw/i6eujRSAwRdTKHGnfXjJhllfov6Dd8Vq6uXZ
         i9u30LEWzmiE9+iqCJVauvBk9Zu2UdlIagcxJ5Gbe5QDQjniDAhoTJePplXipoaWCcbn
         34TW2N1+Aw8Cl8e5xU9oVw8SejAnRYSHRTl59uafxo+j7fiu+5esmS+NpN78YRR6+TFx
         3pjAt3glUDGWlLAsEwzcYeU6gg0BL/D/ng54rBVQXQII/N3wZhBRgl7KuOtLWr2w0fhM
         A4SA==
X-Gm-Message-State: AOAM5322Alz8IXmV+jkVO13dJhH+J+HZI+1MSK9+/2RF0aTStnltlxM+
        RSv6lMeHLngkoyBZw47E9tX28A==
X-Google-Smtp-Source: ABdhPJxgiFstTAIC2faAeEqGBB2eVy/Dl6VuZHzoFW4rlvVrxHMS7ueZQeP0OvVyPtWKbQ3SOnFb/A==
X-Received: by 2002:a5d:404c:0:b0:203:ea4e:3c07 with SMTP id w12-20020a5d404c000000b00203ea4e3c07mr8623820wrp.597.1648844311436;
        Fri, 01 Apr 2022 13:18:31 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 28/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Fri,  1 Apr 2022 20:17:59 +0000
Message-Id: <20220401201804.2867154-29-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
 .../crypto/rockchip,rk3288-crypto.yaml        | 68 +++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index 66db671118c3..e6c00bc8bebf 100644
--- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -11,8 +11,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - rockchip,rk3288-crypto
+    oneOf:
+      - description: crypto IP present on RK3288 SoCs
+        items:
+          - const: rockchip,rk3288-crypto
+      - description: crypto IP present on RK3328 SoCs
+        items:
+          - const: rockchip,rk3328-crypto
+      - description: crypto IPs present on RK3399. crypto0 is the first IP with
+                     RSA support, crypto1 is the second IP without RSA.
+        enum:
+          - rockchip,rk3399-crypto0
+          - rockchip,rk3399-crypto1
 
   reg:
     maxItems: 1
@@ -21,16 +31,65 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
+    minItems: 3
     maxItems: 4
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    maxItems: 1
+    deprecated: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-crypto
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: "aclk"
+            - const: "hclk"
+            - const: "sclk"
+            - const: "apb_pclk"
+          minItems: 4
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-crypto
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: "hclk_master"
+            - const: "hclk_slave"
+            - const: "sclk"
+          maxItems: 3
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3399-crypto0
+              - rockchip,rk3399-crypto1
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: "hclk_master"
+            - const: "hclk_slave"
+            - const: "sclk"
+          maxItems: 3
+        resets:
+          minItems: 3
 
 required:
   - compatible
@@ -39,7 +98,6 @@ required:
   - clocks
   - clock-names
   - resets
-  - reset-names
 
 additionalProperties: false
 
-- 
2.35.1

