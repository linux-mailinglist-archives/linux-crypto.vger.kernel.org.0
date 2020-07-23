Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A322A9E6
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGWHoM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:44:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34552 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWHoM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:44:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyVtO-0005cV-6H; Thu, 23 Jul 2020 17:43:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:43:50 +1000
Date:   Thu, 23 Jul 2020 17:43:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, j-keerthy@ti.com
Subject: [PATCH] crypto: sa2ul - Fix build warnings
Message-ID: <20200723074350.GA3233@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a bunch of initialiser warnings.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index ebcdffcdb686..fc3a8268e2c8 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -916,7 +916,7 @@ static int sa_cipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			     unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 	/* Convert the key size (16/24/32) to the key size index (0/1/2) */
 	int key_idx = (keylen >> 3) - 2;
 
@@ -936,7 +936,7 @@ static int sa_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_aes_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			     unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 	/* Convert the key size (16/24/32) to the key size index (0/1/2) */
 	int key_idx = (keylen >> 3) - 2;
 
@@ -954,7 +954,7 @@ static int sa_aes_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_3des_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 
 	ad.mci_enc = mci_cbc_3des_enc_array;
 	ad.mci_dec = mci_cbc_3des_dec_array;
@@ -968,7 +968,7 @@ static int sa_3des_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_3des_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 
 	ad.mci_enc = mci_ecb_3des_enc_array;
 	ad.mci_dec = mci_ecb_3des_dec_array;
@@ -1233,7 +1233,7 @@ static int sa_cipher_run(struct skcipher_request *req, u8 *iv, int enc)
 	struct sa_tfm_ctx *ctx =
 	    crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
 	struct crypto_alg *alg = req->base.tfm->__crt_alg;
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = {};
 	int ret;
 
 	if (!req->cryptlen)
@@ -1344,7 +1344,7 @@ static int sa_sha_run(struct ahash_request *req)
 {
 	struct sa_tfm_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct sa_sha_req_ctx *rctx = ahash_request_ctx(req);
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = {};
 	size_t auth_len;
 
 	auth_len = req->nbytes;
@@ -1566,7 +1566,7 @@ static int sa_sha_export(struct ahash_request *req, void *out)
 
 static int sa_sha1_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha1");
@@ -1582,7 +1582,7 @@ static int sa_sha1_cra_init(struct crypto_tfm *tfm)
 
 static int sa_sha256_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha256");
@@ -1598,7 +1598,7 @@ static int sa_sha256_cra_init(struct crypto_tfm *tfm)
 
 static int sa_sha512_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha512");
@@ -1842,7 +1842,7 @@ static int sa_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 static int sa_aead_cbc_sha1_setkey(struct crypto_aead *authenc,
 				   const u8 *key, unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 
 	ad.ealg_id = SA_EALG_ID_AES_CBC;
 	ad.aalg_id = SA_AALG_ID_HMAC_SHA1;
@@ -1855,7 +1855,7 @@ static int sa_aead_cbc_sha1_setkey(struct crypto_aead *authenc,
 static int sa_aead_cbc_sha256_setkey(struct crypto_aead *authenc,
 				     const u8 *key, unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = {};
 
 	ad.ealg_id = SA_EALG_ID_AES_CBC;
 	ad.aalg_id = SA_AALG_ID_HMAC_SHA2_256;
@@ -1869,7 +1869,7 @@ static int sa_aead_run(struct aead_request *req, u8 *iv, int enc)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = {};
 	size_t auth_size, enc_size;
 
 	enc_size = req->cryptlen;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
