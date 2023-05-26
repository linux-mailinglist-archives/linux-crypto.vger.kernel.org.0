Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3246712868
	for <lists+linux-crypto@lfdr.de>; Fri, 26 May 2023 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbjEZOc5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 May 2023 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbjEZOcX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 May 2023 10:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31321B3
        for <linux-crypto@vger.kernel.org>; Fri, 26 May 2023 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685111483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPGukvQXP4Tai7PUqcbnIswr++Y11hB7rT1QDpn/afo=;
        b=ejsUWzVdA+Eh3BkBKP8dNsDniUl9fmNjdm5uotBH7KH5j0X70QRqrCIjJV+cc6/9/fQUNU
        kyXZnLAccMQ9NM2iylDtoXuFapTlvKQ7XxyiIBmyTc69k6jbeZS38JG/DV7p2QVcf6YZRF
        PDYSiIPf5cxNBGmx5v9rpwuWZJw4vAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-Ivy8e833NRWSYrtoVTgS-g-1; Fri, 26 May 2023 10:31:21 -0400
X-MC-Unique: Ivy8e833NRWSYrtoVTgS-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A6DD811E92;
        Fri, 26 May 2023 14:31:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D0C140E961;
        Fri, 26 May 2023 14:31:17 +0000 (UTC)
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
Subject: [PATCH net-next 3/8] crypto: af_alg: Pin pages rather than ref'ing if appropriate
Date:   Fri, 26 May 2023 15:30:59 +0100
Message-Id: <20230526143104.882842-4-dhowells@redhat.com>
In-Reply-To: <20230526143104.882842-1-dhowells@redhat.com>
References: <20230526143104.882842-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Convert AF_ALG to use iov_iter_extract_pages() instead of
iov_iter_get_pages().  This will pin pages or leave them unaltered rather
than getting a ref on them as appropriate to the iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

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
 crypto/af_alg.c         | 10 +++++++---
 include/crypto/if_alg.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 5f7252a5b7b4..7caff10df643 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -533,14 +533,17 @@ static const struct net_proto_family alg_family = {
 
 int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len)
 {
+	struct page **pages = sgl->pages;
 	size_t off;
 	ssize_t n;
 	int npages, i;
 
-	n = iov_iter_get_pages2(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
+	n = iov_iter_extract_pages(iter, &pages, len, ALG_MAX_PAGES, 0, &off);
 	if (n < 0)
 		return n;
 
+	sgl->need_unpin = iov_iter_extract_will_pin(iter);
+
 	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);
 	if (WARN_ON(npages == 0))
 		return -EINVAL;
@@ -573,8 +576,9 @@ void af_alg_free_sg(struct af_alg_sgl *sgl)
 {
 	int i;
 
-	for (i = 0; i < sgl->npages; i++)
-		put_page(sgl->pages[i]);
+	if (sgl->need_unpin)
+		for (i = 0; i < sgl->npages; i++)
+			unpin_user_page(sgl->pages[i]);
 }
 EXPORT_SYMBOL_GPL(af_alg_free_sg);
 
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 7e76623f9ec3..46494b33f5bc 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -59,6 +59,7 @@ struct af_alg_sgl {
 	struct scatterlist sg[ALG_MAX_PAGES + 1];
 	struct page *pages[ALG_MAX_PAGES];
 	unsigned int npages;
+	bool need_unpin;
 };
 
 /* TX SGL entry */

