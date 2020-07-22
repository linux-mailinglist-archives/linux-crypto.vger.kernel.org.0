Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D011229811
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGVMPe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 08:15:34 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51376 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbgGVMPM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 155F52008FC;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 093FB200915;
        Wed, 22 Jul 2020 14:15:11 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C634202AC;
        Wed, 22 Jul 2020 14:15:10 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/7] crypto: caam - remove deadcode on 32-bit platforms
Date:   Wed, 22 Jul 2020 15:14:52 +0300
Message-Id: <20200722121458.8478-2-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722121458.8478-1-horia.geanta@nxp.com>
References: <20200722121458.8478-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

When building on a platform with a 32bit DMA address, taking the
upper 32 bits makes no sense.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/regs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 0f810bc13b2b..af61f3a2c0d4 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -173,9 +173,14 @@ static inline u64 rd_reg64(void __iomem *reg)
 
 static inline u64 cpu_to_caam_dma64(dma_addr_t value)
 {
-	if (caam_imx)
-		return (((u64)cpu_to_caam32(lower_32_bits(value)) << 32) |
-			 (u64)cpu_to_caam32(upper_32_bits(value)));
+	if (caam_imx) {
+		u64 ret_val = (u64)cpu_to_caam32(lower_32_bits(value)) << 32;
+
+		if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+			ret_val |= (u64)cpu_to_caam32(upper_32_bits(value));
+
+		return ret_val;
+	}
 
 	return cpu_to_caam64(value);
 }
-- 
2.17.1

