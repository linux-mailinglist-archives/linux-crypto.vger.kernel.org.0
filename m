Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC31AA455
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2020 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636041AbgDONXv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Apr 2020 09:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408866AbgDOLey (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Apr 2020 07:34:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B44820737;
        Wed, 15 Apr 2020 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950493;
        bh=pTRJi42QLtD8XK1UmP7p1s0Jn8MlwflehEJVP2yAQXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcJRPp521puyS88Av9tFWxfBDXv8GEQmQdeH9gpAQU0MlNEzy+pIDojrJxn/Y6sUP
         Y37qgQtVqAFrB0qdUntkgRwPAwbAEP27oL0PL15G5j7y/YZrRRZrqt0N4xGGIUHce3
         m5+VO6PzqV/lb4hJp3pSygDE+B955WY68OSw9HDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 006/129] crypto: qce - use cryptlen when adding extra sgl
Date:   Wed, 15 Apr 2020 07:32:41 -0400
Message-Id: <20200415113445.11881-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eneas U de Queiroz <cotequeiroz@gmail.com>

[ Upstream commit d6364b8128439a8c0e381f80c38667de9f15eef8 ]

The qce crypto driver appends an extra entry to the dst sgl, to maintain
private state information.

When the gcm driver sends requests to the ctr skcipher, it passes the
authentication tag after the actual crypto payload, but it must not be
touched.

Commit 1336c2221bee ("crypto: qce - save a sg table slot for result
buf") limited the destination sgl to avoid overwriting the
authentication tag but it assumed the tag would be in a separate sgl
entry.

This is not always the case, so it is better to limit the length of the
destination buffer to req->cryptlen before appending the result buf.

Signed-off-by: Eneas U de Queiroz <cotequeiroz@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qce/dma.c      | 11 ++++++-----
 drivers/crypto/qce/dma.h      |  2 +-
 drivers/crypto/qce/skcipher.c |  5 +++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 7da893dc00e73..46db5bf366b44 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -48,9 +48,10 @@ void qce_dma_release(struct qce_dma_data *dma)
 
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *new_sgl,
-		int max_ents)
+		unsigned int max_len)
 {
 	struct scatterlist *sg = sgt->sgl, *sg_last = NULL;
+	unsigned int new_len;
 
 	while (sg) {
 		if (!sg_page(sg))
@@ -61,13 +62,13 @@ qce_sgtable_add(struct sg_table *sgt, struct scatterlist *new_sgl,
 	if (!sg)
 		return ERR_PTR(-EINVAL);
 
-	while (new_sgl && sg && max_ents) {
-		sg_set_page(sg, sg_page(new_sgl), new_sgl->length,
-			    new_sgl->offset);
+	while (new_sgl && sg && max_len) {
+		new_len = new_sgl->length > max_len ? max_len : new_sgl->length;
+		sg_set_page(sg, sg_page(new_sgl), new_len, new_sgl->offset);
 		sg_last = sg;
 		sg = sg_next(sg);
 		new_sgl = sg_next(new_sgl);
-		max_ents--;
+		max_len -= new_len;
 	}
 
 	return sg_last;
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index ed25a0d9829e5..7864021693608 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -43,6 +43,6 @@ void qce_dma_issue_pending(struct qce_dma_data *dma);
 int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
-		int max_ents);
+		unsigned int max_len);
 
 #endif /* _DMA_H_ */
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 4217b745f1242..63ae75809cb70 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -97,13 +97,14 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 
 	sg_init_one(&rctx->result_sg, qce->dma.result_buf, QCE_RESULT_BUF_SZ);
 
-	sg = qce_sgtable_add(&rctx->dst_tbl, req->dst, rctx->dst_nents - 1);
+	sg = qce_sgtable_add(&rctx->dst_tbl, req->dst, req->cryptlen);
 	if (IS_ERR(sg)) {
 		ret = PTR_ERR(sg);
 		goto error_free;
 	}
 
-	sg = qce_sgtable_add(&rctx->dst_tbl, &rctx->result_sg, 1);
+	sg = qce_sgtable_add(&rctx->dst_tbl, &rctx->result_sg,
+			     QCE_RESULT_BUF_SZ);
 	if (IS_ERR(sg)) {
 		ret = PTR_ERR(sg);
 		goto error_free;
-- 
2.20.1

