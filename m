Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15AD2DBFC1
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Dec 2020 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLPLtF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Dec 2020 06:49:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:25428 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgLPLtE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Dec 2020 06:49:04 -0500
IronPort-SDR: BU9NKD++bv1Bxf8bW7LOisRIiZcuFl51wh+mJZIH+jw7JEBCgkFzUQB7hEIeHTah4qGVVQEXFx
 EbpFLhTXXkhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259775329"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="259775329"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 03:47:17 -0800
IronPort-SDR: W3ifUFrf13MbFsOnXN+0IMgsjIDGaYsOujnywPDlH1m1BYseHACYXeqqnZne8Cq2uAYuWRPIgk
 1WLEq4RbSNQw==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="368985172"
Received: from johnlyon-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.90.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 03:47:14 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v4 3/5] crypto: keembay-ocs-hcu - Add HMAC support
Date:   Wed, 16 Dec 2020 11:46:37 +0000
Message-Id: <20201216114639.3451399-4-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201216114639.3451399-1-daniele.alessandrelli@linux.intel.com>
References: <20201216114639.3451399-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add HMAC support to the Keem Bay OCS HCU driver, thus making it provide
the following additional transformations:
- hmac(sha256)
- hmac(sha384)
- hmac(sha512)
- hmac(sm3)

The Keem Bay OCS HCU hardware does not allow "context-switch" for HMAC
operations, i.e., it does not support computing a partial HMAC, save its
state and then continue it later. Therefore, full hardware acceleration
is provided only when possible (e.g., when crypto_ahash_digest() is
called); in all other cases hardware acceleration is only partial (OPAD
and IPAD calculation is done in software, while hashing is hardware
accelerated).

Co-developed-by: Declan Murphy <declan.murphy@intel.com>
Signed-off-by: Declan Murphy <declan.murphy@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 drivers/crypto/keembay/Kconfig                |   2 +-
 drivers/crypto/keembay/keembay-ocs-hcu-core.c | 387 +++++++++++++++++-
 drivers/crypto/keembay/ocs-hcu.c              | 156 +++++++
 drivers/crypto/keembay/ocs-hcu.h              |   8 +
 4 files changed, 544 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/keembay/Kconfig b/drivers/crypto/keembay/Kconfig
index d207a4511b7e..a4e7a1626cef 100644
--- a/drivers/crypto/keembay/Kconfig
+++ b/drivers/crypto/keembay/Kconfig
@@ -48,7 +48,7 @@ config CRYPTO_DEV_KEEMBAY_OCS_HCU
 	  Control Unit (HCU) hardware acceleration for use with Crypto API.
 
 	  Provides OCS HCU hardware acceleration of sha256, sha384, sha512, and
-	  sm3.
+	  sm3, as well as the HMAC variant of these algorithms.
 
 	  Say Y or M if you're building for the Intel Keem Bay SoC. If compiled
 	  as a module, the module will be called keembay-ocs-hcu.
diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
index 388cf9add757..37c4b4a689a8 100644
--- a/drivers/crypto/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
@@ -16,6 +16,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/sha2.h>
 #include <crypto/sm3.h>
+#include <crypto/hmac.h>
 #include <crypto/internal/hash.h>
 
 #include "ocs-hcu.h"
@@ -24,17 +25,29 @@
 
 /* Flag marking a final request. */
 #define REQ_FINAL			BIT(0)
+/* Flag marking a HMAC request. */
+#define REQ_FLAGS_HMAC			BIT(1)
+/* Flag set when HW HMAC is being used. */
+#define REQ_FLAGS_HMAC_HW		BIT(2)
+/* Flag set when SW HMAC is being used. */
+#define REQ_FLAGS_HMAC_SW		BIT(3)
 
 /**
  * struct ocs_hcu_ctx: OCS HCU Transform context.
  * @engine_ctx:	 Crypto Engine context.
  * @hcu_dev:	 The OCS HCU device used by the transformation.
+ * @key:	 The key (used only for HMAC transformations).
+ * @key_len:	 The length of the key.
  * @is_sm3_tfm:  Whether or not this is an SM3 transformation.
+ * @is_hmac_tfm: Whether or not this is a HMAC transformation.
  */
 struct ocs_hcu_ctx {
 	struct crypto_engine_ctx engine_ctx;
 	struct ocs_hcu_dev *hcu_dev;
+	u8 key[SHA512_BLOCK_SIZE];
+	size_t key_len;
 	bool is_sm3_tfm;
+	bool is_hmac_tfm;
 };
 
 /**
@@ -46,7 +59,8 @@ struct ocs_hcu_ctx {
  * @dig_sz:	    Digest size of the transformation / request.
  * @dma_list:	    OCS DMA linked list.
  * @hash_ctx:	    OCS HCU hashing context.
- * @buffer:	    Buffer to store partial block of data.
+ * @buffer:	    Buffer to store: partial block of data and SW HMAC
+ *		    artifacts (ipad, opad, etc.).
  * @buf_cnt:	    Number of bytes currently stored in the buffer.
  * @buf_dma_addr:   The DMA address of @buffer (when mapped).
  * @buf_dma_count:  The number of bytes in @buffer currently DMA-mapped.
@@ -63,7 +77,13 @@ struct ocs_hcu_rctx {
 	size_t			dig_sz;
 	struct ocs_hcu_dma_list	*dma_list;
 	struct ocs_hcu_hash_ctx	hash_ctx;
-	u8			buffer[SHA512_BLOCK_SIZE];
+	/*
+	 * Buffer is double the block size because we need space for SW HMAC
+	 * artifacts, i.e:
+	 * - ipad (1 block) + a possible partial block of data.
+	 * - opad (1 block) + digest of H(k ^ ipad || m)
+	 */
+	u8			buffer[2 * SHA512_BLOCK_SIZE];
 	size_t			buf_cnt;
 	dma_addr_t		buf_dma_addr;
 	size_t			buf_dma_count;
@@ -352,19 +372,82 @@ static int kmb_ocs_hcu_handle_queue(struct ahash_request *req)
 	return crypto_transfer_hash_request_to_engine(hcu_dev->engine, req);
 }
 
+static int prepare_ipad(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
+	int i;
+
+	WARN(rctx->buf_cnt, "%s: Context buffer is not empty\n", __func__);
+	WARN(!(rctx->flags & REQ_FLAGS_HMAC_SW),
+	     "%s: HMAC_SW flag is not set\n", __func__);
+	/*
+	 * Key length must be equal to block size. If key is shorter,
+	 * we pad it with zero (note: key cannot be longer, since
+	 * longer keys are hashed by kmb_ocs_hcu_setkey()).
+	 */
+	if (ctx->key_len > rctx->blk_sz) {
+		WARN("%s: Invalid key length in tfm context\n", __func__);
+		return -EINVAL;
+	}
+	memzero_explicit(&ctx->key[ctx->key_len],
+			 rctx->blk_sz - ctx->key_len);
+	ctx->key_len = rctx->blk_sz;
+	/*
+	 * Prepare IPAD for HMAC. Only done for first block.
+	 * HMAC(k,m) = H(k ^ opad || H(k ^ ipad || m))
+	 * k ^ ipad will be first hashed block.
+	 * k ^ opad will be calculated in the final request.
+	 * Only needed if not using HW HMAC.
+	 */
+	for (i = 0; i < rctx->blk_sz; i++)
+		rctx->buffer[i] = ctx->key[i] ^ HMAC_IPAD_VALUE;
+	rctx->buf_cnt = rctx->blk_sz;
+
+	return 0;
+}
+
 static int kmb_ocs_hcu_do_one_request(struct crypto_engine *engine, void *areq)
 {
 	struct ahash_request *req = container_of(areq, struct ahash_request,
 						 base);
 	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_ctx *tctx = crypto_ahash_ctx(tfm);
 	int rc;
+	int i;
 
 	if (!hcu_dev) {
 		rc = -ENOENT;
 		goto error;
 	}
 
+	/*
+	 * If hardware HMAC flag is set, perform HMAC in hardware.
+	 *
+	 * NOTE: this flag implies REQ_FINAL && kmb_get_total_data(rctx)
+	 */
+	if (rctx->flags & REQ_FLAGS_HMAC_HW) {
+		/* Map input data into the HCU DMA linked list. */
+		rc = kmb_ocs_dma_prepare(req);
+		if (rc)
+			goto error;
+
+		rc = ocs_hcu_hmac(hcu_dev, rctx->algo, tctx->key, tctx->key_len,
+				  rctx->dma_list, req->result, rctx->dig_sz);
+
+		/* Unmap data and free DMA list regardless of return code. */
+		kmb_ocs_hcu_dma_cleanup(req, rctx);
+
+		/* Process previous return code. */
+		if (rc)
+			goto error;
+
+		goto done;
+	}
+
 	/* Handle update request case. */
 	if (!(rctx->flags & REQ_FINAL)) {
 		/* Update should always have input data. */
@@ -433,6 +516,36 @@ static int kmb_ocs_hcu_do_one_request(struct crypto_engine *engine, void *areq)
 			goto error;
 	}
 
+	/*
+	 * If we are finalizing a SW HMAC request, we just computed the result
+	 * of: H(k ^ ipad || m).
+	 *
+	 * We now need to complete the HMAC calculation with the OPAD step,
+	 * that is, we need to compute H(k ^ opad || digest), where digest is
+	 * the digest we just obtained, i.e., H(k ^ ipad || m).
+	 */
+	if (rctx->flags & REQ_FLAGS_HMAC_SW) {
+		/*
+		 * Compute k ^ opad and store it in the request buffer (which
+		 * is not used anymore at this point).
+		 * Note: key has been padded / hashed already (so keylen ==
+		 * blksz) .
+		 */
+		WARN_ON(tctx->key_len != rctx->blk_sz);
+		for (i = 0; i < rctx->blk_sz; i++)
+			rctx->buffer[i] = tctx->key[i] ^ HMAC_OPAD_VALUE;
+		/* Now append the digest to the rest of the buffer. */
+		for (i = 0; (i < rctx->dig_sz); i++)
+			rctx->buffer[rctx->blk_sz + i] = req->result[i];
+
+		/* Now hash the buffer to obtain the final HMAC. */
+		rc = ocs_hcu_digest(hcu_dev, rctx->algo, rctx->buffer,
+				    rctx->blk_sz + rctx->dig_sz, req->result,
+				    rctx->dig_sz);
+		if (rc)
+			goto error;
+	}
+
 	/* Perform secure clean-up. */
 	kmb_ocs_hcu_secure_cleanup(req);
 done:
@@ -486,12 +599,17 @@ static int kmb_ocs_hcu_init(struct ahash_request *req)
 	/* Initialize intermediate data. */
 	ocs_hcu_hash_init(&rctx->hash_ctx, rctx->algo);
 
+	/* If this a HMAC request, set HMAC flag. */
+	if (ctx->is_hmac_tfm)
+		rctx->flags |= REQ_FLAGS_HMAC;
+
 	return 0;
 }
 
 static int kmb_ocs_hcu_update(struct ahash_request *req)
 {
 	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	int rc;
 
 	if (!req->nbytes)
 		return 0;
@@ -500,6 +618,19 @@ static int kmb_ocs_hcu_update(struct ahash_request *req)
 	rctx->sg_data_offset = 0;
 	rctx->sg = req->src;
 
+	/*
+	 * If we are doing HMAC, then we must use SW-assisted HMAC, since HW
+	 * HMAC does not support context switching (there it can only be used
+	 * with finup() or digest()).
+	 */
+	if (rctx->flags & REQ_FLAGS_HMAC &&
+	    !(rctx->flags & REQ_FLAGS_HMAC_SW)) {
+		rctx->flags |= REQ_FLAGS_HMAC_SW;
+		rc = prepare_ipad(req);
+		if (rc)
+			return rc;
+	}
+
 	/*
 	 * If remaining sg_data fits into ctx buffer, just copy it there; we'll
 	 * process it at the next update() or final().
@@ -510,6 +641,44 @@ static int kmb_ocs_hcu_update(struct ahash_request *req)
 	return kmb_ocs_hcu_handle_queue(req);
 }
 
+/* Common logic for kmb_ocs_hcu_final() and kmb_ocs_hcu_finup(). */
+static int kmb_ocs_hcu_fin_common(struct ahash_request *req)
+{
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
+	int rc;
+
+	rctx->flags |= REQ_FINAL;
+
+	/*
+	 * If this is a HMAC request and, so far, we didn't have to switch to
+	 * SW HMAC, check if we can use HW HMAC.
+	 */
+	if (rctx->flags & REQ_FLAGS_HMAC &&
+	    !(rctx->flags & REQ_FLAGS_HMAC_SW)) {
+		/*
+		 * If we are here, it means we never processed any data so far,
+		 * so we can use HW HMAC, but only if there is some data to
+		 * process (since OCS HW MAC does not support zero-length
+		 * messages) and the key length is supported by the hardware
+		 * (OCS HCU HW only supports length <= 64); if HW HMAC cannot
+		 * be used, fall back to SW-assisted HMAC.
+		 */
+		if (kmb_get_total_data(rctx) &&
+		    ctx->key_len <= OCS_HCU_HW_KEY_LEN) {
+			rctx->flags |= REQ_FLAGS_HMAC_HW;
+		} else {
+			rctx->flags |= REQ_FLAGS_HMAC_SW;
+			rc = prepare_ipad(req);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return kmb_ocs_hcu_handle_queue(req);
+}
+
 static int kmb_ocs_hcu_final(struct ahash_request *req)
 {
 	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
@@ -518,9 +687,7 @@ static int kmb_ocs_hcu_final(struct ahash_request *req)
 	rctx->sg_data_offset = 0;
 	rctx->sg = NULL;
 
-	rctx->flags |= REQ_FINAL;
-
-	return kmb_ocs_hcu_handle_queue(req);
+	return kmb_ocs_hcu_fin_common(req);
 }
 
 static int kmb_ocs_hcu_finup(struct ahash_request *req)
@@ -531,9 +698,7 @@ static int kmb_ocs_hcu_finup(struct ahash_request *req)
 	rctx->sg_data_offset = 0;
 	rctx->sg = req->src;
 
-	rctx->flags |= REQ_FINAL;
-
-	return kmb_ocs_hcu_handle_queue(req);
+	return kmb_ocs_hcu_fin_common(req);
 }
 
 static int kmb_ocs_hcu_digest(struct ahash_request *req)
@@ -573,6 +738,76 @@ static int kmb_ocs_hcu_import(struct ahash_request *req, const void *in)
 	return 0;
 }
 
+static int kmb_ocs_hcu_setkey(struct crypto_ahash *tfm, const u8 *key,
+			      unsigned int keylen)
+{
+	unsigned int digestsize = crypto_ahash_digestsize(tfm);
+	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
+	size_t blk_sz = crypto_ahash_blocksize(tfm);
+	struct crypto_ahash *ahash_tfm;
+	struct ahash_request *req;
+	struct crypto_wait wait;
+	struct scatterlist sg;
+	const char *alg_name;
+	int rc;
+
+	/*
+	 * Key length must be equal to block size:
+	 * - If key is shorter, we are done for now (the key will be padded
+	 *   later on); this is to maximize the use of HW HMAC (which works
+	 *   only for keys <= 64 bytes).
+	 * - If key is longer, we hash it.
+	 */
+	if (keylen <= blk_sz) {
+		memcpy(ctx->key, key, keylen);
+		ctx->key_len = keylen;
+		return 0;
+	}
+
+	switch (digestsize) {
+	case SHA256_DIGEST_SIZE:
+		alg_name = ctx->is_sm3_tfm ? "sm3-keembay-ocs" :
+					     "sha256-keembay-ocs";
+		break;
+	case SHA384_DIGEST_SIZE:
+		alg_name = "sha384-keembay-ocs";
+		break;
+	case SHA512_DIGEST_SIZE:
+		alg_name = "sha512-keembay-ocs";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ahash_tfm = crypto_alloc_ahash(alg_name, 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req = ahash_request_alloc(ahash_tfm, GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto err_free_ahash;
+	}
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	crypto_ahash_clear_flags(ahash_tfm, ~0);
+
+	sg_init_one(&sg, key, keylen);
+	ahash_request_set_crypt(req, &sg, ctx->key, keylen);
+
+	rc = crypto_wait_req(crypto_ahash_digest(req), &wait);
+	if (rc == 0)
+		ctx->key_len = digestsize;
+
+	ahash_request_free(req);
+err_free_ahash:
+	crypto_free_ahash(ahash_tfm);
+
+	return rc;
+}
+
 /* Set request size and initialize tfm context. */
 static void __cra_init(struct crypto_tfm *tfm, struct ocs_hcu_ctx *ctx)
 {
@@ -605,6 +840,38 @@ static int kmb_ocs_hcu_sm3_cra_init(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static int kmb_ocs_hcu_hmac_sm3_cra_init(struct crypto_tfm *tfm)
+{
+	struct ocs_hcu_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	__cra_init(tfm, ctx);
+
+	ctx->is_sm3_tfm = true;
+	ctx->is_hmac_tfm = true;
+
+	return 0;
+}
+
+static int kmb_ocs_hcu_hmac_cra_init(struct crypto_tfm *tfm)
+{
+	struct ocs_hcu_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	__cra_init(tfm, ctx);
+
+	ctx->is_hmac_tfm = true;
+
+	return 0;
+}
+
+/* Function called when 'tfm' is de-initialized. */
+static void kmb_ocs_hcu_hmac_cra_exit(struct crypto_tfm *tfm)
+{
+	struct ocs_hcu_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	/* Clear the key. */
+	memzero_explicit(ctx->key, sizeof(ctx->key));
+}
+
 static struct ahash_alg ocs_hcu_algs[] = {
 {
 	.init		= kmb_ocs_hcu_init,
@@ -630,6 +897,32 @@ static struct ahash_alg ocs_hcu_algs[] = {
 		}
 	}
 },
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.setkey		= kmb_ocs_hcu_setkey,
+	.halg = {
+		.digestsize	= SHA256_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "hmac(sha256)",
+			.cra_driver_name	= "hmac-sha256-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA256_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_hmac_cra_init,
+			.cra_exit		= kmb_ocs_hcu_hmac_cra_exit,
+		}
+	}
+},
 {
 	.init		= kmb_ocs_hcu_init,
 	.update		= kmb_ocs_hcu_update,
@@ -654,6 +947,32 @@ static struct ahash_alg ocs_hcu_algs[] = {
 		}
 	}
 },
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.setkey		= kmb_ocs_hcu_setkey,
+	.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "hmac-sm3-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_hmac_sm3_cra_init,
+			.cra_exit		= kmb_ocs_hcu_hmac_cra_exit,
+		}
+	}
+},
 {
 	.init		= kmb_ocs_hcu_init,
 	.update		= kmb_ocs_hcu_update,
@@ -678,6 +997,32 @@ static struct ahash_alg ocs_hcu_algs[] = {
 		}
 	}
 },
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.setkey		= kmb_ocs_hcu_setkey,
+	.halg = {
+		.digestsize	= SHA384_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "hmac(sha384)",
+			.cra_driver_name	= "hmac-sha384-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA384_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_hmac_cra_init,
+			.cra_exit		= kmb_ocs_hcu_hmac_cra_exit,
+		}
+	}
+},
 {
 	.init		= kmb_ocs_hcu_init,
 	.update		= kmb_ocs_hcu_update,
@@ -702,6 +1047,32 @@ static struct ahash_alg ocs_hcu_algs[] = {
 		}
 	}
 },
+{
+	.init		= kmb_ocs_hcu_init,
+	.update		= kmb_ocs_hcu_update,
+	.final		= kmb_ocs_hcu_final,
+	.finup		= kmb_ocs_hcu_finup,
+	.digest		= kmb_ocs_hcu_digest,
+	.export		= kmb_ocs_hcu_export,
+	.import		= kmb_ocs_hcu_import,
+	.setkey		= kmb_ocs_hcu_setkey,
+	.halg = {
+		.digestsize	= SHA512_DIGEST_SIZE,
+		.statesize	= sizeof(struct ocs_hcu_rctx),
+		.base	= {
+			.cra_name		= "hmac(sha512)",
+			.cra_driver_name	= "hmac-sha512-keembay-ocs",
+			.cra_priority		= 255,
+			.cra_flags		= CRYPTO_ALG_ASYNC,
+			.cra_blocksize		= SHA512_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct ocs_hcu_ctx),
+			.cra_alignmask		= 0,
+			.cra_module		= THIS_MODULE,
+			.cra_init		= kmb_ocs_hcu_hmac_cra_init,
+			.cra_exit		= kmb_ocs_hcu_hmac_cra_exit,
+		}
+	}
+},
 };
 
 /* Device tree driver match. */
diff --git a/drivers/crypto/keembay/ocs-hcu.c b/drivers/crypto/keembay/ocs-hcu.c
index 6a80a31d0b00..81eecacf603a 100644
--- a/drivers/crypto/keembay/ocs-hcu.c
+++ b/drivers/crypto/keembay/ocs-hcu.c
@@ -367,6 +367,69 @@ static int ocs_hcu_hw_cfg(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
 	return 0;
 }
 
+/**
+ * ocs_hcu_clear_key() - Clear key stored in OCS HMAC KEY registers.
+ * @hcu_dev:	The OCS HCU device whose key registers should be cleared.
+ */
+static void ocs_hcu_clear_key(struct ocs_hcu_dev *hcu_dev)
+{
+	int reg_off;
+
+	/* Clear OCS_HCU_KEY_[0..15] */
+	for (reg_off = 0; reg_off < OCS_HCU_HW_KEY_LEN; reg_off += sizeof(u32))
+		writel(0, hcu_dev->io_base + OCS_HCU_KEY_0 + reg_off);
+}
+
+/**
+ * ocs_hcu_write_key() - Write key to OCS HMAC KEY registers.
+ * @hcu_dev:	The OCS HCU device the key should be written to.
+ * @key:	The key to be written.
+ * @len:	The size of the key to write. It must be OCS_HCU_HW_KEY_LEN.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+static int ocs_hcu_write_key(struct ocs_hcu_dev *hcu_dev, const u8 *key, size_t len)
+{
+	u32 key_u32[OCS_HCU_HW_KEY_LEN_U32];
+	int i;
+
+	if (len > OCS_HCU_HW_KEY_LEN)
+		return -EINVAL;
+
+	/* Copy key into temporary u32 array. */
+	memcpy(key_u32, key, len);
+
+	/*
+	 * Hardware requires all the bytes of the HW Key vector to be
+	 * written. So pad with zero until we reach OCS_HCU_HW_KEY_LEN.
+	 */
+	memzero_explicit((u8 *)key_u32 + len, OCS_HCU_HW_KEY_LEN - len);
+
+	/*
+	 * OCS hardware expects the MSB of the key to be written at the highest
+	 * address of the HCU Key vector; in other word, the key must be
+	 * written in reverse order.
+	 *
+	 * Therefore, we first enable byte swapping for the HCU key vector;
+	 * so that bytes of 32-bit word written to OCS_HCU_KEY_[0..15] will be
+	 * swapped:
+	 * 3 <---> 0, 2 <---> 1.
+	 */
+	writel(HCU_BYTE_ORDER_SWAP,
+	       hcu_dev->io_base + OCS_HCU_KEY_BYTE_ORDER_CFG);
+	/*
+	 * And then we write the 32-bit words composing the key starting from
+	 * the end of the key.
+	 */
+	for (i = 0; i < OCS_HCU_HW_KEY_LEN_U32; i++)
+		writel(key_u32[OCS_HCU_HW_KEY_LEN_U32 - 1 - i],
+		       hcu_dev->io_base + OCS_HCU_KEY_0 + (sizeof(u32) * i));
+
+	memzero_explicit(key_u32, OCS_HCU_HW_KEY_LEN);
+
+	return 0;
+}
+
 /**
  * ocs_hcu_ll_dma_start() - Start OCS HCU hashing via DMA
  * @hcu_dev:	The OCS HCU device to use.
@@ -649,6 +712,99 @@ int ocs_hcu_hash_final(struct ocs_hcu_dev *hcu_dev,
 	return ocs_hcu_get_digest(hcu_dev, ctx->algo, dgst, dgst_len);
 }
 
+/**
+ * ocs_hcu_digest() - Compute hash digest.
+ * @hcu_dev:		The OCS HCU device to use.
+ * @algo:		The hash algorithm to use.
+ * @data:		The input data to process.
+ * @data_len:		The length of @data.
+ * @dgst:		The buffer where to save the computed digest.
+ * @dgst_len:		The length of @dgst.
+ *
+ * Return: 0 on success; negative error code otherwise.
+ */
+int ocs_hcu_digest(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
+		   void *data, size_t data_len, u8 *dgst, size_t dgst_len)
+{
+	struct device *dev = hcu_dev->dev;
+	dma_addr_t dma_handle;
+	u32 reg;
+	int rc;
+
+	/* Configure the hardware for the current request. */
+	rc = ocs_hcu_hw_cfg(hcu_dev, algo, false);
+	if (rc)
+		return rc;
+
+	dma_handle = dma_map_single(dev, data, data_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma_handle))
+		return -EIO;
+
+	reg = HCU_DMA_SNOOP_MASK | HCU_DMA_EN;
+
+	ocs_hcu_done_irq_en(hcu_dev);
+
+	reinit_completion(&hcu_dev->irq_done);
+
+	writel(dma_handle, hcu_dev->io_base + OCS_HCU_DMA_SRC_ADDR);
+	writel(data_len, hcu_dev->io_base + OCS_HCU_DMA_SRC_SIZE);
+	writel(OCS_HCU_START, hcu_dev->io_base + OCS_HCU_OPERATION);
+	writel(reg, hcu_dev->io_base + OCS_HCU_DMA_DMA_MODE);
+
+	writel(OCS_HCU_TERMINATE, hcu_dev->io_base + OCS_HCU_OPERATION);
+
+	rc = ocs_hcu_wait_and_disable_irq(hcu_dev);
+	if (rc)
+		return rc;
+
+	dma_unmap_single(dev, dma_handle, data_len, DMA_TO_DEVICE);
+
+	return ocs_hcu_get_digest(hcu_dev, algo, dgst, dgst_len);
+}
+
+/**
+ * ocs_hcu_hmac() - Compute HMAC.
+ * @hcu_dev:		The OCS HCU device to use.
+ * @algo:		The hash algorithm to use with HMAC.
+ * @key:		The key to use.
+ * @dma_list:	The OCS DMA list mapping the input data to process.
+ * @key_len:		The length of @key.
+ * @dgst:		The buffer where to save the computed HMAC.
+ * @dgst_len:		The length of @dgst.
+ *
+ * Return: 0 on success; negative error code otherwise.
+ */
+int ocs_hcu_hmac(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
+		 const u8 *key, size_t key_len,
+		 const struct ocs_hcu_dma_list *dma_list,
+		 u8 *dgst, size_t dgst_len)
+{
+	int rc;
+
+	/* Ensure 'key' is not NULL. */
+	if (!key || key_len == 0)
+		return -EINVAL;
+
+	/* Configure the hardware for the current request. */
+	rc = ocs_hcu_hw_cfg(hcu_dev, algo, true);
+	if (rc)
+		return rc;
+
+	rc = ocs_hcu_write_key(hcu_dev, key, key_len);
+	if (rc)
+		return rc;
+
+	rc = ocs_hcu_ll_dma_start(hcu_dev, dma_list, true);
+
+	/* Clear HW key before processing return code. */
+	ocs_hcu_clear_key(hcu_dev);
+
+	if (rc)
+		return rc;
+
+	return ocs_hcu_get_digest(hcu_dev, algo, dgst, dgst_len);
+}
+
 irqreturn_t ocs_hcu_irq_handler(int irq, void *dev_id)
 {
 	struct ocs_hcu_dev *hcu_dev = dev_id;
diff --git a/drivers/crypto/keembay/ocs-hcu.h b/drivers/crypto/keembay/ocs-hcu.h
index 6a467dcaf99c..fbbbb92a0592 100644
--- a/drivers/crypto/keembay/ocs-hcu.h
+++ b/drivers/crypto/keembay/ocs-hcu.h
@@ -95,4 +95,12 @@ int ocs_hcu_hash_final(struct ocs_hcu_dev *hcu_dev,
 		       const struct ocs_hcu_hash_ctx *ctx, u8 *dgst,
 		       size_t dgst_len);
 
+int ocs_hcu_digest(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
+		   void *data, size_t data_len, u8 *dgst, size_t dgst_len);
+
+int ocs_hcu_hmac(struct ocs_hcu_dev *hcu_dev, enum ocs_hcu_algo algo,
+		 const u8 *key, size_t key_len,
+		 const struct ocs_hcu_dma_list *dma_list,
+		 u8 *dgst, size_t dgst_len);
+
 #endif /* _CRYPTO_OCS_HCU_H */
-- 
2.26.2

