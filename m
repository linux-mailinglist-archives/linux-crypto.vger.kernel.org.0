Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B97243DA
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Jun 2023 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbjFFNKu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Jun 2023 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjFFNKs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Jun 2023 09:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E5172B
        for <linux-crypto@vger.kernel.org>; Tue,  6 Jun 2023 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686056951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xU6E2fjjhcVwKorersDkYRkNjPEQVcB/v3lc/5jlH4Q=;
        b=eq63PwoJkDHngCBkU0HdNd+ubLNblS0MPBb++auwlgg9ITZye8gPL8mLE8tBsIQJrCP1/5
        PRDbJ95sKPqHUwEI5IyjjZZMiGlUNC4+n3VL0zYiBqx189Zi8dC6y6GeqLzVk1ygVZq8xr
        5MycMWieSH1maLIf5Q3nyQHeIXyWta0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-zAky1qSONByxa_4w_IiLQw-1; Tue, 06 Jun 2023 09:09:05 -0400
X-MC-Unique: zAky1qSONByxa_4w_IiLQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5BED8039B6;
        Tue,  6 Jun 2023 13:09:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DCF64022C5;
        Tue,  6 Jun 2023 13:09:02 +0000 (UTC)
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
Subject: [PATCH net-next v3 00/10] crypto, splice, net: Make AF_ALG handle sendmsg(MSG_SPLICE_PAGES)
Date:   Tue,  6 Jun 2023 14:08:46 +0100
Message-ID: <20230606130856.1970660-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Here are patches to make AF_ALG handle the MSG_SPLICE_PAGES internal
sendmsg flag.  MSG_SPLICE_PAGES is an internal hint that tells the protocol
that it should splice the pages supplied if it can.  The sendpage functions
are then turned into wrappers around that.

This set consists of the following parts:

 (1) Move netfs_extract_iter_to_sg() to somewhere more general and rename
     it to drop the "netfs" prefix.  We use this to extract directly from
     an iterator into a scatterlist.

 (2) Make AF_ALG use iov_iter_extract_pages().  This has the additional
     effect of pinning pages obtained from userspace rather than taking
     refs on them.  Pages from kernel-backed iterators would not be pinned,
     but AF_ALG isn't really meant for use by kernel services.

 (3) Change AF_ALG still further to use extract_iter_to_sg().

 (4) Make af_alg_sendmsg() support MSG_SPLICE_PAGES support and make
     af_alg_sendpage() just a wrapper around sendmsg().  This has to take
     refs on the pages pinned for the moment.

 (5) Make hash_sendmsg() support MSG_SPLICE_PAGES by simply ignoring it.
     hash_sendpage() is left untouched to be removed later, after the
     splice core has been changed to call sendmsg().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-2-alg

David

ver #3)
 - Rebase and deal with fs/cifs/ moving.
 - Reimpose the ALG_MAX_PAGES limit in hash_sendmsg() for kernel iters.
 - Remove BVEC iter restriction when using MSG_SPLICE_PAGES.

ver #2)
 - Put the "netfs_" prefix removal first to shorten lines and avoid
   checkpatch 80-char warnings.
 - Fix a couple of spelling mistakes.
 - Wrap some lines at 80 chars.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=51c78a4d532efe9543a4df019ff405f05c6157f6 # part 1
Link: https://lore.kernel.org/r/20230526143104.882842-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230530141635.136968-1-dhowells@redhat.com/ # v2

David Howells (10):
  Drop the netfs_ prefix from netfs_extract_iter_to_sg()
  Fix a couple of spelling mistakes
  Wrap lines at 80
  Move netfs_extract_iter_to_sg() to lib/scatterlist.c
  crypto: af_alg: Pin pages rather than ref'ing if appropriate
  crypto: af_alg: Use extract_iter_to_sg() to create scatterlists
  crypto: af_alg: Indent the loop in af_alg_sendmsg()
  crypto: af_alg: Support MSG_SPLICE_PAGES
  crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES
  crypto: af_alg/hash: Support MSG_SPLICE_PAGES

 crypto/af_alg.c           | 181 +++++++++++--------------
 crypto/algif_aead.c       |  38 +++---
 crypto/algif_hash.c       | 110 ++++++++++------
 crypto/algif_skcipher.c   |  10 +-
 fs/netfs/iterator.c       | 266 -------------------------------------
 fs/smb/client/smb2ops.c   |   4 +-
 fs/smb/client/smbdirect.c |   2 +-
 include/crypto/if_alg.h   |   7 +-
 include/linux/netfs.h     |   4 -
 include/linux/uio.h       |   5 +
 lib/scatterlist.c         | 269 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 451 insertions(+), 445 deletions(-)

