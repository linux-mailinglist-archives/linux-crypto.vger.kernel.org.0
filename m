Return-Path: <linux-crypto+bounces-425-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83B7FEF67
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669411F2021D
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F2A495C1
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B119F
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:28:15 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g9L-005IOB-C8; Thu, 30 Nov 2023 20:28:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:28:20 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:28:20 +0800
Subject: [PATCH 15/19] crypto: bcm - Remove ofb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g9L-005IOB-C8@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused OFB implementation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/bcm/cipher.c |   57 --------------------------------------------
 1 file changed, 57 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 10968ddb146b..1a3ecd44cbaf 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -3514,25 +3514,6 @@ static struct iproc_alg_s driver_algs[] = {
 	 },
 
 /* SKCIPHER algorithms. */
-	{
-	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
-	 .alg.skcipher = {
-			.base.cra_name = "ofb(des)",
-			.base.cra_driver_name = "ofb-des-iproc",
-			.base.cra_blocksize = DES_BLOCK_SIZE,
-			.min_keysize = DES_KEY_SIZE,
-			.max_keysize = DES_KEY_SIZE,
-			.ivsize = DES_BLOCK_SIZE,
-			},
-	 .cipher_info = {
-			 .alg = CIPHER_ALG_DES,
-			 .mode = CIPHER_MODE_OFB,
-			 },
-	 .auth_info = {
-		       .alg = HASH_ALG_NONE,
-		       .mode = HASH_MODE_NONE,
-		       },
-	 },
 	{
 	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
 	 .alg.skcipher = {
@@ -3571,25 +3552,6 @@ static struct iproc_alg_s driver_algs[] = {
 		       .mode = HASH_MODE_NONE,
 		       },
 	 },
-	{
-	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
-	 .alg.skcipher = {
-			.base.cra_name = "ofb(des3_ede)",
-			.base.cra_driver_name = "ofb-des3-iproc",
-			.base.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-			.min_keysize = DES3_EDE_KEY_SIZE,
-			.max_keysize = DES3_EDE_KEY_SIZE,
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			},
-	 .cipher_info = {
-			 .alg = CIPHER_ALG_3DES,
-			 .mode = CIPHER_MODE_OFB,
-			 },
-	 .auth_info = {
-		       .alg = HASH_ALG_NONE,
-		       .mode = HASH_MODE_NONE,
-		       },
-	 },
 	{
 	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
 	 .alg.skcipher = {
@@ -3628,25 +3590,6 @@ static struct iproc_alg_s driver_algs[] = {
 		       .mode = HASH_MODE_NONE,
 		       },
 	 },
-	{
-	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
-	 .alg.skcipher = {
-			.base.cra_name = "ofb(aes)",
-			.base.cra_driver_name = "ofb-aes-iproc",
-			.base.cra_blocksize = AES_BLOCK_SIZE,
-			.min_keysize = AES_MIN_KEY_SIZE,
-			.max_keysize = AES_MAX_KEY_SIZE,
-			.ivsize = AES_BLOCK_SIZE,
-			},
-	 .cipher_info = {
-			 .alg = CIPHER_ALG_AES,
-			 .mode = CIPHER_MODE_OFB,
-			 },
-	 .auth_info = {
-		       .alg = HASH_ALG_NONE,
-		       .mode = HASH_MODE_NONE,
-		       },
-	 },
 	{
 	 .type = CRYPTO_ALG_TYPE_SKCIPHER,
 	 .alg.skcipher = {

