Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24DB43C640
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Oct 2021 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJ0JQU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Oct 2021 05:16:20 -0400
Received: from pv50p00im-ztdg10012101.me.com ([17.58.6.49]:58778 "EHLO
        pv50p00im-ztdg10012101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235260AbhJ0JQT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Oct 2021 05:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1635326034;
        bh=AM2bSsdlwCgyBBa8Y0P/K1QsbLW0FEVAQJgnx9yIMdg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XpK1FGwMipbWhh3LT8D0Q+xc48BVWsw8sRaWo9cKozOhu9A7z57safzCokbr0TFVL
         50hD6XPfLEw7+lfd7UJi38qpm0qoI1FWMYCszx2AStVVTNio8m6t4GVGYD/OM/7Zba
         kMhrV7d45uxtdNDr43s6AbmIxN4v29ehfFjchrFAd62ULBkQ6rHVKT2HF3UURYgdAS
         6keUw+CxOI4YZS/1veyjqe/Zrb0vKsgUtpM0tWmE07rCbr0wK3zgI3NbxzBIAD+0zH
         s52WhMQJEKedZhaJjolCuZjTEs+92VB5oq/qO3k8lfka6lZ5i3+/uRPf73NBpIJwe5
         Tr8rE+Xb057jg==
Received: from debian.lan (dhcp-077-251-223-151.chello.nl [77.251.223.151])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 29A8C8402DB;
        Wed, 27 Oct 2021 09:13:50 +0000 (UTC)
From:   Richard van Schagen <vschagen@icloud.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org,
        Richard van Schagen <vschagen@icloud.com>
Subject: [PATCH v3 1/2] dt-bindings: crypto: Add Mediatek EIP-93 crypto engine
Date:   Wed, 27 Oct 2021 17:13:28 +0800
Message-Id: <20211027091329.3093641-2-vschagen@icloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027091329.3093641-1-vschagen@icloud.com>
References: <20211027091329.3093641-1-vschagen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-27_02:2021-10-26,2021-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=611 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110270057
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add bindings for the Mediatek EIP-93 crypto engine.

Signed-off-by: Richard van Schagen <vschagen@icloud.com>
---
Changes since V2:
 - Adding 2 missing "static" which got lost in my editing (sorry)

Changes since V1
 - Add missing #include to examples

 .../bindings/crypto/mediatek,mtk-eip93.yaml   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/mediatek,mtk-eip93.yaml

diff --git a/Documentation/devicetree/bindings/crypto/mediatek,mtk-eip93.yaml b/Documentation/devicetree/bindings/crypto/mediatek,mtk-eip93.yaml
new file mode 100644
index 000000000..422870afb
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/mediatek,mtk-eip93.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/mediatek,mtk-eip93.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek EIP93 crypto engine
+
+maintainers:
+  - Richard van Schagen <vschagen@icloud.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek, mtk-eip93
+
+  reg:
+    maxItems: 1
+
+  interrupts-parent:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-parent
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    crypto: crypto@1e004000 {
+         compatible = "mediatek,mtk-eip93";
+         reg = <0x1e004000 0x1000>;
+         interrupt-parent = <&gic>;
+         interrupts = <GIC_SHARED 19 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.30.2

