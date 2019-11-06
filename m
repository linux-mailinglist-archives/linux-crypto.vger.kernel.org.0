Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D0F1797
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 14:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfKFNso (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Nov 2019 08:48:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:32850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfKFNso (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Nov 2019 08:48:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 814A8B38A;
        Wed,  6 Nov 2019 13:48:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 547FCDA79A; Wed,  6 Nov 2019 14:48:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ebiggers@kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] crypto: blake2b: merge blake2 init to api callback
Date:   Wed,  6 Nov 2019 14:48:26 +0100
Message-Id: <ec6fe616a871d03a9d7f8d4c4e6d9a5dbe4e7660.1573047517.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573047517.git.dsterba@suse.com>
References: <cover.1573047517.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The call chain from blake2b_init can be simplified because the param
block is effectively zeros, besides the key.

- blake2b_init0 zeroes state and sets IV
- blake2b_init sets up param block with defaults (key and some 1s)
- init with key, write it to the input buffer and recalculate state

So the compact way is to zero out the state and initialize index 0 of
the state directly with the non-zero values and the key.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 crypto/blake2b_generic.c | 103 ++++++++-------------------------------
 1 file changed, 19 insertions(+), 84 deletions(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 743905fabd65..d3da6113a96a 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -106,81 +106,6 @@ static void blake2b_increment_counter(struct blake2b_state *S, const u64 inc)
 	S->t[1] += (S->t[0] < inc);
 }
 
-static void blake2b_init0(struct blake2b_state *S)
-{
-	size_t i;
-
-	memset(S, 0, sizeof(struct blake2b_state));
-
-	for (i = 0; i < 8; ++i)
-		S->h[i] = blake2b_IV[i];
-}
-
-/* init xors IV with input parameter block */
-static void blake2b_init_param(struct blake2b_state *S,
-			       const struct blake2b_param *P)
-{
-	const u8 *p = (const u8 *)(P);
-	size_t i;
-
-	blake2b_init0(S);
-
-	/* IV XOR ParamBlock */
-	for (i = 0; i < 8; ++i)
-		S->h[i] ^= get_unaligned_le64(p + sizeof(S->h[i]) * i);
-
-	S->outlen = P->digest_length;
-}
-
-static void blake2b_init(struct blake2b_state *S, size_t outlen)
-{
-	struct blake2b_param P;
-
-	P.digest_length = (u8)outlen;
-	P.key_length    = 0;
-	P.fanout        = 1;
-	P.depth         = 1;
-	P.leaf_length   = 0;
-	P.node_offset   = 0;
-	P.xof_length    = 0;
-	P.node_depth    = 0;
-	P.inner_length  = 0;
-	memset(P.reserved, 0, sizeof(P.reserved));
-	memset(P.salt,     0, sizeof(P.salt));
-	memset(P.personal, 0, sizeof(P.personal));
-	blake2b_init_param(S, &P);
-}
-
-static void blake2b_init_key(struct blake2b_state *S, size_t outlen,
-			     const void *key, size_t keylen)
-{
-	struct blake2b_param P;
-
-	P.digest_length = (u8)outlen;
-	P.key_length    = (u8)keylen;
-	P.fanout        = 1;
-	P.depth         = 1;
-	P.leaf_length   = 0;
-	P.node_offset   = 0;
-	P.xof_length    = 0;
-	P.node_depth    = 0;
-	P.inner_length  = 0;
-	memset(P.reserved, 0, sizeof(P.reserved));
-	memset(P.salt,     0, sizeof(P.salt));
-	memset(P.personal, 0, sizeof(P.personal));
-
-	blake2b_init_param(S, &P);
-
-	{
-		u8 block[BLAKE2B_BLOCKBYTES];
-
-		memset(block, 0, BLAKE2B_BLOCKBYTES);
-		memcpy(block, key, keylen);
-		blake2b_update(S, block, BLAKE2B_BLOCKBYTES);
-		memzero_explicit(block, BLAKE2B_BLOCKBYTES);
-	}
-}
-
 #define G(r,i,a,b,c,d)                                  \
 	do {                                            \
 		a = a + b + m[blake2b_sigma[r][2*i+0]]; \
@@ -297,16 +222,26 @@ static int digest_setkey(struct crypto_shash *tfm, const u8 *key,
 	return 0;
 }
 
-static int digest_init(struct shash_desc *desc)
+static int blake2b_init(struct shash_desc *desc)
 {
 	struct digest_tfm_ctx *mctx = crypto_shash_ctx(desc->tfm);
 	struct blake2b_state *state = shash_desc_ctx(desc);
 	const int digestsize = crypto_shash_digestsize(desc->tfm);
 
-	if (mctx->keylen == 0)
-		blake2b_init(state, digestsize);
-	else
-		blake2b_init_key(state, digestsize, mctx->key, mctx->keylen);
+	memset(state, 0, sizeof(*state));
+	memcpy(state->h, blake2b_IV, sizeof(state->h));
+
+	/* Parameter block is all zeros except index 0, no xor for 1..7 */
+	state->h[0] ^= 0x01010000 | mctx->keylen << 8 | digestsize;
+
+	if (mctx->keylen) {
+		u8 block[BLAKE2B_BLOCKBYTES];
+
+		memset(block, 0, BLAKE2B_BLOCKBYTES);
+		memcpy(block, mctx->key, mctx->keylen);
+		blake2b_update(state, block, BLAKE2B_BLOCKBYTES);
+		memzero_explicit(block, BLAKE2B_BLOCKBYTES);
+	}
 	return 0;
 }
 
@@ -350,7 +285,7 @@ static struct shash_alg blake2b_algs[] = {
 		.base.cra_module	= THIS_MODULE,
 		.digestsize		= BLAKE2B_160_DIGEST_SIZE,
 		.setkey			= digest_setkey,
-		.init			= digest_init,
+		.init			= blake2b_init,
 		.update			= digest_update,
 		.final			= blake2b_final,
 		.descsize		= sizeof(struct blake2b_state),
@@ -364,7 +299,7 @@ static struct shash_alg blake2b_algs[] = {
 		.base.cra_module	= THIS_MODULE,
 		.digestsize		= BLAKE2B_256_DIGEST_SIZE,
 		.setkey			= digest_setkey,
-		.init			= digest_init,
+		.init			= blake2b_init,
 		.update			= digest_update,
 		.final			= blake2b_final,
 		.descsize		= sizeof(struct blake2b_state),
@@ -378,7 +313,7 @@ static struct shash_alg blake2b_algs[] = {
 		.base.cra_module	= THIS_MODULE,
 		.digestsize		= BLAKE2B_384_DIGEST_SIZE,
 		.setkey			= digest_setkey,
-		.init			= digest_init,
+		.init			= blake2b_init,
 		.update			= digest_update,
 		.final			= blake2b_final,
 		.descsize		= sizeof(struct blake2b_state),
@@ -392,7 +327,7 @@ static struct shash_alg blake2b_algs[] = {
 		.base.cra_module	= THIS_MODULE,
 		.digestsize		= BLAKE2B_512_DIGEST_SIZE,
 		.setkey			= digest_setkey,
-		.init			= digest_init,
+		.init			= blake2b_init,
 		.update			= digest_update,
 		.final			= blake2b_final,
 		.descsize		= sizeof(struct blake2b_state),
-- 
2.23.0

