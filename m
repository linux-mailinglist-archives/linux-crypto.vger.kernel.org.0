Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D118258046
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF0K17 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:27:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfF0K16 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:27:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so1906689wrl.9
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYfyuXtkWyqjgUR6IexmK+iDcDL5/HP/psv9afBMZ2s=;
        b=rNl2+eFQjBju+QmDCensdOowWubE0/reIt2FWtNLy0+zlTyARcan1bd52vmwU2P0a5
         23LUwYqd11eDXZ9RmAKdvMxzHRsq3s+11iN8nu5qbMyL7T5rzwclSSJf/k7J5VNqFaci
         WS31RiXxUchxmH00q3FZVpY3CY2ceQa8Z6qc+RW+4LPjyipVFlIaNWYMmaHD7c8GWDDg
         0H2SmXga1lCKWTF2Pzz8EUeu7IR5arIok/7Qb3IDZVNi2LKrzC6AE7XEWJ/DDHLc+T25
         u1lbb8mqz7BTp88lAN+MeMm8JvxemuqX0xGfw1SZchFk3e0gKlYgRujiGntRLITGgl+R
         FxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYfyuXtkWyqjgUR6IexmK+iDcDL5/HP/psv9afBMZ2s=;
        b=WYl0KQjeNTuenk3POtqffmFuLN/DtDqoOSNWNy4FGqSykbzoUSLnck+90iClA6YKvB
         5lpXnNBOILlmDC3y+kh4ASeHNFer1iHJ3pU29p4uSMqSsnM0ua/GgKcMikUNb6dFO8cn
         g+SfnE1UgdJ/if7zwkdhgDMb5w3+sYHwPfWozSC3tDqqt7PEb92k2ZQOuUm/oUbvRwBc
         +xpRznSoi90XMEVp3hMzCyVsYKxH9EpTCzR7UZ4YdFkHYCE8ZlmkuvtXJbxekf4gDhDW
         pYKtmURM7Az2ajevRE1PufR9bAtDckx1TUDzu//c3Z9jcrpbUdaG9ZeqH13wlt8Bcpxm
         SEOg==
X-Gm-Message-State: APjAAAUobErQ91dIEZ+TF+1S+7/h9H5hO8GR43ybgm4RVbLZS417mBXE
        CxcMCfnP68KB51qJTU4H1ZJBogKd2Gc=
X-Google-Smtp-Source: APXvYqzlcR3yDJ2Lf3CwxaG/6rU6s8uUFnhPRu2KcpAyLqBPD0dTu95x825vNmfcaqSq96zziB6hoA==
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr2792693wrx.187.1561631274382;
        Thu, 27 Jun 2019 03:27:54 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.27.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:27:53 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 04/32] crypto: aes - create AES library based on the fixed time AES code
Date:   Thu, 27 Jun 2019 12:26:19 +0200
Message-Id: <20190627102647.2992-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Take the existing small footprint and mostly time invariant C code
and turn it into a AES library that can be used for non-performance
critical, casual use of AES, and as a fallback for, e.g., SIMD code
that needs a secondary path that can be taken in contexts where the
SIMD unit is off limits (e.g., in hard interrupts taken from kernel
context)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/Kconfig       |   4 +
 crypto/aes_ti.c      | 307 +----------------
 include/crypto/aes.h |  34 ++
 lib/crypto/Makefile  |   3 +
 lib/crypto/aes.c     | 350 ++++++++++++++++++++
 5 files changed, 395 insertions(+), 303 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e801450bcb1c..091ebbbc9655 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1066,6 +1066,9 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 
 comment "Ciphers"
 
+config CRYPTO_LIB_AES
+	tristate
+
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
 	select CRYPTO_ALGAPI
@@ -1089,6 +1092,7 @@ config CRYPTO_AES
 config CRYPTO_AES_TI
 	tristate "Fixed time AES cipher"
 	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
 	help
 	  This is a generic implementation of AES that attempts to eliminate
 	  data dependent latencies as much as possible without affecting
diff --git a/crypto/aes_ti.c b/crypto/aes_ti.c
index fd70dc322634..339915db9aeb 100644
--- a/crypto/aes_ti.c
+++ b/crypto/aes_ti.c
@@ -1,259 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Scalar fixed time AES core transform
  *
  * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <crypto/aes.h>
 #include <linux/crypto.h>
 #include <linux/module.h>
-#include <asm/unaligned.h>
-
-/*
- * Emit the sbox as volatile const to prevent the compiler from doing
- * constant folding on sbox references involving fixed indexes.
- */
-static volatile const u8 __cacheline_aligned __aesti_sbox[] = {
-	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
-	0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
-	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
-	0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
-	0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
-	0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
-	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
-	0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
-	0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
-	0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
-	0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
-	0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
-	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
-	0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
-	0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
-	0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
-	0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
-	0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
-	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
-	0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
-	0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
-	0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
-	0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
-	0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
-	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
-	0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
-	0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
-	0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
-	0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
-	0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
-	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
-	0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16,
-};
-
-static volatile const u8 __cacheline_aligned __aesti_inv_sbox[] = {
-	0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38,
-	0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
-	0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87,
-	0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
-	0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d,
-	0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
-	0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2,
-	0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
-	0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16,
-	0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
-	0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda,
-	0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
-	0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a,
-	0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
-	0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02,
-	0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
-	0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea,
-	0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
-	0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85,
-	0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
-	0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89,
-	0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
-	0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20,
-	0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
-	0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31,
-	0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
-	0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d,
-	0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
-	0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0,
-	0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
-	0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26,
-	0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d,
-};
-
-static u32 mul_by_x(u32 w)
-{
-	u32 x = w & 0x7f7f7f7f;
-	u32 y = w & 0x80808080;
-
-	/* multiply by polynomial 'x' (0b10) in GF(2^8) */
-	return (x << 1) ^ (y >> 7) * 0x1b;
-}
-
-static u32 mul_by_x2(u32 w)
-{
-	u32 x = w & 0x3f3f3f3f;
-	u32 y = w & 0x80808080;
-	u32 z = w & 0x40404040;
-
-	/* multiply by polynomial 'x^2' (0b100) in GF(2^8) */
-	return (x << 2) ^ (y >> 7) * 0x36 ^ (z >> 6) * 0x1b;
-}
-
-static u32 mix_columns(u32 x)
-{
-	/*
-	 * Perform the following matrix multiplication in GF(2^8)
-	 *
-	 * | 0x2 0x3 0x1 0x1 |   | x[0] |
-	 * | 0x1 0x2 0x3 0x1 |   | x[1] |
-	 * | 0x1 0x1 0x2 0x3 | x | x[2] |
-	 * | 0x3 0x1 0x1 0x2 |   | x[3] |
-	 */
-	u32 y = mul_by_x(x) ^ ror32(x, 16);
-
-	return y ^ ror32(x ^ y, 8);
-}
-
-static u32 inv_mix_columns(u32 x)
-{
-	/*
-	 * Perform the following matrix multiplication in GF(2^8)
-	 *
-	 * | 0xe 0xb 0xd 0x9 |   | x[0] |
-	 * | 0x9 0xe 0xb 0xd |   | x[1] |
-	 * | 0xd 0x9 0xe 0xb | x | x[2] |
-	 * | 0xb 0xd 0x9 0xe |   | x[3] |
-	 *
-	 * which can conveniently be reduced to
-	 *
-	 * | 0x2 0x3 0x1 0x1 |   | 0x5 0x0 0x4 0x0 |   | x[0] |
-	 * | 0x1 0x2 0x3 0x1 |   | 0x0 0x5 0x0 0x4 |   | x[1] |
-	 * | 0x1 0x1 0x2 0x3 | x | 0x4 0x0 0x5 0x0 | x | x[2] |
-	 * | 0x3 0x1 0x1 0x2 |   | 0x0 0x4 0x0 0x5 |   | x[3] |
-	 */
-	u32 y = mul_by_x2(x);
-
-	return mix_columns(x ^ y ^ ror32(y, 16));
-}
-
-static __always_inline u32 subshift(u32 in[], int pos)
-{
-	return (__aesti_sbox[in[pos] & 0xff]) ^
-	       (__aesti_sbox[(in[(pos + 1) % 4] >>  8) & 0xff] <<  8) ^
-	       (__aesti_sbox[(in[(pos + 2) % 4] >> 16) & 0xff] << 16) ^
-	       (__aesti_sbox[(in[(pos + 3) % 4] >> 24) & 0xff] << 24);
-}
-
-static __always_inline u32 inv_subshift(u32 in[], int pos)
-{
-	return (__aesti_inv_sbox[in[pos] & 0xff]) ^
-	       (__aesti_inv_sbox[(in[(pos + 3) % 4] >>  8) & 0xff] <<  8) ^
-	       (__aesti_inv_sbox[(in[(pos + 2) % 4] >> 16) & 0xff] << 16) ^
-	       (__aesti_inv_sbox[(in[(pos + 1) % 4] >> 24) & 0xff] << 24);
-}
-
-static u32 subw(u32 in)
-{
-	return (__aesti_sbox[in & 0xff]) ^
-	       (__aesti_sbox[(in >>  8) & 0xff] <<  8) ^
-	       (__aesti_sbox[(in >> 16) & 0xff] << 16) ^
-	       (__aesti_sbox[(in >> 24) & 0xff] << 24);
-}
-
-static int aesti_expand_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
-			    unsigned int key_len)
-{
-	u32 kwords = key_len / sizeof(u32);
-	u32 rc, i, j;
-
-	if (key_len != AES_KEYSIZE_128 &&
-	    key_len != AES_KEYSIZE_192 &&
-	    key_len != AES_KEYSIZE_256)
-		return -EINVAL;
-
-	ctx->key_length = key_len;
-
-	for (i = 0; i < kwords; i++)
-		ctx->key_enc[i] = get_unaligned_le32(in_key + i * sizeof(u32));
-
-	for (i = 0, rc = 1; i < 10; i++, rc = mul_by_x(rc)) {
-		u32 *rki = ctx->key_enc + (i * kwords);
-		u32 *rko = rki + kwords;
-
-		rko[0] = ror32(subw(rki[kwords - 1]), 8) ^ rc ^ rki[0];
-		rko[1] = rko[0] ^ rki[1];
-		rko[2] = rko[1] ^ rki[2];
-		rko[3] = rko[2] ^ rki[3];
-
-		if (key_len == 24) {
-			if (i >= 7)
-				break;
-			rko[4] = rko[3] ^ rki[4];
-			rko[5] = rko[4] ^ rki[5];
-		} else if (key_len == 32) {
-			if (i >= 6)
-				break;
-			rko[4] = subw(rko[3]) ^ rki[4];
-			rko[5] = rko[4] ^ rki[5];
-			rko[6] = rko[5] ^ rki[6];
-			rko[7] = rko[6] ^ rki[7];
-		}
-	}
-
-	/*
-	 * Generate the decryption keys for the Equivalent Inverse Cipher.
-	 * This involves reversing the order of the round keys, and applying
-	 * the Inverse Mix Columns transformation to all but the first and
-	 * the last one.
-	 */
-	ctx->key_dec[0] = ctx->key_enc[key_len + 24];
-	ctx->key_dec[1] = ctx->key_enc[key_len + 25];
-	ctx->key_dec[2] = ctx->key_enc[key_len + 26];
-	ctx->key_dec[3] = ctx->key_enc[key_len + 27];
-
-	for (i = 4, j = key_len + 20; j > 0; i += 4, j -= 4) {
-		ctx->key_dec[i]     = inv_mix_columns(ctx->key_enc[j]);
-		ctx->key_dec[i + 1] = inv_mix_columns(ctx->key_enc[j + 1]);
-		ctx->key_dec[i + 2] = inv_mix_columns(ctx->key_enc[j + 2]);
-		ctx->key_dec[i + 3] = inv_mix_columns(ctx->key_enc[j + 3]);
-	}
 
-	ctx->key_dec[i]     = ctx->key_enc[0];
-	ctx->key_dec[i + 1] = ctx->key_enc[1];
-	ctx->key_dec[i + 2] = ctx->key_enc[2];
-	ctx->key_dec[i + 3] = ctx->key_enc[3];
-
-	return 0;
-}
 
 static int aesti_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 			 unsigned int key_len)
 {
 	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	return aesti_expand_key(ctx, in_key, key_len);
+	return aes_expandkey(ctx, in_key, key_len);
 }
 
 static void aesti_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
-	const u32 *rkp = ctx->key_enc + 4;
-	int rounds = 6 + ctx->key_length / 4;
-	u32 st0[4], st1[4];
 	unsigned long flags;
-	int round;
-
-	st0[0] = ctx->key_enc[0] ^ get_unaligned_le32(in);
-	st0[1] = ctx->key_enc[1] ^ get_unaligned_le32(in + 4);
-	st0[2] = ctx->key_enc[2] ^ get_unaligned_le32(in + 8);
-	st0[3] = ctx->key_enc[3] ^ get_unaligned_le32(in + 12);
 
 	/*
 	 * Temporarily disable interrupts to avoid races where cachelines are
@@ -261,36 +29,7 @@ static void aesti_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	 */
 	local_irq_save(flags);
 
-	/*
-	 * Force the compiler to emit data independent Sbox references,
-	 * by xoring the input with Sbox values that are known to add up
-	 * to zero. This pulls the entire Sbox into the D-cache before any
-	 * data dependent lookups are done.
-	 */
-	st0[0] ^= __aesti_sbox[ 0] ^ __aesti_sbox[ 64] ^ __aesti_sbox[134] ^ __aesti_sbox[195];
-	st0[1] ^= __aesti_sbox[16] ^ __aesti_sbox[ 82] ^ __aesti_sbox[158] ^ __aesti_sbox[221];
-	st0[2] ^= __aesti_sbox[32] ^ __aesti_sbox[ 96] ^ __aesti_sbox[160] ^ __aesti_sbox[234];
-	st0[3] ^= __aesti_sbox[48] ^ __aesti_sbox[112] ^ __aesti_sbox[186] ^ __aesti_sbox[241];
-
-	for (round = 0;; round += 2, rkp += 8) {
-		st1[0] = mix_columns(subshift(st0, 0)) ^ rkp[0];
-		st1[1] = mix_columns(subshift(st0, 1)) ^ rkp[1];
-		st1[2] = mix_columns(subshift(st0, 2)) ^ rkp[2];
-		st1[3] = mix_columns(subshift(st0, 3)) ^ rkp[3];
-
-		if (round == rounds - 2)
-			break;
-
-		st0[0] = mix_columns(subshift(st1, 0)) ^ rkp[4];
-		st0[1] = mix_columns(subshift(st1, 1)) ^ rkp[5];
-		st0[2] = mix_columns(subshift(st1, 2)) ^ rkp[6];
-		st0[3] = mix_columns(subshift(st1, 3)) ^ rkp[7];
-	}
-
-	put_unaligned_le32(subshift(st1, 0) ^ rkp[4], out);
-	put_unaligned_le32(subshift(st1, 1) ^ rkp[5], out + 4);
-	put_unaligned_le32(subshift(st1, 2) ^ rkp[6], out + 8);
-	put_unaligned_le32(subshift(st1, 3) ^ rkp[7], out + 12);
+	aes_encrypt(ctx, out, in);
 
 	local_irq_restore(flags);
 }
@@ -298,16 +37,7 @@ static void aesti_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 static void aesti_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
-	const u32 *rkp = ctx->key_dec + 4;
-	int rounds = 6 + ctx->key_length / 4;
-	u32 st0[4], st1[4];
 	unsigned long flags;
-	int round;
-
-	st0[0] = ctx->key_dec[0] ^ get_unaligned_le32(in);
-	st0[1] = ctx->key_dec[1] ^ get_unaligned_le32(in + 4);
-	st0[2] = ctx->key_dec[2] ^ get_unaligned_le32(in + 8);
-	st0[3] = ctx->key_dec[3] ^ get_unaligned_le32(in + 12);
 
 	/*
 	 * Temporarily disable interrupts to avoid races where cachelines are
@@ -315,36 +45,7 @@ static void aesti_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 	 */
 	local_irq_save(flags);
 
-	/*
-	 * Force the compiler to emit data independent Sbox references,
-	 * by xoring the input with Sbox values that are known to add up
-	 * to zero. This pulls the entire Sbox into the D-cache before any
-	 * data dependent lookups are done.
-	 */
-	st0[0] ^= __aesti_inv_sbox[ 0] ^ __aesti_inv_sbox[ 64] ^ __aesti_inv_sbox[129] ^ __aesti_inv_sbox[200];
-	st0[1] ^= __aesti_inv_sbox[16] ^ __aesti_inv_sbox[ 83] ^ __aesti_inv_sbox[150] ^ __aesti_inv_sbox[212];
-	st0[2] ^= __aesti_inv_sbox[32] ^ __aesti_inv_sbox[ 96] ^ __aesti_inv_sbox[160] ^ __aesti_inv_sbox[236];
-	st0[3] ^= __aesti_inv_sbox[48] ^ __aesti_inv_sbox[112] ^ __aesti_inv_sbox[187] ^ __aesti_inv_sbox[247];
-
-	for (round = 0;; round += 2, rkp += 8) {
-		st1[0] = inv_mix_columns(inv_subshift(st0, 0)) ^ rkp[0];
-		st1[1] = inv_mix_columns(inv_subshift(st0, 1)) ^ rkp[1];
-		st1[2] = inv_mix_columns(inv_subshift(st0, 2)) ^ rkp[2];
-		st1[3] = inv_mix_columns(inv_subshift(st0, 3)) ^ rkp[3];
-
-		if (round == rounds - 2)
-			break;
-
-		st0[0] = inv_mix_columns(inv_subshift(st1, 0)) ^ rkp[4];
-		st0[1] = inv_mix_columns(inv_subshift(st1, 1)) ^ rkp[5];
-		st0[2] = inv_mix_columns(inv_subshift(st1, 2)) ^ rkp[6];
-		st0[3] = inv_mix_columns(inv_subshift(st1, 3)) ^ rkp[7];
-	}
-
-	put_unaligned_le32(inv_subshift(st1, 0) ^ rkp[4], out);
-	put_unaligned_le32(inv_subshift(st1, 1) ^ rkp[5], out + 4);
-	put_unaligned_le32(inv_subshift(st1, 2) ^ rkp[6], out + 8);
-	put_unaligned_le32(inv_subshift(st1, 3) ^ rkp[7], out + 12);
+	aes_decrypt(ctx, out, in);
 
 	local_irq_restore(flags);
 }
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 0fdb542c70cd..d0067fca0cd0 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -37,4 +37,38 @@ int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
 int crypto_aes_expand_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 		unsigned int key_len);
+
+/**
+ * aes_expandkey - Expands the AES key as described in FIPS-197
+ * @ctx:	The location where the computed key will be stored.
+ * @in_key:	The supplied key.
+ * @key_len:	The length of the supplied key.
+ *
+ * Returns 0 on success. The function fails only if an invalid key size (or
+ * pointer) is supplied.
+ * The expanded key size is 240 bytes (max of 14 rounds with a unique 16 bytes
+ * key schedule plus a 16 bytes key which is used before the first round).
+ * The decryption key is prepared for the "Equivalent Inverse Cipher" as
+ * described in FIPS-197. The first slot (16 bytes) of each key (enc or dec) is
+ * for the initial combination, the second slot for the first round and so on.
+ */
+int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
+		  unsigned int key_len);
+
+/**
+ * aes_encrypt - Encrypt a single AES block
+ * @ctx:	Context struct containing the key schedule
+ * @out:	Buffer to store the ciphertext
+ * @in:		Buffer containing the plaintext
+ */
+void aes_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
+
+/**
+ * aes_decrypt - Decrypt a single AES block
+ * @ctx:	Context struct containing the key schedule
+ * @out:	Buffer to store the plaintext
+ * @in:		Buffer containing the ciphertext
+ */
+void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
+
 #endif
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 88195c34932d..42a91c62d96d 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_CRYPTO_LIB_AES) += libaes.o
+libaes-y := aes.o
+
 obj-$(CONFIG_CRYPTO_LIB_ARC4) += libarc4.o
 libarc4-y := arc4.o
diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
new file mode 100644
index 000000000000..9928b23e0a8a
--- /dev/null
+++ b/lib/crypto/aes.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2019 Linaro Ltd <ard.biesheuvel@linaro.org>
+ */
+
+#include <crypto/aes.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <asm/unaligned.h>
+
+/*
+ * Emit the sbox as volatile const to prevent the compiler from doing
+ * constant folding on sbox references involving fixed indexes.
+ */
+static volatile const u8 __cacheline_aligned aes_sbox[] = {
+	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
+	0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
+	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+	0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
+	0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
+	0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
+	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
+	0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
+	0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+	0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
+	0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
+	0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
+	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
+	0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
+	0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+	0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
+	0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
+	0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
+	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
+	0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
+	0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+	0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
+	0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
+	0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
+	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
+	0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
+	0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+	0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
+	0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
+	0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
+	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
+	0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16,
+};
+
+static volatile const u8 __cacheline_aligned aes_inv_sbox[] = {
+	0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38,
+	0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
+	0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87,
+	0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
+	0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d,
+	0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
+	0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2,
+	0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
+	0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16,
+	0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
+	0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda,
+	0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
+	0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a,
+	0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
+	0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02,
+	0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
+	0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea,
+	0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
+	0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85,
+	0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
+	0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89,
+	0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
+	0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20,
+	0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
+	0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31,
+	0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
+	0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d,
+	0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
+	0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0,
+	0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
+	0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26,
+	0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d,
+};
+
+static u32 mul_by_x(u32 w)
+{
+	u32 x = w & 0x7f7f7f7f;
+	u32 y = w & 0x80808080;
+
+	/* multiply by polynomial 'x' (0b10) in GF(2^8) */
+	return (x << 1) ^ (y >> 7) * 0x1b;
+}
+
+static u32 mul_by_x2(u32 w)
+{
+	u32 x = w & 0x3f3f3f3f;
+	u32 y = w & 0x80808080;
+	u32 z = w & 0x40404040;
+
+	/* multiply by polynomial 'x^2' (0b100) in GF(2^8) */
+	return (x << 2) ^ (y >> 7) * 0x36 ^ (z >> 6) * 0x1b;
+}
+
+static u32 mix_columns(u32 x)
+{
+	/*
+	 * Perform the following matrix multiplication in GF(2^8)
+	 *
+	 * | 0x2 0x3 0x1 0x1 |   | x[0] |
+	 * | 0x1 0x2 0x3 0x1 |   | x[1] |
+	 * | 0x1 0x1 0x2 0x3 | x | x[2] |
+	 * | 0x3 0x1 0x1 0x2 |   | x[3] |
+	 */
+	u32 y = mul_by_x(x) ^ ror32(x, 16);
+
+	return y ^ ror32(x ^ y, 8);
+}
+
+static u32 inv_mix_columns(u32 x)
+{
+	/*
+	 * Perform the following matrix multiplication in GF(2^8)
+	 *
+	 * | 0xe 0xb 0xd 0x9 |   | x[0] |
+	 * | 0x9 0xe 0xb 0xd |   | x[1] |
+	 * | 0xd 0x9 0xe 0xb | x | x[2] |
+	 * | 0xb 0xd 0x9 0xe |   | x[3] |
+	 *
+	 * which can conveniently be reduced to
+	 *
+	 * | 0x2 0x3 0x1 0x1 |   | 0x5 0x0 0x4 0x0 |   | x[0] |
+	 * | 0x1 0x2 0x3 0x1 |   | 0x0 0x5 0x0 0x4 |   | x[1] |
+	 * | 0x1 0x1 0x2 0x3 | x | 0x4 0x0 0x5 0x0 | x | x[2] |
+	 * | 0x3 0x1 0x1 0x2 |   | 0x0 0x4 0x0 0x5 |   | x[3] |
+	 */
+	u32 y = mul_by_x2(x);
+
+	return mix_columns(x ^ y ^ ror32(y, 16));
+}
+
+static __always_inline u32 subshift(u32 in[], int pos)
+{
+	return (aes_sbox[in[pos] & 0xff]) ^
+	       (aes_sbox[(in[(pos + 1) % 4] >>  8) & 0xff] <<  8) ^
+	       (aes_sbox[(in[(pos + 2) % 4] >> 16) & 0xff] << 16) ^
+	       (aes_sbox[(in[(pos + 3) % 4] >> 24) & 0xff] << 24);
+}
+
+static __always_inline u32 inv_subshift(u32 in[], int pos)
+{
+	return (aes_inv_sbox[in[pos] & 0xff]) ^
+	       (aes_inv_sbox[(in[(pos + 3) % 4] >>  8) & 0xff] <<  8) ^
+	       (aes_inv_sbox[(in[(pos + 2) % 4] >> 16) & 0xff] << 16) ^
+	       (aes_inv_sbox[(in[(pos + 1) % 4] >> 24) & 0xff] << 24);
+}
+
+static u32 subw(u32 in)
+{
+	return (aes_sbox[in & 0xff]) ^
+	       (aes_sbox[(in >>  8) & 0xff] <<  8) ^
+	       (aes_sbox[(in >> 16) & 0xff] << 16) ^
+	       (aes_sbox[(in >> 24) & 0xff] << 24);
+}
+
+/**
+ * aes_expandkey - Expands the AES key as described in FIPS-197
+ * @ctx:	The location where the computed key will be stored.
+ * @in_key:	The supplied key.
+ * @key_len:	The length of the supplied key.
+ *
+ * Returns 0 on success. The function fails only if an invalid key size (or
+ * pointer) is supplied.
+ * The expanded key size is 240 bytes (max of 14 rounds with a unique 16 bytes
+ * key schedule plus a 16 bytes key which is used before the first round).
+ * The decryption key is prepared for the "Equivalent Inverse Cipher" as
+ * described in FIPS-197. The first slot (16 bytes) of each key (enc or dec) is
+ * for the initial combination, the second slot for the first round and so on.
+ */
+int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
+		  unsigned int key_len)
+{
+	u32 kwords = key_len / sizeof(u32);
+	u32 rc, i, j;
+
+	if (key_len != AES_KEYSIZE_128 &&
+	    key_len != AES_KEYSIZE_192 &&
+	    key_len != AES_KEYSIZE_256)
+		return -EINVAL;
+
+	ctx->key_length = key_len;
+
+	for (i = 0; i < kwords; i++)
+		ctx->key_enc[i] = get_unaligned_le32(in_key + i * sizeof(u32));
+
+	for (i = 0, rc = 1; i < 10; i++, rc = mul_by_x(rc)) {
+		u32 *rki = ctx->key_enc + (i * kwords);
+		u32 *rko = rki + kwords;
+
+		rko[0] = ror32(subw(rki[kwords - 1]), 8) ^ rc ^ rki[0];
+		rko[1] = rko[0] ^ rki[1];
+		rko[2] = rko[1] ^ rki[2];
+		rko[3] = rko[2] ^ rki[3];
+
+		if (key_len == AES_KEYSIZE_192) {
+			if (i >= 7)
+				break;
+			rko[4] = rko[3] ^ rki[4];
+			rko[5] = rko[4] ^ rki[5];
+		} else if (key_len == AES_KEYSIZE_256) {
+			if (i >= 6)
+				break;
+			rko[4] = subw(rko[3]) ^ rki[4];
+			rko[5] = rko[4] ^ rki[5];
+			rko[6] = rko[5] ^ rki[6];
+			rko[7] = rko[6] ^ rki[7];
+		}
+	}
+
+	/*
+	 * Generate the decryption keys for the Equivalent Inverse Cipher.
+	 * This involves reversing the order of the round keys, and applying
+	 * the Inverse Mix Columns transformation to all but the first and
+	 * the last one.
+	 */
+	ctx->key_dec[0] = ctx->key_enc[key_len + 24];
+	ctx->key_dec[1] = ctx->key_enc[key_len + 25];
+	ctx->key_dec[2] = ctx->key_enc[key_len + 26];
+	ctx->key_dec[3] = ctx->key_enc[key_len + 27];
+
+	for (i = 4, j = key_len + 20; j > 0; i += 4, j -= 4) {
+		ctx->key_dec[i]     = inv_mix_columns(ctx->key_enc[j]);
+		ctx->key_dec[i + 1] = inv_mix_columns(ctx->key_enc[j + 1]);
+		ctx->key_dec[i + 2] = inv_mix_columns(ctx->key_enc[j + 2]);
+		ctx->key_dec[i + 3] = inv_mix_columns(ctx->key_enc[j + 3]);
+	}
+
+	ctx->key_dec[i]     = ctx->key_enc[0];
+	ctx->key_dec[i + 1] = ctx->key_enc[1];
+	ctx->key_dec[i + 2] = ctx->key_enc[2];
+	ctx->key_dec[i + 3] = ctx->key_enc[3];
+
+	return 0;
+}
+EXPORT_SYMBOL(aes_expandkey);
+
+/**
+ * aes_encrypt - Encrypt a single AES block
+ * @ctx:	Context struct containing the key schedule
+ * @out:	Buffer to store the ciphertext
+ * @in:		Buffer containing the plaintext
+ */
+void aes_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in)
+{
+	const u32 *rkp = ctx->key_enc + 4;
+	int rounds = 6 + ctx->key_length / 4;
+	u32 st0[4], st1[4];
+	int round;
+
+	st0[0] = ctx->key_enc[0] ^ get_unaligned_le32(in);
+	st0[1] = ctx->key_enc[1] ^ get_unaligned_le32(in + 4);
+	st0[2] = ctx->key_enc[2] ^ get_unaligned_le32(in + 8);
+	st0[3] = ctx->key_enc[3] ^ get_unaligned_le32(in + 12);
+
+	/*
+	 * Force the compiler to emit data independent Sbox references,
+	 * by xoring the input with Sbox values that are known to add up
+	 * to zero. This pulls the entire Sbox into the D-cache before any
+	 * data dependent lookups are done.
+	 */
+	st0[0] ^= aes_sbox[ 0] ^ aes_sbox[ 64] ^ aes_sbox[134] ^ aes_sbox[195];
+	st0[1] ^= aes_sbox[16] ^ aes_sbox[ 82] ^ aes_sbox[158] ^ aes_sbox[221];
+	st0[2] ^= aes_sbox[32] ^ aes_sbox[ 96] ^ aes_sbox[160] ^ aes_sbox[234];
+	st0[3] ^= aes_sbox[48] ^ aes_sbox[112] ^ aes_sbox[186] ^ aes_sbox[241];
+
+	for (round = 0;; round += 2, rkp += 8) {
+		st1[0] = mix_columns(subshift(st0, 0)) ^ rkp[0];
+		st1[1] = mix_columns(subshift(st0, 1)) ^ rkp[1];
+		st1[2] = mix_columns(subshift(st0, 2)) ^ rkp[2];
+		st1[3] = mix_columns(subshift(st0, 3)) ^ rkp[3];
+
+		if (round == rounds - 2)
+			break;
+
+		st0[0] = mix_columns(subshift(st1, 0)) ^ rkp[4];
+		st0[1] = mix_columns(subshift(st1, 1)) ^ rkp[5];
+		st0[2] = mix_columns(subshift(st1, 2)) ^ rkp[6];
+		st0[3] = mix_columns(subshift(st1, 3)) ^ rkp[7];
+	}
+
+	put_unaligned_le32(subshift(st1, 0) ^ rkp[4], out);
+	put_unaligned_le32(subshift(st1, 1) ^ rkp[5], out + 4);
+	put_unaligned_le32(subshift(st1, 2) ^ rkp[6], out + 8);
+	put_unaligned_le32(subshift(st1, 3) ^ rkp[7], out + 12);
+}
+EXPORT_SYMBOL(aes_encrypt);
+
+/**
+ * aes_decrypt - Decrypt a single AES block
+ * @ctx:	Context struct containing the key schedule
+ * @out:	Buffer to store the plaintext
+ * @in:		Buffer containing the ciphertext
+ */
+void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in)
+{
+	const u32 *rkp = ctx->key_dec + 4;
+	int rounds = 6 + ctx->key_length / 4;
+	u32 st0[4], st1[4];
+	int round;
+
+	st0[0] = ctx->key_dec[0] ^ get_unaligned_le32(in);
+	st0[1] = ctx->key_dec[1] ^ get_unaligned_le32(in + 4);
+	st0[2] = ctx->key_dec[2] ^ get_unaligned_le32(in + 8);
+	st0[3] = ctx->key_dec[3] ^ get_unaligned_le32(in + 12);
+
+	/*
+	 * Force the compiler to emit data independent Sbox references,
+	 * by xoring the input with Sbox values that are known to add up
+	 * to zero. This pulls the entire Sbox into the D-cache before any
+	 * data dependent lookups are done.
+	 */
+	st0[0] ^= aes_inv_sbox[ 0] ^ aes_inv_sbox[ 64] ^ aes_inv_sbox[129] ^ aes_inv_sbox[200];
+	st0[1] ^= aes_inv_sbox[16] ^ aes_inv_sbox[ 83] ^ aes_inv_sbox[150] ^ aes_inv_sbox[212];
+	st0[2] ^= aes_inv_sbox[32] ^ aes_inv_sbox[ 96] ^ aes_inv_sbox[160] ^ aes_inv_sbox[236];
+	st0[3] ^= aes_inv_sbox[48] ^ aes_inv_sbox[112] ^ aes_inv_sbox[187] ^ aes_inv_sbox[247];
+
+	for (round = 0;; round += 2, rkp += 8) {
+		st1[0] = inv_mix_columns(inv_subshift(st0, 0)) ^ rkp[0];
+		st1[1] = inv_mix_columns(inv_subshift(st0, 1)) ^ rkp[1];
+		st1[2] = inv_mix_columns(inv_subshift(st0, 2)) ^ rkp[2];
+		st1[3] = inv_mix_columns(inv_subshift(st0, 3)) ^ rkp[3];
+
+		if (round == rounds - 2)
+			break;
+
+		st0[0] = inv_mix_columns(inv_subshift(st1, 0)) ^ rkp[4];
+		st0[1] = inv_mix_columns(inv_subshift(st1, 1)) ^ rkp[5];
+		st0[2] = inv_mix_columns(inv_subshift(st1, 2)) ^ rkp[6];
+		st0[3] = inv_mix_columns(inv_subshift(st1, 3)) ^ rkp[7];
+	}
+
+	put_unaligned_le32(inv_subshift(st1, 0) ^ rkp[4], out);
+	put_unaligned_le32(inv_subshift(st1, 1) ^ rkp[5], out + 4);
+	put_unaligned_le32(inv_subshift(st1, 2) ^ rkp[6], out + 8);
+	put_unaligned_le32(inv_subshift(st1, 3) ^ rkp[7], out + 12);
+}
+EXPORT_SYMBOL(aes_decrypt);
+
+MODULE_DESCRIPTION("Generic AES library");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

