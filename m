Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1922EB4B
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jul 2020 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgG0Lgp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jul 2020 07:36:45 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:35396 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgG0Lgp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jul 2020 07:36:45 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4BFcNN3p71z9w11;
        Mon, 27 Jul 2020 13:03:00 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BFcLs4g65z2xDJ;
        Mon, 27 Jul 2020 13:01:41 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.121) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 27 Jul
 2020 12:59:47 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
CC:     Christian Eggers <ceggers@arri.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 3/3] hwrng: imx-rngc - setup default RNG quality
Date:   Mon, 27 Jul 2020 12:57:16 +0200
Message-ID: <20200727105718.26225-4-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727105718.26225-1-ceggers@arri.de>
References: <20200727105718.26225-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.121]
X-RMX-ID: 20200727-130145-4BFcLs4g65z2xDJ-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When hw_random device's quality is non-zero, it will automatically fill
the kernel's entropy pool at boot.  For this purpose, one conservative
quality value is being picked up as the default value.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/char/hw_random/imx-rngc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index f9c5ddd0276b..a62ff78bd7ea 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -285,6 +285,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	rngc->rng.init = imx_rngc_init;
 	rngc->rng.read = imx_rngc_read;
 	rngc->rng.cleanup = imx_rngc_cleanup;
+	rngc->rng.quality = 900;
 
 	rngc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, rngc);
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

