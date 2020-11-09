Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333AF2AB26F
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Nov 2020 09:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgKIIdF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Nov 2020 03:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIIdF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Nov 2020 03:33:05 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B4020702;
        Mon,  9 Nov 2020 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604910783;
        bh=pUIpFDWHNFY98c0YYmtkCOD/dENCTpQZ1y7v+Kbd6p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkG+dKnTlwr8Mgd9+3O7wMQB9064p777+2rl7yBcXPun+CpOlTK//PRTBAt2BBQPT
         r7496FjVLW37nRgd+B3eviRNStlkpMLNcEibHmFs9vUwnMtcCRnXITo2W6HpAEMv0N
         q5e3czc3KNXSsWLaTOzzj91cCWmyE8rgUlThCMRQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] crypto: tcrypt - include 1420 byte blocks in aead and skcipher benchmarks
Date:   Mon,  9 Nov 2020 09:31:43 +0100
Message-Id: <20201109083143.2884-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109083143.2884-1-ardb@kernel.org>
References: <20201109083143.2884-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

WireGuard and IPsec both typically operate on input blocks that are
~1420 bytes in size, given the default Ethernet MTU of 1500 bytes and
the overhead of the VPN metadata.

Many aead and sckipher implementations are optimized for power-of-2
block sizes, and whether they perform well when operating on 1420
byte blocks cannot be easily extrapolated from the performance on
power-of-2 block size. So let's add 1420 bytes explicitly, and round
it up to the next blocksize multiple of the algo in question if it
does not support 1420 byte blocks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/tcrypt.c | 81 +++++++++++---------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index fc1f3e516694..a647bb298fbc 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -77,8 +77,8 @@ static const char *check[] = {
 	NULL
 };
 
-static u32 block_sizes[] = { 16, 64, 256, 1024, 1472, 8192, 0 };
-static u32 aead_sizes[] = { 16, 64, 256, 512, 1024, 2048, 4096, 8192, 0 };
+static const int block_sizes[] = { 16, 64, 256, 1024, 1420, 4096, 0 };
+static const int aead_sizes[] = { 16, 64, 256, 512, 1024, 1420, 4096, 8192, 0 };
 
 #define XBUFSIZE 8
 #define MAX_IVLEN 32
@@ -256,10 +256,10 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 	struct test_mb_aead_data *data;
 	struct crypto_aead *tfm;
 	unsigned int i, j, iv_len;
+	const int *b_size;
 	const char *key;
 	const char *e;
 	void *assoc;
-	u32 *b_size;
 	char *iv;
 	int ret;
 
@@ -337,15 +337,17 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 	do {
 		b_size = aead_sizes;
 		do {
-			if (*b_size + authsize > XBUFSIZE * PAGE_SIZE) {
+			int bs = round_up(*b_size, crypto_aead_blocksize(tfm));
+
+			if (bs + authsize > XBUFSIZE * PAGE_SIZE) {
 				pr_err("template (%u) too big for buffer (%lu)\n",
-				       authsize + *b_size,
+				       authsize + bs,
 				       XBUFSIZE * PAGE_SIZE);
 				goto out;
 			}
 
 			pr_info("test %u (%d bit key, %d byte blocks): ", i,
-				*keysize * 8, *b_size);
+				*keysize * 8, bs);
 
 			/* Set up tfm global state, i.e. the key */
 
@@ -380,11 +382,11 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 				memset(assoc, 0xff, aad_size);
 
 				sg_init_aead(cur->sg, cur->xbuf,
-					     *b_size + (enc ? 0 : authsize),
+					     bs + (enc ? 0 : authsize),
 					     assoc, aad_size);
 
 				sg_init_aead(cur->sgout, cur->xoutbuf,
-					     *b_size + (enc ? authsize : 0),
+					     bs + (enc ? authsize : 0),
 					     assoc, aad_size);
 
 				aead_request_set_ad(cur->req, aad_size);
@@ -394,7 +396,7 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 					aead_request_set_crypt(cur->req,
 							       cur->sgout,
 							       cur->sg,
-							       *b_size, iv);
+							       bs, iv);
 					ret = crypto_aead_encrypt(cur->req);
 					ret = do_one_aead_op(cur->req, ret);
 
@@ -406,18 +408,18 @@ static void test_mb_aead_speed(const char *algo, int enc, int secs,
 				}
 
 				aead_request_set_crypt(cur->req, cur->sg,
-						       cur->sgout, *b_size +
+						       cur->sgout, bs +
 						       (enc ? 0 : authsize),
 						       iv);
 
 			}
 
 			if (secs) {
-				ret = test_mb_aead_jiffies(data, enc, *b_size,
+				ret = test_mb_aead_jiffies(data, enc, bs,
 							   secs, num_mb);
 				cond_resched();
 			} else {
-				ret = test_mb_aead_cycles(data, enc, *b_size,
+				ret = test_mb_aead_cycles(data, enc, bs,
 							  num_mb);
 			}
 
@@ -534,7 +536,7 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 	char *xbuf[XBUFSIZE];
 	char *xoutbuf[XBUFSIZE];
 	char *axbuf[XBUFSIZE];
-	unsigned int *b_size;
+	const int *b_size;
 	unsigned int iv_len;
 	struct crypto_wait wait;
 
@@ -590,12 +592,14 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 	do {
 		b_size = aead_sizes;
 		do {
+			u32 bs = round_up(*b_size, crypto_aead_blocksize(tfm));
+
 			assoc = axbuf[0];
 			memset(assoc, 0xff, aad_size);
 
-			if ((*keysize + *b_size) > TVMEMSIZE * PAGE_SIZE) {
+			if ((*keysize + bs) > TVMEMSIZE * PAGE_SIZE) {
 				pr_err("template (%u) too big for tvmem (%lu)\n",
-				       *keysize + *b_size,
+				       *keysize + bs,
 					TVMEMSIZE * PAGE_SIZE);
 				goto out;
 			}
@@ -616,7 +620,7 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 
 			crypto_aead_clear_flags(tfm, ~0);
 			printk(KERN_INFO "test %u (%d bit key, %d byte blocks): ",
-					i, *keysize * 8, *b_size);
+					i, *keysize * 8, bs);
 
 
 			memset(tvmem[0], 0xff, PAGE_SIZE);
@@ -627,11 +631,11 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 				goto out;
 			}
 
-			sg_init_aead(sg, xbuf, *b_size + (enc ? 0 : authsize),
+			sg_init_aead(sg, xbuf, bs + (enc ? 0 : authsize),
 				     assoc, aad_size);
 
 			sg_init_aead(sgout, xoutbuf,
-				     *b_size + (enc ? authsize : 0), assoc,
+				     bs + (enc ? authsize : 0), assoc,
 				     aad_size);
 
 			aead_request_set_ad(req, aad_size);
@@ -644,7 +648,7 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 				 * reversed (input <-> output) to calculate it
 				 */
 				aead_request_set_crypt(req, sgout, sg,
-						       *b_size, iv);
+						       bs, iv);
 				ret = do_one_aead_op(req,
 						     crypto_aead_encrypt(req));
 
@@ -656,15 +660,15 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
 			}
 
 			aead_request_set_crypt(req, sg, sgout,
-					       *b_size + (enc ? 0 : authsize),
+					       bs + (enc ? 0 : authsize),
 					       iv);
 
 			if (secs) {
-				ret = test_aead_jiffies(req, enc, *b_size,
+				ret = test_aead_jiffies(req, enc, bs,
 							secs);
 				cond_resched();
 			} else {
-				ret = test_aead_cycles(req, enc, *b_size);
+				ret = test_aead_cycles(req, enc, bs);
 			}
 
 			if (ret) {
@@ -1253,9 +1257,9 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 	struct test_mb_skcipher_data *data;
 	struct crypto_skcipher *tfm;
 	unsigned int i, j, iv_len;
+	const int *b_size;
 	const char *key;
 	const char *e;
-	u32 *b_size;
 	char iv[128];
 	int ret;
 
@@ -1316,14 +1320,16 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 	do {
 		b_size = block_sizes;
 		do {
-			if (*b_size > XBUFSIZE * PAGE_SIZE) {
+			u32 bs = round_up(*b_size, crypto_skcipher_blocksize(tfm));
+
+			if (bs > XBUFSIZE * PAGE_SIZE) {
 				pr_err("template (%u) too big for buffer (%lu)\n",
 				       *b_size, XBUFSIZE * PAGE_SIZE);
 				goto out;
 			}
 
 			pr_info("test %u (%d bit key, %d byte blocks): ", i,
-				*keysize * 8, *b_size);
+				*keysize * 8, bs);
 
 			/* Set up tfm global state, i.e. the key */
 
@@ -1353,7 +1359,7 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 
 			for (j = 0; j < num_mb; ++j) {
 				struct test_mb_skcipher_data *cur = &data[j];
-				unsigned int k = *b_size;
+				unsigned int k = bs;
 				unsigned int pages = DIV_ROUND_UP(k, PAGE_SIZE);
 				unsigned int p = 0;
 
@@ -1377,12 +1383,12 @@ static void test_mb_skcipher_speed(const char *algo, int enc, int secs,
 
 			if (secs) {
 				ret = test_mb_acipher_jiffies(data, enc,
-							      *b_size, secs,
+							      bs, secs,
 							      num_mb);
 				cond_resched();
 			} else {
 				ret = test_mb_acipher_cycles(data, enc,
-							     *b_size, num_mb);
+							     bs, num_mb);
 			}
 
 			if (ret) {
@@ -1497,8 +1503,8 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 	char iv[128];
 	struct skcipher_request *req;
 	struct crypto_skcipher *tfm;
+	const int *b_size;
 	const char *e;
-	u32 *b_size;
 
 	if (enc == ENCRYPT)
 		e = "encryption";
@@ -1533,17 +1539,18 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 		b_size = block_sizes;
 
 		do {
+			u32 bs = round_up(*b_size, crypto_skcipher_blocksize(tfm));
 			struct scatterlist sg[TVMEMSIZE];
 
-			if ((*keysize + *b_size) > TVMEMSIZE * PAGE_SIZE) {
+			if ((*keysize + bs) > TVMEMSIZE * PAGE_SIZE) {
 				pr_err("template (%u) too big for "
-				       "tvmem (%lu)\n", *keysize + *b_size,
+				       "tvmem (%lu)\n", *keysize + bs,
 				       TVMEMSIZE * PAGE_SIZE);
 				goto out_free_req;
 			}
 
 			pr_info("test %u (%d bit key, %d byte blocks): ", i,
-				*keysize * 8, *b_size);
+				*keysize * 8, bs);
 
 			memset(tvmem[0], 0xff, PAGE_SIZE);
 
@@ -1565,7 +1572,7 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 				goto out_free_req;
 			}
 
-			k = *keysize + *b_size;
+			k = *keysize + bs;
 			sg_init_table(sg, DIV_ROUND_UP(k, PAGE_SIZE));
 
 			if (k > PAGE_SIZE) {
@@ -1582,22 +1589,22 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 				sg_set_buf(sg + j, tvmem[j], k);
 				memset(tvmem[j], 0xff, k);
 			} else {
-				sg_set_buf(sg, tvmem[0] + *keysize, *b_size);
+				sg_set_buf(sg, tvmem[0] + *keysize, bs);
 			}
 
 			iv_len = crypto_skcipher_ivsize(tfm);
 			if (iv_len)
 				memset(&iv, 0xff, iv_len);
 
-			skcipher_request_set_crypt(req, sg, sg, *b_size, iv);
+			skcipher_request_set_crypt(req, sg, sg, bs, iv);
 
 			if (secs) {
 				ret = test_acipher_jiffies(req, enc,
-							   *b_size, secs);
+							   bs, secs);
 				cond_resched();
 			} else {
 				ret = test_acipher_cycles(req, enc,
-							  *b_size);
+							  bs);
 			}
 
 			if (ret) {
-- 
2.17.1

