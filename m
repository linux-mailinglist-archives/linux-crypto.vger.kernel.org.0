Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94891430B6
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2020 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATRSb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jan 2020 12:18:31 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:46681 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgATRSa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jan 2020 12:18:30 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8766bb14;
        Mon, 20 Jan 2020 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=HvQAbwx60Ybev8AGvCdsrUtFnEw=; b=3fwBtCfcixBNVDBKVlsA
        yXTR63W2ddTeicOuRGVeeCDPwJD9saAaf3zInL4jGC1F3vH1kyc1CrN/uXc33/Qb
        jxPQRwY28cVpquf45itczwEE2O6UgABG7ASt38xlWwMJhUO3KOsPr3wWVkG+JUUD
        /8eujQcSKdtOBij/QbICh5QR3i6O4KbtKUrsB34Azz/5j6TFmKd72LiKykOA/jYs
        rFRWjuUsrJEek2bKueoqFpwF93GxsjrIFxMkrWu99j3mGtT587BFOOJUEeAZopcb
        uURpd7xhsUjs/N/jMyO9IJPEo3C9LvDLxUr8ojuHwsAdfIXUiQCRpELHHm6BfHd4
        Mw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd18123b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jan 2020 16:17:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] crypto: x86/curve25519 - replace with formally verified implementation
Date:   Mon, 20 Jan 2020 18:18:15 +0100
Message-Id: <20200120171815.994089-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This comes from INRIA's HACL*/Vale. It implements the same algorithm and
implementation strategy as the code it replaces, only this code has been
formally verified, sans the base point multiplication, which uses code
similar to prior, only it uses the formally verified field arithmetic
alongside reproducable ladder generation steps. This doesn't have a
pure-bmi2 version, which means haswell no longer benefits, but the
increased (doubled) code complexity is not worth it for a single
generation of chips that's already old.

Performance-wise, this is around 1% slower on older microarchitectures,
and slightly faster on newer microarchitectures, mainly 10nm ones or
backports of 10nm to 14nm. This implementation is "everest" below:

Xeon E5-2680 v4 (Broadwell)

     armfazh: 133340 cycles per call
     everest: 133436 cycles per call

Xeon Gold 5120 (Sky Lake Server)

     armfazh: 112636 cycles per call
     everest: 113906 cycles per call

Core i5-6300U (Sky Lake Client)

     armfazh: 116810 cycles per call
     everest: 117916 cycles per call

Core i7-7600U (Kaby Lake)

     armfazh: 119523 cycles per call
     everest: 119040 cycles per call

Core i7-8750H (Coffee Lake)

     armfazh: 113914 cycles per call
     everest: 113650 cycles per call

Core i9-9880H (Coffee Lake Refresh)

     armfazh: 112616 cycles per call
     everest: 114082 cycles per call

Core i3-8121U (Cannon Lake)

     armfazh: 113202 cycles per call
     everest: 111382 cycles per call

Core i7-8265U (Whiskey Lake)

     armfazh: 127307 cycles per call
     everest: 127697 cycles per call

Core i7-8550U (Kaby Lake Refresh)

     armfazh: 127522 cycles per call
     everest: 127083 cycles per call

Xeon Platinum 8275CL (Cascade Lake)

     armfazh: 114380 cycles per call
     everest: 114656 cycles per call

Achieving these kind of results with formally verified code is quite
remarkable, especialy considering that performance is favorable for
newer chips.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/crypto/curve25519-x86_64.c | 3546 ++++++++++-----------------
 1 file changed, 1292 insertions(+), 2254 deletions(-)

diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index eec7d2d24239..e4e58b8e9afe 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1,8 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright (c) 2017 Armando Faz <armfazh@ic.unicamp.br>. All Rights Reserved.
- * Copyright (C) 2018-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- * Copyright (C) 2018 Samuel Neves <sneves@dei.uc.pt>. All Rights Reserved.
+ * Copyright (C) 2020 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ * Copyright (c) 2016-2020 INRIA, CMU and Microsoft Corporation
  */
 
 #include <crypto/curve25519.h>
@@ -16,2337 +15,1378 @@
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(curve25519_use_bmi2);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(curve25519_use_adx);
-
-enum { NUM_WORDS_ELTFP25519 = 4 };
-typedef __aligned(32) u64 eltfp25519_1w[NUM_WORDS_ELTFP25519];
-typedef __aligned(32) u64 eltfp25519_1w_buffer[2 * NUM_WORDS_ELTFP25519];
-
-#define mul_eltfp25519_1w_adx(c, a, b) do { \
-	mul_256x256_integer_adx(m.buffer, a, b); \
-	red_eltfp25519_1w_adx(c, m.buffer); \
-} while (0)
-
-#define mul_eltfp25519_1w_bmi2(c, a, b) do { \
-	mul_256x256_integer_bmi2(m.buffer, a, b); \
-	red_eltfp25519_1w_bmi2(c, m.buffer); \
-} while (0)
-
-#define sqr_eltfp25519_1w_adx(a) do { \
-	sqr_256x256_integer_adx(m.buffer, a); \
-	red_eltfp25519_1w_adx(a, m.buffer); \
-} while (0)
-
-#define sqr_eltfp25519_1w_bmi2(a) do { \
-	sqr_256x256_integer_bmi2(m.buffer, a); \
-	red_eltfp25519_1w_bmi2(a, m.buffer); \
-} while (0)
-
-#define mul_eltfp25519_2w_adx(c, a, b) do { \
-	mul2_256x256_integer_adx(m.buffer, a, b); \
-	red_eltfp25519_2w_adx(c, m.buffer); \
-} while (0)
-
-#define mul_eltfp25519_2w_bmi2(c, a, b) do { \
-	mul2_256x256_integer_bmi2(m.buffer, a, b); \
-	red_eltfp25519_2w_bmi2(c, m.buffer); \
-} while (0)
-
-#define sqr_eltfp25519_2w_adx(a) do { \
-	sqr2_256x256_integer_adx(m.buffer, a); \
-	red_eltfp25519_2w_adx(a, m.buffer); \
-} while (0)
-
-#define sqr_eltfp25519_2w_bmi2(a) do { \
-	sqr2_256x256_integer_bmi2(m.buffer, a); \
-	red_eltfp25519_2w_bmi2(a, m.buffer); \
-} while (0)
-
-#define sqrn_eltfp25519_1w_adx(a, times) do { \
-	int ____counter = (times); \
-	while (____counter-- > 0) \
-		sqr_eltfp25519_1w_adx(a); \
-} while (0)
-
-#define sqrn_eltfp25519_1w_bmi2(a, times) do { \
-	int ____counter = (times); \
-	while (____counter-- > 0) \
-		sqr_eltfp25519_1w_bmi2(a); \
-} while (0)
-
-#define copy_eltfp25519_1w(C, A) do { \
-	(C)[0] = (A)[0]; \
-	(C)[1] = (A)[1]; \
-	(C)[2] = (A)[2]; \
-	(C)[3] = (A)[3]; \
-} while (0)
-
-#define setzero_eltfp25519_1w(C) do { \
-	(C)[0] = 0; \
-	(C)[1] = 0; \
-	(C)[2] = 0; \
-	(C)[3] = 0; \
-} while (0)
-
-__aligned(32) static const u64 table_ladder_8k[252 * NUM_WORDS_ELTFP25519] = {
-	/*   1 */ 0xfffffffffffffff3UL, 0xffffffffffffffffUL,
-		  0xffffffffffffffffUL, 0x5fffffffffffffffUL,
-	/*   2 */ 0x6b8220f416aafe96UL, 0x82ebeb2b4f566a34UL,
-		  0xd5a9a5b075a5950fUL, 0x5142b2cf4b2488f4UL,
-	/*   3 */ 0x6aaebc750069680cUL, 0x89cf7820a0f99c41UL,
-		  0x2a58d9183b56d0f4UL, 0x4b5aca80e36011a4UL,
-	/*   4 */ 0x329132348c29745dUL, 0xf4a2e616e1642fd7UL,
-		  0x1e45bb03ff67bc34UL, 0x306912d0f42a9b4aUL,
-	/*   5 */ 0xff886507e6af7154UL, 0x04f50e13dfeec82fUL,
-		  0xaa512fe82abab5ceUL, 0x174e251a68d5f222UL,
-	/*   6 */ 0xcf96700d82028898UL, 0x1743e3370a2c02c5UL,
-		  0x379eec98b4e86eaaUL, 0x0c59888a51e0482eUL,
-	/*   7 */ 0xfbcbf1d699b5d189UL, 0xacaef0d58e9fdc84UL,
-		  0xc1c20d06231f7614UL, 0x2938218da274f972UL,
-	/*   8 */ 0xf6af49beff1d7f18UL, 0xcc541c22387ac9c2UL,
-		  0x96fcc9ef4015c56bUL, 0x69c1627c690913a9UL,
-	/*   9 */ 0x7a86fd2f4733db0eUL, 0xfdb8c4f29e087de9UL,
-		  0x095e4b1a8ea2a229UL, 0x1ad7a7c829b37a79UL,
-	/*  10 */ 0x342d89cad17ea0c0UL, 0x67bedda6cced2051UL,
-		  0x19ca31bf2bb42f74UL, 0x3df7b4c84980acbbUL,
-	/*  11 */ 0xa8c6444dc80ad883UL, 0xb91e440366e3ab85UL,
-		  0xc215cda00164f6d8UL, 0x3d867c6ef247e668UL,
-	/*  12 */ 0xc7dd582bcc3e658cUL, 0xfd2c4748ee0e5528UL,
-		  0xa0fd9b95cc9f4f71UL, 0x7529d871b0675ddfUL,
-	/*  13 */ 0xb8f568b42d3cbd78UL, 0x1233011b91f3da82UL,
-		  0x2dce6ccd4a7c3b62UL, 0x75e7fc8e9e498603UL,
-	/*  14 */ 0x2f4f13f1fcd0b6ecUL, 0xf1a8ca1f29ff7a45UL,
-		  0xc249c1a72981e29bUL, 0x6ebe0dbb8c83b56aUL,
-	/*  15 */ 0x7114fa8d170bb222UL, 0x65a2dcd5bf93935fUL,
-		  0xbdc41f68b59c979aUL, 0x2f0eef79a2ce9289UL,
-	/*  16 */ 0x42ecbf0c083c37ceUL, 0x2930bc09ec496322UL,
-		  0xf294b0c19cfeac0dUL, 0x3780aa4bedfabb80UL,
-	/*  17 */ 0x56c17d3e7cead929UL, 0xe7cb4beb2e5722c5UL,
-		  0x0ce931732dbfe15aUL, 0x41b883c7621052f8UL,
-	/*  18 */ 0xdbf75ca0c3d25350UL, 0x2936be086eb1e351UL,
-		  0xc936e03cb4a9b212UL, 0x1d45bf82322225aaUL,
-	/*  19 */ 0xe81ab1036a024cc5UL, 0xe212201c304c9a72UL,
-		  0xc5d73fba6832b1fcUL, 0x20ffdb5a4d839581UL,
-	/*  20 */ 0xa283d367be5d0fadUL, 0x6c2b25ca8b164475UL,
-		  0x9d4935467caaf22eUL, 0x5166408eee85ff49UL,
-	/*  21 */ 0x3c67baa2fab4e361UL, 0xb3e433c67ef35cefUL,
-		  0x5259729241159b1cUL, 0x6a621892d5b0ab33UL,
-	/*  22 */ 0x20b74a387555cdcbUL, 0x532aa10e1208923fUL,
-		  0xeaa17b7762281dd1UL, 0x61ab3443f05c44bfUL,
-	/*  23 */ 0x257a6c422324def8UL, 0x131c6c1017e3cf7fUL,
-		  0x23758739f630a257UL, 0x295a407a01a78580UL,
-	/*  24 */ 0xf8c443246d5da8d9UL, 0x19d775450c52fa5dUL,
-		  0x2afcfc92731bf83dUL, 0x7d10c8e81b2b4700UL,
-	/*  25 */ 0xc8e0271f70baa20bUL, 0x993748867ca63957UL,
-		  0x5412efb3cb7ed4bbUL, 0x3196d36173e62975UL,
-	/*  26 */ 0xde5bcad141c7dffcUL, 0x47cc8cd2b395c848UL,
-		  0xa34cd942e11af3cbUL, 0x0256dbf2d04ecec2UL,
-	/*  27 */ 0x875ab7e94b0e667fUL, 0xcad4dd83c0850d10UL,
-		  0x47f12e8f4e72c79fUL, 0x5f1a87bb8c85b19bUL,
-	/*  28 */ 0x7ae9d0b6437f51b8UL, 0x12c7ce5518879065UL,
-		  0x2ade09fe5cf77aeeUL, 0x23a05a2f7d2c5627UL,
-	/*  29 */ 0x5908e128f17c169aUL, 0xf77498dd8ad0852dUL,
-		  0x74b4c4ceab102f64UL, 0x183abadd10139845UL,
-	/*  30 */ 0xb165ba8daa92aaacUL, 0xd5c5ef9599386705UL,
-		  0xbe2f8f0cf8fc40d1UL, 0x2701e635ee204514UL,
-	/*  31 */ 0x629fa80020156514UL, 0xf223868764a8c1ceUL,
-		  0x5b894fff0b3f060eUL, 0x60d9944cf708a3faUL,
-	/*  32 */ 0xaeea001a1c7a201fUL, 0xebf16a633ee2ce63UL,
-		  0x6f7709594c7a07e1UL, 0x79b958150d0208cbUL,
-	/*  33 */ 0x24b55e5301d410e7UL, 0xe3a34edff3fdc84dUL,
-		  0xd88768e4904032d8UL, 0x131384427b3aaeecUL,
-	/*  34 */ 0x8405e51286234f14UL, 0x14dc4739adb4c529UL,
-		  0xb8a2b5b250634ffdUL, 0x2fe2a94ad8a7ff93UL,
-	/*  35 */ 0xec5c57efe843faddUL, 0x2843ce40f0bb9918UL,
-		  0xa4b561d6cf3d6305UL, 0x743629bde8fb777eUL,
-	/*  36 */ 0x343edd46bbaf738fUL, 0xed981828b101a651UL,
-		  0xa401760b882c797aUL, 0x1fc223e28dc88730UL,
-	/*  37 */ 0x48604e91fc0fba0eUL, 0xb637f78f052c6fa4UL,
-		  0x91ccac3d09e9239cUL, 0x23f7eed4437a687cUL,
-	/*  38 */ 0x5173b1118d9bd800UL, 0x29d641b63189d4a7UL,
-		  0xfdbf177988bbc586UL, 0x2959894fcad81df5UL,
-	/*  39 */ 0xaebc8ef3b4bbc899UL, 0x4148995ab26992b9UL,
-		  0x24e20b0134f92cfbUL, 0x40d158894a05dee8UL,
-	/*  40 */ 0x46b00b1185af76f6UL, 0x26bac77873187a79UL,
-		  0x3dc0bf95ab8fff5fUL, 0x2a608bd8945524d7UL,
-	/*  41 */ 0x26449588bd446302UL, 0x7c4bc21c0388439cUL,
-		  0x8e98a4f383bd11b2UL, 0x26218d7bc9d876b9UL,
-	/*  42 */ 0xe3081542997c178aUL, 0x3c2d29a86fb6606fUL,
-		  0x5c217736fa279374UL, 0x7dde05734afeb1faUL,
-	/*  43 */ 0x3bf10e3906d42babUL, 0xe4f7803e1980649cUL,
-		  0xe6053bf89595bf7aUL, 0x394faf38da245530UL,
-	/*  44 */ 0x7a8efb58896928f4UL, 0xfbc778e9cc6a113cUL,
-		  0x72670ce330af596fUL, 0x48f222a81d3d6cf7UL,
-	/*  45 */ 0xf01fce410d72caa7UL, 0x5a20ecc7213b5595UL,
-		  0x7bc21165c1fa1483UL, 0x07f89ae31da8a741UL,
-	/*  46 */ 0x05d2c2b4c6830ff9UL, 0xd43e330fc6316293UL,
-		  0xa5a5590a96d3a904UL, 0x705edb91a65333b6UL,
-	/*  47 */ 0x048ee15e0bb9a5f7UL, 0x3240cfca9e0aaf5dUL,
-		  0x8f4b71ceedc4a40bUL, 0x621c0da3de544a6dUL,
-	/*  48 */ 0x92872836a08c4091UL, 0xce8375b010c91445UL,
-		  0x8a72eb524f276394UL, 0x2667fcfa7ec83635UL,
-	/*  49 */ 0x7f4c173345e8752aUL, 0x061b47feee7079a5UL,
-		  0x25dd9afa9f86ff34UL, 0x3780cef5425dc89cUL,
-	/*  50 */ 0x1a46035a513bb4e9UL, 0x3e1ef379ac575adaUL,
-		  0xc78c5f1c5fa24b50UL, 0x321a967634fd9f22UL,
-	/*  51 */ 0x946707b8826e27faUL, 0x3dca84d64c506fd0UL,
-		  0xc189218075e91436UL, 0x6d9284169b3b8484UL,
-	/*  52 */ 0x3a67e840383f2ddfUL, 0x33eec9a30c4f9b75UL,
-		  0x3ec7c86fa783ef47UL, 0x26ec449fbac9fbc4UL,
-	/*  53 */ 0x5c0f38cba09b9e7dUL, 0x81168cc762a3478cUL,
-		  0x3e23b0d306fc121cUL, 0x5a238aa0a5efdcddUL,
-	/*  54 */ 0x1ba26121c4ea43ffUL, 0x36f8c77f7c8832b5UL,
-		  0x88fbea0b0adcf99aUL, 0x5ca9938ec25bebf9UL,
-	/*  55 */ 0xd5436a5e51fccda0UL, 0x1dbc4797c2cd893bUL,
-		  0x19346a65d3224a08UL, 0x0f5034e49b9af466UL,
-	/*  56 */ 0xf23c3967a1e0b96eUL, 0xe58b08fa867a4d88UL,
-		  0xfb2fabc6a7341679UL, 0x2a75381eb6026946UL,
-	/*  57 */ 0xc80a3be4c19420acUL, 0x66b1f6c681f2b6dcUL,
-		  0x7cf7036761e93388UL, 0x25abbbd8a660a4c4UL,
-	/*  58 */ 0x91ea12ba14fd5198UL, 0x684950fc4a3cffa9UL,
-		  0xf826842130f5ad28UL, 0x3ea988f75301a441UL,
-	/*  59 */ 0xc978109a695f8c6fUL, 0x1746eb4a0530c3f3UL,
-		  0x444d6d77b4459995UL, 0x75952b8c054e5cc7UL,
-	/*  60 */ 0xa3703f7915f4d6aaUL, 0x66c346202f2647d8UL,
-		  0xd01469df811d644bUL, 0x77fea47d81a5d71fUL,
-	/*  61 */ 0xc5e9529ef57ca381UL, 0x6eeeb4b9ce2f881aUL,
-		  0xb6e91a28e8009bd6UL, 0x4b80be3e9afc3fecUL,
-	/*  62 */ 0x7e3773c526aed2c5UL, 0x1b4afcb453c9a49dUL,
-		  0xa920bdd7baffb24dUL, 0x7c54699f122d400eUL,
-	/*  63 */ 0xef46c8e14fa94bc8UL, 0xe0b074ce2952ed5eUL,
-		  0xbea450e1dbd885d5UL, 0x61b68649320f712cUL,
-	/*  64 */ 0x8a485f7309ccbdd1UL, 0xbd06320d7d4d1a2dUL,
-		  0x25232973322dbef4UL, 0x445dc4758c17f770UL,
-	/*  65 */ 0xdb0434177cc8933cUL, 0xed6fe82175ea059fUL,
-		  0x1efebefdc053db34UL, 0x4adbe867c65daf99UL,
-	/*  66 */ 0x3acd71a2a90609dfUL, 0xe5e991856dd04050UL,
-		  0x1ec69b688157c23cUL, 0x697427f6885cfe4dUL,
-	/*  67 */ 0xd7be7b9b65e1a851UL, 0xa03d28d522c536ddUL,
-		  0x28399d658fd2b645UL, 0x49e5b7e17c2641e1UL,
-	/*  68 */ 0x6f8c3a98700457a4UL, 0x5078f0a25ebb6778UL,
-		  0xd13c3ccbc382960fUL, 0x2e003258a7df84b1UL,
-	/*  69 */ 0x8ad1f39be6296a1cUL, 0xc1eeaa652a5fbfb2UL,
-		  0x33ee0673fd26f3cbUL, 0x59256173a69d2cccUL,
-	/*  70 */ 0x41ea07aa4e18fc41UL, 0xd9fc19527c87a51eUL,
-		  0xbdaacb805831ca6fUL, 0x445b652dc916694fUL,
-	/*  71 */ 0xce92a3a7f2172315UL, 0x1edc282de11b9964UL,
-		  0xa1823aafe04c314aUL, 0x790a2d94437cf586UL,
-	/*  72 */ 0x71c447fb93f6e009UL, 0x8922a56722845276UL,
-		  0xbf70903b204f5169UL, 0x2f7a89891ba319feUL,
-	/*  73 */ 0x02a08eb577e2140cUL, 0xed9a4ed4427bdcf4UL,
-		  0x5253ec44e4323cd1UL, 0x3e88363c14e9355bUL,
-	/*  74 */ 0xaa66c14277110b8cUL, 0x1ae0391610a23390UL,
-		  0x2030bd12c93fc2a2UL, 0x3ee141579555c7abUL,
-	/*  75 */ 0x9214de3a6d6e7d41UL, 0x3ccdd88607f17efeUL,
-		  0x674f1288f8e11217UL, 0x5682250f329f93d0UL,
-	/*  76 */ 0x6cf00b136d2e396eUL, 0x6e4cf86f1014debfUL,
-		  0x5930b1b5bfcc4e83UL, 0x047069b48aba16b6UL,
-	/*  77 */ 0x0d4ce4ab69b20793UL, 0xb24db91a97d0fb9eUL,
-		  0xcdfa50f54e00d01dUL, 0x221b1085368bddb5UL,
-	/*  78 */ 0xe7e59468b1e3d8d2UL, 0x53c56563bd122f93UL,
-		  0xeee8a903e0663f09UL, 0x61efa662cbbe3d42UL,
-	/*  79 */ 0x2cf8ddddde6eab2aUL, 0x9bf80ad51435f231UL,
-		  0x5deadacec9f04973UL, 0x29275b5d41d29b27UL,
-	/*  80 */ 0xcfde0f0895ebf14fUL, 0xb9aab96b054905a7UL,
-		  0xcae80dd9a1c420fdUL, 0x0a63bf2f1673bbc7UL,
-	/*  81 */ 0x092f6e11958fbc8cUL, 0x672a81e804822fadUL,
-		  0xcac8351560d52517UL, 0x6f3f7722c8f192f8UL,
-	/*  82 */ 0xf8ba90ccc2e894b7UL, 0x2c7557a438ff9f0dUL,
-		  0x894d1d855ae52359UL, 0x68e122157b743d69UL,
-	/*  83 */ 0xd87e5570cfb919f3UL, 0x3f2cdecd95798db9UL,
-		  0x2121154710c0a2ceUL, 0x3c66a115246dc5b2UL,
-	/*  84 */ 0xcbedc562294ecb72UL, 0xba7143c36a280b16UL,
-		  0x9610c2efd4078b67UL, 0x6144735d946a4b1eUL,
-	/*  85 */ 0x536f111ed75b3350UL, 0x0211db8c2041d81bUL,
-		  0xf93cb1000e10413cUL, 0x149dfd3c039e8876UL,
-	/*  86 */ 0xd479dde46b63155bUL, 0xb66e15e93c837976UL,
-		  0xdafde43b1f13e038UL, 0x5fafda1a2e4b0b35UL,
-	/*  87 */ 0x3600bbdf17197581UL, 0x3972050bbe3cd2c2UL,
-		  0x5938906dbdd5be86UL, 0x34fce5e43f9b860fUL,
-	/*  88 */ 0x75a8a4cd42d14d02UL, 0x828dabc53441df65UL,
-		  0x33dcabedd2e131d3UL, 0x3ebad76fb814d25fUL,
-	/*  89 */ 0xd4906f566f70e10fUL, 0x5d12f7aa51690f5aUL,
-		  0x45adb16e76cefcf2UL, 0x01f768aead232999UL,
-	/*  90 */ 0x2b6cc77b6248febdUL, 0x3cd30628ec3aaffdUL,
-		  0xce1c0b80d4ef486aUL, 0x4c3bff2ea6f66c23UL,
-	/*  91 */ 0x3f2ec4094aeaeb5fUL, 0x61b19b286e372ca7UL,
-		  0x5eefa966de2a701dUL, 0x23b20565de55e3efUL,
-	/*  92 */ 0xe301ca5279d58557UL, 0x07b2d4ce27c2874fUL,
-		  0xa532cd8a9dcf1d67UL, 0x2a52fee23f2bff56UL,
-	/*  93 */ 0x8624efb37cd8663dUL, 0xbbc7ac20ffbd7594UL,
-		  0x57b85e9c82d37445UL, 0x7b3052cb86a6ec66UL,
-	/*  94 */ 0x3482f0ad2525e91eUL, 0x2cb68043d28edca0UL,
-		  0xaf4f6d052e1b003aUL, 0x185f8c2529781b0aUL,
-	/*  95 */ 0xaa41de5bd80ce0d6UL, 0x9407b2416853e9d6UL,
-		  0x563ec36e357f4c3aUL, 0x4cc4b8dd0e297bceUL,
-	/*  96 */ 0xa2fc1a52ffb8730eUL, 0x1811f16e67058e37UL,
-		  0x10f9a366cddf4ee1UL, 0x72f4a0c4a0b9f099UL,
-	/*  97 */ 0x8c16c06f663f4ea7UL, 0x693b3af74e970fbaUL,
-		  0x2102e7f1d69ec345UL, 0x0ba53cbc968a8089UL,
-	/*  98 */ 0xca3d9dc7fea15537UL, 0x4c6824bb51536493UL,
-		  0xb9886314844006b1UL, 0x40d2a72ab454cc60UL,
-	/*  99 */ 0x5936a1b712570975UL, 0x91b9d648debda657UL,
-		  0x3344094bb64330eaUL, 0x006ba10d12ee51d0UL,
-	/* 100 */ 0x19228468f5de5d58UL, 0x0eb12f4c38cc05b0UL,
-		  0xa1039f9dd5601990UL, 0x4502d4ce4fff0e0bUL,
-	/* 101 */ 0xeb2054106837c189UL, 0xd0f6544c6dd3b93cUL,
-		  0x40727064c416d74fUL, 0x6e15c6114b502ef0UL,
-	/* 102 */ 0x4df2a398cfb1a76bUL, 0x11256c7419f2f6b1UL,
-		  0x4a497962066e6043UL, 0x705b3aab41355b44UL,
-	/* 103 */ 0x365ef536d797b1d8UL, 0x00076bd622ddf0dbUL,
-		  0x3bbf33b0e0575a88UL, 0x3777aa05c8e4ca4dUL,
-	/* 104 */ 0x392745c85578db5fUL, 0x6fda4149dbae5ae2UL,
-		  0xb1f0b00b8adc9867UL, 0x09963437d36f1da3UL,
-	/* 105 */ 0x7e824e90a5dc3853UL, 0xccb5f6641f135cbdUL,
-		  0x6736d86c87ce8fccUL, 0x625f3ce26604249fUL,
-	/* 106 */ 0xaf8ac8059502f63fUL, 0x0c05e70a2e351469UL,
-		  0x35292e9c764b6305UL, 0x1a394360c7e23ac3UL,
-	/* 107 */ 0xd5c6d53251183264UL, 0x62065abd43c2b74fUL,
-		  0xb5fbf5d03b973f9bUL, 0x13a3da3661206e5eUL,
-	/* 108 */ 0xc6bd5837725d94e5UL, 0x18e30912205016c5UL,
-		  0x2088ce1570033c68UL, 0x7fba1f495c837987UL,
-	/* 109 */ 0x5a8c7423f2f9079dUL, 0x1735157b34023fc5UL,
-		  0xe4f9b49ad2fab351UL, 0x6691ff72c878e33cUL,
-	/* 110 */ 0x122c2adedc5eff3eUL, 0xf8dd4bf1d8956cf4UL,
-		  0xeb86205d9e9e5bdaUL, 0x049b92b9d975c743UL,
-	/* 111 */ 0xa5379730b0f6c05aUL, 0x72a0ffacc6f3a553UL,
-		  0xb0032c34b20dcd6dUL, 0x470e9dbc88d5164aUL,
-	/* 112 */ 0xb19cf10ca237c047UL, 0xb65466711f6c81a2UL,
-		  0xb3321bd16dd80b43UL, 0x48c14f600c5fbe8eUL,
-	/* 113 */ 0x66451c264aa6c803UL, 0xb66e3904a4fa7da6UL,
-		  0xd45f19b0b3128395UL, 0x31602627c3c9bc10UL,
-	/* 114 */ 0x3120dc4832e4e10dUL, 0xeb20c46756c717f7UL,
-		  0x00f52e3f67280294UL, 0x566d4fc14730c509UL,
-	/* 115 */ 0x7e3a5d40fd837206UL, 0xc1e926dc7159547aUL,
-		  0x216730fba68d6095UL, 0x22e8c3843f69cea7UL,
-	/* 116 */ 0x33d074e8930e4b2bUL, 0xb6e4350e84d15816UL,
-		  0x5534c26ad6ba2365UL, 0x7773c12f89f1f3f3UL,
-	/* 117 */ 0x8cba404da57962aaUL, 0x5b9897a81999ce56UL,
-		  0x508e862f121692fcUL, 0x3a81907fa093c291UL,
-	/* 118 */ 0x0dded0ff4725a510UL, 0x10d8cc10673fc503UL,
-		  0x5b9d151c9f1f4e89UL, 0x32a5c1d5cb09a44cUL,
-	/* 119 */ 0x1e0aa442b90541fbUL, 0x5f85eb7cc1b485dbUL,
-		  0xbee595ce8a9df2e5UL, 0x25e496c722422236UL,
-	/* 120 */ 0x5edf3c46cd0fe5b9UL, 0x34e75a7ed2a43388UL,
-		  0xe488de11d761e352UL, 0x0e878a01a085545cUL,
-	/* 121 */ 0xba493c77e021bb04UL, 0x2b4d1843c7df899aUL,
-		  0x9ea37a487ae80d67UL, 0x67a9958011e41794UL,
-	/* 122 */ 0x4b58051a6697b065UL, 0x47e33f7d8d6ba6d4UL,
-		  0xbb4da8d483ca46c1UL, 0x68becaa181c2db0dUL,
-	/* 123 */ 0x8d8980e90b989aa5UL, 0xf95eb14a2c93c99bUL,
-		  0x51c6c7c4796e73a2UL, 0x6e228363b5efb569UL,
-	/* 124 */ 0xc6bbc0b02dd624c8UL, 0x777eb47dec8170eeUL,
-		  0x3cde15a004cfafa9UL, 0x1dc6bc087160bf9bUL,
-	/* 125 */ 0x2e07e043eec34002UL, 0x18e9fc677a68dc7fUL,
-		  0xd8da03188bd15b9aUL, 0x48fbc3bb00568253UL,
-	/* 126 */ 0x57547d4cfb654ce1UL, 0xd3565b82a058e2adUL,
-		  0xf63eaf0bbf154478UL, 0x47531ef114dfbb18UL,
-	/* 127 */ 0xe1ec630a4278c587UL, 0x5507d546ca8e83f3UL,
-		  0x85e135c63adc0c2bUL, 0x0aa7efa85682844eUL,
-	/* 128 */ 0x72691ba8b3e1f615UL, 0x32b4e9701fbe3ffaUL,
-		  0x97b6d92e39bb7868UL, 0x2cfe53dea02e39e8UL,
-	/* 129 */ 0x687392cd85cd52b0UL, 0x27ff66c910e29831UL,
-		  0x97134556a9832d06UL, 0x269bb0360a84f8a0UL,
-	/* 130 */ 0x706e55457643f85cUL, 0x3734a48c9b597d1bUL,
-		  0x7aee91e8c6efa472UL, 0x5cd6abc198a9d9e0UL,
-	/* 131 */ 0x0e04de06cb3ce41aUL, 0xd8c6eb893402e138UL,
-		  0x904659bb686e3772UL, 0x7215c371746ba8c8UL,
-	/* 132 */ 0xfd12a97eeae4a2d9UL, 0x9514b7516394f2c5UL,
-		  0x266fd5809208f294UL, 0x5c847085619a26b9UL,
-	/* 133 */ 0x52985410fed694eaUL, 0x3c905b934a2ed254UL,
-		  0x10bb47692d3be467UL, 0x063b3d2d69e5e9e1UL,
-	/* 134 */ 0x472726eedda57debUL, 0xefb6c4ae10f41891UL,
-		  0x2b1641917b307614UL, 0x117c554fc4f45b7cUL,
-	/* 135 */ 0xc07cf3118f9d8812UL, 0x01dbd82050017939UL,
-		  0xd7e803f4171b2827UL, 0x1015e87487d225eaUL,
-	/* 136 */ 0xc58de3fed23acc4dUL, 0x50db91c294a7be2dUL,
-		  0x0b94d43d1c9cf457UL, 0x6b1640fa6e37524aUL,
-	/* 137 */ 0x692f346c5fda0d09UL, 0x200b1c59fa4d3151UL,
-		  0xb8c46f760777a296UL, 0x4b38395f3ffdfbcfUL,
-	/* 138 */ 0x18d25e00be54d671UL, 0x60d50582bec8aba6UL,
-		  0x87ad8f263b78b982UL, 0x50fdf64e9cda0432UL,
-	/* 139 */ 0x90f567aac578dcf0UL, 0xef1e9b0ef2a3133bUL,
-		  0x0eebba9242d9de71UL, 0x15473c9bf03101c7UL,
-	/* 140 */ 0x7c77e8ae56b78095UL, 0xb678e7666e6f078eUL,
-		  0x2da0b9615348ba1fUL, 0x7cf931c1ff733f0bUL,
-	/* 141 */ 0x26b357f50a0a366cUL, 0xe9708cf42b87d732UL,
-		  0xc13aeea5f91cb2c0UL, 0x35d90c991143bb4cUL,
-	/* 142 */ 0x47c1c404a9a0d9dcUL, 0x659e58451972d251UL,
-		  0x3875a8c473b38c31UL, 0x1fbd9ed379561f24UL,
-	/* 143 */ 0x11fabc6fd41ec28dUL, 0x7ef8dfe3cd2a2dcaUL,
-		  0x72e73b5d8c404595UL, 0x6135fa4954b72f27UL,
-	/* 144 */ 0xccfc32a2de24b69cUL, 0x3f55698c1f095d88UL,
-		  0xbe3350ed5ac3f929UL, 0x5e9bf806ca477eebUL,
-	/* 145 */ 0xe9ce8fb63c309f68UL, 0x5376f63565e1f9f4UL,
-		  0xd1afcfb35a6393f1UL, 0x6632a1ede5623506UL,
-	/* 146 */ 0x0b7d6c390c2ded4cUL, 0x56cb3281df04cb1fUL,
-		  0x66305a1249ecc3c7UL, 0x5d588b60a38ca72aUL,
-	/* 147 */ 0xa6ecbf78e8e5f42dUL, 0x86eeb44b3c8a3eecUL,
-		  0xec219c48fbd21604UL, 0x1aaf1af517c36731UL,
-	/* 148 */ 0xc306a2836769bde7UL, 0x208280622b1e2adbUL,
-		  0x8027f51ffbff94a6UL, 0x76cfa1ce1124f26bUL,
-	/* 149 */ 0x18eb00562422abb6UL, 0xf377c4d58f8c29c3UL,
-		  0x4dbbc207f531561aUL, 0x0253b7f082128a27UL,
-	/* 150 */ 0x3d1f091cb62c17e0UL, 0x4860e1abd64628a9UL,
-		  0x52d17436309d4253UL, 0x356f97e13efae576UL,
-	/* 151 */ 0xd351e11aa150535bUL, 0x3e6b45bb1dd878ccUL,
-		  0x0c776128bed92c98UL, 0x1d34ae93032885b8UL,
-	/* 152 */ 0x4ba0488ca85ba4c3UL, 0x985348c33c9ce6ceUL,
-		  0x66124c6f97bda770UL, 0x0f81a0290654124aUL,
-	/* 153 */ 0x9ed09ca6569b86fdUL, 0x811009fd18af9a2dUL,
-		  0xff08d03f93d8c20aUL, 0x52a148199faef26bUL,
-	/* 154 */ 0x3e03f9dc2d8d1b73UL, 0x4205801873961a70UL,
-		  0xc0d987f041a35970UL, 0x07aa1f15a1c0d549UL,
-	/* 155 */ 0xdfd46ce08cd27224UL, 0x6d0a024f934e4239UL,
-		  0x808a7a6399897b59UL, 0x0a4556e9e13d95a2UL,
-	/* 156 */ 0xd21a991fe9c13045UL, 0x9b0e8548fe7751b8UL,
-		  0x5da643cb4bf30035UL, 0x77db28d63940f721UL,
-	/* 157 */ 0xfc5eeb614adc9011UL, 0x5229419ae8c411ebUL,
-		  0x9ec3e7787d1dcf74UL, 0x340d053e216e4cb5UL,
-	/* 158 */ 0xcac7af39b48df2b4UL, 0xc0faec2871a10a94UL,
-		  0x140a69245ca575edUL, 0x0cf1c37134273a4cUL,
-	/* 159 */ 0xc8ee306ac224b8a5UL, 0x57eaee7ccb4930b0UL,
-		  0xa1e806bdaacbe74fUL, 0x7d9a62742eeb657dUL,
-	/* 160 */ 0x9eb6b6ef546c4830UL, 0x885cca1fddb36e2eUL,
-		  0xe6b9f383ef0d7105UL, 0x58654fef9d2e0412UL,
-	/* 161 */ 0xa905c4ffbe0e8e26UL, 0x942de5df9b31816eUL,
-		  0x497d723f802e88e1UL, 0x30684dea602f408dUL,
-	/* 162 */ 0x21e5a278a3e6cb34UL, 0xaefb6e6f5b151dc4UL,
-		  0xb30b8e049d77ca15UL, 0x28c3c9cf53b98981UL,
-	/* 163 */ 0x287fb721556cdd2aUL, 0x0d317ca897022274UL,
-		  0x7468c7423a543258UL, 0x4a7f11464eb5642fUL,
-	/* 164 */ 0xa237a4774d193aa6UL, 0xd865986ea92129a1UL,
-		  0x24c515ecf87c1a88UL, 0x604003575f39f5ebUL,
-	/* 165 */ 0x47b9f189570a9b27UL, 0x2b98cede465e4b78UL,
-		  0x026df551dbb85c20UL, 0x74fcd91047e21901UL,
-	/* 166 */ 0x13e2a90a23c1bfa3UL, 0x0cb0074e478519f6UL,
-		  0x5ff1cbbe3af6cf44UL, 0x67fe5438be812dbeUL,
-	/* 167 */ 0xd13cf64fa40f05b0UL, 0x054dfb2f32283787UL,
-		  0x4173915b7f0d2aeaUL, 0x482f144f1f610d4eUL,
-	/* 168 */ 0xf6210201b47f8234UL, 0x5d0ae1929e70b990UL,
-		  0xdcd7f455b049567cUL, 0x7e93d0f1f0916f01UL,
-	/* 169 */ 0xdd79cbf18a7db4faUL, 0xbe8391bf6f74c62fUL,
-		  0x027145d14b8291bdUL, 0x585a73ea2cbf1705UL,
-	/* 170 */ 0x485ca03e928a0db2UL, 0x10fc01a5742857e7UL,
-		  0x2f482edbd6d551a7UL, 0x0f0433b5048fdb8aUL,
-	/* 171 */ 0x60da2e8dd7dc6247UL, 0x88b4c9d38cd4819aUL,
-		  0x13033ac001f66697UL, 0x273b24fe3b367d75UL,
-	/* 172 */ 0xc6e8f66a31b3b9d4UL, 0x281514a494df49d5UL,
-		  0xd1726fdfc8b23da7UL, 0x4b3ae7d103dee548UL,
-	/* 173 */ 0xc6256e19ce4b9d7eUL, 0xff5c5cf186e3c61cUL,
-		  0xacc63ca34b8ec145UL, 0x74621888fee66574UL,
-	/* 174 */ 0x956f409645290a1eUL, 0xef0bf8e3263a962eUL,
-		  0xed6a50eb5ec2647bUL, 0x0694283a9dca7502UL,
-	/* 175 */ 0x769b963643a2dcd1UL, 0x42b7c8ea09fc5353UL,
-		  0x4f002aee13397eabUL, 0x63005e2c19b7d63aUL,
-	/* 176 */ 0xca6736da63023beaUL, 0x966c7f6db12a99b7UL,
-		  0xace09390c537c5e1UL, 0x0b696063a1aa89eeUL,
-	/* 177 */ 0xebb03e97288c56e5UL, 0x432a9f9f938c8be8UL,
-		  0xa6a5a93d5b717f71UL, 0x1a5fb4c3e18f9d97UL,
-	/* 178 */ 0x1c94e7ad1c60cdceUL, 0xee202a43fc02c4a0UL,
-		  0x8dafe4d867c46a20UL, 0x0a10263c8ac27b58UL,
-	/* 179 */ 0xd0dea9dfe4432a4aUL, 0x856af87bbe9277c5UL,
-		  0xce8472acc212c71aUL, 0x6f151b6d9bbb1e91UL,
-	/* 180 */ 0x26776c527ceed56aUL, 0x7d211cb7fbf8faecUL,
-		  0x37ae66a6fd4609ccUL, 0x1f81b702d2770c42UL,
-	/* 181 */ 0x2fb0b057eac58392UL, 0xe1dd89fe29744e9dUL,
-		  0xc964f8eb17beb4f8UL, 0x29571073c9a2d41eUL,
-	/* 182 */ 0xa948a18981c0e254UL, 0x2df6369b65b22830UL,
-		  0xa33eb2d75fcfd3c6UL, 0x078cd6ec4199a01fUL,
-	/* 183 */ 0x4a584a41ad900d2fUL, 0x32142b78e2c74c52UL,
-		  0x68c4e8338431c978UL, 0x7f69ea9008689fc2UL,
-	/* 184 */ 0x52f2c81e46a38265UL, 0xfd78072d04a832fdUL,
-		  0x8cd7d5fa25359e94UL, 0x4de71b7454cc29d2UL,
-	/* 185 */ 0x42eb60ad1eda6ac9UL, 0x0aad37dfdbc09c3aUL,
-		  0x81004b71e33cc191UL, 0x44e6be345122803cUL,
-	/* 186 */ 0x03fe8388ba1920dbUL, 0xf5d57c32150db008UL,
-		  0x49c8c4281af60c29UL, 0x21edb518de701aeeUL,
-	/* 187 */ 0x7fb63e418f06dc99UL, 0xa4460d99c166d7b8UL,
-		  0x24dd5248ce520a83UL, 0x5ec3ad712b928358UL,
-	/* 188 */ 0x15022a5fbd17930fUL, 0xa4f64a77d82570e3UL,
-		  0x12bc8d6915783712UL, 0x498194c0fc620abbUL,
-	/* 189 */ 0x38a2d9d255686c82UL, 0x785c6bd9193e21f0UL,
-		  0xe4d5c81ab24a5484UL, 0x56307860b2e20989UL,
-	/* 190 */ 0x429d55f78b4d74c4UL, 0x22f1834643350131UL,
-		  0x1e60c24598c71fffUL, 0x59f2f014979983efUL,
-	/* 191 */ 0x46a47d56eb494a44UL, 0x3e22a854d636a18eUL,
-		  0xb346e15274491c3bUL, 0x2ceafd4e5390cde7UL,
-	/* 192 */ 0xba8a8538be0d6675UL, 0x4b9074bb50818e23UL,
-		  0xcbdab89085d304c3UL, 0x61a24fe0e56192c4UL,
-	/* 193 */ 0xcb7615e6db525bcbUL, 0xdd7d8c35a567e4caUL,
-		  0xe6b4153acafcdd69UL, 0x2d668e097f3c9766UL,
-	/* 194 */ 0xa57e7e265ce55ef0UL, 0x5d9f4e527cd4b967UL,
-		  0xfbc83606492fd1e5UL, 0x090d52beb7c3f7aeUL,
-	/* 195 */ 0x09b9515a1e7b4d7cUL, 0x1f266a2599da44c0UL,
-		  0xa1c49548e2c55504UL, 0x7ef04287126f15ccUL,
-	/* 196 */ 0xfed1659dbd30ef15UL, 0x8b4ab9eec4e0277bUL,
-		  0x884d6236a5df3291UL, 0x1fd96ea6bf5cf788UL,
-	/* 197 */ 0x42a161981f190d9aUL, 0x61d849507e6052c1UL,
-		  0x9fe113bf285a2cd5UL, 0x7c22d676dbad85d8UL,
-	/* 198 */ 0x82e770ed2bfbd27dUL, 0x4c05b2ece996f5a5UL,
-		  0xcd40a9c2b0900150UL, 0x5895319213d9bf64UL,
-	/* 199 */ 0xe7cc5d703fea2e08UL, 0xb50c491258e2188cUL,
-		  0xcce30baa48205bf0UL, 0x537c659ccfa32d62UL,
-	/* 200 */ 0x37b6623a98cfc088UL, 0xfe9bed1fa4d6aca4UL,
-		  0x04d29b8e56a8d1b0UL, 0x725f71c40b519575UL,
-	/* 201 */ 0x28c7f89cd0339ce6UL, 0x8367b14469ddc18bUL,
-		  0x883ada83a6a1652cUL, 0x585f1974034d6c17UL,
-	/* 202 */ 0x89cfb266f1b19188UL, 0xe63b4863e7c35217UL,
-		  0xd88c9da6b4c0526aUL, 0x3e035c9df0954635UL,
-	/* 203 */ 0xdd9d5412fb45de9dUL, 0xdd684532e4cff40dUL,
-		  0x4b5c999b151d671cUL, 0x2d8c2cc811e7f690UL,
-	/* 204 */ 0x7f54be1d90055d40UL, 0xa464c5df464aaf40UL,
-		  0x33979624f0e917beUL, 0x2c018dc527356b30UL,
-	/* 205 */ 0xa5415024e330b3d4UL, 0x73ff3d96691652d3UL,
-		  0x94ec42c4ef9b59f1UL, 0x0747201618d08e5aUL,
-	/* 206 */ 0x4d6ca48aca411c53UL, 0x66415f2fcfa66119UL,
-		  0x9c4dd40051e227ffUL, 0x59810bc09a02f7ebUL,
-	/* 207 */ 0x2a7eb171b3dc101dUL, 0x441c5ab99ffef68eUL,
-		  0x32025c9b93b359eaUL, 0x5e8ce0a71e9d112fUL,
-	/* 208 */ 0xbfcccb92429503fdUL, 0xd271ba752f095d55UL,
-		  0x345ead5e972d091eUL, 0x18c8df11a83103baUL,
-	/* 209 */ 0x90cd949a9aed0f4cUL, 0xc5d1f4cb6660e37eUL,
-		  0xb8cac52d56c52e0bUL, 0x6e42e400c5808e0dUL,
-	/* 210 */ 0xa3b46966eeaefd23UL, 0x0c4f1f0be39ecdcaUL,
-		  0x189dc8c9d683a51dUL, 0x51f27f054c09351bUL,
-	/* 211 */ 0x4c487ccd2a320682UL, 0x587ea95bb3df1c96UL,
-		  0xc8ccf79e555cb8e8UL, 0x547dc829a206d73dUL,
-	/* 212 */ 0xb822a6cd80c39b06UL, 0xe96d54732000d4c6UL,
-		  0x28535b6f91463b4dUL, 0x228f4660e2486e1dUL,
-	/* 213 */ 0x98799538de8d3abfUL, 0x8cd8330045ebca6eUL,
-		  0x79952a008221e738UL, 0x4322e1a7535cd2bbUL,
-	/* 214 */ 0xb114c11819d1801cUL, 0x2016e4d84f3f5ec7UL,
-		  0xdd0e2df409260f4cUL, 0x5ec362c0ae5f7266UL,
-	/* 215 */ 0xc0462b18b8b2b4eeUL, 0x7cc8d950274d1afbUL,
-		  0xf25f7105436b02d2UL, 0x43bbf8dcbff9ccd3UL,
-	/* 216 */ 0xb6ad1767a039e9dfUL, 0xb0714da8f69d3583UL,
-		  0x5e55fa18b42931f5UL, 0x4ed5558f33c60961UL,
-	/* 217 */ 0x1fe37901c647a5ddUL, 0x593ddf1f8081d357UL,
-		  0x0249a4fd813fd7a6UL, 0x69acca274e9caf61UL,
-	/* 218 */ 0x047ba3ea330721c9UL, 0x83423fc20e7e1ea0UL,
-		  0x1df4c0af01314a60UL, 0x09a62dab89289527UL,
-	/* 219 */ 0xa5b325a49cc6cb00UL, 0xe94b5dc654b56cb6UL,
-		  0x3be28779adc994a0UL, 0x4296e8f8ba3a4aadUL,
-	/* 220 */ 0x328689761e451eabUL, 0x2e4d598bff59594aUL,
-		  0x49b96853d7a7084aUL, 0x4980a319601420a8UL,
-	/* 221 */ 0x9565b9e12f552c42UL, 0x8a5318db7100fe96UL,
-		  0x05c90b4d43add0d7UL, 0x538b4cd66a5d4edaUL,
-	/* 222 */ 0xf4e94fc3e89f039fUL, 0x592c9af26f618045UL,
-		  0x08a36eb5fd4b9550UL, 0x25fffaf6c2ed1419UL,
-	/* 223 */ 0x34434459cc79d354UL, 0xeeecbfb4b1d5476bUL,
-		  0xddeb34a061615d99UL, 0x5129cecceb64b773UL,
-	/* 224 */ 0xee43215894993520UL, 0x772f9c7cf14c0b3bUL,
-		  0xd2e2fce306bedad5UL, 0x715f42b546f06a97UL,
-	/* 225 */ 0x434ecdceda5b5f1aUL, 0x0da17115a49741a9UL,
-		  0x680bd77c73edad2eUL, 0x487c02354edd9041UL,
-	/* 226 */ 0xb8efeff3a70ed9c4UL, 0x56a32aa3e857e302UL,
-		  0xdf3a68bd48a2a5a0UL, 0x07f650b73176c444UL,
-	/* 227 */ 0xe38b9b1626e0ccb1UL, 0x79e053c18b09fb36UL,
-		  0x56d90319c9f94964UL, 0x1ca941e7ac9ff5c4UL,
-	/* 228 */ 0x49c4df29162fa0bbUL, 0x8488cf3282b33305UL,
-		  0x95dfda14cabb437dUL, 0x3391f78264d5ad86UL,
-	/* 229 */ 0x729ae06ae2b5095dUL, 0xd58a58d73259a946UL,
-		  0xe9834262d13921edUL, 0x27fedafaa54bb592UL,
-	/* 230 */ 0xa99dc5b829ad48bbUL, 0x5f025742499ee260UL,
-		  0x802c8ecd5d7513fdUL, 0x78ceb3ef3f6dd938UL,
-	/* 231 */ 0xc342f44f8a135d94UL, 0x7b9edb44828cdda3UL,
-		  0x9436d11a0537cfe7UL, 0x5064b164ec1ab4c8UL,
-	/* 232 */ 0x7020eccfd37eb2fcUL, 0x1f31ea3ed90d25fcUL,
-		  0x1b930d7bdfa1bb34UL, 0x5344467a48113044UL,
-	/* 233 */ 0x70073170f25e6dfbUL, 0xe385dc1a50114cc8UL,
-		  0x2348698ac8fc4f00UL, 0x2a77a55284dd40d8UL,
-	/* 234 */ 0xfe06afe0c98c6ce4UL, 0xc235df96dddfd6e4UL,
-		  0x1428d01e33bf1ed3UL, 0x785768ec9300bdafUL,
-	/* 235 */ 0x9702e57a91deb63bUL, 0x61bdb8bfe5ce8b80UL,
-		  0x645b426f3d1d58acUL, 0x4804a82227a557bcUL,
-	/* 236 */ 0x8e57048ab44d2601UL, 0x68d6501a4b3a6935UL,
-		  0xc39c9ec3f9e1c293UL, 0x4172f257d4de63e2UL,
-	/* 237 */ 0xd368b450330c6401UL, 0x040d3017418f2391UL,
-		  0x2c34bb6090b7d90dUL, 0x16f649228fdfd51fUL,
-	/* 238 */ 0xbea6818e2b928ef5UL, 0xe28ccf91cdc11e72UL,
-		  0x594aaa68e77a36cdUL, 0x313034806c7ffd0fUL,
-	/* 239 */ 0x8a9d27ac2249bd65UL, 0x19a3b464018e9512UL,
-		  0xc26ccff352b37ec7UL, 0x056f68341d797b21UL,
-	/* 240 */ 0x5e79d6757efd2327UL, 0xfabdbcb6553afe15UL,
-		  0xd3e7222c6eaf5a60UL, 0x7046c76d4dae743bUL,
-	/* 241 */ 0x660be872b18d4a55UL, 0x19992518574e1496UL,
-		  0xc103053a302bdcbbUL, 0x3ed8e9800b218e8eUL,
-	/* 242 */ 0x7b0b9239fa75e03eUL, 0xefe9fb684633c083UL,
-		  0x98a35fbe391a7793UL, 0x6065510fe2d0fe34UL,
-	/* 243 */ 0x55cb668548abad0cUL, 0xb4584548da87e527UL,
-		  0x2c43ecea0107c1ddUL, 0x526028809372de35UL,
-	/* 244 */ 0x3415c56af9213b1fUL, 0x5bee1a4d017e98dbUL,
-		  0x13f6b105b5cf709bUL, 0x5ff20e3482b29ab6UL,
-	/* 245 */ 0x0aa29c75cc2e6c90UL, 0xfc7d73ca3a70e206UL,
-		  0x899fc38fc4b5c515UL, 0x250386b124ffc207UL,
-	/* 246 */ 0x54ea28d5ae3d2b56UL, 0x9913149dd6de60ceUL,
-		  0x16694fc58f06d6c1UL, 0x46b23975eb018fc7UL,
-	/* 247 */ 0x470a6a0fb4b7b4e2UL, 0x5d92475a8f7253deUL,
-		  0xabeee5b52fbd3adbUL, 0x7fa20801a0806968UL,
-	/* 248 */ 0x76f3faf19f7714d2UL, 0xb3e840c12f4660c3UL,
-		  0x0fb4cd8df212744eUL, 0x4b065a251d3a2dd2UL,
-	/* 249 */ 0x5cebde383d77cd4aUL, 0x6adf39df882c9cb1UL,
-		  0xa2dd242eb09af759UL, 0x3147c0e50e5f6422UL,
-	/* 250 */ 0x164ca5101d1350dbUL, 0xf8d13479c33fc962UL,
-		  0xe640ce4d13e5da08UL, 0x4bdee0c45061f8baUL,
-	/* 251 */ 0xd7c46dc1a4edb1c9UL, 0x5514d7b6437fd98aUL,
-		  0x58942f6bb2a1c00bUL, 0x2dffb2ab1d70710eUL,
-	/* 252 */ 0xccdfcf2fc18b6d68UL, 0xa8ebcba8b7806167UL,
-		  0x980697f95e2937e3UL, 0x02fbba1cd0126e8cUL
-};
-
-/* c is two 512-bit products: c0[0:7]=a0[0:3]*b0[0:3] and c1[8:15]=a1[4:7]*b1[4:7]
- * a is two 256-bit integers: a0[0:3] and a1[4:7]
- * b is two 256-bit integers: b0[0:3] and b1[4:7]
- */
-static void mul2_256x256_integer_adx(u64 *const c, const u64 *const a,
-				     const u64 *const b)
-{
-	asm volatile(
-		"xorl %%r14d, %%r14d ;"
-		"movq   (%1), %%rdx; "	/* A[0] */
-		"mulx   (%2),  %%r8, %%r15; " /* A[0]*B[0] */
-		"xorl %%r10d, %%r10d ;"
-		"movq %%r8, (%0) ;"
-		"mulx  8(%2), %%r10, %%rax; " /* A[0]*B[1] */
-		"adox %%r10, %%r15 ;"
-		"mulx 16(%2),  %%r8, %%rbx; " /* A[0]*B[2] */
-		"adox  %%r8, %%rax ;"
-		"mulx 24(%2), %%r10, %%rcx; " /* A[0]*B[3] */
-		"adox %%r10, %%rbx ;"
-		/******************************************/
-		"adox %%r14, %%rcx ;"
-
-		"movq  8(%1), %%rdx; "	/* A[1] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[1]*B[0] */
-		"adox %%r15,  %%r8 ;"
-		"movq  %%r8, 8(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[1]*B[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rax ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[1]*B[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%rbx ;"
-		"mulx 24(%2), %%r10, %%r15; " /* A[1]*B[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%rcx ;"
-		/******************************************/
-		"adox %%r14, %%r15 ;"
-		"adcx %%r14, %%r15 ;"
-
-		"movq 16(%1), %%rdx; " /* A[2] */
-		"xorl %%r10d, %%r10d ;"
-		"mulx   (%2),  %%r8,  %%r9; " /* A[2]*B[0] */
-		"adox %%rax,  %%r8 ;"
-		"movq %%r8, 16(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[2]*B[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rbx ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[2]*B[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%rcx ;"
-		"mulx 24(%2), %%r10, %%rax; " /* A[2]*B[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%r15 ;"
-		/******************************************/
-		"adox %%r14, %%rax ;"
-		"adcx %%r14, %%rax ;"
-
-		"movq 24(%1), %%rdx; " /* A[3] */
-		"xorl %%r10d, %%r10d ;"
-		"mulx   (%2),  %%r8,  %%r9; " /* A[3]*B[0] */
-		"adox %%rbx,  %%r8 ;"
-		"movq %%r8, 24(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[3]*B[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rcx ;"
-		"movq %%rcx, 32(%0) ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[3]*B[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"mulx 24(%2), %%r10, %%rbx; " /* A[3]*B[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%rax ;"
-		"movq %%rax, 48(%0) ;"
-		/******************************************/
-		"adox %%r14, %%rbx ;"
-		"adcx %%r14, %%rbx ;"
-		"movq %%rbx, 56(%0) ;"
-
-		"movq 32(%1), %%rdx; "	/* C[0] */
-		"mulx 32(%2),  %%r8, %%r15; " /* C[0]*D[0] */
-		"xorl %%r10d, %%r10d ;"
-		"movq %%r8, 64(%0);"
-		"mulx 40(%2), %%r10, %%rax; " /* C[0]*D[1] */
-		"adox %%r10, %%r15 ;"
-		"mulx 48(%2),  %%r8, %%rbx; " /* C[0]*D[2] */
-		"adox  %%r8, %%rax ;"
-		"mulx 56(%2), %%r10, %%rcx; " /* C[0]*D[3] */
-		"adox %%r10, %%rbx ;"
-		/******************************************/
-		"adox %%r14, %%rcx ;"
-
-		"movq 40(%1), %%rdx; " /* C[1] */
-		"xorl %%r10d, %%r10d ;"
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[1]*D[0] */
-		"adox %%r15,  %%r8 ;"
-		"movq  %%r8, 72(%0);"
-		"mulx 40(%2), %%r10, %%r11; " /* C[1]*D[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rax ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[1]*D[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%rbx ;"
-		"mulx 56(%2), %%r10, %%r15; " /* C[1]*D[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%rcx ;"
-		/******************************************/
-		"adox %%r14, %%r15 ;"
-		"adcx %%r14, %%r15 ;"
-
-		"movq 48(%1), %%rdx; " /* C[2] */
-		"xorl %%r10d, %%r10d ;"
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[2]*D[0] */
-		"adox %%rax,  %%r8 ;"
-		"movq  %%r8, 80(%0);"
-		"mulx 40(%2), %%r10, %%r11; " /* C[2]*D[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rbx ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[2]*D[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%rcx ;"
-		"mulx 56(%2), %%r10, %%rax; " /* C[2]*D[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%r15 ;"
-		/******************************************/
-		"adox %%r14, %%rax ;"
-		"adcx %%r14, %%rax ;"
-
-		"movq 56(%1), %%rdx; " /* C[3] */
-		"xorl %%r10d, %%r10d ;"
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[3]*D[0] */
-		"adox %%rbx,  %%r8 ;"
-		"movq  %%r8, 88(%0);"
-		"mulx 40(%2), %%r10, %%r11; " /* C[3]*D[1] */
-		"adox %%r10,  %%r9 ;"
-		"adcx  %%r9, %%rcx ;"
-		"movq %%rcx,  96(%0) ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[3]*D[2] */
-		"adox  %%r8, %%r11 ;"
-		"adcx %%r11, %%r15 ;"
-		"movq %%r15, 104(%0) ;"
-		"mulx 56(%2), %%r10, %%rbx; " /* C[3]*D[3] */
-		"adox %%r10, %%r13 ;"
-		"adcx %%r13, %%rax ;"
-		"movq %%rax, 112(%0) ;"
-		/******************************************/
-		"adox %%r14, %%rbx ;"
-		"adcx %%r14, %%rbx ;"
-		"movq %%rbx, 120(%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11", "%r13", "%r14", "%r15");
-}
-
-static void mul2_256x256_integer_bmi2(u64 *const c, const u64 *const a,
-				      const u64 *const b)
+static __always_inline u64 eq_mask(u64 a, u64 b)
 {
-	asm volatile(
-		"movq   (%1), %%rdx; "	/* A[0] */
-		"mulx   (%2),  %%r8, %%r15; " /* A[0]*B[0] */
-		"movq %%r8,  (%0) ;"
-		"mulx  8(%2), %%r10, %%rax; " /* A[0]*B[1] */
-		"addq %%r10, %%r15 ;"
-		"mulx 16(%2),  %%r8, %%rbx; " /* A[0]*B[2] */
-		"adcq  %%r8, %%rax ;"
-		"mulx 24(%2), %%r10, %%rcx; " /* A[0]*B[3] */
-		"adcq %%r10, %%rbx ;"
-		/******************************************/
-		"adcq    $0, %%rcx ;"
-
-		"movq  8(%1), %%rdx; "	/* A[1] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[1]*B[0] */
-		"addq %%r15,  %%r8 ;"
-		"movq %%r8, 8(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[1]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[1]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%r15; " /* A[1]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%r15 ;"
-
-		"addq  %%r9, %%rax ;"
-		"adcq %%r11, %%rbx ;"
-		"adcq %%r13, %%rcx ;"
-		"adcq    $0, %%r15 ;"
-
-		"movq 16(%1), %%rdx; "	/* A[2] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[2]*B[0] */
-		"addq %%rax,  %%r8 ;"
-		"movq %%r8, 16(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[2]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[2]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%rax; " /* A[2]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rax ;"
-
-		"addq  %%r9, %%rbx ;"
-		"adcq %%r11, %%rcx ;"
-		"adcq %%r13, %%r15 ;"
-		"adcq    $0, %%rax ;"
-
-		"movq 24(%1), %%rdx; "	/* A[3] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[3]*B[0] */
-		"addq %%rbx,  %%r8 ;"
-		"movq %%r8, 24(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[3]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[3]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%rbx; " /* A[3]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rbx ;"
-
-		"addq  %%r9, %%rcx ;"
-		"movq %%rcx, 32(%0) ;"
-		"adcq %%r11, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"adcq %%r13, %%rax ;"
-		"movq %%rax, 48(%0) ;"
-		"adcq    $0, %%rbx ;"
-		"movq %%rbx, 56(%0) ;"
-
-		"movq 32(%1), %%rdx; "	/* C[0] */
-		"mulx 32(%2),  %%r8, %%r15; " /* C[0]*D[0] */
-		"movq %%r8, 64(%0) ;"
-		"mulx 40(%2), %%r10, %%rax; " /* C[0]*D[1] */
-		"addq %%r10, %%r15 ;"
-		"mulx 48(%2),  %%r8, %%rbx; " /* C[0]*D[2] */
-		"adcq  %%r8, %%rax ;"
-		"mulx 56(%2), %%r10, %%rcx; " /* C[0]*D[3] */
-		"adcq %%r10, %%rbx ;"
-		/******************************************/
-		"adcq    $0, %%rcx ;"
-
-		"movq 40(%1), %%rdx; "	/* C[1] */
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[1]*D[0] */
-		"addq %%r15,  %%r8 ;"
-		"movq %%r8, 72(%0) ;"
-		"mulx 40(%2), %%r10, %%r11; " /* C[1]*D[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[1]*D[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 56(%2), %%r10, %%r15; " /* C[1]*D[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%r15 ;"
-
-		"addq  %%r9, %%rax ;"
-		"adcq %%r11, %%rbx ;"
-		"adcq %%r13, %%rcx ;"
-		"adcq    $0, %%r15 ;"
-
-		"movq 48(%1), %%rdx; "	/* C[2] */
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[2]*D[0] */
-		"addq %%rax,  %%r8 ;"
-		"movq %%r8, 80(%0) ;"
-		"mulx 40(%2), %%r10, %%r11; " /* C[2]*D[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[2]*D[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 56(%2), %%r10, %%rax; " /* C[2]*D[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rax ;"
-
-		"addq  %%r9, %%rbx ;"
-		"adcq %%r11, %%rcx ;"
-		"adcq %%r13, %%r15 ;"
-		"adcq    $0, %%rax ;"
-
-		"movq 56(%1), %%rdx; "	/* C[3] */
-		"mulx 32(%2),  %%r8,  %%r9; " /* C[3]*D[0] */
-		"addq %%rbx,  %%r8 ;"
-		"movq %%r8, 88(%0) ;"
-		"mulx 40(%2), %%r10, %%r11; " /* C[3]*D[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 48(%2),  %%r8, %%r13; " /* C[3]*D[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 56(%2), %%r10, %%rbx; " /* C[3]*D[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rbx ;"
-
-		"addq  %%r9, %%rcx ;"
-		"movq %%rcx,  96(%0) ;"
-		"adcq %%r11, %%r15 ;"
-		"movq %%r15, 104(%0) ;"
-		"adcq %%r13, %%rax ;"
-		"movq %%rax, 112(%0) ;"
-		"adcq    $0, %%rbx ;"
-		"movq %%rbx, 120(%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11", "%r13", "%r15");
+	u64 x = a ^ b;
+	u64 minus_x = ~x + (u64)1U;
+	u64 x_or_minus_x = x | minus_x;
+	u64 xnx = x_or_minus_x >> (u32)63U;
+	return xnx - (u64)1U;
 }
 
-static void sqr2_256x256_integer_adx(u64 *const c, const u64 *const a)
+static __always_inline u64 gte_mask(u64 a, u64 b)
 {
-	asm volatile(
-		"movq   (%1), %%rdx        ;" /* A[0]      */
-		"mulx  8(%1),  %%r8, %%r14 ;" /* A[1]*A[0] */
-		"xorl %%r15d, %%r15d;"
-		"mulx 16(%1),  %%r9, %%r10 ;" /* A[2]*A[0] */
-		"adcx %%r14,  %%r9 ;"
-		"mulx 24(%1), %%rax, %%rcx ;" /* A[3]*A[0] */
-		"adcx %%rax, %%r10 ;"
-		"movq 24(%1), %%rdx        ;" /* A[3]      */
-		"mulx  8(%1), %%r11, %%rbx ;" /* A[1]*A[3] */
-		"adcx %%rcx, %%r11 ;"
-		"mulx 16(%1), %%rax, %%r13 ;" /* A[2]*A[3] */
-		"adcx %%rax, %%rbx ;"
-		"movq  8(%1), %%rdx        ;" /* A[1]      */
-		"adcx %%r15, %%r13 ;"
-		"mulx 16(%1), %%rax, %%rcx ;" /* A[2]*A[1] */
-		"movq    $0, %%r14 ;"
-		/******************************************/
-		"adcx %%r15, %%r14 ;"
-
-		"xorl %%r15d, %%r15d;"
-		"adox %%rax, %%r10 ;"
-		"adcx  %%r8,  %%r8 ;"
-		"adox %%rcx, %%r11 ;"
-		"adcx  %%r9,  %%r9 ;"
-		"adox %%r15, %%rbx ;"
-		"adcx %%r10, %%r10 ;"
-		"adox %%r15, %%r13 ;"
-		"adcx %%r11, %%r11 ;"
-		"adox %%r15, %%r14 ;"
-		"adcx %%rbx, %%rbx ;"
-		"adcx %%r13, %%r13 ;"
-		"adcx %%r14, %%r14 ;"
-
-		"movq   (%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[0]^2 */
-		/*******************/
-		"movq %%rax,  0(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  8(%0) ;"
-		"movq  8(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9, 16(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10, 24(%0) ;"
-		"movq 16(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11, 32(%0) ;"
-		"adcq %%rcx, %%rbx ;"
-		"movq %%rbx, 40(%0) ;"
-		"movq 24(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 48(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 56(%0) ;"
-
-
-		"movq 32(%1), %%rdx        ;" /* B[0]      */
-		"mulx 40(%1),  %%r8, %%r14 ;" /* B[1]*B[0] */
-		"xorl %%r15d, %%r15d;"
-		"mulx 48(%1),  %%r9, %%r10 ;" /* B[2]*B[0] */
-		"adcx %%r14,  %%r9 ;"
-		"mulx 56(%1), %%rax, %%rcx ;" /* B[3]*B[0] */
-		"adcx %%rax, %%r10 ;"
-		"movq 56(%1), %%rdx        ;" /* B[3]      */
-		"mulx 40(%1), %%r11, %%rbx ;" /* B[1]*B[3] */
-		"adcx %%rcx, %%r11 ;"
-		"mulx 48(%1), %%rax, %%r13 ;" /* B[2]*B[3] */
-		"adcx %%rax, %%rbx ;"
-		"movq 40(%1), %%rdx        ;" /* B[1]      */
-		"adcx %%r15, %%r13 ;"
-		"mulx 48(%1), %%rax, %%rcx ;" /* B[2]*B[1] */
-		"movq    $0, %%r14 ;"
-		/******************************************/
-		"adcx %%r15, %%r14 ;"
-
-		"xorl %%r15d, %%r15d;"
-		"adox %%rax, %%r10 ;"
-		"adcx  %%r8,  %%r8 ;"
-		"adox %%rcx, %%r11 ;"
-		"adcx  %%r9,  %%r9 ;"
-		"adox %%r15, %%rbx ;"
-		"adcx %%r10, %%r10 ;"
-		"adox %%r15, %%r13 ;"
-		"adcx %%r11, %%r11 ;"
-		"adox %%r15, %%r14 ;"
-		"adcx %%rbx, %%rbx ;"
-		"adcx %%r13, %%r13 ;"
-		"adcx %%r14, %%r14 ;"
-
-		"movq 32(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* B[0]^2 */
-		/*******************/
-		"movq %%rax,  64(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  72(%0) ;"
-		"movq 40(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* B[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9,  80(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10,  88(%0) ;"
-		"movq 48(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* B[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11,  96(%0) ;"
-		"adcq %%rcx, %%rbx ;"
-		"movq %%rbx, 104(%0) ;"
-		"movq 56(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* B[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 112(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 120(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11", "%r13", "%r14", "%r15");
+	u64 x = a;
+	u64 y = b;
+	u64 x_xor_y = x ^ y;
+	u64 x_sub_y = x - y;
+	u64 x_sub_y_xor_y = x_sub_y ^ y;
+	u64 q = x_xor_y | x_sub_y_xor_y;
+	u64 x_xor_q = x ^ q;
+	u64 x_xor_q_ = x_xor_q >> (u32)63U;
+	return x_xor_q_ - (u64)1U;
 }
 
-static void sqr2_256x256_integer_bmi2(u64 *const c, const u64 *const a)
+/* Computes the addition of four-element f1 with value in f2
+ * and returns the carry (if any) */
+static inline u64 add_scalar(u64 *out, const u64 *f1, u64 f2)
 {
-	asm volatile(
-		"movq  8(%1), %%rdx        ;" /* A[1]      */
-		"mulx   (%1),  %%r8,  %%r9 ;" /* A[0]*A[1] */
-		"mulx 16(%1), %%r10, %%r11 ;" /* A[2]*A[1] */
-		"mulx 24(%1), %%rcx, %%r14 ;" /* A[3]*A[1] */
-
-		"movq 16(%1), %%rdx        ;" /* A[2]      */
-		"mulx 24(%1), %%r15, %%r13 ;" /* A[3]*A[2] */
-		"mulx   (%1), %%rax, %%rdx ;" /* A[0]*A[2] */
-
-		"addq %%rax,  %%r9 ;"
-		"adcq %%rdx, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq %%r14, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"movq    $0, %%r14 ;"
-		"adcq    $0, %%r14 ;"
-
-		"movq   (%1), %%rdx        ;" /* A[0]      */
-		"mulx 24(%1), %%rax, %%rcx ;" /* A[0]*A[3] */
-
-		"addq %%rax, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq    $0, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"adcq    $0, %%r14 ;"
-
-		"shldq $1, %%r13, %%r14 ;"
-		"shldq $1, %%r15, %%r13 ;"
-		"shldq $1, %%r11, %%r15 ;"
-		"shldq $1, %%r10, %%r11 ;"
-		"shldq $1,  %%r9, %%r10 ;"
-		"shldq $1,  %%r8,  %%r9 ;"
-		"shlq  $1,  %%r8        ;"
-
-		/*******************/
-		"mulx %%rdx, %%rax, %%rcx ; " /* A[0]^2 */
-		/*******************/
-		"movq %%rax,  0(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  8(%0) ;"
-		"movq  8(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* A[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9, 16(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10, 24(%0) ;"
-		"movq 16(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* A[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11, 32(%0) ;"
-		"adcq %%rcx, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"movq 24(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* A[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 48(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 56(%0) ;"
-
-		"movq 40(%1), %%rdx        ;" /* B[1]      */
-		"mulx 32(%1),  %%r8,  %%r9 ;" /* B[0]*B[1] */
-		"mulx 48(%1), %%r10, %%r11 ;" /* B[2]*B[1] */
-		"mulx 56(%1), %%rcx, %%r14 ;" /* B[3]*B[1] */
-
-		"movq 48(%1), %%rdx        ;" /* B[2]      */
-		"mulx 56(%1), %%r15, %%r13 ;" /* B[3]*B[2] */
-		"mulx 32(%1), %%rax, %%rdx ;" /* B[0]*B[2] */
-
-		"addq %%rax,  %%r9 ;"
-		"adcq %%rdx, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq %%r14, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"movq    $0, %%r14 ;"
-		"adcq    $0, %%r14 ;"
-
-		"movq 32(%1), %%rdx        ;" /* B[0]      */
-		"mulx 56(%1), %%rax, %%rcx ;" /* B[0]*B[3] */
-
-		"addq %%rax, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq    $0, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"adcq    $0, %%r14 ;"
-
-		"shldq $1, %%r13, %%r14 ;"
-		"shldq $1, %%r15, %%r13 ;"
-		"shldq $1, %%r11, %%r15 ;"
-		"shldq $1, %%r10, %%r11 ;"
-		"shldq $1,  %%r9, %%r10 ;"
-		"shldq $1,  %%r8,  %%r9 ;"
-		"shlq  $1,  %%r8        ;"
-
-		/*******************/
-		"mulx %%rdx, %%rax, %%rcx ; " /* B[0]^2 */
-		/*******************/
-		"movq %%rax,  64(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  72(%0) ;"
-		"movq 40(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* B[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9,  80(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10,  88(%0) ;"
-		"movq 48(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* B[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11,  96(%0) ;"
-		"adcq %%rcx, %%r15 ;"
-		"movq %%r15, 104(%0) ;"
-		"movq 56(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ; " /* B[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 112(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 120(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10",
-		  "%r11", "%r13", "%r14", "%r15");
-}
+	u64 carry_r;
 
-static void red_eltfp25519_2w_adx(u64 *const c, const u64 *const a)
-{
 	asm volatile(
-		"movl    $38, %%edx; "	/* 2*c = 38 = 2^256 */
-		"mulx 32(%1),  %%r8, %%r10; " /* c*C[4] */
-		"xorl %%ebx, %%ebx ;"
-		"adox   (%1),  %%r8 ;"
-		"mulx 40(%1),  %%r9, %%r11; " /* c*C[5] */
-		"adcx %%r10,  %%r9 ;"
-		"adox  8(%1),  %%r9 ;"
-		"mulx 48(%1), %%r10, %%rax; " /* c*C[6] */
-		"adcx %%r11, %%r10 ;"
-		"adox 16(%1), %%r10 ;"
-		"mulx 56(%1), %%r11, %%rcx; " /* c*C[7] */
-		"adcx %%rax, %%r11 ;"
-		"adox 24(%1), %%r11 ;"
-		/***************************************/
-		"adcx %%rbx, %%rcx ;"
-		"adox  %%rbx, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0, of=0 */
-		"adcx %%rcx,  %%r8 ;"
-		"adcx %%rbx,  %%r9 ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcx %%rbx, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"adcx %%rbx, %%r11 ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,   (%0) ;"
-
-		"mulx  96(%1),  %%r8, %%r10; " /* c*C[4] */
-		"xorl %%ebx, %%ebx ;"
-		"adox 64(%1),  %%r8 ;"
-		"mulx 104(%1),  %%r9, %%r11; " /* c*C[5] */
-		"adcx %%r10,  %%r9 ;"
-		"adox 72(%1),  %%r9 ;"
-		"mulx 112(%1), %%r10, %%rax; " /* c*C[6] */
-		"adcx %%r11, %%r10 ;"
-		"adox 80(%1), %%r10 ;"
-		"mulx 120(%1), %%r11, %%rcx; " /* c*C[7] */
-		"adcx %%rax, %%r11 ;"
-		"adox 88(%1), %%r11 ;"
-		/****************************************/
-		"adcx %%rbx, %%rcx ;"
-		"adox  %%rbx, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0, of=0 */
-		"adcx %%rcx,  %%r8 ;"
-		"adcx %%rbx,  %%r9 ;"
-		"movq  %%r9, 40(%0) ;"
-		"adcx %%rbx, %%r10 ;"
-		"movq %%r10, 48(%0) ;"
-		"adcx %%rbx, %%r11 ;"
-		"movq %%r11, 56(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8, 32(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11");
-}
+		/* Clear registers to propagate the carry bit */
+		"  xor %%r8, %%r8;"
+		"  xor %%r9, %%r9;"
+		"  xor %%r10, %%r10;"
+		"  xor %%r11, %%r11;"
+		"  xor %1, %1;"
+
+		/* Begin addition chain */
+		"  addq 0(%3), %0;"
+		"  movq %0, 0(%2);"
+		"  adcxq 8(%3), %%r8;"
+		"  movq %%r8, 8(%2);"
+		"  adcxq 16(%3), %%r9;"
+		"  movq %%r9, 16(%2);"
+		"  adcxq 24(%3), %%r10;"
+		"  movq %%r10, 24(%2);"
+
+		/* Return the carry bit in a register */
+		"  adcx %%r11, %1;"
+	: "+&r" (f2), "=&r" (carry_r)
+	: "r" (out), "r" (f1)
+	: "%r8", "%r9", "%r10", "%r11", "memory", "cc"
+	);
 
-static void red_eltfp25519_2w_bmi2(u64 *const c, const u64 *const a)
-{
-	asm volatile(
-		"movl    $38, %%edx ; "       /* 2*c = 38 = 2^256 */
-		"mulx 32(%1),  %%r8, %%r10 ;" /* c*C[4] */
-		"mulx 40(%1),  %%r9, %%r11 ;" /* c*C[5] */
-		"addq %%r10,  %%r9 ;"
-		"mulx 48(%1), %%r10, %%rax ;" /* c*C[6] */
-		"adcq %%r11, %%r10 ;"
-		"mulx 56(%1), %%r11, %%rcx ;" /* c*C[7] */
-		"adcq %%rax, %%r11 ;"
-		/***************************************/
-		"adcq    $0, %%rcx ;"
-		"addq   (%1),  %%r8 ;"
-		"adcq  8(%1),  %%r9 ;"
-		"adcq 16(%1), %%r10 ;"
-		"adcq 24(%1), %%r11 ;"
-		"adcq     $0, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0 */
-		"addq %%rcx,  %%r8 ;"
-		"adcq    $0,  %%r9 ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcq    $0, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"adcq    $0, %%r11 ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,   (%0) ;"
-
-		"mulx  96(%1),  %%r8, %%r10 ;" /* c*C[4] */
-		"mulx 104(%1),  %%r9, %%r11 ;" /* c*C[5] */
-		"addq %%r10,  %%r9 ;"
-		"mulx 112(%1), %%r10, %%rax ;" /* c*C[6] */
-		"adcq %%r11, %%r10 ;"
-		"mulx 120(%1), %%r11, %%rcx ;" /* c*C[7] */
-		"adcq %%rax, %%r11 ;"
-		/****************************************/
-		"adcq    $0, %%rcx ;"
-		"addq 64(%1),  %%r8 ;"
-		"adcq 72(%1),  %%r9 ;"
-		"adcq 80(%1), %%r10 ;"
-		"adcq 88(%1), %%r11 ;"
-		"adcq     $0, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0 */
-		"addq %%rcx,  %%r8 ;"
-		"adcq    $0,  %%r9 ;"
-		"movq  %%r9, 40(%0) ;"
-		"adcq    $0, %%r10 ;"
-		"movq %%r10, 48(%0) ;"
-		"adcq    $0, %%r11 ;"
-		"movq %%r11, 56(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8, 32(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10",
-		  "%r11");
+	return carry_r;
 }
 
-static void mul_256x256_integer_adx(u64 *const c, const u64 *const a,
-				    const u64 *const b)
+/* Computes the field addition of two field elements */
+static inline void fadd(u64 *out, const u64 *f1, const u64 *f2)
 {
 	asm volatile(
-		"movq   (%1), %%rdx; "	/* A[0] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[0]*B[0] */
-		"xorl %%r10d, %%r10d ;"
-		"movq  %%r8,  (%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[0]*B[1] */
-		"adox  %%r9, %%r10 ;"
-		"movq %%r10, 8(%0) ;"
-		"mulx 16(%2), %%r15, %%r13; " /* A[0]*B[2] */
-		"adox %%r11, %%r15 ;"
-		"mulx 24(%2), %%r14, %%rdx; " /* A[0]*B[3] */
-		"adox %%r13, %%r14 ;"
-		"movq $0, %%rax ;"
-		/******************************************/
-		"adox %%rdx, %%rax ;"
-
-		"movq  8(%1), %%rdx; "	/* A[1] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[1]*B[0] */
-		"xorl %%r10d, %%r10d ;"
-		"adcx 8(%0),  %%r8 ;"
-		"movq  %%r8,  8(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[1]*B[1] */
-		"adox  %%r9, %%r10 ;"
-		"adcx %%r15, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"mulx 16(%2), %%r15, %%r13; " /* A[1]*B[2] */
-		"adox %%r11, %%r15 ;"
-		"adcx %%r14, %%r15 ;"
-		"movq $0, %%r8  ;"
-		"mulx 24(%2), %%r14, %%rdx; " /* A[1]*B[3] */
-		"adox %%r13, %%r14 ;"
-		"adcx %%rax, %%r14 ;"
-		"movq $0, %%rax ;"
-		/******************************************/
-		"adox %%rdx, %%rax ;"
-		"adcx  %%r8, %%rax ;"
-
-		"movq 16(%1), %%rdx; "	/* A[2] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[2]*B[0] */
-		"xorl %%r10d, %%r10d ;"
-		"adcx 16(%0), %%r8 ;"
-		"movq  %%r8, 16(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[2]*B[1] */
-		"adox  %%r9, %%r10 ;"
-		"adcx %%r15, %%r10 ;"
-		"movq %%r10, 24(%0) ;"
-		"mulx 16(%2), %%r15, %%r13; " /* A[2]*B[2] */
-		"adox %%r11, %%r15 ;"
-		"adcx %%r14, %%r15 ;"
-		"movq $0, %%r8  ;"
-		"mulx 24(%2), %%r14, %%rdx; " /* A[2]*B[3] */
-		"adox %%r13, %%r14 ;"
-		"adcx %%rax, %%r14 ;"
-		"movq $0, %%rax ;"
-		/******************************************/
-		"adox %%rdx, %%rax ;"
-		"adcx  %%r8, %%rax ;"
-
-		"movq 24(%1), %%rdx; "	/* A[3] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[3]*B[0] */
-		"xorl %%r10d, %%r10d ;"
-		"adcx 24(%0), %%r8 ;"
-		"movq  %%r8, 24(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[3]*B[1] */
-		"adox  %%r9, %%r10 ;"
-		"adcx %%r15, %%r10 ;"
-		"movq %%r10, 32(%0) ;"
-		"mulx 16(%2), %%r15, %%r13; " /* A[3]*B[2] */
-		"adox %%r11, %%r15 ;"
-		"adcx %%r14, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"movq $0, %%r8  ;"
-		"mulx 24(%2), %%r14, %%rdx; " /* A[3]*B[3] */
-		"adox %%r13, %%r14 ;"
-		"adcx %%rax, %%r14 ;"
-		"movq %%r14, 48(%0) ;"
-		"movq $0, %%rax ;"
-		/******************************************/
-		"adox %%rdx, %%rax ;"
-		"adcx  %%r8, %%rax ;"
-		"movq %%rax, 56(%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11",
-		  "%r13", "%r14", "%r15");
+		/* Compute the raw addition of f1 + f2 */
+		"  movq 0(%0), %%r8;"
+		"  addq 0(%2), %%r8;"
+		"  movq 8(%0), %%r9;"
+		"  adcxq 8(%2), %%r9;"
+		"  movq 16(%0), %%r10;"
+		"  adcxq 16(%2), %%r10;"
+		"  movq 24(%0), %%r11;"
+		"  adcxq 24(%2), %%r11;"
+
+		/* Wrap the result back into the field */
+
+		/* Step 1: Compute carry*38 */
+		"  mov $0, %%rax;"
+		"  mov $38, %0;"
+		"  cmovc %0, %%rax;"
+
+		/* Step 2: Add carry*38 to the original sum */
+		"  xor %%rcx, %%rcx;"
+		"  add %%rax, %%r8;"
+		"  adcx %%rcx, %%r9;"
+		"  movq %%r9, 8(%1);"
+		"  adcx %%rcx, %%r10;"
+		"  movq %%r10, 16(%1);"
+		"  adcx %%rcx, %%r11;"
+		"  movq %%r11, 24(%1);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %0, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%1);"
+	: "+&r" (f2)
+	: "r" (out), "r" (f1)
+	: "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11", "memory", "cc"
+	);
 }
 
-static void mul_256x256_integer_bmi2(u64 *const c, const u64 *const a,
-				     const u64 *const b)
+/* Computes the field substraction of two field elements */
+static inline void fsub(u64 *out, const u64 *f1, const u64 *f2)
 {
 	asm volatile(
-		"movq   (%1), %%rdx; "	/* A[0] */
-		"mulx   (%2),  %%r8, %%r15; " /* A[0]*B[0] */
-		"movq %%r8,  (%0) ;"
-		"mulx  8(%2), %%r10, %%rax; " /* A[0]*B[1] */
-		"addq %%r10, %%r15 ;"
-		"mulx 16(%2),  %%r8, %%rbx; " /* A[0]*B[2] */
-		"adcq  %%r8, %%rax ;"
-		"mulx 24(%2), %%r10, %%rcx; " /* A[0]*B[3] */
-		"adcq %%r10, %%rbx ;"
-		/******************************************/
-		"adcq    $0, %%rcx ;"
-
-		"movq  8(%1), %%rdx; "	/* A[1] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[1]*B[0] */
-		"addq %%r15,  %%r8 ;"
-		"movq %%r8, 8(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[1]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[1]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%r15; " /* A[1]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%r15 ;"
-
-		"addq  %%r9, %%rax ;"
-		"adcq %%r11, %%rbx ;"
-		"adcq %%r13, %%rcx ;"
-		"adcq    $0, %%r15 ;"
-
-		"movq 16(%1), %%rdx; "	/* A[2] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[2]*B[0] */
-		"addq %%rax,  %%r8 ;"
-		"movq %%r8, 16(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[2]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[2]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%rax; " /* A[2]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rax ;"
-
-		"addq  %%r9, %%rbx ;"
-		"adcq %%r11, %%rcx ;"
-		"adcq %%r13, %%r15 ;"
-		"adcq    $0, %%rax ;"
-
-		"movq 24(%1), %%rdx; "	/* A[3] */
-		"mulx   (%2),  %%r8,  %%r9; " /* A[3]*B[0] */
-		"addq %%rbx,  %%r8 ;"
-		"movq %%r8, 24(%0) ;"
-		"mulx  8(%2), %%r10, %%r11; " /* A[3]*B[1] */
-		"adcq %%r10,  %%r9 ;"
-		"mulx 16(%2),  %%r8, %%r13; " /* A[3]*B[2] */
-		"adcq  %%r8, %%r11 ;"
-		"mulx 24(%2), %%r10, %%rbx; " /* A[3]*B[3] */
-		"adcq %%r10, %%r13 ;"
-		/******************************************/
-		"adcq    $0, %%rbx ;"
-
-		"addq  %%r9, %%rcx ;"
-		"movq %%rcx, 32(%0) ;"
-		"adcq %%r11, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"adcq %%r13, %%rax ;"
-		"movq %%rax, 48(%0) ;"
-		"adcq    $0, %%rbx ;"
-		"movq %%rbx, 56(%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11", "%r13", "%r15");
+		/* Compute the raw substraction of f1-f2 */
+		"  movq 0(%1), %%r8;"
+		"  subq 0(%2), %%r8;"
+		"  movq 8(%1), %%r9;"
+		"  sbbq 8(%2), %%r9;"
+		"  movq 16(%1), %%r10;"
+		"  sbbq 16(%2), %%r10;"
+		"  movq 24(%1), %%r11;"
+		"  sbbq 24(%2), %%r11;"
+
+		/* Wrap the result back into the field */
+
+		/* Step 1: Compute carry*38 */
+		"  mov $0, %%rax;"
+		"  mov $38, %%rcx;"
+		"  cmovc %%rcx, %%rax;"
+
+		/* Step 2: Substract carry*38 from the original difference */
+		"  sub %%rax, %%r8;"
+		"  sbb $0, %%r9;"
+		"  sbb $0, %%r10;"
+		"  sbb $0, %%r11;"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rcx, %%rax;"
+		"  sub %%rax, %%r8;"
+
+		/* Store the result */
+		"  movq %%r8, 0(%0);"
+		"  movq %%r9, 8(%0);"
+		"  movq %%r10, 16(%0);"
+		"  movq %%r11, 24(%0);"
+	:
+	: "r" (out), "r" (f1), "r" (f2)
+	: "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11", "memory", "cc"
+	);
 }
 
-static void sqr_256x256_integer_adx(u64 *const c, const u64 *const a)
+/* Computes a field multiplication: out <- f1 * f2
+ * Uses the 8-element buffer tmp for intermediate results */
+static inline void fmul(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 {
 	asm volatile(
-		"movq   (%1), %%rdx        ;" /* A[0]      */
-		"mulx  8(%1),  %%r8, %%r14 ;" /* A[1]*A[0] */
-		"xorl %%r15d, %%r15d;"
-		"mulx 16(%1),  %%r9, %%r10 ;" /* A[2]*A[0] */
-		"adcx %%r14,  %%r9 ;"
-		"mulx 24(%1), %%rax, %%rcx ;" /* A[3]*A[0] */
-		"adcx %%rax, %%r10 ;"
-		"movq 24(%1), %%rdx        ;" /* A[3]      */
-		"mulx  8(%1), %%r11, %%rbx ;" /* A[1]*A[3] */
-		"adcx %%rcx, %%r11 ;"
-		"mulx 16(%1), %%rax, %%r13 ;" /* A[2]*A[3] */
-		"adcx %%rax, %%rbx ;"
-		"movq  8(%1), %%rdx        ;" /* A[1]      */
-		"adcx %%r15, %%r13 ;"
-		"mulx 16(%1), %%rax, %%rcx ;" /* A[2]*A[1] */
-		"movq    $0, %%r14 ;"
-		/******************************************/
-		"adcx %%r15, %%r14 ;"
-
-		"xorl %%r15d, %%r15d;"
-		"adox %%rax, %%r10 ;"
-		"adcx  %%r8,  %%r8 ;"
-		"adox %%rcx, %%r11 ;"
-		"adcx  %%r9,  %%r9 ;"
-		"adox %%r15, %%rbx ;"
-		"adcx %%r10, %%r10 ;"
-		"adox %%r15, %%r13 ;"
-		"adcx %%r11, %%r11 ;"
-		"adox %%r15, %%r14 ;"
-		"adcx %%rbx, %%rbx ;"
-		"adcx %%r13, %%r13 ;"
-		"adcx %%r14, %%r14 ;"
-
-		"movq   (%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[0]^2 */
-		/*******************/
-		"movq %%rax,  0(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  8(%0) ;"
-		"movq  8(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9, 16(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10, 24(%0) ;"
-		"movq 16(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11, 32(%0) ;"
-		"adcq %%rcx, %%rbx ;"
-		"movq %%rbx, 40(%0) ;"
-		"movq 24(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 48(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 56(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11", "%r13", "%r14", "%r15");
+		/* Compute the raw multiplication: tmp <- src1 * src2 */
+
+		/* Compute src1[0] * src2 */
+		"  movq 0(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 0(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 8(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"
+		/* Compute src1[1] * src2 */
+		"  movq 8(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 8(%0), %%r8;"    "  movq %%r8, 8(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 16(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[2] * src2 */
+		"  movq 16(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 16(%0), %%r8;"    "  movq %%r8, 16(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 24(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[3] * src2 */
+		"  movq 24(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 24(%0), %%r8;"    "  movq %%r8, 24(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 32(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 40(%0);"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 48(%0);"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 56(%0);"
+		/* Line up pointers */
+		"  mov %0, %1;"
+		"  mov %2, %0;"
+
+		/* Wrap the result back into the field */
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 32(%1), %%r8, %%r13;"
+		"  xor %3, %3;"
+		"  adoxq 0(%1), %%r8;"
+		"  mulxq 40(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 8(%1), %%r9;"
+		"  mulxq 48(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 16(%1), %%r10;"
+		"  mulxq 56(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 24(%1), %%r11;"
+		"  adcx %3, %%rax;"
+		"  adox %3, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %3, %%r9;"
+		"  movq %%r9, 8(%0);"
+		"  adcx %3, %%r10;"
+		"  movq %%r10, 16(%0);"
+		"  adcx %3, %%r11;"
+		"  movq %%r11, 24(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%0);"
+	: "+&r" (tmp), "+&r" (f1), "+&r" (out), "+&r" (f2)
+	:
+	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "memory", "cc"
+	);
 }
 
-static void sqr_256x256_integer_bmi2(u64 *const c, const u64 *const a)
+/* Computes two field multiplications:
+ * out[0] <- f1[0] * f2[0]
+ * out[1] <- f1[1] * f2[1]
+ * Uses the 16-element buffer tmp for intermediate results. */
+static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 {
 	asm volatile(
-		"movq  8(%1), %%rdx        ;" /* A[1]      */
-		"mulx   (%1),  %%r8,  %%r9 ;" /* A[0]*A[1] */
-		"mulx 16(%1), %%r10, %%r11 ;" /* A[2]*A[1] */
-		"mulx 24(%1), %%rcx, %%r14 ;" /* A[3]*A[1] */
-
-		"movq 16(%1), %%rdx        ;" /* A[2]      */
-		"mulx 24(%1), %%r15, %%r13 ;" /* A[3]*A[2] */
-		"mulx   (%1), %%rax, %%rdx ;" /* A[0]*A[2] */
-
-		"addq %%rax,  %%r9 ;"
-		"adcq %%rdx, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq %%r14, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"movq    $0, %%r14 ;"
-		"adcq    $0, %%r14 ;"
-
-		"movq   (%1), %%rdx        ;" /* A[0]      */
-		"mulx 24(%1), %%rax, %%rcx ;" /* A[0]*A[3] */
-
-		"addq %%rax, %%r10 ;"
-		"adcq %%rcx, %%r11 ;"
-		"adcq    $0, %%r15 ;"
-		"adcq    $0, %%r13 ;"
-		"adcq    $0, %%r14 ;"
-
-		"shldq $1, %%r13, %%r14 ;"
-		"shldq $1, %%r15, %%r13 ;"
-		"shldq $1, %%r11, %%r15 ;"
-		"shldq $1, %%r10, %%r11 ;"
-		"shldq $1,  %%r9, %%r10 ;"
-		"shldq $1,  %%r8,  %%r9 ;"
-		"shlq  $1,  %%r8        ;"
-
-		/*******************/
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[0]^2 */
-		/*******************/
-		"movq %%rax,  0(%0) ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,  8(%0) ;"
-		"movq  8(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[1]^2 */
-		"adcq %%rax,  %%r9 ;"
-		"movq  %%r9, 16(%0) ;"
-		"adcq %%rcx, %%r10 ;"
-		"movq %%r10, 24(%0) ;"
-		"movq 16(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[2]^2 */
-		"adcq %%rax, %%r11 ;"
-		"movq %%r11, 32(%0) ;"
-		"adcq %%rcx, %%r15 ;"
-		"movq %%r15, 40(%0) ;"
-		"movq 24(%1), %%rdx ;"
-		"mulx %%rdx, %%rax, %%rcx ;" /* A[3]^2 */
-		"adcq %%rax, %%r13 ;"
-		"movq %%r13, 48(%0) ;"
-		"adcq %%rcx, %%r14 ;"
-		"movq %%r14, 56(%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10",
-		  "%r11", "%r13", "%r14", "%r15");
+		/* Compute the raw multiplication tmp[0] <- f1[0] * f2[0] */
+
+		/* Compute src1[0] * src2 */
+		"  movq 0(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 0(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 8(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"
+		/* Compute src1[1] * src2 */
+		"  movq 8(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 8(%0), %%r8;"    "  movq %%r8, 8(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 16(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[2] * src2 */
+		"  movq 16(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 16(%0), %%r8;"    "  movq %%r8, 16(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 24(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[3] * src2 */
+		"  movq 24(%1), %%rdx;"
+		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 24(%0), %%r8;"    "  movq %%r8, 24(%0);"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 32(%0);"
+		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 40(%0);"    "  mov $0, %%r8;"
+		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 48(%0);"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 56(%0);"
+
+		/* Compute the raw multiplication tmp[1] <- f1[1] * f2[1] */
+
+		/* Compute src1[0] * src2 */
+		"  movq 32(%1), %%rdx;"
+		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 64(%0);"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 72(%0);"
+		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"
+		/* Compute src1[1] * src2 */
+		"  movq 40(%1), %%rdx;"
+		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 72(%0), %%r8;"    "  movq %%r8, 72(%0);"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 80(%0);"
+		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[2] * src2 */
+		"  movq 48(%1), %%rdx;"
+		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 80(%0), %%r8;"    "  movq %%r8, 80(%0);"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 88(%0);"
+		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
+		/* Compute src1[3] * src2 */
+		"  movq 56(%1), %%rdx;"
+		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 88(%0), %%r8;"    "  movq %%r8, 88(%0);"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 96(%0);"
+		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 104(%0);"    "  mov $0, %%r8;"
+		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 112(%0);"    "  mov $0, %%rax;"
+		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 120(%0);"
+		/* Line up pointers */
+		"  mov %0, %1;"
+		"  mov %2, %0;"
+
+		/* Wrap the results back into the field */
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 32(%1), %%r8, %%r13;"
+		"  xor %3, %3;"
+		"  adoxq 0(%1), %%r8;"
+		"  mulxq 40(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 8(%1), %%r9;"
+		"  mulxq 48(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 16(%1), %%r10;"
+		"  mulxq 56(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 24(%1), %%r11;"
+		"  adcx %3, %%rax;"
+		"  adox %3, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %3, %%r9;"
+		"  movq %%r9, 8(%0);"
+		"  adcx %3, %%r10;"
+		"  movq %%r10, 16(%0);"
+		"  adcx %3, %%r11;"
+		"  movq %%r11, 24(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%0);"
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 96(%1), %%r8, %%r13;"
+		"  xor %3, %3;"
+		"  adoxq 64(%1), %%r8;"
+		"  mulxq 104(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 72(%1), %%r9;"
+		"  mulxq 112(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 80(%1), %%r10;"
+		"  mulxq 120(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 88(%1), %%r11;"
+		"  adcx %3, %%rax;"
+		"  adox %3, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %3, %%r9;"
+		"  movq %%r9, 40(%0);"
+		"  adcx %3, %%r10;"
+		"  movq %%r10, 48(%0);"
+		"  adcx %3, %%r11;"
+		"  movq %%r11, 56(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 32(%0);"
+	: "+&r" (tmp), "+&r" (f1), "+&r" (out), "+&r" (f2)
+	:
+	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "memory", "cc"
+	);
 }
 
-static void red_eltfp25519_1w_adx(u64 *const c, const u64 *const a)
+/* Computes the field multiplication of four-element f1 with value in f2 */
+static inline void fmul_scalar(u64 *out, const u64 *f1, u64 f2)
 {
-	asm volatile(
-		"movl    $38, %%edx ;"	/* 2*c = 38 = 2^256 */
-		"mulx 32(%1),  %%r8, %%r10 ;" /* c*C[4] */
-		"xorl %%ebx, %%ebx ;"
-		"adox   (%1),  %%r8 ;"
-		"mulx 40(%1),  %%r9, %%r11 ;" /* c*C[5] */
-		"adcx %%r10,  %%r9 ;"
-		"adox  8(%1),  %%r9 ;"
-		"mulx 48(%1), %%r10, %%rax ;" /* c*C[6] */
-		"adcx %%r11, %%r10 ;"
-		"adox 16(%1), %%r10 ;"
-		"mulx 56(%1), %%r11, %%rcx ;" /* c*C[7] */
-		"adcx %%rax, %%r11 ;"
-		"adox 24(%1), %%r11 ;"
-		/***************************************/
-		"adcx %%rbx, %%rcx ;"
-		"adox  %%rbx, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0, of=0 */
-		"adcx %%rcx,  %%r8 ;"
-		"adcx %%rbx,  %%r9 ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcx %%rbx, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"adcx %%rbx, %%r11 ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9",
-		  "%r10", "%r11");
-}
+	register u64 f2_r asm("rdx") = f2;
 
-static void red_eltfp25519_1w_bmi2(u64 *const c, const u64 *const a)
-{
 	asm volatile(
-		"movl    $38, %%edx ;"	/* 2*c = 38 = 2^256 */
-		"mulx 32(%1),  %%r8, %%r10 ;" /* c*C[4] */
-		"mulx 40(%1),  %%r9, %%r11 ;" /* c*C[5] */
-		"addq %%r10,  %%r9 ;"
-		"mulx 48(%1), %%r10, %%rax ;" /* c*C[6] */
-		"adcq %%r11, %%r10 ;"
-		"mulx 56(%1), %%r11, %%rcx ;" /* c*C[7] */
-		"adcq %%rax, %%r11 ;"
-		/***************************************/
-		"adcq    $0, %%rcx ;"
-		"addq   (%1),  %%r8 ;"
-		"adcq  8(%1),  %%r9 ;"
-		"adcq 16(%1), %%r10 ;"
-		"adcq 24(%1), %%r11 ;"
-		"adcq     $0, %%rcx ;"
-		"imul %%rdx, %%rcx ;" /* c*C[4], cf=0 */
-		"addq %%rcx,  %%r8 ;"
-		"adcq    $0,  %%r9 ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcq    $0, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"adcq    $0, %%r11 ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a)
-		: "memory", "cc", "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10",
-		  "%r11");
+		/* Compute the raw multiplication of f1*f2 */
+		"  mulxq 0(%2), %%r8, %%rcx;"      /* f1[0]*f2 */
+		"  mulxq 8(%2), %%r9, %%r12;"      /* f1[1]*f2 */
+		"  add %%rcx, %%r9;"
+		"  mov $0, %%rcx;"
+		"  mulxq 16(%2), %%r10, %%r13;"    /* f1[2]*f2 */
+		"  adcx %%r12, %%r10;"
+		"  mulxq 24(%2), %%r11, %%rax;"    /* f1[3]*f2 */
+		"  adcx %%r13, %%r11;"
+		"  adcx %%rcx, %%rax;"
+
+		/* Wrap the result back into the field */
+
+		/* Step 1: Compute carry*38 */
+		"  mov $38, %%rdx;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %%rcx, %%r9;"
+		"  movq %%r9, 8(%1);"
+		"  adcx %%rcx, %%r10;"
+		"  movq %%r10, 16(%1);"
+		"  adcx %%rcx, %%r11;"
+		"  movq %%r11, 24(%1);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%1);"
+	: "+&r" (f2_r)
+	: "r" (out), "r" (f1)
+	: "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "memory", "cc"
+	);
 }
 
-static __always_inline void
-add_eltfp25519_1w_adx(u64 *const c, const u64 *const a, const u64 *const b)
+/* Computes p1 <- bit ? p2 : p1 in constant time */
+static inline void cswap2(u64 bit, const u64 *p1, const u64 *p2)
 {
 	asm volatile(
-		"mov     $38, %%eax ;"
-		"xorl  %%ecx, %%ecx ;"
-		"movq   (%2),  %%r8 ;"
-		"adcx   (%1),  %%r8 ;"
-		"movq  8(%2),  %%r9 ;"
-		"adcx  8(%1),  %%r9 ;"
-		"movq 16(%2), %%r10 ;"
-		"adcx 16(%1), %%r10 ;"
-		"movq 24(%2), %%r11 ;"
-		"adcx 24(%1), %%r11 ;"
-		"cmovc %%eax, %%ecx ;"
-		"xorl %%eax, %%eax  ;"
-		"adcx %%rcx,  %%r8  ;"
-		"adcx %%rax,  %%r9  ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcx %%rax, %%r10  ;"
-		"movq %%r10, 16(%0) ;"
-		"adcx %%rax, %%r11  ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $38, %%ecx ;"
-		"cmovc %%ecx, %%eax ;"
-		"addq %%rax,  %%r8  ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11");
+		/* Invert the polarity of bit to match cmov expectations */
+		"  add $18446744073709551615, %0;"
+
+		/* cswap p1[0], p2[0] */
+		"  movq 0(%1), %%r8;"
+		"  movq 0(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 0(%1);"
+		"  movq %%r9, 0(%2);"
+
+		/* cswap p1[1], p2[1] */
+		"  movq 8(%1), %%r8;"
+		"  movq 8(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 8(%1);"
+		"  movq %%r9, 8(%2);"
+
+		/* cswap p1[2], p2[2] */
+		"  movq 16(%1), %%r8;"
+		"  movq 16(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 16(%1);"
+		"  movq %%r9, 16(%2);"
+
+		/* cswap p1[3], p2[3] */
+		"  movq 24(%1), %%r8;"
+		"  movq 24(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 24(%1);"
+		"  movq %%r9, 24(%2);"
+
+		/* cswap p1[4], p2[4] */
+		"  movq 32(%1), %%r8;"
+		"  movq 32(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 32(%1);"
+		"  movq %%r9, 32(%2);"
+
+		/* cswap p1[5], p2[5] */
+		"  movq 40(%1), %%r8;"
+		"  movq 40(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 40(%1);"
+		"  movq %%r9, 40(%2);"
+
+		/* cswap p1[6], p2[6] */
+		"  movq 48(%1), %%r8;"
+		"  movq 48(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 48(%1);"
+		"  movq %%r9, 48(%2);"
+
+		/* cswap p1[7], p2[7] */
+		"  movq 56(%1), %%r8;"
+		"  movq 56(%2), %%r9;"
+		"  mov %%r8, %%r10;"
+		"  cmovc %%r9, %%r8;"
+		"  cmovc %%r10, %%r9;"
+		"  movq %%r8, 56(%1);"
+		"  movq %%r9, 56(%2);"
+	: "+&r" (bit)
+	: "r" (p1), "r" (p2)
+	: "%r8", "%r9", "%r10", "memory", "cc"
+	);
 }
 
-static __always_inline void
-add_eltfp25519_1w_bmi2(u64 *const c, const u64 *const a, const u64 *const b)
+/* Computes the square of a field element: out <- f * f
+ * Uses the 8-element buffer tmp for intermediate results */
+static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 {
 	asm volatile(
-		"mov     $38, %%eax ;"
-		"movq   (%2),  %%r8 ;"
-		"addq   (%1),  %%r8 ;"
-		"movq  8(%2),  %%r9 ;"
-		"adcq  8(%1),  %%r9 ;"
-		"movq 16(%2), %%r10 ;"
-		"adcq 16(%1), %%r10 ;"
-		"movq 24(%2), %%r11 ;"
-		"adcq 24(%1), %%r11 ;"
-		"mov      $0, %%ecx ;"
-		"cmovc %%eax, %%ecx ;"
-		"addq %%rcx,  %%r8  ;"
-		"adcq    $0,  %%r9  ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcq    $0, %%r10  ;"
-		"movq %%r10, 16(%0) ;"
-		"adcq    $0, %%r11  ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx  ;"
-		"cmovc %%eax, %%ecx ;"
-		"addq %%rcx,  %%r8  ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11");
+		/* Compute the raw multiplication: tmp <- f * f */
+
+		/* Step 1: Compute all partial products */
+		"  movq 0(%1), %%rdx;"                                       /* f[0] */
+		"  mulxq 8(%1), %%r8, %%r14;"      "  xor %%r15, %%r15;"     /* f[1]*f[0] */
+		"  mulxq 16(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
+		"  mulxq 24(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
+		"  movq 24(%1), %%rdx;"                                      /* f[3] */
+		"  mulxq 8(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  movq 8(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
+		"  mulxq 16(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
+
+		/* Step 2: Compute two parallel carry chains */
+		"  xor %%r15, %%r15;"
+		"  adox %%rax, %%r10;"
+		"  adcx %%r8, %%r8;"
+		"  adox %%rcx, %%r11;"
+		"  adcx %%r9, %%r9;"
+		"  adox %%r15, %%r12;"
+		"  adcx %%r10, %%r10;"
+		"  adox %%r15, %%r13;"
+		"  adcx %%r11, %%r11;"
+		"  adox %%r15, %%r14;"
+		"  adcx %%r12, %%r12;"
+		"  adcx %%r13, %%r13;"
+		"  adcx %%r14, %%r14;"
+
+		/* Step 3: Compute intermediate squares */
+		"  movq 0(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[0]^2 */
+		                           "  movq %%rax, 0(%0);"
+		"  add %%rcx, %%r8;"       "  movq %%r8, 8(%0);"
+		"  movq 8(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[1]^2 */
+		"  adcx %%rax, %%r9;"      "  movq %%r9, 16(%0);"
+		"  adcx %%rcx, %%r10;"     "  movq %%r10, 24(%0);"
+		"  movq 16(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
+		"  adcx %%rax, %%r11;"     "  movq %%r11, 32(%0);"
+		"  adcx %%rcx, %%r12;"     "  movq %%r12, 40(%0);"
+		"  movq 24(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
+		"  adcx %%rax, %%r13;"     "  movq %%r13, 48(%0);"
+		"  adcx %%rcx, %%r14;"     "  movq %%r14, 56(%0);"
+
+		/* Line up pointers */
+		"  mov %0, %1;"
+		"  mov %2, %0;"
+
+		/* Wrap the result back into the field */
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 32(%1), %%r8, %%r13;"
+		"  xor %%rcx, %%rcx;"
+		"  adoxq 0(%1), %%r8;"
+		"  mulxq 40(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 8(%1), %%r9;"
+		"  mulxq 48(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 16(%1), %%r10;"
+		"  mulxq 56(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 24(%1), %%r11;"
+		"  adcx %%rcx, %%rax;"
+		"  adox %%rcx, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %%rcx, %%r9;"
+		"  movq %%r9, 8(%0);"
+		"  adcx %%rcx, %%r10;"
+		"  movq %%r10, 16(%0);"
+		"  adcx %%rcx, %%r11;"
+		"  movq %%r11, 24(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%0);"
+	: "+&r" (tmp), "+&r" (f), "+&r" (out)
+	:
+	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "memory", "cc"
+	);
 }
 
-static __always_inline void
-sub_eltfp25519_1w(u64 *const c, const u64 *const a, const u64 *const b)
+/* Computes two field squarings:
+ * out[0] <- f[0] * f[0]
+ * out[1] <- f[1] * f[1]
+ * Uses the 16-element buffer tmp for intermediate results */
+static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 {
 	asm volatile(
-		"mov     $38, %%eax ;"
-		"movq   (%1),  %%r8 ;"
-		"subq   (%2),  %%r8 ;"
-		"movq  8(%1),  %%r9 ;"
-		"sbbq  8(%2),  %%r9 ;"
-		"movq 16(%1), %%r10 ;"
-		"sbbq 16(%2), %%r10 ;"
-		"movq 24(%1), %%r11 ;"
-		"sbbq 24(%2), %%r11 ;"
-		"mov      $0, %%ecx ;"
-		"cmovc %%eax, %%ecx ;"
-		"subq %%rcx,  %%r8  ;"
-		"sbbq    $0,  %%r9  ;"
-		"movq  %%r9,  8(%0) ;"
-		"sbbq    $0, %%r10  ;"
-		"movq %%r10, 16(%0) ;"
-		"sbbq    $0, %%r11  ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx  ;"
-		"cmovc %%eax, %%ecx ;"
-		"subq %%rcx,  %%r8  ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(b)
-		: "memory", "cc", "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11");
+		/* Step 1: Compute all partial products */
+		"  movq 0(%1), %%rdx;"                                       /* f[0] */
+		"  mulxq 8(%1), %%r8, %%r14;"      "  xor %%r15, %%r15;"     /* f[1]*f[0] */
+		"  mulxq 16(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
+		"  mulxq 24(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
+		"  movq 24(%1), %%rdx;"                                      /* f[3] */
+		"  mulxq 8(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  movq 8(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
+		"  mulxq 16(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
+
+		/* Step 2: Compute two parallel carry chains */
+		"  xor %%r15, %%r15;"
+		"  adox %%rax, %%r10;"
+		"  adcx %%r8, %%r8;"
+		"  adox %%rcx, %%r11;"
+		"  adcx %%r9, %%r9;"
+		"  adox %%r15, %%r12;"
+		"  adcx %%r10, %%r10;"
+		"  adox %%r15, %%r13;"
+		"  adcx %%r11, %%r11;"
+		"  adox %%r15, %%r14;"
+		"  adcx %%r12, %%r12;"
+		"  adcx %%r13, %%r13;"
+		"  adcx %%r14, %%r14;"
+
+		/* Step 3: Compute intermediate squares */
+		"  movq 0(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[0]^2 */
+		                           "  movq %%rax, 0(%0);"
+		"  add %%rcx, %%r8;"       "  movq %%r8, 8(%0);"
+		"  movq 8(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[1]^2 */
+		"  adcx %%rax, %%r9;"      "  movq %%r9, 16(%0);"
+		"  adcx %%rcx, %%r10;"     "  movq %%r10, 24(%0);"
+		"  movq 16(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
+		"  adcx %%rax, %%r11;"     "  movq %%r11, 32(%0);"
+		"  adcx %%rcx, %%r12;"     "  movq %%r12, 40(%0);"
+		"  movq 24(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
+		"  adcx %%rax, %%r13;"     "  movq %%r13, 48(%0);"
+		"  adcx %%rcx, %%r14;"     "  movq %%r14, 56(%0);"
+
+		/* Step 1: Compute all partial products */
+		"  movq 32(%1), %%rdx;"                                       /* f[0] */
+		"  mulxq 40(%1), %%r8, %%r14;"      "  xor %%r15, %%r15;"     /* f[1]*f[0] */
+		"  mulxq 48(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
+		"  mulxq 56(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
+		"  movq 56(%1), %%rdx;"                                      /* f[3] */
+		"  mulxq 40(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 48(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  movq 40(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
+		"  mulxq 48(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
+
+		/* Step 2: Compute two parallel carry chains */
+		"  xor %%r15, %%r15;"
+		"  adox %%rax, %%r10;"
+		"  adcx %%r8, %%r8;"
+		"  adox %%rcx, %%r11;"
+		"  adcx %%r9, %%r9;"
+		"  adox %%r15, %%r12;"
+		"  adcx %%r10, %%r10;"
+		"  adox %%r15, %%r13;"
+		"  adcx %%r11, %%r11;"
+		"  adox %%r15, %%r14;"
+		"  adcx %%r12, %%r12;"
+		"  adcx %%r13, %%r13;"
+		"  adcx %%r14, %%r14;"
+
+		/* Step 3: Compute intermediate squares */
+		"  movq 32(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[0]^2 */
+		                           "  movq %%rax, 64(%0);"
+		"  add %%rcx, %%r8;"       "  movq %%r8, 72(%0);"
+		"  movq 40(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[1]^2 */
+		"  adcx %%rax, %%r9;"      "  movq %%r9, 80(%0);"
+		"  adcx %%rcx, %%r10;"     "  movq %%r10, 88(%0);"
+		"  movq 48(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
+		"  adcx %%rax, %%r11;"     "  movq %%r11, 96(%0);"
+		"  adcx %%rcx, %%r12;"     "  movq %%r12, 104(%0);"
+		"  movq 56(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
+		"  adcx %%rax, %%r13;"     "  movq %%r13, 112(%0);"
+		"  adcx %%rcx, %%r14;"     "  movq %%r14, 120(%0);"
+
+		/* Line up pointers */
+		"  mov %0, %1;"
+		"  mov %2, %0;"
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 32(%1), %%r8, %%r13;"
+		"  xor %%rcx, %%rcx;"
+		"  adoxq 0(%1), %%r8;"
+		"  mulxq 40(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 8(%1), %%r9;"
+		"  mulxq 48(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 16(%1), %%r10;"
+		"  mulxq 56(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 24(%1), %%r11;"
+		"  adcx %%rcx, %%rax;"
+		"  adox %%rcx, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %%rcx, %%r9;"
+		"  movq %%r9, 8(%0);"
+		"  adcx %%rcx, %%r10;"
+		"  movq %%r10, 16(%0);"
+		"  adcx %%rcx, %%r11;"
+		"  movq %%r11, 24(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 0(%0);"
+
+		/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
+		"  mov $38, %%rdx;"
+		"  mulxq 96(%1), %%r8, %%r13;"
+		"  xor %%rcx, %%rcx;"
+		"  adoxq 64(%1), %%r8;"
+		"  mulxq 104(%1), %%r9, %%r12;"
+		"  adcx %%r13, %%r9;"
+		"  adoxq 72(%1), %%r9;"
+		"  mulxq 112(%1), %%r10, %%r13;"
+		"  adcx %%r12, %%r10;"
+		"  adoxq 80(%1), %%r10;"
+		"  mulxq 120(%1), %%r11, %%rax;"
+		"  adcx %%r13, %%r11;"
+		"  adoxq 88(%1), %%r11;"
+		"  adcx %%rcx, %%rax;"
+		"  adox %%rcx, %%rax;"
+		"  imul %%rdx, %%rax;"
+
+		/* Step 2: Fold the carry back into dst */
+		"  add %%rax, %%r8;"
+		"  adcx %%rcx, %%r9;"
+		"  movq %%r9, 40(%0);"
+		"  adcx %%rcx, %%r10;"
+		"  movq %%r10, 48(%0);"
+		"  adcx %%rcx, %%r11;"
+		"  movq %%r11, 56(%0);"
+
+		/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
+		"  mov $0, %%rax;"
+		"  cmovc %%rdx, %%rax;"
+		"  add %%rax, %%r8;"
+		"  movq %%r8, 32(%0);"
+	: "+&r" (tmp), "+&r" (f), "+&r" (out)
+	:
+	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "memory", "cc"
+	);
 }
 
-/* Multiplication by a24 = (A+2)/4 = (486662+2)/4 = 121666 */
-static __always_inline void
-mul_a24_eltfp25519_1w(u64 *const c, const u64 *const a)
+static void point_add_and_double(u64 *q, u64 *p01_tmp1, u64 *tmp2)
 {
-	const u64 a24 = 121666;
-	asm volatile(
-		"movq     %2, %%rdx ;"
-		"mulx   (%1),  %%r8, %%r10 ;"
-		"mulx  8(%1),  %%r9, %%r11 ;"
-		"addq %%r10,  %%r9 ;"
-		"mulx 16(%1), %%r10, %%rax ;"
-		"adcq %%r11, %%r10 ;"
-		"mulx 24(%1), %%r11, %%rcx ;"
-		"adcq %%rax, %%r11 ;"
-		/**************************/
-		"adcq    $0, %%rcx ;"
-		"movl   $38, %%edx ;" /* 2*c = 38 = 2^256 mod 2^255-19*/
-		"imul %%rdx, %%rcx ;"
-		"addq %%rcx,  %%r8 ;"
-		"adcq    $0,  %%r9 ;"
-		"movq  %%r9,  8(%0) ;"
-		"adcq    $0, %%r10 ;"
-		"movq %%r10, 16(%0) ;"
-		"adcq    $0, %%r11 ;"
-		"movq %%r11, 24(%0) ;"
-		"mov     $0, %%ecx ;"
-		"cmovc %%edx, %%ecx ;"
-		"addq %%rcx,  %%r8 ;"
-		"movq  %%r8,   (%0) ;"
-		:
-		: "r"(c), "r"(a), "r"(a24)
-		: "memory", "cc", "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10",
-		  "%r11");
+	u64 *nq = p01_tmp1;
+	u64 *nq_p1 = p01_tmp1 + (u32)8U;
+	u64 *tmp1 = p01_tmp1 + (u32)16U;
+	u64 *x1 = q;
+	u64 *x2 = nq;
+	u64 *z2 = nq + (u32)4U;
+	u64 *z3 = nq_p1 + (u32)4U;
+	u64 *a = tmp1;
+	u64 *b = tmp1 + (u32)4U;
+	u64 *ab = tmp1;
+	u64 *dc = tmp1 + (u32)8U;
+	u64 *x3;
+	u64 *z31;
+	u64 *d0;
+	u64 *c0;
+	u64 *a1;
+	u64 *b1;
+	u64 *d;
+	u64 *c;
+	u64 *ab1;
+	u64 *dc1;
+	fadd(a, x2, z2);
+	fsub(b, x2, z2);
+	x3 = nq_p1;
+	z31 = nq_p1 + (u32)4U;
+	d0 = dc;
+	c0 = dc + (u32)4U;
+	fadd(c0, x3, z31);
+	fsub(d0, x3, z31);
+	fmul2(dc, dc, ab, tmp2);
+	fadd(x3, d0, c0);
+	fsub(z31, d0, c0);
+	a1 = tmp1;
+	b1 = tmp1 + (u32)4U;
+	d = tmp1 + (u32)8U;
+	c = tmp1 + (u32)12U;
+	ab1 = tmp1;
+	dc1 = tmp1 + (u32)8U;
+	fsqr2(dc1, ab1, tmp2);
+	fsqr2(nq_p1, nq_p1, tmp2);
+	a1[0U] = c[0U];
+	a1[1U] = c[1U];
+	a1[2U] = c[2U];
+	a1[3U] = c[3U];
+	fsub(c, d, c);
+	fmul_scalar(b1, c, (u64)121665U);
+	fadd(b1, b1, d);
+	fmul2(nq, dc1, ab1, tmp2);
+	fmul(z3, z3, x1, tmp2);
 }
 
-static void inv_eltfp25519_1w_adx(u64 *const c, const u64 *const a)
+static void point_double(u64 *nq, u64 *tmp1, u64 *tmp2)
 {
-	struct {
-		eltfp25519_1w_buffer buffer;
-		eltfp25519_1w x0, x1, x2;
-	} __aligned(32) m;
-	u64 *T[4];
-
-	T[0] = m.x0;
-	T[1] = c; /* x^(-1) */
-	T[2] = m.x1;
-	T[3] = m.x2;
-
-	copy_eltfp25519_1w(T[1], a);
-	sqrn_eltfp25519_1w_adx(T[1], 1);
-	copy_eltfp25519_1w(T[2], T[1]);
-	sqrn_eltfp25519_1w_adx(T[2], 2);
-	mul_eltfp25519_1w_adx(T[0], a, T[2]);
-	mul_eltfp25519_1w_adx(T[1], T[1], T[0]);
-	copy_eltfp25519_1w(T[2], T[1]);
-	sqrn_eltfp25519_1w_adx(T[2], 1);
-	mul_eltfp25519_1w_adx(T[0], T[0], T[2]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_adx(T[2], 5);
-	mul_eltfp25519_1w_adx(T[0], T[0], T[2]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_adx(T[2], 10);
-	mul_eltfp25519_1w_adx(T[2], T[2], T[0]);
-	copy_eltfp25519_1w(T[3], T[2]);
-	sqrn_eltfp25519_1w_adx(T[3], 20);
-	mul_eltfp25519_1w_adx(T[3], T[3], T[2]);
-	sqrn_eltfp25519_1w_adx(T[3], 10);
-	mul_eltfp25519_1w_adx(T[3], T[3], T[0]);
-	copy_eltfp25519_1w(T[0], T[3]);
-	sqrn_eltfp25519_1w_adx(T[0], 50);
-	mul_eltfp25519_1w_adx(T[0], T[0], T[3]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_adx(T[2], 100);
-	mul_eltfp25519_1w_adx(T[2], T[2], T[0]);
-	sqrn_eltfp25519_1w_adx(T[2], 50);
-	mul_eltfp25519_1w_adx(T[2], T[2], T[3]);
-	sqrn_eltfp25519_1w_adx(T[2], 5);
-	mul_eltfp25519_1w_adx(T[1], T[1], T[2]);
-
-	memzero_explicit(&m, sizeof(m));
+	u64 *x2 = nq;
+	u64 *z2 = nq + (u32)4U;
+	u64 *a = tmp1;
+	u64 *b = tmp1 + (u32)4U;
+	u64 *d = tmp1 + (u32)8U;
+	u64 *c = tmp1 + (u32)12U;
+	u64 *ab = tmp1;
+	u64 *dc = tmp1 + (u32)8U;
+	fadd(a, x2, z2);
+	fsub(b, x2, z2);
+	fsqr2(dc, ab, tmp2);
+	a[0U] = c[0U];
+	a[1U] = c[1U];
+	a[2U] = c[2U];
+	a[3U] = c[3U];
+	fsub(c, d, c);
+	fmul_scalar(b, c, (u64)121665U);
+	fadd(b, b, d);
+	fmul2(nq, dc, ab, tmp2);
 }
 
-static void inv_eltfp25519_1w_bmi2(u64 *const c, const u64 *const a)
+static void montgomery_ladder(u64 *out, const u8 *key, u64 *init1)
 {
-	struct {
-		eltfp25519_1w_buffer buffer;
-		eltfp25519_1w x0, x1, x2;
-	} __aligned(32) m;
-	u64 *T[5];
-
-	T[0] = m.x0;
-	T[1] = c; /* x^(-1) */
-	T[2] = m.x1;
-	T[3] = m.x2;
-
-	copy_eltfp25519_1w(T[1], a);
-	sqrn_eltfp25519_1w_bmi2(T[1], 1);
-	copy_eltfp25519_1w(T[2], T[1]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 2);
-	mul_eltfp25519_1w_bmi2(T[0], a, T[2]);
-	mul_eltfp25519_1w_bmi2(T[1], T[1], T[0]);
-	copy_eltfp25519_1w(T[2], T[1]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 1);
-	mul_eltfp25519_1w_bmi2(T[0], T[0], T[2]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 5);
-	mul_eltfp25519_1w_bmi2(T[0], T[0], T[2]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 10);
-	mul_eltfp25519_1w_bmi2(T[2], T[2], T[0]);
-	copy_eltfp25519_1w(T[3], T[2]);
-	sqrn_eltfp25519_1w_bmi2(T[3], 20);
-	mul_eltfp25519_1w_bmi2(T[3], T[3], T[2]);
-	sqrn_eltfp25519_1w_bmi2(T[3], 10);
-	mul_eltfp25519_1w_bmi2(T[3], T[3], T[0]);
-	copy_eltfp25519_1w(T[0], T[3]);
-	sqrn_eltfp25519_1w_bmi2(T[0], 50);
-	mul_eltfp25519_1w_bmi2(T[0], T[0], T[3]);
-	copy_eltfp25519_1w(T[2], T[0]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 100);
-	mul_eltfp25519_1w_bmi2(T[2], T[2], T[0]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 50);
-	mul_eltfp25519_1w_bmi2(T[2], T[2], T[3]);
-	sqrn_eltfp25519_1w_bmi2(T[2], 5);
-	mul_eltfp25519_1w_bmi2(T[1], T[1], T[2]);
-
-	memzero_explicit(&m, sizeof(m));
+	u64 tmp2[16U] = { 0U };
+	u64 p01_tmp1_swap[33U] = { 0U };
+	u64 *p0 = p01_tmp1_swap;
+	u64 *p01 = p01_tmp1_swap;
+	u64 *p03 = p01;
+	u64 *p11 = p01 + (u32)8U;
+	u64 *x0;
+	u64 *z0;
+	u64 *p01_tmp1;
+	u64 *p01_tmp11;
+	u64 *nq10;
+	u64 *nq_p11;
+	u64 *swap1;
+	u64 sw0;
+	u64 *nq1;
+	u64 *tmp1;
+	memcpy(p11, init1, (u32)8U * sizeof(init1[0U]));
+	x0 = p03;
+	z0 = p03 + (u32)4U;
+	x0[0U] = (u64)1U;
+	x0[1U] = (u64)0U;
+	x0[2U] = (u64)0U;
+	x0[3U] = (u64)0U;
+	z0[0U] = (u64)0U;
+	z0[1U] = (u64)0U;
+	z0[2U] = (u64)0U;
+	z0[3U] = (u64)0U;
+	p01_tmp1 = p01_tmp1_swap;
+	p01_tmp11 = p01_tmp1_swap;
+	nq10 = p01_tmp1_swap;
+	nq_p11 = p01_tmp1_swap + (u32)8U;
+	swap1 = p01_tmp1_swap + (u32)32U;
+	cswap2((u64)1U, nq10, nq_p11);
+	point_add_and_double(init1, p01_tmp11, tmp2);
+	swap1[0U] = (u64)1U;
+	{
+		u32 i;
+		for (i = (u32)0U; i < (u32)251U; i = i + (u32)1U) {
+			u64 *p01_tmp12 = p01_tmp1_swap;
+			u64 *swap2 = p01_tmp1_swap + (u32)32U;
+			u64 *nq2 = p01_tmp12;
+			u64 *nq_p12 = p01_tmp12 + (u32)8U;
+			u64 bit = (u64)(key[((u32)253U - i) / (u32)8U] >> ((u32)253U - i) % (u32)8U & (u8)1U);
+			u64 sw = swap2[0U] ^ bit;
+			cswap2(sw, nq2, nq_p12);
+			point_add_and_double(init1, p01_tmp12, tmp2);
+			swap2[0U] = bit;
+		}
+	}
+	sw0 = swap1[0U];
+	cswap2(sw0, nq10, nq_p11);
+	nq1 = p01_tmp1;
+	tmp1 = p01_tmp1 + (u32)16U;
+	point_double(nq1, tmp1, tmp2);
+	point_double(nq1, tmp1, tmp2);
+	point_double(nq1, tmp1, tmp2);
+	memcpy(out, p0, (u32)8U * sizeof(p0[0U]));
+
+	memzero_explicit(tmp2, sizeof(tmp2));
+	memzero_explicit(p01_tmp1_swap, sizeof(p01_tmp1_swap));
 }
 
-/* Given c, a 256-bit number, fred_eltfp25519_1w updates c
- * with a number such that 0 <= C < 2**255-19.
- */
-static __always_inline void fred_eltfp25519_1w(u64 *const c)
+static void fsquare_times(u64 *o, const u64 *inp, u64 *tmp, u32 n1)
 {
-	u64 tmp0 = 38, tmp1 = 19;
-	asm volatile(
-		"btrq   $63,    %3 ;" /* Put bit 255 in carry flag and clear */
-		"cmovncl %k5,   %k4 ;" /* c[255] ? 38 : 19 */
-
-		/* Add either 19 or 38 to c */
-		"addq    %4,   %0 ;"
-		"adcq    $0,   %1 ;"
-		"adcq    $0,   %2 ;"
-		"adcq    $0,   %3 ;"
-
-		/* Test for bit 255 again; only triggered on overflow modulo 2^255-19 */
-		"movl    $0,  %k4 ;"
-		"cmovnsl %k5,  %k4 ;" /* c[255] ? 0 : 19 */
-		"btrq   $63,   %3 ;" /* Clear bit 255 */
-
-		/* Subtract 19 if necessary */
-		"subq    %4,   %0 ;"
-		"sbbq    $0,   %1 ;"
-		"sbbq    $0,   %2 ;"
-		"sbbq    $0,   %3 ;"
-
-		: "+r"(c[0]), "+r"(c[1]), "+r"(c[2]), "+r"(c[3]), "+r"(tmp0),
-		  "+r"(tmp1)
-		:
-		: "memory", "cc");
+	u32 i;
+	fsqr(o, inp, tmp);
+	for (i = (u32)0U; i < n1 - (u32)1U; i = i + (u32)1U)
+		fsqr(o, o, tmp);
 }
 
-static __always_inline void cswap(u8 bit, u64 *const px, u64 *const py)
+static void finv(u64 *o, const u64 *i, u64 *tmp)
 {
-	u64 temp;
-	asm volatile(
-		"test %9, %9 ;"
-		"movq %0, %8 ;"
-		"cmovnzq %4, %0 ;"
-		"cmovnzq %8, %4 ;"
-		"movq %1, %8 ;"
-		"cmovnzq %5, %1 ;"
-		"cmovnzq %8, %5 ;"
-		"movq %2, %8 ;"
-		"cmovnzq %6, %2 ;"
-		"cmovnzq %8, %6 ;"
-		"movq %3, %8 ;"
-		"cmovnzq %7, %3 ;"
-		"cmovnzq %8, %7 ;"
-		: "+r"(px[0]), "+r"(px[1]), "+r"(px[2]), "+r"(px[3]),
-		  "+r"(py[0]), "+r"(py[1]), "+r"(py[2]), "+r"(py[3]),
-		  "=r"(temp)
-		: "r"(bit)
-		: "cc"
-	);
+	u64 t1[16U] = { 0U };
+	u64 *a0 = t1;
+	u64 *b = t1 + (u32)4U;
+	u64 *c = t1 + (u32)8U;
+	u64 *t00 = t1 + (u32)12U;
+	u64 *tmp1 = tmp;
+	u64 *a;
+	u64 *t0;
+	fsquare_times(a0, i, tmp1, (u32)1U);
+	fsquare_times(t00, a0, tmp1, (u32)2U);
+	fmul(b, t00, i, tmp);
+	fmul(a0, b, a0, tmp);
+	fsquare_times(t00, a0, tmp1, (u32)1U);
+	fmul(b, t00, b, tmp);
+	fsquare_times(t00, b, tmp1, (u32)5U);
+	fmul(b, t00, b, tmp);
+	fsquare_times(t00, b, tmp1, (u32)10U);
+	fmul(c, t00, b, tmp);
+	fsquare_times(t00, c, tmp1, (u32)20U);
+	fmul(t00, t00, c, tmp);
+	fsquare_times(t00, t00, tmp1, (u32)10U);
+	fmul(b, t00, b, tmp);
+	fsquare_times(t00, b, tmp1, (u32)50U);
+	fmul(c, t00, b, tmp);
+	fsquare_times(t00, c, tmp1, (u32)100U);
+	fmul(t00, t00, c, tmp);
+	fsquare_times(t00, t00, tmp1, (u32)50U);
+	fmul(t00, t00, b, tmp);
+	fsquare_times(t00, t00, tmp1, (u32)5U);
+	a = t1;
+	t0 = t1 + (u32)12U;
+	fmul(o, t0, a, tmp);
 }
 
-static __always_inline void cselect(u8 bit, u64 *const px, const u64 *const py)
+static void store_felem(u64 *b, u64 *f)
 {
-	asm volatile(
-		"test %4, %4 ;"
-		"cmovnzq %5, %0 ;"
-		"cmovnzq %6, %1 ;"
-		"cmovnzq %7, %2 ;"
-		"cmovnzq %8, %3 ;"
-		: "+r"(px[0]), "+r"(px[1]), "+r"(px[2]), "+r"(px[3])
-		: "r"(bit), "rm"(py[0]), "rm"(py[1]), "rm"(py[2]), "rm"(py[3])
-		: "cc"
-	);
+	u64 f30 = f[3U];
+	u64 top_bit0 = f30 >> (u32)63U;
+	u64 carry0;
+	u64 f31;
+	u64 top_bit;
+	u64 carry;
+	u64 f0;
+	u64 f1;
+	u64 f2;
+	u64 f3;
+	u64 m0;
+	u64 m1;
+	u64 m2;
+	u64 m3;
+	u64 mask;
+	u64 f0_;
+	u64 f1_;
+	u64 f2_;
+	u64 f3_;
+	u64 o0;
+	u64 o1;
+	u64 o2;
+	u64 o3;
+	f[3U] = f30 & (u64)0x7fffffffffffffffU;
+	carry0 = add_scalar(f, f, (u64)19U * top_bit0);
+	f31 = f[3U];
+	top_bit = f31 >> (u32)63U;
+	f[3U] = f31 & (u64)0x7fffffffffffffffU;
+	carry = add_scalar(f, f, (u64)19U * top_bit);
+	f0 = f[0U];
+	f1 = f[1U];
+	f2 = f[2U];
+	f3 = f[3U];
+	m0 = gte_mask(f0, (u64)0xffffffffffffffedU);
+	m1 = eq_mask(f1, (u64)0xffffffffffffffffU);
+	m2 = eq_mask(f2, (u64)0xffffffffffffffffU);
+	m3 = eq_mask(f3, (u64)0x7fffffffffffffffU);
+	mask = ((m0 & m1) & m2) & m3;
+	f0_ = f0 - (mask & (u64)0xffffffffffffffedU);
+	f1_ = f1 - (mask & (u64)0xffffffffffffffffU);
+	f2_ = f2 - (mask & (u64)0xffffffffffffffffU);
+	f3_ = f3 - (mask & (u64)0x7fffffffffffffffU);
+	o0 = f0_;
+	o1 = f1_;
+	o2 = f2_;
+	o3 = f3_;
+	b[0U] = o0;
+	b[1U] = o1;
+	b[2U] = o2;
+	b[3U] = o3;
 }
 
-static void curve25519_adx(u8 shared[CURVE25519_KEY_SIZE],
-			   const u8 private_key[CURVE25519_KEY_SIZE],
-			   const u8 session_key[CURVE25519_KEY_SIZE])
+static void encode_point(u8 *o, const u64 *i)
 {
-	struct {
-		u64 buffer[4 * NUM_WORDS_ELTFP25519];
-		u64 coordinates[4 * NUM_WORDS_ELTFP25519];
-		u64 workspace[6 * NUM_WORDS_ELTFP25519];
-		u8 session[CURVE25519_KEY_SIZE];
-		u8 private[CURVE25519_KEY_SIZE];
-	} __aligned(32) m;
-
-	int i = 0, j = 0;
-	u64 prev = 0;
-	u64 *const X1 = (u64 *)m.session;
-	u64 *const key = (u64 *)m.private;
-	u64 *const Px = m.coordinates + 0;
-	u64 *const Pz = m.coordinates + 4;
-	u64 *const Qx = m.coordinates + 8;
-	u64 *const Qz = m.coordinates + 12;
-	u64 *const X2 = Qx;
-	u64 *const Z2 = Qz;
-	u64 *const X3 = Px;
-	u64 *const Z3 = Pz;
-	u64 *const X2Z2 = Qx;
-	u64 *const X3Z3 = Px;
-
-	u64 *const A = m.workspace + 0;
-	u64 *const B = m.workspace + 4;
-	u64 *const D = m.workspace + 8;
-	u64 *const C = m.workspace + 12;
-	u64 *const DA = m.workspace + 16;
-	u64 *const CB = m.workspace + 20;
-	u64 *const AB = A;
-	u64 *const DC = D;
-	u64 *const DACB = DA;
-
-	memcpy(m.private, private_key, sizeof(m.private));
-	memcpy(m.session, session_key, sizeof(m.session));
-
-	curve25519_clamp_secret(m.private);
-
-	/* As in the draft:
-	 * When receiving such an array, implementations of curve25519
-	 * MUST mask the most-significant bit in the final byte. This
-	 * is done to preserve compatibility with point formats which
-	 * reserve the sign bit for use in other protocols and to
-	 * increase resistance to implementation fingerprinting
-	 */
-	m.session[CURVE25519_KEY_SIZE - 1] &= (1 << (255 % 8)) - 1;
-
-	copy_eltfp25519_1w(Px, X1);
-	setzero_eltfp25519_1w(Pz);
-	setzero_eltfp25519_1w(Qx);
-	setzero_eltfp25519_1w(Qz);
-
-	Pz[0] = 1;
-	Qx[0] = 1;
-
-	/* main-loop */
-	prev = 0;
-	j = 62;
-	for (i = 3; i >= 0; --i) {
-		while (j >= 0) {
-			u64 bit = (key[i] >> j) & 0x1;
-			u64 swap = bit ^ prev;
-			prev = bit;
-
-			add_eltfp25519_1w_adx(A, X2, Z2);	/* A = (X2+Z2) */
-			sub_eltfp25519_1w(B, X2, Z2);		/* B = (X2-Z2) */
-			add_eltfp25519_1w_adx(C, X3, Z3);	/* C = (X3+Z3) */
-			sub_eltfp25519_1w(D, X3, Z3);		/* D = (X3-Z3) */
-			mul_eltfp25519_2w_adx(DACB, AB, DC);	/* [DA|CB] = [A|B]*[D|C] */
-
-			cselect(swap, A, C);
-			cselect(swap, B, D);
-
-			sqr_eltfp25519_2w_adx(AB);		/* [AA|BB] = [A^2|B^2] */
-			add_eltfp25519_1w_adx(X3, DA, CB);	/* X3 = (DA+CB) */
-			sub_eltfp25519_1w(Z3, DA, CB);		/* Z3 = (DA-CB) */
-			sqr_eltfp25519_2w_adx(X3Z3);		/* [X3|Z3] = [(DA+CB)|(DA+CB)]^2 */
-
-			copy_eltfp25519_1w(X2, B);		/* X2 = B^2 */
-			sub_eltfp25519_1w(Z2, A, B);		/* Z2 = E = AA-BB */
-
-			mul_a24_eltfp25519_1w(B, Z2);		/* B = a24*E */
-			add_eltfp25519_1w_adx(B, B, X2);	/* B = a24*E+B */
-			mul_eltfp25519_2w_adx(X2Z2, X2Z2, AB);	/* [X2|Z2] = [B|E]*[A|a24*E+B] */
-			mul_eltfp25519_1w_adx(Z3, Z3, X1);	/* Z3 = Z3*X1 */
-			--j;
-		}
-		j = 63;
-	}
-
-	inv_eltfp25519_1w_adx(A, Qz);
-	mul_eltfp25519_1w_adx((u64 *)shared, Qx, A);
-	fred_eltfp25519_1w((u64 *)shared);
-
-	memzero_explicit(&m, sizeof(m));
+	const u64 *x = i;
+	const u64 *z = i + (u32)4U;
+	u64 tmp[4U] = { 0U };
+	u64 tmp_w[16U] = { 0U };
+	finv(tmp, z, tmp_w);
+	fmul(tmp, tmp, x, tmp_w);
+	store_felem((u64 *)o, tmp);
 }
 
-static void curve25519_adx_base(u8 session_key[CURVE25519_KEY_SIZE],
-				const u8 private_key[CURVE25519_KEY_SIZE])
+static void curve25519_ever64(u8 *out, const u8 *priv, const u8 *pub)
 {
-	struct {
-		u64 buffer[4 * NUM_WORDS_ELTFP25519];
-		u64 coordinates[4 * NUM_WORDS_ELTFP25519];
-		u64 workspace[4 * NUM_WORDS_ELTFP25519];
-		u8 private[CURVE25519_KEY_SIZE];
-	} __aligned(32) m;
-
-	const int ite[4] = { 64, 64, 64, 63 };
-	const int q = 3;
-	u64 swap = 1;
-
-	int i = 0, j = 0, k = 0;
-	u64 *const key = (u64 *)m.private;
-	u64 *const Ur1 = m.coordinates + 0;
-	u64 *const Zr1 = m.coordinates + 4;
-	u64 *const Ur2 = m.coordinates + 8;
-	u64 *const Zr2 = m.coordinates + 12;
-
-	u64 *const UZr1 = m.coordinates + 0;
-	u64 *const ZUr2 = m.coordinates + 8;
-
-	u64 *const A = m.workspace + 0;
-	u64 *const B = m.workspace + 4;
-	u64 *const C = m.workspace + 8;
-	u64 *const D = m.workspace + 12;
-
-	u64 *const AB = m.workspace + 0;
-	u64 *const CD = m.workspace + 8;
-
-	const u64 *const P = table_ladder_8k;
-
-	memcpy(m.private, private_key, sizeof(m.private));
-
-	curve25519_clamp_secret(m.private);
-
-	setzero_eltfp25519_1w(Ur1);
-	setzero_eltfp25519_1w(Zr1);
-	setzero_eltfp25519_1w(Zr2);
-	Ur1[0] = 1;
-	Zr1[0] = 1;
-	Zr2[0] = 1;
-
-	/* G-S */
-	Ur2[3] = 0x1eaecdeee27cab34UL;
-	Ur2[2] = 0xadc7a0b9235d48e2UL;
-	Ur2[1] = 0xbbf095ae14b2edf8UL;
-	Ur2[0] = 0x7e94e1fec82faabdUL;
-
-	/* main-loop */
-	j = q;
-	for (i = 0; i < NUM_WORDS_ELTFP25519; ++i) {
-		while (j < ite[i]) {
-			u64 bit = (key[i] >> j) & 0x1;
-			k = (64 * i + j - q);
-			swap = swap ^ bit;
-			cswap(swap, Ur1, Ur2);
-			cswap(swap, Zr1, Zr2);
-			swap = bit;
-			/* Addition */
-			sub_eltfp25519_1w(B, Ur1, Zr1);		/* B = Ur1-Zr1 */
-			add_eltfp25519_1w_adx(A, Ur1, Zr1);	/* A = Ur1+Zr1 */
-			mul_eltfp25519_1w_adx(C, &P[4 * k], B);	/* C = M0-B */
-			sub_eltfp25519_1w(B, A, C);		/* B = (Ur1+Zr1) - M*(Ur1-Zr1) */
-			add_eltfp25519_1w_adx(A, A, C);		/* A = (Ur1+Zr1) + M*(Ur1-Zr1) */
-			sqr_eltfp25519_2w_adx(AB);		/* A = A^2      |  B = B^2 */
-			mul_eltfp25519_2w_adx(UZr1, ZUr2, AB);	/* Ur1 = Zr2*A  |  Zr1 = Ur2*B */
-			++j;
+	u64 init1[8U] = { 0U };
+	u64 tmp[4U] = { 0U };
+	u64 tmp3;
+	u64 *x;
+	u64 *z;
+	{
+		u32 i;
+		for (i = (u32)0U; i < (u32)4U; i = i + (u32)1U) {
+			u64 *os = tmp;
+			const u8 *bj = pub + i * (u32)8U;
+			u64 u = *(u64 *)bj;
+			u64 r = u;
+			u64 x0 = r;
+			os[i] = x0;
 		}
-		j = 0;
 	}
-
-	/* Doubling */
-	for (i = 0; i < q; ++i) {
-		add_eltfp25519_1w_adx(A, Ur1, Zr1);	/*  A = Ur1+Zr1 */
-		sub_eltfp25519_1w(B, Ur1, Zr1);		/*  B = Ur1-Zr1 */
-		sqr_eltfp25519_2w_adx(AB);		/*  A = A**2     B = B**2 */
-		copy_eltfp25519_1w(C, B);		/*  C = B */
-		sub_eltfp25519_1w(B, A, B);		/*  B = A-B */
-		mul_a24_eltfp25519_1w(D, B);		/*  D = my_a24*B */
-		add_eltfp25519_1w_adx(D, D, C);		/*  D = D+C */
-		mul_eltfp25519_2w_adx(UZr1, AB, CD);	/*  Ur1 = A*B   Zr1 = Zr1*A */
-	}
-
-	/* Convert to affine coordinates */
-	inv_eltfp25519_1w_adx(A, Zr1);
-	mul_eltfp25519_1w_adx((u64 *)session_key, Ur1, A);
-	fred_eltfp25519_1w((u64 *)session_key);
-
-	memzero_explicit(&m, sizeof(m));
+	tmp3 = tmp[3U];
+	tmp[3U] = tmp3 & (u64)0x7fffffffffffffffU;
+	x = init1;
+	z = init1 + (u32)4U;
+	z[0U] = (u64)1U;
+	z[1U] = (u64)0U;
+	z[2U] = (u64)0U;
+	z[3U] = (u64)0U;
+	x[0U] = tmp[0U];
+	x[1U] = tmp[1U];
+	x[2U] = tmp[2U];
+	x[3U] = tmp[3U];
+	montgomery_ladder(init1, priv, init1);
+	encode_point(out, init1);
 }
 
-static void curve25519_bmi2(u8 shared[CURVE25519_KEY_SIZE],
-			    const u8 private_key[CURVE25519_KEY_SIZE],
-			    const u8 session_key[CURVE25519_KEY_SIZE])
-{
-	struct {
-		u64 buffer[4 * NUM_WORDS_ELTFP25519];
-		u64 coordinates[4 * NUM_WORDS_ELTFP25519];
-		u64 workspace[6 * NUM_WORDS_ELTFP25519];
-		u8 session[CURVE25519_KEY_SIZE];
-		u8 private[CURVE25519_KEY_SIZE];
-	} __aligned(32) m;
-
-	int i = 0, j = 0;
-	u64 prev = 0;
-	u64 *const X1 = (u64 *)m.session;
-	u64 *const key = (u64 *)m.private;
-	u64 *const Px = m.coordinates + 0;
-	u64 *const Pz = m.coordinates + 4;
-	u64 *const Qx = m.coordinates + 8;
-	u64 *const Qz = m.coordinates + 12;
-	u64 *const X2 = Qx;
-	u64 *const Z2 = Qz;
-	u64 *const X3 = Px;
-	u64 *const Z3 = Pz;
-	u64 *const X2Z2 = Qx;
-	u64 *const X3Z3 = Px;
-
-	u64 *const A = m.workspace + 0;
-	u64 *const B = m.workspace + 4;
-	u64 *const D = m.workspace + 8;
-	u64 *const C = m.workspace + 12;
-	u64 *const DA = m.workspace + 16;
-	u64 *const CB = m.workspace + 20;
-	u64 *const AB = A;
-	u64 *const DC = D;
-	u64 *const DACB = DA;
-
-	memcpy(m.private, private_key, sizeof(m.private));
-	memcpy(m.session, session_key, sizeof(m.session));
-
-	curve25519_clamp_secret(m.private);
-
-	/* As in the draft:
-	 * When receiving such an array, implementations of curve25519
-	 * MUST mask the most-significant bit in the final byte. This
-	 * is done to preserve compatibility with point formats which
-	 * reserve the sign bit for use in other protocols and to
-	 * increase resistance to implementation fingerprinting
-	 */
-	m.session[CURVE25519_KEY_SIZE - 1] &= (1 << (255 % 8)) - 1;
-
-	copy_eltfp25519_1w(Px, X1);
-	setzero_eltfp25519_1w(Pz);
-	setzero_eltfp25519_1w(Qx);
-	setzero_eltfp25519_1w(Qz);
-
-	Pz[0] = 1;
-	Qx[0] = 1;
-
-	/* main-loop */
-	prev = 0;
-	j = 62;
-	for (i = 3; i >= 0; --i) {
-		while (j >= 0) {
-			u64 bit = (key[i] >> j) & 0x1;
-			u64 swap = bit ^ prev;
-			prev = bit;
-
-			add_eltfp25519_1w_bmi2(A, X2, Z2);	/* A = (X2+Z2) */
-			sub_eltfp25519_1w(B, X2, Z2);		/* B = (X2-Z2) */
-			add_eltfp25519_1w_bmi2(C, X3, Z3);	/* C = (X3+Z3) */
-			sub_eltfp25519_1w(D, X3, Z3);		/* D = (X3-Z3) */
-			mul_eltfp25519_2w_bmi2(DACB, AB, DC);	/* [DA|CB] = [A|B]*[D|C] */
-
-			cselect(swap, A, C);
-			cselect(swap, B, D);
-
-			sqr_eltfp25519_2w_bmi2(AB);		/* [AA|BB] = [A^2|B^2] */
-			add_eltfp25519_1w_bmi2(X3, DA, CB);	/* X3 = (DA+CB) */
-			sub_eltfp25519_1w(Z3, DA, CB);		/* Z3 = (DA-CB) */
-			sqr_eltfp25519_2w_bmi2(X3Z3);		/* [X3|Z3] = [(DA+CB)|(DA+CB)]^2 */
-
-			copy_eltfp25519_1w(X2, B);		/* X2 = B^2 */
-			sub_eltfp25519_1w(Z2, A, B);		/* Z2 = E = AA-BB */
-
-			mul_a24_eltfp25519_1w(B, Z2);		/* B = a24*E */
-			add_eltfp25519_1w_bmi2(B, B, X2);	/* B = a24*E+B */
-			mul_eltfp25519_2w_bmi2(X2Z2, X2Z2, AB);	/* [X2|Z2] = [B|E]*[A|a24*E+B] */
-			mul_eltfp25519_1w_bmi2(Z3, Z3, X1);	/* Z3 = Z3*X1 */
-			--j;
-		}
-		j = 63;
-	}
-
-	inv_eltfp25519_1w_bmi2(A, Qz);
-	mul_eltfp25519_1w_bmi2((u64 *)shared, Qx, A);
-	fred_eltfp25519_1w((u64 *)shared);
+/* The below constants were generated using this sage script:
+ *
+ * #!/usr/bin/env sage
+ * import sys
+ * from sage.all import *
+ * def limbs(n):
+ * 	n = int(n)
+ * 	l = ((n >> 0) % 2^64, (n >> 64) % 2^64, (n >> 128) % 2^64, (n >> 192) % 2^64)
+ * 	return "0x%016xULL, 0x%016xULL, 0x%016xULL, 0x%016xULL" % l
+ * ec = EllipticCurve(GF(2^255 - 19), [0, 486662, 0, 1, 0])
+ * p_minus_s = (ec.lift_x(9) - ec.lift_x(1))[0]
+ * print("static const u64 p_minus_s[] = { %s };\n" % limbs(p_minus_s))
+ * print("static const u64 table_ladder[] = {")
+ * p = ec.lift_x(9)
+ * for i in range(252):
+ * 	l = (p[0] + p[2]) / (p[0] - p[2])
+ * 	print(("\t%s" + ("," if i != 251 else "")) % limbs(l))
+ * 	p = p * 2
+ * print("};")
+ *
+ */
 
-	memzero_explicit(&m, sizeof(m));
-}
+static const u64 p_minus_s[] = { 0x816b1e0137d48290ULL, 0x440f6a51eb4d1207ULL, 0x52385f46dca2b71dULL, 0x215132111d8354cbULL };
+
+static const u64 table_ladder[] = {
+	0xfffffffffffffff3ULL, 0xffffffffffffffffULL, 0xffffffffffffffffULL, 0x5fffffffffffffffULL,
+	0x6b8220f416aafe96ULL, 0x82ebeb2b4f566a34ULL, 0xd5a9a5b075a5950fULL, 0x5142b2cf4b2488f4ULL,
+	0x6aaebc750069680cULL, 0x89cf7820a0f99c41ULL, 0x2a58d9183b56d0f4ULL, 0x4b5aca80e36011a4ULL,
+	0x329132348c29745dULL, 0xf4a2e616e1642fd7ULL, 0x1e45bb03ff67bc34ULL, 0x306912d0f42a9b4aULL,
+	0xff886507e6af7154ULL, 0x04f50e13dfeec82fULL, 0xaa512fe82abab5ceULL, 0x174e251a68d5f222ULL,
+	0xcf96700d82028898ULL, 0x1743e3370a2c02c5ULL, 0x379eec98b4e86eaaULL, 0x0c59888a51e0482eULL,
+	0xfbcbf1d699b5d189ULL, 0xacaef0d58e9fdc84ULL, 0xc1c20d06231f7614ULL, 0x2938218da274f972ULL,
+	0xf6af49beff1d7f18ULL, 0xcc541c22387ac9c2ULL, 0x96fcc9ef4015c56bULL, 0x69c1627c690913a9ULL,
+	0x7a86fd2f4733db0eULL, 0xfdb8c4f29e087de9ULL, 0x095e4b1a8ea2a229ULL, 0x1ad7a7c829b37a79ULL,
+	0x342d89cad17ea0c0ULL, 0x67bedda6cced2051ULL, 0x19ca31bf2bb42f74ULL, 0x3df7b4c84980acbbULL,
+	0xa8c6444dc80ad883ULL, 0xb91e440366e3ab85ULL, 0xc215cda00164f6d8ULL, 0x3d867c6ef247e668ULL,
+	0xc7dd582bcc3e658cULL, 0xfd2c4748ee0e5528ULL, 0xa0fd9b95cc9f4f71ULL, 0x7529d871b0675ddfULL,
+	0xb8f568b42d3cbd78ULL, 0x1233011b91f3da82ULL, 0x2dce6ccd4a7c3b62ULL, 0x75e7fc8e9e498603ULL,
+	0x2f4f13f1fcd0b6ecULL, 0xf1a8ca1f29ff7a45ULL, 0xc249c1a72981e29bULL, 0x6ebe0dbb8c83b56aULL,
+	0x7114fa8d170bb222ULL, 0x65a2dcd5bf93935fULL, 0xbdc41f68b59c979aULL, 0x2f0eef79a2ce9289ULL,
+	0x42ecbf0c083c37ceULL, 0x2930bc09ec496322ULL, 0xf294b0c19cfeac0dULL, 0x3780aa4bedfabb80ULL,
+	0x56c17d3e7cead929ULL, 0xe7cb4beb2e5722c5ULL, 0x0ce931732dbfe15aULL, 0x41b883c7621052f8ULL,
+	0xdbf75ca0c3d25350ULL, 0x2936be086eb1e351ULL, 0xc936e03cb4a9b212ULL, 0x1d45bf82322225aaULL,
+	0xe81ab1036a024cc5ULL, 0xe212201c304c9a72ULL, 0xc5d73fba6832b1fcULL, 0x20ffdb5a4d839581ULL,
+	0xa283d367be5d0fadULL, 0x6c2b25ca8b164475ULL, 0x9d4935467caaf22eULL, 0x5166408eee85ff49ULL,
+	0x3c67baa2fab4e361ULL, 0xb3e433c67ef35cefULL, 0x5259729241159b1cULL, 0x6a621892d5b0ab33ULL,
+	0x20b74a387555cdcbULL, 0x532aa10e1208923fULL, 0xeaa17b7762281dd1ULL, 0x61ab3443f05c44bfULL,
+	0x257a6c422324def8ULL, 0x131c6c1017e3cf7fULL, 0x23758739f630a257ULL, 0x295a407a01a78580ULL,
+	0xf8c443246d5da8d9ULL, 0x19d775450c52fa5dULL, 0x2afcfc92731bf83dULL, 0x7d10c8e81b2b4700ULL,
+	0xc8e0271f70baa20bULL, 0x993748867ca63957ULL, 0x5412efb3cb7ed4bbULL, 0x3196d36173e62975ULL,
+	0xde5bcad141c7dffcULL, 0x47cc8cd2b395c848ULL, 0xa34cd942e11af3cbULL, 0x0256dbf2d04ecec2ULL,
+	0x875ab7e94b0e667fULL, 0xcad4dd83c0850d10ULL, 0x47f12e8f4e72c79fULL, 0x5f1a87bb8c85b19bULL,
+	0x7ae9d0b6437f51b8ULL, 0x12c7ce5518879065ULL, 0x2ade09fe5cf77aeeULL, 0x23a05a2f7d2c5627ULL,
+	0x5908e128f17c169aULL, 0xf77498dd8ad0852dULL, 0x74b4c4ceab102f64ULL, 0x183abadd10139845ULL,
+	0xb165ba8daa92aaacULL, 0xd5c5ef9599386705ULL, 0xbe2f8f0cf8fc40d1ULL, 0x2701e635ee204514ULL,
+	0x629fa80020156514ULL, 0xf223868764a8c1ceULL, 0x5b894fff0b3f060eULL, 0x60d9944cf708a3faULL,
+	0xaeea001a1c7a201fULL, 0xebf16a633ee2ce63ULL, 0x6f7709594c7a07e1ULL, 0x79b958150d0208cbULL,
+	0x24b55e5301d410e7ULL, 0xe3a34edff3fdc84dULL, 0xd88768e4904032d8ULL, 0x131384427b3aaeecULL,
+	0x8405e51286234f14ULL, 0x14dc4739adb4c529ULL, 0xb8a2b5b250634ffdULL, 0x2fe2a94ad8a7ff93ULL,
+	0xec5c57efe843faddULL, 0x2843ce40f0bb9918ULL, 0xa4b561d6cf3d6305ULL, 0x743629bde8fb777eULL,
+	0x343edd46bbaf738fULL, 0xed981828b101a651ULL, 0xa401760b882c797aULL, 0x1fc223e28dc88730ULL,
+	0x48604e91fc0fba0eULL, 0xb637f78f052c6fa4ULL, 0x91ccac3d09e9239cULL, 0x23f7eed4437a687cULL,
+	0x5173b1118d9bd800ULL, 0x29d641b63189d4a7ULL, 0xfdbf177988bbc586ULL, 0x2959894fcad81df5ULL,
+	0xaebc8ef3b4bbc899ULL, 0x4148995ab26992b9ULL, 0x24e20b0134f92cfbULL, 0x40d158894a05dee8ULL,
+	0x46b00b1185af76f6ULL, 0x26bac77873187a79ULL, 0x3dc0bf95ab8fff5fULL, 0x2a608bd8945524d7ULL,
+	0x26449588bd446302ULL, 0x7c4bc21c0388439cULL, 0x8e98a4f383bd11b2ULL, 0x26218d7bc9d876b9ULL,
+	0xe3081542997c178aULL, 0x3c2d29a86fb6606fULL, 0x5c217736fa279374ULL, 0x7dde05734afeb1faULL,
+	0x3bf10e3906d42babULL, 0xe4f7803e1980649cULL, 0xe6053bf89595bf7aULL, 0x394faf38da245530ULL,
+	0x7a8efb58896928f4ULL, 0xfbc778e9cc6a113cULL, 0x72670ce330af596fULL, 0x48f222a81d3d6cf7ULL,
+	0xf01fce410d72caa7ULL, 0x5a20ecc7213b5595ULL, 0x7bc21165c1fa1483ULL, 0x07f89ae31da8a741ULL,
+	0x05d2c2b4c6830ff9ULL, 0xd43e330fc6316293ULL, 0xa5a5590a96d3a904ULL, 0x705edb91a65333b6ULL,
+	0x048ee15e0bb9a5f7ULL, 0x3240cfca9e0aaf5dULL, 0x8f4b71ceedc4a40bULL, 0x621c0da3de544a6dULL,
+	0x92872836a08c4091ULL, 0xce8375b010c91445ULL, 0x8a72eb524f276394ULL, 0x2667fcfa7ec83635ULL,
+	0x7f4c173345e8752aULL, 0x061b47feee7079a5ULL, 0x25dd9afa9f86ff34ULL, 0x3780cef5425dc89cULL,
+	0x1a46035a513bb4e9ULL, 0x3e1ef379ac575adaULL, 0xc78c5f1c5fa24b50ULL, 0x321a967634fd9f22ULL,
+	0x946707b8826e27faULL, 0x3dca84d64c506fd0ULL, 0xc189218075e91436ULL, 0x6d9284169b3b8484ULL,
+	0x3a67e840383f2ddfULL, 0x33eec9a30c4f9b75ULL, 0x3ec7c86fa783ef47ULL, 0x26ec449fbac9fbc4ULL,
+	0x5c0f38cba09b9e7dULL, 0x81168cc762a3478cULL, 0x3e23b0d306fc121cULL, 0x5a238aa0a5efdcddULL,
+	0x1ba26121c4ea43ffULL, 0x36f8c77f7c8832b5ULL, 0x88fbea0b0adcf99aULL, 0x5ca9938ec25bebf9ULL,
+	0xd5436a5e51fccda0ULL, 0x1dbc4797c2cd893bULL, 0x19346a65d3224a08ULL, 0x0f5034e49b9af466ULL,
+	0xf23c3967a1e0b96eULL, 0xe58b08fa867a4d88ULL, 0xfb2fabc6a7341679ULL, 0x2a75381eb6026946ULL,
+	0xc80a3be4c19420acULL, 0x66b1f6c681f2b6dcULL, 0x7cf7036761e93388ULL, 0x25abbbd8a660a4c4ULL,
+	0x91ea12ba14fd5198ULL, 0x684950fc4a3cffa9ULL, 0xf826842130f5ad28ULL, 0x3ea988f75301a441ULL,
+	0xc978109a695f8c6fULL, 0x1746eb4a0530c3f3ULL, 0x444d6d77b4459995ULL, 0x75952b8c054e5cc7ULL,
+	0xa3703f7915f4d6aaULL, 0x66c346202f2647d8ULL, 0xd01469df811d644bULL, 0x77fea47d81a5d71fULL,
+	0xc5e9529ef57ca381ULL, 0x6eeeb4b9ce2f881aULL, 0xb6e91a28e8009bd6ULL, 0x4b80be3e9afc3fecULL,
+	0x7e3773c526aed2c5ULL, 0x1b4afcb453c9a49dULL, 0xa920bdd7baffb24dULL, 0x7c54699f122d400eULL,
+	0xef46c8e14fa94bc8ULL, 0xe0b074ce2952ed5eULL, 0xbea450e1dbd885d5ULL, 0x61b68649320f712cULL,
+	0x8a485f7309ccbdd1ULL, 0xbd06320d7d4d1a2dULL, 0x25232973322dbef4ULL, 0x445dc4758c17f770ULL,
+	0xdb0434177cc8933cULL, 0xed6fe82175ea059fULL, 0x1efebefdc053db34ULL, 0x4adbe867c65daf99ULL,
+	0x3acd71a2a90609dfULL, 0xe5e991856dd04050ULL, 0x1ec69b688157c23cULL, 0x697427f6885cfe4dULL,
+	0xd7be7b9b65e1a851ULL, 0xa03d28d522c536ddULL, 0x28399d658fd2b645ULL, 0x49e5b7e17c2641e1ULL,
+	0x6f8c3a98700457a4ULL, 0x5078f0a25ebb6778ULL, 0xd13c3ccbc382960fULL, 0x2e003258a7df84b1ULL,
+	0x8ad1f39be6296a1cULL, 0xc1eeaa652a5fbfb2ULL, 0x33ee0673fd26f3cbULL, 0x59256173a69d2cccULL,
+	0x41ea07aa4e18fc41ULL, 0xd9fc19527c87a51eULL, 0xbdaacb805831ca6fULL, 0x445b652dc916694fULL,
+	0xce92a3a7f2172315ULL, 0x1edc282de11b9964ULL, 0xa1823aafe04c314aULL, 0x790a2d94437cf586ULL,
+	0x71c447fb93f6e009ULL, 0x8922a56722845276ULL, 0xbf70903b204f5169ULL, 0x2f7a89891ba319feULL,
+	0x02a08eb577e2140cULL, 0xed9a4ed4427bdcf4ULL, 0x5253ec44e4323cd1ULL, 0x3e88363c14e9355bULL,
+	0xaa66c14277110b8cULL, 0x1ae0391610a23390ULL, 0x2030bd12c93fc2a2ULL, 0x3ee141579555c7abULL,
+	0x9214de3a6d6e7d41ULL, 0x3ccdd88607f17efeULL, 0x674f1288f8e11217ULL, 0x5682250f329f93d0ULL,
+	0x6cf00b136d2e396eULL, 0x6e4cf86f1014debfULL, 0x5930b1b5bfcc4e83ULL, 0x047069b48aba16b6ULL,
+	0x0d4ce4ab69b20793ULL, 0xb24db91a97d0fb9eULL, 0xcdfa50f54e00d01dULL, 0x221b1085368bddb5ULL,
+	0xe7e59468b1e3d8d2ULL, 0x53c56563bd122f93ULL, 0xeee8a903e0663f09ULL, 0x61efa662cbbe3d42ULL,
+	0x2cf8ddddde6eab2aULL, 0x9bf80ad51435f231ULL, 0x5deadacec9f04973ULL, 0x29275b5d41d29b27ULL,
+	0xcfde0f0895ebf14fULL, 0xb9aab96b054905a7ULL, 0xcae80dd9a1c420fdULL, 0x0a63bf2f1673bbc7ULL,
+	0x092f6e11958fbc8cULL, 0x672a81e804822fadULL, 0xcac8351560d52517ULL, 0x6f3f7722c8f192f8ULL,
+	0xf8ba90ccc2e894b7ULL, 0x2c7557a438ff9f0dULL, 0x894d1d855ae52359ULL, 0x68e122157b743d69ULL,
+	0xd87e5570cfb919f3ULL, 0x3f2cdecd95798db9ULL, 0x2121154710c0a2ceULL, 0x3c66a115246dc5b2ULL,
+	0xcbedc562294ecb72ULL, 0xba7143c36a280b16ULL, 0x9610c2efd4078b67ULL, 0x6144735d946a4b1eULL,
+	0x536f111ed75b3350ULL, 0x0211db8c2041d81bULL, 0xf93cb1000e10413cULL, 0x149dfd3c039e8876ULL,
+	0xd479dde46b63155bULL, 0xb66e15e93c837976ULL, 0xdafde43b1f13e038ULL, 0x5fafda1a2e4b0b35ULL,
+	0x3600bbdf17197581ULL, 0x3972050bbe3cd2c2ULL, 0x5938906dbdd5be86ULL, 0x34fce5e43f9b860fULL,
+	0x75a8a4cd42d14d02ULL, 0x828dabc53441df65ULL, 0x33dcabedd2e131d3ULL, 0x3ebad76fb814d25fULL,
+	0xd4906f566f70e10fULL, 0x5d12f7aa51690f5aULL, 0x45adb16e76cefcf2ULL, 0x01f768aead232999ULL,
+	0x2b6cc77b6248febdULL, 0x3cd30628ec3aaffdULL, 0xce1c0b80d4ef486aULL, 0x4c3bff2ea6f66c23ULL,
+	0x3f2ec4094aeaeb5fULL, 0x61b19b286e372ca7ULL, 0x5eefa966de2a701dULL, 0x23b20565de55e3efULL,
+	0xe301ca5279d58557ULL, 0x07b2d4ce27c2874fULL, 0xa532cd8a9dcf1d67ULL, 0x2a52fee23f2bff56ULL,
+	0x8624efb37cd8663dULL, 0xbbc7ac20ffbd7594ULL, 0x57b85e9c82d37445ULL, 0x7b3052cb86a6ec66ULL,
+	0x3482f0ad2525e91eULL, 0x2cb68043d28edca0ULL, 0xaf4f6d052e1b003aULL, 0x185f8c2529781b0aULL,
+	0xaa41de5bd80ce0d6ULL, 0x9407b2416853e9d6ULL, 0x563ec36e357f4c3aULL, 0x4cc4b8dd0e297bceULL,
+	0xa2fc1a52ffb8730eULL, 0x1811f16e67058e37ULL, 0x10f9a366cddf4ee1ULL, 0x72f4a0c4a0b9f099ULL,
+	0x8c16c06f663f4ea7ULL, 0x693b3af74e970fbaULL, 0x2102e7f1d69ec345ULL, 0x0ba53cbc968a8089ULL,
+	0xca3d9dc7fea15537ULL, 0x4c6824bb51536493ULL, 0xb9886314844006b1ULL, 0x40d2a72ab454cc60ULL,
+	0x5936a1b712570975ULL, 0x91b9d648debda657ULL, 0x3344094bb64330eaULL, 0x006ba10d12ee51d0ULL,
+	0x19228468f5de5d58ULL, 0x0eb12f4c38cc05b0ULL, 0xa1039f9dd5601990ULL, 0x4502d4ce4fff0e0bULL,
+	0xeb2054106837c189ULL, 0xd0f6544c6dd3b93cULL, 0x40727064c416d74fULL, 0x6e15c6114b502ef0ULL,
+	0x4df2a398cfb1a76bULL, 0x11256c7419f2f6b1ULL, 0x4a497962066e6043ULL, 0x705b3aab41355b44ULL,
+	0x365ef536d797b1d8ULL, 0x00076bd622ddf0dbULL, 0x3bbf33b0e0575a88ULL, 0x3777aa05c8e4ca4dULL,
+	0x392745c85578db5fULL, 0x6fda4149dbae5ae2ULL, 0xb1f0b00b8adc9867ULL, 0x09963437d36f1da3ULL,
+	0x7e824e90a5dc3853ULL, 0xccb5f6641f135cbdULL, 0x6736d86c87ce8fccULL, 0x625f3ce26604249fULL,
+	0xaf8ac8059502f63fULL, 0x0c05e70a2e351469ULL, 0x35292e9c764b6305ULL, 0x1a394360c7e23ac3ULL,
+	0xd5c6d53251183264ULL, 0x62065abd43c2b74fULL, 0xb5fbf5d03b973f9bULL, 0x13a3da3661206e5eULL,
+	0xc6bd5837725d94e5ULL, 0x18e30912205016c5ULL, 0x2088ce1570033c68ULL, 0x7fba1f495c837987ULL,
+	0x5a8c7423f2f9079dULL, 0x1735157b34023fc5ULL, 0xe4f9b49ad2fab351ULL, 0x6691ff72c878e33cULL,
+	0x122c2adedc5eff3eULL, 0xf8dd4bf1d8956cf4ULL, 0xeb86205d9e9e5bdaULL, 0x049b92b9d975c743ULL,
+	0xa5379730b0f6c05aULL, 0x72a0ffacc6f3a553ULL, 0xb0032c34b20dcd6dULL, 0x470e9dbc88d5164aULL,
+	0xb19cf10ca237c047ULL, 0xb65466711f6c81a2ULL, 0xb3321bd16dd80b43ULL, 0x48c14f600c5fbe8eULL,
+	0x66451c264aa6c803ULL, 0xb66e3904a4fa7da6ULL, 0xd45f19b0b3128395ULL, 0x31602627c3c9bc10ULL,
+	0x3120dc4832e4e10dULL, 0xeb20c46756c717f7ULL, 0x00f52e3f67280294ULL, 0x566d4fc14730c509ULL,
+	0x7e3a5d40fd837206ULL, 0xc1e926dc7159547aULL, 0x216730fba68d6095ULL, 0x22e8c3843f69cea7ULL,
+	0x33d074e8930e4b2bULL, 0xb6e4350e84d15816ULL, 0x5534c26ad6ba2365ULL, 0x7773c12f89f1f3f3ULL,
+	0x8cba404da57962aaULL, 0x5b9897a81999ce56ULL, 0x508e862f121692fcULL, 0x3a81907fa093c291ULL,
+	0x0dded0ff4725a510ULL, 0x10d8cc10673fc503ULL, 0x5b9d151c9f1f4e89ULL, 0x32a5c1d5cb09a44cULL,
+	0x1e0aa442b90541fbULL, 0x5f85eb7cc1b485dbULL, 0xbee595ce8a9df2e5ULL, 0x25e496c722422236ULL,
+	0x5edf3c46cd0fe5b9ULL, 0x34e75a7ed2a43388ULL, 0xe488de11d761e352ULL, 0x0e878a01a085545cULL,
+	0xba493c77e021bb04ULL, 0x2b4d1843c7df899aULL, 0x9ea37a487ae80d67ULL, 0x67a9958011e41794ULL,
+	0x4b58051a6697b065ULL, 0x47e33f7d8d6ba6d4ULL, 0xbb4da8d483ca46c1ULL, 0x68becaa181c2db0dULL,
+	0x8d8980e90b989aa5ULL, 0xf95eb14a2c93c99bULL, 0x51c6c7c4796e73a2ULL, 0x6e228363b5efb569ULL,
+	0xc6bbc0b02dd624c8ULL, 0x777eb47dec8170eeULL, 0x3cde15a004cfafa9ULL, 0x1dc6bc087160bf9bULL,
+	0x2e07e043eec34002ULL, 0x18e9fc677a68dc7fULL, 0xd8da03188bd15b9aULL, 0x48fbc3bb00568253ULL,
+	0x57547d4cfb654ce1ULL, 0xd3565b82a058e2adULL, 0xf63eaf0bbf154478ULL, 0x47531ef114dfbb18ULL,
+	0xe1ec630a4278c587ULL, 0x5507d546ca8e83f3ULL, 0x85e135c63adc0c2bULL, 0x0aa7efa85682844eULL,
+	0x72691ba8b3e1f615ULL, 0x32b4e9701fbe3ffaULL, 0x97b6d92e39bb7868ULL, 0x2cfe53dea02e39e8ULL,
+	0x687392cd85cd52b0ULL, 0x27ff66c910e29831ULL, 0x97134556a9832d06ULL, 0x269bb0360a84f8a0ULL,
+	0x706e55457643f85cULL, 0x3734a48c9b597d1bULL, 0x7aee91e8c6efa472ULL, 0x5cd6abc198a9d9e0ULL,
+	0x0e04de06cb3ce41aULL, 0xd8c6eb893402e138ULL, 0x904659bb686e3772ULL, 0x7215c371746ba8c8ULL,
+	0xfd12a97eeae4a2d9ULL, 0x9514b7516394f2c5ULL, 0x266fd5809208f294ULL, 0x5c847085619a26b9ULL,
+	0x52985410fed694eaULL, 0x3c905b934a2ed254ULL, 0x10bb47692d3be467ULL, 0x063b3d2d69e5e9e1ULL,
+	0x472726eedda57debULL, 0xefb6c4ae10f41891ULL, 0x2b1641917b307614ULL, 0x117c554fc4f45b7cULL,
+	0xc07cf3118f9d8812ULL, 0x01dbd82050017939ULL, 0xd7e803f4171b2827ULL, 0x1015e87487d225eaULL,
+	0xc58de3fed23acc4dULL, 0x50db91c294a7be2dULL, 0x0b94d43d1c9cf457ULL, 0x6b1640fa6e37524aULL,
+	0x692f346c5fda0d09ULL, 0x200b1c59fa4d3151ULL, 0xb8c46f760777a296ULL, 0x4b38395f3ffdfbcfULL,
+	0x18d25e00be54d671ULL, 0x60d50582bec8aba6ULL, 0x87ad8f263b78b982ULL, 0x50fdf64e9cda0432ULL,
+	0x90f567aac578dcf0ULL, 0xef1e9b0ef2a3133bULL, 0x0eebba9242d9de71ULL, 0x15473c9bf03101c7ULL,
+	0x7c77e8ae56b78095ULL, 0xb678e7666e6f078eULL, 0x2da0b9615348ba1fULL, 0x7cf931c1ff733f0bULL,
+	0x26b357f50a0a366cULL, 0xe9708cf42b87d732ULL, 0xc13aeea5f91cb2c0ULL, 0x35d90c991143bb4cULL,
+	0x47c1c404a9a0d9dcULL, 0x659e58451972d251ULL, 0x3875a8c473b38c31ULL, 0x1fbd9ed379561f24ULL,
+	0x11fabc6fd41ec28dULL, 0x7ef8dfe3cd2a2dcaULL, 0x72e73b5d8c404595ULL, 0x6135fa4954b72f27ULL,
+	0xccfc32a2de24b69cULL, 0x3f55698c1f095d88ULL, 0xbe3350ed5ac3f929ULL, 0x5e9bf806ca477eebULL,
+	0xe9ce8fb63c309f68ULL, 0x5376f63565e1f9f4ULL, 0xd1afcfb35a6393f1ULL, 0x6632a1ede5623506ULL,
+	0x0b7d6c390c2ded4cULL, 0x56cb3281df04cb1fULL, 0x66305a1249ecc3c7ULL, 0x5d588b60a38ca72aULL,
+	0xa6ecbf78e8e5f42dULL, 0x86eeb44b3c8a3eecULL, 0xec219c48fbd21604ULL, 0x1aaf1af517c36731ULL,
+	0xc306a2836769bde7ULL, 0x208280622b1e2adbULL, 0x8027f51ffbff94a6ULL, 0x76cfa1ce1124f26bULL,
+	0x18eb00562422abb6ULL, 0xf377c4d58f8c29c3ULL, 0x4dbbc207f531561aULL, 0x0253b7f082128a27ULL,
+	0x3d1f091cb62c17e0ULL, 0x4860e1abd64628a9ULL, 0x52d17436309d4253ULL, 0x356f97e13efae576ULL,
+	0xd351e11aa150535bULL, 0x3e6b45bb1dd878ccULL, 0x0c776128bed92c98ULL, 0x1d34ae93032885b8ULL,
+	0x4ba0488ca85ba4c3ULL, 0x985348c33c9ce6ceULL, 0x66124c6f97bda770ULL, 0x0f81a0290654124aULL,
+	0x9ed09ca6569b86fdULL, 0x811009fd18af9a2dULL, 0xff08d03f93d8c20aULL, 0x52a148199faef26bULL,
+	0x3e03f9dc2d8d1b73ULL, 0x4205801873961a70ULL, 0xc0d987f041a35970ULL, 0x07aa1f15a1c0d549ULL,
+	0xdfd46ce08cd27224ULL, 0x6d0a024f934e4239ULL, 0x808a7a6399897b59ULL, 0x0a4556e9e13d95a2ULL,
+	0xd21a991fe9c13045ULL, 0x9b0e8548fe7751b8ULL, 0x5da643cb4bf30035ULL, 0x77db28d63940f721ULL,
+	0xfc5eeb614adc9011ULL, 0x5229419ae8c411ebULL, 0x9ec3e7787d1dcf74ULL, 0x340d053e216e4cb5ULL,
+	0xcac7af39b48df2b4ULL, 0xc0faec2871a10a94ULL, 0x140a69245ca575edULL, 0x0cf1c37134273a4cULL,
+	0xc8ee306ac224b8a5ULL, 0x57eaee7ccb4930b0ULL, 0xa1e806bdaacbe74fULL, 0x7d9a62742eeb657dULL,
+	0x9eb6b6ef546c4830ULL, 0x885cca1fddb36e2eULL, 0xe6b9f383ef0d7105ULL, 0x58654fef9d2e0412ULL,
+	0xa905c4ffbe0e8e26ULL, 0x942de5df9b31816eULL, 0x497d723f802e88e1ULL, 0x30684dea602f408dULL,
+	0x21e5a278a3e6cb34ULL, 0xaefb6e6f5b151dc4ULL, 0xb30b8e049d77ca15ULL, 0x28c3c9cf53b98981ULL,
+	0x287fb721556cdd2aULL, 0x0d317ca897022274ULL, 0x7468c7423a543258ULL, 0x4a7f11464eb5642fULL,
+	0xa237a4774d193aa6ULL, 0xd865986ea92129a1ULL, 0x24c515ecf87c1a88ULL, 0x604003575f39f5ebULL,
+	0x47b9f189570a9b27ULL, 0x2b98cede465e4b78ULL, 0x026df551dbb85c20ULL, 0x74fcd91047e21901ULL,
+	0x13e2a90a23c1bfa3ULL, 0x0cb0074e478519f6ULL, 0x5ff1cbbe3af6cf44ULL, 0x67fe5438be812dbeULL,
+	0xd13cf64fa40f05b0ULL, 0x054dfb2f32283787ULL, 0x4173915b7f0d2aeaULL, 0x482f144f1f610d4eULL,
+	0xf6210201b47f8234ULL, 0x5d0ae1929e70b990ULL, 0xdcd7f455b049567cULL, 0x7e93d0f1f0916f01ULL,
+	0xdd79cbf18a7db4faULL, 0xbe8391bf6f74c62fULL, 0x027145d14b8291bdULL, 0x585a73ea2cbf1705ULL,
+	0x485ca03e928a0db2ULL, 0x10fc01a5742857e7ULL, 0x2f482edbd6d551a7ULL, 0x0f0433b5048fdb8aULL,
+	0x60da2e8dd7dc6247ULL, 0x88b4c9d38cd4819aULL, 0x13033ac001f66697ULL, 0x273b24fe3b367d75ULL,
+	0xc6e8f66a31b3b9d4ULL, 0x281514a494df49d5ULL, 0xd1726fdfc8b23da7ULL, 0x4b3ae7d103dee548ULL,
+	0xc6256e19ce4b9d7eULL, 0xff5c5cf186e3c61cULL, 0xacc63ca34b8ec145ULL, 0x74621888fee66574ULL,
+	0x956f409645290a1eULL, 0xef0bf8e3263a962eULL, 0xed6a50eb5ec2647bULL, 0x0694283a9dca7502ULL,
+	0x769b963643a2dcd1ULL, 0x42b7c8ea09fc5353ULL, 0x4f002aee13397eabULL, 0x63005e2c19b7d63aULL,
+	0xca6736da63023beaULL, 0x966c7f6db12a99b7ULL, 0xace09390c537c5e1ULL, 0x0b696063a1aa89eeULL,
+	0xebb03e97288c56e5ULL, 0x432a9f9f938c8be8ULL, 0xa6a5a93d5b717f71ULL, 0x1a5fb4c3e18f9d97ULL,
+	0x1c94e7ad1c60cdceULL, 0xee202a43fc02c4a0ULL, 0x8dafe4d867c46a20ULL, 0x0a10263c8ac27b58ULL,
+	0xd0dea9dfe4432a4aULL, 0x856af87bbe9277c5ULL, 0xce8472acc212c71aULL, 0x6f151b6d9bbb1e91ULL,
+	0x26776c527ceed56aULL, 0x7d211cb7fbf8faecULL, 0x37ae66a6fd4609ccULL, 0x1f81b702d2770c42ULL,
+	0x2fb0b057eac58392ULL, 0xe1dd89fe29744e9dULL, 0xc964f8eb17beb4f8ULL, 0x29571073c9a2d41eULL,
+	0xa948a18981c0e254ULL, 0x2df6369b65b22830ULL, 0xa33eb2d75fcfd3c6ULL, 0x078cd6ec4199a01fULL,
+	0x4a584a41ad900d2fULL, 0x32142b78e2c74c52ULL, 0x68c4e8338431c978ULL, 0x7f69ea9008689fc2ULL,
+	0x52f2c81e46a38265ULL, 0xfd78072d04a832fdULL, 0x8cd7d5fa25359e94ULL, 0x4de71b7454cc29d2ULL,
+	0x42eb60ad1eda6ac9ULL, 0x0aad37dfdbc09c3aULL, 0x81004b71e33cc191ULL, 0x44e6be345122803cULL,
+	0x03fe8388ba1920dbULL, 0xf5d57c32150db008ULL, 0x49c8c4281af60c29ULL, 0x21edb518de701aeeULL,
+	0x7fb63e418f06dc99ULL, 0xa4460d99c166d7b8ULL, 0x24dd5248ce520a83ULL, 0x5ec3ad712b928358ULL,
+	0x15022a5fbd17930fULL, 0xa4f64a77d82570e3ULL, 0x12bc8d6915783712ULL, 0x498194c0fc620abbULL,
+	0x38a2d9d255686c82ULL, 0x785c6bd9193e21f0ULL, 0xe4d5c81ab24a5484ULL, 0x56307860b2e20989ULL,
+	0x429d55f78b4d74c4ULL, 0x22f1834643350131ULL, 0x1e60c24598c71fffULL, 0x59f2f014979983efULL,
+	0x46a47d56eb494a44ULL, 0x3e22a854d636a18eULL, 0xb346e15274491c3bULL, 0x2ceafd4e5390cde7ULL,
+	0xba8a8538be0d6675ULL, 0x4b9074bb50818e23ULL, 0xcbdab89085d304c3ULL, 0x61a24fe0e56192c4ULL,
+	0xcb7615e6db525bcbULL, 0xdd7d8c35a567e4caULL, 0xe6b4153acafcdd69ULL, 0x2d668e097f3c9766ULL,
+	0xa57e7e265ce55ef0ULL, 0x5d9f4e527cd4b967ULL, 0xfbc83606492fd1e5ULL, 0x090d52beb7c3f7aeULL,
+	0x09b9515a1e7b4d7cULL, 0x1f266a2599da44c0ULL, 0xa1c49548e2c55504ULL, 0x7ef04287126f15ccULL,
+	0xfed1659dbd30ef15ULL, 0x8b4ab9eec4e0277bULL, 0x884d6236a5df3291ULL, 0x1fd96ea6bf5cf788ULL,
+	0x42a161981f190d9aULL, 0x61d849507e6052c1ULL, 0x9fe113bf285a2cd5ULL, 0x7c22d676dbad85d8ULL,
+	0x82e770ed2bfbd27dULL, 0x4c05b2ece996f5a5ULL, 0xcd40a9c2b0900150ULL, 0x5895319213d9bf64ULL,
+	0xe7cc5d703fea2e08ULL, 0xb50c491258e2188cULL, 0xcce30baa48205bf0ULL, 0x537c659ccfa32d62ULL,
+	0x37b6623a98cfc088ULL, 0xfe9bed1fa4d6aca4ULL, 0x04d29b8e56a8d1b0ULL, 0x725f71c40b519575ULL,
+	0x28c7f89cd0339ce6ULL, 0x8367b14469ddc18bULL, 0x883ada83a6a1652cULL, 0x585f1974034d6c17ULL,
+	0x89cfb266f1b19188ULL, 0xe63b4863e7c35217ULL, 0xd88c9da6b4c0526aULL, 0x3e035c9df0954635ULL,
+	0xdd9d5412fb45de9dULL, 0xdd684532e4cff40dULL, 0x4b5c999b151d671cULL, 0x2d8c2cc811e7f690ULL,
+	0x7f54be1d90055d40ULL, 0xa464c5df464aaf40ULL, 0x33979624f0e917beULL, 0x2c018dc527356b30ULL,
+	0xa5415024e330b3d4ULL, 0x73ff3d96691652d3ULL, 0x94ec42c4ef9b59f1ULL, 0x0747201618d08e5aULL,
+	0x4d6ca48aca411c53ULL, 0x66415f2fcfa66119ULL, 0x9c4dd40051e227ffULL, 0x59810bc09a02f7ebULL,
+	0x2a7eb171b3dc101dULL, 0x441c5ab99ffef68eULL, 0x32025c9b93b359eaULL, 0x5e8ce0a71e9d112fULL,
+	0xbfcccb92429503fdULL, 0xd271ba752f095d55ULL, 0x345ead5e972d091eULL, 0x18c8df11a83103baULL,
+	0x90cd949a9aed0f4cULL, 0xc5d1f4cb6660e37eULL, 0xb8cac52d56c52e0bULL, 0x6e42e400c5808e0dULL,
+	0xa3b46966eeaefd23ULL, 0x0c4f1f0be39ecdcaULL, 0x189dc8c9d683a51dULL, 0x51f27f054c09351bULL,
+	0x4c487ccd2a320682ULL, 0x587ea95bb3df1c96ULL, 0xc8ccf79e555cb8e8ULL, 0x547dc829a206d73dULL,
+	0xb822a6cd80c39b06ULL, 0xe96d54732000d4c6ULL, 0x28535b6f91463b4dULL, 0x228f4660e2486e1dULL,
+	0x98799538de8d3abfULL, 0x8cd8330045ebca6eULL, 0x79952a008221e738ULL, 0x4322e1a7535cd2bbULL,
+	0xb114c11819d1801cULL, 0x2016e4d84f3f5ec7ULL, 0xdd0e2df409260f4cULL, 0x5ec362c0ae5f7266ULL,
+	0xc0462b18b8b2b4eeULL, 0x7cc8d950274d1afbULL, 0xf25f7105436b02d2ULL, 0x43bbf8dcbff9ccd3ULL,
+	0xb6ad1767a039e9dfULL, 0xb0714da8f69d3583ULL, 0x5e55fa18b42931f5ULL, 0x4ed5558f33c60961ULL,
+	0x1fe37901c647a5ddULL, 0x593ddf1f8081d357ULL, 0x0249a4fd813fd7a6ULL, 0x69acca274e9caf61ULL,
+	0x047ba3ea330721c9ULL, 0x83423fc20e7e1ea0ULL, 0x1df4c0af01314a60ULL, 0x09a62dab89289527ULL,
+	0xa5b325a49cc6cb00ULL, 0xe94b5dc654b56cb6ULL, 0x3be28779adc994a0ULL, 0x4296e8f8ba3a4aadULL,
+	0x328689761e451eabULL, 0x2e4d598bff59594aULL, 0x49b96853d7a7084aULL, 0x4980a319601420a8ULL,
+	0x9565b9e12f552c42ULL, 0x8a5318db7100fe96ULL, 0x05c90b4d43add0d7ULL, 0x538b4cd66a5d4edaULL,
+	0xf4e94fc3e89f039fULL, 0x592c9af26f618045ULL, 0x08a36eb5fd4b9550ULL, 0x25fffaf6c2ed1419ULL,
+	0x34434459cc79d354ULL, 0xeeecbfb4b1d5476bULL, 0xddeb34a061615d99ULL, 0x5129cecceb64b773ULL,
+	0xee43215894993520ULL, 0x772f9c7cf14c0b3bULL, 0xd2e2fce306bedad5ULL, 0x715f42b546f06a97ULL,
+	0x434ecdceda5b5f1aULL, 0x0da17115a49741a9ULL, 0x680bd77c73edad2eULL, 0x487c02354edd9041ULL,
+	0xb8efeff3a70ed9c4ULL, 0x56a32aa3e857e302ULL, 0xdf3a68bd48a2a5a0ULL, 0x07f650b73176c444ULL,
+	0xe38b9b1626e0ccb1ULL, 0x79e053c18b09fb36ULL, 0x56d90319c9f94964ULL, 0x1ca941e7ac9ff5c4ULL,
+	0x49c4df29162fa0bbULL, 0x8488cf3282b33305ULL, 0x95dfda14cabb437dULL, 0x3391f78264d5ad86ULL,
+	0x729ae06ae2b5095dULL, 0xd58a58d73259a946ULL, 0xe9834262d13921edULL, 0x27fedafaa54bb592ULL,
+	0xa99dc5b829ad48bbULL, 0x5f025742499ee260ULL, 0x802c8ecd5d7513fdULL, 0x78ceb3ef3f6dd938ULL,
+	0xc342f44f8a135d94ULL, 0x7b9edb44828cdda3ULL, 0x9436d11a0537cfe7ULL, 0x5064b164ec1ab4c8ULL,
+	0x7020eccfd37eb2fcULL, 0x1f31ea3ed90d25fcULL, 0x1b930d7bdfa1bb34ULL, 0x5344467a48113044ULL,
+	0x70073170f25e6dfbULL, 0xe385dc1a50114cc8ULL, 0x2348698ac8fc4f00ULL, 0x2a77a55284dd40d8ULL,
+	0xfe06afe0c98c6ce4ULL, 0xc235df96dddfd6e4ULL, 0x1428d01e33bf1ed3ULL, 0x785768ec9300bdafULL,
+	0x9702e57a91deb63bULL, 0x61bdb8bfe5ce8b80ULL, 0x645b426f3d1d58acULL, 0x4804a82227a557bcULL,
+	0x8e57048ab44d2601ULL, 0x68d6501a4b3a6935ULL, 0xc39c9ec3f9e1c293ULL, 0x4172f257d4de63e2ULL,
+	0xd368b450330c6401ULL, 0x040d3017418f2391ULL, 0x2c34bb6090b7d90dULL, 0x16f649228fdfd51fULL,
+	0xbea6818e2b928ef5ULL, 0xe28ccf91cdc11e72ULL, 0x594aaa68e77a36cdULL, 0x313034806c7ffd0fULL,
+	0x8a9d27ac2249bd65ULL, 0x19a3b464018e9512ULL, 0xc26ccff352b37ec7ULL, 0x056f68341d797b21ULL,
+	0x5e79d6757efd2327ULL, 0xfabdbcb6553afe15ULL, 0xd3e7222c6eaf5a60ULL, 0x7046c76d4dae743bULL,
+	0x660be872b18d4a55ULL, 0x19992518574e1496ULL, 0xc103053a302bdcbbULL, 0x3ed8e9800b218e8eULL,
+	0x7b0b9239fa75e03eULL, 0xefe9fb684633c083ULL, 0x98a35fbe391a7793ULL, 0x6065510fe2d0fe34ULL,
+	0x55cb668548abad0cULL, 0xb4584548da87e527ULL, 0x2c43ecea0107c1ddULL, 0x526028809372de35ULL,
+	0x3415c56af9213b1fULL, 0x5bee1a4d017e98dbULL, 0x13f6b105b5cf709bULL, 0x5ff20e3482b29ab6ULL,
+	0x0aa29c75cc2e6c90ULL, 0xfc7d73ca3a70e206ULL, 0x899fc38fc4b5c515ULL, 0x250386b124ffc207ULL,
+	0x54ea28d5ae3d2b56ULL, 0x9913149dd6de60ceULL, 0x16694fc58f06d6c1ULL, 0x46b23975eb018fc7ULL,
+	0x470a6a0fb4b7b4e2ULL, 0x5d92475a8f7253deULL, 0xabeee5b52fbd3adbULL, 0x7fa20801a0806968ULL,
+	0x76f3faf19f7714d2ULL, 0xb3e840c12f4660c3ULL, 0x0fb4cd8df212744eULL, 0x4b065a251d3a2dd2ULL,
+	0x5cebde383d77cd4aULL, 0x6adf39df882c9cb1ULL, 0xa2dd242eb09af759ULL, 0x3147c0e50e5f6422ULL,
+	0x164ca5101d1350dbULL, 0xf8d13479c33fc962ULL, 0xe640ce4d13e5da08ULL, 0x4bdee0c45061f8baULL,
+	0xd7c46dc1a4edb1c9ULL, 0x5514d7b6437fd98aULL, 0x58942f6bb2a1c00bULL, 0x2dffb2ab1d70710eULL,
+	0xccdfcf2fc18b6d68ULL, 0xa8ebcba8b7806167ULL, 0x980697f95e2937e3ULL, 0x02fbba1cd0126e8cULL
+};
 
-static void curve25519_bmi2_base(u8 session_key[CURVE25519_KEY_SIZE],
-				 const u8 private_key[CURVE25519_KEY_SIZE])
+static void curve25519_ever64_base(u8 *out, const u8 *priv)
 {
-	struct {
-		u64 buffer[4 * NUM_WORDS_ELTFP25519];
-		u64 coordinates[4 * NUM_WORDS_ELTFP25519];
-		u64 workspace[4 * NUM_WORDS_ELTFP25519];
-		u8 private[CURVE25519_KEY_SIZE];
-	} __aligned(32) m;
-
-	const int ite[4] = { 64, 64, 64, 63 };
-	const int q = 3;
 	u64 swap = 1;
-
-	int i = 0, j = 0, k = 0;
-	u64 *const key = (u64 *)m.private;
-	u64 *const Ur1 = m.coordinates + 0;
-	u64 *const Zr1 = m.coordinates + 4;
-	u64 *const Ur2 = m.coordinates + 8;
-	u64 *const Zr2 = m.coordinates + 12;
-
-	u64 *const UZr1 = m.coordinates + 0;
-	u64 *const ZUr2 = m.coordinates + 8;
-
-	u64 *const A = m.workspace + 0;
-	u64 *const B = m.workspace + 4;
-	u64 *const C = m.workspace + 8;
-	u64 *const D = m.workspace + 12;
-
-	u64 *const AB = m.workspace + 0;
-	u64 *const CD = m.workspace + 8;
-
-	const u64 *const P = table_ladder_8k;
-
-	memcpy(m.private, private_key, sizeof(m.private));
-
-	curve25519_clamp_secret(m.private);
-
-	setzero_eltfp25519_1w(Ur1);
-	setzero_eltfp25519_1w(Zr1);
-	setzero_eltfp25519_1w(Zr2);
-	Ur1[0] = 1;
-	Zr1[0] = 1;
-	Zr2[0] = 1;
-
-	/* G-S */
-	Ur2[3] = 0x1eaecdeee27cab34UL;
-	Ur2[2] = 0xadc7a0b9235d48e2UL;
-	Ur2[1] = 0xbbf095ae14b2edf8UL;
-	Ur2[0] = 0x7e94e1fec82faabdUL;
-
-	/* main-loop */
-	j = q;
-	for (i = 0; i < NUM_WORDS_ELTFP25519; ++i) {
-		while (j < ite[i]) {
-			u64 bit = (key[i] >> j) & 0x1;
-			k = (64 * i + j - q);
+	int i, j, k;
+	u64 tmp[16 + 32 + 4];
+	u64 *x1 = &tmp[0];
+	u64 *z1 = &tmp[4];
+	u64 *x2 = &tmp[8];
+	u64 *z2 = &tmp[12];
+	u64 *xz1 = &tmp[0];
+	u64 *xz2 = &tmp[8];
+	u64 *a = &tmp[0 + 16];
+	u64 *b = &tmp[4 + 16];
+	u64 *c = &tmp[8 + 16];
+	u64 *ab = &tmp[0 + 16];
+	u64 *abcd = &tmp[0 + 16];
+	u64 *ef = &tmp[16 + 16];
+	u64 *efgh = &tmp[16 + 16];
+	u64 *key = &tmp[0 + 16 + 32];
+
+	memcpy(key, priv, 32);
+	((u8 *)key)[0] &= 248;
+	((u8 *)key)[31] = (((u8 *)key)[31] & 127) | 64;
+
+	x1[0] = 1, x1[1] = x1[2] = x1[3] = 0;
+	z1[0] = 1, z1[1] = z1[2] = z1[3] = 0;
+	z2[0] = 1, z2[1] = z2[2] = z2[3] = 0;
+	memcpy(x2, p_minus_s, sizeof(p_minus_s));
+
+	j = 3;
+	for (i = 0; i < 4; ++i) {
+		while (j < (const int[]){ 64, 64, 64, 63 }[i]) {
+			u64 bit = (key[i] >> j) & 1;
+			k = (64 * i + j - 3);
 			swap = swap ^ bit;
-			cswap(swap, Ur1, Ur2);
-			cswap(swap, Zr1, Zr2);
+			cswap2(swap, xz1, xz2);
 			swap = bit;
-			/* Addition */
-			sub_eltfp25519_1w(B, Ur1, Zr1);		/* B = Ur1-Zr1 */
-			add_eltfp25519_1w_bmi2(A, Ur1, Zr1);	/* A = Ur1+Zr1 */
-			mul_eltfp25519_1w_bmi2(C, &P[4 * k], B);/* C = M0-B */
-			sub_eltfp25519_1w(B, A, C);		/* B = (Ur1+Zr1) - M*(Ur1-Zr1) */
-			add_eltfp25519_1w_bmi2(A, A, C);	/* A = (Ur1+Zr1) + M*(Ur1-Zr1) */
-			sqr_eltfp25519_2w_bmi2(AB);		/* A = A^2      |  B = B^2 */
-			mul_eltfp25519_2w_bmi2(UZr1, ZUr2, AB);	/* Ur1 = Zr2*A  |  Zr1 = Ur2*B */
+			fsub(b, x1, z1);
+			fadd(a, x1, z1);
+			fmul(c, &table_ladder[4 * k], b, ef);
+			fsub(b, a, c);
+			fadd(a, a, c);
+			fsqr2(ab, ab, efgh);
+			fmul2(xz1, xz2, ab, efgh);
 			++j;
 		}
 		j = 0;
 	}
 
-	/* Doubling */
-	for (i = 0; i < q; ++i) {
-		add_eltfp25519_1w_bmi2(A, Ur1, Zr1);	/*  A = Ur1+Zr1 */
-		sub_eltfp25519_1w(B, Ur1, Zr1);		/*  B = Ur1-Zr1 */
-		sqr_eltfp25519_2w_bmi2(AB);		/*  A = A**2     B = B**2 */
-		copy_eltfp25519_1w(C, B);		/*  C = B */
-		sub_eltfp25519_1w(B, A, B);		/*  B = A-B */
-		mul_a24_eltfp25519_1w(D, B);		/*  D = my_a24*B */
-		add_eltfp25519_1w_bmi2(D, D, C);	/*  D = D+C */
-		mul_eltfp25519_2w_bmi2(UZr1, AB, CD);	/*  Ur1 = A*B   Zr1 = Zr1*A */
-	}
+	point_double(xz1, abcd, efgh);
+	point_double(xz1, abcd, efgh);
+	point_double(xz1, abcd, efgh);
+	encode_point(out, xz1);
 
-	/* Convert to affine coordinates */
-	inv_eltfp25519_1w_bmi2(A, Zr1);
-	mul_eltfp25519_1w_bmi2((u64 *)session_key, Ur1, A);
-	fred_eltfp25519_1w((u64 *)session_key);
-
-	memzero_explicit(&m, sizeof(m));
+	memzero_explicit(tmp, sizeof(tmp));
 }
 
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(curve25519_use_bmi2_adx);
+
 void curve25519_arch(u8 mypublic[CURVE25519_KEY_SIZE],
 		     const u8 secret[CURVE25519_KEY_SIZE],
 		     const u8 basepoint[CURVE25519_KEY_SIZE])
 {
-	if (static_branch_likely(&curve25519_use_adx))
-		curve25519_adx(mypublic, secret, basepoint);
-	else if (static_branch_likely(&curve25519_use_bmi2))
-		curve25519_bmi2(mypublic, secret, basepoint);
+	if (static_branch_likely(&curve25519_use_bmi2_adx))
+		curve25519_ever64(mypublic, secret, basepoint);
 	else
 		curve25519_generic(mypublic, secret, basepoint);
 }
@@ -2355,10 +1395,8 @@ EXPORT_SYMBOL(curve25519_arch);
 void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
 			  const u8 secret[CURVE25519_KEY_SIZE])
 {
-	if (static_branch_likely(&curve25519_use_adx))
-		curve25519_adx_base(pub, secret);
-	else if (static_branch_likely(&curve25519_use_bmi2))
-		curve25519_bmi2_base(pub, secret);
+	if (static_branch_likely(&curve25519_use_bmi2_adx))
+		curve25519_ever64_base(pub, secret);
 	else
 		curve25519_generic(pub, secret, curve25519_base_point);
 }
@@ -2449,12 +1487,11 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
+
 static int __init curve25519_mod_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_BMI2))
-		static_branch_enable(&curve25519_use_bmi2);
-	else if (boot_cpu_has(X86_FEATURE_ADX))
-		static_branch_enable(&curve25519_use_adx);
+	if (boot_cpu_has(X86_FEATURE_BMI2) && boot_cpu_has(X86_FEATURE_ADX))
+		static_branch_enable(&curve25519_use_bmi2_adx);
 	else
 		return 0;
 	return IS_REACHABLE(CONFIG_CRYPTO_KPP) ?
@@ -2474,3 +1511,4 @@ module_exit(curve25519_mod_exit);
 MODULE_ALIAS_CRYPTO("curve25519");
 MODULE_ALIAS_CRYPTO("curve25519-x86");
 MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.24.1

