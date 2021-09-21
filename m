Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41808413CF1
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Sep 2021 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhIUVud (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Sep 2021 17:50:33 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:34186 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhIUVub (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Sep 2021 17:50:31 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 0DF10F40B6A; Tue, 21 Sep 2021 23:39:48 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: nintendo-aes: Document the Wii and Wii U AES support
Date:   Tue, 21 Sep 2021 23:39:28 +0200
Message-Id: <20210921213930.10366-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921213930.10366-1-linkmauve@linkmauve.fr>
References: <20210921213930.10366-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Both of these consoles use the exact same AES engine, which only
supports CBC mode with 128-bit keys.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../bindings/crypto/nintendo-aes.yaml         | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nintendo-aes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/nintendo-aes.yaml b/Documentation/devicetree/bindings/crypto/nintendo-aes.yaml
new file mode 100644
index 000000000000..e62a2bfc571c
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/nintendo-aes.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/nintendo-aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii and Wii U AES engine
+
+maintainers:
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |+
+  The AES engine in the Nintendo Wii and Wii U supports the following:
+  -- Advanced Encryption Standard (AES) in CBC mode, with 128-bit keys
+
+properties:
+  compatible:
+    items:
+      - const: nintendo,hollywood-aes
+      - const: nintendo,latte-aes
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Not supported yet.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
-- 
2.33.0

