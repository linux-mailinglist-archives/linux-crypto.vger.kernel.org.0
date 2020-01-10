Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3411136892
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jan 2020 08:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAJHx6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 02:53:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbgAJHx5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 02:53:57 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12D843CD0D3895616E35;
        Fri, 10 Jan 2020 15:53:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 15:53:45 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH 9/9] crypto: hisilicon - Add aead support on SEC2
Date:   Fri, 10 Jan 2020 15:49:58 +0800
Message-ID: <1578642598-8584-10-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578642598-8584-1-git-send-email-xuzaibo@huawei.com>
References: <1578642598-8584-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

authenc(hmac(sha1),cbc(aes)), authenc(hmac(sha256),cbc(aes)), and
authenc(hmac(sha512),cbc(aes)) support are added for SEC v2.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig           |   8 +-
 drivers/crypto/hisilicon/sec2/sec.h        |  29 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 589 +++++++++++++++++++++++++++--
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  18 +
 4 files changed, 620 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 6e7c757..8851161 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -20,12 +20,18 @@ config CRYPTO_DEV_HISI_SEC2
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	select CRYPTO_DEV_HISI_QM
+	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	depends on PCI && PCI_MSI
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	help
 	  Support for HiSilicon SEC Engine of version 2 in crypto subsystem.
 	  It provides AES, SM4, and 3DES algorithms with ECB
-	  CBC, and XTS cipher mode.
+	  CBC, and XTS cipher mode, and AEAD algorithms.
 
 	  To compile this as a module, choose M here: the module
           will be called hisi_sec2.
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 97d5150..13e2d8d 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -13,6 +13,8 @@
 struct sec_alg_res {
 	u8 *c_ivin;
 	dma_addr_t c_ivin_dma;
+	u8 *out_mac;
+	dma_addr_t out_mac_dma;
 };
 
 /* Cipher request of SEC private */
@@ -26,14 +28,21 @@ struct sec_cipher_req {
 	bool encrypt;
 };
 
+struct sec_aead_req {
+	u8 *out_mac;
+	dma_addr_t out_mac_dma;
+	struct aead_request *aead_req;
+};
+
 /* SEC request of Crypto */
 struct sec_req {
 	struct sec_sqe sec_sqe;
 	struct sec_ctx *ctx;
 	struct sec_qp_ctx *qp_ctx;
 
-	/* Cipher supported only at present */
 	struct sec_cipher_req c_req;
+	struct sec_aead_req aead_req;
+
 	int err_type;
 	int req_id;
 
@@ -60,6 +69,16 @@ struct sec_req_op {
 	int (*process)(struct sec_ctx *ctx, struct sec_req *req);
 };
 
+/* SEC auth context */
+struct sec_auth_ctx {
+	dma_addr_t a_key_dma;
+	u8 *a_key;
+	u8 a_key_len;
+	u8 mac_len;
+	u8 a_alg;
+	struct crypto_shash *hash_tfm;
+};
+
 /* SEC cipher context which cipher's relatives */
 struct sec_cipher_ctx {
 	u8 *c_key;
@@ -85,6 +104,11 @@ struct sec_qp_ctx {
 	atomic_t pending_reqs;
 };
 
+enum sec_alg_type {
+	SEC_SKCIPHER,
+	SEC_AEAD
+};
+
 /* SEC Crypto TFM context which defines queue and cipher .etc relatives */
 struct sec_ctx {
 	struct sec_qp_ctx *qp_ctx;
@@ -102,7 +126,10 @@ struct sec_ctx {
 
 	 /* Currrent cyclic index to select a queue for decipher */
 	atomic_t dec_qcyclic;
+
+	enum sec_alg_type alg_type;
 	struct sec_cipher_ctx c_ctx;
+	struct sec_auth_ctx a_ctx;
 };
 
 enum sec_endian {
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index f919dea..a0a3568 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -3,7 +3,11 @@
 
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
+#include <crypto/authenc.h>
 #include <crypto/des.h>
+#include <crypto/hash.h>
+#include <crypto/internal/aead.h>
+#include <crypto/sha.h>
 #include <crypto/skcipher.h>
 #include <crypto/xts.h>
 #include <linux/crypto.h>
@@ -27,6 +31,10 @@
 #define SEC_SRC_SGL_OFFSET	7
 #define SEC_CKEY_OFFSET		9
 #define SEC_CMODE_OFFSET	12
+#define SEC_AKEY_OFFSET         5
+#define SEC_AEAD_ALG_OFFSET     11
+#define SEC_AUTH_OFFSET		6
+
 #define SEC_FLAG_OFFSET		7
 #define SEC_FLAG_MASK		0x0780
 #define SEC_TYPE_MASK		0x0F
@@ -35,11 +43,16 @@
 #define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
 #define SEC_SGL_SGE_NR		128
 #define SEC_CTX_DEV(ctx)	(&(ctx)->sec->qm.pdev->dev)
+#define SEC_CIPHER_AUTH		0xfe
+#define SEC_AUTH_CIPHER		0x1
+#define SEC_MAX_MAC_LEN		64
+#define SEC_TOTAL_MAC_SZ	(SEC_MAX_MAC_LEN * QM_Q_DEPTH)
+#define SEC_SQE_LEN_RATE	4
 #define SEC_SQE_CFLAG		2
+#define SEC_SQE_AEAD_FLAG	3
 #define SEC_SQE_DONE		0x1
 
-static DEFINE_MUTEX(sec_algs_lock);
-static unsigned int sec_active_devs;
+static atomic_t sec_active_devs;
 
 /* Get an en/de-cipher queue cyclically to balance load over queues of TFM */
 static inline int sec_alloc_queue_id(struct sec_ctx *ctx, struct sec_req *req)
@@ -97,6 +110,27 @@ static void sec_free_req_id(struct sec_req *req)
 	mutex_unlock(&qp_ctx->req_lock);
 }
 
+static int sec_aead_verify(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
+{
+	struct aead_request *aead_req = req->aead_req.aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	u8 *mac_out = qp_ctx->res[req->req_id].out_mac;
+	size_t authsize = crypto_aead_authsize(tfm);
+	u8 *mac = mac_out + SEC_MAX_MAC_LEN;
+	struct scatterlist *sgl = aead_req->src;
+	size_t sz;
+
+	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac, authsize,
+				aead_req->cryptlen + aead_req->assoclen -
+				authsize);
+	if (unlikely(sz != authsize || memcmp(mac_out, mac, sz))) {
+		dev_err(SEC_CTX_DEV(req->ctx), "aead verify failure!\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
 static void sec_req_cb(struct hisi_qp *qp, void *resp)
 {
 	struct sec_qp_ctx *qp_ctx = qp->qp_ctx;
@@ -119,14 +153,18 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 	done = le16_to_cpu(bd->type2.done_flag) & SEC_DONE_MASK;
 	flag = (le16_to_cpu(bd->type2.done_flag) &
 		SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
-	if (req->err_type || done != SEC_SQE_DONE ||
-	    flag != SEC_SQE_CFLAG) {
+	if (unlikely(req->err_type || done != SEC_SQE_DONE ||
+	    (ctx->alg_type == SEC_SKCIPHER && flag != SEC_SQE_CFLAG) ||
+	    (ctx->alg_type == SEC_AEAD && flag != SEC_SQE_AEAD_FLAG))) {
 		dev_err(SEC_CTX_DEV(ctx),
 			"err_type[%d],done[%d],flag[%d]\n",
 			req->err_type, done, flag);
 		err = -EIO;
 	}
 
+	if (ctx->alg_type == SEC_AEAD && !req->c_req.encrypt)
+		err = sec_aead_verify(req, qp_ctx);
+
 	atomic64_inc(&ctx->sec->debug.dfx.recv_cnt);
 
 	ctx->req_op->buf_unmap(ctx, req);
@@ -182,12 +220,53 @@ static void sec_free_civ_resource(struct device *dev, struct sec_alg_res *res)
 				  res->c_ivin, res->c_ivin_dma);
 }
 
+static int sec_alloc_mac_resource(struct device *dev, struct sec_alg_res *res)
+{
+	int i;
+
+	res->out_mac = dma_alloc_coherent(dev, SEC_TOTAL_MAC_SZ << 1,
+					  &res->out_mac_dma, GFP_KERNEL);
+	if (!res->out_mac)
+		return -ENOMEM;
+
+	for (i = 1; i < QM_Q_DEPTH; i++) {
+		res[i].out_mac_dma = res->out_mac_dma +
+				     i * (SEC_MAX_MAC_LEN << 1);
+		res[i].out_mac = res->out_mac + i * (SEC_MAX_MAC_LEN << 1);
+	}
+
+	return 0;
+}
+
+static void sec_free_mac_resource(struct device *dev, struct sec_alg_res *res)
+{
+	if (res->out_mac)
+		dma_free_coherent(dev, SEC_TOTAL_MAC_SZ << 1,
+				  res->out_mac, res->out_mac_dma);
+}
+
 static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 				  struct sec_qp_ctx *qp_ctx)
 {
 	struct device *dev = SEC_CTX_DEV(ctx);
+	struct sec_alg_res *res = qp_ctx->res;
+	int ret;
+
+	ret = sec_alloc_civ_resource(dev, res);
+	if (ret)
+		return ret;
 
-	return sec_alloc_civ_resource(dev, qp_ctx->res);
+	if (ctx->alg_type == SEC_AEAD) {
+		ret = sec_alloc_mac_resource(dev, res);
+		if (ret)
+			goto get_fail;
+	}
+
+	return 0;
+get_fail:
+	sec_free_civ_resource(dev, res);
+
+	return ret;
 }
 
 static void sec_alg_resource_free(struct sec_ctx *ctx,
@@ -196,6 +275,9 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 	struct device *dev = SEC_CTX_DEV(ctx);
 
 	sec_free_civ_resource(dev, qp_ctx->res);
+
+	if (ctx->alg_type == SEC_AEAD)
+		sec_free_mac_resource(dev, qp_ctx->res);
 }
 
 static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
@@ -339,12 +421,34 @@ static void sec_cipher_uninit(struct sec_ctx *ctx)
 			  c_ctx->c_key, c_ctx->c_key_dma);
 }
 
+static int sec_auth_init(struct sec_ctx *ctx)
+{
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+
+	a_ctx->a_key = dma_alloc_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+					  &a_ctx->a_key_dma, GFP_KERNEL);
+	if (!a_ctx->a_key)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void sec_auth_uninit(struct sec_ctx *ctx)
+{
+	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
+
+	memzero_explicit(a_ctx->a_key, SEC_MAX_KEY_SIZE);
+	dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+			  a_ctx->a_key, a_ctx->a_key_dma);
+}
+
 static int sec_skcipher_init(struct crypto_skcipher *tfm)
 {
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
 	int ret;
 
 	ctx = crypto_skcipher_ctx(tfm);
+	ctx->alg_type = SEC_SKCIPHER;
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
 	ctx->c_ctx.ivsize = crypto_skcipher_ivsize(tfm);
 	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
@@ -547,6 +651,126 @@ static void sec_skcipher_sgl_unmap(struct sec_ctx *ctx, struct sec_req *req)
 	sec_cipher_unmap(dev, c_req, sk_req->src, sk_req->dst);
 }
 
+static int sec_aead_aes_set_key(struct sec_cipher_ctx *c_ctx,
+				struct crypto_authenc_keys *keys)
+{
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		c_ctx->c_key_len = SEC_CKEY_128BIT;
+		break;
+	case AES_KEYSIZE_192:
+		c_ctx->c_key_len = SEC_CKEY_192BIT;
+		break;
+	case AES_KEYSIZE_256:
+		c_ctx->c_key_len = SEC_CKEY_256BIT;
+		break;
+	default:
+		pr_err("hisi_sec2: aead aes key error!\n");
+		return -EINVAL;
+	}
+	memcpy(c_ctx->c_key, keys->enckey, keys->enckeylen);
+
+	return 0;
+}
+
+static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
+				 struct crypto_authenc_keys *keys)
+{
+	struct crypto_shash *hash_tfm = ctx->hash_tfm;
+	SHASH_DESC_ON_STACK(shash, hash_tfm);
+	int blocksize, ret;
+
+	if (!keys->authkeylen) {
+		pr_err("hisi_sec2: aead auth key error!\n");
+		return -EINVAL;
+	}
+
+	blocksize = crypto_shash_blocksize(hash_tfm);
+	if (keys->authkeylen > blocksize) {
+		ret = crypto_shash_digest(shash, keys->authkey,
+					  keys->authkeylen, ctx->a_key);
+		if (ret) {
+			pr_err("hisi_sec2: aead auth disgest error!\n");
+			return -EINVAL;
+		}
+		ctx->a_key_len = blocksize;
+	} else {
+		memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
+		ctx->a_key_len = keys->authkeylen;
+	}
+
+	return 0;
+}
+
+static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			   const u32 keylen, const enum sec_hash_alg a_alg,
+			   const enum sec_calg c_alg,
+			   const enum sec_mac_len mac_len,
+			   const enum sec_cmode c_mode)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	struct crypto_authenc_keys keys;
+	int ret;
+
+	ctx->a_ctx.a_alg = a_alg;
+	ctx->c_ctx.c_alg = c_alg;
+	ctx->a_ctx.mac_len = mac_len;
+	c_ctx->c_mode = c_mode;
+
+	if (crypto_authenc_extractkeys(&keys, key, keylen))
+		goto bad_key;
+
+	ret = sec_aead_aes_set_key(c_ctx, &keys);
+	if (ret) {
+		dev_err(SEC_CTX_DEV(ctx), "set sec cipher key err!\n");
+		goto bad_key;
+	}
+
+	ret = sec_aead_auth_set_key(&ctx->a_ctx, &keys);
+	if (ret) {
+		dev_err(SEC_CTX_DEV(ctx), "set sec auth key err!\n");
+		goto bad_key;
+	}
+
+	return 0;
+bad_key:
+	memzero_explicit(&keys, sizeof(struct crypto_authenc_keys));
+
+	return -EINVAL;
+}
+
+
+#define GEN_SEC_AEAD_SETKEY_FUNC(name, aalg, calg, maclen, cmode)	\
+static int sec_setkey_##name(struct crypto_aead *tfm, const u8 *key,	\
+	u32 keylen)							\
+{									\
+	return sec_aead_setkey(tfm, key, keylen, aalg, calg, maclen, cmode);\
+}
+
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha1, SEC_A_HMAC_SHA1,
+			 SEC_CALG_AES, SEC_HMAC_SHA1_MAC, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256,
+			 SEC_CALG_AES, SEC_HMAC_SHA256_MAC, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512,
+			 SEC_CALG_AES, SEC_HMAC_SHA512_MAC, SEC_CMODE_CBC)
+
+static int sec_aead_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct aead_request *aq = req->aead_req.aead_req;
+
+	return sec_cipher_map(SEC_CTX_DEV(ctx), req, aq->src, aq->dst);
+}
+
+static void sec_aead_sgl_unmap(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct device *dev = SEC_CTX_DEV(ctx);
+	struct sec_cipher_req *cq = &req->c_req;
+	struct aead_request *aq = req->aead_req.aead_req;
+
+	sec_cipher_unmap(dev, cq, aq->src, aq->dst);
+}
+
 static int sec_request_transfer(struct sec_ctx *ctx, struct sec_req *req)
 {
 	int ret;
@@ -629,20 +853,31 @@ static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 	return 0;
 }
 
-static void sec_update_iv(struct sec_req *req)
+static void sec_update_iv(struct sec_req *req, enum sec_alg_type alg_type)
 {
+	struct aead_request *aead_req = req->aead_req.aead_req;
 	struct skcipher_request *sk_req = req->c_req.sk_req;
 	u32 iv_size = req->ctx->c_ctx.ivsize;
 	struct scatterlist *sgl;
+	unsigned int cryptlen;
 	size_t sz;
+	u8 *iv;
 
 	if (req->c_req.encrypt)
-		sgl = sk_req->dst;
+		sgl = alg_type == SEC_SKCIPHER ? sk_req->dst : aead_req->dst;
 	else
-		sgl = sk_req->src;
+		sgl = alg_type == SEC_SKCIPHER ? sk_req->src : aead_req->src;
+
+	if (alg_type == SEC_SKCIPHER) {
+		iv = sk_req->iv;
+		cryptlen = sk_req->cryptlen;
+	} else {
+		iv = aead_req->iv;
+		cryptlen = aead_req->cryptlen;
+	}
 
-	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), sk_req->iv,
-				iv_size, sk_req->cryptlen - iv_size);
+	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), iv, iv_size,
+				cryptlen - iv_size);
 	if (unlikely(sz != iv_size))
 		dev_err(SEC_CTX_DEV(req->ctx), "copy output iv error!\n");
 }
@@ -658,7 +893,7 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 
 	/* IV output at encrypto of CBC mode */
 	if (!err && ctx->c_ctx.c_mode == SEC_CMODE_CBC && req->c_req.encrypt)
-		sec_update_iv(req);
+		sec_update_iv(req, SEC_SKCIPHER);
 
 	if (req->fake_busy)
 		sk_req->base.complete(&sk_req->base, -EINPROGRESS);
@@ -666,6 +901,102 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 	sk_req->base.complete(&sk_req->base, err);
 }
 
+static void sec_aead_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct aead_request *aead_req = req->aead_req.aead_req;
+	u8 *c_ivin = req->qp_ctx->res[req->req_id].c_ivin;
+
+	memcpy(c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
+}
+
+static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
+			       struct sec_req *req, struct sec_sqe *sec_sqe)
+{
+	struct sec_aead_req *a_req = &req->aead_req;
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct aead_request *aq = a_req->aead_req;
+
+	sec_sqe->type2.a_key_addr = cpu_to_le64(ctx->a_key_dma);
+
+	sec_sqe->type2.mac_key_alg =
+			cpu_to_le32(ctx->mac_len / SEC_SQE_LEN_RATE);
+
+	sec_sqe->type2.mac_key_alg |=
+			cpu_to_le32((u32)((ctx->a_key_len) /
+			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET);
+
+	sec_sqe->type2.mac_key_alg |=
+			cpu_to_le32((u32)(ctx->a_alg) << SEC_AEAD_ALG_OFFSET);
+
+	sec_sqe->type_cipher_auth |= SEC_AUTH_TYPE1 << SEC_AUTH_OFFSET;
+
+	if (dir)
+		sec_sqe->sds_sa_type &= SEC_CIPHER_AUTH;
+	else
+		sec_sqe->sds_sa_type |= SEC_AUTH_CIPHER;
+
+	sec_sqe->type2.alen_ivllen = cpu_to_le32(c_req->c_len + aq->assoclen);
+
+	sec_sqe->type2.cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
+
+	sec_sqe->type2.mac_addr =
+		cpu_to_le64(req->qp_ctx->res[req->req_id].out_mac_dma);
+}
+
+static int sec_aead_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_sqe *sec_sqe = &req->sec_sqe;
+	int ret;
+
+	ret = sec_skcipher_bd_fill(ctx, req);
+	if (unlikely(ret)) {
+		dev_err(SEC_CTX_DEV(ctx), "skcipher bd fill is error!\n");
+		return ret;
+	}
+
+	sec_auth_bd_fill_ex(auth_ctx, req->c_req.encrypt, req, sec_sqe);
+
+	return 0;
+}
+
+static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
+{
+	struct aead_request *a_req = req->aead_req.aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
+	struct sec_cipher_req *c_req = &req->c_req;
+	size_t authsize = crypto_aead_authsize(tfm);
+	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
+	size_t sz;
+
+	atomic_dec(&qp_ctx->pending_reqs);
+
+	if (!err && c->c_ctx.c_mode == SEC_CMODE_CBC && c_req->encrypt)
+		sec_update_iv(req, SEC_AEAD);
+
+	/* Copy output mac */
+	if (!err && c_req->encrypt) {
+		struct scatterlist *sgl = a_req->dst;
+
+		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl),
+					  qp_ctx->res[req->req_id].out_mac,
+					  authsize, a_req->cryptlen +
+					  a_req->assoclen);
+
+		if (unlikely(sz != authsize)) {
+			dev_err(SEC_CTX_DEV(req->ctx), "copy out mac err!\n");
+			err = -EINVAL;
+		}
+	}
+
+	sec_free_req_id(req);
+
+	if (req->fake_busy)
+		a_req->base.complete(&a_req->base, -EINPROGRESS);
+
+	a_req->base.complete(&a_req->base, err);
+}
+
 static void sec_request_uninit(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
@@ -712,7 +1043,7 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 
 	/* Output IV as decrypto */
 	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt)
-		sec_update_iv(req);
+		sec_update_iv(req, ctx->alg_type);
 
 	ret = ctx->req_op->bd_send(ctx, req);
 	if (unlikely(ret != -EBUSY && ret != -EINPROGRESS)) {
@@ -724,10 +1055,16 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 
 err_send_req:
 	/* As failing, restore the IV from user */
-	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt)
-		memcpy(req->c_req.sk_req->iv,
-		       req->qp_ctx->res[req->req_id].c_ivin,
-		       ctx->c_ctx.ivsize);
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt) {
+		if (ctx->alg_type == SEC_SKCIPHER)
+			memcpy(req->c_req.sk_req->iv,
+			       req->qp_ctx->res[req->req_id].c_ivin,
+			       ctx->c_ctx.ivsize);
+		else
+			memcpy(req->aead_req.aead_req->iv,
+			       req->qp_ctx->res[req->req_id].c_ivin,
+			       ctx->c_ctx.ivsize);
+	}
 
 	sec_request_untransfer(ctx, req);
 err_uninit_req:
@@ -746,6 +1083,16 @@ static const struct sec_req_op sec_skcipher_req_ops = {
 	.process	= sec_process,
 };
 
+static const struct sec_req_op sec_aead_req_ops = {
+	.buf_map	= sec_aead_sgl_map,
+	.buf_unmap	= sec_aead_sgl_unmap,
+	.do_transfer	= sec_aead_copy_iv,
+	.bd_fill	= sec_aead_bd_fill,
+	.bd_send	= sec_bd_send,
+	.callback	= sec_aead_callback,
+	.process	= sec_process,
+};
+
 static int sec_skcipher_ctx_init(struct crypto_skcipher *tfm)
 {
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -760,6 +1107,96 @@ static void sec_skcipher_ctx_exit(struct crypto_skcipher *tfm)
 	sec_skcipher_uninit(tfm);
 }
 
+static int sec_aead_init(struct crypto_aead *tfm)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct sec_req));
+	ctx->alg_type = SEC_AEAD;
+	ctx->c_ctx.ivsize = crypto_aead_ivsize(tfm);
+	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
+		dev_err(SEC_CTX_DEV(ctx), "get error aead iv size!\n");
+		return -EINVAL;
+	}
+
+	ctx->req_op = &sec_aead_req_ops;
+	ret = sec_ctx_base_init(ctx);
+	if (ret)
+		return ret;
+
+	ret = sec_auth_init(ctx);
+	if (ret)
+		goto err_auth_init;
+
+	ret = sec_cipher_init(ctx);
+	if (ret)
+		goto err_cipher_init;
+
+	return ret;
+
+err_cipher_init:
+	sec_auth_uninit(ctx);
+err_auth_init:
+	sec_ctx_base_uninit(ctx);
+
+	return ret;
+}
+
+static void sec_aead_exit(struct crypto_aead *tfm)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+
+	sec_cipher_uninit(ctx);
+	sec_auth_uninit(ctx);
+	sec_ctx_base_uninit(ctx);
+}
+
+static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	int ret;
+
+	ret = sec_aead_init(tfm);
+	if (ret) {
+		pr_err("hisi_sec2: aead init error!\n");
+		return ret;
+	}
+
+	auth_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
+	if (IS_ERR(auth_ctx->hash_tfm)) {
+		dev_err(SEC_CTX_DEV(ctx), "aead alloc shash error!\n");
+		sec_aead_exit(tfm);
+		return PTR_ERR(auth_ctx->hash_tfm);
+	}
+
+	return 0;
+}
+
+static void sec_aead_ctx_exit(struct crypto_aead *tfm)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+
+	crypto_free_shash(ctx->a_ctx.hash_tfm);
+	sec_aead_exit(tfm);
+}
+
+static int sec_aead_sha1_ctx_init(struct crypto_aead *tfm)
+{
+	return sec_aead_ctx_init(tfm, "sha1");
+}
+
+static int sec_aead_sha256_ctx_init(struct crypto_aead *tfm)
+{
+	return sec_aead_ctx_init(tfm, "sha256");
+}
+
+static int sec_aead_sha512_ctx_init(struct crypto_aead *tfm)
+{
+	return sec_aead_ctx_init(tfm, "sha512");
+}
+
 static int sec_skcipher_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	struct skcipher_request *sk_req = sreq->c_req.sk_req;
@@ -877,25 +1314,133 @@ static struct skcipher_alg sec_skciphers[] = {
 			 AES_BLOCK_SIZE, AES_BLOCK_SIZE)
 };
 
+static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
+{
+	u8 c_alg = ctx->c_ctx.c_alg;
+	struct aead_request *req = sreq->aead_req.aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	size_t authsize = crypto_aead_authsize(tfm);
+
+	if (unlikely(!req->src || !req->dst || !req->cryptlen)) {
+		dev_err(SEC_CTX_DEV(ctx), "aead input param error!\n");
+		return -EINVAL;
+	}
+
+	/* Support AES only */
+	if (unlikely(c_alg != SEC_CALG_AES)) {
+		dev_err(SEC_CTX_DEV(ctx), "aead crypto alg error!\n");
+		return -EINVAL;
+
+	}
+	if (sreq->c_req.encrypt)
+		sreq->c_req.c_len = req->cryptlen;
+	else
+		sreq->c_req.c_len = req->cryptlen - authsize;
+
+	if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
+		dev_err(SEC_CTX_DEV(ctx), "aead crypto length error!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
+	struct sec_req *req = aead_request_ctx(a_req);
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	req->aead_req.aead_req = a_req;
+	req->c_req.encrypt = encrypt;
+	req->ctx = ctx;
+
+	ret = sec_aead_param_check(ctx, req);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	return ctx->req_op->process(ctx, req);
+}
+
+static int sec_aead_encrypt(struct aead_request *a_req)
+{
+	return sec_aead_crypto(a_req, true);
+}
+
+static int sec_aead_decrypt(struct aead_request *a_req)
+{
+	return sec_aead_crypto(a_req, false);
+}
+
+#define SEC_AEAD_GEN_ALG(sec_cra_name, sec_set_key, ctx_init,\
+			 ctx_exit, blk_size, iv_size, max_authsize)\
+{\
+	.base = {\
+		.cra_name = sec_cra_name,\
+		.cra_driver_name = "hisi_sec_"sec_cra_name,\
+		.cra_priority = SEC_PRIORITY,\
+		.cra_flags = CRYPTO_ALG_ASYNC,\
+		.cra_blocksize = blk_size,\
+		.cra_ctxsize = sizeof(struct sec_ctx),\
+		.cra_module = THIS_MODULE,\
+	},\
+	.init = ctx_init,\
+	.exit = ctx_exit,\
+	.setkey = sec_set_key,\
+	.decrypt = sec_aead_decrypt,\
+	.encrypt = sec_aead_encrypt,\
+	.ivsize = iv_size,\
+	.maxauthsize = max_authsize,\
+}
+
+#define SEC_AEAD_ALG(algname, keyfunc, aead_init, blksize, ivsize, authsize)\
+	SEC_AEAD_GEN_ALG(algname, keyfunc, aead_init,\
+			sec_aead_ctx_exit, blksize, ivsize, authsize)
+
+static struct aead_alg sec_aeads[] = {
+	SEC_AEAD_ALG("authenc(hmac(sha1),cbc(aes))",
+		     sec_setkey_aes_cbc_sha1, sec_aead_sha1_ctx_init,
+		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA1_DIGEST_SIZE),
+
+	SEC_AEAD_ALG("authenc(hmac(sha256),cbc(aes))",
+		     sec_setkey_aes_cbc_sha256, sec_aead_sha256_ctx_init,
+		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA256_DIGEST_SIZE),
+
+	SEC_AEAD_ALG("authenc(hmac(sha512),cbc(aes))",
+		     sec_setkey_aes_cbc_sha512, sec_aead_sha512_ctx_init,
+		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
+};
+
 int sec_register_to_crypto(void)
 {
 	int ret = 0;
 
 	/* To avoid repeat register */
-	mutex_lock(&sec_algs_lock);
-	if (++sec_active_devs == 1)
+	if (atomic_add_return(1, &sec_active_devs) == 1) {
 		ret = crypto_register_skciphers(sec_skciphers,
 						ARRAY_SIZE(sec_skciphers));
-	mutex_unlock(&sec_algs_lock);
+		if (ret)
+			return ret;
+
+		ret = crypto_register_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
+		if (ret)
+			goto reg_aead_fail;
+	}
+
+	return ret;
+
+reg_aead_fail:
+	crypto_unregister_skciphers(sec_skciphers, ARRAY_SIZE(sec_skciphers));
 
 	return ret;
 }
 
 void sec_unregister_from_crypto(void)
 {
-	mutex_lock(&sec_algs_lock);
-	if (--sec_active_devs == 0)
+	if (atomic_sub_return(1, &sec_active_devs) == 0) {
 		crypto_unregister_skciphers(sec_skciphers,
 					    ARRAY_SIZE(sec_skciphers));
-	mutex_unlock(&sec_algs_lock);
+		crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
+	}
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 46b3a35..b2786e1 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -14,6 +14,18 @@ enum sec_calg {
 	SEC_CALG_SM4  = 0x3,
 };
 
+enum sec_hash_alg {
+	SEC_A_HMAC_SHA1   = 0x10,
+	SEC_A_HMAC_SHA256 = 0x11,
+	SEC_A_HMAC_SHA512 = 0x15,
+};
+
+enum sec_mac_len {
+	SEC_HMAC_SHA1_MAC   = 20,
+	SEC_HMAC_SHA256_MAC = 32,
+	SEC_HMAC_SHA512_MAC = 64,
+};
+
 enum sec_cmode {
 	SEC_CMODE_ECB    = 0x0,
 	SEC_CMODE_CBC    = 0x1,
@@ -34,6 +46,12 @@ enum sec_bd_type {
 	SEC_BD_TYPE2 = 0x2,
 };
 
+enum sec_auth {
+	SEC_NO_AUTH = 0x0,
+	SEC_AUTH_TYPE1 = 0x1,
+	SEC_AUTH_TYPE2 = 0x2,
+};
+
 enum sec_cipher_dir {
 	SEC_CIPHER_ENC = 0x1,
 	SEC_CIPHER_DEC = 0x2,
-- 
2.8.1

