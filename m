Return-Path: <linux-crypto+bounces-11819-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE07A8B0EC
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA935A1070
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Apr 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A622B8C3;
	Wed, 16 Apr 2025 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="S2YYnObJ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFA22CBF7
	for <linux-crypto@vger.kernel.org>; Wed, 16 Apr 2025 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785874; cv=none; b=TE5NbMtTkg3DBslcjZFBEEAIgqYV85KmV9nPmsJBUrLmnnJnguvcUfXk9n/bIeZU1kulnGZr9r1SKzjpBWGY4YXWc6EbNdJzGOq+AmczY9nbOjaCjOsZ4vQlTJyzRy+o6rCjP1mxxopO4fQDwg7sAdBqaJPa8/rSOBsdPvi0gLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785874; c=relaxed/simple;
	bh=oCWIsU7it7RFCaB85UZtYguR/Qmiyl7CYoWLM6V2N0A=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=LmFKrbf/pW9l7BOnY5eHPasSeUytY3u8FjfLOh5PPtx2MDWjVCYfZTNwvPsZk5hKag0qIx7p6TmNXOdVfB5EQgbobUhGrbfHgXdiNnAzCT8dHdeVj2lqz9FAa8VCe7z7coN7cREa9rTBk9z3I19dU/WVrHM4K5Bsz3J5smgE6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=S2YYnObJ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d4Huz3C69B7cDotE3V00uqfYDPm3xqAct2NTblL48lQ=; b=S2YYnObJns1tF6VYIWfkEsWZFh
	SeVlclYpkN3XQg1ZZzPpvmK2YzNdZwiVPRiSLKhBbiDfWannfH55vTO/kfN52aNb8bkzJ/wINl9lk
	hIs6yAtUlLQXnELbkSpeL3CXlh9sXqZsJu+dmcL7cJSaQZV7u+EbPOW8tCRzyH6yh0ASnAtIOAfC2
	P0/xsC11cXBh41vQf6+WwJx9Agc0TZc9NhpFMdlwuG26Gv/jXjmyvz4OAD1HW9usLLPBclLr7K3AN
	zshBJUunwODVlTb5uR+/1bYwAlYpTkKUJiSmZjLL0bOK9xVE+hSJkTFAX7NGJXL5YDPlEgOviO26X
	mXSA6sgQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u4wVY-00G6PV-3C;
	Wed, 16 Apr 2025 14:44:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Apr 2025 14:44:28 +0800
Date: Wed, 16 Apr 2025 14:44:28 +0800
Message-Id: <95e06d5e7d8139a2e8dc89bb6c7ad0eb4112ad43.1744784515.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744784515.git.herbert@gondor.apana.org.au>
References: <cover.1744784515.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 46/67] crypto: riscv/sha512 - Use API partial block handling
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the Crypto API partial block handling.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/riscv/crypto/sha512-riscv64-glue.c | 47 ++++++++++---------------
 crypto/sha512_generic.c                 |  5 +--
 include/crypto/sha512_base.h            |  6 ++++
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/crypto/sha512-riscv64-glue.c b/arch/riscv/crypto/sha512-riscv64-glue.c
index 43b56a08aeb5..4634fca78ae2 100644
--- a/arch/riscv/crypto/sha512-riscv64-glue.c
+++ b/arch/riscv/crypto/sha512-riscv64-glue.c
@@ -14,7 +14,7 @@
 #include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
 #include <crypto/sha512_base.h>
-#include <linux/linkage.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 
 /*
@@ -24,8 +24,8 @@
 asmlinkage void sha512_transform_zvknhb_zvkb(
 	struct sha512_state *state, const u8 *data, int num_blocks);
 
-static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
-				 unsigned int len)
+static void sha512_block(struct sha512_state *state, const u8 *data,
+			 int num_blocks)
 {
 	/*
 	 * Ensure struct sha512_state begins directly with the SHA-512
@@ -35,35 +35,24 @@ static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
 
 	if (crypto_simd_usable()) {
 		kernel_vector_begin();
-		sha512_base_do_update(desc, data, len,
-				      sha512_transform_zvknhb_zvkb);
+		sha512_transform_zvknhb_zvkb(state, data, num_blocks);
 		kernel_vector_end();
 	} else {
-		crypto_sha512_update(desc, data, len);
+		sha512_generic_block_fn(state, data, num_blocks);
 	}
-	return 0;
+}
+
+static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	return sha512_base_do_update_blocks(desc, data, len, sha512_block);
 }
 
 static int riscv64_sha512_finup(struct shash_desc *desc, const u8 *data,
 				unsigned int len, u8 *out)
 {
-	if (crypto_simd_usable()) {
-		kernel_vector_begin();
-		if (len)
-			sha512_base_do_update(desc, data, len,
-					      sha512_transform_zvknhb_zvkb);
-		sha512_base_do_finalize(desc, sha512_transform_zvknhb_zvkb);
-		kernel_vector_end();
-
-		return sha512_base_finish(desc, out);
-	}
-
-	return crypto_sha512_finup(desc, data, len, out);
-}
-
-static int riscv64_sha512_final(struct shash_desc *desc, u8 *out)
-{
-	return riscv64_sha512_finup(desc, NULL, 0, out);
+	sha512_base_do_finup(desc, data, len, sha512_block);
+	return sha512_base_finish(desc, out);
 }
 
 static int riscv64_sha512_digest(struct shash_desc *desc, const u8 *data,
@@ -77,14 +66,15 @@ static struct shash_alg riscv64_sha512_algs[] = {
 	{
 		.init = sha512_base_init,
 		.update = riscv64_sha512_update,
-		.final = riscv64_sha512_final,
 		.finup = riscv64_sha512_finup,
 		.digest = riscv64_sha512_digest,
-		.descsize = sizeof(struct sha512_state),
+		.descsize = SHA512_STATE_SIZE,
 		.digestsize = SHA512_DIGEST_SIZE,
 		.base = {
 			.cra_blocksize = SHA512_BLOCK_SIZE,
 			.cra_priority = 300,
+			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
+				     CRYPTO_AHASH_ALG_FINUP_MAX,
 			.cra_name = "sha512",
 			.cra_driver_name = "sha512-riscv64-zvknhb-zvkb",
 			.cra_module = THIS_MODULE,
@@ -92,13 +82,14 @@ static struct shash_alg riscv64_sha512_algs[] = {
 	}, {
 		.init = sha384_base_init,
 		.update = riscv64_sha512_update,
-		.final = riscv64_sha512_final,
 		.finup = riscv64_sha512_finup,
-		.descsize = sizeof(struct sha512_state),
+		.descsize = SHA512_STATE_SIZE,
 		.digestsize = SHA384_DIGEST_SIZE,
 		.base = {
 			.cra_blocksize = SHA384_BLOCK_SIZE,
 			.cra_priority = 300,
+			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
+				     CRYPTO_AHASH_ALG_FINUP_MAX,
 			.cra_name = "sha384",
 			.cra_driver_name = "sha384-riscv64-zvknhb-zvkb",
 			.cra_module = THIS_MODULE,
diff --git a/crypto/sha512_generic.c b/crypto/sha512_generic.c
index ed81813bd420..27a7346ff143 100644
--- a/crypto/sha512_generic.c
+++ b/crypto/sha512_generic.c
@@ -145,14 +145,15 @@ sha512_transform(u64 *state, const u8 *input)
 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
 }
 
-static void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
-				    int blocks)
+void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
+			     int blocks)
 {
 	while (blocks--) {
 		sha512_transform(sst->state, src);
 		src += SHA512_BLOCK_SIZE;
 	}
 }
+EXPORT_SYMBOL_GPL(sha512_generic_block_fn);
 
 int crypto_sha512_update(struct shash_desc *desc, const u8 *data,
 			unsigned int len)
diff --git a/include/crypto/sha512_base.h b/include/crypto/sha512_base.h
index 8cb172e52dc0..e9f302ec3ede 100644
--- a/include/crypto/sha512_base.h
+++ b/include/crypto/sha512_base.h
@@ -10,7 +10,10 @@
 
 #include <crypto/internal/hash.h>
 #include <crypto/sha2.h>
+#include <linux/compiler.h>
+#include <linux/math.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 typedef void (sha512_block_fn)(struct sha512_state *sst, u8 const *src,
@@ -175,4 +178,7 @@ static inline int sha512_base_finish(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
+void sha512_generic_block_fn(struct sha512_state *sst, u8 const *src,
+			     int blocks);
+
 #endif /* _CRYPTO_SHA512_BASE_H */
-- 
2.39.5


