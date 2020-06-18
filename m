Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7E1FE63B
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2020 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgFRCb4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 17 Jun 2020 22:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgFRBPP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7462193E;
        Thu, 18 Jun 2020 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442914;
        bh=sMj1a01Ly63MbfBjhXj41uQ3VY8ywzgCtKQT9UCyDRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ+DSvam2KDSAydV05MN9hd3BkG8yGcXt+g4ZVmiTWOjbwIv0NtxyBw+umL8sUcy9
         2twTmrsTVoT9sKX4I967WMQjuOUjKOPAnJR2IB1tcj659BEShQVPwn1eIR+A2my/ma
         QlXN2XyZH9lo/rvWPIG1fk50PoKUiOB0otna2q4I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 332/388] crypto: omap-sham - add proper load balancing support for multicore
Date:   Wed, 17 Jun 2020 21:07:09 -0400
Message-Id: <20200618010805.600873-332-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit 281c377872ff5d15d80df25fc4df02d2676c7cde ]

The current implementation of the multiple accelerator core support for
OMAP SHA does not work properly. It always picks up the first probed
accelerator core if this is available, and rest of the book keeping also
gets confused if there are two cores available. Add proper load
balancing support for SHA, and also fix any bugs related to the
multicore support while doing it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-sham.c | 64 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 0cbf9c932a0f..a82a3596dca3 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -169,8 +169,6 @@ struct omap_sham_hmac_ctx {
 };
 
 struct omap_sham_ctx {
-	struct omap_sham_dev	*dd;
-
 	unsigned long		flags;
 
 	/* fallback stuff */
@@ -933,27 +931,35 @@ static int omap_sham_update_dma_stop(struct omap_sham_dev *dd)
 	return 0;
 }
 
+struct omap_sham_dev *omap_sham_find_dev(struct omap_sham_reqctx *ctx)
+{
+	struct omap_sham_dev *dd;
+
+	if (ctx->dd)
+		return ctx->dd;
+
+	spin_lock_bh(&sham.lock);
+	dd = list_first_entry(&sham.dev_list, struct omap_sham_dev, list);
+	list_move_tail(&dd->list, &sham.dev_list);
+	ctx->dd = dd;
+	spin_unlock_bh(&sham.lock);
+
+	return dd;
+}
+
 static int omap_sham_init(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct omap_sham_ctx *tctx = crypto_ahash_ctx(tfm);
 	struct omap_sham_reqctx *ctx = ahash_request_ctx(req);
-	struct omap_sham_dev *dd = NULL, *tmp;
+	struct omap_sham_dev *dd;
 	int bs = 0;
 
-	spin_lock_bh(&sham.lock);
-	if (!tctx->dd) {
-		list_for_each_entry(tmp, &sham.dev_list, list) {
-			dd = tmp;
-			break;
-		}
-		tctx->dd = dd;
-	} else {
-		dd = tctx->dd;
-	}
-	spin_unlock_bh(&sham.lock);
+	ctx->dd = NULL;
 
-	ctx->dd = dd;
+	dd = omap_sham_find_dev(ctx);
+	if (!dd)
+		return -ENODEV;
 
 	ctx->flags = 0;
 
@@ -1223,8 +1229,7 @@ static int omap_sham_handle_queue(struct omap_sham_dev *dd,
 static int omap_sham_enqueue(struct ahash_request *req, unsigned int op)
 {
 	struct omap_sham_reqctx *ctx = ahash_request_ctx(req);
-	struct omap_sham_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
-	struct omap_sham_dev *dd = tctx->dd;
+	struct omap_sham_dev *dd = ctx->dd;
 
 	ctx->op = op;
 
@@ -1234,7 +1239,7 @@ static int omap_sham_enqueue(struct ahash_request *req, unsigned int op)
 static int omap_sham_update(struct ahash_request *req)
 {
 	struct omap_sham_reqctx *ctx = ahash_request_ctx(req);
-	struct omap_sham_dev *dd = ctx->dd;
+	struct omap_sham_dev *dd = omap_sham_find_dev(ctx);
 
 	if (!req->nbytes)
 		return 0;
@@ -1338,21 +1343,8 @@ static int omap_sham_setkey(struct crypto_ahash *tfm, const u8 *key,
 	struct omap_sham_hmac_ctx *bctx = tctx->base;
 	int bs = crypto_shash_blocksize(bctx->shash);
 	int ds = crypto_shash_digestsize(bctx->shash);
-	struct omap_sham_dev *dd = NULL, *tmp;
 	int err, i;
 
-	spin_lock_bh(&sham.lock);
-	if (!tctx->dd) {
-		list_for_each_entry(tmp, &sham.dev_list, list) {
-			dd = tmp;
-			break;
-		}
-		tctx->dd = dd;
-	} else {
-		dd = tctx->dd;
-	}
-	spin_unlock_bh(&sham.lock);
-
 	err = crypto_shash_setkey(tctx->fallback, key, keylen);
 	if (err)
 		return err;
@@ -1370,7 +1362,7 @@ static int omap_sham_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 	memset(bctx->ipad + keylen, 0, bs - keylen);
 
-	if (!test_bit(FLAGS_AUTO_XOR, &dd->flags)) {
+	if (!test_bit(FLAGS_AUTO_XOR, &sham.flags)) {
 		memcpy(bctx->opad, bctx->ipad, bs);
 
 		for (i = 0; i < bs; i++) {
@@ -2174,6 +2166,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 	}
 
 	dd->flags |= dd->pdata->flags;
+	sham.flags |= dd->pdata->flags;
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DEFAULT_AUTOSUSPEND_DELAY);
@@ -2201,6 +2194,9 @@ static int omap_sham_probe(struct platform_device *pdev)
 	spin_unlock(&sham.lock);
 
 	for (i = 0; i < dd->pdata->algs_info_size; i++) {
+		if (dd->pdata->algs_info[i].registered)
+			break;
+
 		for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
 			struct ahash_alg *alg;
 
@@ -2252,9 +2248,11 @@ static int omap_sham_remove(struct platform_device *pdev)
 	list_del(&dd->list);
 	spin_unlock(&sham.lock);
 	for (i = dd->pdata->algs_info_size - 1; i >= 0; i--)
-		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--)
+		for (j = dd->pdata->algs_info[i].registered - 1; j >= 0; j--) {
 			crypto_unregister_ahash(
 					&dd->pdata->algs_info[i].algs_list[j]);
+			dd->pdata->algs_info[i].registered--;
+		}
 	tasklet_kill(&dd->done_task);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.25.1

