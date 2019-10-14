Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0CD6245
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfJNMT7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 08:19:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40167 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfJNMT6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 08:19:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so16529410wmj.5
        for <linux-crypto@vger.kernel.org>; Mon, 14 Oct 2019 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVNHs0s3WCYU5+OihjPscz3hwsEKNMpgRbegvdwaBws=;
        b=KkKFJz2cgvK69Ns0vSu7ysdTNf6SaIlhIBpDa170/DMnCf0mmH6F0B3r5h0hG9oShR
         OQJffL2PZNw+7Vxy8wrgTVpeSpKZfGZhnNhyoTOIWsKWCqf9/7zpPigYJJQI5lOHJAaf
         RK6ctxzdMnlCXpFi+gRkpp3ybhCB3B02Co05k+8WswpKEUEb793dEIE1rugaVQ/0kxDN
         GbB2C6JEsaMpehr8jv3ZT8Ak/wG5kQrvQbSj2vCTi5LZrZEXVbaDxI+fdKKSP3CNz066
         m79NmXBy7NYSevt1BV2oPapNXC+38wrnWd+mUV5p8J2pp8nXwinifTDnF3hRkSSQjSYq
         QTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVNHs0s3WCYU5+OihjPscz3hwsEKNMpgRbegvdwaBws=;
        b=tFYi1Sfv9mrMEnNmnRlNqfSwwkT+8lcVSGR+VWuKliJjRbM2kC5t9WAlplK3YBnvvH
         0AlMK9PZtqqMjFTTgAnUZyXPRf/AAYhple4nPA4DUKiMAlNonRALzXD5LUD5bj+vN0ne
         J0x2rb6GROS0YDk3aNQDCIr7vKjaNJ7GbxaHOllahS4OsnnrjQ3GoFeUxGfqj/y5K5B1
         09tQa0bwLpuRUPpIz/iMTCPNWrEfzYAuvE3TWWQ+BmV/l0VxjY9U5YgCU5HHImyhlWET
         RHAuA8sr5AE6GeSPX57DUyQz9V6TV+PyH6CcJmvoEDl4+qgd0bJYUf8OdJld6tyalsZF
         lGQQ==
X-Gm-Message-State: APjAAAXfKKp18JLhDSVm9oDE7MpTzeFtOF4glXHAN3GtsiGWNbiE3oDa
        nGKpjnvPKDeWuJe7xBmurteBSpYKh5uN4Q==
X-Google-Smtp-Source: APXvYqzE8KRd3mv5e0DTO9y6TwjAKGL9ydCJRE/b2c4F4R/mHWDGpMCv6CvZL43ycg94sLCJZz+NvA==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr14429812wml.106.1571055596254;
        Mon, 14 Oct 2019 05:19:56 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id i1sm20222470wmb.19.2019.10.14.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:19:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 16/25] crypto: mxs - switch to skcipher API
Date:   Mon, 14 Oct 2019 14:19:01 +0200
Message-Id: <20191014121910.7264-17-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
References: <20191014121910.7264-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Commit 7a7ffe65c8c5 ("crypto: skcipher - Add top-level skcipher interface")
dated 20 august 2015 introduced the new skcipher API which is supposed to
replace both blkcipher and ablkcipher. While all consumers of the API have
been converted long ago, some producers of the ablkcipher remain, forcing
us to keep the ablkcipher support routines alive, along with the matching
code to expose [a]blkciphers via the skcipher API.

So switch this driver to the skcipher API, allowing us to finally drop the
blkcipher code in the near future.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/mxs-dcp.c | 140 +++++++++-----------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index bf8d2197bc11..f438b425c655 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -211,11 +211,11 @@ static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
  * Encryption (AES128)
  */
 static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
-			   struct ablkcipher_request *req, int init)
+			   struct skcipher_request *req, int init)
 {
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
-	struct dcp_aes_req_ctx *rctx = ablkcipher_request_ctx(req);
+	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 	int ret;
 
 	dma_addr_t key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
@@ -274,9 +274,9 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 {
 	struct dcp *sdcp = global_sdcp;
 
-	struct ablkcipher_request *req = ablkcipher_request_cast(arq);
+	struct skcipher_request *req = skcipher_request_cast(arq);
 	struct dcp_async_ctx *actx = crypto_tfm_ctx(arq->tfm);
-	struct dcp_aes_req_ctx *rctx = ablkcipher_request_ctx(req);
+	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 
 	struct scatterlist *dst = req->dst;
 	struct scatterlist *src = req->src;
@@ -305,7 +305,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	if (!rctx->ecb) {
 		/* Copy the CBC IV just past the key. */
-		memcpy(key + AES_KEYSIZE_128, req->info, AES_KEYSIZE_128);
+		memcpy(key + AES_KEYSIZE_128, req->iv, AES_KEYSIZE_128);
 		/* CBC needs the INIT set. */
 		init = 1;
 	} else {
@@ -316,10 +316,10 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 		src_buf = sg_virt(src);
 		len = sg_dma_len(src);
 		tlen += len;
-		limit_hit = tlen > req->nbytes;
+		limit_hit = tlen > req->cryptlen;
 
 		if (limit_hit)
-			len = req->nbytes - (tlen - len);
+			len = req->cryptlen - (tlen - len);
 
 		do {
 			if (actx->fill + len > out_off)
@@ -375,10 +375,10 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 	/* Copy the IV for CBC for chaining */
 	if (!rctx->ecb) {
 		if (rctx->enc)
-			memcpy(req->info, out_buf+(last_out_len-AES_BLOCK_SIZE),
+			memcpy(req->iv, out_buf+(last_out_len-AES_BLOCK_SIZE),
 				AES_BLOCK_SIZE);
 		else
-			memcpy(req->info, in_buf+(last_out_len-AES_BLOCK_SIZE),
+			memcpy(req->iv, in_buf+(last_out_len-AES_BLOCK_SIZE),
 				AES_BLOCK_SIZE);
 	}
 
@@ -422,17 +422,17 @@ static int dcp_chan_thread_aes(void *data)
 	return 0;
 }
 
-static int mxs_dcp_block_fallback(struct ablkcipher_request *req, int enc)
+static int mxs_dcp_block_fallback(struct skcipher_request *req, int enc)
 {
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct dcp_async_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct dcp_async_ctx *ctx = crypto_skcipher_ctx(tfm);
 	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 	int ret;
 
 	skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 	skcipher_request_set_callback(subreq, req->base.flags, NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst,
-				   req->nbytes, req->info);
+				   req->cryptlen, req->iv);
 
 	if (enc)
 		ret = crypto_skcipher_encrypt(subreq);
@@ -444,12 +444,12 @@ static int mxs_dcp_block_fallback(struct ablkcipher_request *req, int enc)
 	return ret;
 }
 
-static int mxs_dcp_aes_enqueue(struct ablkcipher_request *req, int enc, int ecb)
+static int mxs_dcp_aes_enqueue(struct skcipher_request *req, int enc, int ecb)
 {
 	struct dcp *sdcp = global_sdcp;
 	struct crypto_async_request *arq = &req->base;
 	struct dcp_async_ctx *actx = crypto_tfm_ctx(arq->tfm);
-	struct dcp_aes_req_ctx *rctx = ablkcipher_request_ctx(req);
+	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
 	int ret;
 
 	if (unlikely(actx->key_len != AES_KEYSIZE_128))
@@ -468,30 +468,30 @@ static int mxs_dcp_aes_enqueue(struct ablkcipher_request *req, int enc, int ecb)
 	return ret;
 }
 
-static int mxs_dcp_aes_ecb_decrypt(struct ablkcipher_request *req)
+static int mxs_dcp_aes_ecb_decrypt(struct skcipher_request *req)
 {
 	return mxs_dcp_aes_enqueue(req, 0, 1);
 }
 
-static int mxs_dcp_aes_ecb_encrypt(struct ablkcipher_request *req)
+static int mxs_dcp_aes_ecb_encrypt(struct skcipher_request *req)
 {
 	return mxs_dcp_aes_enqueue(req, 1, 1);
 }
 
-static int mxs_dcp_aes_cbc_decrypt(struct ablkcipher_request *req)
+static int mxs_dcp_aes_cbc_decrypt(struct skcipher_request *req)
 {
 	return mxs_dcp_aes_enqueue(req, 0, 0);
 }
 
-static int mxs_dcp_aes_cbc_encrypt(struct ablkcipher_request *req)
+static int mxs_dcp_aes_cbc_encrypt(struct skcipher_request *req)
 {
 	return mxs_dcp_aes_enqueue(req, 1, 0);
 }
 
-static int mxs_dcp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
+static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int len)
 {
-	struct dcp_async_ctx *actx = crypto_ablkcipher_ctx(tfm);
+	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
 	unsigned int ret;
 
 	/*
@@ -525,10 +525,10 @@ static int mxs_dcp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	return ret;
 }
 
-static int mxs_dcp_aes_fallback_init(struct crypto_tfm *tfm)
+static int mxs_dcp_aes_fallback_init_tfm(struct crypto_skcipher *tfm)
 {
-	const char *name = crypto_tfm_alg_name(tfm);
-	struct dcp_async_ctx *actx = crypto_tfm_ctx(tfm);
+	const char *name = crypto_tfm_alg_name(crypto_skcipher_tfm(tfm));
+	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
 	struct crypto_sync_skcipher *blk;
 
 	blk = crypto_alloc_sync_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
@@ -536,13 +536,13 @@ static int mxs_dcp_aes_fallback_init(struct crypto_tfm *tfm)
 		return PTR_ERR(blk);
 
 	actx->fallback = blk;
-	tfm->crt_ablkcipher.reqsize = sizeof(struct dcp_aes_req_ctx);
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct dcp_aes_req_ctx));
 	return 0;
 }
 
-static void mxs_dcp_aes_fallback_exit(struct crypto_tfm *tfm)
+static void mxs_dcp_aes_fallback_exit_tfm(struct crypto_skcipher *tfm)
 {
-	struct dcp_async_ctx *actx = crypto_tfm_ctx(tfm);
+	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
 
 	crypto_free_sync_skcipher(actx->fallback);
 }
@@ -854,54 +854,44 @@ static void dcp_sha_cra_exit(struct crypto_tfm *tfm)
 }
 
 /* AES 128 ECB and AES 128 CBC */
-static struct crypto_alg dcp_aes_algs[] = {
+static struct skcipher_alg dcp_aes_algs[] = {
 	{
-		.cra_name		= "ecb(aes)",
-		.cra_driver_name	= "ecb-aes-dcp",
-		.cra_priority		= 400,
-		.cra_alignmask		= 15,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC |
+		.base.cra_name		= "ecb(aes)",
+		.base.cra_driver_name	= "ecb-aes-dcp",
+		.base.cra_priority	= 400,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_NEED_FALLBACK,
-		.cra_init		= mxs_dcp_aes_fallback_init,
-		.cra_exit		= mxs_dcp_aes_fallback_exit,
-		.cra_blocksize		= AES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_u	= {
-			.ablkcipher = {
-				.min_keysize	= AES_MIN_KEY_SIZE,
-				.max_keysize	= AES_MAX_KEY_SIZE,
-				.setkey		= mxs_dcp_aes_setkey,
-				.encrypt	= mxs_dcp_aes_ecb_encrypt,
-				.decrypt	= mxs_dcp_aes_ecb_decrypt
-			},
-		},
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.setkey			= mxs_dcp_aes_setkey,
+		.encrypt		= mxs_dcp_aes_ecb_encrypt,
+		.decrypt		= mxs_dcp_aes_ecb_decrypt,
+		.init			= mxs_dcp_aes_fallback_init_tfm,
+		.exit			= mxs_dcp_aes_fallback_exit_tfm,
 	}, {
-		.cra_name		= "cbc(aes)",
-		.cra_driver_name	= "cbc-aes-dcp",
-		.cra_priority		= 400,
-		.cra_alignmask		= 15,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC |
+		.base.cra_name		= "cbc(aes)",
+		.base.cra_driver_name	= "cbc-aes-dcp",
+		.base.cra_priority	= 400,
+		.base.cra_alignmask	= 15,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC |
 					  CRYPTO_ALG_NEED_FALLBACK,
-		.cra_init		= mxs_dcp_aes_fallback_init,
-		.cra_exit		= mxs_dcp_aes_fallback_exit,
-		.cra_blocksize		= AES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_u = {
-			.ablkcipher = {
-				.min_keysize	= AES_MIN_KEY_SIZE,
-				.max_keysize	= AES_MAX_KEY_SIZE,
-				.setkey		= mxs_dcp_aes_setkey,
-				.encrypt	= mxs_dcp_aes_cbc_encrypt,
-				.decrypt	= mxs_dcp_aes_cbc_decrypt,
-				.ivsize		= AES_BLOCK_SIZE,
-			},
-		},
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.setkey			= mxs_dcp_aes_setkey,
+		.encrypt		= mxs_dcp_aes_cbc_encrypt,
+		.decrypt		= mxs_dcp_aes_cbc_decrypt,
+		.ivsize			= AES_BLOCK_SIZE,
+		.init			= mxs_dcp_aes_fallback_init_tfm,
+		.exit			= mxs_dcp_aes_fallback_exit_tfm,
 	},
 };
 
@@ -1104,8 +1094,8 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	sdcp->caps = readl(sdcp->base + MXS_DCP_CAPABILITY1);
 
 	if (sdcp->caps & MXS_DCP_CAPABILITY1_AES128) {
-		ret = crypto_register_algs(dcp_aes_algs,
-					   ARRAY_SIZE(dcp_aes_algs));
+		ret = crypto_register_skciphers(dcp_aes_algs,
+						ARRAY_SIZE(dcp_aes_algs));
 		if (ret) {
 			/* Failed to register algorithm. */
 			dev_err(dev, "Failed to register AES crypto!\n");
@@ -1139,7 +1129,7 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 
 err_unregister_aes:
 	if (sdcp->caps & MXS_DCP_CAPABILITY1_AES128)
-		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
+		crypto_unregister_skciphers(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
 
 err_destroy_aes_thread:
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
@@ -1164,7 +1154,7 @@ static int mxs_dcp_remove(struct platform_device *pdev)
 		crypto_unregister_ahash(&dcp_sha1_alg);
 
 	if (sdcp->caps & MXS_DCP_CAPABILITY1_AES128)
-		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
+		crypto_unregister_skciphers(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
 
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
-- 
2.20.1

