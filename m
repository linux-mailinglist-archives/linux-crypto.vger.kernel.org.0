Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE711B7BF9
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Apr 2020 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgDXQpI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Apr 2020 12:45:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52028 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgDXQpI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Apr 2020 12:45:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OGj2OJ067904;
        Fri, 24 Apr 2020 11:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587746702;
        bh=a3YbnQzPP/EyIcZogb3ZBNHJfeBLiWbazbKGTNmqw9Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nPEx+GsdCR5kJsY25OzqcDwLD4QQNRUua2vwkMV+9OksBo+kebxI6cdeot+FBrzUs
         0cL1xpkEkJDkLe/JqnIN5z0RL30lOgyf/U3YNoj7kyd0BMzHhiMVv1uhAYLBbwLiKy
         pmQbq7Q+Hlnk5v1Je9JUiHYxoVn8RP/OaL3kLW0c=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OGj2WD103117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 11:45:02 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 11:45:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 11:45:01 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OGinTC033554;
        Fri, 24 Apr 2020 11:45:00 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     Keerthy <j-keerthy@ti.com>
Subject: [PATCHv2 7/7] arm64: dts: ti: k3-j721e-main: Add crypto accelerator node
Date:   Fri, 24 Apr 2020 19:44:30 +0300
Message-ID: <20200424164430.3288-8-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424164430.3288-1-t-kristo@ti.com>
References: <20200424164430.3288-1-t-kristo@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0b9d14b838a1..f41bd22ebac8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -256,6 +256,29 @@
 		};
 	};
 
+	main_crypto: crypto@4E00000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x0 0x4E00000 0x0 0x1200>;
+		power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x04E00000 0x00 0x04E00000 0x0 0x30000>;
+
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
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&k3_clks 264 1>;
+		};
+	};
+
 	main_pmx0: pinmux@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
