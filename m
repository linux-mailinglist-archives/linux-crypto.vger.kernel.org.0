Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28312210EE
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Jul 2020 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGOP1a (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Jul 2020 11:27:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33170 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgGOP1T (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Jul 2020 11:27:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 827621A1439;
        Wed, 15 Jul 2020 17:27:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75C6E1A048B;
        Wed, 15 Jul 2020 17:27:17 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 83E2E2035C;
        Wed, 15 Jul 2020 17:27:16 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] ARM: dts: imx6sll: add rng
Date:   Wed, 15 Jul 2020 18:26:02 +0300
Message-Id: <20200715152604.10407-4-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715152604.10407-1-horia.geanta@nxp.com>
References: <20200715152604.10407-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add node for the RNGB block.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index fb5d3bc50c6b..0b622201a1f3 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -786,6 +786,13 @@
 				clocks = <&clks IMX6SLL_CLK_MMDC_P0_IPG>;
 			};
 
+			rngb: rng@21b4000 {
+				compatible = "fsl,imx6sll-rngb", "fsl,imx25-rngb";
+				reg = <0x021b4000 0x4000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_DUMMY>;
+			};
+
 			ocotp: efuse@21bc000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1

