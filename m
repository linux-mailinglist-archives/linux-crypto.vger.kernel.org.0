Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA26A3AE9
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Feb 2023 06:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB0Fwe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Feb 2023 00:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0Fwd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Feb 2023 00:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221B1A670;
        Sun, 26 Feb 2023 21:52:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F153B80C9D;
        Mon, 27 Feb 2023 05:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146F2C433D2;
        Mon, 27 Feb 2023 05:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677477147;
        bh=aPo5WaY/XIMwJW9JZdOvrAHioUQEA/ViC9rIR/eViNg=;
        h=From:To:Cc:Subject:Date:From;
        b=fnJZG/8KUuth7N0BAxvtAytckxCWUy0NR7uAuKYWSnGSwgFkZcFiFTl//k02yw8ye
         EBGn/ePNDVygTiQZ4Xy2EhD1gTbnFDT9tQ81DaDaQgJSV4XjTM1CJiwZ4ecJYHzjm8
         jOiAtjteuOUZ6wQ//immxhgbwpdpnZrQMURWJnS6buzLq94Cwji9rmW7cX40I0qpEb
         l+fng8Zyz1cBrzpyJSSaQv1HM1Msm3eVC5WM9smEZws9IPYWwKM6Ro23wV0sXPPR0y
         VUXjWK2zOfdmzqPuHr4Srwy8T88XCwU0kD5XrtOz8Tu7fZ2nECW/ULNlyqAAQVv5nC
         KqJU57H1cWEUg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A . Donenfeld " <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] crypto: testmgr - fix RNG performance in fuzz tests
Date:   Sun, 26 Feb 2023 21:50:18 -0800
Message-Id: <20230227055018.1713117-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The performance of the crypto fuzz tests has greatly regressed since
v5.18.  When booting a kernel on an arm64 dev board with all software
crypto algorithms and CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled, the
fuzz tests now take about 200 seconds to run, or about 325 seconds with
lockdep enabled, compared to about 5 seconds before.

The root cause is that the random number generation has become much
slower due to commit d4150779e60f ("random32: use real rng for
non-deterministic randomness").  On my same arm64 dev board, at the time
the fuzz tests are run, get_random_u8() is about 345x slower than
prandom_u32_state(), or about 469x if lockdep is enabled.

Lockdep makes a big difference, but much of the rest comes from the
get_random_*() functions taking a *very* slow path when the CRNG is not
yet initialized.  Since the crypto self-tests run early during boot,
even having a hardware RNG driver enabled (CONFIG_CRYPTO_DEV_QCOM_RNG in
my case) doesn't prevent this.  x86 systems don't have this issue, but
they still see a significant regression if lockdep is enabled.

Converting the "Fully random bytes" case in generate_random_bytes() to
use get_random_bytes() helps significantly, improving the test time to
about 27 seconds.  But that's still over 5x slower than before.

This is all a bit silly, though, since the fuzz tests don't actually
need cryptographically secure random numbers.  So let's just make them
use a non-cryptographically-secure RNG as they did before.  The original
prandom_u32() is gone now, so let's use prandom_u32_state() instead,
with an explicitly managed state, like various other self-tests in the
kernel source tree (rbtree_test.c, test_scanf.c, etc.) already do.  This
also has the benefit that no locking is required anymore, so performance
should be even better than the original version that used prandom_u32().

Fixes: d4150779e60f ("random32: use real rng for non-deterministic randomness")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.c | 268 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 171 insertions(+), 97 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c91e93ece20b..2cbd2f8ce3c3 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -860,12 +860,52 @@ static int prepare_keybuf(const u8 *key, unsigned int ksize,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 
+/*
+ * The fuzz tests use prandom instead of the normal Linux RNG since they don't
+ * need cryptographically secure random numbers.  This greatly improves the
+ * performance of these tests, especially if they are run before the Linux RNG
+ * has been initialized or if they are run on a lockdep-enabled kernel.
+ */
+
+static inline void init_rnd_state(struct rnd_state *rng)
+{
+	static atomic64_t next_seed;
+
+	prandom_seed_state(rng, atomic64_inc_return(&next_seed));
+}
+
+static inline u8 prandom_u8(struct rnd_state *rng)
+{
+	return prandom_u32_state(rng);
+}
+
+static inline u32 prandom_u32_below(struct rnd_state *rng, u32 n)
+{
+	/*
+	 * This is slightly biased for non-power-of-2 values of n, but this
+	 * isn't important here.
+	 */
+	return prandom_u32_state(rng) % n;
+}
+
+static inline bool prandom_bool(struct rnd_state *rng)
+{
+	return prandom_u32_below(rng, 2);
+}
+
+static inline u32 prandom_u32_inclusive(struct rnd_state *rng,
+					u32 floor, u32 ceil)
+{
+	return floor + prandom_u32_below(rng, ceil - floor + 1);
+}
+
 /* Generate a random length in range [0, max_len], but prefer smaller values */
-static unsigned int generate_random_length(unsigned int max_len)
+static unsigned int generate_random_length(struct rnd_state *rng,
+					   unsigned int max_len)
 {
-	unsigned int len = get_random_u32_below(max_len + 1);
+	unsigned int len = prandom_u32_below(rng, max_len + 1);
 
-	switch (get_random_u32_below(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 		return len % 64;
 	case 1:
@@ -878,43 +918,44 @@ static unsigned int generate_random_length(unsigned int max_len)
 }
 
 /* Flip a random bit in the given nonempty data buffer */
-static void flip_random_bit(u8 *buf, size_t size)
+static void flip_random_bit(struct rnd_state *rng, u8 *buf, size_t size)
 {
 	size_t bitpos;
 
-	bitpos = get_random_u32_below(size * 8);
+	bitpos = prandom_u32_below(rng, size * 8);
 	buf[bitpos / 8] ^= 1 << (bitpos % 8);
 }
 
 /* Flip a random byte in the given nonempty data buffer */
-static void flip_random_byte(u8 *buf, size_t size)
+static void flip_random_byte(struct rnd_state *rng, u8 *buf, size_t size)
 {
-	buf[get_random_u32_below(size)] ^= 0xff;
+	buf[prandom_u32_below(rng, size)] ^= 0xff;
 }
 
 /* Sometimes make some random changes to the given nonempty data buffer */
-static void mutate_buffer(u8 *buf, size_t size)
+static void mutate_buffer(struct rnd_state *rng, u8 *buf, size_t size)
 {
 	size_t num_flips;
 	size_t i;
 
 	/* Sometimes flip some bits */
-	if (get_random_u32_below(4) == 0) {
-		num_flips = min_t(size_t, 1 << get_random_u32_below(8), size * 8);
+	if (prandom_u32_below(rng, 4) == 0) {
+		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8),
+				  size * 8);
 		for (i = 0; i < num_flips; i++)
-			flip_random_bit(buf, size);
+			flip_random_bit(rng, buf, size);
 	}
 
 	/* Sometimes flip some bytes */
-	if (get_random_u32_below(4) == 0) {
-		num_flips = min_t(size_t, 1 << get_random_u32_below(8), size);
+	if (prandom_u32_below(rng, 4) == 0) {
+		num_flips = min_t(size_t, 1 << prandom_u32_below(rng, 8), size);
 		for (i = 0; i < num_flips; i++)
-			flip_random_byte(buf, size);
+			flip_random_byte(rng, buf, size);
 	}
 }
 
 /* Randomly generate 'count' bytes, but sometimes make them "interesting" */
-static void generate_random_bytes(u8 *buf, size_t count)
+static void generate_random_bytes(struct rnd_state *rng, u8 *buf, size_t count)
 {
 	u8 b;
 	u8 increment;
@@ -923,11 +964,11 @@ static void generate_random_bytes(u8 *buf, size_t count)
 	if (count == 0)
 		return;
 
-	switch (get_random_u32_below(8)) { /* Choose a generation strategy */
+	switch (prandom_u32_below(rng, 8)) { /* Choose a generation strategy */
 	case 0:
 	case 1:
 		/* All the same byte, plus optional mutations */
-		switch (get_random_u32_below(4)) {
+		switch (prandom_u32_below(rng, 4)) {
 		case 0:
 			b = 0x00;
 			break;
@@ -935,28 +976,28 @@ static void generate_random_bytes(u8 *buf, size_t count)
 			b = 0xff;
 			break;
 		default:
-			b = get_random_u8();
+			b = prandom_u8(rng);
 			break;
 		}
 		memset(buf, b, count);
-		mutate_buffer(buf, count);
+		mutate_buffer(rng, buf, count);
 		break;
 	case 2:
 		/* Ascending or descending bytes, plus optional mutations */
-		increment = get_random_u8();
-		b = get_random_u8();
+		increment = prandom_u8(rng);
+		b = prandom_u8(rng);
 		for (i = 0; i < count; i++, b += increment)
 			buf[i] = b;
-		mutate_buffer(buf, count);
+		mutate_buffer(rng, buf, count);
 		break;
 	default:
 		/* Fully random bytes */
-		for (i = 0; i < count; i++)
-			buf[i] = get_random_u8();
+		prandom_bytes_state(rng, buf, count);
 	}
 }
 
-static char *generate_random_sgl_divisions(struct test_sg_division *divs,
+static char *generate_random_sgl_divisions(struct rnd_state *rng,
+					   struct test_sg_division *divs,
 					   size_t max_divs, char *p, char *end,
 					   bool gen_flushes, u32 req_flags)
 {
@@ -967,24 +1008,26 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 		unsigned int this_len;
 		const char *flushtype_str;
 
-		if (div == &divs[max_divs - 1] || get_random_u32_below(2) == 0)
+		if (div == &divs[max_divs - 1] || prandom_bool(rng))
 			this_len = remaining;
 		else
-			this_len = get_random_u32_inclusive(1, remaining);
+			this_len = prandom_u32_inclusive(rng, 1, remaining);
 		div->proportion_of_total = this_len;
 
-		if (get_random_u32_below(4) == 0)
-			div->offset = get_random_u32_inclusive(PAGE_SIZE - 128, PAGE_SIZE - 1);
-		else if (get_random_u32_below(2) == 0)
-			div->offset = get_random_u32_below(32);
+		if (prandom_u32_below(rng, 4) == 0)
+			div->offset = prandom_u32_inclusive(rng,
+							    PAGE_SIZE - 128,
+							    PAGE_SIZE - 1);
+		else if (prandom_bool(rng))
+			div->offset = prandom_u32_below(rng, 32);
 		else
-			div->offset = get_random_u32_below(PAGE_SIZE);
-		if (get_random_u32_below(8) == 0)
+			div->offset = prandom_u32_below(rng, PAGE_SIZE);
+		if (prandom_u32_below(rng, 8) == 0)
 			div->offset_relative_to_alignmask = true;
 
 		div->flush_type = FLUSH_TYPE_NONE;
 		if (gen_flushes) {
-			switch (get_random_u32_below(4)) {
+			switch (prandom_u32_below(rng, 4)) {
 			case 0:
 				div->flush_type = FLUSH_TYPE_REIMPORT;
 				break;
@@ -996,7 +1039,7 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 
 		if (div->flush_type != FLUSH_TYPE_NONE &&
 		    !(req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) &&
-		    get_random_u32_below(2) == 0)
+		    prandom_bool(rng))
 			div->nosimd = true;
 
 		switch (div->flush_type) {
@@ -1031,7 +1074,8 @@ static char *generate_random_sgl_divisions(struct test_sg_division *divs,
 }
 
 /* Generate a random testvec_config for fuzz testing */
-static void generate_random_testvec_config(struct testvec_config *cfg,
+static void generate_random_testvec_config(struct rnd_state *rng,
+					   struct testvec_config *cfg,
 					   char *name, size_t max_namelen)
 {
 	char *p = name;
@@ -1043,7 +1087,7 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 
 	p += scnprintf(p, end - p, "random:");
 
-	switch (get_random_u32_below(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 	case 1:
 		cfg->inplace_mode = OUT_OF_PLACE;
@@ -1058,12 +1102,12 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 		break;
 	}
 
-	if (get_random_u32_below(2) == 0) {
+	if (prandom_bool(rng)) {
 		cfg->req_flags |= CRYPTO_TFM_REQ_MAY_SLEEP;
 		p += scnprintf(p, end - p, " may_sleep");
 	}
 
-	switch (get_random_u32_below(4)) {
+	switch (prandom_u32_below(rng, 4)) {
 	case 0:
 		cfg->finalization_type = FINALIZATION_TYPE_FINAL;
 		p += scnprintf(p, end - p, " use_final");
@@ -1078,36 +1122,37 @@ static void generate_random_testvec_config(struct testvec_config *cfg,
 		break;
 	}
 
-	if (!(cfg->req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) &&
-	    get_random_u32_below(2) == 0) {
+	if (!(cfg->req_flags & CRYPTO_TFM_REQ_MAY_SLEEP) && prandom_bool(rng)) {
 		cfg->nosimd = true;
 		p += scnprintf(p, end - p, " nosimd");
 	}
 
 	p += scnprintf(p, end - p, " src_divs=[");
-	p = generate_random_sgl_divisions(cfg->src_divs,
+	p = generate_random_sgl_divisions(rng, cfg->src_divs,
 					  ARRAY_SIZE(cfg->src_divs), p, end,
 					  (cfg->finalization_type !=
 					   FINALIZATION_TYPE_DIGEST),
 					  cfg->req_flags);
 	p += scnprintf(p, end - p, "]");
 
-	if (cfg->inplace_mode == OUT_OF_PLACE && get_random_u32_below(2) == 0) {
+	if (cfg->inplace_mode == OUT_OF_PLACE && prandom_bool(rng)) {
 		p += scnprintf(p, end - p, " dst_divs=[");
-		p = generate_random_sgl_divisions(cfg->dst_divs,
+		p = generate_random_sgl_divisions(rng, cfg->dst_divs,
 						  ARRAY_SIZE(cfg->dst_divs),
 						  p, end, false,
 						  cfg->req_flags);
 		p += scnprintf(p, end - p, "]");
 	}
 
-	if (get_random_u32_below(2) == 0) {
-		cfg->iv_offset = get_random_u32_inclusive(1, MAX_ALGAPI_ALIGNMASK);
+	if (prandom_bool(rng)) {
+		cfg->iv_offset = prandom_u32_inclusive(rng, 1,
+						       MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " iv_offset=%u", cfg->iv_offset);
 	}
 
-	if (get_random_u32_below(2) == 0) {
-		cfg->key_offset = get_random_u32_inclusive(1, MAX_ALGAPI_ALIGNMASK);
+	if (prandom_bool(rng)) {
+		cfg->key_offset = prandom_u32_inclusive(rng, 1,
+							MAX_ALGAPI_ALIGNMASK);
 		p += scnprintf(p, end - p, " key_offset=%u", cfg->key_offset);
 	}
 
@@ -1620,11 +1665,14 @@ static int test_hash_vec(const struct hash_testvec *vec, unsigned int vec_num,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_hash_vec_cfg(vec, vec_name, &cfg,
 						req, desc, tsgl, hashstate);
@@ -1642,15 +1690,16 @@ static int test_hash_vec(const struct hash_testvec *vec, unsigned int vec_num,
  * Generate a hash test vector from the given implementation.
  * Assumes the buffers in 'vec' were already allocated.
  */
-static void generate_random_hash_testvec(struct shash_desc *desc,
+static void generate_random_hash_testvec(struct rnd_state *rng,
+					 struct shash_desc *desc,
 					 struct hash_testvec *vec,
 					 unsigned int maxkeysize,
 					 unsigned int maxdatasize,
 					 char *name, size_t max_namelen)
 {
 	/* Data */
-	vec->psize = generate_random_length(maxdatasize);
-	generate_random_bytes((u8 *)vec->plaintext, vec->psize);
+	vec->psize = generate_random_length(rng, maxdatasize);
+	generate_random_bytes(rng, (u8 *)vec->plaintext, vec->psize);
 
 	/*
 	 * Key: length in range [1, maxkeysize], but usually choose maxkeysize.
@@ -1660,9 +1709,9 @@ static void generate_random_hash_testvec(struct shash_desc *desc,
 	vec->ksize = 0;
 	if (maxkeysize) {
 		vec->ksize = maxkeysize;
-		if (get_random_u32_below(4) == 0)
-			vec->ksize = get_random_u32_inclusive(1, maxkeysize);
-		generate_random_bytes((u8 *)vec->key, vec->ksize);
+		if (prandom_u32_below(rng, 4) == 0)
+			vec->ksize = prandom_u32_inclusive(rng, 1, maxkeysize);
+		generate_random_bytes(rng, (u8 *)vec->key, vec->ksize);
 
 		vec->setkey_error = crypto_shash_setkey(desc->tfm, vec->key,
 							vec->ksize);
@@ -1696,6 +1745,7 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	const unsigned int maxdatasize = (2 * PAGE_SIZE) - TESTMGR_POISON_LEN;
 	const char *algname = crypto_hash_alg_common(tfm)->base.cra_name;
 	const char *driver = crypto_ahash_driver_name(tfm);
+	struct rnd_state rng;
 	char _generic_driver[CRYPTO_MAX_ALG_NAME];
 	struct crypto_shash *generic_tfm = NULL;
 	struct shash_desc *generic_desc = NULL;
@@ -1709,6 +1759,8 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	if (noextratests)
 		return 0;
 
+	init_rnd_state(&rng);
+
 	if (!generic_driver) { /* Use default naming convention? */
 		err = build_generic_driver_name(algname, _generic_driver);
 		if (err)
@@ -1777,10 +1829,11 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	}
 
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_hash_testvec(generic_desc, &vec,
+		generate_random_hash_testvec(&rng, generic_desc, &vec,
 					     maxkeysize, maxdatasize,
 					     vec_name, sizeof(vec_name));
-		generate_random_testvec_config(cfg, cfgname, sizeof(cfgname));
+		generate_random_testvec_config(&rng, cfg, cfgname,
+					       sizeof(cfgname));
 
 		err = test_hash_vec_cfg(&vec, vec_name, cfg,
 					req, desc, tsgl, hashstate);
@@ -2182,11 +2235,14 @@ static int test_aead_vec(int enc, const struct aead_testvec *vec,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_aead_vec_cfg(enc, vec, vec_name,
 						&cfg, req, tsgls);
@@ -2202,6 +2258,7 @@ static int test_aead_vec(int enc, const struct aead_testvec *vec,
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 
 struct aead_extra_tests_ctx {
+	struct rnd_state rng;
 	struct aead_request *req;
 	struct crypto_aead *tfm;
 	const struct alg_test_desc *test_desc;
@@ -2220,24 +2277,26 @@ struct aead_extra_tests_ctx {
  * here means the full ciphertext including the authentication tag.  The
  * authentication tag (and hence also the ciphertext) is assumed to be nonempty.
  */
-static void mutate_aead_message(struct aead_testvec *vec, bool aad_iv,
+static void mutate_aead_message(struct rnd_state *rng,
+				struct aead_testvec *vec, bool aad_iv,
 				unsigned int ivsize)
 {
 	const unsigned int aad_tail_size = aad_iv ? ivsize : 0;
 	const unsigned int authsize = vec->clen - vec->plen;
 
-	if (get_random_u32_below(2) == 0 && vec->alen > aad_tail_size) {
+	if (prandom_bool(rng) && vec->alen > aad_tail_size) {
 		 /* Mutate the AAD */
-		flip_random_bit((u8 *)vec->assoc, vec->alen - aad_tail_size);
-		if (get_random_u32_below(2) == 0)
+		flip_random_bit(rng, (u8 *)vec->assoc,
+				vec->alen - aad_tail_size);
+		if (prandom_bool(rng))
 			return;
 	}
-	if (get_random_u32_below(2) == 0) {
+	if (prandom_bool(rng)) {
 		/* Mutate auth tag (assuming it's at the end of ciphertext) */
-		flip_random_bit((u8 *)vec->ctext + vec->plen, authsize);
+		flip_random_bit(rng, (u8 *)vec->ctext + vec->plen, authsize);
 	} else {
 		/* Mutate any part of the ciphertext */
-		flip_random_bit((u8 *)vec->ctext, vec->clen);
+		flip_random_bit(rng, (u8 *)vec->ctext, vec->clen);
 	}
 }
 
@@ -2248,7 +2307,8 @@ static void mutate_aead_message(struct aead_testvec *vec, bool aad_iv,
  */
 #define MIN_COLLISION_FREE_AUTHSIZE 8
 
-static void generate_aead_message(struct aead_request *req,
+static void generate_aead_message(struct rnd_state *rng,
+				  struct aead_request *req,
 				  const struct aead_test_suite *suite,
 				  struct aead_testvec *vec,
 				  bool prefer_inauthentic)
@@ -2257,17 +2317,18 @@ static void generate_aead_message(struct aead_request *req,
 	const unsigned int ivsize = crypto_aead_ivsize(tfm);
 	const unsigned int authsize = vec->clen - vec->plen;
 	const bool inauthentic = (authsize >= MIN_COLLISION_FREE_AUTHSIZE) &&
-				 (prefer_inauthentic || get_random_u32_below(4) == 0);
+				 (prefer_inauthentic ||
+				  prandom_u32_below(rng, 4) == 0);
 
 	/* Generate the AAD. */
-	generate_random_bytes((u8 *)vec->assoc, vec->alen);
+	generate_random_bytes(rng, (u8 *)vec->assoc, vec->alen);
 	if (suite->aad_iv && vec->alen >= ivsize)
 		/* Avoid implementation-defined behavior. */
 		memcpy((u8 *)vec->assoc + vec->alen - ivsize, vec->iv, ivsize);
 
-	if (inauthentic && get_random_u32_below(2) == 0) {
+	if (inauthentic && prandom_bool(rng)) {
 		/* Generate a random ciphertext. */
-		generate_random_bytes((u8 *)vec->ctext, vec->clen);
+		generate_random_bytes(rng, (u8 *)vec->ctext, vec->clen);
 	} else {
 		int i = 0;
 		struct scatterlist src[2], dst;
@@ -2279,7 +2340,7 @@ static void generate_aead_message(struct aead_request *req,
 		if (vec->alen)
 			sg_set_buf(&src[i++], vec->assoc, vec->alen);
 		if (vec->plen) {
-			generate_random_bytes((u8 *)vec->ptext, vec->plen);
+			generate_random_bytes(rng, (u8 *)vec->ptext, vec->plen);
 			sg_set_buf(&src[i++], vec->ptext, vec->plen);
 		}
 		sg_init_one(&dst, vec->ctext, vec->alen + vec->clen);
@@ -2299,7 +2360,7 @@ static void generate_aead_message(struct aead_request *req,
 		 * Mutate the authentic (ciphertext, AAD) pair to get an
 		 * inauthentic one.
 		 */
-		mutate_aead_message(vec, suite->aad_iv, ivsize);
+		mutate_aead_message(rng, vec, suite->aad_iv, ivsize);
 	}
 	vec->novrfy = 1;
 	if (suite->einval_allowed)
@@ -2313,7 +2374,8 @@ static void generate_aead_message(struct aead_request *req,
  * If 'prefer_inauthentic' is true, then this function will generate inauthentic
  * test vectors (i.e. vectors with 'vec->novrfy=1') more often.
  */
-static void generate_random_aead_testvec(struct aead_request *req,
+static void generate_random_aead_testvec(struct rnd_state *rng,
+					 struct aead_request *req,
 					 struct aead_testvec *vec,
 					 const struct aead_test_suite *suite,
 					 unsigned int maxkeysize,
@@ -2329,18 +2391,18 @@ static void generate_random_aead_testvec(struct aead_request *req,
 
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
-	if (get_random_u32_below(4) == 0)
-		vec->klen = get_random_u32_below(maxkeysize + 1);
-	generate_random_bytes((u8 *)vec->key, vec->klen);
+	if (prandom_u32_below(rng, 4) == 0)
+		vec->klen = prandom_u32_below(rng, maxkeysize + 1);
+	generate_random_bytes(rng, (u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_aead_setkey(tfm, vec->key, vec->klen);
 
 	/* IV */
-	generate_random_bytes((u8 *)vec->iv, ivsize);
+	generate_random_bytes(rng, (u8 *)vec->iv, ivsize);
 
 	/* Tag length: in [0, maxauthsize], but usually choose maxauthsize */
 	authsize = maxauthsize;
-	if (get_random_u32_below(4) == 0)
-		authsize = get_random_u32_below(maxauthsize + 1);
+	if (prandom_u32_below(rng, 4) == 0)
+		authsize = prandom_u32_below(rng, maxauthsize + 1);
 	if (prefer_inauthentic && authsize < MIN_COLLISION_FREE_AUTHSIZE)
 		authsize = MIN_COLLISION_FREE_AUTHSIZE;
 	if (WARN_ON(authsize > maxdatasize))
@@ -2349,11 +2411,11 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	vec->setauthsize_error = crypto_aead_setauthsize(tfm, authsize);
 
 	/* AAD, plaintext, and ciphertext lengths */
-	total_len = generate_random_length(maxdatasize);
-	if (get_random_u32_below(4) == 0)
+	total_len = generate_random_length(rng, maxdatasize);
+	if (prandom_u32_below(rng, 4) == 0)
 		vec->alen = 0;
 	else
-		vec->alen = generate_random_length(total_len);
+		vec->alen = generate_random_length(rng, total_len);
 	vec->plen = total_len - vec->alen;
 	vec->clen = vec->plen + authsize;
 
@@ -2364,7 +2426,7 @@ static void generate_random_aead_testvec(struct aead_request *req,
 	vec->novrfy = 0;
 	vec->crypt_error = 0;
 	if (vec->setkey_error == 0 && vec->setauthsize_error == 0)
-		generate_aead_message(req, suite, vec, prefer_inauthentic);
+		generate_aead_message(rng, req, suite, vec, prefer_inauthentic);
 	snprintf(name, max_namelen,
 		 "\"random: alen=%u plen=%u authsize=%u klen=%u novrfy=%d\"",
 		 vec->alen, vec->plen, authsize, vec->klen, vec->novrfy);
@@ -2376,7 +2438,7 @@ static void try_to_generate_inauthentic_testvec(
 	int i;
 
 	for (i = 0; i < 10; i++) {
-		generate_random_aead_testvec(ctx->req, &ctx->vec,
+		generate_random_aead_testvec(&ctx->rng, ctx->req, &ctx->vec,
 					     &ctx->test_desc->suite.aead,
 					     ctx->maxkeysize, ctx->maxdatasize,
 					     ctx->vec_name,
@@ -2407,7 +2469,8 @@ static int test_aead_inauthentic_inputs(struct aead_extra_tests_ctx *ctx)
 		 */
 		try_to_generate_inauthentic_testvec(ctx);
 		if (ctx->vec.novrfy) {
-			generate_random_testvec_config(&ctx->cfg, ctx->cfgname,
+			generate_random_testvec_config(&ctx->rng, &ctx->cfg,
+						       ctx->cfgname,
 						       sizeof(ctx->cfgname));
 			err = test_aead_vec_cfg(DECRYPT, &ctx->vec,
 						ctx->vec_name, &ctx->cfg,
@@ -2497,12 +2560,13 @@ static int test_aead_vs_generic_impl(struct aead_extra_tests_ctx *ctx)
 	 * the other implementation against them.
 	 */
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_aead_testvec(generic_req, &ctx->vec,
+		generate_random_aead_testvec(&ctx->rng, generic_req, &ctx->vec,
 					     &ctx->test_desc->suite.aead,
 					     ctx->maxkeysize, ctx->maxdatasize,
 					     ctx->vec_name,
 					     sizeof(ctx->vec_name), false);
-		generate_random_testvec_config(&ctx->cfg, ctx->cfgname,
+		generate_random_testvec_config(&ctx->rng, &ctx->cfg,
+					       ctx->cfgname,
 					       sizeof(ctx->cfgname));
 		if (!ctx->vec.novrfy) {
 			err = test_aead_vec_cfg(ENCRYPT, &ctx->vec,
@@ -2541,6 +2605,7 @@ static int test_aead_extra(const struct alg_test_desc *test_desc,
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+	init_rnd_state(&ctx->rng);
 	ctx->req = req;
 	ctx->tfm = crypto_aead_reqtfm(req);
 	ctx->test_desc = test_desc;
@@ -2930,11 +2995,14 @@ static int test_skcipher_vec(int enc, const struct cipher_testvec *vec,
 
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 	if (!noextratests) {
+		struct rnd_state rng;
 		struct testvec_config cfg;
 		char cfgname[TESTVEC_CONFIG_NAMELEN];
 
+		init_rnd_state(&rng);
+
 		for (i = 0; i < fuzz_iterations; i++) {
-			generate_random_testvec_config(&cfg, cfgname,
+			generate_random_testvec_config(&rng, &cfg, cfgname,
 						       sizeof(cfgname));
 			err = test_skcipher_vec_cfg(enc, vec, vec_name,
 						    &cfg, req, tsgls);
@@ -2952,7 +3020,8 @@ static int test_skcipher_vec(int enc, const struct cipher_testvec *vec,
  * Generate a symmetric cipher test vector from the given implementation.
  * Assumes the buffers in 'vec' were already allocated.
  */
-static void generate_random_cipher_testvec(struct skcipher_request *req,
+static void generate_random_cipher_testvec(struct rnd_state *rng,
+					   struct skcipher_request *req,
 					   struct cipher_testvec *vec,
 					   unsigned int maxdatasize,
 					   char *name, size_t max_namelen)
@@ -2966,17 +3035,17 @@ static void generate_random_cipher_testvec(struct skcipher_request *req,
 
 	/* Key: length in [0, maxkeysize], but usually choose maxkeysize */
 	vec->klen = maxkeysize;
-	if (get_random_u32_below(4) == 0)
-		vec->klen = get_random_u32_below(maxkeysize + 1);
-	generate_random_bytes((u8 *)vec->key, vec->klen);
+	if (prandom_u32_below(rng, 4) == 0)
+		vec->klen = prandom_u32_below(rng, maxkeysize + 1);
+	generate_random_bytes(rng, (u8 *)vec->key, vec->klen);
 	vec->setkey_error = crypto_skcipher_setkey(tfm, vec->key, vec->klen);
 
 	/* IV */
-	generate_random_bytes((u8 *)vec->iv, ivsize);
+	generate_random_bytes(rng, (u8 *)vec->iv, ivsize);
 
 	/* Plaintext */
-	vec->len = generate_random_length(maxdatasize);
-	generate_random_bytes((u8 *)vec->ptext, vec->len);
+	vec->len = generate_random_length(rng, maxdatasize);
+	generate_random_bytes(rng, (u8 *)vec->ptext, vec->len);
 
 	/* If the key couldn't be set, no need to continue to encrypt. */
 	if (vec->setkey_error)
@@ -3018,6 +3087,7 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	const unsigned int maxdatasize = (2 * PAGE_SIZE) - TESTMGR_POISON_LEN;
 	const char *algname = crypto_skcipher_alg(tfm)->base.cra_name;
 	const char *driver = crypto_skcipher_driver_name(tfm);
+	struct rnd_state rng;
 	char _generic_driver[CRYPTO_MAX_ALG_NAME];
 	struct crypto_skcipher *generic_tfm = NULL;
 	struct skcipher_request *generic_req = NULL;
@@ -3035,6 +3105,8 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	if (strncmp(algname, "kw(", 3) == 0)
 		return 0;
 
+	init_rnd_state(&rng);
+
 	if (!generic_driver) { /* Use default naming convention? */
 		err = build_generic_driver_name(algname, _generic_driver);
 		if (err)
@@ -3119,9 +3191,11 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	}
 
 	for (i = 0; i < fuzz_iterations * 8; i++) {
-		generate_random_cipher_testvec(generic_req, &vec, maxdatasize,
+		generate_random_cipher_testvec(&rng, generic_req, &vec,
+					       maxdatasize,
 					       vec_name, sizeof(vec_name));
-		generate_random_testvec_config(cfg, cfgname, sizeof(cfgname));
+		generate_random_testvec_config(&rng, cfg, cfgname,
+					       sizeof(cfgname));
 
 		err = test_skcipher_vec_cfg(ENCRYPT, &vec, vec_name,
 					    cfg, req, tsgls);

base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
-- 
2.39.2

