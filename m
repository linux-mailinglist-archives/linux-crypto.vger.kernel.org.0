Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635A114FD4D
	for <lists+linux-crypto@lfdr.de>; Sun,  2 Feb 2020 14:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBN1v (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 2 Feb 2020 08:27:51 -0500
Received: from foss.arm.com ([217.140.110.172]:46166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgBBN1v (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 2 Feb 2020 08:27:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780F430E;
        Sun,  2 Feb 2020 05:27:50 -0800 (PST)
Received: from ssg-dev-vb.kfn.arm.com (E111385.Arm.com [10.50.4.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62BC03F52E;
        Sun,  2 Feb 2020 05:27:46 -0800 (PST)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Weili Qian <qianweili@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: [PATCH v2 1/3] dt-bindings: add device tree binding for Arm CryptoCell trng engine
Date:   Sun,  2 Feb 2020 15:26:59 +0200
Message-Id: <1580650021-8578-2-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580650021-8578-1-git-send-email-hadar.gat@arm.com>
References: <1580650021-8578-1-git-send-email-hadar.gat@arm.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The Arm CryptoCell is a hardware security engine. This patch adds DT
bindings for its TRNG (True Random Number Generator) engine.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 .../devicetree/bindings/rng/arm-cctrng.yaml        | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/arm-cctrng.yaml

diff --git a/Documentation/devicetree/bindings/rng/arm-cctrng.yaml b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
new file mode 100644
index 0000000..fe9422e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/arm-cctrng.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/arm-cctrng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm ZrustZone CryptoCell TRNG engine
+
+maintainers:
+  - Hadar Gat <hadar.gat@arm.com>
+
+description: |+
+  Arm ZrustZone CryptoCell TRNG (True Random Number Generator) engine.
+
+properties:
+  compatible:
+    description: Should be "arm,cryptocell-7x3-trng"
+    const: arm,cryptocell-7x3-trng
+
+  interrupts:
+    description: Interrupt number for the device.
+    maxItems: 1
+
+  reg:
+    description: Base physical address of the engine and length of memory
+                 mapped region.
+    maxItems: 1
+
+  rosc-ratio:
+    description: Sampling ratio values from calibration for 4 ring oscillators.
+    maxItems: 1
+
+  clocks:
+    description: Reference to the crypto engine clock.
+
+required:
+  - compatible
+  - interrupts
+  - reg
+  - rosc-ratio
+
+additionalProperties: false
+
+examples:
+  - |
+    arm_cctrng: arm_cctrng@60000000 {
+        compatible = "arm,cryptocell-7x3-trng";
+        interrupts = <0 29 4>;
+        reg = <0x60000000 0x10000>;
+        rosc-ratio = <5000 1000 500 0>;
+    };
-- 
2.7.4

