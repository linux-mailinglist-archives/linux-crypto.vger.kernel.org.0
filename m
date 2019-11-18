Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99A4FFF74
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Nov 2019 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRHVx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Nov 2019 02:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRHVx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Nov 2019 02:21:53 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1787820722;
        Mon, 18 Nov 2019 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574061713;
        bh=W9k5YTKo5XbpvfkP4KwDIOH2LejnN8oW+YuR6RZHo24=;
        h=From:To:Cc:Subject:Date:From;
        b=GaVt9EmTXBuPKqez2lE3ngifm54BC6F+Qjm2J5/JlXL+Z/83FIPMBR9P39R+ZrQTp
         1yeMWJ2gZdYT1VM16Ivuw7ZwJ1dxgWNOHSZLLklOqCHQ49+ZTeBCtyB2ijzq2+FexX
         SQB3c8MRMPFqSJZe6jW8y6/yW6aaciO3kbJwaUxM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: chacha_generic - remove unnecessary setkey() functions
Date:   Sun, 17 Nov 2019 23:21:29 -0800
Message-Id: <20191118072129.467514-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Use chacha20_setkey() and chacha12_setkey() from
<crypto/internal/chacha.h> instead of defining them again in
chacha_generic.c.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/chacha_generic.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/crypto/chacha_generic.c b/crypto/chacha_generic.c
index c1b147318393..8beea79ab117 100644
--- a/crypto/chacha_generic.c
+++ b/crypto/chacha_generic.c
@@ -37,18 +37,6 @@ static int chacha_stream_xor(struct skcipher_request *req,
 	return err;
 }
 
-static int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
-				  unsigned int keysize)
-{
-	return chacha_setkey(tfm, key, keysize, 20);
-}
-
-static int crypto_chacha12_setkey(struct crypto_skcipher *tfm, const u8 *key,
-				 unsigned int keysize)
-{
-	return chacha_setkey(tfm, key, keysize, 12);
-}
-
 static int crypto_chacha_crypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -91,7 +79,7 @@ static struct skcipher_alg algs[] = {
 		.max_keysize		= CHACHA_KEY_SIZE,
 		.ivsize			= CHACHA_IV_SIZE,
 		.chunksize		= CHACHA_BLOCK_SIZE,
-		.setkey			= crypto_chacha20_setkey,
+		.setkey			= chacha20_setkey,
 		.encrypt		= crypto_chacha_crypt,
 		.decrypt		= crypto_chacha_crypt,
 	}, {
@@ -106,7 +94,7 @@ static struct skcipher_alg algs[] = {
 		.max_keysize		= CHACHA_KEY_SIZE,
 		.ivsize			= XCHACHA_IV_SIZE,
 		.chunksize		= CHACHA_BLOCK_SIZE,
-		.setkey			= crypto_chacha20_setkey,
+		.setkey			= chacha20_setkey,
 		.encrypt		= crypto_xchacha_crypt,
 		.decrypt		= crypto_xchacha_crypt,
 	}, {
@@ -121,7 +109,7 @@ static struct skcipher_alg algs[] = {
 		.max_keysize		= CHACHA_KEY_SIZE,
 		.ivsize			= XCHACHA_IV_SIZE,
 		.chunksize		= CHACHA_BLOCK_SIZE,
-		.setkey			= crypto_chacha12_setkey,
+		.setkey			= chacha12_setkey,
 		.encrypt		= crypto_xchacha_crypt,
 		.decrypt		= crypto_xchacha_crypt,
 	}
-- 
2.24.0

