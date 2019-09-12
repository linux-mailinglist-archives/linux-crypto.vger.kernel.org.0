Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3574DB0ACD
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Sep 2019 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfILJDU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Sep 2019 05:03:20 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:42875 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730023AbfILJDU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Sep 2019 05:03:20 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x8C91pjU011596;
        Thu, 12 Sep 2019 12:01:51 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id E198662A57; Thu, 12 Sep 2019 12:01:51 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, vkoul@kernel.org, tglx@linutronix.de,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/2] dt-binding: hwrng: add NPCM RNG documentation
Date:   Thu, 12 Sep 2019 12:01:48 +0300
Message-Id: <20190912090149.7521-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190912090149.7521-1-tmaimon77@gmail.com>
References: <20190912090149.7521-1-tmaimon77@gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Random Number Generator (RNG).

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/rng/nuvoton,npcm-rng.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
new file mode 100644
index 000000000000..65c04172fc8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
@@ -0,0 +1,12 @@
+NPCM SoC Random Number Generator
+
+Required properties:
+- compatible  : "nuvoton,npcm750-rng" for the NPCM7XX BMC.
+- reg         : Specifies physical base address and size of the registers.
+
+Example:
+
+rng: rng@f000b000 {
+	compatible = "nuvoton,npcm750-rng";
+	reg = <0xf000b000 0x8>;
+};
-- 
2.18.0

