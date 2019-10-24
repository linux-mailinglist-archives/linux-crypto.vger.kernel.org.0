Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA8E3405
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Oct 2019 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbfJXNYb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Oct 2019 09:24:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53573 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393564AbfJXNYb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Oct 2019 09:24:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id n7so2007967wmc.3
        for <linux-crypto@vger.kernel.org>; Thu, 24 Oct 2019 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2guTtZQNpFmVRb5THlXvx+Ph/1cQAsy90V4CVYSsag=;
        b=nCeNNwhnfQKyLswrzwpba3mA3U6yVfyGX6WdvSfLEHcHYWXazli+FyVa05jZzJYyLO
         6JWe+MPWL5gBTM4EgtH43iWvkXaiKfVQmTgGBKdmKmF5tCiEEF/2h3XhidOTfsN5yjzX
         rNyBr8jMlYcudlTrMfqZZUZpXHIMa1beoisjiXVY/cAmVhv/JYN33htFS9pgQM8AzHPU
         2pgCAfdkdEHZyVFwNVyScU1AbE/r34htkn2QkSkcOpxT4iHu3oQGKD34yLIcnH5ByegS
         3v73E5ryqSJTeHa0aCE4zrGhT/rymB+yC9xcu46TnBUjU0zDfOPiSHZ6oAcAVxE7Osiy
         YtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2guTtZQNpFmVRb5THlXvx+Ph/1cQAsy90V4CVYSsag=;
        b=leA7YZY/YlOgrbjqaphemAd9lfI3Co5TJoZKVWD17kIWKk7o5lzLITZNAyd+UkL2Rk
         G2xKkJ4Srxz92idgnhzBiej7WPwp9eCAS55ICCxL9T8GlucbIHfh4IR8X1mkOSdYKnrf
         Gl3l99JbUd7yjrOrGLCVRB9kU3zMEb873L0+k8dwuHlaz7imqu+m2GfJbYcJkBRI2jix
         cw3qCGvvkC6DszwO26tEA4WflE6P/wlGYipF9xrVMd/tGamIBE1+8UI7c9tMFEhCtuY8
         MMRfRozhnF78U0jUdy2EX9EErtNdqA5FL7Nx+M3c/2hrIWV7cQ0RsTbL+zxj4umi5NLq
         URsw==
X-Gm-Message-State: APjAAAWOY0Yl9akcDgOx1AN/j7j8JFei1Hzlg6RXIMs3jNcVEHktpGR0
        68FyIgaCfs9yi0HjGmmxpE6p/sVH21jp08C6
X-Google-Smtp-Source: APXvYqxyS3DWGdWwGtlflO2EVB07GqBuSHK5MeOC2wl+H0T9ELOhLvu+VCdoiM1IVrHi8ReqTc3YkQ==
X-Received: by 2002:a7b:c4cf:: with SMTP id g15mr4622410wmk.122.1571923466064;
        Thu, 24 Oct 2019 06:24:26 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id e3sm2346310wme.36.2019.10.24.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:24:25 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 23/27] crypto: rockchip - switch to skcipher API
Date:   Thu, 24 Oct 2019 15:23:41 +0200
Message-Id: <20191024132345.5236-24-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
References: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
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

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/rockchip/Makefile                   |   2 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   8 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |   3 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c | 556 --------------------
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   | 538 +++++++++++++++++++
 5 files changed, 545 insertions(+), 562 deletions(-)

diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/Makefile
index 6e23764e6c8a..785277aca71e 100644
--- a/drivers/crypto/rockchip/Makefile
+++ b/drivers/crypto/rockchip/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) += rk_crypto.o
 rk_crypto-objs := rk3288_crypto.o \
-		  rk3288_crypto_ablkcipher.o \
+		  rk3288_crypto_skcipher.o \
 		  rk3288_crypto_ahash.o
diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index e5714ef24bf2..f385587f99af 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -264,8 +264,8 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		rk_cipher_algs[i]->dev = crypto_info;
 		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
-			err = crypto_register_alg(
-					&rk_cipher_algs[i]->alg.crypto);
+			err = crypto_register_skcipher(
+					&rk_cipher_algs[i]->alg.skcipher);
 		else
 			err = crypto_register_ahash(
 					&rk_cipher_algs[i]->alg.hash);
@@ -277,7 +277,7 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 err_cipher_algs:
 	for (k = 0; k < i; k++) {
 		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
-			crypto_unregister_alg(&rk_cipher_algs[k]->alg.crypto);
+			crypto_unregister_skcipher(&rk_cipher_algs[k]->alg.skcipher);
 		else
 			crypto_unregister_ahash(&rk_cipher_algs[i]->alg.hash);
 	}
@@ -290,7 +290,7 @@ static void rk_crypto_unregister(void)
 
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
-			crypto_unregister_alg(&rk_cipher_algs[i]->alg.crypto);
+			crypto_unregister_skcipher(&rk_cipher_algs[i]->alg.skcipher);
 		else
 			crypto_unregister_ahash(&rk_cipher_algs[i]->alg.hash);
 	}
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 18e2b3f29336..2b49c677afdb 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <crypto/internal/hash.h>
+#include <crypto/internal/skcipher.h>
 
 #include <crypto/md5.h>
 #include <crypto/sha.h>
@@ -256,7 +257,7 @@ enum alg_type {
 struct rk_crypto_tmp {
 	struct rk_crypto_info		*dev;
 	union {
-		struct crypto_alg	crypto;
+		struct skcipher_alg	skcipher;
 		struct ahash_alg	hash;
 	} alg;
 	enum alg_type			type;
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c b/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
deleted file mode 100644
index d0f4b2d18059..000000000000
--- a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
+++ /dev/null
@@ -1,556 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Crypto acceleration support for Rockchip RK3288
- *
- * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
- *
- * Author: Zain Wang <zain.wang@rock-chips.com>
- *
- * Some ideas are from marvell-cesa.c and s5p-sss.c driver.
- */
-#include "rk3288_crypto.h"
-
-#define RK_CRYPTO_DEC			BIT(0)
-
-static void rk_crypto_complete(struct crypto_async_request *base, int err)
-{
-	if (base->complete)
-		base->complete(base, err);
-}
-
-static int rk_handle_req(struct rk_crypto_info *dev,
-			 struct ablkcipher_request *req)
-{
-	if (!IS_ALIGNED(req->nbytes, dev->align_size))
-		return -EINVAL;
-	else
-		return dev->enqueue(dev, &req->base);
-}
-
-static int rk_aes_setkey(struct crypto_ablkcipher *cipher,
-			 const u8 *key, unsigned int keylen)
-{
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
-	    keylen != AES_KEYSIZE_256) {
-		crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
-		return -EINVAL;
-	}
-	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, key, keylen);
-	return 0;
-}
-
-static int rk_des_setkey(struct crypto_ablkcipher *cipher,
-			 const u8 *key, unsigned int keylen)
-{
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(cipher);
-	int err;
-
-	err = verify_ablkcipher_des_key(cipher, key);
-	if (err)
-		return err;
-
-	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
-	return 0;
-}
-
-static int rk_tdes_setkey(struct crypto_ablkcipher *cipher,
-			  const u8 *key, unsigned int keylen)
-{
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(cipher);
-	int err;
-
-	err = verify_ablkcipher_des3_key(cipher, key);
-	if (err)
-		return err;
-
-	ctx->keylen = keylen;
-	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
-	return 0;
-}
-
-static int rk_aes_ecb_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_AES_ECB_MODE;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_aes_ecb_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_aes_cbc_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_AES_CBC_MODE;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_aes_cbc_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des_ecb_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = 0;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des_ecb_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des_cbc_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des_cbc_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des3_ede_ecb_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_SELECT;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des3_ede_ecb_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des3_ede_cbc_encrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC;
-	return rk_handle_req(dev, req);
-}
-
-static int rk_des3_ede_cbc_decrypt(struct ablkcipher_request *req)
-{
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	struct rk_crypto_info *dev = ctx->dev;
-
-	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC |
-		    RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
-}
-
-static void rk_ablk_hw_init(struct rk_crypto_info *dev)
-{
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-	struct crypto_ablkcipher *cipher = crypto_ablkcipher_reqtfm(req);
-	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(cipher);
-	u32 ivsize, block, conf_reg = 0;
-
-	block = crypto_tfm_alg_blocksize(tfm);
-	ivsize = crypto_ablkcipher_ivsize(cipher);
-
-	if (block == DES_BLOCK_SIZE) {
-		ctx->mode |= RK_CRYPTO_TDES_FIFO_MODE |
-			     RK_CRYPTO_TDES_BYTESWAP_KEY |
-			     RK_CRYPTO_TDES_BYTESWAP_IV;
-		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, ctx->mode);
-		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, req->info, ivsize);
-		conf_reg = RK_CRYPTO_DESSEL;
-	} else {
-		ctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
-			     RK_CRYPTO_AES_KEY_CHANGE |
-			     RK_CRYPTO_AES_BYTESWAP_KEY |
-			     RK_CRYPTO_AES_BYTESWAP_IV;
-		if (ctx->keylen == AES_KEYSIZE_192)
-			ctx->mode |= RK_CRYPTO_AES_192BIT_key;
-		else if (ctx->keylen == AES_KEYSIZE_256)
-			ctx->mode |= RK_CRYPTO_AES_256BIT_key;
-		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, ctx->mode);
-		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, req->info, ivsize);
-	}
-	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
-		    RK_CRYPTO_BYTESWAP_BRFIFO;
-	CRYPTO_WRITE(dev, RK_CRYPTO_CONF, conf_reg);
-	CRYPTO_WRITE(dev, RK_CRYPTO_INTENA,
-		     RK_CRYPTO_BCDMA_ERR_ENA | RK_CRYPTO_BCDMA_DONE_ENA);
-}
-
-static void crypto_dma_start(struct rk_crypto_info *dev)
-{
-	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAS, dev->addr_in);
-	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAL, dev->count / 4);
-	CRYPTO_WRITE(dev, RK_CRYPTO_BTDMAS, dev->addr_out);
-	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, RK_CRYPTO_BLOCK_START |
-		     _SBF(RK_CRYPTO_BLOCK_START, 16));
-}
-
-static int rk_set_data_start(struct rk_crypto_info *dev)
-{
-	int err;
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	u32 ivsize = crypto_ablkcipher_ivsize(tfm);
-	u8 *src_last_blk = page_address(sg_page(dev->sg_src)) +
-		dev->sg_src->offset + dev->sg_src->length - ivsize;
-
-	/* Store the iv that need to be updated in chain mode.
-	 * And update the IV buffer to contain the next IV for decryption mode.
-	 */
-	if (ctx->mode & RK_CRYPTO_DEC) {
-		memcpy(ctx->iv, src_last_blk, ivsize);
-		sg_pcopy_to_buffer(dev->first, dev->src_nents, req->info,
-				   ivsize, dev->total - ivsize);
-	}
-
-	err = dev->load_data(dev, dev->sg_src, dev->sg_dst);
-	if (!err)
-		crypto_dma_start(dev);
-	return err;
-}
-
-static int rk_ablk_start(struct rk_crypto_info *dev)
-{
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-	unsigned long flags;
-	int err = 0;
-
-	dev->left_bytes = req->nbytes;
-	dev->total = req->nbytes;
-	dev->sg_src = req->src;
-	dev->first = req->src;
-	dev->src_nents = sg_nents(req->src);
-	dev->sg_dst = req->dst;
-	dev->dst_nents = sg_nents(req->dst);
-	dev->aligned = 1;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	rk_ablk_hw_init(dev);
-	err = rk_set_data_start(dev);
-	spin_unlock_irqrestore(&dev->lock, flags);
-	return err;
-}
-
-static void rk_iv_copyback(struct rk_crypto_info *dev)
-{
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	u32 ivsize = crypto_ablkcipher_ivsize(tfm);
-
-	/* Update the IV buffer to contain the next IV for encryption mode. */
-	if (!(ctx->mode & RK_CRYPTO_DEC)) {
-		if (dev->aligned) {
-			memcpy(req->info, sg_virt(dev->sg_dst) +
-				dev->sg_dst->length - ivsize, ivsize);
-		} else {
-			memcpy(req->info, dev->addr_vir +
-				dev->count - ivsize, ivsize);
-		}
-	}
-}
-
-static void rk_update_iv(struct rk_crypto_info *dev)
-{
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	u32 ivsize = crypto_ablkcipher_ivsize(tfm);
-	u8 *new_iv = NULL;
-
-	if (ctx->mode & RK_CRYPTO_DEC) {
-		new_iv = ctx->iv;
-	} else {
-		new_iv = page_address(sg_page(dev->sg_dst)) +
-			 dev->sg_dst->offset + dev->sg_dst->length - ivsize;
-	}
-
-	if (ivsize == DES_BLOCK_SIZE)
-		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, new_iv, ivsize);
-	else if (ivsize == AES_BLOCK_SIZE)
-		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, new_iv, ivsize);
-}
-
-/* return:
- *	true	some err was occurred
- *	fault	no err, continue
- */
-static int rk_ablk_rx(struct rk_crypto_info *dev)
-{
-	int err = 0;
-	struct ablkcipher_request *req =
-		ablkcipher_request_cast(dev->async_req);
-
-	dev->unload_data(dev);
-	if (!dev->aligned) {
-		if (!sg_pcopy_from_buffer(req->dst, dev->dst_nents,
-					  dev->addr_vir, dev->count,
-					  dev->total - dev->left_bytes -
-					  dev->count)) {
-			err = -EINVAL;
-			goto out_rx;
-		}
-	}
-	if (dev->left_bytes) {
-		rk_update_iv(dev);
-		if (dev->aligned) {
-			if (sg_is_last(dev->sg_src)) {
-				dev_err(dev->dev, "[%s:%d] Lack of data\n",
-					__func__, __LINE__);
-				err = -ENOMEM;
-				goto out_rx;
-			}
-			dev->sg_src = sg_next(dev->sg_src);
-			dev->sg_dst = sg_next(dev->sg_dst);
-		}
-		err = rk_set_data_start(dev);
-	} else {
-		rk_iv_copyback(dev);
-		/* here show the calculation is over without any err */
-		dev->complete(dev->async_req, 0);
-		tasklet_schedule(&dev->queue_task);
-	}
-out_rx:
-	return err;
-}
-
-static int rk_ablk_cra_init(struct crypto_tfm *tfm)
-{
-	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct crypto_alg *alg = tfm->__crt_alg;
-	struct rk_crypto_tmp *algt;
-
-	algt = container_of(alg, struct rk_crypto_tmp, alg.crypto);
-
-	ctx->dev = algt->dev;
-	ctx->dev->align_size = crypto_tfm_alg_alignmask(tfm) + 1;
-	ctx->dev->start = rk_ablk_start;
-	ctx->dev->update = rk_ablk_rx;
-	ctx->dev->complete = rk_crypto_complete;
-	ctx->dev->addr_vir = (char *)__get_free_page(GFP_KERNEL);
-
-	return ctx->dev->addr_vir ? ctx->dev->enable_clk(ctx->dev) : -ENOMEM;
-}
-
-static void rk_ablk_cra_exit(struct crypto_tfm *tfm)
-{
-	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	free_page((unsigned long)ctx->dev->addr_vir);
-	ctx->dev->disable_clk(ctx->dev);
-}
-
-struct rk_crypto_tmp rk_ecb_aes_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "ecb(aes)",
-		.cra_driver_name	= "ecb-aes-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= AES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x0f,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= AES_MIN_KEY_SIZE,
-			.max_keysize	= AES_MAX_KEY_SIZE,
-			.setkey		= rk_aes_setkey,
-			.encrypt	= rk_aes_ecb_encrypt,
-			.decrypt	= rk_aes_ecb_decrypt,
-		}
-	}
-};
-
-struct rk_crypto_tmp rk_cbc_aes_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "cbc(aes)",
-		.cra_driver_name	= "cbc-aes-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= AES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x0f,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= AES_MIN_KEY_SIZE,
-			.max_keysize	= AES_MAX_KEY_SIZE,
-			.ivsize		= AES_BLOCK_SIZE,
-			.setkey		= rk_aes_setkey,
-			.encrypt	= rk_aes_cbc_encrypt,
-			.decrypt	= rk_aes_cbc_decrypt,
-		}
-	}
-};
-
-struct rk_crypto_tmp rk_ecb_des_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "ecb(des)",
-		.cra_driver_name	= "ecb-des-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= DES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x07,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= DES_KEY_SIZE,
-			.max_keysize	= DES_KEY_SIZE,
-			.setkey		= rk_des_setkey,
-			.encrypt	= rk_des_ecb_encrypt,
-			.decrypt	= rk_des_ecb_decrypt,
-		}
-	}
-};
-
-struct rk_crypto_tmp rk_cbc_des_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "cbc(des)",
-		.cra_driver_name	= "cbc-des-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= DES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x07,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= DES_KEY_SIZE,
-			.max_keysize	= DES_KEY_SIZE,
-			.ivsize		= DES_BLOCK_SIZE,
-			.setkey		= rk_des_setkey,
-			.encrypt	= rk_des_cbc_encrypt,
-			.decrypt	= rk_des_cbc_decrypt,
-		}
-	}
-};
-
-struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "ecb(des3_ede)",
-		.cra_driver_name	= "ecb-des3-ede-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= DES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x07,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= DES3_EDE_KEY_SIZE,
-			.max_keysize	= DES3_EDE_KEY_SIZE,
-			.ivsize		= DES_BLOCK_SIZE,
-			.setkey		= rk_tdes_setkey,
-			.encrypt	= rk_des3_ede_ecb_encrypt,
-			.decrypt	= rk_des3_ede_ecb_decrypt,
-		}
-	}
-};
-
-struct rk_crypto_tmp rk_cbc_des3_ede_alg = {
-	.type = ALG_TYPE_CIPHER,
-	.alg.crypto = {
-		.cra_name		= "cbc(des3_ede)",
-		.cra_driver_name	= "cbc-des3-ede-rk",
-		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
-					  CRYPTO_ALG_ASYNC,
-		.cra_blocksize		= DES_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct rk_cipher_ctx),
-		.cra_alignmask		= 0x07,
-		.cra_type		= &crypto_ablkcipher_type,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= rk_ablk_cra_init,
-		.cra_exit		= rk_ablk_cra_exit,
-		.cra_u.ablkcipher	= {
-			.min_keysize	= DES3_EDE_KEY_SIZE,
-			.max_keysize	= DES3_EDE_KEY_SIZE,
-			.ivsize		= DES_BLOCK_SIZE,
-			.setkey		= rk_tdes_setkey,
-			.encrypt	= rk_des3_ede_cbc_encrypt,
-			.decrypt	= rk_des3_ede_cbc_decrypt,
-		}
-	}
-};
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
new file mode 100644
index 000000000000..ca4de4ddfe1f
--- /dev/null
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Crypto acceleration support for Rockchip RK3288
+ *
+ * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Zain Wang <zain.wang@rock-chips.com>
+ *
+ * Some ideas are from marvell-cesa.c and s5p-sss.c driver.
+ */
+#include "rk3288_crypto.h"
+
+#define RK_CRYPTO_DEC			BIT(0)
+
+static void rk_crypto_complete(struct crypto_async_request *base, int err)
+{
+	if (base->complete)
+		base->complete(base, err);
+}
+
+static int rk_handle_req(struct rk_crypto_info *dev,
+			 struct skcipher_request *req)
+{
+	if (!IS_ALIGNED(req->cryptlen, dev->align_size))
+		return -EINVAL;
+	else
+		return dev->enqueue(dev, &req->base);
+}
+
+static int rk_aes_setkey(struct crypto_skcipher *cipher,
+			 const u8 *key, unsigned int keylen)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_192 &&
+	    keylen != AES_KEYSIZE_256) {
+		crypto_skcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+	ctx->keylen = keylen;
+	memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, key, keylen);
+	return 0;
+}
+
+static int rk_des_setkey(struct crypto_skcipher *cipher,
+			 const u8 *key, unsigned int keylen)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	int err;
+
+	err = verify_skcipher_des_key(cipher, key);
+	if (err)
+		return err;
+
+	ctx->keylen = keylen;
+	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	return 0;
+}
+
+static int rk_tdes_setkey(struct crypto_skcipher *cipher,
+			  const u8 *key, unsigned int keylen)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	int err;
+
+	err = verify_skcipher_des3_key(cipher, key);
+	if (err)
+		return err;
+
+	ctx->keylen = keylen;
+	memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, key, keylen);
+	return 0;
+}
+
+static int rk_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_AES_ECB_MODE;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_AES_CBC_MODE;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des_ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = 0;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des_ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des_cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des_cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC | RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des3_ede_ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_SELECT;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des3_ede_ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des3_ede_cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC;
+	return rk_handle_req(dev, req);
+}
+
+static int rk_des3_ede_cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *dev = ctx->dev;
+
+	ctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC |
+		    RK_CRYPTO_DEC;
+	return rk_handle_req(dev, req);
+}
+
+static void rk_ablk_hw_init(struct rk_crypto_info *dev)
+{
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
+	u32 ivsize, block, conf_reg = 0;
+
+	block = crypto_tfm_alg_blocksize(tfm);
+	ivsize = crypto_skcipher_ivsize(cipher);
+
+	if (block == DES_BLOCK_SIZE) {
+		ctx->mode |= RK_CRYPTO_TDES_FIFO_MODE |
+			     RK_CRYPTO_TDES_BYTESWAP_KEY |
+			     RK_CRYPTO_TDES_BYTESWAP_IV;
+		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, ctx->mode);
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, req->iv, ivsize);
+		conf_reg = RK_CRYPTO_DESSEL;
+	} else {
+		ctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
+			     RK_CRYPTO_AES_KEY_CHANGE |
+			     RK_CRYPTO_AES_BYTESWAP_KEY |
+			     RK_CRYPTO_AES_BYTESWAP_IV;
+		if (ctx->keylen == AES_KEYSIZE_192)
+			ctx->mode |= RK_CRYPTO_AES_192BIT_key;
+		else if (ctx->keylen == AES_KEYSIZE_256)
+			ctx->mode |= RK_CRYPTO_AES_256BIT_key;
+		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, ctx->mode);
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, req->iv, ivsize);
+	}
+	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
+		    RK_CRYPTO_BYTESWAP_BRFIFO;
+	CRYPTO_WRITE(dev, RK_CRYPTO_CONF, conf_reg);
+	CRYPTO_WRITE(dev, RK_CRYPTO_INTENA,
+		     RK_CRYPTO_BCDMA_ERR_ENA | RK_CRYPTO_BCDMA_DONE_ENA);
+}
+
+static void crypto_dma_start(struct rk_crypto_info *dev)
+{
+	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAS, dev->addr_in);
+	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAL, dev->count / 4);
+	CRYPTO_WRITE(dev, RK_CRYPTO_BTDMAS, dev->addr_out);
+	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, RK_CRYPTO_BLOCK_START |
+		     _SBF(RK_CRYPTO_BLOCK_START, 16));
+}
+
+static int rk_set_data_start(struct rk_crypto_info *dev)
+{
+	int err;
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	u32 ivsize = crypto_skcipher_ivsize(tfm);
+	u8 *src_last_blk = page_address(sg_page(dev->sg_src)) +
+		dev->sg_src->offset + dev->sg_src->length - ivsize;
+
+	/* Store the iv that need to be updated in chain mode.
+	 * And update the IV buffer to contain the next IV for decryption mode.
+	 */
+	if (ctx->mode & RK_CRYPTO_DEC) {
+		memcpy(ctx->iv, src_last_blk, ivsize);
+		sg_pcopy_to_buffer(dev->first, dev->src_nents, req->iv,
+				   ivsize, dev->total - ivsize);
+	}
+
+	err = dev->load_data(dev, dev->sg_src, dev->sg_dst);
+	if (!err)
+		crypto_dma_start(dev);
+	return err;
+}
+
+static int rk_ablk_start(struct rk_crypto_info *dev)
+{
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+	unsigned long flags;
+	int err = 0;
+
+	dev->left_bytes = req->cryptlen;
+	dev->total = req->cryptlen;
+	dev->sg_src = req->src;
+	dev->first = req->src;
+	dev->src_nents = sg_nents(req->src);
+	dev->sg_dst = req->dst;
+	dev->dst_nents = sg_nents(req->dst);
+	dev->aligned = 1;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	rk_ablk_hw_init(dev);
+	err = rk_set_data_start(dev);
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return err;
+}
+
+static void rk_iv_copyback(struct rk_crypto_info *dev)
+{
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	u32 ivsize = crypto_skcipher_ivsize(tfm);
+
+	/* Update the IV buffer to contain the next IV for encryption mode. */
+	if (!(ctx->mode & RK_CRYPTO_DEC)) {
+		if (dev->aligned) {
+			memcpy(req->iv, sg_virt(dev->sg_dst) +
+				dev->sg_dst->length - ivsize, ivsize);
+		} else {
+			memcpy(req->iv, dev->addr_vir +
+				dev->count - ivsize, ivsize);
+		}
+	}
+}
+
+static void rk_update_iv(struct rk_crypto_info *dev)
+{
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	u32 ivsize = crypto_skcipher_ivsize(tfm);
+	u8 *new_iv = NULL;
+
+	if (ctx->mode & RK_CRYPTO_DEC) {
+		new_iv = ctx->iv;
+	} else {
+		new_iv = page_address(sg_page(dev->sg_dst)) +
+			 dev->sg_dst->offset + dev->sg_dst->length - ivsize;
+	}
+
+	if (ivsize == DES_BLOCK_SIZE)
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, new_iv, ivsize);
+	else if (ivsize == AES_BLOCK_SIZE)
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, new_iv, ivsize);
+}
+
+/* return:
+ *	true	some err was occurred
+ *	fault	no err, continue
+ */
+static int rk_ablk_rx(struct rk_crypto_info *dev)
+{
+	int err = 0;
+	struct skcipher_request *req =
+		skcipher_request_cast(dev->async_req);
+
+	dev->unload_data(dev);
+	if (!dev->aligned) {
+		if (!sg_pcopy_from_buffer(req->dst, dev->dst_nents,
+					  dev->addr_vir, dev->count,
+					  dev->total - dev->left_bytes -
+					  dev->count)) {
+			err = -EINVAL;
+			goto out_rx;
+		}
+	}
+	if (dev->left_bytes) {
+		rk_update_iv(dev);
+		if (dev->aligned) {
+			if (sg_is_last(dev->sg_src)) {
+				dev_err(dev->dev, "[%s:%d] Lack of data\n",
+					__func__, __LINE__);
+				err = -ENOMEM;
+				goto out_rx;
+			}
+			dev->sg_src = sg_next(dev->sg_src);
+			dev->sg_dst = sg_next(dev->sg_dst);
+		}
+		err = rk_set_data_start(dev);
+	} else {
+		rk_iv_copyback(dev);
+		/* here show the calculation is over without any err */
+		dev->complete(dev->async_req, 0);
+		tasklet_schedule(&dev->queue_task);
+	}
+out_rx:
+	return err;
+}
+
+static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_tmp *algt;
+
+	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
+
+	ctx->dev = algt->dev;
+	ctx->dev->align_size = crypto_tfm_alg_alignmask(crypto_skcipher_tfm(tfm)) + 1;
+	ctx->dev->start = rk_ablk_start;
+	ctx->dev->update = rk_ablk_rx;
+	ctx->dev->complete = rk_crypto_complete;
+	ctx->dev->addr_vir = (char *)__get_free_page(GFP_KERNEL);
+
+	return ctx->dev->addr_vir ? ctx->dev->enable_clk(ctx->dev) : -ENOMEM;
+}
+
+static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	free_page((unsigned long)ctx->dev->addr_vir);
+	ctx->dev->disable_clk(ctx->dev);
+}
+
+struct rk_crypto_tmp rk_ecb_aes_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "ecb(aes)",
+		.base.cra_driver_name	= "ecb-aes-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x0f,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.setkey			= rk_aes_setkey,
+		.encrypt		= rk_aes_ecb_encrypt,
+		.decrypt		= rk_aes_ecb_decrypt,
+	}
+};
+
+struct rk_crypto_tmp rk_cbc_aes_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "cbc(aes)",
+		.base.cra_driver_name	= "cbc-aes-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= AES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x0f,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= AES_MIN_KEY_SIZE,
+		.max_keysize		= AES_MAX_KEY_SIZE,
+		.ivsize			= AES_BLOCK_SIZE,
+		.setkey			= rk_aes_setkey,
+		.encrypt		= rk_aes_cbc_encrypt,
+		.decrypt		= rk_aes_cbc_decrypt,
+	}
+};
+
+struct rk_crypto_tmp rk_ecb_des_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "ecb(des)",
+		.base.cra_driver_name	= "ecb-des-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x07,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= DES_KEY_SIZE,
+		.max_keysize		= DES_KEY_SIZE,
+		.setkey			= rk_des_setkey,
+		.encrypt		= rk_des_ecb_encrypt,
+		.decrypt		= rk_des_ecb_decrypt,
+	}
+};
+
+struct rk_crypto_tmp rk_cbc_des_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "cbc(des)",
+		.base.cra_driver_name	= "cbc-des-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x07,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= DES_KEY_SIZE,
+		.max_keysize		= DES_KEY_SIZE,
+		.ivsize			= DES_BLOCK_SIZE,
+		.setkey			= rk_des_setkey,
+		.encrypt		= rk_des_cbc_encrypt,
+		.decrypt		= rk_des_cbc_decrypt,
+	}
+};
+
+struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "ecb(des3_ede)",
+		.base.cra_driver_name	= "ecb-des3-ede-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x07,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= DES3_EDE_KEY_SIZE,
+		.max_keysize		= DES3_EDE_KEY_SIZE,
+		.ivsize			= DES_BLOCK_SIZE,
+		.setkey			= rk_tdes_setkey,
+		.encrypt		= rk_des3_ede_ecb_encrypt,
+		.decrypt		= rk_des3_ede_ecb_decrypt,
+	}
+};
+
+struct rk_crypto_tmp rk_cbc_des3_ede_alg = {
+	.type = ALG_TYPE_CIPHER,
+	.alg.skcipher = {
+		.base.cra_name		= "cbc(des3_ede)",
+		.base.cra_driver_name	= "cbc-des3-ede-rk",
+		.base.cra_priority	= 300,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_blocksize	= DES_BLOCK_SIZE,
+		.base.cra_ctxsize	= sizeof(struct rk_cipher_ctx),
+		.base.cra_alignmask	= 0x07,
+		.base.cra_module	= THIS_MODULE,
+
+		.init			= rk_ablk_init_tfm,
+		.exit			= rk_ablk_exit_tfm,
+		.min_keysize		= DES3_EDE_KEY_SIZE,
+		.max_keysize		= DES3_EDE_KEY_SIZE,
+		.ivsize			= DES_BLOCK_SIZE,
+		.setkey			= rk_tdes_setkey,
+		.encrypt		= rk_des3_ede_cbc_encrypt,
+		.decrypt		= rk_des3_ede_cbc_decrypt,
+	}
+};
-- 
2.20.1

