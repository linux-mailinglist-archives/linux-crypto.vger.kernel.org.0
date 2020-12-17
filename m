Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAB2DDB45
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgLQWZl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 17:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgLQWZl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 17:25:41 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v2 02/11] crypto: blake2b - define shash_alg structs using macros
Date:   Thu, 17 Dec 2020 14:21:29 -0800
Message-Id: <20201217222138.170526-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217222138.170526-1-ebiggers@kernel.org>
References: <20201217222138.170526-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The shash_alg structs for the four variants of BLAKE2b are identical
except for the algorithm name, driver name, and digest size.  So, avoid
code duplication by using a macro to define these structs.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/blake2b_generic.c | 82 ++++++++++++----------------------------
 1 file changed, 25 insertions(+), 57 deletions(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 83942f511075e..0e38e3e48297c 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -236,64 +236,32 @@ static int blake2b_final(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
-static struct shash_alg blake2b_algs[] = {
-	{
-		.base.cra_name		= "blake2b-160",
-		.base.cra_driver_name	= "blake2b-160-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_160_HASH_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-256",
-		.base.cra_driver_name	= "blake2b-256-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_256_HASH_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-384",
-		.base.cra_driver_name	= "blake2b-384-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_384_HASH_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
-	}, {
-		.base.cra_name		= "blake2b-512",
-		.base.cra_driver_name	= "blake2b-512-generic",
-		.base.cra_priority	= 100,
-		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,
-		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx),
-		.base.cra_module	= THIS_MODULE,
-		.digestsize		= BLAKE2B_512_HASH_SIZE,
-		.setkey			= blake2b_setkey,
-		.init			= blake2b_init,
-		.update			= blake2b_update,
-		.final			= blake2b_final,
-		.descsize		= sizeof(struct blake2b_state),
+#define BLAKE2B_ALG(name, driver_name, digest_size)			\
+	{								\
+		.base.cra_name		= name,				\
+		.base.cra_driver_name	= driver_name,			\
+		.base.cra_priority	= 100,				\
+		.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,	\
+		.base.cra_blocksize	= BLAKE2B_BLOCK_SIZE,		\
+		.base.cra_ctxsize	= sizeof(struct blake2b_tfm_ctx), \
+		.base.cra_module	= THIS_MODULE,			\
+		.digestsize		= digest_size,			\
+		.setkey			= blake2b_setkey,		\
+		.init			= blake2b_init,			\
+		.update			= blake2b_update,		\
+		.final			= blake2b_final,		\
+		.descsize		= sizeof(struct blake2b_state),	\
 	}
+
+static struct shash_alg blake2b_algs[] = {
+	BLAKE2B_ALG("blake2b-160", "blake2b-160-generic",
+		    BLAKE2B_160_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-256", "blake2b-256-generic",
+		    BLAKE2B_256_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-384", "blake2b-384-generic",
+		    BLAKE2B_384_HASH_SIZE),
+	BLAKE2B_ALG("blake2b-512", "blake2b-512-generic",
+		    BLAKE2B_512_HASH_SIZE),
 };
 
 static int __init blake2b_mod_init(void)
-- 
2.29.2

