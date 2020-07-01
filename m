Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6B2105D8
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2020 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgGAIGe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Jul 2020 04:06:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50524 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgGAIGS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Jul 2020 04:06:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06186BV0020507;
        Wed, 1 Jul 2020 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593590771;
        bh=NHbH2P2evP6VK2nWKKxgMOYd1QQ6qnBNeOw3CGwXnLc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ernJ26Fl9nNk4M1iiubGoiETPClN0UHG4BjzTzP2/C4FJIWtyEfiJa+PJJc2p9+MD
         UNbeiItib7onOlxg24yKvi6NQTPnCIj2SSsfz2bHh2Fp4EPP7vrwXSEno1NSPoRMrZ
         gb6NEyVpqf4jqgL9Se8oLGHXdf1cElPCj9h9DUa4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061866N9089755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 03:06:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 03:06:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 03:06:07 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06185wUg078048;
        Wed, 1 Jul 2020 03:06:06 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <j-keerthy@ti.com>
Subject: [PATCHv5 4/7] crypto: sa2ul: Add AEAD algorithm support
Date:   Wed, 1 Jul 2020 11:05:50 +0300
Message-ID: <20200701080553.22604-5-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701080553.22604-1-t-kristo@ti.com>
References: <20200701080553.22604-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add support for sa2ul hardware AEAD for hmac(sha256),cbc(aes) and
hmac(sha1),cbc(aes) algorithms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
[t-kristo@ti.com: number of bug fixes, major refactoring and cleanup of
 code]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/sa2ul.c | 538 +++++++++++++++++++++++++++++++++++++++--
 drivers/crypto/sa2ul.h |   1 +
 2 files changed, 518 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 747d02f01ca5..6fc57d10e04a 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -17,7 +17,9 @@
 #include <linux/pm_runtime.h>
 
 #include <crypto/aes.h>
+#include <crypto/authenc.h>
 #include <crypto/des.h>
+#include <crypto/internal/aead.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
@@ -77,6 +79,7 @@ static struct device *sa_k3_dev;
  * @iv_size: Initialization Vector size
  * @akey: Authentication key
  * @akey_len: Authentication key length
+ * @enc: True, if this is an encode request
  */
 struct sa_cmdl_cfg {
 	int aalg;
@@ -85,6 +88,7 @@ struct sa_cmdl_cfg {
 	u8 iv_size;
 	const u8 *akey;
 	u16 akey_len;
+	bool enc;
 };
 
 /**
@@ -101,6 +105,8 @@ struct sa_cmdl_cfg {
  * @mci_dec: Mode Control Instruction for Decryption
  * @inv_key: Whether the encryption algorithm demands key inversion
  * @ctx: Pointer to the algorithm context
+ * @keyed_mac: Whether the authentication algorithm has key
+ * @prep_iopad: Function pointer to generate intermediate ipad/opad
  */
 struct algo_data {
 	struct sa_eng_info enc_eng;
@@ -115,6 +121,9 @@ struct algo_data {
 	u8 *mci_dec;
 	bool inv_key;
 	struct sa_tfm_ctx *ctx;
+	bool keyed_mac;
+	void (*prep_iopad)(struct algo_data *algo, const u8 *key,
+			   u16 key_sz, u32 *ipad, u32 *opad);
 };
 
 /**
@@ -128,6 +137,7 @@ struct sa_alg_tmpl {
 	union {
 		struct skcipher_alg skcipher;
 		struct ahash_alg ahash;
+		struct aead_alg aead;
 	} alg;
 	bool registered;
 };
@@ -231,6 +241,38 @@ static u8 mci_cbc_dec_array[3][MODE_CONTROL_BYTES] = {
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
 };
 
+/*
+ * Mode Control Instructions for various Key lengths 128, 192, 256
+ * For CBC (Cipher Block Chaining) mode for encryption
+ */
+static u8 mci_cbc_enc_no_iv_array[3][MODE_CONTROL_BYTES] = {
+	{	0x21, 0x00, 0x00, 0x18, 0x88, 0x0a, 0xaa, 0x4b, 0x7e, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+	{	0x21, 0x00, 0x00, 0x18, 0x88, 0x4a, 0xaa, 0x4b, 0x7e, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+	{	0x21, 0x00, 0x00, 0x18, 0x88, 0x8a, 0xaa, 0x4b, 0x7e, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+};
+
+/*
+ * Mode Control Instructions for various Key lengths 128, 192, 256
+ * For CBC (Cipher Block Chaining) mode for decryption
+ */
+static u8 mci_cbc_dec_no_iv_array[3][MODE_CONTROL_BYTES] = {
+	{	0x31, 0x00, 0x00, 0x80, 0x8a, 0xca, 0x98, 0xf4, 0x40, 0xc0,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+	{	0x31, 0x00, 0x00, 0x84, 0x8a, 0xca, 0x98, 0xf4, 0x40, 0xc0,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+	{	0x31, 0x00, 0x00, 0x88, 0x8a, 0xca, 0x98, 0xf4, 0x40, 0xc0,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	},
+};
+
 /*
  * Mode Control Instructions for various Key lengths 128, 192, 256
  * For ECB (Electronic Code Book) mode for encryption
@@ -310,6 +352,82 @@ static void sa_swiz_128(u8 *in, u16 len)
 	}
 }
 
+/* Prepare the ipad and opad from key as per SHA algorithm step 1*/
+static void prepare_kiopad(u8 *k_ipad, u8 *k_opad, const u8 *key, u16 key_sz)
+{
+	int i;
+
+	for (i = 0; i < key_sz; i++) {
+		k_ipad[i] = key[i] ^ 0x36;
+		k_opad[i] = key[i] ^ 0x5c;
+	}
+
+	/* Instead of XOR with 0 */
+	for (; i < SHA1_BLOCK_SIZE; i++) {
+		k_ipad[i] = 0x36;
+		k_opad[i] = 0x5c;
+	}
+}
+
+static void sa_export_shash(struct shash_desc *hash, int block_size,
+			    int digest_size, u32 *out)
+{
+	union {
+		struct sha1_state sha1;
+		struct sha256_state sha256;
+		struct sha512_state sha512;
+	} sha;
+	void *state;
+	u32 *result;
+	int i;
+
+	switch (digest_size) {
+	case SHA1_DIGEST_SIZE:
+		state = &sha.sha1;
+		result = sha.sha1.state;
+		break;
+	case SHA256_DIGEST_SIZE:
+		state = &sha.sha256;
+		result = sha.sha256.state;
+		break;
+	default:
+		dev_err(sa_k3_dev, "%s: bad digest_size=%d\n", __func__,
+			digest_size);
+		return;
+	}
+
+	crypto_shash_export(hash, state);
+
+	for (i = 0; i < digest_size >> 2; i++)
+		out[i] = cpu_to_be32(result[i]);
+}
+
+static void sa_prepare_iopads(struct algo_data *data, const u8 *key,
+			      u16 key_sz, u32 *ipad, u32 *opad)
+{
+	SHASH_DESC_ON_STACK(shash, data->ctx->shash);
+	int block_size = crypto_shash_blocksize(data->ctx->shash);
+	int digest_size = crypto_shash_digestsize(data->ctx->shash);
+	u8 k_ipad[SHA1_BLOCK_SIZE];
+	u8 k_opad[SHA1_BLOCK_SIZE];
+
+	shash->tfm = data->ctx->shash;
+
+	prepare_kiopad(k_ipad, k_opad, key, key_sz);
+
+	memzero_explicit(ipad, block_size);
+	memzero_explicit(opad, block_size);
+
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, k_ipad, block_size);
+	sa_export_shash(shash, block_size, digest_size, ipad);
+
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, k_opad, block_size);
+
+	sa_export_shash(shash, block_size, digest_size, opad);
+}
+
 /* Derive the inverse key used in AES-CBC decryption operation */
 static inline int sa_aes_inv_key(u8 *inv_key, const u8 *key, u16 key_sz)
 {
@@ -380,14 +498,26 @@ static int sa_set_sc_enc(struct algo_data *ad, const u8 *key, u16 key_sz,
 static void sa_set_sc_auth(struct algo_data *ad, const u8 *key, u16 key_sz,
 			   u8 *sc_buf)
 {
+	u32 ipad[64], opad[64];
+
 	/* Set Authentication mode selector to hash processing */
 	sc_buf[0] = SA_HASH_PROCESSING;
 	/* Auth SW ctrl word: bit[6]=1 (upload computed hash to TLR section) */
 	sc_buf[1] = SA_UPLOAD_HASH_TO_TLR;
 	sc_buf[1] |= ad->auth_ctrl;
 
-	/* basic hash */
-	sc_buf[1] |= SA_BASIC_HASH;
+	/* Copy the keys or ipad/opad */
+	if (ad->keyed_mac) {
+		ad->prep_iopad(ad, key, key_sz, ipad, opad);
+
+		/* Copy ipad to AuthKey */
+		memcpy(&sc_buf[32], ipad, ad->hash_size);
+		/* Copy opad to Aux-1 */
+		memcpy(&sc_buf[64], opad, ad->hash_size);
+	} else {
+		/* basic hash */
+		sc_buf[1] |= SA_BASIC_HASH;
+	}
 }
 
 static inline void sa_copy_iv(u32 *out, const u8 *iv, bool size16)
@@ -417,16 +547,18 @@ static int sa_format_cmdl_gen(struct sa_cmdl_cfg *cfg, u8 *cmdl,
 	/* Iniialize the command update structure */
 	memzero_explicit(upd_info, sizeof(*upd_info));
 
-	if (cfg->enc_eng_id)
-		total = SA_CMDL_HEADER_SIZE_BYTES;
+	if (cfg->enc_eng_id && cfg->auth_eng_id) {
+		if (cfg->enc) {
+			auth_offset = SA_CMDL_HEADER_SIZE_BYTES;
+			enc_next_eng = cfg->auth_eng_id;
 
-	if (cfg->auth_eng_id)
-		total = SA_CMDL_HEADER_SIZE_BYTES;
-
-	if (cfg->iv_size)
-		total += cfg->iv_size;
-
-	enc_next_eng = SA_ENG_ID_OUTPORT2;
+			if (cfg->iv_size)
+				auth_offset += cfg->iv_size;
+		} else {
+			enc_offset = SA_CMDL_HEADER_SIZE_BYTES;
+			auth_next_eng = cfg->enc_eng_id;
+		}
+	}
 
 	if (cfg->enc_eng_id) {
 		upd_info->flags |= SA_CMDL_UPD_ENC;
@@ -447,11 +579,11 @@ static int sa_format_cmdl_gen(struct sa_cmdl_cfg *cfg, u8 *cmdl,
 
 			cmdl[enc_offset + SA_CMDL_OFFSET_OPTION_CTRL1] =
 				(SA_CTX_ENC_AUX2_OFFSET | (cfg->iv_size >> 3));
-			enc_offset += SA_CMDL_HEADER_SIZE_BYTES + cfg->iv_size;
+			total += SA_CMDL_HEADER_SIZE_BYTES + cfg->iv_size;
 		} else {
 			cmdl[enc_offset + SA_CMDL_OFFSET_LABEL_LEN] =
 						SA_CMDL_HEADER_SIZE_BYTES;
-			enc_offset += SA_CMDL_HEADER_SIZE_BYTES;
+			total += SA_CMDL_HEADER_SIZE_BYTES;
 		}
 	}
 
@@ -559,23 +691,28 @@ int sa_init_sc(struct sa_ctx_info *ctx, const u8 *enc_key,
 	int auth_sc_offset = 0;
 	u8 *sc_buf = ctx->sc;
 	u16 sc_id = ctx->sc_id;
-	u8 first_engine;
+	u8 first_engine = 0;
 
 	memzero_explicit(sc_buf, SA_CTX_MAX_SZ);
 
-	if (ad->enc_eng.eng_id) {
-		enc_sc_offset = SA_CTX_PHP_PE_CTX_SZ;
-		first_engine = ad->enc_eng.eng_id;
-		sc_buf[1] = SA_SCCTL_FE_ENC;
-		ad->hash_size = ad->iv_out_size;
-	} else {
+	if (ad->auth_eng.eng_id) {
+		if (enc)
+			first_engine = ad->enc_eng.eng_id;
+		else
+			first_engine = ad->auth_eng.eng_id;
+
 		enc_sc_offset = SA_CTX_PHP_PE_CTX_SZ;
 		auth_sc_offset = enc_sc_offset + ad->enc_eng.sc_size;
-		first_engine = ad->auth_eng.eng_id;
 		sc_buf[1] = SA_SCCTL_FE_AUTH_ENC;
 		if (!ad->hash_size)
 			return -EINVAL;
 		ad->hash_size = roundup(ad->hash_size, 8);
+
+	} else if (ad->enc_eng.eng_id && !ad->auth_eng.eng_id) {
+		enc_sc_offset = SA_CTX_PHP_PE_CTX_SZ;
+		first_engine = ad->enc_eng.eng_id;
+		sc_buf[1] = SA_SCCTL_FE_ENC;
+		ad->hash_size = ad->iv_out_size;
 	}
 
 	/* SCCTL Owner info: 0=host, 1=CP_ACE */
@@ -1492,6 +1629,305 @@ static void sa_sha_cra_exit(struct crypto_tfm *tfm)
 	crypto_free_ahash(ctx->fallback.ahash);
 }
 
+static void sa_aead_dma_in_callback(void *data)
+{
+	struct sa_rx_data *rxd = (struct sa_rx_data *)data;
+	struct aead_request *req;
+	struct crypto_aead *tfm;
+	unsigned int start;
+	unsigned int authsize;
+	u8 auth_tag[SA_MAX_AUTH_TAG_SZ];
+	size_t pl, ml;
+	int i, sglen;
+	int err = 0;
+	u16 auth_len;
+	u32 *mdptr;
+	bool diff_dst;
+	enum dma_data_direction dir_src;
+
+	req = container_of(rxd->req, struct aead_request, base);
+	tfm = crypto_aead_reqtfm(req);
+	start = req->assoclen + req->cryptlen;
+	authsize = crypto_aead_authsize(tfm);
+
+	diff_dst = (req->src != req->dst) ? true : false;
+	dir_src = diff_dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
+	mdptr = (u32 *)dmaengine_desc_get_metadata_ptr(rxd->tx_in, &pl, &ml);
+	for (i = 0; i < (authsize / 4); i++)
+		mdptr[i + 4] = htonl(mdptr[i + 4]);
+
+	auth_len = req->assoclen + req->cryptlen;
+	if (!rxd->enc)
+		auth_len -= authsize;
+
+	sglen =  sg_nents_for_len(rxd->src, auth_len);
+	dma_unmap_sg(rxd->ddev, rxd->src, sglen, dir_src);
+	kfree(rxd->split_src_sg);
+
+	if (diff_dst) {
+		sglen = sg_nents_for_len(rxd->dst, auth_len);
+		dma_unmap_sg(rxd->ddev, rxd->dst, sglen, DMA_FROM_DEVICE);
+		kfree(rxd->split_dst_sg);
+	}
+
+	if (rxd->enc) {
+		scatterwalk_map_and_copy(&mdptr[4], req->dst, start, authsize,
+					 1);
+	} else {
+		start -= authsize;
+		scatterwalk_map_and_copy(auth_tag, req->src, start, authsize,
+					 0);
+
+		err = memcmp(&mdptr[4], auth_tag, authsize) ? -EBADMSG : 0;
+	}
+
+	kfree(rxd);
+
+	aead_request_complete(req, err);
+}
+
+static int sa_cra_init_aead(struct crypto_aead *tfm, const char *hash,
+			    const char *fallback)
+{
+	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+	struct sa_crypto_data *data = dev_get_drvdata(sa_k3_dev);
+	int ret;
+
+	memzero_explicit(ctx, sizeof(*ctx));
+
+	ctx->shash = crypto_alloc_shash(hash, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->shash)) {
+		dev_err(sa_k3_dev, "base driver %s couldn't be loaded\n", hash);
+		return PTR_ERR(ctx->shash);
+	}
+
+	ctx->fallback.aead = crypto_alloc_aead(fallback, 0,
+					       CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->fallback.aead)) {
+		dev_err(sa_k3_dev, "fallback driver %s couldn't be loaded\n",
+			fallback);
+		return PTR_ERR(ctx->fallback.aead);
+	}
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct aead_request) +
+				crypto_aead_reqsize(ctx->fallback.aead));
+
+	ret = sa_init_ctx_info(&ctx->enc, data);
+	if (ret)
+		return ret;
+
+	ret = sa_init_ctx_info(&ctx->dec, data);
+	if (ret) {
+		sa_free_ctx_info(&ctx->enc, data);
+		return ret;
+	}
+
+	dev_dbg(sa_k3_dev, "%s(0x%p) sc-ids(0x%x(0x%pad), 0x%x(0x%pad))\n",
+		__func__, tfm, ctx->enc.sc_id, &ctx->enc.sc_phys,
+		ctx->dec.sc_id, &ctx->dec.sc_phys);
+
+	return ret;
+}
+
+static int sa_cra_init_aead_sha1(struct crypto_aead *tfm)
+{
+	return sa_cra_init_aead(tfm, "sha1",
+				"authenc(hmac(sha1-ce),cbc(aes-ce))");
+}
+
+static int sa_cra_init_aead_sha256(struct crypto_aead *tfm)
+{
+	return sa_cra_init_aead(tfm, "sha256",
+				"authenc(hmac(sha256-ce),cbc(aes-ce))");
+}
+
+static void sa_exit_tfm_aead(struct crypto_aead *tfm)
+{
+	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+	struct sa_crypto_data *data = dev_get_drvdata(sa_k3_dev);
+
+	crypto_free_shash(ctx->shash);
+	crypto_free_aead(ctx->fallback.aead);
+
+	sa_free_ctx_info(&ctx->enc, data);
+	sa_free_ctx_info(&ctx->dec, data);
+}
+
+/* AEAD algorithm configuration interface function */
+static int sa_aead_setkey(struct crypto_aead *authenc,
+			  const u8 *key, unsigned int keylen,
+			  struct algo_data *ad)
+{
+	struct sa_tfm_ctx *ctx = crypto_aead_ctx(authenc);
+	struct crypto_authenc_keys keys;
+	int cmdl_len;
+	struct sa_cmdl_cfg cfg;
+	int key_idx;
+
+	if (crypto_authenc_extractkeys(&keys, key, keylen) != 0)
+		return -EINVAL;
+
+	/* Convert the key size (16/24/32) to the key size index (0/1/2) */
+	key_idx = (keys.enckeylen >> 3) - 2;
+	if (key_idx >= 3)
+		return -EINVAL;
+
+	ad->ctx = ctx;
+	ad->enc_eng.eng_id = SA_ENG_ID_EM1;
+	ad->enc_eng.sc_size = SA_CTX_ENC_TYPE1_SZ;
+	ad->auth_eng.eng_id = SA_ENG_ID_AM1;
+	ad->auth_eng.sc_size = SA_CTX_AUTH_TYPE2_SZ;
+	ad->mci_enc = mci_cbc_enc_no_iv_array[key_idx];
+	ad->mci_dec = mci_cbc_dec_no_iv_array[key_idx];
+	ad->inv_key = true;
+	ad->keyed_mac = true;
+	ad->ealg_id = SA_EALG_ID_AES_CBC;
+	ad->prep_iopad = sa_prepare_iopads;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.enc = true;
+	cfg.aalg = ad->aalg_id;
+	cfg.enc_eng_id = ad->enc_eng.eng_id;
+	cfg.auth_eng_id = ad->auth_eng.eng_id;
+	cfg.iv_size = crypto_aead_ivsize(authenc);
+	cfg.akey = keys.authkey;
+	cfg.akey_len = keys.authkeylen;
+
+	/* Setup Encryption Security Context & Command label template */
+	if (sa_init_sc(&ctx->enc, keys.enckey, keys.enckeylen,
+		       keys.authkey, keys.authkeylen,
+		       ad, 1, &ctx->enc.epib[1]))
+		return -EINVAL;
+
+	cmdl_len = sa_format_cmdl_gen(&cfg,
+				      (u8 *)ctx->enc.cmdl,
+				      &ctx->enc.cmdl_upd_info);
+	if (cmdl_len <= 0 || (cmdl_len > SA_MAX_CMDL_WORDS * sizeof(u32)))
+		return -EINVAL;
+
+	ctx->enc.cmdl_size = cmdl_len;
+
+	/* Setup Decryption Security Context & Command label template */
+	if (sa_init_sc(&ctx->dec, keys.enckey, keys.enckeylen,
+		       keys.authkey, keys.authkeylen,
+		       ad, 0, &ctx->dec.epib[1]))
+		return -EINVAL;
+
+	cfg.enc = false;
+	cmdl_len = sa_format_cmdl_gen(&cfg, (u8 *)ctx->dec.cmdl,
+				      &ctx->dec.cmdl_upd_info);
+
+	if (cmdl_len <= 0 || (cmdl_len > SA_MAX_CMDL_WORDS * sizeof(u32)))
+		return -EINVAL;
+
+	ctx->dec.cmdl_size = cmdl_len;
+
+	crypto_aead_clear_flags(ctx->fallback.aead, CRYPTO_TFM_REQ_MASK);
+	crypto_aead_set_flags(ctx->fallback.aead,
+			      crypto_aead_get_flags(authenc) &
+			      CRYPTO_TFM_REQ_MASK);
+	crypto_aead_setkey(ctx->fallback.aead, key, keylen);
+
+	return 0;
+}
+
+static int sa_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(crypto_aead_tfm(tfm));
+
+	return crypto_aead_setauthsize(ctx->fallback.aead, authsize);
+}
+
+static int sa_aead_cbc_sha1_setkey(struct crypto_aead *authenc,
+				   const u8 *key, unsigned int keylen)
+{
+	struct algo_data ad = { 0 };
+
+	ad.ealg_id = SA_EALG_ID_AES_CBC;
+	ad.aalg_id = SA_AALG_ID_HMAC_SHA1;
+	ad.hash_size = SHA1_DIGEST_SIZE;
+	ad.auth_ctrl = SA_AUTH_SW_CTRL_SHA1;
+
+	return sa_aead_setkey(authenc, key, keylen, &ad);
+}
+
+static int sa_aead_cbc_sha256_setkey(struct crypto_aead *authenc,
+				     const u8 *key, unsigned int keylen)
+{
+	struct algo_data ad = { 0 };
+
+	ad.ealg_id = SA_EALG_ID_AES_CBC;
+	ad.aalg_id = SA_AALG_ID_HMAC_SHA2_256;
+	ad.hash_size = SHA256_DIGEST_SIZE;
+	ad.auth_ctrl = SA_AUTH_SW_CTRL_SHA256;
+
+	return sa_aead_setkey(authenc, key, keylen, &ad);
+}
+
+static int sa_aead_run(struct aead_request *req, u8 *iv, int enc)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
+	struct sa_req sa_req = { 0 };
+	size_t auth_size, enc_size;
+
+	enc_size = req->cryptlen;
+	auth_size = req->assoclen + req->cryptlen;
+
+	if (!enc) {
+		enc_size -= crypto_aead_authsize(tfm);
+		auth_size -= crypto_aead_authsize(tfm);
+	}
+
+	if (auth_size > SA_MAX_DATA_SZ ||
+	    (auth_size >= SA_UNSAFE_DATA_SZ_MIN &&
+	     auth_size <= SA_UNSAFE_DATA_SZ_MAX)) {
+		struct aead_request *subreq = aead_request_ctx(req);
+		int ret;
+
+		aead_request_set_tfm(subreq, ctx->fallback.aead);
+		aead_request_set_callback(subreq, req->base.flags,
+					  req->base.complete, req->base.data);
+		aead_request_set_crypt(subreq, req->src, req->dst,
+				       req->cryptlen, req->iv);
+		aead_request_set_ad(subreq, req->assoclen);
+
+		ret = enc ? crypto_aead_encrypt(subreq) :
+			crypto_aead_decrypt(subreq);
+		return ret;
+	}
+
+	sa_req.enc_offset = req->assoclen;
+	sa_req.enc_size = enc_size;
+	sa_req.auth_size = auth_size;
+	sa_req.size = auth_size;
+	sa_req.enc_iv = iv;
+	sa_req.type = CRYPTO_ALG_TYPE_AEAD;
+	sa_req.enc = enc;
+	sa_req.callback = sa_aead_dma_in_callback;
+	sa_req.mdata_size = 52;
+	sa_req.base = &req->base;
+	sa_req.ctx = ctx;
+	sa_req.src = req->src;
+	sa_req.dst = req->dst;
+
+	return sa_run(&sa_req);
+}
+
+/* AEAD algorithm encrypt interface function */
+static int sa_aead_encrypt(struct aead_request *req)
+{
+	return sa_aead_run(req, req->iv, 1);
+}
+
+/* AEAD algorithm decrypt interface function */
+static int sa_aead_decrypt(struct aead_request *req)
+{
+	return sa_aead_run(req, req->iv, 0);
+}
+
 static struct sa_alg_tmpl sa_algs[] = {
 	{
 		.type = CRYPTO_ALG_TYPE_SKCIPHER,
@@ -1670,6 +2106,61 @@ static struct sa_alg_tmpl sa_algs[] = {
 			.import			= sa_sha_import,
 		},
 	},
+	{
+		.type	= CRYPTO_ALG_TYPE_AEAD,
+		.alg.aead = {
+			.base = {
+				.cra_name = "authenc(hmac(sha1),cbc(aes))",
+				.cra_driver_name =
+					"authenc(hmac(sha1),cbc(aes))-sa2ul",
+				.cra_blocksize = AES_BLOCK_SIZE,
+				.cra_flags = CRYPTO_ALG_TYPE_AEAD |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_ctxsize = sizeof(struct sa_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_priority = 3000,
+			},
+			.ivsize = AES_BLOCK_SIZE,
+			.maxauthsize = SHA1_DIGEST_SIZE,
+
+			.init = sa_cra_init_aead_sha1,
+			.exit = sa_exit_tfm_aead,
+			.setkey = sa_aead_cbc_sha1_setkey,
+			.setauthsize = sa_aead_setauthsize,
+			.encrypt = sa_aead_encrypt,
+			.decrypt = sa_aead_decrypt,
+		},
+	},
+	{
+		.type	= CRYPTO_ALG_TYPE_AEAD,
+		.alg.aead = {
+			.base = {
+				.cra_name = "authenc(hmac(sha256),cbc(aes))",
+				.cra_driver_name =
+					"authenc(hmac(sha256),cbc(aes))-sa2ul",
+				.cra_blocksize = AES_BLOCK_SIZE,
+				.cra_flags = CRYPTO_ALG_TYPE_AEAD |
+					CRYPTO_ALG_KERN_DRIVER_ONLY |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_ctxsize = sizeof(struct sa_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_alignmask = 0,
+				.cra_priority = 3000,
+			},
+			.ivsize = AES_BLOCK_SIZE,
+			.maxauthsize = SHA256_DIGEST_SIZE,
+
+			.init = sa_cra_init_aead_sha256,
+			.exit = sa_exit_tfm_aead,
+			.setkey = sa_aead_cbc_sha256_setkey,
+			.setauthsize = sa_aead_setauthsize,
+			.encrypt = sa_aead_encrypt,
+			.decrypt = sa_aead_decrypt,
+		},
+	},
 };
 
 /* Register the algorithms in crypto framework */
@@ -1687,6 +2178,9 @@ void sa_register_algos(const struct device *dev)
 		} else if (type == CRYPTO_ALG_TYPE_AHASH) {
 			alg_name = sa_algs[i].alg.ahash.halg.base.cra_name;
 			err = crypto_register_ahash(&sa_algs[i].alg.ahash);
+		} else if (type == CRYPTO_ALG_TYPE_AEAD) {
+			alg_name = sa_algs[i].alg.aead.base.cra_name;
+			err = crypto_register_aead(&sa_algs[i].alg.aead);
 		} else {
 			dev_err(dev,
 				"un-supported crypto algorithm (%d)",
@@ -1715,6 +2209,8 @@ void sa_unregister_algos(const struct device *dev)
 			crypto_unregister_skcipher(&sa_algs[i].alg.skcipher);
 		else if (type == CRYPTO_ALG_TYPE_AHASH)
 			crypto_unregister_ahash(&sa_algs[i].alg.ahash);
+		else if (type == CRYPTO_ALG_TYPE_AEAD)
+			crypto_unregister_aead(&sa_algs[i].alg.aead);
 
 		sa_algs[i].registered = false;
 	}
diff --git a/drivers/crypto/sa2ul.h b/drivers/crypto/sa2ul.h
index dc5e3470c3a0..7f7e3fe60d11 100644
--- a/drivers/crypto/sa2ul.h
+++ b/drivers/crypto/sa2ul.h
@@ -313,6 +313,7 @@ struct sa_tfm_ctx {
 	union {
 		struct crypto_sync_skcipher	*skcipher;
 		struct crypto_ahash		*ahash;
+		struct crypto_aead		*aead;
 	} fallback;
 };
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
