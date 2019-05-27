Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8B2B7EC
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfE0OwR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:52:17 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49131 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfE0Ovg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:51:36 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2C8B724000B;
        Mon, 27 May 2019 14:51:32 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 08/14] crypto: inside-secure - unify cache reset
Date:   Mon, 27 May 2019 16:51:00 +0200
Message-Id: <20190527145106.8693-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch unify the way the cache related data is zeroed when the cache
buffer is DMA unmapped. It should not change the driver behaviour, but
improves the code safety and readability.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index 58ce480690eb..a79a73bb3969 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -183,6 +183,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int rin
 		dma_unmap_single(priv->dev, sreq->cache_dma, sreq->cache_sz,
 				 DMA_TO_DEVICE);
 		sreq->cache_dma = 0;
+		sreq->cache_sz = 0;
 	}
 
 	if (sreq->finish)
@@ -344,6 +345,7 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 	if (req->cache_dma) {
 		dma_unmap_single(priv->dev, req->cache_dma, req->cache_sz,
 				 DMA_TO_DEVICE);
+		req->cache_dma = 0;
 		req->cache_sz = 0;
 	}
 
-- 
2.21.0

