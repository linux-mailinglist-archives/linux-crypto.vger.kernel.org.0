Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761B02BA268
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 07:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKTGl3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:41:29 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34084 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgKTGl3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:41:29 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg06o-00077d-NY; Fri, 20 Nov 2020 17:41:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:41:26 +1100
Date:   Fri, 20 Nov 2020 17:41:26 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: sparc - Fix sparse endianness warnings
Message-ID: <20201120064126.GA28499@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a coulpe of sparse endianness warnings.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/sparc/crypto/crc32c_glue.c b/arch/sparc/crypto/crc32c_glue.c
index 4e9323229e71..82efb7f81c28 100644
--- a/arch/sparc/crypto/crc32c_glue.c
+++ b/arch/sparc/crypto/crc32c_glue.c
@@ -35,7 +35,7 @@ static int crc32c_sparc64_setkey(struct crypto_shash *hash, const u8 *key,
 
 	if (keylen != sizeof(u32))
 		return -EINVAL;
-	*(__le32 *)mctx = le32_to_cpup((__le32 *)key);
+	*mctx = le32_to_cpup((__le32 *)key);
 	return 0;
 }
 
diff --git a/arch/sparc/crypto/md5_glue.c b/arch/sparc/crypto/md5_glue.c
index 111283fe837e..511db98d590a 100644
--- a/arch/sparc/crypto/md5_glue.c
+++ b/arch/sparc/crypto/md5_glue.c
@@ -33,10 +33,11 @@ static int md5_sparc64_init(struct shash_desc *desc)
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
+	le32_to_cpu_array(mctx->hash, 4);
 	mctx->byte_count = 0;
 
 	return 0;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
