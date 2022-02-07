Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B774AB42C
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Feb 2022 07:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiBGGA7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Feb 2022 01:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350168AbiBGDZU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 6 Feb 2022 22:25:20 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:25:17 PST
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A606C061A73;
        Sun,  6 Feb 2022 19:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644204318; x=1675740318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfZXbSjfHN2zhkIvf0MRCwkDTCAF9Wzn7xDTBknnhxM=;
  b=tdjF8/KZBdeJ/LK4IjStVin+bzi7eRVav8HsrkhgVN9mk5iMFWwbPlp/
   QuVfYLAJc0u/7BIsSEesB2aun/TQTqCy2Ywa2FdeMbKlhtq5nlJ6OWQOc
   y9EUqcVj+ts+OU0Uc0qdhSqWlpkCkd1li6BexAERS5lRcgYA5YTPnpucs
   4s1s346ui8MBdSUmPvrmKaKKVLya5jPFVNG6oeBQfeSiWIZ3o3t09mRCs
   HvAW8ynhaBgfljbK7/92p2TVdJPF4GO1Vn0yA+H1qj5r6xJ+0VgviuX/8
   Bn9AOStvDsnVSvwU3rZ02JEFjvMGByXXAcM9YGts1hA8lKWktnWKG2L/A
   g==;
IronPort-SDR: Z0NKONyjhiP0NRGdxtzlnVgQlI/yJXBEkOity4WjdOUXrp3too4yqNoOL9DGICI2+gQQ2sS4Zu
 HLMQd6IaON+NLpHYfveVtcmnaT9vNSDgS3afxWuzQ0Qbx95gJ/LF8dwssl4JBARP3ozI7xvcjl
 O6f0rVpGH0bKaXBF6KX2Pbt+cNER44xJBsQbQ7HoLsrN9QTuXh6Xx/XIpHlIMTRUK3mT1D+oZt
 NUWnYS81t8BiswooFkDKgD4xlK9ndJ1t8o16JsvLZcLU0rDJaX63W0hWGxb+N5mNm5wUFwVl9H
 g3fmo7wBY1fhPATfL/9FNv6y
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="147803309"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2022 20:24:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 6 Feb 2022 20:24:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 6 Feb 2022 20:24:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Date:   Mon, 7 Feb 2022 05:24:03 +0200
Message-ID: <20220207032405.70733-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207032405.70733-1-tudor.ambarus@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
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

Convert Atmel AES documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "aes_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../devicetree/bindings/crypto/atmel,aes.yaml | 65 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 20 ------
 2 files changed, 65 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,aes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/atmel,aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
new file mode 100644
index 000000000000..f77ec04dbabe
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,aes.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-aes
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
+    const: aes_clk
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
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    aes: aes@f8038000 {
+      compatible = "atmel,at91sam9g46-aes";
+      reg = <0xe1810000 0x100>;
+      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
+      clock-names = "aes_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
+             <&dma0 AT91_XDMAC_DT_PERID(2)>;
+      dma-names = "tx", "rx";
+      status= "okay";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
index f2aab3dc2b52..1353ebd0dcaa 100644
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
@@ -2,26 +2,6 @@
 
 These are the HW cryptographic accelerators found on some Atmel products.
 
-* Advanced Encryption Standard (AES)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-aes".
-- reg: Should contain AES registers location and length.
-- interrupts: Should contain the IRQ line for the AES.
-- dmas: List of two DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property.
-
-Example:
-aes@f8038000 {
-	compatible = "atmel,at91sam9g46-aes";
-	reg = <0xf8038000 0x100>;
-	interrupts = <43 4 0>;
-	dmas = <&dma1 2 18>,
-	       <&dma1 2 19>;
-	dma-names = "tx", "rx";
-
 * Triple Data Encryption Standard (Triple DES)
 
 Required properties:
-- 
2.25.1

