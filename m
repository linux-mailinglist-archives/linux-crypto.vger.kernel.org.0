Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F11F8F1C
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgFOHPU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 03:15:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43994 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgFOHPU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 03:15:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05F7FBVh007680;
        Mon, 15 Jun 2020 02:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592205311;
        bh=urWL+xGplHTB4efaGJSK4KzijW6kDqyDz5lf+3XyQyg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tvOUUvJxAYXWKSHvtn2hFOqijFDNXB6yXaYO62a58fh5L7fCBA7HtcVJBSkKcOfFn
         H2VKPc6EXilgpDfy7TY7IywFl+La2bn/oAPGQXWjHi7e2HN0QhKS+Am8J1GDVwVQbB
         tyAHcOqBi4CGwWzV2sdWcJhUGj0EP1T7MKm8rYHY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05F7FBaU080068
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 02:15:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 15
 Jun 2020 02:15:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 15 Jun 2020 02:15:11 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05F7ExrC062159;
        Mon, 15 Jun 2020 02:15:10 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <j-keerthy@ti.com>
Subject: [PATCHv4 6/7] arm64: dts: ti: k3-am6: Add crypto accelarator node
Date:   Mon, 15 Jun 2020 10:14:51 +0300
Message-ID: <20200615071452.25141-7-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615071452.25141-1-t-kristo@ti.com>
References: <20200615071452.25141-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add crypto accelarator node for supporting hardware crypto algorithms,
including SHA1, SHA256, SHA512, AES, 3DES, and AEAD suites.

Signed-off-by: Keerthy <j-keerthy@ti.com>
[t-kristo@ti.com: Modifications based on introduction of yaml binding]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 61815228e230..4615f2009a35 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -112,6 +112,28 @@
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
 	};
 
+	crypto: crypto@4E00000 {
+		compatible = "ti,am654-sa2ul";
+		reg = <0x0 0x4E00000 0x0 0x1200>;
+		power-domains = <&k3_pds 136 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x04E00000 0x00 0x04E00000 0x0 0x30000>;
+		status = "okay";
+
+		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
+				<&main_udmap 0x4001>;
+		dma-names = "tx", "rx1", "rx2";
+		dma-coherent;
+
+		rng: rng@4e10000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x0 0x4e10000 0x0 0x7d>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&k3_clks 136 1>;
+		};
+	};
+
 	main_pmx0: pinmux@11c000 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c000 0x0 0x2e4>;
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
