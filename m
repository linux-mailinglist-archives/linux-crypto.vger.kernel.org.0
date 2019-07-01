Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00227868
	for <lists+linux-crypto@lfdr.de>; Thu, 23 May 2019 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWIuj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 May 2019 04:50:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWIui (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 May 2019 04:50:38 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hTjQq-0002wz-Rm; Thu, 23 May 2019 10:50:36 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hTjQq-0001fO-6z; Thu, 23 May 2019 10:50:36 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-crypto@vger.kernel.org
Cc:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] crypto: caam: print debug messages at debug level
Date:   Thu, 23 May 2019 10:50:29 +0200
Message-Id: <20190523085030.4969-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523085030.4969-1-s.hauer@pengutronix.de>
References: <20190523085030.4969-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The CAAM driver used to put its debug messages inside #ifdef DEBUG and
then prints the messages at KERN_ERR level. Replace this with proper
functions printing at KERN_DEBUG level. The #ifdef DEBUG gets
unnecessary when the right functions are used.

This replaces:

- print_hex_dump(KERN_ERR ...) inside #ifdef DEBUG with
  print_hex_dump_debug(...)
- dev_err() inside #ifdef DEBUG with dev_dbg()
- printk(KERN_ERR ...) inside #ifdef DEBUG with dev_dbg()

Some parts of the driver use these functions already, so it is only
consequent to use the debug function consistently.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/crypto/caam/caamalg.c      | 145 ++++++++-----------
 drivers/crypto/caam/caamalg_desc.c | 116 ++++++---------
 drivers/crypto/caam/caamalg_qi.c   |  54 +++----
 drivers/crypto/caam/caamhash.c     | 225 ++++++++++++-----------------
 drivers/crypto/caam/caamrng.c      |  22 ++-
 drivers/crypto/caam/key_gen.c      |  28 ++--
 drivers/crypto/caam/sg_sw_sec4.h   |   8 +-
 7 files changed, 240 insertions(+), 358 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index fb2994f3b18f..30fed464fb3f 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -576,13 +576,11 @@ static int aead_setkey(struct crypto_aead *aead,
 	if (crypto_authenc_extractkeys(&keys, key, keylen) != 0)
 		goto badkey;
 
-#ifdef DEBUG
-	printk(KERN_ERR "keylen %d enckeylen %d authkeylen %d\n",
+	dev_dbg(jrdev, "keylen %d enckeylen %d authkeylen %d\n",
 	       keys.authkeylen + keys.enckeylen, keys.enckeylen,
 	       keys.authkeylen);
-	print_hex_dump(KERN_ERR, "key in @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	/*
 	 * If DKP is supported, use it in the shared descriptor to generate
@@ -616,11 +614,10 @@ static int aead_setkey(struct crypto_aead *aead,
 	memcpy(ctx->key + ctx->adata.keylen_pad, keys.enckey, keys.enckeylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, ctx->adata.keylen_pad +
 				   keys.enckeylen, ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx.key@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-		       ctx->adata.keylen_pad + keys.enckeylen, 1);
-#endif
+
+	print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
+			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
 skip_split_key:
 	ctx->cdata.keylen = keys.enckeylen;
@@ -671,10 +668,8 @@ static int gcm_setkey(struct crypto_aead *aead,
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, keylen, ctx->dir);
@@ -692,10 +687,8 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	if (keylen < 4)
 		return -EINVAL;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 
@@ -718,10 +711,8 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	if (keylen < 4)
 		return -EINVAL;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 
@@ -750,10 +741,8 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			       OP_ALG_AAI_CTR_MOD128);
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 	/*
 	 * AES-CTR needs to load IV in CONTEXT1 reg
 	 * at an offset of 128bits (16bytes)
@@ -942,9 +931,7 @@ static void aead_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct aead_request *req = context;
 	struct aead_edesc *edesc;
 
-#ifdef DEBUG
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
 
@@ -964,9 +951,7 @@ static void aead_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct aead_request *req = context;
 	struct aead_edesc *edesc;
 
-#ifdef DEBUG
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
 
@@ -994,21 +979,18 @@ static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 
-#ifdef DEBUG
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
 
 	if (err)
 		caam_jr_strstatus(jrdev, err);
 
-#ifdef DEBUG
 	if (ivsize)
-		print_hex_dump(KERN_ERR, "dstiv  @"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-			       edesc->src_nents > 1 ? 100 : ivsize, 1);
-#endif
+		print_hex_dump_debug("dstiv  @"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
+				     edesc->src_nents > 1 ? 100 : ivsize, 1);
+
 	caam_dump_sg(KERN_ERR, "dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
@@ -1033,21 +1015,17 @@ static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 {
 	struct skcipher_request *req = context;
 	struct skcipher_edesc *edesc;
-#ifdef DEBUG
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
 	if (err)
 		caam_jr_strstatus(jrdev, err);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "dstiv  @"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize, 1);
-#endif
+	print_hex_dump_debug("dstiv  @"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize, 1);
 	caam_dump_sg(KERN_ERR, "dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
@@ -1243,6 +1221,7 @@ static void init_skcipher_job(struct skcipher_request *req,
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct device *jrdev = ctx->jrdev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc = edesc->hw_desc;
 	u32 *sh_desc;
@@ -1250,12 +1229,11 @@ static void init_skcipher_job(struct skcipher_request *req,
 	dma_addr_t src_dma, dst_dma, ptr;
 	int len, sec4_sg_index = 0;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "presciv@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize, 1);
-	pr_err("asked=%d, cryptlen%d\n",
+	print_hex_dump_debug("presciv@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize, 1);
+	dev_dbg(jrdev, "asked=%d, cryptlen%d\n",
 	       (int)edesc->src_nents > 1 ? 100 : req->cryptlen, req->cryptlen);
-#endif
+
 	caam_dump_sg(KERN_ERR, "src    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->src,
 		     edesc->src_nents > 1 ? 100 : req->cryptlen, 1);
@@ -1440,11 +1418,10 @@ static int gcm_encrypt(struct aead_request *req)
 
 	/* Create and submit job descriptor */
 	init_gcm_job(req, edesc, all_contig, true);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
 	ret = caam_jr_enqueue(jrdev, desc, aead_encrypt_done, req);
@@ -1550,11 +1527,10 @@ static int aead_encrypt(struct aead_request *req)
 
 	/* Create and submit job descriptor */
 	init_authenc_job(req, edesc, all_contig, true);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
 	ret = caam_jr_enqueue(jrdev, desc, aead_encrypt_done, req);
@@ -1585,11 +1561,10 @@ static int gcm_decrypt(struct aead_request *req)
 
 	/* Create and submit job descriptor*/
 	init_gcm_job(req, edesc, all_contig, false);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
 	ret = caam_jr_enqueue(jrdev, desc, aead_decrypt_done, req);
@@ -1633,11 +1608,10 @@ static int aead_decrypt(struct aead_request *req)
 
 	/* Create and submit job descriptor*/
 	init_authenc_job(req, edesc, all_contig, false);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
 	ret = caam_jr_enqueue(jrdev, desc, aead_decrypt_done, req);
@@ -1776,11 +1750,9 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 
 	edesc->iv_dma = iv_dma;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "skcipher sec4_sg@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->sec4_sg,
-		       sec4_sg_bytes, 1);
-#endif
+	print_hex_dump_debug("skcipher sec4_sg@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->sec4_sg,
+			     sec4_sg_bytes, 1);
 
 	return edesc;
 }
@@ -1801,11 +1773,11 @@ static int skcipher_encrypt(struct skcipher_request *req)
 
 	/* Create and submit job descriptor*/
 	init_skcipher_job(req, edesc, true);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "skcipher jobdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("skcipher jobdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
+
 	desc = edesc->hw_desc;
 	ret = caam_jr_enqueue(jrdev, desc, skcipher_encrypt_done, req);
 
@@ -1845,11 +1817,10 @@ static int skcipher_decrypt(struct skcipher_request *req)
 	/* Create and submit job descriptor*/
 	init_skcipher_job(req, edesc, false);
 	desc = edesc->hw_desc;
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "skcipher jobdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-		       desc_bytes(edesc->hw_desc), 1);
-#endif
+
+	print_hex_dump_debug("skcipher jobdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
+			     desc_bytes(edesc->hw_desc), 1);
 
 	ret = caam_jr_enqueue(jrdev, desc, skcipher_decrypt_done, req);
 	if (!ret) {
diff --git a/drivers/crypto/caam/caamalg_desc.c b/drivers/crypto/caam/caamalg_desc.c
index 1e1a376edc2f..a73b79c5d46c 100644
--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -115,11 +115,9 @@ void cnstr_shdsc_aead_null_encap(u32 * const desc, struct alginfo *adata,
 	append_seq_store(desc, icvsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "aead null enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("aead null enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_null_encap);
 
@@ -204,11 +202,9 @@ void cnstr_shdsc_aead_null_decap(u32 * const desc, struct alginfo *adata,
 	append_seq_fifo_load(desc, icvsize, FIFOLD_CLASS_CLASS2 |
 			     FIFOLD_TYPE_LAST2 | FIFOLD_TYPE_ICV);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "aead null dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("aead null dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_null_decap);
 
@@ -358,10 +354,9 @@ void cnstr_shdsc_aead_encap(u32 * const desc, struct alginfo *cdata,
 	append_seq_store(desc, icvsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("aead enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_encap);
 
@@ -475,10 +470,9 @@ void cnstr_shdsc_aead_decap(u32 * const desc, struct alginfo *cdata,
 	append_seq_fifo_load(desc, icvsize, FIFOLD_CLASS_CLASS2 |
 			     FIFOLD_TYPE_LAST2 | FIFOLD_TYPE_ICV);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "aead dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("aead dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_decap);
 
@@ -613,11 +607,9 @@ void cnstr_shdsc_aead_givencap(u32 * const desc, struct alginfo *cdata,
 	append_seq_store(desc, icvsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "aead givenc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("aead givenc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_givencap);
 
@@ -742,10 +734,9 @@ void cnstr_shdsc_gcm_encap(u32 * const desc, struct alginfo *cdata,
 	append_seq_store(desc, icvsize, LDST_CLASS_1_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "gcm enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("gcm enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_gcm_encap);
 
@@ -838,10 +829,9 @@ void cnstr_shdsc_gcm_decap(u32 * const desc, struct alginfo *cdata,
 	append_seq_fifo_load(desc, icvsize, FIFOLD_CLASS_CLASS1 |
 			     FIFOLD_TYPE_ICV | FIFOLD_TYPE_LAST1);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "gcm dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("gcm dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_gcm_decap);
 
@@ -933,11 +923,9 @@ void cnstr_shdsc_rfc4106_encap(u32 * const desc, struct alginfo *cdata,
 	append_seq_store(desc, icvsize, LDST_CLASS_1_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "rfc4106 enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("rfc4106 enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4106_encap);
 
@@ -1030,11 +1018,9 @@ void cnstr_shdsc_rfc4106_decap(u32 * const desc, struct alginfo *cdata,
 	append_seq_fifo_load(desc, icvsize, FIFOLD_CLASS_CLASS1 |
 			     FIFOLD_TYPE_ICV | FIFOLD_TYPE_LAST1);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "rfc4106 dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("rfc4106 dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4106_decap);
 
@@ -1115,11 +1101,9 @@ void cnstr_shdsc_rfc4543_encap(u32 * const desc, struct alginfo *cdata,
 	append_seq_store(desc, icvsize, LDST_CLASS_1_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "rfc4543 enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("rfc4543 enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4543_encap);
 
@@ -1205,11 +1189,9 @@ void cnstr_shdsc_rfc4543_decap(u32 * const desc, struct alginfo *cdata,
 	append_seq_fifo_load(desc, icvsize, FIFOLD_CLASS_CLASS1 |
 			     FIFOLD_TYPE_ICV | FIFOLD_TYPE_LAST1);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "rfc4543 dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("rfc4543 dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4543_decap);
 
@@ -1416,11 +1398,9 @@ void cnstr_shdsc_skcipher_encap(u32 * const desc, struct alginfo *cdata,
 	/* Perform operation */
 	skcipher_append_src_dst(desc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "skcipher enc shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("skcipher enc shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_skcipher_encap);
 
@@ -1487,11 +1467,9 @@ void cnstr_shdsc_skcipher_decap(u32 * const desc, struct alginfo *cdata,
 	/* Perform operation */
 	skcipher_append_src_dst(desc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "skcipher dec shdesc@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("skcipher dec shdesc@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_skcipher_decap);
 
@@ -1538,11 +1516,9 @@ void cnstr_shdsc_xts_skcipher_encap(u32 * const desc, struct alginfo *cdata)
 	/* Perform operation */
 	skcipher_append_src_dst(desc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "xts skcipher enc shdesc@" __stringify(__LINE__) ": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("xts skcipher enc shdesc@" __stringify(__LINE__)
+			     ": ", DUMP_PREFIX_ADDRESS, 16, 4,
+			     desc, desc_bytes(desc), 1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_xts_skcipher_encap);
 
@@ -1588,11 +1564,9 @@ void cnstr_shdsc_xts_skcipher_decap(u32 * const desc, struct alginfo *cdata)
 	/* Perform operation */
 	skcipher_append_src_dst(desc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "xts skcipher dec shdesc@" __stringify(__LINE__) ": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("xts skcipher dec shdesc@" __stringify(__LINE__)
+			     ": ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
+			     desc_bytes(desc), 1);
 }
 EXPORT_SYMBOL(cnstr_shdsc_xts_skcipher_decap);
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index d290d6b41825..44642058b5ac 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -214,13 +214,11 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	if (crypto_authenc_extractkeys(&keys, key, keylen) != 0)
 		goto badkey;
 
-#ifdef DEBUG
-	dev_err(jrdev, "keylen %d enckeylen %d authkeylen %d\n",
+	dev_dbg(jrdev, "keylen %d enckeylen %d authkeylen %d\n",
 		keys.authkeylen + keys.enckeylen, keys.enckeylen,
 		keys.authkeylen);
-	print_hex_dump(KERN_ERR, "key in @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	/*
 	 * If DKP is supported, use it in the shared descriptor to generate
@@ -253,11 +251,10 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	memcpy(ctx->key + ctx->adata.keylen_pad, keys.enckey, keys.enckeylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, ctx->adata.keylen_pad +
 				   keys.enckeylen, ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx.key@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-		       ctx->adata.keylen_pad + keys.enckeylen, 1);
-#endif
+
+	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
+			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
 skip_split_key:
 	ctx->cdata.keylen = keys.enckeylen;
@@ -386,10 +383,8 @@ static int gcm_setkey(struct crypto_aead *aead,
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, keylen, ctx->dir);
@@ -485,10 +480,8 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	if (keylen < 4)
 		return -EINVAL;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -589,10 +582,8 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	if (keylen < 4)
 		return -EINVAL;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -644,10 +635,9 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	const bool is_rfc3686 = alg->caam.rfc3686;
 	int ret = 0;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key in @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-#endif
+	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+
 	/*
 	 * AES-CTR needs to load IV in CONTEXT1 reg
 	 * at an offset of 128bits (16bytes)
@@ -1182,23 +1172,19 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	struct device *qidev = caam_ctx->qidev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 
-#ifdef DEBUG
-	dev_err(qidev, "%s %d: status 0x%x\n", __func__, __LINE__, status);
-#endif
+	dev_dbg(qidev, "%s %d: status 0x%x\n", __func__, __LINE__, status);
 
 	edesc = container_of(drv_req, typeof(*edesc), drv_req);
 
 	if (status)
 		caam_jr_strstatus(qidev, status);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "dstiv  @" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-		       edesc->src_nents > 1 ? 100 : ivsize, 1);
+	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
+			     edesc->src_nents > 1 ? 100 : ivsize, 1);
 	caam_dump_sg(KERN_ERR, "dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
-#endif
 
 	skcipher_unmap(qidev, edesc, req);
 
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 8aee7c9bf862..57bf984b8793 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -235,11 +235,10 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 			  ctx->ctx_len, true, ctrlpriv->era);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_update_dma,
 				   desc_bytes(desc), ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "ahash update shdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+
+	print_hex_dump_debug("ahash update shdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	/* ahash_update_first shared descriptor */
 	desc = ctx->sh_desc_update_first;
@@ -247,11 +246,9 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 			  ctx->ctx_len, false, ctrlpriv->era);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_update_first_dma,
 				   desc_bytes(desc), ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "ahash update first shdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("ahash update first shdesc@"__stringify(__LINE__)
+			     ": ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
+			     desc_bytes(desc), 1);
 
 	/* ahash_final shared descriptor */
 	desc = ctx->sh_desc_fin;
@@ -259,11 +256,10 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 			  ctx->ctx_len, true, ctrlpriv->era);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_fin_dma,
 				   desc_bytes(desc), ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ahash final shdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc,
-		       desc_bytes(desc), 1);
-#endif
+
+	print_hex_dump_debug("ahash final shdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+			     desc_bytes(desc), 1);
 
 	/* ahash_digest shared descriptor */
 	desc = ctx->sh_desc_digest;
@@ -271,12 +267,10 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 			  ctx->ctx_len, false, ctrlpriv->era);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_digest_dma,
 				   desc_bytes(desc), ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR,
-		       "ahash digest shdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc,
-		       desc_bytes(desc), 1);
-#endif
+
+	print_hex_dump_debug("ahash digest shdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+			     desc_bytes(desc), 1);
 
 	return 0;
 }
@@ -320,9 +314,9 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 			    ctx->ctx_len, ctx->key_dma);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_update_first_dma,
 				   desc_bytes(desc), ctx->dir);
-	print_hex_dump_debug("axcbc update first shdesc@" __stringify(__LINE__)" : ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+	print_hex_dump_debug("axcbc update first shdesc@" __stringify(__LINE__)
+			     " : ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
+			     desc_bytes(desc), 1);
 
 	/* shared descriptor for ahash_digest */
 	desc = ctx->sh_desc_digest;
@@ -369,8 +363,8 @@ static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 			    ctx->ctx_len, 0);
 	dma_sync_single_for_device(jrdev, ctx->sh_desc_update_first_dma,
 				   desc_bytes(desc), ctx->dir);
-	print_hex_dump_debug("acmac update first shdesc@" __stringify(__LINE__)" : ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+	print_hex_dump_debug("acmac update first shdesc@" __stringify(__LINE__)
+			     " : ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
 			     desc_bytes(desc), 1);
 
 	/* shared descriptor for ahash_digest */
@@ -421,12 +415,11 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	append_seq_store(desc, digestsize, LDST_CLASS_2_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "key_in@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("key_in@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	result.err = 0;
 	init_completion(&result.completion);
@@ -436,11 +429,10 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-#ifdef DEBUG
-		print_hex_dump(KERN_ERR,
-			       "digested key@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, key, digestsize, 1);
-#endif
+
+		print_hex_dump_debug("digested key@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, key,
+				     digestsize, 1);
 	}
 	dma_unmap_single(jrdev, key_dma, *keylen, DMA_BIDIRECTIONAL);
 
@@ -455,15 +447,14 @@ static int ahash_setkey(struct crypto_ahash *ahash,
 			const u8 *key, unsigned int keylen)
 {
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct device *jrdev = ctx->jrdev;
 	int blocksize = crypto_tfm_alg_blocksize(&ahash->base);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(ctx->jrdev->parent);
 	int ret;
 	u8 *hashed_key = NULL;
 
-#ifdef DEBUG
-	printk(KERN_ERR "keylen %d\n", keylen);
-#endif
+	dev_dbg(jrdev, "keylen %d\n", keylen);
 
 	if (keylen > blocksize) {
 		hashed_key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
@@ -592,11 +583,9 @@ static void ahash_done(struct device *jrdev, u32 *desc, u32 err,
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
-#ifdef DEBUG
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
@@ -606,11 +595,9 @@ static void ahash_done(struct device *jrdev, u32 *desc, u32 err,
 	memcpy(req->result, state->caam_ctx, digestsize);
 	kfree(edesc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-		       ctx->ctx_len, 1);
-#endif
+	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
+			     ctx->ctx_len, 1);
 
 	req->base.complete(&req->base, err);
 }
@@ -623,11 +610,9 @@ static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
-#ifdef DEBUG
 	int digestsize = crypto_ahash_digestsize(ahash);
 
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
@@ -637,15 +622,13 @@ static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
 	switch_buf(state);
 	kfree(edesc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-		       ctx->ctx_len, 1);
+	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
+			     ctx->ctx_len, 1);
 	if (req->result)
-		print_hex_dump(KERN_ERR, "result@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, req->result,
-			       digestsize, 1);
-#endif
+		print_hex_dump_debug("result@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
+				     digestsize, 1);
 
 	req->base.complete(&req->base, err);
 }
@@ -658,11 +641,9 @@ static void ahash_done_ctx_src(struct device *jrdev, u32 *desc, u32 err,
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
-#ifdef DEBUG
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
@@ -672,11 +653,9 @@ static void ahash_done_ctx_src(struct device *jrdev, u32 *desc, u32 err,
 	memcpy(req->result, state->caam_ctx, digestsize);
 	kfree(edesc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-		       ctx->ctx_len, 1);
-#endif
+	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
+			     ctx->ctx_len, 1);
 
 	req->base.complete(&req->base, err);
 }
@@ -689,11 +668,9 @@ static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
-#ifdef DEBUG
 	int digestsize = crypto_ahash_digestsize(ahash);
 
-	dev_err(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
@@ -703,15 +680,13 @@ static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
 	switch_buf(state);
 	kfree(edesc);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-		       ctx->ctx_len, 1);
+	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
+			     ctx->ctx_len, 1);
 	if (req->result)
-		print_hex_dump(KERN_ERR, "result@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, req->result,
-			       digestsize, 1);
-#endif
+		print_hex_dump_debug("result@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
+				     digestsize, 1);
 
 	req->base.complete(&req->base, err);
 }
@@ -885,11 +860,9 @@ static int ahash_update_ctx(struct ahash_request *req)
 
 		append_seq_out_ptr(desc, state->ctx_dma, ctx->ctx_len, 0);
 
-#ifdef DEBUG
-		print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			       desc_bytes(desc), 1);
-#endif
+		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+				     desc_bytes(desc), 1);
 
 		ret = caam_jr_enqueue(jrdev, desc, ahash_done_bi, req);
 		if (ret)
@@ -902,13 +875,12 @@ static int ahash_update_ctx(struct ahash_request *req)
 		*buflen = *next_buflen;
 		*next_buflen = last_buflen;
 	}
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "buf@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
-	print_hex_dump(KERN_ERR, "next buf@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, next_buf,
-		       *next_buflen, 1);
-#endif
+
+	print_hex_dump_debug("buf@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
+	print_hex_dump_debug("next buf@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf,
+			     *next_buflen, 1);
 
 	return ret;
 unmap_ctx:
@@ -969,10 +941,9 @@ static int ahash_final_ctx(struct ahash_request *req)
 			  LDST_SGF);
 	append_seq_out_ptr(desc, state->ctx_dma, digestsize, 0);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
 	if (ret)
@@ -1050,10 +1021,9 @@ static int ahash_finup_ctx(struct ahash_request *req)
 
 	append_seq_out_ptr(desc, state->ctx_dma, digestsize, 0);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
 	if (ret)
@@ -1127,10 +1097,9 @@ static int ahash_digest(struct ahash_request *req)
 		return -ENOMEM;
 	}
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
 	if (!ret) {
@@ -1182,10 +1151,9 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	if (ret)
 		goto unmap;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
 	if (!ret) {
@@ -1305,11 +1273,9 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 		if (ret)
 			goto unmap_ctx;
 
-#ifdef DEBUG
-		print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			       desc_bytes(desc), 1);
-#endif
+		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+				     desc_bytes(desc), 1);
 
 		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
 		if (ret)
@@ -1325,13 +1291,12 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 		*buflen = *next_buflen;
 		*next_buflen = 0;
 	}
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "buf@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
-	print_hex_dump(KERN_ERR, "next buf@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, next_buf,
-		       *next_buflen, 1);
-#endif
+
+	print_hex_dump_debug("buf@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
+	print_hex_dump_debug("next buf@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf, *next_buflen,
+			     1);
 
 	return ret;
  unmap_ctx:
@@ -1406,10 +1371,9 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	if (ret)
 		goto unmap;
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
 	if (!ret) {
@@ -1509,11 +1473,9 @@ static int ahash_update_first(struct ahash_request *req)
 		if (ret)
 			goto unmap_ctx;
 
-#ifdef DEBUG
-		print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			       desc_bytes(desc), 1);
-#endif
+		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
+				     desc_bytes(desc), 1);
 
 		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
 		if (ret)
@@ -1531,11 +1493,10 @@ static int ahash_update_first(struct ahash_request *req)
 					 req->nbytes, 0);
 		switch_buf(state);
 	}
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "next buf@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, next_buf,
-		       *next_buflen, 1);
-#endif
+
+	print_hex_dump_debug("next buf@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf, *next_buflen,
+			     1);
 
 	return ret;
  unmap_ctx:
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 95eb5402c59f..addf1bc18a0d 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -113,10 +113,8 @@ static void rng_done(struct device *jrdev, u32 *desc, u32 err, void *context)
 	/* Buffer refilled, invalidate cache */
 	dma_sync_single_for_cpu(jrdev, bd->addr, RN_BUF_SIZE, DMA_FROM_DEVICE);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "rng refreshed buf@: ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, bd->buf, RN_BUF_SIZE, 1);
-#endif
+	print_hex_dump_debug("rng refreshed buf@: ", DUMP_PREFIX_ADDRESS, 16, 4,
+			     bd->buf, RN_BUF_SIZE, 1);
 }
 
 static inline int submit_job(struct caam_rng_ctx *ctx, int to_current)
@@ -209,10 +207,10 @@ static inline int rng_create_sh_desc(struct caam_rng_ctx *ctx)
 		dev_err(jrdev, "unable to map shared descriptor\n");
 		return -ENOMEM;
 	}
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "rng shdesc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-		       desc, desc_bytes(desc), 1);
-#endif
+
+	print_hex_dump_debug("rng shdesc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
+			     desc, desc_bytes(desc), 1);
+
 	return 0;
 }
 
@@ -233,10 +231,10 @@ static inline int rng_create_job_desc(struct caam_rng_ctx *ctx, int buf_id)
 	}
 
 	append_seq_out_ptr_intlen(desc, bd->addr, RN_BUF_SIZE, 0);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "rng job desc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-		       desc, desc_bytes(desc), 1);
-#endif
+
+	print_hex_dump_debug("rng job desc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
+			     desc, desc_bytes(desc), 1);
+
 	return 0;
 }
 
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index 8d0713fae6ac..48dd3536060d 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -16,9 +16,7 @@ void split_key_done(struct device *dev, u32 *desc, u32 err,
 {
 	struct split_key_result *res = context;
 
-#ifdef DEBUG
-	dev_err(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-#endif
+	dev_dbg(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	if (err)
 		caam_jr_strstatus(dev, err);
@@ -55,12 +53,10 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 	adata->keylen_pad = split_key_pad_len(adata->algtype &
 					      OP_ALG_ALGSEL_MASK);
 
-#ifdef DEBUG
-	dev_err(jrdev, "split keylen %d split keylen padded %d\n",
+	dev_dbg(jrdev, "split keylen %d split keylen padded %d\n",
 		adata->keylen, adata->keylen_pad);
-	print_hex_dump(KERN_ERR, "ctx.key@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen, 1);
-#endif
+	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen, 1);
 
 	if (adata->keylen_pad > max_keylen)
 		return -EINVAL;
@@ -102,10 +98,9 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 	append_fifo_store(desc, dma_addr, adata->keylen,
 			  LDST_CLASS_2_CCB | FIFOST_TYPE_SPLIT_KEK);
 
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "jobdesc@"__stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc), 1);
-#endif
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
+			     1);
 
 	result.err = 0;
 	init_completion(&result.completion);
@@ -115,11 +110,10 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 		/* in progress */
 		wait_for_completion(&result.completion);
 		ret = result.err;
-#ifdef DEBUG
-		print_hex_dump(KERN_ERR, "ctx.key@"__stringify(__LINE__)": ",
-			       DUMP_PREFIX_ADDRESS, 16, 4, key_out,
-			       adata->keylen_pad, 1);
-#endif
+
+		print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, key_out,
+				     adata->keylen_pad, 1);
 	}
 
 	dma_unmap_single(jrdev, dma_addr, adata->keylen_pad, DMA_BIDIRECTIONAL);
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index dbfa9fce33e0..8f9555d01011 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -35,11 +35,9 @@ static inline void dma_to_sec4_sg_one(struct sec4_sg_entry *sec4_sg_ptr,
 		sec4_sg_ptr->bpid_offset = cpu_to_caam32(offset &
 							 SEC4_SG_OFFSET_MASK);
 	}
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "sec4_sg_ptr@: ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, sec4_sg_ptr,
-		       sizeof(struct sec4_sg_entry), 1);
-#endif
+
+	print_hex_dump_debug("sec4_sg_ptr@: ", DUMP_PREFIX_ADDRESS, 16, 4,
+			     sec4_sg_ptr, sizeof(struct sec4_sg_entry), 1);
 }
 
 /*
-- 
2.20.1

