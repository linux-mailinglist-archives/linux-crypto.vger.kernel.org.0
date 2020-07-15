Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66A2210E4
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Jul 2020 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOP1S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Jul 2020 11:27:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54262 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgGOP1R (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Jul 2020 11:27:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 947F9200334;
        Wed, 15 Jul 2020 17:27:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 847A9200319;
        Wed, 15 Jul 2020 17:27:14 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C6229205C8;
        Wed, 15 Jul 2020 17:27:13 +0200 (CEST)
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
Subject: [PATCH v4 0/5] hwrng: add support for i.MX6 rngb
Date:   Wed, 15 Jul 2020 18:25:59 +0300
Message-Id: <20200715152604.10407-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add support for RNGB found in some i.MX6 SoCs (6SL, 6SLL, 6ULL, 6ULZ),
based on RNGC driver (drivers/char/hw_random/imx-rngc.c).

This driver claims support also for RNGB (besides RNGC),
and is currently used only by i.MX25.

Note:

Several NXP SoC from QorIQ family (P1010, P1023, P4080, P3041, P5020)
also have a RNGB, however it's part of the CAAM
(Cryptograhic Accelerator and Assurance Module) crypto accelerator.
In this case, RNGB is managed in the caam driver
(drivers/crypto/caam/), since it's tightly related to
the caam "job ring" interface, not to mention CAAM internally relying on
RNGB as source of randomness.

On the other hand, the i.MX6 SoCs with RNGB have a DCP
(Data Co-Processor) crypto accelerator and this block and RNGB
are independent.

Changelog:
v4
-remove unneeded compatible strings from the driver
v3
-mention in the DT binding the compatibility with "fsl,imx25-rngb"
-collected Reviewed-by
v2
-update rngb DT binding with compatible strings for i.MX6 SoCs

Horia Geantă (5):
  dt-bindings: rng: add RNGB compatibles for i.MX6 SoCs
  ARM: dts: imx6sl: fix rng node
  ARM: dts: imx6sll: add rng
  ARM: dts: imx6ull: add rng
  hwrng: imx-rngc: enable driver for i.MX6

 Documentation/devicetree/bindings/rng/imx-rng.txt | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi                     | 2 ++
 arch/arm/boot/dts/imx6sll.dtsi                    | 7 +++++++
 arch/arm/boot/dts/imx6ull.dtsi                    | 7 +++++++
 drivers/char/hw_random/Kconfig                    | 2 +-
 5 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.17.1

