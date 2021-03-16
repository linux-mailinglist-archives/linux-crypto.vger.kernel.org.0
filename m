Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC833CB3A
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Mar 2021 03:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhCPB7x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Mar 2021 21:59:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13617 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhCPB7v (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Mar 2021 21:59:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DzxJK4szsz17Lk2;
        Tue, 16 Mar 2021 09:57:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 09:59:35 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <clabbe.montjoie@gmail.com>, <clabbe@baylibre.com>,
        <gcherian@marvell.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH v2 1/4] crypto: amlogic - Fix the parameter of dma_unmap_sg()
Date:   Tue, 16 Mar 2021 09:55:23 +0800
Message-ID: <1615859726-57062-2-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1615859726-57062-1-git-send-email-chenxiang66@hisilicon.com>
References: <1615859726-57062-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

For function dma_unmap_sg(), the <nents> parameter should be number of
elements in the scatterlist prior to the mapping, not after the mapping.
So fix this usage.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 8b5e073..c6865cbd 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -236,10 +236,10 @@ static int meson_cipher(struct skcipher_request *areq)
 	dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
 
 	if (areq->src == areq->dst) {
-		dma_unmap_sg(mc->dev, areq->src, nr_sgs, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
 	} else {
-		dma_unmap_sg(mc->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
-		dma_unmap_sg(mc->dev, areq->dst, nr_sgd, DMA_FROM_DEVICE);
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
 	}
 
 	if (areq->iv && ivsize > 0) {
-- 
2.8.1

