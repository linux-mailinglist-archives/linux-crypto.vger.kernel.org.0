Return-Path: <linux-crypto+bounces-12701-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D608AA9C44
	for <lists+linux-crypto@lfdr.de>; Mon,  5 May 2025 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD08F3ADB54
	for <lists+linux-crypto@lfdr.de>; Mon,  5 May 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6B26F440;
	Mon,  5 May 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD62nloZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A04A1D
	for <linux-crypto@vger.kernel.org>; Mon,  5 May 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472297; cv=none; b=t1cHWi1re1zFYs7e3x30c40OC6vw+3iHGswRf3Ygxq5Q6jAYGivcBSthda6e9BbFao4S1PaskC9AjuDQyfT0u/GpWRqkwMkY/COH78+oPraOCb/FcggsnqzUTrjga92t2CUUvnbXSKtIWKQnHCqVOtSkbNPoMd9UROolNqL0kMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472297; c=relaxed/simple;
	bh=W9GlfLupJ8un/8a0mB6DKsmxe5aVS/5mqb75tv8VGI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ructC4uxDYrW3YWYIyledHYxUhirfllPMgaXPHXnK6jWyE/h1Ki2HjwsjUFcTDGhwbYRPDbJGe5gjHjzgBUWj9x6U3Yn7QzjrxutCP+Jm5AAfrWMlRDyjwcylTlw7CCjg+wNN+vR2Q9xE6dCJmeyQIo79/42FPkCZqHvvzxMbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD62nloZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FCC4CEEE
	for <linux-crypto@vger.kernel.org>; Mon,  5 May 2025 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746472296;
	bh=W9GlfLupJ8un/8a0mB6DKsmxe5aVS/5mqb75tv8VGI8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LD62nloZTuOi3cJ4GmNB+ylbY7aH+Pzg8iUPlpvWElGO8ewPtYB/FU0XddK/kv0JD
	 Wq7Z06Ys1j/cI7+Q+hFOqUlgmCNbG+c3mtE7gdV5sSSi5r8N8nAcBLzW33MJizObfp
	 33Jv+yk3/CIb/2sYG9Vple/l55oKZzNEOnyRNuYOWyW+Mpvd7xQ2ztMegsqreFQG+A
	 LY/99YM8/O6I7ci/Sobs3wvGyxnJvnqNr4jFWnPKsdJl/n6lUcidCOj+pqJgFGOVaY
	 9y3o4dlUhgMEvvlkojQyCb1hTwWT5DNAEJMqVk/3x1BdejNwsHkneDlcmt3/IsmjSx
	 VdM0w+D4KjJPw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 1/8] crypto: algif_aead - use memcpy_sglist() instead of null skcipher
Date: Mon,  5 May 2025 12:10:38 -0700
Message-ID: <20250505191045.763835-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505191045.763835-1-ebiggers@kernel.org>
References: <20250505191045.763835-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

For copying data between two scatterlists, just use memcpy_sglist()
instead of the so-called "null skcipher".  This is much simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig      |   1 -
 crypto/algif_aead.c | 101 ++++++++------------------------------------
 2 files changed, 18 insertions(+), 84 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7bfad077f308..551eeeab3a0a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1390,11 +1390,10 @@ config CRYPTO_USER_API_RNG_CAVP
 config CRYPTO_USER_API_AEAD
 	tristate "AEAD cipher algorithms"
 	depends on NET
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
-	select CRYPTO_NULL
 	select CRYPTO_USER_API
 	help
 	  Enable the userspace interface for AEAD cipher algorithms.
 
 	  See Documentation/crypto/userspace-if.rst and
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 7d58cbbce4af..79b016a899a1 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -25,32 +25,25 @@
 
 #include <crypto/internal/aead.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/if_alg.h>
 #include <crypto/skcipher.h>
-#include <crypto/null.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <net/sock.h>
 
-struct aead_tfm {
-	struct crypto_aead *aead;
-	struct crypto_sync_skcipher *null_tfm;
-};
-
 static inline bool aead_sufficient_data(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
 	struct af_alg_ctx *ctx = ask->private;
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int as = crypto_aead_authsize(tfm);
 
 	/*
 	 * The minimum amount of memory needed for an AEAD cipher is
 	 * the AAD and in case of decryption the tag.
@@ -62,42 +55,25 @@ static int aead_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int ivsize = crypto_aead_ivsize(tfm);
 
 	return af_alg_sendmsg(sock, msg, size, ivsize);
 }
 
-static int crypto_aead_copy_sgl(struct crypto_sync_skcipher *null_tfm,
-				struct scatterlist *src,
-				struct scatterlist *dst, unsigned int len)
-{
-	SYNC_SKCIPHER_REQUEST_ON_STACK(skreq, null_tfm);
-
-	skcipher_request_set_sync_tfm(skreq, null_tfm);
-	skcipher_request_set_callback(skreq, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-	skcipher_request_set_crypt(skreq, src, dst, len, NULL);
-
-	return crypto_skcipher_encrypt(skreq);
-}
-
 static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 			 size_t ignored, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
 	struct af_alg_ctx *ctx = ask->private;
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
-	struct crypto_sync_skcipher *null_tfm = aeadc->null_tfm;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int i, as = crypto_aead_authsize(tfm);
 	struct af_alg_async_req *areq;
 	struct af_alg_tsgl *tsgl, *tmp;
 	struct scatterlist *rsgl_src, *tsgl_src = NULL;
 	int err = 0;
@@ -221,15 +197,12 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 		 *	    |	   |
 		 *	    | copy |
 		 *	    v	   v
 		 * RX SGL: AAD || PT || Tag
 		 */
-		err = crypto_aead_copy_sgl(null_tfm, tsgl_src,
-					   areq->first_rsgl.sgl.sgt.sgl,
-					   processed);
-		if (err)
-			goto free;
+		memcpy_sglist(areq->first_rsgl.sgl.sgt.sgl, tsgl_src,
+			      processed);
 		af_alg_pull_tsgl(sk, processed, NULL, 0);
 	} else {
 		/*
 		 * Decryption operation - To achieve an in-place cipher
 		 * operation, the following  SGL structure is used:
@@ -239,16 +212,12 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 		 *	    | copy |	 | Create SGL link.
 		 *	    v	   v	 |
 		 * RX SGL: AAD || CT ----+
 		 */
 
-		 /* Copy AAD || CT to RX SGL buffer for in-place operation. */
-		err = crypto_aead_copy_sgl(null_tfm, tsgl_src,
-					   areq->first_rsgl.sgl.sgt.sgl,
-					   outlen);
-		if (err)
-			goto free;
+		/* Copy AAD || CT to RX SGL buffer for in-place operation. */
+		memcpy_sglist(areq->first_rsgl.sgl.sgt.sgl, tsgl_src, outlen);
 
 		/* Create TX SGL for tag and chain it to RX SGL. */
 		areq->tsgl_entries = af_alg_count_tsgl(sk, processed,
 						       processed - as);
 		if (!areq->tsgl_entries)
@@ -377,11 +346,11 @@ static struct proto_ops algif_aead_ops = {
 static int aead_check_key(struct socket *sock)
 {
 	int err = 0;
 	struct sock *psk;
 	struct alg_sock *pask;
-	struct aead_tfm *tfm;
+	struct crypto_aead *tfm;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 
 	lock_sock(sk);
 	if (!atomic_read(&ask->nokey_refcnt))
@@ -391,11 +360,11 @@ static int aead_check_key(struct socket *sock)
 	pask = alg_sk(ask->parent);
 	tfm = pask->private;
 
 	err = -ENOKEY;
 	lock_sock_nested(psk, SINGLE_DEPTH_NESTING);
-	if (crypto_aead_get_flags(tfm->aead) & CRYPTO_TFM_NEED_KEY)
+	if (crypto_aead_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		goto unlock;
 
 	atomic_dec(&pask->nokey_refcnt);
 	atomic_set(&ask->nokey_refcnt, 0);
 
@@ -452,68 +421,35 @@ static struct proto_ops algif_aead_ops_nokey = {
 	.poll		=	af_alg_poll,
 };
 
 static void *aead_bind(const char *name, u32 type, u32 mask)
 {
-	struct aead_tfm *tfm;
-	struct crypto_aead *aead;
-	struct crypto_sync_skcipher *null_tfm;
-
-	tfm = kzalloc(sizeof(*tfm), GFP_KERNEL);
-	if (!tfm)
-		return ERR_PTR(-ENOMEM);
-
-	aead = crypto_alloc_aead(name, type, mask);
-	if (IS_ERR(aead)) {
-		kfree(tfm);
-		return ERR_CAST(aead);
-	}
-
-	null_tfm = crypto_get_default_null_skcipher();
-	if (IS_ERR(null_tfm)) {
-		crypto_free_aead(aead);
-		kfree(tfm);
-		return ERR_CAST(null_tfm);
-	}
-
-	tfm->aead = aead;
-	tfm->null_tfm = null_tfm;
-
-	return tfm;
+	return crypto_alloc_aead(name, type, mask);
 }
 
 static void aead_release(void *private)
 {
-	struct aead_tfm *tfm = private;
-
-	crypto_free_aead(tfm->aead);
-	crypto_put_default_null_skcipher();
-	kfree(tfm);
+	crypto_free_aead(private);
 }
 
 static int aead_setauthsize(void *private, unsigned int authsize)
 {
-	struct aead_tfm *tfm = private;
-
-	return crypto_aead_setauthsize(tfm->aead, authsize);
+	return crypto_aead_setauthsize(private, authsize);
 }
 
 static int aead_setkey(void *private, const u8 *key, unsigned int keylen)
 {
-	struct aead_tfm *tfm = private;
-
-	return crypto_aead_setkey(tfm->aead, key, keylen);
+	return crypto_aead_setkey(private, key, keylen);
 }
 
 static void aead_sock_destruct(struct sock *sk)
 {
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
 	struct sock *psk = ask->parent;
 	struct alg_sock *pask = alg_sk(psk);
-	struct aead_tfm *aeadc = pask->private;
-	struct crypto_aead *tfm = aeadc->aead;
+	struct crypto_aead *tfm = pask->private;
 	unsigned int ivlen = crypto_aead_ivsize(tfm);
 
 	af_alg_pull_tsgl(sk, ctx->used, NULL, 0);
 	sock_kzfree_s(sk, ctx->iv, ivlen);
 	sock_kfree_s(sk, ctx, ctx->len);
@@ -522,14 +458,13 @@ static void aead_sock_destruct(struct sock *sk)
 
 static int aead_accept_parent_nokey(void *private, struct sock *sk)
 {
 	struct af_alg_ctx *ctx;
 	struct alg_sock *ask = alg_sk(sk);
-	struct aead_tfm *tfm = private;
-	struct crypto_aead *aead = tfm->aead;
+	struct crypto_aead *tfm = private;
 	unsigned int len = sizeof(*ctx);
-	unsigned int ivlen = crypto_aead_ivsize(aead);
+	unsigned int ivlen = crypto_aead_ivsize(tfm);
 
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	memset(ctx, 0, len);
@@ -552,13 +487,13 @@ static int aead_accept_parent_nokey(void *private, struct sock *sk)
 	return 0;
 }
 
 static int aead_accept_parent(void *private, struct sock *sk)
 {
-	struct aead_tfm *tfm = private;
+	struct crypto_aead *tfm = private;
 
-	if (crypto_aead_get_flags(tfm->aead) & CRYPTO_TFM_NEED_KEY)
+	if (crypto_aead_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
 
 	return aead_accept_parent_nokey(private, sk);
 }
 
-- 
2.49.0


