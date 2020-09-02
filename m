Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB90B25A966
	for <lists+linux-crypto@lfdr.de>; Wed,  2 Sep 2020 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBK21 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 2 Sep 2020 06:28:27 -0400
Received: from auth-smtp.nebula.fi ([217.149.52.145]:59005 "EHLO
        auth-smtp.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBK20 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 2 Sep 2020 06:28:26 -0400
Received: from developer-Precision-3630-Tower (82-203-173-204.bb.dnainternet.fi [82.203.173.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: xipheracom)
        by auth-smtp.nebula.fi (Postfix) with ESMTPSA id 10E6A42A3;
        Wed,  2 Sep 2020 13:28:21 +0300 (EEST)
From:   Atte Tommiska <atte.tommiska@xiphera.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Atte Tommiska <atte.tommiska@xiphera.com>
Subject: [PATCH v3 2/3] dt-bindings: rng: add bindings for Xiphera XIP8001B hwrng
Date:   Wed,  2 Sep 2020 13:28:16 +0300
Message-Id: <20200902102817.32172-3-atte.tommiska@xiphera.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902102817.32172-1-atte.tommiska@xiphera.com>
References: <20200902102817.32172-1-atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=8.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        authsmtp1-hki2.nebula.fi
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Document the device tree bindings of Xiphera's XIP8001B-trng IP.

Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/rng/xiphera,xip8001b-trng.yaml   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml

diff --git a/Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml b/Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
new file mode 100644
index 000000000000..1e17e55762f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/xiphera,xip8001b-trng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xiphera XIP8001B-trng bindings
+
+maintainers:
+  - Atte Tommiska <atte.tommiska@xiphera.com>
+
+description: |
+  Xiphera FPGA-based true random number generator intellectual property core.
+
+properties:
+  compatible:
+    const: xiphera,xip8001b-trng
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rng@43c00000 {
+        compatible = "xiphera,xip8001b-trng";
+        reg = <0x43c00000 0x10000>;
+    };
-- 
2.28.0

