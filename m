Return-Path: <linux-crypto+bounces-7050-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDC989E51
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EC21F2136E
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA82189534;
	Mon, 30 Sep 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="NzdjGdRv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CB188587
	for <linux-crypto@vger.kernel.org>; Mon, 30 Sep 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688689; cv=none; b=t8Ws8Gf3COAzEude6WqXeNp62/i2M/5rnsuHlBv14Wg1vF9BtslG0EQWdgL2Io0hSmdAlIWKcN6zcmPTUBdr3Es1nn5ozuoh4djxeeOeZuysiXR0euL4+8qPHYKnzS8ZpG7Mf7GX6xuNNnlmF3yrtnG0cboevk+An0nkL4USHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688689; c=relaxed/simple;
	bh=BtkixWbFBj6Yac3YttcDXhmj5cLqyJ/Rb2iv6L5DLxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6qFieoeUCA03HSGI8ViHbnzcVkYsFDNv1lbOzWCHpS4LFselIlOzKUXKYGzZ0S/EcCqb0i8LgUsFAsLCMJK9ypfmVtiHaI2EFLhqRCsHO7C1RhNcZGAmzKaIWdrqqtnnIWNqf2Mo/17G/9F/Aio32kZ9Vdw8bwsNG+BlJFD57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=NzdjGdRv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d606726cso2917049b3a.3
        for <linux-crypto@vger.kernel.org>; Mon, 30 Sep 2024 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1727688686; x=1728293486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T2O/wzUWAcc5bxOJMvDyfSbentxOqBo1MqzzmAVxzI=;
        b=NzdjGdRvIR+VVSlWe54hkSNDy/tWYEdXTCOfNBoVI9d89e+57DHX1cFzP33oE4TysG
         jO0vkJD820/TIJzApC1mSYvMLhslllfNUCd2iyV5JmlUiTmMj5hfi+lRubkcgi6C2Na+
         GfbwZ7I6v15bR48JEcsVyV5HUXOKQ2wWW/A7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688686; x=1728293486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T2O/wzUWAcc5bxOJMvDyfSbentxOqBo1MqzzmAVxzI=;
        b=Kr9ZbzBfihsQU1JcreA68qwRpf7PVF/N9/sYsVZGxBYKvztv6m8x+Q/0+0bkBFAvoI
         VJ0cW1DOfPycjMKdXaeMNz823FsNhFLnXNLTh5tNeIDIRUzBODlvilz+uiC9wp/5GlCp
         cOoSDXtXb0giOjQc/AWFCVy9KnIxC5ImKy+K118Uc5m6W5Zdh99+lqp01T04PcVlBXpU
         uOnzhbERN9cmfuckcaKEsiFhthjvp5cVUER5Kuwa3vcq7MuY36ZEmKzEkyXid/2mIzkR
         TmjlaJeiqzQFUxqD/Rkb9eNcHzx9NziNBa2EfRcq+MKAeeRbQU/wK+GEz+23BaOznE85
         R9iw==
X-Forwarded-Encrypted: i=1; AJvYcCVxmdv4NEaVbWYPxZzupC3kW3zB1nACIT510OudZh2zQMPXiNQ/+V/cJPM4v9uox7DLuUXl53mCVGX8M/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qMWt910ympBAcz1miIp7oyA8Pxx6Je1wtBB69m7KffSqKg/w
	K4txVqgEXBuQ3cdFcWNEL661Q1VLczHNVHDuB6zL+nZZ3Lno9emtkRqL0ZtkqFw=
X-Google-Smtp-Source: AGHT+IEuKtxdNePtC/bs+3ojDjEuIz+NIWakFzqNLCe2omt1+OaUNpnnslK8x6KxXeCktR2DfYVPGQ==
X-Received: by 2002:a05:6a00:10c8:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-71b25f74f10mr16727754b3a.14.1727688686090;
        Mon, 30 Sep 2024 02:31:26 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26499743sm6037482b3a.18.2024.09.30.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:31:25 -0700 (PDT)
From: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
To: devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	robh@kernel.org
Cc: Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	bhoomikak@vayavyalabs.com,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	Shweta Raikar <shwetar@vayavyalabs.com>
Subject: [PATCH v9 3/7] Add SPAcc ahash support
Date: Mon, 30 Sep 2024 15:00:50 +0530
Message-Id: <20240930093054.215809-4-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930093054.215809-1-pavitrakumarm@vayavyalabs.com>
References: <20240930093054.215809-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ahash support to SPAcc driver.
Below are the hash algos supported:
- cmac(aes)
- xcbc(aes)
- cmac(sm4)
- xcbc(sm4)
- hmac(md5)
- md5
- hmac(sha1)
- sha1
- sha224
- sha256
- sha384
- sha512
- hmac(sha224)
- hmac(sha256)
- hmac(sha384)
- hmac(sha512)
- sha3-224
- sha3-256
- sha3-384
- sha3-512
- hmac(sm3)
- sm3
- michael_mic

Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Co-developed-by: Shweta Raikar <shwetar@vayavyalabs.com>
Signed-off-by: Shweta Raikar <shwetar@vayavyalabs.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
---
 drivers/crypto/dwc-spacc/spacc_ahash.c | 916 +++++++++++++++++++++++++
 1 file changed, 916 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c

diff --git a/drivers/crypto/dwc-spacc/spacc_ahash.c b/drivers/crypto/dwc-spacc/spacc_ahash.c
new file mode 100644
index 000000000000..34eadec0c9d2
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
@@ -0,0 +1,916 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dmapool.h>
+#include <crypto/sm3.h>
+#include <crypto/sha1.h>
+#include <crypto/sm4.h>
+#include <crypto/sha2.h>
+#include <crypto/sha3.h>
+#include <crypto/md5.h>
+#include <crypto/aes.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+
+#include "spacc_device.h"
+#include "spacc_core.h"
+
+#define PPP_BUF_SIZE 128
+
+struct sdesc {
+	struct shash_desc shash;
+	char ctx[];
+};
+
+static struct dma_pool *spacc_hash_pool;
+static LIST_HEAD(spacc_hash_alg_list);
+static LIST_HEAD(head_sglbuf);
+static DEFINE_MUTEX(spacc_hash_alg_mutex);
+
+static struct mode_tab possible_hashes[] = {
+	{ .keylen[0] = 16, MODE_TAB_HASH("cmac(aes)", MAC_CMAC, 16,  16),
+	.sw_fb = true },
+	{ .keylen[0] = 48 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(aes)",
+	MAC_XCBC, 16,  16), .sw_fb = true },
+
+	{ MODE_TAB_HASH("cmac(sm4)",	MAC_SM4_CMAC, 16, 16), .sw_fb = true },
+	{ .keylen[0] = 32 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(sm4)",
+	MAC_SM4_XCBC, 16, 16), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(md5)",	HMAC_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("md5",		HASH_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(sha1)",	HMAC_SHA1, SHA1_DIGEST_SIZE,
+	SHA1_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha1",		HASH_SHA1, SHA1_DIGEST_SIZE,
+	SHA1_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("sha224",	HASH_SHA224, SHA224_DIGEST_SIZE,
+	SHA224_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha256",	HASH_SHA256, SHA256_DIGEST_SIZE,
+	SHA256_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha384",	HASH_SHA384, SHA384_DIGEST_SIZE,
+	SHA384_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha512",	HASH_SHA512, SHA512_DIGEST_SIZE,
+	SHA512_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(sha512)",	HMAC_SHA512, SHA512_DIGEST_SIZE,
+	SHA512_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("hmac(sha224)",	HMAC_SHA224, SHA224_DIGEST_SIZE,
+	SHA224_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("hmac(sha256)",	HMAC_SHA256, SHA256_DIGEST_SIZE,
+	SHA256_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("hmac(sha384)",	HMAC_SHA384, SHA384_DIGEST_SIZE,
+	SHA384_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("sha3-224", HASH_SHA3_224, SHA3_224_DIGEST_SIZE,
+	SHA3_224_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha3-256", HASH_SHA3_256, SHA3_256_DIGEST_SIZE,
+	SHA3_256_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha3-384", HASH_SHA3_384, SHA3_384_DIGEST_SIZE,
+	SHA3_384_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha3-512", HASH_SHA3_512, SHA3_512_DIGEST_SIZE,
+	SHA3_512_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(sm3)", HMAC_SM3, SM3_DIGEST_SIZE,
+	SM3_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sm3", HASH_SM3, SM3_DIGEST_SIZE,
+	SM3_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("michael_mic", MAC_MICHAEL, 8, 8), .sw_fb = true },
+};
+
+static void spacc_hash_cleanup_dma_dst(struct spacc_crypto_ctx *tctx,
+				       struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	pdu_ddt_free(&ctx->dst);
+}
+
+static void spacc_hash_cleanup_dma_src(struct spacc_crypto_ctx *tctx,
+				       struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	if (tctx->tmp_sgl && tctx->tmp_sgl[0].length != 0) {
+		dma_unmap_sg(tctx->dev, tctx->tmp_sgl, ctx->src_nents,
+				DMA_TO_DEVICE);
+		kfree(tctx->tmp_sgl_buff);
+		tctx->tmp_sgl_buff = NULL;
+		tctx->tmp_sgl[0].length = 0;
+	} else {
+		dma_unmap_sg(tctx->dev, req->src, ctx->src_nents,
+				DMA_TO_DEVICE);
+	}
+
+	pdu_ddt_free(&ctx->src);
+}
+
+static void spacc_hash_cleanup_dma(struct device *dev,
+				   struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	dma_unmap_sg(dev, req->src, ctx->src_nents, DMA_TO_DEVICE);
+	pdu_ddt_free(&ctx->src);
+
+	dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
+	pdu_ddt_free(&ctx->dst);
+}
+
+static void spacc_init_calg(struct crypto_alg *calg,
+			    const struct mode_tab *mode)
+{
+
+	strscpy(calg->cra_name, mode->name);
+	calg->cra_name[sizeof(mode->name) - 1] = '\0';
+
+	strscpy(calg->cra_driver_name, "spacc-");
+	strcat(calg->cra_driver_name, mode->name);
+	calg->cra_driver_name[sizeof(calg->cra_driver_name) - 1] = '\0';
+
+	calg->cra_blocksize = mode->blocklen;
+}
+
+static int spacc_ctx_clone_handle(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	if (tctx->handle < 0)
+		return -ENXIO;
+
+	ctx->acb.new_handle = spacc_clone_handle(&priv->spacc, tctx->handle,
+			&ctx->acb);
+
+	if (ctx->acb.new_handle < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		return -ENOMEM;
+	}
+
+	ctx->acb.tctx  = tctx;
+	ctx->acb.ctx   = ctx;
+	ctx->acb.req   = req;
+	ctx->acb.spacc = &priv->spacc;
+
+	return 0;
+}
+
+static int spacc_hash_init_dma(struct device *dev, struct ahash_request *req,
+			       int final)
+{
+	int rc = -1;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	gfp_t mflags = GFP_ATOMIC;
+
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP)
+		mflags = GFP_KERNEL;
+
+	ctx->digest_buf = dma_pool_alloc(spacc_hash_pool, mflags,
+					 &ctx->digest_dma);
+
+	if (!ctx->digest_buf)
+		return -ENOMEM;
+
+	rc = pdu_ddt_init(&ctx->dst, 1 | 0x80000000);
+	if (rc < 0) {
+		pr_err("ERR: PDU DDT init error\n");
+		rc = -EIO;
+		goto err_free_digest;
+	}
+
+	pdu_ddt_add(&ctx->dst, ctx->digest_dma, SPACC_MAX_DIGEST_SIZE);
+
+	if (ctx->total_nents > 0 && ctx->single_shot) {
+		/* single shot */
+		spacc_ctx_clone_handle(req);
+
+		if (req->nbytes) {
+			rc = spacc_sg_to_ddt(dev, req->src, req->nbytes,
+					     &ctx->src, DMA_TO_DEVICE);
+		} else {
+			memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
+			sg_set_buf(&(tctx->tmp_sgl[0]), tctx->tmp_buffer,
+								PPP_BUF_SIZE);
+			rc = spacc_sg_to_ddt(dev, &(tctx->tmp_sgl[0]),
+					     tctx->tmp_sgl[0].length,
+					     &ctx->src, DMA_TO_DEVICE);
+
+		}
+	} else if (ctx->total_nents == 0 && req->nbytes == 0) {
+		spacc_ctx_clone_handle(req);
+
+		/* zero length case */
+		memset(tctx->tmp_buffer, '\0', PPP_BUF_SIZE);
+		sg_set_buf(&(tctx->tmp_sgl[0]), tctx->tmp_buffer, PPP_BUF_SIZE);
+		rc = spacc_sg_to_ddt(dev, &(tctx->tmp_sgl[0]),
+					    tctx->tmp_sgl[0].length,
+					    &ctx->src, DMA_TO_DEVICE);
+
+	}
+
+	if (rc < 0)
+		goto err_free_dst;
+
+	ctx->src_nents = rc;
+
+	return rc;
+
+err_free_dst:
+	pdu_ddt_free(&ctx->dst);
+err_free_digest:
+	dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
+
+	return rc;
+}
+
+static void spacc_free_mems(struct spacc_crypto_reqctx *ctx,
+			    struct spacc_crypto_ctx *tctx,
+			    struct ahash_request *req)
+{
+	spacc_hash_cleanup_dma_dst(tctx, req);
+	spacc_hash_cleanup_dma_src(tctx, req);
+
+	if (ctx->single_shot) {
+		kfree(tctx->tmp_sgl);
+		tctx->tmp_sgl = NULL;
+
+		ctx->single_shot = 0;
+		if (ctx->total_nents)
+			ctx->total_nents = 0;
+	}
+}
+
+static void spacc_digest_cb(void *spacc, void *tfm)
+{
+	struct ahash_cb_data *cb = tfm;
+	int err = -1;
+	int dig_sz;
+
+	dig_sz = crypto_ahash_digestsize(crypto_ahash_reqtfm(cb->req));
+
+	if (cb->ctx->single_shot)
+		memcpy(cb->req->result, cb->ctx->digest_buf, dig_sz);
+	else
+		memcpy(cb->tctx->digest_ctx_buf, cb->ctx->digest_buf, dig_sz);
+
+	err = cb->spacc->job[cb->new_handle].job_err;
+
+	dma_pool_free(spacc_hash_pool, cb->ctx->digest_buf,
+			cb->ctx->digest_dma);
+	spacc_free_mems(cb->ctx, cb->tctx, cb->req);
+	spacc_close(cb->spacc, cb->new_handle);
+
+	if (cb->req->base.complete)
+		ahash_request_complete(cb->req, err);
+}
+
+static int do_shash(unsigned char *name, unsigned char *result,
+		    const u8 *data1, unsigned int data1_len,
+		    const u8 *data2, unsigned int data2_len,
+		    const u8 *key, unsigned int key_len)
+{
+	int rc;
+	unsigned int size;
+	struct crypto_shash *hash;
+	struct sdesc *sdesc;
+
+	hash = crypto_alloc_shash(name, 0, 0);
+	if (IS_ERR(hash)) {
+		rc = PTR_ERR(hash);
+		pr_err("ERR: Crypto %s allocation error %d\n", name, rc);
+		return rc;
+	}
+
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(hash);
+	sdesc = kmalloc(size, GFP_KERNEL);
+	if (!sdesc) {
+		rc = -ENOMEM;
+		goto do_shash_err;
+	}
+	sdesc->shash.tfm = hash;
+
+	if (key_len > 0) {
+		rc = crypto_shash_setkey(hash, key, key_len);
+		if (rc) {
+			pr_err("ERR: Could not setkey %s shash\n", name);
+			goto do_shash_err;
+		}
+	}
+
+	rc = crypto_shash_init(&sdesc->shash);
+	if (rc) {
+		pr_err("ERR: Could not init %s shash\n", name);
+		goto do_shash_err;
+	}
+
+	rc = crypto_shash_update(&sdesc->shash, data1, data1_len);
+	if (rc) {
+		pr_err("ERR: Could not update1\n");
+		goto do_shash_err;
+	}
+
+	if (data2 && data2_len) {
+		rc = crypto_shash_update(&sdesc->shash, data2, data2_len);
+		if (rc) {
+			pr_err("ERR: Could not update2\n");
+			goto do_shash_err;
+		}
+	}
+
+	rc = crypto_shash_final(&sdesc->shash, result);
+	if (rc)
+		pr_err("ERR: Could not generate %s hash\n", name);
+
+do_shash_err:
+	crypto_free_shash(hash);
+	kfree(sdesc);
+
+	return rc;
+}
+
+static int spacc_hash_setkey(struct crypto_ahash *tfm, const u8 *key,
+			     unsigned int keylen)
+{
+	int rc;
+	const struct spacc_alg *salg = spacc_tfm_ahash(&tfm->base);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+	unsigned int digest_size, block_size;
+	char hash_alg[CRYPTO_MAX_ALG_NAME];
+
+	block_size = crypto_tfm_alg_blocksize(&tfm->base);
+	digest_size = crypto_ahash_digestsize(tfm);
+
+	/*
+	 * We will not use the hardware in case of HMACs
+	 * This was meant for hashes but it works for cmac/xcbc since we
+	 * only intend to support 128-bit keys...
+	 */
+	if (keylen > block_size && salg->mode->id != CRYPTO_MODE_MAC_CMAC) {
+		pr_debug("Exceeds keylen: %u\n", keylen);
+		pr_debug("Req. keylen hashing %s\n",
+					salg->calg->cra_name);
+
+		memset(hash_alg, 0x00, CRYPTO_MAX_ALG_NAME);
+		switch (salg->mode->id)	{
+		case CRYPTO_MODE_HMAC_SHA224:
+			rc = do_shash("sha224", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA256:
+			rc = do_shash("sha256", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA384:
+			rc = do_shash("sha384", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA512:
+			rc = do_shash("sha512", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_MD5:
+			rc = do_shash("md5", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		case CRYPTO_MODE_HMAC_SHA1:
+			rc = do_shash("sha1", tctx->ipad, key, keylen,
+				      NULL, 0, NULL, 0);
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		if (rc < 0) {
+			pr_err("ERR: %d computing shash for %s\n",
+								rc, hash_alg);
+			return -EIO;
+		}
+
+		keylen = digest_size;
+		pr_debug("updated keylen: %u\n", keylen);
+
+		tctx->ctx_valid = false;
+
+		if (salg->mode->sw_fb) {
+			rc = crypto_ahash_setkey(tctx->fb.hash,
+						 tctx->ipad, keylen);
+			if (rc < 0)
+				return rc;
+		}
+	} else {
+		memcpy(tctx->ipad, key, keylen);
+		tctx->ctx_valid = false;
+
+		if (salg->mode->sw_fb) {
+			rc = crypto_ahash_setkey(tctx->fb.hash, key, keylen);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	/* close handle since key size may have changed */
+	if (tctx->handle >= 0) {
+		spacc_close(&priv->spacc, tctx->handle);
+		put_device(tctx->dev);
+		tctx->handle = -1;
+		tctx->dev = NULL;
+	}
+
+	priv = NULL;
+	priv = dev_get_drvdata(salg->dev[0]);
+	tctx->dev = get_device(salg->dev[0]);
+	if (spacc_isenabled(&priv->spacc, salg->mode->id, keylen)) {
+		tctx->handle = spacc_open(&priv->spacc,
+					  CRYPTO_MODE_NULL,
+					  salg->mode->id, -1,
+					  0, spacc_digest_cb, tfm);
+
+	} else
+		pr_debug("  Keylen: %d not enabled for algo: %d",
+						keylen, salg->mode->id);
+
+	if (tctx->handle < 0) {
+		pr_err("ERR1: Failed to open SPAcc context\n");
+		put_device(salg->dev[0]);
+		return -EIO;
+	}
+
+	rc = spacc_set_operation(&priv->spacc, tctx->handle, OP_ENCRYPT,
+				 ICV_HASH, IP_ICV_OFFSET, 0, 0, 0);
+	if (rc < 0) {
+		spacc_close(&priv->spacc, tctx->handle);
+		tctx->handle = -1;
+		put_device(tctx->dev);
+		return -EIO;
+	}
+
+	if (salg->mode->id == CRYPTO_MODE_MAC_XCBC ||
+	    salg->mode->id == CRYPTO_MODE_MAC_SM4_XCBC) {
+		rc = spacc_compute_xcbc_key(&priv->spacc, salg->mode->id,
+					    tctx->handle, tctx->ipad,
+					    keylen, tctx->ipad);
+		if (rc < 0) {
+			dev_warn(tctx->dev,
+				 "Failed to compute XCBC key: %d\n", rc);
+			return -EIO;
+		}
+		rc = spacc_write_context(&priv->spacc, tctx->handle,
+					 SPACC_HASH_OPERATION, tctx->ipad,
+					 32 + keylen, NULL, 0);
+	} else {
+		rc = spacc_write_context(&priv->spacc, tctx->handle,
+					 SPACC_HASH_OPERATION, tctx->ipad,
+					 keylen, NULL, 0);
+	}
+
+	memset(tctx->ipad, 0, sizeof(tctx->ipad));
+	if (rc < 0) {
+		pr_err("ERR: Failed to write SPAcc context\n");
+		/* Non-fatal; we continue with the software fallback. */
+		return 0;
+	}
+
+	tctx->ctx_valid = true;
+
+	return 0;
+}
+
+static int spacc_set_statesize(struct spacc_alg *salg)
+{
+	unsigned int statesize = 0;
+
+	switch (salg->mode->id) {
+	case CRYPTO_MODE_HMAC_SHA1:
+	case CRYPTO_MODE_HASH_SHA1:
+		statesize = sizeof(struct sha1_state);
+		break;
+	case CRYPTO_MODE_MAC_CMAC:
+	case CRYPTO_MODE_MAC_XCBC:
+		statesize = sizeof(struct crypto_aes_ctx);
+		break;
+	case CRYPTO_MODE_MAC_SM4_CMAC:
+	case CRYPTO_MODE_MAC_SM4_XCBC:
+		statesize = sizeof(struct sm4_ctx);
+		break;
+	case CRYPTO_MODE_HMAC_MD5:
+	case CRYPTO_MODE_HASH_MD5:
+		statesize = sizeof(struct md5_state);
+		break;
+	case CRYPTO_MODE_HASH_SHA224:
+	case CRYPTO_MODE_HASH_SHA256:
+	case CRYPTO_MODE_HMAC_SHA224:
+	case CRYPTO_MODE_HMAC_SHA256:
+		statesize = sizeof(struct sha256_state);
+		break;
+	case CRYPTO_MODE_HMAC_SHA512:
+	case CRYPTO_MODE_HASH_SHA512:
+		statesize = sizeof(struct sha512_state);
+		break;
+	case CRYPTO_MODE_HMAC_SHA384:
+	case CRYPTO_MODE_HASH_SHA384:
+		statesize = sizeof(struct spacc_crypto_reqctx);
+		break;
+	case CRYPTO_MODE_HASH_SHA3_224:
+	case CRYPTO_MODE_HASH_SHA3_256:
+	case CRYPTO_MODE_HASH_SHA3_384:
+	case CRYPTO_MODE_HASH_SHA3_512:
+		statesize = sizeof(struct sha3_state);
+		break;
+	case CRYPTO_MODE_HMAC_SM3:
+	case CRYPTO_MODE_MAC_MICHAEL:
+		statesize = sizeof(struct spacc_crypto_reqctx);
+		break;
+	default:
+		break;
+	}
+
+	return statesize;
+}
+
+static int spacc_hash_cra_init(struct crypto_tfm *tfm)
+{
+	const struct spacc_alg *salg = spacc_tfm_ahash(tfm);
+	struct spacc_crypto_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct spacc_priv *priv = NULL;
+
+	tctx->handle    = -1;
+	tctx->ctx_valid = false;
+	tctx->dev       = get_device(salg->dev[0]);
+
+	if (salg->mode->sw_fb) {
+		tctx->fb.hash = crypto_alloc_ahash(salg->calg->cra_name, 0,
+						   CRYPTO_ALG_NEED_FALLBACK);
+
+		if (IS_ERR(tctx->fb.hash)) {
+			if (tctx->handle >= 0)
+				spacc_close(&priv->spacc, tctx->handle);
+			put_device(tctx->dev);
+			return PTR_ERR(tctx->fb.hash);
+		}
+
+		crypto_ahash_set_statesize(__crypto_ahash_cast(tfm),
+				crypto_ahash_statesize(tctx->fb.hash));
+
+		crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+					 sizeof(struct spacc_crypto_reqctx) +
+					 crypto_ahash_reqsize(tctx->fb.hash));
+
+	} else {
+		crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+					 sizeof(struct spacc_crypto_reqctx));
+	}
+
+	return 0;
+}
+
+static void spacc_hash_cra_exit(struct crypto_tfm *tfm)
+{
+	struct spacc_crypto_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	crypto_free_ahash(tctx->fb.hash);
+
+	if (tctx->handle >= 0)
+		spacc_close(&priv->spacc, tctx->handle);
+
+	put_device(tctx->dev);
+}
+
+static int spacc_hash_init(struct ahash_request *req)
+{
+	int rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ctx->digest_buf = NULL;
+	ctx->single_shot = 0;
+	ctx->total_nents = 0;
+	tctx->tmp_sgl = NULL;
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	rc = crypto_ahash_init(&ctx->fb.hash_req);
+
+	return rc;
+}
+
+static int spacc_hash_update(struct ahash_request *req)
+{
+	int rc;
+	int nbytes = req->nbytes;
+
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	if (!nbytes)
+		return 0;
+
+	pr_debug("%s Using SW fallback\n", __func__);
+
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.nbytes = req->nbytes;
+	ctx->fb.hash_req.src = req->src;
+
+	rc = crypto_ahash_update(&ctx->fb.hash_req);
+	return rc;
+}
+
+static int spacc_hash_final(struct ahash_request *req)
+{
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	int rc;
+
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.result = req->result;
+
+	rc = crypto_ahash_final(&ctx->fb.hash_req);
+	return rc;
+}
+
+static int spacc_hash_digest(struct ahash_request *req)
+{
+	int ret, final = 0;
+	int rc;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+	const struct spacc_alg *salg = spacc_tfm_ahash(&reqtfm->base);
+
+
+	/* direct single shot digest call */
+	ctx->single_shot = 1;
+	ctx->total_nents = sg_nents(req->src);
+
+	/* alloc tmp_sgl */
+	tctx->tmp_sgl = kmalloc(sizeof(*(tctx->tmp_sgl)) * 2, GFP_KERNEL);
+
+	if (!tctx->tmp_sgl)
+		return -ENOMEM;
+
+	sg_init_table(tctx->tmp_sgl, 2);
+	tctx->tmp_sgl[0].length = 0;
+
+
+	if (tctx->handle < 0 || !tctx->ctx_valid) {
+		priv = NULL;
+		pr_debug("%s: open SPAcc context\n", __func__);
+
+		priv = dev_get_drvdata(salg->dev[0]);
+		tctx->dev = get_device(salg->dev[0]);
+		ret = spacc_isenabled(&priv->spacc, salg->mode->id, 0);
+		if (ret)
+			tctx->handle = spacc_open(&priv->spacc,
+					CRYPTO_MODE_NULL,
+					salg->mode->id, -1, 0,
+					spacc_digest_cb,
+					reqtfm);
+
+		if (tctx->handle < 0) {
+			put_device(salg->dev[0]);
+			pr_debug("ERR2: Failed to open SPAcc context\n");
+			goto fallback;
+		}
+
+		rc = spacc_set_operation(&priv->spacc, tctx->handle,
+					 OP_ENCRYPT, ICV_HASH, IP_ICV_OFFSET,
+					 0, 0, 0);
+		if (rc < 0) {
+			spacc_close(&priv->spacc, tctx->handle);
+			pr_debug("ERR3: Failed to open SPAcc context\n");
+			tctx->handle = -1;
+			put_device(tctx->dev);
+			goto fallback;
+		}
+		tctx->ctx_valid = true;
+	}
+
+	rc = spacc_hash_init_dma(tctx->dev, req, final);
+	if (rc < 0)
+		goto fallback;
+
+	if (rc == 0)
+		return 0;
+
+	rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->acb.new_handle,
+			&ctx->src, &ctx->dst, req->nbytes,
+			0, req->nbytes, 0, 0, 0);
+
+	if (rc < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		spacc_close(&priv->spacc, ctx->acb.new_handle);
+
+		if (rc != -EBUSY) {
+			pr_debug("Failed to enqueue job, ERR: %d\n", rc);
+			return rc;
+		}
+
+		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+			return -EBUSY;
+
+		goto fallback;
+	}
+
+	return -EINPROGRESS;
+
+fallback:
+	/* Start from scratch as init is not called before digest */
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+						CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	ctx->fb.hash_req.nbytes = req->nbytes;
+	ctx->fb.hash_req.src = req->src;
+	ctx->fb.hash_req.result = req->result;
+
+	return crypto_ahash_digest(&ctx->fb.hash_req);
+}
+
+static int spacc_hash_finup(struct ahash_request *req)
+{
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	int rc;
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+						CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.nbytes     = req->nbytes;
+	ctx->fb.hash_req.src        = req->src;
+	ctx->fb.hash_req.result     = req->result;
+
+	rc = crypto_ahash_finup(&ctx->fb.hash_req);
+	return rc;
+}
+
+static int spacc_hash_import(struct ahash_request *req, const void *in)
+{
+	int rc;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rc = crypto_ahash_import(&ctx->fb.hash_req, in);
+	return rc;
+}
+
+static int spacc_hash_export(struct ahash_request *req, void *out)
+{
+	int rc;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+						CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rc = crypto_ahash_export(&ctx->fb.hash_req, out);
+	return rc;
+}
+
+static const struct ahash_alg spacc_hash_template = {
+	.init   = spacc_hash_init,
+	.update = spacc_hash_update,
+	.final  = spacc_hash_final,
+	.finup  = spacc_hash_finup,
+	.digest = spacc_hash_digest,
+	.setkey = spacc_hash_setkey,
+	.export = spacc_hash_export,
+	.import = spacc_hash_import,
+
+	.halg.base = {
+		.cra_priority	= 300,
+		.cra_module	= THIS_MODULE,
+		.cra_init	= spacc_hash_cra_init,
+		.cra_exit	= spacc_hash_cra_exit,
+		.cra_ctxsize	= sizeof(struct spacc_crypto_ctx),
+		.cra_flags	= CRYPTO_ALG_TYPE_AHASH    |
+				  CRYPTO_ALG_ASYNC	   |
+				  CRYPTO_ALG_NEED_FALLBACK |
+				  CRYPTO_ALG_OPTIONAL_KEY
+	},
+};
+
+static int spacc_register_hash(struct spacc_alg *salg)
+{
+	int rc;
+
+	salg->calg = &salg->alg.hash.halg.base;
+	salg->alg.hash = spacc_hash_template;
+
+	spacc_init_calg(salg->calg, salg->mode);
+	salg->alg.hash.halg.digestsize = salg->mode->hashlen;
+	salg->alg.hash.halg.statesize = spacc_set_statesize(salg);
+
+	rc = crypto_register_ahash(&salg->alg.hash);
+	if (rc < 0)
+		return rc;
+
+	mutex_lock(&spacc_hash_alg_mutex);
+	list_add(&salg->list, &spacc_hash_alg_list);
+	mutex_unlock(&spacc_hash_alg_mutex);
+
+	return 0;
+}
+
+
+int probe_hashes(struct platform_device *spacc_pdev)
+{
+	int rc;
+	unsigned int i;
+	int registered = 0;
+	struct spacc_alg *salg;
+	struct spacc_priv *priv = dev_get_drvdata(&spacc_pdev->dev);
+
+	spacc_hash_pool = dma_pool_create("spacc-digest", &spacc_pdev->dev,
+					  SPACC_MAX_DIGEST_SIZE,
+					  SPACC_DMA_ALIGN, SPACC_DMA_BOUNDARY);
+
+	if (!spacc_hash_pool)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(possible_hashes); i++)
+		possible_hashes[i].valid = 0;
+
+	for (i = 0; i < ARRAY_SIZE(possible_hashes); i++) {
+		if (possible_hashes[i].valid == 0 &&
+		       spacc_isenabled(&priv->spacc,
+				       possible_hashes[i].id & 0xFF,
+				       possible_hashes[i].hashlen)) {
+
+			salg = kmalloc(sizeof(*salg), GFP_KERNEL);
+			if (!salg)
+				return -ENOMEM;
+
+			salg->mode = &possible_hashes[i];
+
+			/* Copy all dev's over to the salg */
+			salg->dev[0] = &spacc_pdev->dev;
+			salg->dev[1] = NULL;
+
+			rc = spacc_register_hash(salg);
+			if (rc < 0) {
+				kfree(salg);
+				continue;
+			}
+			pr_debug("registered %s\n",
+				 possible_hashes[i].name);
+
+			registered++;
+			possible_hashes[i].valid = 1;
+		}
+	}
+
+	return registered;
+}
+
+int spacc_unregister_hash_algs(void)
+{
+	struct spacc_alg *salg, *tmp;
+
+	mutex_lock(&spacc_hash_alg_mutex);
+	list_for_each_entry_safe(salg, tmp, &spacc_hash_alg_list, list) {
+		crypto_unregister_alg(salg->calg);
+		list_del(&salg->list);
+		kfree(salg);
+	}
+	mutex_unlock(&spacc_hash_alg_mutex);
+
+	dma_pool_destroy(spacc_hash_pool);
+
+	return 0;
+}
-- 
2.25.1


