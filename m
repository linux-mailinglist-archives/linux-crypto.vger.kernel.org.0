Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AEB201D20
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jun 2020 23:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgFSVeW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Jun 2020 17:34:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34216 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFSVeW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Jun 2020 17:34:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 682E81A02C5;
        Fri, 19 Jun 2020 23:34:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 59E9E1A02BB;
        Fri, 19 Jun 2020 23:34:20 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B9BB204B6;
        Fri, 19 Jun 2020 23:34:19 +0200 (CEST)
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
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hwrng: add support for i.MX6 rngb
Date:   Sat, 20 Jun 2020 00:33:43 +0300
Message-Id: <20200619213347.27826-1-horia.geanta@nxp.com>
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

All the i.MX6 SoCs with RNGB have a DCP (Data Co-Processor)
crypto accelerator.

Several NXP SoC from QorIQ family (P1010, P1023, P4080, P3041, P5020)
also have a RNGB, however it's part of the CAAM
(Cryptograhic Accelerator and Assurance Module) crypto accelerator.
In this case, RNGB is managed in the caam driver
(drivers/crypto/caam/), since it's tightly related to
the caam "job ring" interface.

Horia Geantă (4):
  ARM: dts: imx6sl: fix rng node
  ARM: dts: imx6sll: add rng
  ARM: dts: imx6ull: add rng
  hwrng: imx-rngc: enable driver for i.MX6

 arch/arm/boot/dts/imx6sl.dtsi  | 2 ++
 arch/arm/boot/dts/imx6sll.dtsi | 7 +++++++
 arch/arm/boot/dts/imx6ull.dtsi | 7 +++++++
 drivers/char/hw_random/Kconfig | 2 +-
 4 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.17.1

