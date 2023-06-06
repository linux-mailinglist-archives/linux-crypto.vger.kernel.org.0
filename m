Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E67243FC
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Jun 2023 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjFFNME (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Jun 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjFFNLV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Jun 2023 09:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DE198C
        for <linux-crypto@vger.kernel.org>; Tue,  6 Jun 2023 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686056992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnXJJhKEglI6aFkiEP4Z1FkQOeWzVq0l/3qLhbCSf1g=;
        b=MdUMZD1/3+IKaL1Ps0TEARIYBKxS/rM8BOd0x/tw+J0FkotkMD1dAlSSLhWRA2/lHs5k/9
        7C4INqCGd2FR9yCNf1Dgp/dkv2vqtZqPC6HRXN3UEvOkeh2oOEjTZGG3vM8knpk1HLFCt9
        vOc3xHCZ/nDG9SqiwZ64neMag8P/gMQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-KdbeL7cYOaapfNDCVE78pw-1; Tue, 06 Jun 2023 09:09:48 -0400
X-MC-Unique: KdbeL7cYOaapfNDCVE78pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 308C529AA2C4;
        Tue,  6 Jun 2023 13:09:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 356851121314;
        Tue,  6 Jun 2023 13:09:43 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 10/10] crypto: af_alg/hash: Support MSG_SPLICE_PAGES
Date:   Tue,  6 Jun 2023 14:08:56 +0100
Message-ID: <20230606130856.1970660-11-dhowells@redhat.com>
In-Reply-To: <20230606130856.1970660-1-dhowells@redhat.com>
References: <20230606130856.1970660-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Make AF_ALG sendmsg() support MSG_SPLICE_PAGES in the hashing code.  This
causes pages to be spliced from the source iterator if possible.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Fixed some checkpatch warnings.

 crypto/af_alg.c     |  11 +++--
 crypto/algif_hash.c | 100 +++++++++++++++++++++++++++-----------------
 2 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 3cf734835ccb..7d4b6016b83d 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -542,9 +542,14 @@ void af_alg_free_sg(struct af_alg_sgl *sgl)
 {
 	int i;
 
-	if (sgl->need_unpin)
-		for (i = 0; i < sgl->sgt.nents; i++)
-			unpin_user_page(sg_page(&sgl->sgt.sgl[i]));
+	if (sgl->sgt.sgl) {
+		if (sgl->need_unpin)
+			for (i = 0; i < sgl->sgt.nents; i++)
+				unpin_user_page(sg_page(&sgl->sgt.sgl[i]));
+		if (sgl->sgt.sgl != sgl->sgl)
+			kvfree(sgl->sgt.sgl);
+		sgl->sgt.sgl = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(af_alg_free_sg);
 
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 16c69c4b9c62..1a2d80c6c91a 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -63,78 +63,102 @@ static void hash_free_result(struct sock *sk, struct hash_ctx *ctx)
 static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 			size_t ignored)
 {
-	int limit = ALG_MAX_PAGES * PAGE_SIZE;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct hash_ctx *ctx = ask->private;
-	long copied = 0;
+	ssize_t copied = 0;
+	size_t len, max_pages, npages;
+	bool continuing = ctx->more, need_init = false;
 	int err;
 
-	if (limit > sk->sk_sndbuf)
-		limit = sk->sk_sndbuf;
+	max_pages = min_t(size_t, ALG_MAX_PAGES,
+			  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
 
 	lock_sock(sk);
-	if (!ctx->more) {
+	if (!continuing) {
 		if ((msg->msg_flags & MSG_MORE))
 			hash_free_result(sk, ctx);
-
-		err = crypto_wait_req(crypto_ahash_init(&ctx->req), &ctx->wait);
-		if (err)
-			goto unlock;
+		need_init = true;
 	}
 
 	ctx->more = false;
 
 	while (msg_data_left(msg)) {
-		int len = msg_data_left(msg);
-
-		if (len > limit)
-			len = limit;
-
 		ctx->sgl.sgt.sgl = ctx->sgl.sgl;
 		ctx->sgl.sgt.nents = 0;
 		ctx->sgl.sgt.orig_nents = 0;
 
-		len = extract_iter_to_sg(&msg->msg_iter, len, &ctx->sgl.sgt,
-					 ALG_MAX_PAGES, 0);
-		if (len < 0) {
-			err = copied ? 0 : len;
-			goto unlock;
+		err = -EIO;
+		npages = iov_iter_npages(&msg->msg_iter, max_pages);
+		if (npages == 0)
+			goto unlock_free;
+
+		if (npages > ARRAY_SIZE(ctx->sgl.sgl)) {
+			err = -ENOMEM;
+			ctx->sgl.sgt.sgl =
+				kvmalloc(array_size(npages,
+						    sizeof(*ctx->sgl.sgt.sgl)),
+					 GFP_KERNEL);
+			if (!ctx->sgl.sgt.sgl)
+				goto unlock_free;
 		}
-		sg_mark_end(ctx->sgl.sgt.sgl + ctx->sgl.sgt.nents);
+		sg_init_table(ctx->sgl.sgl, npages);
 
 		ctx->sgl.need_unpin = iov_iter_extract_will_pin(&msg->msg_iter);
 
-		ahash_request_set_crypt(&ctx->req, ctx->sgl.sgt.sgl, NULL, len);
+		err = extract_iter_to_sg(&msg->msg_iter, LONG_MAX,
+					 &ctx->sgl.sgt, npages, 0);
+		if (err < 0)
+			goto unlock_free;
+		len = err;
+		sg_mark_end(ctx->sgl.sgt.sgl + ctx->sgl.sgt.nents - 1);
 
-		err = crypto_wait_req(crypto_ahash_update(&ctx->req),
-				      &ctx->wait);
-		af_alg_free_sg(&ctx->sgl);
-		if (err) {
-			iov_iter_revert(&msg->msg_iter, len);
-			goto unlock;
+		if (!msg_data_left(msg)) {
+			err = hash_alloc_result(sk, ctx);
+			if (err)
+				goto unlock_free;
 		}
 
-		copied += len;
-	}
+		ahash_request_set_crypt(&ctx->req, ctx->sgl.sgt.sgl,
+					ctx->result, len);
 
-	err = 0;
+		if (!msg_data_left(msg) && !continuing &&
+		    !(msg->msg_flags & MSG_MORE)) {
+			err = crypto_ahash_digest(&ctx->req);
+		} else {
+			if (need_init) {
+				err = crypto_wait_req(
+					crypto_ahash_init(&ctx->req),
+					&ctx->wait);
+				if (err)
+					goto unlock_free;
+				need_init = false;
+			}
+
+			if (msg_data_left(msg) || (msg->msg_flags & MSG_MORE))
+				err = crypto_ahash_update(&ctx->req);
+			else
+				err = crypto_ahash_finup(&ctx->req);
+			continuing = true;
+		}
 
-	ctx->more = msg->msg_flags & MSG_MORE;
-	if (!ctx->more) {
-		err = hash_alloc_result(sk, ctx);
+		err = crypto_wait_req(err, &ctx->wait);
 		if (err)
-			goto unlock;
+			goto unlock_free;
 
-		ahash_request_set_crypt(&ctx->req, NULL, ctx->result, 0);
-		err = crypto_wait_req(crypto_ahash_final(&ctx->req),
-				      &ctx->wait);
+		copied += len;
+		af_alg_free_sg(&ctx->sgl);
 	}
 
+	ctx->more = msg->msg_flags & MSG_MORE;
+	err = 0;
 unlock:
 	release_sock(sk);
+	return copied ?: err;
 
-	return err ?: copied;
+unlock_free:
+	af_alg_free_sg(&ctx->sgl);
+	goto unlock;
 }
 
 static ssize_t hash_sendpage(struct socket *sock, struct page *page,

