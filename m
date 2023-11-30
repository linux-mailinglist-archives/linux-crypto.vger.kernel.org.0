Return-Path: <linux-crypto+bounces-415-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599177FEF5B
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15095281DFA
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EB47A4F
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4661B3
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:27:56 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g92-005IJT-Fn; Thu, 30 Nov 2023 20:27:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:28:01 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:28:01 +0800
Subject: [PATCH 6/19] crypto: cpt - Remove cfb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g92-005IJT-Fn@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused CFB implementation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/cavium/cpt/cptvf_algs.c |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_algs.c b/drivers/crypto/cavium/cpt/cptvf_algs.c
index ee476c6c7f82..219fe9be7606 100644
--- a/drivers/crypto/cavium/cpt/cptvf_algs.c
+++ b/drivers/crypto/cavium/cpt/cptvf_algs.c
@@ -311,12 +311,6 @@ static int cvm_ecb_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
 	return cvm_setkey(cipher, key, keylen, AES_ECB);
 }
 
-static int cvm_cfb_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
-			      u32 keylen)
-{
-	return cvm_setkey(cipher, key, keylen, AES_CFB);
-}
-
 static int cvm_cbc_des3_setkey(struct crypto_skcipher *cipher, const u8 *key,
 			       u32 keylen)
 {
@@ -391,24 +385,6 @@ static struct skcipher_alg algs[] = { {
 	.encrypt		= cvm_encrypt,
 	.decrypt		= cvm_decrypt,
 	.init			= cvm_enc_dec_init,
-}, {
-	.base.cra_flags		= CRYPTO_ALG_ASYNC |
-				  CRYPTO_ALG_ALLOCATES_MEMORY,
-	.base.cra_blocksize	= AES_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct cvm_enc_ctx),
-	.base.cra_alignmask	= 7,
-	.base.cra_priority	= 4001,
-	.base.cra_name		= "cfb(aes)",
-	.base.cra_driver_name	= "cavium-cfb-aes",
-	.base.cra_module	= THIS_MODULE,
-
-	.ivsize			= AES_BLOCK_SIZE,
-	.min_keysize		= AES_MIN_KEY_SIZE,
-	.max_keysize		= AES_MAX_KEY_SIZE,
-	.setkey			= cvm_cfb_aes_setkey,
-	.encrypt		= cvm_encrypt,
-	.decrypt		= cvm_decrypt,
-	.init			= cvm_enc_dec_init,
 }, {
 	.base.cra_flags		= CRYPTO_ALG_ASYNC |
 				  CRYPTO_ALG_ALLOCATES_MEMORY,

