Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1046F401420
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Sep 2021 03:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhIFBcY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Sep 2021 21:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351717AbhIFBa6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Sep 2021 21:30:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1102961215;
        Mon,  6 Sep 2021 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891458;
        bh=6KCB01tXX1O/mIj2NNFhOZlGXoZvY3bLeowUgxuiZFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPQ7AhP1UsmMzGcwcSmhAyN3UEqodOC+n9rqjFrZDy6siYKrL4+EjJeFd/5O2UniU
         RDtIBL8GUm3i/rHkhlOeJOVotuwIJ/phsgtFWD5u+CiNekbz1xRX29edL07skP+lMm
         GOt5nv0cBUNtp7etBBnvgNRWUypAOOvTqrLSxzD6D8zCCPgk2IdWIL4lU/eHHLTAyA
         YLBw9aduxL6uH0ZpNECkyBa6Ezur8RFZ5x4krxDD2zV7pe6Ag8+1ClNub14JHFyQS4
         eI7A28L8pVsKfVe+H5rVbyNjTlj+inUTfU2SohIy2655rb5+tDTHJwgjnxusHJsgD2
         3Ys1EGIIvu7EQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Richard Weinberger <richard@nod.at>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 02/14] crypto: mxs-dcp - Check for DMA mapping errors
Date:   Sun,  5 Sep 2021 21:24:03 -0400
Message-Id: <20210906012415.931147-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012415.931147-1-sashal@kernel.org>
References: <20210906012415.931147-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

[ Upstream commit df6313d707e575a679ada3313358289af24454c0 ]

After calling dma_map_single(), we must also call dma_mapping_error().
This fixes the following warning when compiling with CONFIG_DMA_API_DEBUG:

[  311.241478] WARNING: CPU: 0 PID: 428 at kernel/dma/debug.c:1027 check_unmap+0x79c/0x96c
[  311.249547] DMA-API: mxs-dcp 2280000.crypto: device driver failed to check map error[device address=0x00000000860cb080] [size=32 bytes] [mapped as single]

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/mxs-dcp.c | 45 +++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 34839b539207..1bab5b99ebbd 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -167,15 +167,19 @@ static struct dcp *global_sdcp;
 
 static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
 {
+	int dma_err;
 	struct dcp *sdcp = global_sdcp;
 	const int chan = actx->chan;
 	uint32_t stat;
 	unsigned long ret;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
-
 	dma_addr_t desc_phys = dma_map_single(sdcp->dev, desc, sizeof(*desc),
 					      DMA_TO_DEVICE);
 
+	dma_err = dma_mapping_error(sdcp->dev, desc_phys);
+	if (dma_err)
+		return dma_err;
+
 	reinit_completion(&sdcp->completion[chan]);
 
 	/* Clear status register. */
@@ -213,18 +217,29 @@ static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
 static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 			   struct ablkcipher_request *req, int init)
 {
+	dma_addr_t key_phys, src_phys, dst_phys;
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
 	struct dcp_aes_req_ctx *rctx = ablkcipher_request_ctx(req);
 	int ret;
 
-	dma_addr_t key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
-					     2 * AES_KEYSIZE_128,
-					     DMA_TO_DEVICE);
-	dma_addr_t src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
-					     DCP_BUF_SZ, DMA_TO_DEVICE);
-	dma_addr_t dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
-					     DCP_BUF_SZ, DMA_FROM_DEVICE);
+	key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
+				  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
+	ret = dma_mapping_error(sdcp->dev, key_phys);
+	if (ret)
+		return ret;
+
+	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
+				  DCP_BUF_SZ, DMA_TO_DEVICE);
+	ret = dma_mapping_error(sdcp->dev, src_phys);
+	if (ret)
+		goto err_src;
+
+	dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
+				  DCP_BUF_SZ, DMA_FROM_DEVICE);
+	ret = dma_mapping_error(sdcp->dev, dst_phys);
+	if (ret)
+		goto err_dst;
 
 	if (actx->fill % AES_BLOCK_SIZE) {
 		dev_err(sdcp->dev, "Invalid block size!\n");
@@ -262,10 +277,12 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	ret = mxs_dcp_start_dma(actx);
 
 aes_done_run:
+	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
+err_dst:
+	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
+err_src:
 	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
 			 DMA_TO_DEVICE);
-	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
-	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
 
 	return ret;
 }
@@ -565,6 +582,10 @@ static int mxs_dcp_run_sha(struct ahash_request *req)
 	dma_addr_t buf_phys = dma_map_single(sdcp->dev, sdcp->coh->sha_in_buf,
 					     DCP_BUF_SZ, DMA_TO_DEVICE);
 
+	ret = dma_mapping_error(sdcp->dev, buf_phys);
+	if (ret)
+		return ret;
+
 	/* Fill in the DMA descriptor. */
 	desc->control0 = MXS_DCP_CONTROL0_DECR_SEMAPHORE |
 		    MXS_DCP_CONTROL0_INTERRUPT |
@@ -597,6 +618,10 @@ static int mxs_dcp_run_sha(struct ahash_request *req)
 	if (rctx->fini) {
 		digest_phys = dma_map_single(sdcp->dev, sdcp->coh->sha_out_buf,
 					     DCP_SHA_PAY_SZ, DMA_FROM_DEVICE);
+		ret = dma_mapping_error(sdcp->dev, digest_phys);
+		if (ret)
+			goto done_run;
+
 		desc->control0 |= MXS_DCP_CONTROL0_HASH_TERM;
 		desc->payload = digest_phys;
 	}
-- 
2.30.2

