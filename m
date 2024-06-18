Return-Path: <linux-crypto+bounces-5017-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014990C2D6
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Jun 2024 06:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF276283926
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Jun 2024 04:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652819B3C0;
	Tue, 18 Jun 2024 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="bJqLWaxI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEA481A3
	for <linux-crypto@vger.kernel.org>; Tue, 18 Jun 2024 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718684897; cv=none; b=cB5X/O9gMlFIvXwS6AFOaLkFt6xLxDPCXJ4w/6NbdQUKT+YnudZVBijMMaXSqc6M8V9ErxHOrp9gdSHZz3s+zna/o/LXk+1DI6zV9/q0+LlVbWPXbVw0BUJOuEe0CQy6FyvhcuM1l0SkZppeQMsPmGkcIzb6zeJeassLbsCYplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718684897; c=relaxed/simple;
	bh=pTna6K1HSzOlKdlZAFTZPI4RiydYiTbybAZMo4UZJOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2mbnJqCTEXIsPJuQp09RYuYiEM1modF3y2W9/xhQkLJQsP0rWQDmhIqlbZNMpF2nDuyJndfxQ+ZVBvhHDzDUwGx12yKwC9SllXbTW3Ag4f1mvfEm97dLzS2pgb7JHlziWw9sPtXbT0z9gpQGqIcq6ceDFQRIEufAqx0NsYvr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=bJqLWaxI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705d9f4cd7bso2845409b3a.1
        for <linux-crypto@vger.kernel.org>; Mon, 17 Jun 2024 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1718684895; x=1719289695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEoflNdgtlqOD4YS71XpoYK4gbVEk7nG2Vf9hiMMu1w=;
        b=bJqLWaxIdvc3hxnyu53CT7Q1AkE3+2/r9CwECRjwX1w/pOJ775qG8DwKh/Mx2AuoRv
         mJY4oj6kWOJHmpiZqAu3HvIUf7GGS2XViUuUf6f+GfGhSrilHsBGK9y2JwC4+OXw5ygj
         pgcHGgblVjMqnWCzASLNnwdorbnn9krzyKQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718684895; x=1719289695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEoflNdgtlqOD4YS71XpoYK4gbVEk7nG2Vf9hiMMu1w=;
        b=GesIHVGFgxT/JftdjLhYbvSAFhDA/YhNs1cQHyRe1qgzltpvWD55hGZn4A+uCgpL9J
         jtTIbNHL1ImmXjrMhzXjWYhxtU80SZEH83yqSEaMTu0Cl8p9s8XpNgBAP3OXSoCxcpG/
         PYXb3+p2Ycp2iwjbMy73cXQtcTXZ7WWRp3sflfZDo8SxDjrNQYh9/2P7oYTKA2sW4oYI
         fj6PP82VO9SPCii0H25QhNr2UAJBgAEV0+d5wl36n9DBgpzlo0Kll5bjFGzMGOvxYUbq
         aGjqddkBNTiHf+nsTaKZRBgYJJF1ayj7vUP8hM9kGXlnZCDASB15QwTUJO9qA+aEn/Ma
         0OZA==
X-Forwarded-Encrypted: i=1; AJvYcCWr2j13m9dbf7FQBkX7MXXsgvGLK43FY2wWtBMo2/HkxWLv5713kb+5uUhY+5hxUbtuXOKTwQkO9SxyowYePFz8t6PTrwaP1HrbfHvv
X-Gm-Message-State: AOJu0YzKGootpcSueYzxMmFTqCF628bw+BknlIsf7db4NykObfI+1ZWc
	BPbP12jCcGGgQowhVRxJI/1wlPPkAdcGN63dTBnTYqITKy7B+dEEQ8yh/RjVF1o=
X-Google-Smtp-Source: AGHT+IGMOckYyJi429vyeacxa0pctU0CmW/1pfvc8bKgHBDJGRbAYFL4OcrKKG8uti8F+YQu+6yBiQ==
X-Received: by 2002:a05:6a20:918d:b0:1b5:d172:91fa with SMTP id adf61e73a8af0-1bae828eeeamr12783782637.48.1718684894629;
        Mon, 17 Jun 2024 21:28:14 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1770csm87912405ad.230.2024.06.17.21.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 21:28:14 -0700 (PDT)
From: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
To: herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	bhoomikak@vayavyalabs.com,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	shwetar <shwetar@vayavyalabs.com>
Subject: [PATCH v4 3/7] Add SPAcc ahash support
Date: Tue, 18 Jun 2024 09:57:46 +0530
Message-Id: <20240618042750.485720-4-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618042750.485720-1-pavitrakumarm@vayavyalabs.com>
References: <20240618042750.485720-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: shwetar <shwetar@vayavyalabs.com>
Signed-off-by: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
---
 drivers/crypto/dwc-spacc/spacc_ahash.c | 883 +++++++++++++++++++++++++
 1 file changed, 883 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c

diff --git a/drivers/crypto/dwc-spacc/spacc_ahash.c b/drivers/crypto/dwc-spacc/spacc_ahash.c
new file mode 100644
index 000000000000..b70d1d27c90a
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
@@ -0,0 +1,883 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dmapool.h>
+#include <crypto/sm3.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <crypto/sha3.h>
+#include <crypto/md5.h>
+#include <crypto/aes.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
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
+	if (tctx->ppp_sgl && tctx->ppp_sgl[0].length != 0) {
+		dma_unmap_sg(tctx->dev, tctx->ppp_sgl, ctx->src_nents, DMA_TO_DEVICE);
+		kfree(tctx->ppp_sgl_buff);
+		tctx->ppp_sgl_buff = NULL;
+		tctx->ppp_sgl[0].length = 0;
+	} else {
+		dma_unmap_sg(tctx->dev, req->src, ctx->src_nents, DMA_TO_DEVICE);
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
+			memset(tctx->ppp_buffer, '\0', PPP_BUF_SIZE);
+			sg_set_buf(&(tctx->ppp_sgl[0]), tctx->ppp_buffer,
+								PPP_BUF_SIZE);
+			rc = spacc_sg_to_ddt(dev, &(tctx->ppp_sgl[0]),
+					     tctx->ppp_sgl[0].length,
+					     &ctx->src, DMA_TO_DEVICE);
+
+		}
+	} else if (ctx->total_nents == 0 && req->nbytes == 0) {
+		spacc_ctx_clone_handle(req);
+
+		/* zero length case */
+		memset(tctx->ppp_buffer, '\0', PPP_BUF_SIZE);
+		sg_set_buf(&(tctx->ppp_sgl[0]), tctx->ppp_buffer, PPP_BUF_SIZE);
+		rc = spacc_sg_to_ddt(dev, &(tctx->ppp_sgl[0]),
+					    tctx->ppp_sgl[0].length,
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
+		if (tctx->ppp_sgl) {
+			kfree(NULL);
+			tctx->ppp_sgl = NULL;
+		}
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
+	dma_pool_free(spacc_hash_pool, cb->ctx->digest_buf, cb->ctx->digest_dma);
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
+		dev_dbg(salg->dev[0], "Exceeds keylen: %u\n", keylen);
+		dev_dbg(salg->dev[0], "Req. keylen hashing %s\n",
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
+		dev_dbg(salg->dev[0], "updated keylen: %u\n", keylen);
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
+		pr_err("ERR: Failed to open SPAcc context\n");
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
+	ctx->rem_nents = 0;
+	tctx->ppp_sgl = NULL;
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
+	//printk(KERN_ALERT "PK: UPDATE : req->nbytes:%d", req->nbytes);
+	ctx->rem_nents += sg_nents_for_len(req->src, req->nbytes);
+
+	if (!nbytes) {
+		//printk(KERN_ALERT "<- update: ret 0");
+		return 0;
+	}
+
+	dev_dbg(tctx->dev, "%s Using SW fallback\n", __func__);
+	//printk(KERN_ALERT "Update: FB: nbytes:%d", req->nbytes);
+
+
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.nbytes = req->nbytes;
+	ctx->fb.hash_req.src = req->src;
+
+	rc = crypto_ahash_update(&ctx->fb.hash_req);
+	//printk(KERN_ALERT "<- update: ret: %d", rc);
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
+	//printk(KERN_ALERT "PK: FINAL : req->nbytes:%d", req->nbytes);
+
+	//printk(KERN_ALERT "Final: FB: result computed");
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.result = req->result;
+
+	rc = crypto_ahash_final(&ctx->fb.hash_req);
+	//printk(KERN_ALERT "<- final: ret:%d", rc);
+	return rc;
+}
+
+static int spacc_hash_digest(struct ahash_request *req)
+{
+	int x, final = 0;
+	int rc;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+	const struct spacc_alg *salg = spacc_tfm_ahash(&reqtfm->base);
+
+	//printk(KERN_ALERT "===============================");
+	//printk(KERN_ALERT "PK: DIGEST : req->nbytes:%d", req->nbytes);
+
+	/* direct single shot digest call */
+	ctx->single_shot = 1;
+	ctx->total_nents = sg_nents(req->src);
+	//printk(KERN_ALERT "single shot: nents:%d", ctx->total_nents);
+
+	/* alloc ppp_sgl */
+	tctx->ppp_sgl = kmalloc(sizeof(*(tctx->ppp_sgl)) * 2, GFP_KERNEL);
+	//printk(KERN_ALERT "PK2: ALLOC ppp_sgl:%p", tctx->ppp_sgl);
+
+	if (!tctx->ppp_sgl)
+		return -ENOMEM;
+
+	sg_init_table(tctx->ppp_sgl, 2);
+	tctx->ppp_sgl[0].length = 0;
+
+
+	if (tctx->handle < 0 || !tctx->ctx_valid) {
+		priv = NULL;
+		dev_dbg(tctx->dev, "%s: open SPAcc context\n", __func__);
+
+		for (x = 0; x < ELP_CAPI_MAX_DEV && salg->dev[x]; x++) {
+			priv = dev_get_drvdata(salg->dev[x]);
+			tctx->dev = get_device(salg->dev[x]);
+			if (spacc_isenabled(&priv->spacc, salg->mode->id, 0)) {
+				tctx->handle = spacc_open(&priv->spacc,
+							  CRYPTO_MODE_NULL,
+							  salg->mode->id, -1, 0,
+							  spacc_digest_cb,
+							  reqtfm);
+			}
+
+			if (tctx->handle >= 0)
+				break;
+
+			put_device(salg->dev[x]);
+		}
+
+		if (tctx->handle < 0) {
+			dev_dbg(salg->dev[0], "Failed to open SPAcc context\n");
+			//PK: Dont need any hardware context, because we need to
+			//just fallback and compute. Context is for hardware.
+			goto fallback;
+		}
+
+		rc = spacc_set_operation(&priv->spacc, tctx->handle,
+					 OP_ENCRYPT, ICV_HASH, IP_ICV_OFFSET,
+					 0, 0, 0);
+		if (rc < 0) {
+			spacc_close(&priv->spacc, tctx->handle);
+			dev_dbg(salg->dev[0], "Failed to open SPAcc context\n");
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
+	//printk(KERN_ALERT "<- digest: ret: -EINPROGRESS");
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
+	//printk(KERN_ALERT "===============================");
+	//printk(KERN_ALERT "PK: FINUP : req->nbytes:%d", req->nbytes);
+	//printk(KERN_ALERT "Finup: FB: result computed: nbytes: %d", req->nbytes);
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags &
+						CRYPTO_TFM_REQ_MAY_SLEEP;
+	ctx->fb.hash_req.nbytes     = req->nbytes;
+	ctx->fb.hash_req.src        = req->src;
+	ctx->fb.hash_req.result     = req->result;
+
+	rc = crypto_ahash_finup(&ctx->fb.hash_req);
+	//printk(KERN_ALERT "finup: ret: %d", rc);
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
+	//printk(KERN_ALERT "spacc_import called");
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+	ctx->fb.hash_req.base.flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP;
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
+	//printk(KERN_ALERT "spacc_export called");
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
+	salg->alg.hash.halg.statesize = sizeof(struct spacc_crypto_reqctx);
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
+			dev_dbg(&spacc_pdev->dev, "registered %s\n",
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


