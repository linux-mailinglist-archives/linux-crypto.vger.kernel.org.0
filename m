Return-Path: <linux-crypto+bounces-4658-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0E8D88AF
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Jun 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2700285A83
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Jun 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02485139584;
	Mon,  3 Jun 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcOGyyqu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E31386A5;
	Mon,  3 Jun 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439943; cv=none; b=tr/O/1BLuk+c9f71w0neetEoiRnnGLjrqMFEKp88M/gwfXR2rSJuuzFB3I6FCmm2O79M21UNNlhJ+TLWuZ06vk3wzgce6OSbY+6f4knbqstS5T4YxzXUo1bnahcAFZ1Q5Mb5hl6di3FxgNkvAibSLdYQQZkCKpYMoQX4kb8AOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439943; c=relaxed/simple;
	bh=bEAErKpCeshzwAkO0SuBVx5kVZlpHksTR/Mh3AegBSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG+8bt2uh8wP0OVN5kIUVV7++v1R8d6HANtZ8mmpBQ7gNtjgD24Cyp4A6sTQ+8vUatE+XY1buZjbyZRyRShiBotmfiLmKHCzDpha4ZDouZWt7E0H5kAA4oP8BoE3W+fiJpdFwSHFPjNlUZ2HjvMeJxQUqZUSqnVEVlik9zhl0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcOGyyqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E8AC4AF08;
	Mon,  3 Jun 2024 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717439943;
	bh=bEAErKpCeshzwAkO0SuBVx5kVZlpHksTR/Mh3AegBSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcOGyyquVHb8/gLLemcw1FZg5AOhU7NlI8uDFUuLG2gH394RwEzrcymcqevXcuBWE
	 n40aFXs3tTMx0xaikkxrpUbq2d//s2T/wA1h3DCNePaNqLB0FmbFH9mpuAafZvU/KP
	 uIKK00Ra/EKKCDWIiiSg8+ZtW+inKJHWfN9449v4HwiG54asUcEgHmtMemx7Nz0ypS
	 hcu9wVlrGAPnENebltFZpWYBOSwfEjaSpJPxLUfcvPTWvwAwWK6j6roqw9qqY7MbG6
	 21Bnb+0srTGCN43ht0FbnMlAytnVmDhv83OLumlYeGUpJ682naTf69OYmxeeb91Ydi
	 CK3siuL3PGAzA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	fsverity@lists.linux.dev,
	dm-devel@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 1/8] crypto: shash - add support for finup_mb
Date: Mon,  3 Jun 2024 11:37:24 -0700
Message-ID: <20240603183731.108986-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603183731.108986-1-ebiggers@kernel.org>
References: <20240603183731.108986-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Most cryptographic hash functions are serialized, in the sense that they
have an internal block size and the blocks must be processed serially.
(BLAKE3 is a notable exception that has tree-based hashing built-in, but
all the more common choices such as the SHAs and BLAKE2 are serialized.
ParallelHash and Sakura are parallel hashes based on SHA3, but SHA3 is
much slower than SHA256 in software even with the ARMv8 SHA3 extension.)

This limits the performance of computing a single hash.  Yet, computing
multiple hashes simultaneously does not have this limitation.  Modern
CPUs are superscalar and often can execute independent instructions in
parallel.  As a result, on many modern CPUs, it is possible to hash two
equal-length messages in about the same time as a single message, if all
the instructions are interleaved.

Meanwhile, a very common use case for hashing in the Linux kernel is
dm-verity and fs-verity.  Both use a Merkle tree that has a fixed block
size, usually 4096 bytes with an empty or 32-byte salt prepended.  The
hash algorithm is usually SHA-256.  Usually, many blocks need to be
hashed at a time.  This is an ideal scenario for multibuffer hashing.

Linux actually used to support SHA-256 multibuffer hashing on x86_64,
before it was removed by commit ab8085c130ed ("crypto: x86 - remove SHA
multibuffer routines and mcryptd").  However, it was integrated with the
crypto API in a weird way, where it behaved as an asynchronous hash that
queued up and executed all requests on a global queue.  This made it
very complex, buggy, and virtually unusable.

This patch takes a new approach of just adding an API
crypto_shash_finup_mb() that synchronously computes the hash of multiple
equal-length messages, starting from a common state that represents the
(possibly empty) common prefix shared by the messages.

The new API is part of the "shash" algorithm type, as it does not make
sense in "ahash".  It does a "finup" operation rather than a "digest"
operation in order to support the salt that is used by dm-verity and
fs-verity.  The data and output buffers are provided in arrays of length
@num_msgs in order to make the API itself extensible to interleaving
factors other than 2.  (Though, initially only 2x will actually be used.
There are some platforms in which a higher factor could help, but there
are significant trade-offs.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/shash.c        | 60 +++++++++++++++++++++++++++++++++++++++++++
 include/crypto/hash.h | 45 +++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 301ab42bf849..5a2352933fbf 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -73,10 +73,57 @@ int crypto_shash_finup(struct shash_desc *desc, const u8 *data,
 {
 	return crypto_shash_alg(desc->tfm)->finup(desc, data, len, out);
 }
 EXPORT_SYMBOL_GPL(crypto_shash_finup);
 
+static noinline_for_stack int
+shash_finup_mb_fallback(struct shash_desc *desc, const u8 * const data[],
+			unsigned int len, u8 * const outs[],
+			unsigned int num_msgs)
+{
+	struct crypto_shash *tfm = desc->tfm;
+	SHASH_DESC_ON_STACK(desc2, tfm);
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < num_msgs - 1; i++) {
+		desc2->tfm = tfm;
+		memcpy(shash_desc_ctx(desc2), shash_desc_ctx(desc),
+		       crypto_shash_descsize(tfm));
+		err = crypto_shash_finup(desc2, data[i], len, outs[i]);
+		if (err)
+			return err;
+	}
+	return crypto_shash_finup(desc, data[i], len, outs[i]);
+}
+
+int crypto_shash_finup_mb(struct shash_desc *desc, const u8 * const data[],
+			  unsigned int len, u8 * const outs[],
+			  unsigned int num_msgs)
+{
+	struct shash_alg *alg = crypto_shash_alg(desc->tfm);
+	int err;
+
+	if (num_msgs == 1)
+		return crypto_shash_finup(desc, data[0], len, outs[0]);
+
+	if (num_msgs == 0)
+		return 0;
+
+	if (WARN_ON_ONCE(num_msgs > alg->mb_max_msgs))
+		goto fallback;
+
+	err = alg->finup_mb(desc, data, len, outs, num_msgs);
+	if (unlikely(err == -EOPNOTSUPP))
+		goto fallback;
+	return err;
+
+fallback:
+	return shash_finup_mb_fallback(desc, data, len, outs, num_msgs);
+}
+EXPORT_SYMBOL_GPL(crypto_shash_finup_mb);
+
 static int shash_default_digest(struct shash_desc *desc, const u8 *data,
 				unsigned int len, u8 *out)
 {
 	struct shash_alg *shash = crypto_shash_alg(desc->tfm);
 
@@ -312,10 +359,20 @@ static int shash_prepare_alg(struct shash_alg *alg)
 		return -EINVAL;
 
 	if ((alg->export && !alg->import) || (alg->import && !alg->export))
 		return -EINVAL;
 
+	if (alg->mb_max_msgs) {
+		if (alg->mb_max_msgs > HASH_MAX_MB_MSGS)
+			return -EINVAL;
+		if (!alg->finup_mb)
+			return -EINVAL;
+	} else {
+		if (alg->finup_mb)
+			return -EINVAL;
+	}
+
 	err = hash_prepare_alg(&alg->halg);
 	if (err)
 		return err;
 
 	base->cra_type = &crypto_shash_type;
@@ -339,10 +396,13 @@ static int shash_prepare_alg(struct shash_alg *alg)
 	if (!alg->export)
 		alg->halg.statesize = alg->descsize;
 	if (!alg->setkey)
 		alg->setkey = shash_no_setkey;
 
+	if (!alg->mb_max_msgs)
+		alg->mb_max_msgs = 1;
+
 	return 0;
 }
 
 int crypto_register_shash(struct shash_alg *alg)
 {
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 2d5ea9f9ff43..002099610755 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -154,11 +154,13 @@ struct ahash_alg {
 struct shash_desc {
 	struct crypto_shash *tfm;
 	void *__ctx[] __aligned(ARCH_SLAB_MINALIGN);
 };
 
-#define HASH_MAX_DIGESTSIZE	 64
+#define HASH_MAX_DIGESTSIZE	64
+
+#define HASH_MAX_MB_MSGS	2  /* max value of crypto_shash_mb_max_msgs() */
 
 /*
  * Worst case is hmac(sha3-224-generic).  Its context is a nested 'shash_desc'
  * containing a 'struct sha3_state'.
  */
@@ -177,10 +179,19 @@ struct shash_desc {
  * @finup: see struct ahash_alg
  * @digest: see struct ahash_alg
  * @export: see struct ahash_alg
  * @import: see struct ahash_alg
  * @setkey: see struct ahash_alg
+ * @finup_mb: **[optional]** Multibuffer hashing support.  Finish calculating
+ *	      the digests of multiple messages, interleaving the instructions to
+ *	      potentially achieve better performance than hashing each message
+ *	      individually.  The num_msgs argument will be between 2 and
+ *	      @mb_max_msgs inclusively.  If there are particular values of len
+ *	      or num_msgs, or a particular calling context (e.g. no-SIMD) that
+ *	      the implementation does not support with this method, the
+ *	      implementation may return -EOPNOTSUPP from this method in those
+ *	      cases to cause the crypto API to fall back to repeated finups.
  * @init_tfm: Initialize the cryptographic transformation object.
  *	      This function is called only once at the instantiation
  *	      time, right after the transformation context was
  *	      allocated. In case the cryptographic hardware has
  *	      some special requirements which need to be handled
@@ -192,10 +203,11 @@ struct shash_desc {
  *	      various changes set in @init_tfm.
  * @clone_tfm: Copy transform into new object, may allocate memory.
  * @descsize: Size of the operational state for the message digest. This state
  * 	      size is the memory size that needs to be allocated for
  *	      shash_desc.__ctx
+ * @mb_max_msgs: Maximum supported value of num_msgs argument to @finup_mb
  * @halg: see struct hash_alg_common
  * @HASH_ALG_COMMON: see struct hash_alg_common
  */
 struct shash_alg {
 	int (*init)(struct shash_desc *desc);
@@ -208,15 +220,19 @@ struct shash_alg {
 		      unsigned int len, u8 *out);
 	int (*export)(struct shash_desc *desc, void *out);
 	int (*import)(struct shash_desc *desc, const void *in);
 	int (*setkey)(struct crypto_shash *tfm, const u8 *key,
 		      unsigned int keylen);
+	int (*finup_mb)(struct shash_desc *desc, const u8 * const data[],
+			unsigned int len, u8 * const outs[],
+			unsigned int num_msgs);
 	int (*init_tfm)(struct crypto_shash *tfm);
 	void (*exit_tfm)(struct crypto_shash *tfm);
 	int (*clone_tfm)(struct crypto_shash *dst, struct crypto_shash *src);
 
 	unsigned int descsize;
+	unsigned int mb_max_msgs;
 
 	union {
 		struct HASH_ALG_COMMON;
 		struct hash_alg_common halg;
 	};
@@ -750,10 +766,20 @@ static inline unsigned int crypto_shash_digestsize(struct crypto_shash *tfm)
 static inline unsigned int crypto_shash_statesize(struct crypto_shash *tfm)
 {
 	return crypto_shash_alg(tfm)->statesize;
 }
 
+/*
+ * Return the maximum supported multibuffer hashing interleaving factor, i.e.
+ * the maximum num_msgs that can be passed to crypto_shash_finup_mb().  The
+ * return value will be between 1 and HASH_MAX_MB_MSGS inclusively.
+ */
+static inline unsigned int crypto_shash_mb_max_msgs(struct crypto_shash *tfm)
+{
+	return crypto_shash_alg(tfm)->mb_max_msgs;
+}
+
 static inline u32 crypto_shash_get_flags(struct crypto_shash *tfm)
 {
 	return crypto_tfm_get_flags(crypto_shash_tfm(tfm));
 }
 
@@ -843,10 +869,27 @@ int crypto_shash_digest(struct shash_desc *desc, const u8 *data,
  * Return: 0 on success; < 0 if an error occurred.
  */
 int crypto_shash_tfm_digest(struct crypto_shash *tfm, const u8 *data,
 			    unsigned int len, u8 *out);
 
+/**
+ * crypto_shash_finup_mb() - multibuffer message hashing
+ * @desc: the starting state that is forked for each message.  It contains the
+ *	  state after hashing a (possibly-empty) common prefix of the messages.
+ * @data: the data of each message (not including any common prefix from @desc)
+ * @len: length of each data buffer in bytes
+ * @outs: output buffer for each message digest
+ * @num_msgs: number of messages, i.e. the number of entries in @data and @outs.
+ *	      This can't be more than crypto_shash_mb_max_msgs().
+ *
+ * Context: Any context.
+ * Return: 0 on success; a negative errno value on failure.
+ */
+int crypto_shash_finup_mb(struct shash_desc *desc, const u8 * const data[],
+			  unsigned int len, u8 * const outs[],
+			  unsigned int num_msgs);
+
 /**
  * crypto_shash_export() - extract operational state for message digest
  * @desc: reference to the operational state handle whose state is exported
  * @out: output buffer of sufficient size that can hold the hash state
  *
-- 
2.45.1


