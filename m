Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4019E4AD6D2
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Feb 2022 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbiBHL36 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Feb 2022 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356476AbiBHKtg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Feb 2022 05:49:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9BC03FEC3;
        Tue,  8 Feb 2022 02:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644317375; x=1675853375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M55KZu2QZB5/Dm64TNCQxn9MG29ddQ39+nhh37gfD/I=;
  b=BqstaFSOLY1KkJexNH83pnHkmNAI4LioEIyNv4q6a0Kclvi8BAQwLVio
   BlOJuAxjhUfqXxt3WFcruYYiBfVa7sdT/QtfAlzZif+aidfkuoyWqRaJV
   2RKv8ZEGNB6/Bsoc7Egl3i1m6/qtCP+ydIkdhuKlmgMaY0+1MPhBqvDCq
   UEREsFvKQfTdM+uVx3OtNqBNcH67Rlz/TiaKB/r/qcOqQwiDMzChDv+mj
   mrRtcUx/zgr8E+wUspne/tURReqoylgOe3fxBQQNvY/J+7XdwDlxaDbpe
   hVECXustUV+kZAx8qbUdIqFwQ18ZiGw2VaBZw6yo9jMwTI8u9AePRfScO
   g==;
IronPort-SDR: EkrbKHP3uOk0uVFmPiAseSDf13NtILToVfRQw/p4mx2PLqPCRMmClxA9SIXmw2bPFcX6uI0v2D
 eU0oISWnIgyX/qx2bllIvdDxFpSOa5AER2i703hAyKUO2v8OTCXZoWi0qwbs7N+ESs+FzxIdfL
 SmO5SG1LeCQh6fiGu00tc0l7mU82nWS21qKNJ5TaLMrHfGdCwgak+QukN0sgdLnmF9l3VqvzCA
 UsXj9UZev5aWaqRMZ7iqODWkijTcmtwqfqP6Xpid3RYMCQKEJnpzvo9RmkPxtgVvirFFHZTymJ
 PddesnsKnjKuKSRsCCsPOcd7
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="152299954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 03:49:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 03:49:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 03:49:27 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Date:   Tue, 8 Feb 2022 12:49:17 +0200
Message-ID: <20220208104918.226156-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208104918.226156-1-tudor.ambarus@microchip.com>
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Convert Atmel TDES documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "tdes_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../crypto/atmel,at91sam9g46-tdes.yaml        | 63 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 23 -------
 2 files changed, 63 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
new file mode 100644
index 000000000000..8a71f3feb6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,at91sam9g46-tdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-tdes
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: tdes_clk
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+
+    tdes: crypto@e2014000 {
+      compatible = "atmel,at91sam9g46-tdes";
+      reg = <0xe2014000 0x100>;
+      interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
+      clock-names = "tdes_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
+             <&dma0 AT91_XDMAC_DT_PERID(53)>;
+      dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
index 1353ebd0dcaa..5c6541cfcc4a 100644
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
@@ -2,29 +2,6 @@
 
 These are the HW cryptographic accelerators found on some Atmel products.
 
-* Triple Data Encryption Standard (Triple DES)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-tdes".
-- reg: Should contain TDES registers location and length.
-- interrupts: Should contain the IRQ line for the TDES.
-
-Optional properties:
-- dmas: List of two DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property.
-
-Example:
-tdes@f803c000 {
-	compatible = "atmel,at91sam9g46-tdes";
-	reg = <0xf803c000 0x100>;
-	interrupts = <44 4 0>;
-	dmas = <&dma1 2 20>,
-	       <&dma1 2 21>;
-	dma-names = "tx", "rx";
-};
-
 * Secure Hash Algorithm (SHA)
 
 Required properties:
-- 
2.25.1

