Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2932E14A6F0
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jan 2020 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgA0PIy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jan 2020 10:08:54 -0500
Received: from foss.arm.com ([217.140.110.172]:45864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgA0PIy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jan 2020 10:08:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CADD31B;
        Mon, 27 Jan 2020 07:08:53 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316B33F67D;
        Mon, 27 Jan 2020 07:08:52 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3] crypto: ccree - protect against short scatterlists
Date:   Mon, 27 Jan 2020 17:08:21 +0200
Message-Id: <20200127150822.12126-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Deal gracefully with the event of being handed a scatterlist
which is shorter than expected.

This mitigates a crash in some cases due to
attempt to map empty (but not NULL) scatterlists with none
zero lengths.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 65 +++++++++++++---------------
 drivers/crypto/ccree/cc_buffer_mgr.h |  1 +
 2 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index a72586eccd81..c5d58becb66d 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -87,6 +87,11 @@ static unsigned int cc_get_sgl_nents(struct device *dev,
 {
 	unsigned int nents = 0;
 
+	*lbytes = 0;
+
+	if (!sg_list || !sg_list->length)
+		goto out;
+
 	while (nbytes && sg_list) {
 		nents++;
 		/* get the number of bytes in the last entry */
@@ -95,6 +100,8 @@ static unsigned int cc_get_sgl_nents(struct device *dev,
 				nbytes : sg_list->length;
 		sg_list = sg_next(sg_list);
 	}
+
+out:
 	dev_dbg(dev, "nents %d last bytes %d\n", nents, *lbytes);
 	return nents;
 }
@@ -290,37 +297,25 @@ static int cc_map_sg(struct device *dev, struct scatterlist *sg,
 		     unsigned int nbytes, int direction, u32 *nents,
 		     u32 max_sg_nents, u32 *lbytes, u32 *mapped_nents)
 {
-	if (sg_is_last(sg)) {
-		/* One entry only case -set to DLLI */
-		if (dma_map_sg(dev, sg, 1, direction) != 1) {
-			dev_err(dev, "dma_map_sg() single buffer failed\n");
-			return -ENOMEM;
-		}
-		dev_dbg(dev, "Mapped sg: dma_address=%pad page=%p addr=%pK offset=%u length=%u\n",
-			&sg_dma_address(sg), sg_page(sg), sg_virt(sg),
-			sg->offset, sg->length);
-		*lbytes = nbytes;
-		*nents = 1;
-		*mapped_nents = 1;
-	} else {  /*sg_is_last*/
-		*nents = cc_get_sgl_nents(dev, sg, nbytes, lbytes);
-		if (*nents > max_sg_nents) {
-			*nents = 0;
-			dev_err(dev, "Too many fragments. current %d max %d\n",
-				*nents, max_sg_nents);
-			return -ENOMEM;
-		}
-		/* In case of mmu the number of mapped nents might
-		 * be changed from the original sgl nents
-		 */
-		*mapped_nents = dma_map_sg(dev, sg, *nents, direction);
-		if (*mapped_nents == 0) {
-			*nents = 0;
-			dev_err(dev, "dma_map_sg() sg buffer failed\n");
-			return -ENOMEM;
-		}
+	int ret = 0;
+
+	*nents = cc_get_sgl_nents(dev, sg, nbytes, lbytes);
+	if (*nents > max_sg_nents) {
+		*nents = 0;
+		dev_err(dev, "Too many fragments. current %d max %d\n",
+			*nents, max_sg_nents);
+		return -ENOMEM;
 	}
 
+	ret = dma_map_sg(dev, sg, *nents, direction);
+	if (dma_mapping_error(dev, ret)) {
+		*nents = 0;
+		dev_err(dev, "dma_map_sg() sg buffer failed %d\n", ret);
+		return -ENOMEM;
+	}
+
+	*mapped_nents = ret;
+
 	return 0;
 }
 
@@ -555,11 +550,11 @@ void cc_unmap_aead_request(struct device *dev, struct aead_request *req)
 		sg_virt(req->src), areq_ctx->src.nents, areq_ctx->assoc.nents,
 		areq_ctx->assoclen, req->cryptlen);
 
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_BIDIRECTIONAL);
+	dma_unmap_sg(dev, req->src, areq_ctx->src.mapped_nents, DMA_BIDIRECTIONAL);
 	if (req->src != req->dst) {
 		dev_dbg(dev, "Unmapping dst sgl: req->dst=%pK\n",
 			sg_virt(req->dst));
-		dma_unmap_sg(dev, req->dst, sg_nents(req->dst),
+		dma_unmap_sg(dev, req->dst, areq_ctx->dst.mapped_nents,
 			     DMA_BIDIRECTIONAL);
 	}
 	if (drvdata->coherent &&
@@ -881,7 +876,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 					    &src_last_bytes);
 	sg_index = areq_ctx->src_sgl->length;
 	//check where the data starts
-	while (sg_index <= size_to_skip) {
+	while (src_mapped_nents && (sg_index <= size_to_skip)) {
 		src_mapped_nents--;
 		offset -= areq_ctx->src_sgl->length;
 		sgl = sg_next(areq_ctx->src_sgl);
@@ -908,7 +903,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 			size_for_map += crypto_aead_ivsize(tfm);
 
 		rc = cc_map_sg(dev, req->dst, size_for_map, DMA_BIDIRECTIONAL,
-			       &areq_ctx->dst.nents,
+			       &areq_ctx->dst.mapped_nents,
 			       LLI_MAX_NUM_OF_DATA_ENTRIES, &dst_last_bytes,
 			       &dst_mapped_nents);
 		if (rc)
@@ -921,7 +916,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 	offset = size_to_skip;
 
 	//check where the data starts
-	while (sg_index <= size_to_skip) {
+	while (dst_mapped_nents && sg_index <= size_to_skip) {
 		dst_mapped_nents--;
 		offset -= areq_ctx->dst_sgl->length;
 		sgl = sg_next(areq_ctx->dst_sgl);
@@ -1123,7 +1118,7 @@ int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 	if (is_gcm4543)
 		size_to_map += crypto_aead_ivsize(tfm);
 	rc = cc_map_sg(dev, req->src, size_to_map, DMA_BIDIRECTIONAL,
-		       &areq_ctx->src.nents,
+		       &areq_ctx->src.mapped_nents,
 		       (LLI_MAX_NUM_OF_ASSOC_DATA_ENTRIES +
 			LLI_MAX_NUM_OF_DATA_ENTRIES),
 		       &dummy, &mapped_nents);
diff --git a/drivers/crypto/ccree/cc_buffer_mgr.h b/drivers/crypto/ccree/cc_buffer_mgr.h
index af434872c6ff..827b6cb1236e 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.h
+++ b/drivers/crypto/ccree/cc_buffer_mgr.h
@@ -25,6 +25,7 @@ enum cc_sg_cpy_direct {
 
 struct cc_mlli {
 	cc_sram_addr_t sram_addr;
+	unsigned int mapped_nents;
 	unsigned int nents; //sg nents
 	unsigned int mlli_nents; //mlli nents might be different than the above
 };
-- 
2.23.0

