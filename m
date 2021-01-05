Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10312EB084
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jan 2021 17:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbhAEQuW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jan 2021 11:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbhAEQuS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAEA522D08;
        Tue,  5 Jan 2021 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609865353;
        bh=bMIOMOLbDLnSPoXGYkxPU0GuUV2bDg29aS76ANaEsXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ni6innpIrxZfvLSh26MHxDXrOO6Ub32iqL6rw5Q8PEKcSbGO4OiNvve1ZzS4+J46C
         8Np0zFb1ZrPT/TaTwOmssUxY/Gkxd3VrY104R6+ZBWhSpGSJi0BW4ax/s6jOfdsOMW
         c9lZa7PVfgHUobRwXRvLseN4DepvFq0YrEP786wDZqDVwUM6c+Qzos3HTUdI8Yo45E
         1SC3YykZM/jVHpwJmbjyr0LGc82OxLYartSX7YlqmMBWESvH72UMl5kpQ6b/QNidv0
         pj26pXA6259js9AEFbeMePWir9OYd007jMRw+FKgkwrJGcFLKDKR0AH/SL2wjTKRVd
         vJ1lqpkTJNIrQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v2 13/21] crypto: x86/blowfish - drop CTR mode implementation
Date:   Tue,  5 Jan 2021 17:48:01 +0100
Message-Id: <20210105164809.8594-14-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105164809.8594-1-ardb@kernel.org>
References: <20210105164809.8594-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Blowfish in counter mode is never used in the kernel, so there
is no point in keeping an accelerated implementation around.

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/blowfish_glue.c | 107 --------------------
 crypto/Kconfig                  |   1 +
 2 files changed, 1 insertion(+), 107 deletions(-)

diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index cedfdba69ce3..a880e0b1c255 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -6,8 +6,6 @@
  *
  * CBC & ECB parts based on code (crypto/cbc.c,ecb.c) by:
  *   Copyright (c) 2006 Herbert Xu <herbert@gondor.apana.org.au>
- * CTR part based on code (crypto/ctr.c) by:
- *   (C) Copyright IBM Corp. 2007 - Joy Latten <latten@us.ibm.com>
  */
 
 #include <crypto/algapi.h>
@@ -247,97 +245,6 @@ static int cbc_decrypt(struct skcipher_request *req)
 	return err;
 }
 
-static void ctr_crypt_final(struct bf_ctx *ctx, struct skcipher_walk *walk)
-{
-	u8 *ctrblk = walk->iv;
-	u8 keystream[BF_BLOCK_SIZE];
-	u8 *src = walk->src.virt.addr;
-	u8 *dst = walk->dst.virt.addr;
-	unsigned int nbytes = walk->nbytes;
-
-	blowfish_enc_blk(ctx, keystream, ctrblk);
-	crypto_xor_cpy(dst, keystream, src, nbytes);
-
-	crypto_inc(ctrblk, BF_BLOCK_SIZE);
-}
-
-static unsigned int __ctr_crypt(struct bf_ctx *ctx, struct skcipher_walk *walk)
-{
-	unsigned int bsize = BF_BLOCK_SIZE;
-	unsigned int nbytes = walk->nbytes;
-	u64 *src = (u64 *)walk->src.virt.addr;
-	u64 *dst = (u64 *)walk->dst.virt.addr;
-	u64 ctrblk = be64_to_cpu(*(__be64 *)walk->iv);
-	__be64 ctrblocks[4];
-
-	/* Process four block batch */
-	if (nbytes >= bsize * 4) {
-		do {
-			if (dst != src) {
-				dst[0] = src[0];
-				dst[1] = src[1];
-				dst[2] = src[2];
-				dst[3] = src[3];
-			}
-
-			/* create ctrblks for parallel encrypt */
-			ctrblocks[0] = cpu_to_be64(ctrblk++);
-			ctrblocks[1] = cpu_to_be64(ctrblk++);
-			ctrblocks[2] = cpu_to_be64(ctrblk++);
-			ctrblocks[3] = cpu_to_be64(ctrblk++);
-
-			blowfish_enc_blk_xor_4way(ctx, (u8 *)dst,
-						  (u8 *)ctrblocks);
-
-			src += 4;
-			dst += 4;
-		} while ((nbytes -= bsize * 4) >= bsize * 4);
-
-		if (nbytes < bsize)
-			goto done;
-	}
-
-	/* Handle leftovers */
-	do {
-		if (dst != src)
-			*dst = *src;
-
-		ctrblocks[0] = cpu_to_be64(ctrblk++);
-
-		blowfish_enc_blk_xor(ctx, (u8 *)dst, (u8 *)ctrblocks);
-
-		src += 1;
-		dst += 1;
-	} while ((nbytes -= bsize) >= bsize);
-
-done:
-	*(__be64 *)walk->iv = cpu_to_be64(ctrblk);
-	return nbytes;
-}
-
-static int ctr_crypt(struct skcipher_request *req)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct bf_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while ((nbytes = walk.nbytes) >= BF_BLOCK_SIZE) {
-		nbytes = __ctr_crypt(ctx, &walk);
-		err = skcipher_walk_done(&walk, nbytes);
-	}
-
-	if (nbytes) {
-		ctr_crypt_final(ctx, &walk);
-		err = skcipher_walk_done(&walk, 0);
-	}
-
-	return err;
-}
-
 static struct crypto_alg bf_cipher_alg = {
 	.cra_name		= "blowfish",
 	.cra_driver_name	= "blowfish-asm",
@@ -384,20 +291,6 @@ static struct skcipher_alg bf_skcipher_algs[] = {
 		.setkey			= blowfish_setkey_skcipher,
 		.encrypt		= cbc_encrypt,
 		.decrypt		= cbc_decrypt,
-	}, {
-		.base.cra_name		= "ctr(blowfish)",
-		.base.cra_driver_name	= "ctr-blowfish-asm",
-		.base.cra_priority	= 300,
-		.base.cra_blocksize	= 1,
-		.base.cra_ctxsize	= sizeof(struct bf_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.min_keysize		= BF_MIN_KEY_SIZE,
-		.max_keysize		= BF_MAX_KEY_SIZE,
-		.ivsize			= BF_BLOCK_SIZE,
-		.chunksize		= BF_BLOCK_SIZE,
-		.setkey			= blowfish_setkey_skcipher,
-		.encrypt		= ctr_crypt,
-		.decrypt		= ctr_crypt,
 	},
 };
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5e820a57d138..24c0e001d06d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1255,6 +1255,7 @@ config CRYPTO_BLOWFISH_X86_64
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
+	imply CRYPTO_CTR
 	help
 	  Blowfish cipher algorithm (x86_64), by Bruce Schneier.
 
-- 
2.17.1

