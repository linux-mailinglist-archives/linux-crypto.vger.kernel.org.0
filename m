Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251B015AF34
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Feb 2020 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBLRzs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Feb 2020 12:55:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:45196 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRzr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Feb 2020 12:55:47 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 523022076AA;
        Wed, 12 Feb 2020 18:55:46 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44593207661;
        Wed, 12 Feb 2020 18:55:46 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D916F20567;
        Wed, 12 Feb 2020 18:55:45 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v6 1/9] crypto: caam - refactor skcipher/aead/gcm/chachapoly {en,de}crypt functions
Date:   Wed, 12 Feb 2020 19:55:16 +0200
Message-Id: <1581530124-9135-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
References: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Create a common crypt function for each skcipher/aead/gcm/chachapoly
algorithms and call it for encrypt/decrypt with the specific boolean -
true for encrypt and false for decrypt.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg.c | 268 +++++++++---------------------------------
 1 file changed, 53 insertions(+), 215 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index ef1a65f..30fca37 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -941,8 +941,8 @@ static void skcipher_unmap(struct device *dev, struct skcipher_edesc *edesc,
 		   edesc->sec4_sg_dma, edesc->sec4_sg_bytes);
 }
 
-static void aead_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
-				   void *context)
+static void aead_crypt_done(struct device *jrdev, u32 *desc, u32 err,
+			    void *context)
 {
 	struct aead_request *req = context;
 	struct aead_edesc *edesc;
@@ -962,69 +962,8 @@ static void aead_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	aead_request_complete(req, ecode);
 }
 
-static void aead_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
-				   void *context)
-{
-	struct aead_request *req = context;
-	struct aead_edesc *edesc;
-	int ecode = 0;
-
-	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-
-	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
-
-	if (err)
-		ecode = caam_jr_strstatus(jrdev, err);
-
-	aead_unmap(jrdev, edesc, req);
-
-	kfree(edesc);
-
-	aead_request_complete(req, ecode);
-}
-
-static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
-				  void *context)
-{
-	struct skcipher_request *req = context;
-	struct skcipher_edesc *edesc;
-	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	int ivsize = crypto_skcipher_ivsize(skcipher);
-	int ecode = 0;
-
-	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
-
-	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
-
-	if (err)
-		ecode = caam_jr_strstatus(jrdev, err);
-
-	skcipher_unmap(jrdev, edesc, req);
-
-	/*
-	 * The crypto API expects us to set the IV (req->iv) to the last
-	 * ciphertext block (CBC mode) or last counter (CTR mode).
-	 * This is used e.g. by the CTS mode.
-	 */
-	if (ivsize && !ecode) {
-		memcpy(req->iv, (u8 *)edesc->sec4_sg + edesc->sec4_sg_bytes,
-		       ivsize);
-		print_hex_dump_debug("dstiv  @"__stringify(__LINE__)": ",
-				     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-				     edesc->src_nents > 1 ? 100 : ivsize, 1);
-	}
-
-	caam_dump_sg("dst    @" __stringify(__LINE__)": ",
-		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
-		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
-
-	kfree(edesc);
-
-	skcipher_request_complete(req, ecode);
-}
-
-static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
-				  void *context)
+static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
+				void *context)
 {
 	struct skcipher_request *req = context;
 	struct skcipher_edesc *edesc;
@@ -1436,41 +1375,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	return edesc;
 }
 
-static int gcm_encrypt(struct aead_request *req)
-{
-	struct aead_edesc *edesc;
-	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
-	struct device *jrdev = ctx->jrdev;
-	bool all_contig;
-	u32 *desc;
-	int ret = 0;
-
-	/* allocate extended descriptor */
-	edesc = aead_edesc_alloc(req, GCM_DESC_JOB_IO_LEN, &all_contig, true);
-	if (IS_ERR(edesc))
-		return PTR_ERR(edesc);
-
-	/* Create and submit job descriptor */
-	init_gcm_job(req, edesc, all_contig, true);
-
-	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
-
-	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_encrypt_done, req);
-	if (!ret) {
-		ret = -EINPROGRESS;
-	} else {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
-
-	return ret;
-}
-
-static int chachapoly_encrypt(struct aead_request *req)
+static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
@@ -1481,18 +1386,18 @@ static int chachapoly_encrypt(struct aead_request *req)
 	int ret;
 
 	edesc = aead_edesc_alloc(req, CHACHAPOLY_DESC_JOB_IO_LEN, &all_contig,
-				 true);
+				 encrypt);
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
 	desc = edesc->hw_desc;
 
-	init_chachapoly_job(req, edesc, all_contig, true);
+	init_chachapoly_job(req, edesc, all_contig, encrypt);
 	print_hex_dump_debug("chachapoly jobdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, aead_encrypt_done, req);
+	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
 	if (!ret) {
 		ret = -EINPROGRESS;
 	} else {
@@ -1503,45 +1408,17 @@ static int chachapoly_encrypt(struct aead_request *req)
 	return ret;
 }
 
-static int chachapoly_decrypt(struct aead_request *req)
+static int chachapoly_encrypt(struct aead_request *req)
 {
-	struct aead_edesc *edesc;
-	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
-	struct device *jrdev = ctx->jrdev;
-	bool all_contig;
-	u32 *desc;
-	int ret;
-
-	edesc = aead_edesc_alloc(req, CHACHAPOLY_DESC_JOB_IO_LEN, &all_contig,
-				 false);
-	if (IS_ERR(edesc))
-		return PTR_ERR(edesc);
-
-	desc = edesc->hw_desc;
-
-	init_chachapoly_job(req, edesc, all_contig, false);
-	print_hex_dump_debug("chachapoly jobdesc@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
-
-	ret = caam_jr_enqueue(jrdev, desc, aead_decrypt_done, req);
-	if (!ret) {
-		ret = -EINPROGRESS;
-	} else {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
-
-	return ret;
+	return chachapoly_crypt(req, true);
 }
 
-static int ipsec_gcm_encrypt(struct aead_request *req)
+static int chachapoly_decrypt(struct aead_request *req)
 {
-	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_encrypt(req);
+	return chachapoly_crypt(req, false);
 }
 
-static int aead_encrypt(struct aead_request *req)
+static inline int aead_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
@@ -1553,19 +1430,19 @@ static int aead_encrypt(struct aead_request *req)
 
 	/* allocate extended descriptor */
 	edesc = aead_edesc_alloc(req, AUTHENC_DESC_JOB_IO_LEN,
-				 &all_contig, true);
+				 &all_contig, encrypt);
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
 	/* Create and submit job descriptor */
-	init_authenc_job(req, edesc, all_contig, true);
+	init_authenc_job(req, edesc, all_contig, encrypt);
 
 	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
 			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_encrypt_done, req);
+	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
 	if (!ret) {
 		ret = -EINPROGRESS;
 	} else {
@@ -1576,7 +1453,17 @@ static int aead_encrypt(struct aead_request *req)
 	return ret;
 }
 
-static int gcm_decrypt(struct aead_request *req)
+static int aead_encrypt(struct aead_request *req)
+{
+	return aead_crypt(req, true);
+}
+
+static int aead_decrypt(struct aead_request *req)
+{
+	return aead_crypt(req, false);
+}
+
+static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
@@ -1587,19 +1474,20 @@ static int gcm_decrypt(struct aead_request *req)
 	int ret = 0;
 
 	/* allocate extended descriptor */
-	edesc = aead_edesc_alloc(req, GCM_DESC_JOB_IO_LEN, &all_contig, false);
+	edesc = aead_edesc_alloc(req, GCM_DESC_JOB_IO_LEN, &all_contig,
+				 encrypt);
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
-	/* Create and submit job descriptor*/
-	init_gcm_job(req, edesc, all_contig, false);
+	/* Create and submit job descriptor */
+	init_gcm_job(req, edesc, all_contig, encrypt);
 
 	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
 			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_decrypt_done, req);
+	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
 	if (!ret) {
 		ret = -EINPROGRESS;
 	} else {
@@ -1610,48 +1498,24 @@ static int gcm_decrypt(struct aead_request *req)
 	return ret;
 }
 
-static int ipsec_gcm_decrypt(struct aead_request *req)
+static int gcm_encrypt(struct aead_request *req)
 {
-	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_decrypt(req);
+	return gcm_crypt(req, true);
 }
 
-static int aead_decrypt(struct aead_request *req)
+static int gcm_decrypt(struct aead_request *req)
 {
-	struct aead_edesc *edesc;
-	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct caam_ctx *ctx = crypto_aead_ctx(aead);
-	struct device *jrdev = ctx->jrdev;
-	bool all_contig;
-	u32 *desc;
-	int ret = 0;
-
-	caam_dump_sg("dec src@" __stringify(__LINE__)": ",
-		     DUMP_PREFIX_ADDRESS, 16, 4, req->src,
-		     req->assoclen + req->cryptlen, 1);
-
-	/* allocate extended descriptor */
-	edesc = aead_edesc_alloc(req, AUTHENC_DESC_JOB_IO_LEN,
-				 &all_contig, false);
-	if (IS_ERR(edesc))
-		return PTR_ERR(edesc);
-
-	/* Create and submit job descriptor*/
-	init_authenc_job(req, edesc, all_contig, false);
-
-	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
+	return gcm_crypt(req, false);
+}
 
-	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_decrypt_done, req);
-	if (!ret) {
-		ret = -EINPROGRESS;
-	} else {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
+static int ipsec_gcm_encrypt(struct aead_request *req)
+{
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_encrypt(req);
+}
 
-	return ret;
+static int ipsec_gcm_decrypt(struct aead_request *req)
+{
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_decrypt(req);
 }
 
 /*
@@ -1815,7 +1679,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	return edesc;
 }
 
-static int skcipher_encrypt(struct skcipher_request *req)
+static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
@@ -1833,14 +1697,14 @@ static int skcipher_encrypt(struct skcipher_request *req)
 		return PTR_ERR(edesc);
 
 	/* Create and submit job descriptor*/
-	init_skcipher_job(req, edesc, true);
+	init_skcipher_job(req, edesc, encrypt);
 
 	print_hex_dump_debug("skcipher jobdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
 			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, skcipher_encrypt_done, req);
+	ret = caam_jr_enqueue(jrdev, desc, skcipher_crypt_done, req);
 
 	if (!ret) {
 		ret = -EINPROGRESS;
@@ -1852,40 +1716,14 @@ static int skcipher_encrypt(struct skcipher_request *req)
 	return ret;
 }
 
-static int skcipher_decrypt(struct skcipher_request *req)
+static int skcipher_encrypt(struct skcipher_request *req)
 {
-	struct skcipher_edesc *edesc;
-	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
-	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
-	struct device *jrdev = ctx->jrdev;
-	u32 *desc;
-	int ret = 0;
-
-	if (!req->cryptlen)
-		return 0;
-
-	/* allocate extended descriptor */
-	edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
-	if (IS_ERR(edesc))
-		return PTR_ERR(edesc);
-
-	/* Create and submit job descriptor*/
-	init_skcipher_job(req, edesc, false);
-	desc = edesc->hw_desc;
-
-	print_hex_dump_debug("skcipher jobdesc@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
-
-	ret = caam_jr_enqueue(jrdev, desc, skcipher_decrypt_done, req);
-	if (!ret) {
-		ret = -EINPROGRESS;
-	} else {
-		skcipher_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
+	return skcipher_crypt(req, true);
+}
 
-	return ret;
+static int skcipher_decrypt(struct skcipher_request *req)
+{
+	return skcipher_crypt(req, false);
 }
 
 static struct caam_skcipher_alg driver_algs[] = {
-- 
2.1.0

