Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38B5584F87
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Jul 2022 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiG2LY4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Jul 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiG2LYz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Jul 2022 07:24:55 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC895286FA;
        Fri, 29 Jul 2022 04:24:52 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 26TB5WpW050856;
        Fri, 29 Jul 2022 19:05:33 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 29 Jul
 2022 19:23:17 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        "Johnny Huang" <johnny_huang@aspeedtech.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: [PATCH v9 3/5] ARM: dts: aspeed: Add HACE device controller node
Date:   Fri, 29 Jul 2022 19:23:11 +0800
Message-ID: <20220729112313.86169-4-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729112313.86169-1-neal_liu@aspeedtech.com>
References: <20220729112313.86169-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 26TB5WpW050856
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add hace node to device tree for AST2500/AST2600.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
Reviewed-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 8 ++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index c89092c3905b..04f98d1dbb97 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,14 @@ rng: hwrng@1e6e2078 {
 				quality = <100>;
 			};
 
+			hace: crypto@1e6e3000 {
+				compatible = "aspeed,ast2500-hace";
+				reg = <0x1e6e3000 0x100>;
+				interrupts = <4>;
+				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+				resets = <&syscon ASPEED_RESET_HACE>;
+			};
+
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2500-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 6660564855ff..095cf8d03616 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -323,6 +323,14 @@ apb {
 			#size-cells = <1>;
 			ranges;
 
+			hace: crypto@1e6d0000 {
+				compatible = "aspeed,ast2600-hace";
+				reg = <0x1e6d0000 0x200>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+				resets = <&syscon ASPEED_RESET_HACE>;
+			};
+
 			syscon: syscon@1e6e2000 {
 				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1000>;
-- 
2.25.1

