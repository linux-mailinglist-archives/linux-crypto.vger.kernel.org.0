Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88315325E
	for <lists+linux-crypto@lfdr.de>; Wed,  5 Feb 2020 15:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgBEOAR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 5 Feb 2020 09:00:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46745 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgBEOAR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 5 Feb 2020 09:00:17 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1izLDt-0004pI-U4; Wed, 05 Feb 2020 15:00:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1izLDq-0001oe-7L; Wed, 05 Feb 2020 15:00:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: imx-rngc: improve dependencies
Date:   Wed,  5 Feb 2020 15:00:02 +0100
Message-Id: <20200205140002.26273-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The imx-rngc driver binds to devices that are compatible to
"fsl,imx25-rngb". Grepping through the device tree sources suggests this
only exists on i.MX25. So restrict dependencies to configs that have
this SoC enabled, but allow compile testing. For the latter additional
dependencies for clk and readl/writel are necessary.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/hw_random/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 8486c29d8324..17fe954fccde 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -244,7 +244,8 @@ config HW_RANDOM_MXC_RNGA
 
 config HW_RANDOM_IMX_RNGC
 	tristate "Freescale i.MX RNGC Random Number Generator"
-	depends on ARCH_MXC
+	depends on HAS_IOMEM && HAVE_CLK
+	depends on SOC_IMX25 || COMPILE_TEST
 	default HW_RANDOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
-- 
2.24.0

