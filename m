Return-Path: <linux-crypto+bounces-355-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1377FB444
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A154A1C20D22
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156719BAD
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AEF5
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 00:25:46 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r7tPY-004Jtw-Sw; Tue, 28 Nov 2023 16:25:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Nov 2023 16:25:49 +0800
Date: Tue, 28 Nov 2023 16:25:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: af_alg - Disallow multiple in-flight AIO requests
Message-ID: <ZWWkDZRR33ypncn7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Having multiple in-flight AIO requests results in unpredictable
output because they all share the same IV.  Fix this by only allowing
one request at a time.

Fixes: 83094e5e9e49 ("crypto: af_alg - add async support to algif_aead")
Fixes: a596999b7ddf ("crypto: algif - change algif_skcipher to be asynchronous")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/af_alg.c         | 14 +++++++++++++-
 include/crypto/if_alg.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ea6fb8e89d06..68cc9290cabe 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1116,9 +1116,13 @@ EXPORT_SYMBOL_GPL(af_alg_sendmsg);
 void af_alg_free_resources(struct af_alg_async_req *areq)
 {
 	struct sock *sk = areq->sk;
+	struct af_alg_ctx *ctx;
 
 	af_alg_free_areq_sgls(areq);
 	sock_kfree_s(sk, areq, areq->areqlen);
+
+	ctx = alg_sk(sk)->private;
+	ctx->inflight = false;
 }
 EXPORT_SYMBOL_GPL(af_alg_free_resources);
 
@@ -1188,11 +1192,19 @@ EXPORT_SYMBOL_GPL(af_alg_poll);
 struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 					   unsigned int areqlen)
 {
-	struct af_alg_async_req *areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
+	struct af_alg_ctx *ctx = alg_sk(sk)->private;
+	struct af_alg_async_req *areq;
 
+	/* Only one AIO request can be in flight. */
+	if (ctx->inflight)
+		return ERR_PTR(-EBUSY);
+
+	areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
+	ctx->inflight = true;
+
 	areq->areqlen = areqlen;
 	areq->sk = sk;
 	areq->first_rsgl.sgl.sgt.sgl = areq->first_rsgl.sgl.sgl;
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index ef8ce86b1f78..08b803a4fcde 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -136,6 +136,7 @@ struct af_alg_async_req {
  *			recvmsg is invoked.
  * @init:		True if metadata has been sent.
  * @len:		Length of memory allocated for this data structure.
+ * @inflight:		Non-zero when AIO requests are in flight.
  */
 struct af_alg_ctx {
 	struct list_head tsgl_list;
@@ -154,6 +155,8 @@ struct af_alg_ctx {
 	bool init;
 
 	unsigned int len;
+
+	unsigned int inflight;
 };
 
 int af_alg_register_type(const struct af_alg_type *type);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

