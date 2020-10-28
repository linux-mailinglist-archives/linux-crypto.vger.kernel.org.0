Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A229E0DD
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Oct 2020 02:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgJ1WDA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 28 Oct 2020 18:03:00 -0400
Received: from foss.arm.com ([217.140.110.172]:38786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbgJ1WCP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB2D176B;
        Wed, 28 Oct 2020 05:34:40 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5697C3F719;
        Wed, 28 Oct 2020 05:34:38 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] crypto: ccree: re-introduce ccree eboiv support
Date:   Wed, 28 Oct 2020 14:34:19 +0200
Message-Id: <20201028123420.30623-5-gilad@benyossef.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028123420.30623-1-gilad@benyossef.com>
References: <20201028123420.30623-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

BitLocker eboiv support, which was removed in
commit 1d8b41ff6991 ("crypto: ccree - remove bitlocker cipher")
is reintroduced based on the crypto API new support for
eboiv.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: 1d8b41ff6991 ("crypto: ccree - remove bitlocker cipher")
---
 drivers/crypto/ccree/cc_cipher.c     | 132 +++++++++++++++++++--------
 drivers/crypto/ccree/cc_crypto_ctx.h |   1 +
 2 files changed, 96 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index dafa6577a845..a13ae60189ed 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -74,10 +74,14 @@ static int validate_keys_sizes(struct cc_cipher_ctx *ctx_p, u32 size)
 	case S_DIN_to_AES:
 		switch (size) {
 		case CC_AES_128_BIT_KEY_SIZE:
-		case CC_AES_192_BIT_KEY_SIZE:
 			if (ctx_p->cipher_mode != DRV_CIPHER_XTS)
 				return 0;
 			break;
+		case CC_AES_192_BIT_KEY_SIZE:
+			if (ctx_p->cipher_mode != DRV_CIPHER_XTS &&
+			    ctx_p->cipher_mode != DRV_CIPHER_BITLOCKER)
+				return 0;
+			break;
 		case CC_AES_256_BIT_KEY_SIZE:
 			return 0;
 		case (CC_AES_192_BIT_KEY_SIZE * 2):
@@ -120,6 +124,7 @@ static int validate_data_size(struct cc_cipher_ctx *ctx_p,
 		case DRV_CIPHER_ECB:
 		case DRV_CIPHER_CBC:
 		case DRV_CIPHER_ESSIV:
+		case DRV_CIPHER_BITLOCKER:
 			if (IS_ALIGNED(size, AES_BLOCK_SIZE))
 				return 0;
 			break;
@@ -345,7 +350,8 @@ static int cc_cipher_sethkey(struct crypto_skcipher *sktfm, const u8 *key,
 		}
 
 		if (ctx_p->cipher_mode == DRV_CIPHER_XTS ||
-		    ctx_p->cipher_mode == DRV_CIPHER_ESSIV) {
+		    ctx_p->cipher_mode == DRV_CIPHER_ESSIV ||
+		    ctx_p->cipher_mode == DRV_CIPHER_BITLOCKER) {
 			if (hki.hw_key1 == hki.hw_key2) {
 				dev_err(dev, "Illegal hw key numbers (%d,%d)\n",
 					hki.hw_key1, hki.hw_key2);
@@ -543,6 +549,7 @@ static void cc_setup_readiv_desc(struct crypto_tfm *tfm,
 		break;
 	case DRV_CIPHER_XTS:
 	case DRV_CIPHER_ESSIV:
+	case DRV_CIPHER_BITLOCKER:
 		/*  IV */
 		hw_desc_init(&desc[*seq_size]);
 		set_setup_mode(&desc[*seq_size], SETUP_WRITE_STATE1);
@@ -597,6 +604,7 @@ static void cc_setup_state_desc(struct crypto_tfm *tfm,
 		break;
 	case DRV_CIPHER_XTS:
 	case DRV_CIPHER_ESSIV:
+	case DRV_CIPHER_BITLOCKER:
 		break;
 	default:
 		dev_err(dev, "Unsupported cipher mode (%d)\n", cipher_mode);
@@ -616,56 +624,70 @@ static void cc_setup_xex_state_desc(struct crypto_tfm *tfm,
 	int flow_mode = ctx_p->flow_mode;
 	int direction = req_ctx->gen_ctx.op_type;
 	dma_addr_t key_dma_addr = ctx_p->user.key_dma_addr;
-	unsigned int key_len = (ctx_p->keylen / 2);
 	dma_addr_t iv_dma_addr = req_ctx->gen_ctx.iv_dma_addr;
-	unsigned int key_offset = key_len;
+	unsigned int key_len;
+	unsigned int key_offset;
 
 	switch (cipher_mode) {
 	case DRV_CIPHER_ECB:
-		break;
 	case DRV_CIPHER_CBC:
 	case DRV_CIPHER_CBC_CTS:
 	case DRV_CIPHER_CTR:
 	case DRV_CIPHER_OFB:
-		break;
-	case DRV_CIPHER_XTS:
-	case DRV_CIPHER_ESSIV:
+		/* No secondary key for these ciphers, so just return */
+		return;
 
-		if (cipher_mode == DRV_CIPHER_ESSIV)
-			key_len = SHA256_DIGEST_SIZE;
+	case DRV_CIPHER_XTS:
+		/* Secondary key is same size as primary key and stored after primary key */
+		key_len = ctx_p->keylen / 2;
+		key_offset = key_len;
+		break;
 
-		/* load XEX key */
-		hw_desc_init(&desc[*seq_size]);
-		set_cipher_mode(&desc[*seq_size], cipher_mode);
-		set_cipher_config0(&desc[*seq_size], direction);
-		if (cc_key_type(tfm) == CC_HW_PROTECTED_KEY) {
-			set_hw_crypto_key(&desc[*seq_size],
-					  ctx_p->hw.key2_slot);
-		} else {
-			set_din_type(&desc[*seq_size], DMA_DLLI,
-				     (key_dma_addr + key_offset),
-				     key_len, NS_BIT);
-		}
-		set_xex_data_unit_size(&desc[*seq_size], nbytes);
-		set_flow_mode(&desc[*seq_size], S_DIN_to_AES2);
-		set_key_size_aes(&desc[*seq_size], key_len);
-		set_setup_mode(&desc[*seq_size], SETUP_LOAD_XEX_KEY);
-		(*seq_size)++;
+	case DRV_CIPHER_ESSIV:
+		/* Secondary key is a digest of primary key and stored after primary key */
+		key_len = SHA256_DIGEST_SIZE;
+		key_offset = ctx_p->keylen / 2;
+		break;
 
-		/* Load IV */
-		hw_desc_init(&desc[*seq_size]);
-		set_setup_mode(&desc[*seq_size], SETUP_LOAD_STATE1);
-		set_cipher_mode(&desc[*seq_size], cipher_mode);
-		set_cipher_config0(&desc[*seq_size], direction);
-		set_key_size_aes(&desc[*seq_size], key_len);
-		set_flow_mode(&desc[*seq_size], flow_mode);
-		set_din_type(&desc[*seq_size], DMA_DLLI, iv_dma_addr,
-			     CC_AES_BLOCK_SIZE, NS_BIT);
-		(*seq_size)++;
+	case DRV_CIPHER_BITLOCKER:
+		/* Secondary key is same as primary key */
+		key_len = ctx_p->keylen;
+		key_offset = 0;
 		break;
+
 	default:
+		/* This should never really happen */
 		dev_err(dev, "Unsupported cipher mode (%d)\n", cipher_mode);
+		return;
+	}
+
+	/* load XEX key */
+	hw_desc_init(&desc[*seq_size]);
+	set_cipher_mode(&desc[*seq_size], cipher_mode);
+	set_cipher_config0(&desc[*seq_size], direction);
+	if (cc_key_type(tfm) == CC_HW_PROTECTED_KEY) {
+		set_hw_crypto_key(&desc[*seq_size],
+				  ctx_p->hw.key2_slot);
+	} else {
+		set_din_type(&desc[*seq_size], DMA_DLLI,
+			     (key_dma_addr + key_offset),
+			     key_len, NS_BIT);
 	}
+	set_xex_data_unit_size(&desc[*seq_size], nbytes);
+	set_flow_mode(&desc[*seq_size], S_DIN_to_AES2);
+	set_key_size_aes(&desc[*seq_size], key_len);
+	set_setup_mode(&desc[*seq_size], SETUP_LOAD_XEX_KEY);
+	(*seq_size)++;
+
+	/* Load IV */
+	hw_desc_init(&desc[*seq_size]);
+	set_setup_mode(&desc[*seq_size], SETUP_LOAD_STATE1);
+	set_cipher_mode(&desc[*seq_size], cipher_mode);
+	set_cipher_config0(&desc[*seq_size], direction);
+	set_key_size_aes(&desc[*seq_size], key_len);
+	set_flow_mode(&desc[*seq_size], flow_mode);
+	set_din_type(&desc[*seq_size], DMA_DLLI, iv_dma_addr, CC_AES_BLOCK_SIZE, NS_BIT);
+	(*seq_size)++;
 }
 
 static int cc_out_flow_mode(struct cc_cipher_ctx *ctx_p)
@@ -702,6 +724,7 @@ static void cc_setup_key_desc(struct crypto_tfm *tfm,
 	case DRV_CIPHER_CTR:
 	case DRV_CIPHER_OFB:
 	case DRV_CIPHER_ECB:
+	case DRV_CIPHER_BITLOCKER:
 		/* Load key */
 		hw_desc_init(&desc[*seq_size]);
 		set_cipher_mode(&desc[*seq_size], cipher_mode);
@@ -1040,6 +1063,24 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.std_body = CC_STD_NIST,
 		.sec_func = true,
 	},
+	{
+		.name = "eboiv(cbc(paes))",
+		.driver_name = "eboiv-cbc-paes-ccree",
+		.blocksize = AES_BLOCK_SIZE,
+		.template_skcipher = {
+			.setkey = cc_cipher_sethkey,
+			.encrypt = cc_cipher_encrypt,
+			.decrypt = cc_cipher_decrypt,
+			.min_keysize = CC_HW_KEY_SIZE,
+			.max_keysize = CC_HW_KEY_SIZE,
+			.ivsize = AES_BLOCK_SIZE,
+			},
+		.cipher_mode = DRV_CIPHER_BITLOCKER,
+		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_712,
+		.std_body = CC_STD_NIST,
+		.sec_func = true,
+	},
 	{
 		.name = "ecb(paes)",
 		.driver_name = "ecb-paes-ccree",
@@ -1168,6 +1209,23 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.min_hw_rev = CC_HW_REV_712,
 		.std_body = CC_STD_NIST,
 	},
+	{
+		.name = "eboiv(cbc(aes))",
+		.driver_name = "eboiv-cbc-aes-ccree",
+		.blocksize = AES_BLOCK_SIZE,
+		.template_skcipher = {
+			.setkey = cc_cipher_setkey,
+			.encrypt = cc_cipher_encrypt,
+			.decrypt = cc_cipher_decrypt,
+			.min_keysize = AES_MIN_KEY_SIZE,
+			.max_keysize = AES_MAX_KEY_SIZE,
+			.ivsize = AES_BLOCK_SIZE,
+			},
+		.cipher_mode = DRV_CIPHER_BITLOCKER,
+		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_712,
+		.std_body = CC_STD_NIST,
+	},
 	{
 		.name = "ecb(aes)",
 		.driver_name = "ecb-aes-ccree",
diff --git a/drivers/crypto/ccree/cc_crypto_ctx.h b/drivers/crypto/ccree/cc_crypto_ctx.h
index bd9a1c0896b3..ccf960a0d989 100644
--- a/drivers/crypto/ccree/cc_crypto_ctx.h
+++ b/drivers/crypto/ccree/cc_crypto_ctx.h
@@ -108,6 +108,7 @@ enum drv_cipher_mode {
 	DRV_CIPHER_CBC_CTS = 11,
 	DRV_CIPHER_GCTR = 12,
 	DRV_CIPHER_ESSIV = 13,
+	DRV_CIPHER_BITLOCKER = 14,
 	DRV_CIPHER_RESERVE32B = S32_MAX
 };
 
-- 
2.28.0

