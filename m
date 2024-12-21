Return-Path: <linux-crypto+bounces-8690-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD09F9F6B
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 10:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4497C18913F6
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11451EF0B3;
	Sat, 21 Dec 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFCckQQ7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31A1EC4C5
	for <linux-crypto@vger.kernel.org>; Sat, 21 Dec 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772291; cv=none; b=krHgG6qVhGSoG+cAv+dL+j6W500uu6IoNiwtYpN+hKDl6xk2pNM4L/s2wvEghd0STsc0c1Nv0d+h6XSQncSnK2NAniMb/oWElQdbHfyQAqkQ390p8aQoxjorevFH+yPeqKXuGuUQ77Rc12g9FGtOvU9AE5pPqedxvlrA8DISa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772291; c=relaxed/simple;
	bh=5+ZF0ImlbQo//JHYBtR4hUhu8cd/k3zSglYQL5MyI1I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sco5Gn8iKljj2MD5HxaWCSxEeW8/QxIuCNxfVjWDjUPf0PFK25QdTy0g81MlkSsBmj9MOtR7DD1Bg+PO/AVxKOq3M+yjg6hJEYtCIDbxMzXoeH2Yf3o4yQ6O9vhcs5q6EPTYyHwnGNaKOYtYtpkAEjEBziB06B6BE9hJo8ON9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFCckQQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C295C4CED6
	for <linux-crypto@vger.kernel.org>; Sat, 21 Dec 2024 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734772291;
	bh=5+ZF0ImlbQo//JHYBtR4hUhu8cd/k3zSglYQL5MyI1I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pFCckQQ7ElKnHMLRLinhBSTIo7u/ony9u5lA2Mwhp8qL+NEccxrmmXHqzBUJu8bJQ
	 cvaXDYPTw3q/vXY1iFkukIB++EcD5nikltPboXR4KsI9Q2zjYF/RgyYQC1T0GwT5yw
	 vyK63YyfuYoEtCZrMS/ZQmqGIzloxuK+goXGSztO4wzm4hxULdTmKJU8ncLNIZP6vb
	 V36sNgr7AHm2Zt5CxMa1L944nAvLiFk9LVckFcs9SK4zrkplyIhlP6fc+2RAHV1pte
	 LmYDEylF+SRNTBobOsxvJ/aB6XfjoiuV0roWnw+4Ijv/nWjhPYiSAWnEf/xjnepupg
	 UcicGCu8+R5Ng==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 01/29] crypto: skcipher - document skcipher_walk_done() and rename some vars
Date: Sat, 21 Dec 2024 01:10:28 -0800
Message-ID: <20241221091056.282098-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221091056.282098-1-ebiggers@kernel.org>
References: <20241221091056.282098-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

skcipher_walk_done() has an unusual calling convention, and some of its
local variables have unclear names.  Document it and rename variables to
make it a bit clearer what is going on.  No change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/skcipher.c                  | 50 ++++++++++++++++++++----------
 include/crypto/internal/skcipher.h |  2 +-
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index d5fe0eca3826..8749c44f98a2 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -87,21 +87,39 @@ static int skcipher_done_slow(struct skcipher_walk *walk, unsigned int bsize)
 	addr = skcipher_get_spot(addr, bsize);
 	scatterwalk_copychunks(addr, &walk->out, bsize, 1);
 	return 0;
 }
 
-int skcipher_walk_done(struct skcipher_walk *walk, int err)
+/**
+ * skcipher_walk_done() - finish one step of a skcipher_walk
+ * @walk: the skcipher_walk
+ * @res: number of bytes *not* processed (>= 0) from walk->nbytes,
+ *	 or a -errno value to terminate the walk due to an error
+ *
+ * This function cleans up after one step of walking through the source and
+ * destination scatterlists, and advances to the next step if applicable.
+ * walk->nbytes is set to the number of bytes available in the next step,
+ * walk->total is set to the new total number of bytes remaining, and
+ * walk->{src,dst}.virt.addr is set to the next pair of data pointers.  If there
+ * is no more data, or if an error occurred (i.e. -errno return), then
+ * walk->nbytes and walk->total are set to 0 and all resources owned by the
+ * skcipher_walk are freed.
+ *
+ * Return: 0 or a -errno value.  If @res was a -errno value then it will be
+ *	   returned, but other errors may occur too.
+ */
+int skcipher_walk_done(struct skcipher_walk *walk, int res)
 {
-	unsigned int n = walk->nbytes;
-	unsigned int nbytes = 0;
+	unsigned int n = walk->nbytes; /* num bytes processed this step */
+	unsigned int total = 0; /* new total remaining */
 
 	if (!n)
 		goto finish;
 
-	if (likely(err >= 0)) {
-		n -= err;
-		nbytes = walk->total - n;
+	if (likely(res >= 0)) {
+		n -= res; /* subtract num bytes *not* processed */
+		total = walk->total - n;
 	}
 
 	if (likely(!(walk->flags & (SKCIPHER_WALK_SLOW |
 				    SKCIPHER_WALK_COPY |
 				    SKCIPHER_WALK_DIFF)))) {
@@ -113,35 +131,35 @@ int skcipher_walk_done(struct skcipher_walk *walk, int err)
 	} else if (walk->flags & SKCIPHER_WALK_COPY) {
 		skcipher_map_dst(walk);
 		memcpy(walk->dst.virt.addr, walk->page, n);
 		skcipher_unmap_dst(walk);
 	} else if (unlikely(walk->flags & SKCIPHER_WALK_SLOW)) {
-		if (err > 0) {
+		if (res > 0) {
 			/*
 			 * Didn't process all bytes.  Either the algorithm is
 			 * broken, or this was the last step and it turned out
 			 * the message wasn't evenly divisible into blocks but
 			 * the algorithm requires it.
 			 */
-			err = -EINVAL;
-			nbytes = 0;
+			res = -EINVAL;
+			total = 0;
 		} else
 			n = skcipher_done_slow(walk, n);
 	}
 
-	if (err > 0)
-		err = 0;
+	if (res > 0)
+		res = 0;
 
-	walk->total = nbytes;
+	walk->total = total;
 	walk->nbytes = 0;
 
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
+	scatterwalk_done(&walk->in, 0, total);
+	scatterwalk_done(&walk->out, 1, total);
 
-	if (nbytes) {
+	if (total) {
 		crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
 			     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
 		return skcipher_walk_next(walk);
 	}
 
@@ -156,11 +174,11 @@ int skcipher_walk_done(struct skcipher_walk *walk, int err)
 		kfree(walk->buffer);
 	if (walk->page)
 		free_page((unsigned long)walk->page);
 
 out:
-	return err;
+	return res;
 }
 EXPORT_SYMBOL_GPL(skcipher_walk_done);
 
 static int skcipher_next_slow(struct skcipher_walk *walk, unsigned int bsize)
 {
diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index 08d1e8c63afc..4f49621d3eb6 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -194,11 +194,11 @@ void crypto_unregister_lskcipher(struct lskcipher_alg *alg);
 int crypto_register_lskciphers(struct lskcipher_alg *algs, int count);
 void crypto_unregister_lskciphers(struct lskcipher_alg *algs, int count);
 int lskcipher_register_instance(struct crypto_template *tmpl,
 				struct lskcipher_instance *inst);
 
-int skcipher_walk_done(struct skcipher_walk *walk, int err);
+int skcipher_walk_done(struct skcipher_walk *walk, int res);
 int skcipher_walk_virt(struct skcipher_walk *walk,
 		       struct skcipher_request *req,
 		       bool atomic);
 int skcipher_walk_aead_encrypt(struct skcipher_walk *walk,
 			       struct aead_request *req, bool atomic);
-- 
2.47.1


