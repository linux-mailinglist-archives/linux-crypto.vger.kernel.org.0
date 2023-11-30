Return-Path: <linux-crypto+bounces-408-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772D7FED22
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F874B20AC3
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161593C075
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA85171E
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 01:56:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8dmL-005FBE-Kr; Thu, 30 Nov 2023 17:56:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 17:56:26 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 17:56:26 +0800
Subject: [v2 PATCH 4/4] crypto: algif_skcipher - Fix stream cipher chaining
References: <ZWhcDoBp8wPiWiYa@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Message-Id: <E1r8dmL-005FBE-Kr@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Unlike algif_aead which is always issued in one go (thus limiting
the maximum size of the request), algif_skcipher has always allowed
unlimited input data by cutting them up as necessary and feeding
the fragments to the underlying algorithm one at a time.

However, because of deficiencies in the API, this has been broken
for most stream ciphers such as arc4 or chacha.  This is because
they have an internal state in addition to the IV that must be
preserved in order to continue processing.

Fix this by using the new skcipher state API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/algif_skcipher.c |   71 +++++++++++++++++++++++++++++++++++++++++++++---
 include/crypto/if_alg.h |    2 +
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 9ada9b741af8..59dcc6fc74a2 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -47,6 +47,52 @@ static int skcipher_sendmsg(struct socket *sock, struct msghdr *msg,
 	return af_alg_sendmsg(sock, msg, size, ivsize);
 }
 
+static int algif_skcipher_export(struct sock *sk, struct skcipher_request *req)
+{
+	struct alg_sock *ask = alg_sk(sk);
+	struct crypto_skcipher *tfm;
+	struct af_alg_ctx *ctx;
+	struct alg_sock *pask;
+	unsigned statesize;
+	struct sock *psk;
+	int err;
+
+	if (!(req->base.flags & CRYPTO_SKCIPHER_REQ_NOTFINAL))
+		return 0;
+
+	ctx = ask->private;
+	psk = ask->parent;
+	pask = alg_sk(psk);
+	tfm = pask->private;
+
+	statesize = crypto_skcipher_statesize(tfm);
+	ctx->state = sock_kmalloc(sk, statesize, GFP_ATOMIC);
+	if (!ctx->state)
+		return -ENOMEM;
+
+	err = crypto_skcipher_export(req, ctx->state);
+	if (err) {
+		sock_kzfree_s(sk, ctx->state, statesize);
+		ctx->state = NULL;
+	}
+
+	return err;
+}
+
+static void algif_skcipher_done(void *data, int err)
+{
+	struct af_alg_async_req *areq = data;
+	struct sock *sk = areq->sk;
+
+	if (err)
+		goto out;
+
+	err = algif_skcipher_export(sk, &areq->cra_u.skcipher_req);
+
+out:
+	af_alg_async_cb(data, err);
+}
+
 static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 			     size_t ignored, int flags)
 {
@@ -58,6 +104,7 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct crypto_skcipher *tfm = pask->private;
 	unsigned int bs = crypto_skcipher_chunksize(tfm);
 	struct af_alg_async_req *areq;
+	unsigned cflags = 0;
 	int err = 0;
 	size_t len = 0;
 
@@ -82,8 +129,10 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * If more buffers are to be expected to be processed, process only
 	 * full block size buffers.
 	 */
-	if (ctx->more || len < ctx->used)
+	if (ctx->more || len < ctx->used) {
 		len -= len % bs;
+		cflags |= CRYPTO_SKCIPHER_REQ_NOTFINAL;
+	}
 
 	/*
 	 * Create a per request TX SGL for this request which tracks the
@@ -107,6 +156,16 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	skcipher_request_set_crypt(&areq->cra_u.skcipher_req, areq->tsgl,
 				   areq->first_rsgl.sgl.sgt.sgl, len, ctx->iv);
 
+	if (ctx->state) {
+		err = crypto_skcipher_import(&areq->cra_u.skcipher_req,
+					     ctx->state);
+		sock_kzfree_s(sk, ctx->state, crypto_skcipher_statesize(tfm));
+		ctx->state = NULL;
+		if (err)
+			goto free;
+		cflags |= CRYPTO_SKCIPHER_REQ_CONT;
+	}
+
 	if (msg->msg_iocb && !is_sync_kiocb(msg->msg_iocb)) {
 		/* AIO operation */
 		sock_hold(sk);
@@ -116,8 +175,9 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 		areq->outlen = len;
 
 		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
+					      cflags |
 					      CRYPTO_TFM_REQ_MAY_SLEEP,
-					      af_alg_async_cb, areq);
+					      algif_skcipher_done, areq);
 		err = ctx->enc ?
 			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
 			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req);
@@ -130,6 +190,7 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	} else {
 		/* Synchronous operation */
 		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
+					      cflags |
 					      CRYPTO_TFM_REQ_MAY_SLEEP |
 					      CRYPTO_TFM_REQ_MAY_BACKLOG,
 					      crypto_req_done, &ctx->wait);
@@ -137,8 +198,11 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
 			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req),
 						 &ctx->wait);
-	}
 
+		if (!err)
+			err = algif_skcipher_export(
+				sk, &areq->cra_u.skcipher_req);
+	}
 
 free:
 	af_alg_free_resources(areq);
@@ -301,6 +365,7 @@ static void skcipher_sock_destruct(struct sock *sk)
 
 	af_alg_pull_tsgl(sk, ctx->used, NULL, 0);
 	sock_kzfree_s(sk, ctx->iv, crypto_skcipher_ivsize(tfm));
+	sock_kzfree_s(sk, ctx->state, crypto_skcipher_statesize(tfm));
 	sock_kfree_s(sk, ctx, ctx->len);
 	af_alg_release_parent(sk);
 }
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 08b803a4fcde..78ecaf5db04c 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -121,6 +121,7 @@ struct af_alg_async_req {
  *
  * @tsgl_list:		Link to TX SGL
  * @iv:			IV for cipher operation
+ * @state:		Existing state for continuing operation
  * @aead_assoclen:	Length of AAD for AEAD cipher operations
  * @completion:		Work queue for synchronous operation
  * @used:		TX bytes sent to kernel. This variable is used to
@@ -142,6 +143,7 @@ struct af_alg_ctx {
 	struct list_head tsgl_list;
 
 	void *iv;
+	void *state;
 	size_t aead_assoclen;
 
 	struct crypto_wait wait;

