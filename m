Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D617539CA3
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jun 2022 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiFAFmp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Jun 2022 01:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiFAFml (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Jun 2022 01:42:41 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB05A16A
        for <linux-crypto@vger.kernel.org>; Tue, 31 May 2022 22:42:40 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2515Rn6E027924;
        Wed, 1 Jun 2022 13:27:50 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Jun
 2022 13:42:18 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] dt-bindings: crypto: add documentation for aspeed hace
Date:   Wed, 1 Jun 2022 13:42:03 +0800
Message-ID: <20220601054204.1522976-5-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2515Rn6E027924
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add device tree binding documentation for the Aspeed Hash
and Crypto Engines (HACE) Controller.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
---
 .../bindings/crypto/aspeed,hace.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,hace.yaml

diff --git a/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml b/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
new file mode 100644
index 000000000000..36b4ad0dc7fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/aspeed,hace.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/aspeed,hace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED HACE hash and crypto Hardware Accelerator Device Tree Bindings
+
+maintainers:
+  - Neal Liu <neal_liu@aspeedtech.com>
+
+description: |
+  The Hash and Crypto Engine (HACE) is designed to accelerate the throughput
+  of hash data digest, encryption, and decryption. Basically, HACE can be
+  divided into two independently engines - Hash Engine and Crypto Engine.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2500-hace
+      - aspeed,ast2600-hace
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    hace: hace@1e6d0000 {
+        compatible = "aspeed,ast2600-hace";
+        reg = <0x1e6d0000 0x200>;
+        interrupts = <4>;
+        clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+        clock-names = "yclk";
+        resets = <&syscon ASPEED_RESET_HACE>;
+    };
-- 
2.25.1

