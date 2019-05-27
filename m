Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0925A2B7D3
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE0OvY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:51:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38419 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfE0OvY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:51:24 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 44678200006;
        Mon, 27 May 2019 14:51:20 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 03/14] crypto: inside-secure - fix coding style for a condition
Date:   Mon, 27 May 2019 16:50:55 +0200
Message-Id: <20190527145106.8693-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This cosmetic patch fixes a cosmetic issue with if brackets.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 86c699c14f84..263bd4ce73c5 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -720,11 +720,10 @@ static inline void safexcel_handle_result_descriptor(struct safexcel_crypto_priv
 	}
 
 acknowledge:
-	if (i) {
+	if (i)
 		writel(EIP197_xDR_PROC_xD_PKT(i) |
 		       EIP197_xDR_PROC_xD_COUNT(tot_descs * priv->config.rd_offset),
 		       EIP197_HIA_RDR(priv, ring) + EIP197_HIA_xDR_PROC_COUNT);
-	}
 
 	/* If the number of requests overflowed the counter, try to proceed more
 	 * requests.
-- 
2.21.0

