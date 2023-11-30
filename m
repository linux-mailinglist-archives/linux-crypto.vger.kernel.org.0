Return-Path: <linux-crypto+bounces-417-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E217FEF5E
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AE91C20A71
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3A47A4C
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96DD46
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:27:59 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g94-005IJd-JO; Thu, 30 Nov 2023 20:27:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:28:03 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:28:03 +0800
Subject: [PATCH 7/19] crypto: nitrox - Remove cfb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g94-005IJd-JO@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused CFB implementation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/cavium/nitrox/nitrox_skcipher.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
index 138261dcd032..6e5e667bab75 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
@@ -419,25 +419,6 @@ static struct skcipher_alg nitrox_skciphers[] = { {
 	.decrypt = nitrox_aes_decrypt,
 	.init = nitrox_skcipher_init,
 	.exit = nitrox_skcipher_exit,
-}, {
-	.base = {
-		.cra_name = "cfb(aes)",
-		.cra_driver_name = "n5_cfb(aes)",
-		.cra_priority = PRIO,
-		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
-		.cra_blocksize = AES_BLOCK_SIZE,
-		.cra_ctxsize = sizeof(struct nitrox_crypto_ctx),
-		.cra_alignmask = 0,
-		.cra_module = THIS_MODULE,
-	},
-	.min_keysize = AES_MIN_KEY_SIZE,
-	.max_keysize = AES_MAX_KEY_SIZE,
-	.ivsize = AES_BLOCK_SIZE,
-	.setkey = nitrox_aes_setkey,
-	.encrypt = nitrox_aes_encrypt,
-	.decrypt = nitrox_aes_decrypt,
-	.init = nitrox_skcipher_init,
-	.exit = nitrox_skcipher_exit,
 }, {
 	.base = {
 		.cra_name = "xts(aes)",

