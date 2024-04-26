Return-Path: <linux-crypto+bounces-3858-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2838B2F71
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Apr 2024 06:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9051C21EC7
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Apr 2024 04:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D33A824A6;
	Fri, 26 Apr 2024 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="gQwyqZjL"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3418175E
	for <linux-crypto@vger.kernel.org>; Fri, 26 Apr 2024 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105604; cv=none; b=TIKQM3o72tRQjIaaiW9kg1lWXPqqBsusPnIYSSJbPlodyOnL8IlzDugH61lD0EfDSzhqa8awgh51rRH/fBCBtgwX284EXGwb6kMygTap3cvxHl3KvEMN48ncZtx3OyhAcERoj4tgWaQ4oDyHk4Csb8wddT4F9PF5iZokf3hLYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105604; c=relaxed/simple;
	bh=WE5kTPX114ngg8EENY4v4076oPEn4tdFkgiGE7ytV4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUCKGwHqZNjqFGPDcTWNqKZD7OMJ3VXoe/Fkwlgcy2/nnPel7AtJspJIOA5RlqrfDfp+h83Q49cpf3eLOCEJg3vM3k4qcUmR2NyurddWDAcLnL+/jZt7r6UnMN6D7F+ZQZgoG9pfysDgBahBvtoqVhZOtJFXOhKSkry51E8mBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=gQwyqZjL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso1521260b3a.0
        for <linux-crypto@vger.kernel.org>; Thu, 25 Apr 2024 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1714105602; x=1714710402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo1tFSBD/BZ+h6FehiiqMiHdX9sd33+adHOBdZoGSJw=;
        b=gQwyqZjLboThMoIX9alZJHDJ1LzvoVz+Ijg3jbk2g8jEE5AZMzajDh5wr2ja/TBgTd
         aOgWKhdjqwITI2vI9bw4kDhy8doiT26N9U/9F/l0+foD54b6HHUrZywSyCheKj+jgoHp
         GbLLL/EUuOi4YnjpGbGM8LLy10s51UBaEGXuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714105602; x=1714710402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fo1tFSBD/BZ+h6FehiiqMiHdX9sd33+adHOBdZoGSJw=;
        b=phg5patJrXouYqx2o7pxdBqTSMxmBtYUkpsmG4NJu91Mz3fBYzuptFGMyGaaGl1sGd
         RilCCfUHSnbvk07eO2W33edS/qXS4pZgSIf7uGDq5t5BkRIz/IGfEOcuJsJzGVXaf/mD
         BYIQMKMZqvxSVMR9SCPe9GR9XqsOQHYd3K0nLh3mpKntGKWmgReNOkuer7zWscmsoiqZ
         aGWlBqL4E8lTfVaAg0b+vijuhO32KPeQoQr7lVn0OrhQy2X0DJdxngW22KyGEnpa4Q6n
         HM2nCFdBSEr/q2jW5OWbKhIkW+kz/jlPcZYeG7sFN5kVfgYcmUEHJegVfzlQ0JEvOHVy
         IfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHwGi7ZkTkPQpuzux0rdWRbhb8V6iRZT03yZ2TKapRVV4hSMT9iw5NvN08GnkQBHQ+bRmPoH2IFfgnGNSRgn5D+qau2qtPhjftGRI/
X-Gm-Message-State: AOJu0YyQsGCB+FGhQV0L2D15ORPbFJHAmh6KuTgrGq6GcLzTGCs3YwLL
	Ij23fI5g2EfyheqisAaZRnBfq7J5qfZTovS6Q6uRlOE2CyrMEPtl2xmV0IqE3JA=
X-Google-Smtp-Source: AGHT+IEPLlFB+CpuYfXCF3BPUJrdP86grDCZCH1Ea06jgrku+dVc27TgX8cVMxNdIC82R7EjchErMw==
X-Received: by 2002:a05:6a20:2d06:b0:1ad:5325:d9b7 with SMTP id g6-20020a056a202d0600b001ad5325d9b7mr2140829pzl.52.1714105601545;
        Thu, 25 Apr 2024 21:26:41 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a5d8c00b002a474e2d7d8sm15500291pji.15.2024.04.25.21.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 21:26:41 -0700 (PDT)
From: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
To: herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	bhoomikak@vayavyalabs.com,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Subject: [PATCH v3 3/7] Add SPAcc ahash support
Date: Fri, 26 Apr 2024 09:55:40 +0530
Message-Id: <20240426042544.3545690-4-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426042544.3545690-1-pavitrakumarm@vayavyalabs.com>
References: <20240426042544.3545690-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/crypto/dwc-spacc/spacc_ahash.c | 1292 ++++++++++++++++++++++++
 1 file changed, 1292 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c

diff --git a/drivers/crypto/dwc-spacc/spacc_ahash.c b/drivers/crypto/dwc-spacc/spacc_ahash.c
new file mode 100644
index 0000000000000..df026f0c615ef
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/spacc_ahash.c
@@ -0,0 +1,1292 @@
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
+static int dma_map_count;
+
+static struct mode_tab possible_hashes[] = {
+	{ .keylen[0] = 16, MODE_TAB_HASH("cmac(aes)", MAC_CMAC, 16,  16),
+	.sw_fb = true },
+	{ .keylen[0] = 48 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(aes)",
+	MAC_XCBC, 16,  16), .sw_fb = true },
+
+	{ MODE_TAB_HASH("cmac(sm4)", MAC_SM4_CMAC, 16, 16), .sw_fb = true },
+	{ .keylen[0] = 32 | MODE_TAB_HASH_XCBC, MODE_TAB_HASH("xcbc(sm4)",
+	MAC_SM4_XCBC, 16, 16), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(md5)", HMAC_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("md5", HASH_MD5, MD5_DIGEST_SIZE,
+	MD5_HMAC_BLOCK_SIZE), .sw_fb = true },
+
+	{ MODE_TAB_HASH("hmac(sha1)", HMAC_SHA1, SHA1_DIGEST_SIZE,
+	SHA1_BLOCK_SIZE), .sw_fb = true },
+	{ MODE_TAB_HASH("sha1", HASH_SHA1, SHA1_DIGEST_SIZE,
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
+		dma_map_count--;
+		dma_unmap_sg(tctx->dev, tctx->ppp_sgl, ctx->src_nents, DMA_TO_DEVICE);
+		kfree(tctx->ppp_sgl_buff);
+		tctx->ppp_sgl_buff = NULL;
+		tctx->ppp_sgl[0].length = 0;
+	} else {
+		dma_map_count--;
+		dma_unmap_sg(tctx->dev, req->src, ctx->src_nents, DMA_TO_DEVICE);
+	}
+
+	pdu_ddt_free(&ctx->src);
+}
+
+//FIXME: Whos is using this?
+static void spacc_hash_cleanup_dma(struct device *dev,
+				   struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	dma_map_count--;
+	dma_unmap_sg(dev, req->src, ctx->src_nents, DMA_TO_DEVICE);
+	pdu_ddt_free(&ctx->src);
+
+	dma_pool_free(spacc_hash_pool, ctx->digest_buf, ctx->digest_dma);
+	pdu_ddt_free(&ctx->dst);
+}
+
+static void spacc_hash_cleanup_ppp(struct ahash_request *req)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	if (ctx->total_nents) {
+		ctx->total_nents = 0;
+		ctx->cur_part_pck = 0;
+	}
+	ctx->acb.tctx->flag_ppp = 0;
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
+static int spacc_partial_packet(struct spacc_device *spacc, int handle,
+			 int packet_stat)
+{
+	int ret = CRYPTO_OK;
+	struct spacc_job *job = NULL;
+
+	if (handle < 0 || handle > SPACC_MAX_JOBS)
+		return -ENXIO;
+
+	job = &spacc->job[handle];
+	if (!job) {
+		ret = -EIO;
+	} else {
+		switch (packet_stat) {
+		case NO_PARTIAL_PCK:
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_BEGIN);
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_END);
+			break;
+
+		case FIRST_PARTIAL_PCK:
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_BEGIN);
+			job->ctrl &= ~SPACC_CTRL_MASK(SPACC_CTRL_MSG_END);
+			break;
+
+		case MIDDLE_PARTIAL_PCK:
+			job->ctrl &= ~SPACC_CTRL_MASK(SPACC_CTRL_MSG_BEGIN);
+			job->ctrl &= ~SPACC_CTRL_MASK(SPACC_CTRL_MSG_END);
+			break;
+
+		case LAST_PARTIAL_PCK:
+			job->ctrl &= ~SPACC_CTRL_MASK(SPACC_CTRL_MSG_BEGIN);
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_END);
+			break;
+
+		default:  /* NO_PARTIAL_PCK */
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_BEGIN);
+			job->ctrl |= SPACC_CTRL_MASK(SPACC_CTRL_MSG_END);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int modify_scatterlist(struct scatterlist *src, struct scatterlist *t_sg,
+		       char *ppp_buf, int prev_remainder_len, int blk_sz,
+		       struct spacc_crypto_ctx *tctx, int nbytes, int final)
+{
+	int err;
+	size_t len = nbytes;
+	int sg_total_len;
+	unsigned char *buffer;
+	int remainder_len = (len + prev_remainder_len) % blk_sz;
+
+	buffer = kmalloc(len + prev_remainder_len, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	tctx->ppp_sgl_buff = buffer;
+
+	if (prev_remainder_len)
+		memcpy(buffer, ppp_buf, prev_remainder_len);
+
+	if (final) {
+		memset(ppp_buf, '\0', 128);
+		if (final == 1) {
+			sg_set_buf(t_sg, buffer, prev_remainder_len);
+			err = prev_remainder_len;
+			return err;
+		}
+		//err = len + prev_remainder_len; //FIXME
+		err = sg_copy_to_buffer(src,
+				sg_nents_for_len(src, len),
+				(buffer + prev_remainder_len), len);
+		if (err != len)
+			pr_debug("ERR: Failed to copy scatterlist: err:%d\n",
+									err);
+		sg_set_buf(t_sg, buffer, len+prev_remainder_len);
+		return len+prev_remainder_len;
+	}
+
+	err = sg_copy_to_buffer(src, sg_nents_for_len(src, len),
+					(buffer + prev_remainder_len), len);
+	if (err != len)
+		pr_debug("Failed to copy scatterlist to buffer\n");
+
+	if (remainder_len) {
+		memset(ppp_buf, '\0', 128);
+
+		if (len + prev_remainder_len > blk_sz) {
+			memcpy(ppp_buf, buffer +
+				(len + prev_remainder_len - remainder_len),
+				remainder_len);
+		} else {
+			memcpy(ppp_buf, buffer, remainder_len);
+			kfree(buffer);
+			tctx->ppp_sgl_buff = NULL;
+		}
+	}
+
+	sg_total_len = (len - remainder_len) + prev_remainder_len;
+	sg_set_buf(t_sg, buffer, sg_total_len);
+
+	return remainder_len;
+}
+
+static int spacc_hash_init_dma(struct device *dev, struct ahash_request *req,
+			       int final)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(tfm);
+	const struct spacc_alg *salg = spacc_tfm_ahash(&tfm->base);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	gfp_t mflags = GFP_ATOMIC;
+	int rc = -1, blk_sz = 64;
+	int prev_rem_len = ctx->rem_len;
+	int nbytes = req->nbytes;
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
+	pdu_ddt_add(&ctx->dst, ctx->digest_dma, SPACC_MAX_DIGEST_SIZE);
+
+	if (ctx->total_nents && !ctx->single_shot) {
+		switch (salg->mode->id) {
+		case CRYPTO_MODE_HASH_SHA384:
+		case CRYPTO_MODE_HMAC_SHA384:
+		case CRYPTO_MODE_HASH_SHA512:
+		case CRYPTO_MODE_HMAC_SHA512:
+			blk_sz = 128;
+			break;
+		case CRYPTO_MODE_MAC_MICHAEL:
+			blk_sz = 64;
+			break;
+		default:
+			blk_sz = 64;
+		}
+
+		ctx->rem_len = modify_scatterlist(req->src,
+						  &(tctx->ppp_sgl[0]),
+						  tctx->ppp_buffer,
+						  prev_rem_len, blk_sz,
+						  tctx,
+						  nbytes, final);
+
+		if (ctx->rem_len < 0)
+			return ctx->rem_len;
+	}
+
+	/* partial packet handling */
+	if (ctx->total_nents && !ctx->single_shot) {
+
+		if (final) {
+			spacc_ctx_clone_handle(req);
+
+			if (!ctx->small_pck) {
+				/* set to LAST PARTIAL PKT, Regular PPP pkt,
+				 * final chunk
+				 * Also for final rem_len = 0, setting up last
+				 * pkt with 0 len doesnt work
+				 */
+				rc = spacc_partial_packet(&priv->spacc,
+						ctx->acb.new_handle,
+						LAST_PARTIAL_PCK);
+				if (rc != CRYPTO_OK)
+					return -ENOMEM;
+
+			}
+		} else if (!final && tctx->ppp_sgl[0].length != 0) {
+			spacc_ctx_clone_handle(req);
+
+			/* not a small packet anymore */
+			ctx->small_pck = 0;
+
+			/* Set FIRST/MIDDLE partial pkt */
+			if (ctx->first_ppp_chunk) {
+				ctx->first_ppp_chunk = 0;
+
+				if (ctx->total_nents == ctx->rem_nents &&
+				    ctx->rem_len == 0) {
+					/* case of UPDATE % blksz == 0 */
+					spacc_partial_packet(&priv->spacc,
+							ctx->acb.new_handle,
+							NO_PARTIAL_PCK);
+				} else {
+					spacc_partial_packet(&priv->spacc,
+							ctx->acb.new_handle,
+							FIRST_PARTIAL_PCK);
+				}
+			} else {
+
+				if (ctx->total_nents == ctx->rem_nents &&
+				    ctx->rem_len == 0) {
+					rc = spacc_partial_packet(&priv->spacc,
+							ctx->acb.new_handle,
+							LAST_PARTIAL_PCK);
+				} else {
+					spacc_partial_packet(&priv->spacc,
+							ctx->acb.new_handle,
+							MIDDLE_PARTIAL_PCK);
+				}
+			}
+		} else {
+			/* set first+last pkt together */
+			return 0;
+		}
+
+		if (tctx->ppp_sgl[0].length) {
+			dma_map_count++;
+			rc = spacc_sg_to_ddt(dev, &(tctx->ppp_sgl[0]),
+					     tctx->ppp_sgl[0].length,
+					     &ctx->src, DMA_TO_DEVICE);
+		} else {
+			;/* Handle ZERO msg or ZERO last chunk */
+		}
+
+	} else if (ctx->total_nents > 0 && ctx->single_shot) {
+		/* single shot */
+		spacc_ctx_clone_handle(req);
+
+		if (req->nbytes) {
+			dma_map_count++;
+			rc = spacc_sg_to_ddt(dev, req->src, req->nbytes,
+					     &ctx->src, DMA_TO_DEVICE);
+		} else {
+			memset(tctx->ppp_buffer, '\0', PPP_BUF_SIZE);
+			sg_set_buf(&(tctx->ppp_sgl[0]), tctx->ppp_buffer,
+								PPP_BUF_SIZE);
+			dma_map_count++;
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
+		dma_map_count++;
+		rc = spacc_sg_to_ddt(dev, &(tctx->ppp_sgl[0]),
+					    tctx->ppp_sgl[0].length,
+					    &ctx->src, DMA_TO_DEVICE);
+
+	} else if (ctx->total_nents == 0 && !ctx->single_shot) {
+		/* INIT-FINUP sequence */
+		spacc_ctx_clone_handle(req);
+		dma_map_count++;
+		rc = spacc_sg_to_ddt(dev, req->src, req->nbytes,
+				     &ctx->src, DMA_TO_DEVICE);
+	} else {
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
+static void spacc_ppp_free(struct spacc_crypto_reqctx *ctx,
+			   struct spacc_crypto_ctx *tctx,
+			   struct ahash_request *req)
+{
+	if (tctx->ppp_sgl) {
+		kfree(NULL);
+		tctx->ppp_sgl = NULL;
+	}
+
+	ctx->final_part_pck = 0;
+	ctx->single_shot = 0;
+	spacc_hash_cleanup_ppp(req);
+}
+
+
+static void spacc_free_mems(struct spacc_crypto_reqctx *ctx,
+			    struct spacc_crypto_ctx *tctx,
+			    struct ahash_request *req)
+{
+	spacc_hash_cleanup_dma_dst(tctx, req);
+	spacc_hash_cleanup_dma_src(tctx, req);
+
+	if (ctx->final_part_pck || ctx->single_shot)
+		spacc_ppp_free(ctx, tctx, req);
+
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
+	if (cb->ctx->single_shot || cb->ctx->final_part_pck)
+		memcpy(cb->req->result, cb->ctx->digest_buf, dig_sz);
+	else
+		memcpy(cb->tctx->digest_ctx_buf, cb->ctx->digest_buf, dig_sz);
+
+	err = cb->spacc->job[cb->new_handle].job_err;
+
+	dma_pool_free(spacc_hash_pool, cb->ctx->digest_buf, cb->ctx->digest_dma);
+	//FIXME: cb->ctx->digest_buf = NULL;
+	spacc_free_mems(cb->ctx, cb->tctx, cb->req);
+	spacc_close(cb->spacc, cb->new_handle);
+
+
+	/* call complete once at the end */
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
+	int x, rc;
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
+	 * If keylen > hash block len, the key is supposed to be hashed so that
+	 * it is less than the block length. This is kind of a useless
+	 * property of HMAC as you can just use that hash as the key directly.
+	 * We will just not use the hardware in this case to avoid the issue.
+	 * This test was meant for hashes but it works for cmac/xcbc since we
+	 * only intend to support 128-bit keys...
+	 */
+
+	if (keylen > block_size && salg->mode->id != CRYPTO_MODE_MAC_CMAC) {
+		dev_dbg(salg->dev[0], "Exceeds keylen: %u\n", keylen);
+		dev_dbg(salg->dev[0], "Req. keylen hashing %s\n",
+			salg->calg->cra_name);
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
+	} else
+		memcpy(tctx->ipad, key, keylen);
+
+	tctx->ctx_valid = false;
+
+	if (salg->mode->sw_fb) {
+		rc = crypto_ahash_setkey(tctx->fb.hash, key, keylen);
+		if (rc < 0)
+			return rc;
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
+	for (x = 0; x < ELP_CAPI_MAX_DEV && salg->dev[x]; x++) {
+		priv = dev_get_drvdata(salg->dev[x]);
+		tctx->dev = get_device(salg->dev[x]);
+		if (spacc_isenabled(&priv->spacc, salg->mode->id, keylen)) {
+			tctx->handle = spacc_open(&priv->spacc,
+						  CRYPTO_MODE_NULL,
+						  salg->mode->id, -1,
+						  0, spacc_digest_cb, tfm);
+
+		} else
+			pr_debug("  Keylen: %d not enabled for algo: %d",
+							keylen, salg->mode->id);
+
+		if (tctx->handle >= 0)
+			break;
+
+		put_device(salg->dev[x]);
+	}
+
+	if (tctx->handle < 0) {
+		pr_err("ERR: Failed to open SPAcc context\n");
+		dev_dbg(salg->dev[0], "Failed to open SPAcc context\n");
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
+		dev_warn(tctx->dev, "Failed to write SPAcc context %d: %d\n",
+			 tctx->handle, rc);
+
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
+	tctx->flag_ppp  = 0;
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
+	int x = 0, rc = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	const struct spacc_alg *salg = spacc_tfm_ahash(&reqtfm->base);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+
+	ctx->digest_buf = NULL;
+
+	ctx->single_shot = 0;
+	ctx->total_nents = 0;
+	ctx->cur_part_pck = 0;
+	ctx->final_part_pck = 0;
+	ctx->rem_len = 0;
+	ctx->rem_nents = 0;
+	ctx->first_ppp_chunk = 1;
+	ctx->small_pck = 1;
+	tctx->ppp_sgl = NULL;
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
+						salg->mode->id, -1, 0,
+						spacc_digest_cb, reqtfm);
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
+	/* alloc ppp_sgl */
+	tctx->ppp_sgl = kmalloc(sizeof(*(tctx->ppp_sgl)) * 2, GFP_KERNEL);
+
+	if (!tctx->ppp_sgl)
+		return -ENOMEM;
+
+	sg_init_table(tctx->ppp_sgl, 2);
+	tctx->ppp_sgl[0].length = 0;
+
+	return 0;
+fallback:
+
+	ctx->fb.hash_req.base = req->base;
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	return crypto_ahash_init(&ctx->fb.hash_req);
+}
+
+static int spacc_hash_final_part_pck(struct ahash_request *req)
+{
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	int rc;
+
+	ctx->final_part_pck = 1;
+
+	/* In all the final calls the data is same as prev update and
+	 * hence we can skip this init dma part and just enQ ddt
+	 * No use in calling initdata, just process remaining bytes in ppp_sgl
+	 * and be done with it.
+	 */
+
+	rc = spacc_hash_init_dma(tctx->dev, req, 1);
+
+	if (rc < 0)
+		return -ENOMEM;
+
+	/* enqueue ddt for the remaining bytes of data, everything else
+	 * would have been processed already, req->nbytes need not be
+	 * processed
+	 * Since this will hit only for small pkts, hence the condition
+	 *  ctx->rem_len-req->nbytes for the small pkt len
+	 */
+	if (ctx->rem_len)
+		rc = spacc_packet_enqueue_ddt(&priv->spacc,
+				ctx->acb.new_handle, &ctx->src, &ctx->dst,
+				tctx->ppp_sgl[0].length,
+				0, tctx->ppp_sgl[0].length, 0, 0, 0);
+	else {
+		/* zero msg handling */
+		rc = spacc_packet_enqueue_ddt(&priv->spacc,
+				ctx->acb.new_handle,
+				&ctx->src, &ctx->dst, 0, 0, 0, 0, 0, 0);
+	}
+
+	if (rc < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		spacc_close(&priv->spacc, ctx->acb.new_handle);
+
+		if (rc != -EBUSY) {
+			dev_err(tctx->dev, "ERR: Failed to enqueue job: %d\n", rc);
+			return rc;
+		}
+
+		if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+			return -EBUSY;
+	}
+
+	return -EINPROGRESS;
+}
+
+static int spacc_hash_update(struct ahash_request *req)
+{
+	int rc;
+	int nents = sg_nents(req->src);
+	int nbytes = req->nbytes;
+
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	ctx->rem_nents += sg_nents_for_len(req->src, req->nbytes);
+
+	if (!nbytes)
+		return 0;
+
+
+	if (req->src) {
+		/* set partial packet flag */
+		ctx->cur_part_pck++;
+
+		if (ctx->total_nents == 0 && nents > 0) {
+			/* assigned once for a req */
+			ctx->total_nents = nents;
+		}
+	}
+
+	if (tctx->handle < 0 ||
+	    !tctx->ctx_valid ||
+	    nbytes > priv->max_msg_len) {
+		goto fallback;
+	}
+
+	rc = spacc_hash_init_dma(tctx->dev, req, 0);
+	if (rc < 0)
+		goto fallback;
+
+	if (rc == 0)
+		return 0;
+
+	/* assumption: update wont be getting a zero len */
+	rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->acb.new_handle,
+				      &ctx->src, &ctx->dst,
+				      tctx->ppp_sgl[0].length,
+				      0, tctx->ppp_sgl[0].length, 0, 0, 0);
+	if (rc < 0) {
+		spacc_hash_cleanup_dma(tctx->dev, req);
+		spacc_close(&priv->spacc, ctx->acb.new_handle);
+
+		if (rc != -EBUSY) {
+			dev_err(tctx->dev,
+				"ERR: Failed to enqueue job: %d\n", rc);
+			return rc;
+		} else if (!(req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG))
+			return -EBUSY;
+
+		goto fallback;
+	}
+
+	return -EINPROGRESS;
+
+fallback:
+	dev_dbg(tctx->dev, "%s Using SW fallback\n", __func__);
+
+	ctx->fb.hash_req.base.flags = req->base.flags;
+	ctx->fb.hash_req.nbytes = req->nbytes;
+	ctx->fb.hash_req.src = req->src;
+
+	return crypto_ahash_update(&ctx->fb.hash_req);
+}
+
+static int spacc_hash_final(struct ahash_request *req)
+{
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct ahash_cb_data *acb = &ctx->acb;
+	int err;
+
+	if (tctx->handle < 0 || !tctx->ctx_valid)
+		goto fallback;
+
+	ctx->final_part_pck = 1;
+
+	/* a corner case of final, where rem_len is 0, we dont proccess
+	 * that 0-size chunk and send the prev computed hash
+	 */
+	if (ctx->total_nents == ctx->rem_nents	&&
+	    ctx->rem_len == 0			&&
+	    ctx->total_nents != 0) {
+
+		memcpy(req->result, acb->tctx->digest_ctx_buf,
+			crypto_ahash_digestsize(crypto_ahash_reqtfm(acb->req)));
+
+		err = acb->spacc->job[acb->new_handle].job_err;
+
+		/* cleanup everything before exiting on this path */
+		spacc_ppp_free(ctx, tctx, req);
+		spacc_close(acb->spacc, acb->new_handle);
+
+		return CRYPTO_OK;
+	}
+
+	if (ctx->total_nents || ctx->small_pck) {
+		err = spacc_hash_final_part_pck(req);
+		/* no returns from here, this is final, process everything
+		 * and copy result/digest and exit from here
+		 */
+
+		if (err == -ENOMEM) {
+			/* Hash init failed */
+			memcpy(req->result, acb->tctx->digest_ctx_buf,
+			crypto_ahash_digestsize(crypto_ahash_reqtfm(acb->req)));
+
+			err = acb->spacc->job[acb->new_handle].job_err;
+			spacc_close(acb->spacc, acb->new_handle);
+			//FIXME: Should this return 0 as done below? why?
+			err = CRYPTO_OK;
+		}
+
+		return err;
+	}
+
+	memcpy(req->result, acb->tctx->digest_ctx_buf,
+	       crypto_ahash_digestsize(crypto_ahash_reqtfm(acb->req)));
+
+	err = acb->spacc->job[acb->new_handle].job_err;
+	spacc_close(acb->spacc, acb->new_handle);
+
+	return 0;
+
+fallback:
+	ctx->fb.hash_req.base.flags = req->base.flags;
+	ctx->fb.hash_req.result = req->result;
+
+	return crypto_ahash_final(&ctx->fb.hash_req);
+}
+
+static int spacc_hash_digest(struct ahash_request *req)
+{
+	int final = 0;
+	int rc, total_len = 0;
+	struct crypto_ahash *reqtfm = crypto_ahash_reqtfm(req);
+	struct spacc_crypto_ctx *tctx = crypto_ahash_ctx(reqtfm);
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+	struct spacc_priv *priv = dev_get_drvdata(tctx->dev);
+
+	if (tctx->flag_ppp) {
+		/* from finup */
+		ctx->single_shot = 0;
+		ctx->final_part_pck = 1;
+		final = 2;
+	} else {
+		/* direct single shot digest call */
+		ctx->single_shot = 1;
+		ctx->final_part_pck = 0;
+		ctx->rem_len = 0;
+		ctx->total_nents = sg_nents(req->src);
+
+		/* alloc ppp_sgl */
+		tctx->ppp_sgl = kmalloc(sizeof(*(tctx->ppp_sgl)) * 2, GFP_KERNEL);
+
+		if (!tctx->ppp_sgl)
+			return -ENOMEM;
+
+		sg_init_table(tctx->ppp_sgl, 2);
+		tctx->ppp_sgl[0].length = 0;
+	}
+
+	rc = spacc_hash_init_dma(tctx->dev, req, final);
+	if (rc < 0)
+		goto fallback;
+
+	if (rc == 0)
+		return 0;
+
+	if (final) {
+		if (ctx->total_nents) {
+			/* INIT-UPDATE-UPDATE-FINUP/FINAL */
+			total_len = tctx->ppp_sgl[0].length;
+		} else if (req->src->length == 0 && ctx->total_nents == 0) {
+			/* zero msg handling */
+			total_len = 0;
+		} else {
+			/* handle INIT-FINUP sequence, process req->nbytes */
+			total_len = req->nbytes;
+		}
+
+		rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->acb.new_handle,
+				&ctx->src, &ctx->dst, total_len,
+				0, total_len, 0, 0, 0);
+	} else {
+		rc = spacc_packet_enqueue_ddt(&priv->spacc, ctx->acb.new_handle,
+				&ctx->src, &ctx->dst, req->nbytes,
+				0, req->nbytes, 0, 0, 0);
+	}
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
+	ctx->fb.hash_req.base = req->base;
+	ahash_request_set_tfm(&ctx->fb.hash_req, tctx->fb.hash);
+
+	ctx->fb.hash_req.nbytes = total_len;
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
+	if (tctx->handle < 0 || !tctx->ctx_valid)
+		goto fallback;
+
+	/* set this flag for rem_len usage */
+	tctx->flag_ppp = 1;
+	rc = spacc_hash_digest(req);
+	return rc;
+
+fallback:
+	ctx->fb.hash_req.base.flags = req->base.flags;
+	ctx->fb.hash_req.nbytes     = req->nbytes;
+	ctx->fb.hash_req.src        = req->src;
+	ctx->fb.hash_req.result     = req->result;
+
+	return crypto_ahash_finup(&ctx->fb.hash_req);
+}
+
+static int spacc_hash_import(struct ahash_request *req, const void *in)
+{
+	struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	memcpy(ctx, in, sizeof(*ctx));
+
+	return 0;
+}
+
+static int spacc_hash_export(struct ahash_request *req, void *out)
+{
+	const struct spacc_crypto_reqctx *ctx = ahash_request_ctx(req);
+
+	memcpy(out, ctx, sizeof(*ctx));
+
+	return 0;
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


