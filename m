Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7ABF2E6
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Sep 2019 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfIZM0f (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 26 Sep 2019 08:26:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38354 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfIZM0e (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 26 Sep 2019 08:26:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A1F020057A;
        Thu, 26 Sep 2019 14:26:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BA9C200565;
        Thu, 26 Sep 2019 14:26:32 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 06B77205E3;
        Thu, 26 Sep 2019 14:26:31 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2] crypto: caam - use mapped_{src,dst}_nents for descriptor
Date:   Thu, 26 Sep 2019 15:26:29 +0300
Message-Id: <1569500789-7443-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The mapped_{src,dst}_nents _returned_ from the dma_map_sg
call (which could be less than src/dst_nents) have to be
used to generate the job descriptors.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
Changes since v1:
- updated, with mapped_{src,dst}_nents, the set_rsa_pub_pdb, set_rsa_priv_f{1,2,3}_pdb functions.
---
 drivers/crypto/caam/caampkc.c | 72 +++++++++++++++++++++++--------------------
 drivers/crypto/caam/caampkc.h |  8 +++--
 2 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 83f96d4..6619c51 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -252,9 +252,9 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	int sg_flags = (flags == GFP_ATOMIC) ? SG_MITER_ATOMIC : 0;
-	int sgc;
 	int sec4_sg_index, sec4_sg_len = 0, sec4_sg_bytes;
 	int src_nents, dst_nents;
+	int mapped_src_nents, mapped_dst_nents;
 	unsigned int diff_size = 0;
 	int lzeros;
 
@@ -285,13 +285,27 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 				     req_ctx->fixup_src_len);
 	dst_nents = sg_nents_for_len(req->dst, req->dst_len);
 
-	if (!diff_size && src_nents == 1)
+	mapped_src_nents = dma_map_sg(dev, req_ctx->fixup_src, src_nents,
+				      DMA_TO_DEVICE);
+	if (unlikely(!mapped_src_nents)) {
+		dev_err(dev, "unable to map source\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	mapped_dst_nents = dma_map_sg(dev, req->dst, dst_nents,
+				      DMA_FROM_DEVICE);
+	if (unlikely(!mapped_dst_nents)) {
+		dev_err(dev, "unable to map destination\n");
+		goto src_fail;
+	}
+
+	if (!diff_size && mapped_src_nents == 1)
 		sec4_sg_len = 0; /* no need for an input hw s/g table */
 	else
-		sec4_sg_len = src_nents + !!diff_size;
+		sec4_sg_len = mapped_src_nents + !!diff_size;
 	sec4_sg_index = sec4_sg_len;
-	if (dst_nents > 1)
-		sec4_sg_len += pad_sg_nents(dst_nents);
+
+	if (mapped_dst_nents > 1)
+		sec4_sg_len += pad_sg_nents(mapped_dst_nents);
 	else
 		sec4_sg_len = pad_sg_nents(sec4_sg_len);
 
@@ -301,19 +315,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	edesc = kzalloc(sizeof(*edesc) + desclen + sec4_sg_bytes,
 			GFP_DMA | flags);
 	if (!edesc)
-		return ERR_PTR(-ENOMEM);
-
-	sgc = dma_map_sg(dev, req_ctx->fixup_src, src_nents, DMA_TO_DEVICE);
-	if (unlikely(!sgc)) {
-		dev_err(dev, "unable to map source\n");
-		goto src_fail;
-	}
-
-	sgc = dma_map_sg(dev, req->dst, dst_nents, DMA_FROM_DEVICE);
-	if (unlikely(!sgc)) {
-		dev_err(dev, "unable to map destination\n");
 		goto dst_fail;
-	}
 
 	edesc->sec4_sg = (void *)edesc + sizeof(*edesc) + desclen;
 	if (diff_size)
@@ -324,7 +326,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 		sg_to_sec4_sg_last(req_ctx->fixup_src, req_ctx->fixup_src_len,
 				   edesc->sec4_sg + !!diff_size, 0);
 
-	if (dst_nents > 1)
+	if (mapped_dst_nents > 1)
 		sg_to_sec4_sg_last(req->dst, req->dst_len,
 				   edesc->sec4_sg + sec4_sg_index, 0);
 
@@ -335,6 +337,9 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	if (!sec4_sg_bytes)
 		return edesc;
 
+	edesc->mapped_src_nents = mapped_src_nents;
+	edesc->mapped_dst_nents = mapped_dst_nents;
+
 	edesc->sec4_sg_dma = dma_map_single(dev, edesc->sec4_sg,
 					    sec4_sg_bytes, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, edesc->sec4_sg_dma)) {
@@ -351,11 +356,11 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	return edesc;
 
 sec4_sg_fail:
-	dma_unmap_sg(dev, req->dst, dst_nents, DMA_FROM_DEVICE);
+	kfree(edesc);
 dst_fail:
-	dma_unmap_sg(dev, req_ctx->fixup_src, src_nents, DMA_TO_DEVICE);
+	dma_unmap_sg(dev, req->dst, dst_nents, DMA_FROM_DEVICE);
 src_fail:
-	kfree(edesc);
+	dma_unmap_sg(dev, req_ctx->fixup_src, src_nents, DMA_TO_DEVICE);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -383,15 +388,15 @@ static int set_rsa_pub_pdb(struct akcipher_request *req,
 		return -ENOMEM;
 	}
 
-	if (edesc->src_nents > 1) {
+	if (edesc->mapped_src_nents > 1) {
 		pdb->sgf |= RSA_PDB_SGF_F;
 		pdb->f_dma = edesc->sec4_sg_dma;
-		sec4_sg_index += edesc->src_nents;
+		sec4_sg_index += edesc->mapped_src_nents;
 	} else {
 		pdb->f_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
-	if (edesc->dst_nents > 1) {
+	if (edesc->mapped_dst_nents > 1) {
 		pdb->sgf |= RSA_PDB_SGF_G;
 		pdb->g_dma = edesc->sec4_sg_dma +
 			     sec4_sg_index * sizeof(struct sec4_sg_entry);
@@ -428,17 +433,18 @@ static int set_rsa_priv_f1_pdb(struct akcipher_request *req,
 		return -ENOMEM;
 	}
 
-	if (edesc->src_nents > 1) {
+	if (edesc->mapped_src_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_G;
 		pdb->g_dma = edesc->sec4_sg_dma;
-		sec4_sg_index += edesc->src_nents;
+		sec4_sg_index += edesc->mapped_src_nents;
+
 	} else {
 		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 
 		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
-	if (edesc->dst_nents > 1) {
+	if (edesc->mapped_dst_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_F;
 		pdb->f_dma = edesc->sec4_sg_dma +
 			     sec4_sg_index * sizeof(struct sec4_sg_entry);
@@ -493,17 +499,17 @@ static int set_rsa_priv_f2_pdb(struct akcipher_request *req,
 		goto unmap_tmp1;
 	}
 
-	if (edesc->src_nents > 1) {
+	if (edesc->mapped_src_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_G;
 		pdb->g_dma = edesc->sec4_sg_dma;
-		sec4_sg_index += edesc->src_nents;
+		sec4_sg_index += edesc->mapped_src_nents;
 	} else {
 		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 
 		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
-	if (edesc->dst_nents > 1) {
+	if (edesc->mapped_dst_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_F;
 		pdb->f_dma = edesc->sec4_sg_dma +
 			     sec4_sg_index * sizeof(struct sec4_sg_entry);
@@ -582,17 +588,17 @@ static int set_rsa_priv_f3_pdb(struct akcipher_request *req,
 		goto unmap_tmp1;
 	}
 
-	if (edesc->src_nents > 1) {
+	if (edesc->mapped_src_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_G;
 		pdb->g_dma = edesc->sec4_sg_dma;
-		sec4_sg_index += edesc->src_nents;
+		sec4_sg_index += edesc->mapped_src_nents;
 	} else {
 		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 
 		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
-	if (edesc->dst_nents > 1) {
+	if (edesc->mapped_dst_nents > 1) {
 		pdb->sgf |= RSA_PRIV_PDB_SGF_F;
 		pdb->f_dma = edesc->sec4_sg_dma +
 			     sec4_sg_index * sizeof(struct sec4_sg_entry);
diff --git a/drivers/crypto/caam/caampkc.h b/drivers/crypto/caam/caampkc.h
index 2c488c9..c68fb4c 100644
--- a/drivers/crypto/caam/caampkc.h
+++ b/drivers/crypto/caam/caampkc.h
@@ -112,8 +112,10 @@ struct caam_rsa_req_ctx {
 
 /**
  * rsa_edesc - s/w-extended rsa descriptor
- * @src_nents     : number of segments in input scatterlist
- * @dst_nents     : number of segments in output scatterlist
+ * @src_nents     : number of segments in input s/w scatterlist
+ * @dst_nents     : number of segments in output s/w scatterlist
+ * @mapped_src_nents: number of segments in input h/w link table
+ * @mapped_dst_nents: number of segments in output h/w link table
  * @sec4_sg_bytes : length of h/w link table
  * @sec4_sg_dma   : dma address of h/w link table
  * @sec4_sg       : pointer to h/w link table
@@ -123,6 +125,8 @@ struct caam_rsa_req_ctx {
 struct rsa_edesc {
 	int src_nents;
 	int dst_nents;
+	int mapped_src_nents;
+	int mapped_dst_nents;
 	int sec4_sg_bytes;
 	dma_addr_t sec4_sg_dma;
 	struct sec4_sg_entry *sec4_sg;
-- 
2.1.0

