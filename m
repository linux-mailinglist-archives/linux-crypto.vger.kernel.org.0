Return-Path: <linux-crypto+bounces-386-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331647FDD5E
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 17:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AFD1F20FDF
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543613B780
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05CEC9;
	Wed, 29 Nov 2023 07:21:51 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 29 Nov
 2023 18:21:50 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 29 Nov
 2023 18:21:49 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Antoine Tenart <atenart@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: safexcel - Add error handling for dma_map_sg() calls
Date: Wed, 29 Nov 2023 07:21:45 -0800
Message-ID: <20231129152145.7767-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Macro dma_map_sg() may return 0 on error. This patch enables
checks in case of the macro failure and ensures unmapping of
previously mapped buffers with dma_unmap_sg().

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 49186a7d9e46 ("crypto: inside_secure - Avoid dma map if size is zero")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

 drivers/crypto/inside-secure/safexcel_cipher.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 272c28b5a088..ca660f31c15f 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -742,9 +742,9 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 				max(totlen_src, totlen_dst));
 			return -EINVAL;
 		}
-		if (sreq->nr_src > 0)
-			dma_map_sg(priv->dev, src, sreq->nr_src,
-				   DMA_BIDIRECTIONAL);
+		if ((sreq->nr_src > 0) &&
+		    (!dma_map_sg(priv->dev, src, sreq->nr_src, DMA_BIDIRECTIONAL)))
+			return -ENOMEM;
 	} else {
 		if (unlikely(totlen_src && (sreq->nr_src <= 0))) {
 			dev_err(priv->dev, "Source buffer not large enough (need %d bytes)!",
@@ -752,8 +752,9 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 			return -EINVAL;
 		}
 
-		if (sreq->nr_src > 0)
-			dma_map_sg(priv->dev, src, sreq->nr_src, DMA_TO_DEVICE);
+		if ((sreq->nr_src > 0) &&
+		    (!dma_map_sg(priv->dev, src, sreq->nr_src, DMA_TO_DEVICE)))
+			return -ENOMEM;
 
 		if (unlikely(totlen_dst && (sreq->nr_dst <= 0))) {
 			dev_err(priv->dev, "Dest buffer not large enough (need %d bytes)!",
@@ -762,9 +763,11 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 			goto unmap;
 		}
 
-		if (sreq->nr_dst > 0)
-			dma_map_sg(priv->dev, dst, sreq->nr_dst,
-				   DMA_FROM_DEVICE);
+		if ((sreq->nr_dst > 0) &&
+		    (!dma_map_sg(priv->dev, dst, sreq->nr_dst, DMA_FROM_DEVICE))) {
+			ret = -ENOMEM;
+			goto unmap;
+		}
 	}
 
 	memcpy(ctx->base.ctxr->data, ctx->key, ctx->key_len);

