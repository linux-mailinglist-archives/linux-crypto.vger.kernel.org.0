Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C666BD3BC
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Mar 2023 16:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjCPPab (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Mar 2023 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCPP3V (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Mar 2023 11:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7E0E1912
        for <linux-crypto@vger.kernel.org>; Thu, 16 Mar 2023 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678980449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zb6mFnKCVLQu6xBmdV/ljtXgUzSvLJ/bZitog7Xho38=;
        b=amapRChA3kg2FMheVgKNQvnzJbg8BhsPGKCeVp+pW5TdlfQ303O35G63JKuo48O9sfRq7o
        BbJiwx/hvnWwVle2kUSDCNpIO1cpx3ElZFDuYx3i4f+9NJNONg988nzAnMfwYhEuIEePZK
        Euhm2uEnpqFsewFRwQG/92KMX7wXaIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-Wn_Xf5sGMh2vYcAXsHUQRQ-1; Thu, 16 Mar 2023 11:27:24 -0400
X-MC-Unique: Wn_Xf5sGMh2vYcAXsHUQRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4CD3857FB3;
        Thu, 16 Mar 2023 15:27:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8B7C140EBF4;
        Thu, 16 Mar 2023 15:27:21 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [RFC PATCH 23/28] algif: Remove hash_sendpage*()
Date:   Thu, 16 Mar 2023 15:26:13 +0000
Message-Id: <20230316152618.711970-24-dhowells@redhat.com>
In-Reply-To: <20230316152618.711970-1-dhowells@redhat.com>
References: <20230316152618.711970-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove hash_sendpage*() and use hash_sendmsg() as the latter seems to just
use the source pages directly anyway.

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
 crypto/algif_hash.c | 66 ---------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 1d017ec5c63c..52f5828a054a 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -129,58 +129,6 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err ?: copied;
 }
 
-static ssize_t hash_sendpage(struct socket *sock, struct page *page,
-			     int offset, size_t size, int flags)
-{
-	struct sock *sk = sock->sk;
-	struct alg_sock *ask = alg_sk(sk);
-	struct hash_ctx *ctx = ask->private;
-	int err;
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		flags |= MSG_MORE;
-
-	lock_sock(sk);
-	sg_init_table(ctx->sgl.sg, 1);
-	sg_set_page(ctx->sgl.sg, page, size, offset);
-
-	if (!(flags & MSG_MORE)) {
-		err = hash_alloc_result(sk, ctx);
-		if (err)
-			goto unlock;
-	} else if (!ctx->more)
-		hash_free_result(sk, ctx);
-
-	ahash_request_set_crypt(&ctx->req, ctx->sgl.sg, ctx->result, size);
-
-	if (!(flags & MSG_MORE)) {
-		if (ctx->more)
-			err = crypto_ahash_finup(&ctx->req);
-		else
-			err = crypto_ahash_digest(&ctx->req);
-	} else {
-		if (!ctx->more) {
-			err = crypto_ahash_init(&ctx->req);
-			err = crypto_wait_req(err, &ctx->wait);
-			if (err)
-				goto unlock;
-		}
-
-		err = crypto_ahash_update(&ctx->req);
-	}
-
-	err = crypto_wait_req(err, &ctx->wait);
-	if (err)
-		goto unlock;
-
-	ctx->more = flags & MSG_MORE;
-
-unlock:
-	release_sock(sk);
-
-	return err ?: size;
-}
-
 static int hash_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			int flags)
 {
@@ -285,7 +233,6 @@ static struct proto_ops algif_hash_ops = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg,
-	.sendpage	=	hash_sendpage,
 	.recvmsg	=	hash_recvmsg,
 	.accept		=	hash_accept,
 };
@@ -337,18 +284,6 @@ static int hash_sendmsg_nokey(struct socket *sock, struct msghdr *msg,
 	return hash_sendmsg(sock, msg, size);
 }
 
-static ssize_t hash_sendpage_nokey(struct socket *sock, struct page *page,
-				   int offset, size_t size, int flags)
-{
-	int err;
-
-	err = hash_check_key(sock);
-	if (err)
-		return err;
-
-	return hash_sendpage(sock, page, offset, size, flags);
-}
-
 static int hash_recvmsg_nokey(struct socket *sock, struct msghdr *msg,
 			      size_t ignored, int flags)
 {
@@ -387,7 +322,6 @@ static struct proto_ops algif_hash_ops_nokey = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg_nokey,
-	.sendpage	=	hash_sendpage_nokey,
 	.recvmsg	=	hash_recvmsg_nokey,
 	.accept		=	hash_accept_nokey,
 };

