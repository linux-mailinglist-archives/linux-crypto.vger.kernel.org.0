Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A816A2BA21F
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 07:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgKTGBi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:01:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33856 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgKTGBi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:01:38 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kfzUB-0006UI-Ky; Fri, 20 Nov 2020 17:01:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:01:31 +1100
Date:   Fri, 20 Nov 2020 17:01:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] crypto: mips/octeon - Fix sparse endianness warnings
Message-ID: <20201120060131.GA27557@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a number of endianness warnings in the mips/octeon
code.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
index 7315cc307397..cb68f9e284bb 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.h
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -41,7 +41,7 @@ do {							\
  */
 #define read_octeon_64bit_hash_dword(index)		\
 ({							\
-	u64 __value;					\
+	__be64 __value;					\
 							\
 	__asm__ __volatile__ (				\
 	"dmfc2 %[rt],0x0048+" STR(index)		\
diff --git a/arch/mips/cavium-octeon/crypto/octeon-md5.c b/arch/mips/cavium-octeon/crypto/octeon-md5.c
index 8c8ea139653e..5ee4ade99b99 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-md5.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-md5.c
@@ -68,10 +68,11 @@ static int octeon_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *mctx = shash_desc_ctx(desc);
 
-	mctx->hash[0] = cpu_to_le32(MD5_H0);
-	mctx->hash[1] = cpu_to_le32(MD5_H1);
-	mctx->hash[2] = cpu_to_le32(MD5_H2);
-	mctx->hash[3] = cpu_to_le32(MD5_H3);
+	mctx->hash[0] = MD5_H0;
+	mctx->hash[1] = MD5_H1;
+	mctx->hash[2] = MD5_H2;
+	mctx->hash[3] = MD5_H3;
+	cpu_to_le32_array(mctx->hash, 4);
 	mctx->byte_count = 0;
 
 	return 0;
@@ -139,8 +140,9 @@ static int octeon_md5_final(struct shash_desc *desc, u8 *out)
 	}
 
 	memset(p, 0, padding);
-	mctx->block[14] = cpu_to_le32(mctx->byte_count << 3);
-	mctx->block[15] = cpu_to_le32(mctx->byte_count >> 29);
+	mctx->block[14] = mctx->byte_count << 3;
+	mctx->block[15] = mctx->byte_count >> 29;
+	cpu_to_le32_array(mctx->block + 14, 2);
 	octeon_md5_transform(mctx->block);
 
 	octeon_md5_read_hash(mctx);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
