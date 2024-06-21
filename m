Return-Path: <linux-crypto+bounces-5160-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21150912C10
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Jun 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE3B1F2378E
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Jun 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694816D4FF;
	Fri, 21 Jun 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+ljcL6V"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187F16B397;
	Fri, 21 Jun 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989219; cv=none; b=WqrFLf+OFOeipFxZ06GtQAH8GhtaQfexd4zIkaW+FIUxrJ2sZTdBCuJEi5qrG2JreYPK5+Rj4OOFiIpUG72tdgNWlgCTjRnxurH6WVPGqpCJ23kpuvtFc6pze57Ghm/41RO2bD4rkltGhONM6vKr01O9m2sf85hfsFQJuX9Jcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989219; c=relaxed/simple;
	bh=h4goIHE8JZiiBX5at0AKaJh1622KaTu4aeyplnUlqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YccDcxK6exgROKiAW/872BprjO8zpqmJKlx1xkDjqA2YNivxQyuMzD7eRc1Mh+tBdCPmDFf+af0YU20iV3EfdFJhu+F+Yi21onOPmg+iX4UAJGAcKmTrDvtg9M2WERAPHbxW3i/ZZbiIAIZ7HSwK4F9akEy4U5Fo/h4UzjiL/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+ljcL6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE9BC4AF08;
	Fri, 21 Jun 2024 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989218;
	bh=h4goIHE8JZiiBX5at0AKaJh1622KaTu4aeyplnUlqSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+ljcL6Vw29bFpZwU5rAHqO/h3jllmrcCt0hf0RV/ATwttH8GbykWTkIjhW2xvoJH
	 VIjuj9WvI60M8wpYLcpVN3uYa1WuXA42/urW/anwqAQYxecRv1qRvIPWN+Wx8noFco
	 RTvZa8PV2sh0dW7vaIxFsogk9l8h9CVM8prw+zwUpBtcVFkcklKXCAGnah0RUmoAyU
	 jTiR+vnaQgzBco9BZZymRAMGRCB/afqLQkmfXIAGFHvmgSlfRZjyVjqexrddjZdIIK
	 tKWlddceeLb+EkgtFT9Vp8lSpYQP17Z3XTyQsF+7tkkCo8oSYAVcAf72Dz4SuowwnQ
	 k0kEelMRjcGzw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	fsverity@lists.linux.dev,
	dm-devel@lists.linux.dev
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v6 06/15] fsverity: improve performance by using multibuffer hashing
Date: Fri, 21 Jun 2024 09:59:13 -0700
Message-ID: <20240621165922.77672-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621165922.77672-1-ebiggers@kernel.org>
References: <20240621165922.77672-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

When supported by the hash algorithm, use crypto_shash_finup_mb() to
interleave the hashing of pairs of data blocks.  On some CPUs this
nearly doubles hashing performance.  The increase in overall throughput
of cold-cache fsverity reads that I'm seeing on arm64 and x86_64 is
roughly 35% (though this metric is hard to measure as it jumps around a
lot).

For now this is only done on the verification path, and only for data
blocks, not Merkle tree blocks.  We could use finup_mb on Merkle tree
blocks too, but that is less important as there aren't as many Merkle
tree blocks as data blocks, and that would require some additional code
restructuring.  We could also use finup_mb to accelerate building the
Merkle tree, but verification performance is more important.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |   7 ++
 fs/verity/hash_algs.c        |   8 +-
 fs/verity/verify.c           | 169 +++++++++++++++++++++++++++++------
 3 files changed, 153 insertions(+), 31 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..7535c9d9b516 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -27,10 +27,15 @@ struct fsverity_hash_alg {
 	/*
 	 * The HASH_ALGO_* constant for this algorithm.  This is different from
 	 * FS_VERITY_HASH_ALG_*, which uses a different numbering scheme.
 	 */
 	enum hash_algo algo_id;
+	/*
+	 * The maximum supported interleaving factor for multibuffer hashing, or
+	 * 1 if the algorithm doesn't support multibuffer hashing
+	 */
+	int mb_max_msgs;
 };
 
 /* Merkle tree parameters: hash algorithm, initial hash state, and topology */
 struct merkle_tree_params {
 	const struct fsverity_hash_alg *hash_alg; /* the hash algorithm */
@@ -150,8 +155,10 @@ static inline void fsverity_init_signature(void)
 }
 #endif /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
 
 /* verify.c */
 
+#define FS_VERITY_MAX_PENDING_DATA_BLOCKS	2
+
 void __init fsverity_init_workqueue(void);
 
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index 6b08b1d9a7d7..f24d7c295455 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -82,12 +82,16 @@ const struct fsverity_hash_alg *fsverity_get_hash_alg(const struct inode *inode,
 	if (WARN_ON_ONCE(alg->digest_size != crypto_shash_digestsize(tfm)))
 		goto err_free_tfm;
 	if (WARN_ON_ONCE(alg->block_size != crypto_shash_blocksize(tfm)))
 		goto err_free_tfm;
 
-	pr_info("%s using implementation \"%s\"\n",
-		alg->name, crypto_shash_driver_name(tfm));
+	alg->mb_max_msgs = min(crypto_shash_mb_max_msgs(tfm),
+			       FS_VERITY_MAX_PENDING_DATA_BLOCKS);
+
+	pr_info("%s using implementation \"%s\"%s\n",
+		alg->name, crypto_shash_driver_name(tfm),
+		alg->mb_max_msgs > 1 ? " (multibuffer)" : "");
 
 	/* pairs with smp_load_acquire() above */
 	smp_store_release(&alg->tfm, tfm);
 	goto out_unlock;
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..a07651c22520 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -8,10 +8,31 @@
 #include "fsverity_private.h"
 
 #include <crypto/hash.h>
 #include <linux/bio.h>
 
+struct fsverity_pending_block {
+	const void *data;
+	u64 pos;
+	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
+};
+
+struct fsverity_verification_context {
+	struct inode *inode;
+	struct fsverity_info *vi;
+	unsigned long max_ra_pages;
+
+	/*
+	 * This is the queue of data blocks that are pending verification.  We
+	 * allow multiple blocks to be queued up in order to support multibuffer
+	 * hashing, i.e. interleaving the hashing of multiple messages.  On many
+	 * CPUs this improves performance significantly.
+	 */
+	int num_pending;
+	struct fsverity_pending_block pending_blocks[FS_VERITY_MAX_PENDING_DATA_BLOCKS];
+};
+
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
  * Returns true if the hash block with index @hblock_idx in the tree, located in
  * @hpage, has already been verified.
@@ -77,23 +98,25 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 	SetPageChecked(hpage);
 	return false;
 }
 
 /*
- * Verify a single data block against the file's Merkle tree.
+ * Verify the hash of a single data block against the file's Merkle tree.
  *
  * In principle, we need to verify the entire path to the root node.  However,
  * for efficiency the filesystem may cache the hash blocks.  Therefore we need
  * only ascend the tree until an already-verified hash block is seen, and then
  * verify the path to that block.
  *
  * Return: %true if the data block is valid, else %false.
  */
 static bool
 verify_data_block(struct inode *inode, struct fsverity_info *vi,
-		  const void *data, u64 data_pos, unsigned long max_ra_pages)
+		  const struct fsverity_pending_block *dblock,
+		  unsigned long max_ra_pages)
 {
+	const u64 data_pos = dblock->pos;
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
 	int level;
 	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	const u8 *want_hash;
@@ -113,23 +136,27 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
 	 */
 	u64 hidx = data_pos >> params->log_blocksize;
 
-	/* Up to 1 + FS_VERITY_MAX_LEVELS pages may be mapped at once */
-	BUILD_BUG_ON(1 + FS_VERITY_MAX_LEVELS > KM_MAX_IDX);
+	/*
+	 * Up to FS_VERITY_MAX_PENDING_DATA_BLOCKS + FS_VERITY_MAX_LEVELS pages
+	 * may be mapped at once.
+	 */
+	BUILD_BUG_ON(FS_VERITY_MAX_PENDING_DATA_BLOCKS +
+		     FS_VERITY_MAX_LEVELS > KM_MAX_IDX);
 
 	if (unlikely(data_pos >= inode->i_size)) {
 		/*
 		 * This can happen in the data page spanning EOF when the Merkle
 		 * tree block size is less than the page size.  The Merkle tree
 		 * doesn't cover data blocks fully past EOF.  But the entire
 		 * page spanning EOF can be visible to userspace via a mmap, and
 		 * any part past EOF should be all zeroes.  Therefore, we need
 		 * to verify that any data blocks fully past EOF are all zeroes.
 		 */
-		if (memchr_inv(data, 0, params->block_size)) {
+		if (memchr_inv(dblock->data, 0, params->block_size)) {
 			fsverity_err(inode,
 				     "FILE CORRUPTED!  Data past EOF is not zeroed");
 			return false;
 		}
 		return true;
@@ -219,54 +246,120 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		want_hash = _want_hash;
 		kunmap_local(haddr);
 		put_page(hpage);
 	}
 
-	/* Finally, verify the data block. */
-	if (fsverity_hash_block(params, inode, data, real_hash) != 0)
-		goto error;
-	if (memcmp(want_hash, real_hash, hsize) != 0)
+	/* Finally, verify the hash of the data block. */
+	if (memcmp(want_hash, dblock->real_hash, hsize) != 0)
 		goto corrupted;
 	return true;
 
 corrupted:
 	fsverity_err(inode,
 		     "FILE CORRUPTED! pos=%llu, level=%d, want_hash=%s:%*phN, real_hash=%s:%*phN",
 		     data_pos, level - 1,
 		     params->hash_alg->name, hsize, want_hash,
-		     params->hash_alg->name, hsize, real_hash);
+		     params->hash_alg->name, hsize,
+		     level == 0 ? dblock->real_hash : real_hash);
 error:
 	for (; level > 0; level--) {
 		kunmap_local(hblocks[level - 1].addr);
 		put_page(hblocks[level - 1].page);
 	}
 	return false;
 }
 
+static void
+fsverity_init_verification_context(struct fsverity_verification_context *ctx,
+				   struct inode *inode,
+				   unsigned long max_ra_pages)
+{
+	ctx->inode = inode;
+	ctx->vi = inode->i_verity_info;
+	ctx->max_ra_pages = max_ra_pages;
+	ctx->num_pending = 0;
+}
+
+static void
+fsverity_clear_pending_blocks(struct fsverity_verification_context *ctx)
+{
+	int i;
+
+	for (i = ctx->num_pending - 1; i >= 0; i--) {
+		kunmap_local(ctx->pending_blocks[i].data);
+		ctx->pending_blocks[i].data = NULL;
+	}
+	ctx->num_pending = 0;
+}
+
+static bool
+fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
+{
+	struct inode *inode = ctx->inode;
+	struct fsverity_info *vi = ctx->vi;
+	const struct merkle_tree_params *params = &vi->tree_params;
+	SHASH_DESC_ON_STACK(desc, params->hash_alg->tfm);
+	const u8 *data[FS_VERITY_MAX_PENDING_DATA_BLOCKS];
+	u8 *real_hashes[FS_VERITY_MAX_PENDING_DATA_BLOCKS];
+	int i;
+	int err;
+
+	if (ctx->num_pending == 0)
+		return true;
+
+	for (i = 0; i < ctx->num_pending; i++) {
+		data[i] = ctx->pending_blocks[i].data;
+		real_hashes[i] = ctx->pending_blocks[i].real_hash;
+	}
+
+	desc->tfm = params->hash_alg->tfm;
+	if (params->hashstate)
+		err = crypto_shash_import(desc, params->hashstate);
+	else
+		err = crypto_shash_init(desc);
+	if (err) {
+		fsverity_err(inode, "Error %d importing hash state", err);
+		return false;
+	}
+	err = crypto_shash_finup_mb(desc, data, params->block_size, real_hashes,
+				    ctx->num_pending);
+	if (err) {
+		fsverity_err(inode, "Error %d computing block hashes", err);
+		return false;
+	}
+
+	for (i = 0; i < ctx->num_pending; i++) {
+		if (!verify_data_block(inode, vi, &ctx->pending_blocks[i],
+				       ctx->max_ra_pages))
+			return false;
+	}
+
+	fsverity_clear_pending_blocks(ctx);
+	return true;
+}
+
 static bool
-verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
-		   unsigned long max_ra_pages)
+fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
+			 struct folio *data_folio, size_t len, size_t offset)
 {
-	struct inode *inode = data_folio->mapping->host;
-	struct fsverity_info *vi = inode->i_verity_info;
-	const unsigned int block_size = vi->tree_params.block_size;
+	struct fsverity_info *vi = ctx->vi;
+	const struct merkle_tree_params *params = &vi->tree_params;
+	const unsigned int block_size = params->block_size;
+	const int mb_max_msgs = params->hash_alg->mb_max_msgs;
 	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
 
 	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offset, block_size)))
 		return false;
 	if (WARN_ON_ONCE(!folio_test_locked(data_folio) ||
 			 folio_test_uptodate(data_folio)))
 		return false;
 	do {
-		void *data;
-		bool valid;
-
-		data = kmap_local_folio(data_folio, offset);
-		valid = verify_data_block(inode, vi, data, pos + offset,
-					  max_ra_pages);
-		kunmap_local(data);
-		if (!valid)
+		ctx->pending_blocks[ctx->num_pending].data =
+			kmap_local_folio(data_folio, offset);
+		ctx->pending_blocks[ctx->num_pending].pos = pos + offset;
+		if (++ctx->num_pending == mb_max_msgs &&
+		    !fsverity_verify_pending_blocks(ctx))
 			return false;
 		offset += block_size;
 		len -= block_size;
 	} while (len);
 	return true;
@@ -284,11 +377,19 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
  *
  * Return: %true if the data is valid, else %false.
  */
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
-	return verify_data_blocks(folio, len, offset, 0);
+	struct fsverity_verification_context ctx;
+
+	fsverity_init_verification_context(&ctx, folio->mapping->host, 0);
+
+	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
+	    fsverity_verify_pending_blocks(&ctx))
+		return true;
+	fsverity_clear_pending_blocks(&ctx);
+	return false;
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
 
 #ifdef CONFIG_BLOCK
 /**
@@ -305,10 +406,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * filesystems) must instead call fsverity_verify_page() directly on each page.
  * All filesystems must also call fsverity_verify_page() on holes.
  */
 void fsverity_verify_bio(struct bio *bio)
 {
+	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
+	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
 	unsigned long max_ra_pages = 0;
 
 	if (bio->bi_opf & REQ_RAHEAD) {
 		/*
@@ -321,17 +424,25 @@ void fsverity_verify_bio(struct bio *bio)
 		 * reduces the number of I/O requests made to the Merkle tree.
 		 */
 		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
+	fsverity_init_verification_context(&ctx, inode, max_ra_pages);
+
 	bio_for_each_folio_all(fi, bio) {
-		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
-					max_ra_pages)) {
-			bio->bi_status = BLK_STS_IOERR;
-			break;
-		}
+		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
+					      fi.offset))
+			goto ioerr;
 	}
+
+	if (!fsverity_verify_pending_blocks(&ctx))
+		goto ioerr;
+	return;
+
+ioerr:
+	fsverity_clear_pending_blocks(&ctx);
+	bio->bi_status = BLK_STS_IOERR;
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
 
 /**
-- 
2.45.2


