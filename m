Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D021973C484
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Jun 2023 00:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjFWW6F (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Jun 2023 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFWW5t (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Jun 2023 18:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14E296C
        for <linux-crypto@vger.kernel.org>; Fri, 23 Jun 2023 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687560969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4BeeShTAxgKz2QzPCzlja5T5FtGvmauABSkyx/PwCY=;
        b=VZswf/3hDPesBtCslITMbYXhLlvpZi9+3jRP0mzBoMSkrV69TABQsCUp71WmuyaiYWfJYK
        8NfkzUvT7ujsR3PgkN3Jo030q6S8UxnxXZPZiqP2OFfAk7xaqqWIdif6QedW4I8KHvuNpv
        ZCzI7MO0mju3zxetBuRbsZ0Wje58q7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-frAzKgsoNduq05U9Fs3Ljg-1; Fri, 23 Jun 2023 18:56:02 -0400
X-MC-Unique: frAzKgsoNduq05U9Fs3Ljg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 756A0380451F;
        Fri, 23 Jun 2023 22:56:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8BBF1121314;
        Fri, 23 Jun 2023 22:55:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>, bpf@vger.kernel.org,
        dccp@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-x25@vger.kernel.org, mptcp@lists.linux.dev,
        rds-devel@oss.oracle.com, tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux-foundation.org
Subject: [PATCH net-next v5 15/16] sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
Date:   Fri, 23 Jun 2023 23:55:12 +0100
Message-ID: <20230623225513.2732256-16-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove ->sendpage() and ->sendpage_locked().  sendmsg() with
MSG_SPLICE_PAGES should be used instead.  This allows multiple pages and
multipage folios to be passed through.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for net/can
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: bpf@vger.kernel.org
cc: dccp@vger.kernel.org
cc: linux-afs@lists.infradead.org
cc: linux-arm-msm@vger.kernel.org
cc: linux-can@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: linux-doc@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-hams@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-rdma@vger.kernel.org
cc: linux-sctp@vger.kernel.org
cc: linux-wpan@vger.kernel.org
cc: linux-x25@vger.kernel.org
cc: mptcp@lists.linux.dev
cc: netdev@vger.kernel.org
cc: rds-devel@oss.oracle.com
cc: tipc-discussion@lists.sourceforge.net
cc: virtualization@lists.linux-foundation.org
---

Notes:
    ver #2)
     - Removed duplicate word in comment.

 Documentation/bpf/map_sockmap.rst             | 10 ++--
 Documentation/filesystems/locking.rst         |  2 -
 Documentation/filesystems/vfs.rst             |  1 -
 Documentation/networking/scaling.rst          |  4 +-
 crypto/af_alg.c                               | 28 -----------
 crypto/algif_aead.c                           | 22 ++-------
 crypto/algif_rng.c                            |  2 -
 crypto/algif_skcipher.c                       | 14 ------
 .../chelsio/inline_crypto/chtls/chtls.h       |  2 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 14 ------
 .../chelsio/inline_crypto/chtls/chtls_main.c  |  1 -
 fs/nfsd/vfs.c                                 |  2 +-
 include/crypto/if_alg.h                       |  2 -
 include/linux/net.h                           |  8 ----
 include/net/inet_common.h                     |  2 -
 include/net/sock.h                            |  6 ---
 include/net/tcp.h                             |  4 --
 net/appletalk/ddp.c                           |  1 -
 net/atm/pvc.c                                 |  1 -
 net/atm/svc.c                                 |  1 -
 net/ax25/af_ax25.c                            |  1 -
 net/caif/caif_socket.c                        |  2 -
 net/can/bcm.c                                 |  1 -
 net/can/isotp.c                               |  1 -
 net/can/j1939/socket.c                        |  1 -
 net/can/raw.c                                 |  1 -
 net/core/sock.c                               | 35 +-------------
 net/dccp/ipv4.c                               |  1 -
 net/dccp/ipv6.c                               |  1 -
 net/ieee802154/socket.c                       |  2 -
 net/ipv4/af_inet.c                            | 21 --------
 net/ipv4/tcp.c                                | 43 ++---------------
 net/ipv4/tcp_bpf.c                            | 23 +--------
 net/ipv4/tcp_ipv4.c                           |  1 -
 net/ipv4/udp.c                                | 15 ------
 net/ipv4/udp_impl.h                           |  2 -
 net/ipv4/udplite.c                            |  1 -
 net/ipv6/af_inet6.c                           |  3 --
 net/ipv6/raw.c                                |  1 -
 net/ipv6/tcp_ipv6.c                           |  1 -
 net/kcm/kcmsock.c                             | 20 --------
 net/key/af_key.c                              |  1 -
 net/l2tp/l2tp_ip.c                            |  1 -
 net/l2tp/l2tp_ip6.c                           |  1 -
 net/llc/af_llc.c                              |  1 -
 net/mctp/af_mctp.c                            |  1 -
 net/mptcp/protocol.c                          |  2 -
 net/netlink/af_netlink.c                      |  1 -
 net/netrom/af_netrom.c                        |  1 -
 net/packet/af_packet.c                        |  2 -
 net/phonet/socket.c                           |  2 -
 net/qrtr/af_qrtr.c                            |  1 -
 net/rds/af_rds.c                              |  1 -
 net/rose/af_rose.c                            |  1 -
 net/rxrpc/af_rxrpc.c                          |  1 -
 net/sctp/protocol.c                           |  1 -
 net/socket.c                                  | 48 -------------------
 net/tipc/socket.c                             |  3 --
 net/tls/tls.h                                 |  6 ---
 net/tls/tls_device.c                          | 17 -------
 net/tls/tls_main.c                            |  7 ---
 net/tls/tls_sw.c                              | 35 --------------
 net/unix/af_unix.c                            | 19 --------
 net/vmw_vsock/af_vsock.c                      |  3 --
 net/x25/af_x25.c                              |  1 -
 net/xdp/xsk.c                                 |  1 -
 66 files changed, 20 insertions(+), 442 deletions(-)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index cc92047c6630..2d630686a00b 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -240,11 +240,11 @@ offsets into ``msg``, respectively.
 If a program of type ``BPF_PROG_TYPE_SK_MSG`` is run on a ``msg`` it can only
 parse data that the (``data``, ``data_end``) pointers have already consumed.
 For ``sendmsg()`` hooks this is likely the first scatterlist element. But for
-calls relying on the ``sendpage`` handler (e.g., ``sendfile()``) this will be
-the range (**0**, **0**) because the data is shared with user space and by
-default the objective is to avoid allowing user space to modify data while (or
-after) BPF verdict is being decided. This helper can be used to pull in data
-and to set the start and end pointers to given values. Data will be copied if
+calls relying on MSG_SPLICE_PAGES (e.g., ``sendfile()``) this will be the
+range (**0**, **0**) because the data is shared with user space and by default
+the objective is to avoid allowing user space to modify data while (or after)
+BPF verdict is being decided. This helper can be used to pull in data and to
+set the start and end pointers to given values. Data will be copied if
 necessary (i.e., if data was not linear and if start and end pointers do not
 point to the same chunk).
 
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index aa1a233b0fa8..ed148919e11a 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -521,8 +521,6 @@ prototypes::
 	int (*fsync) (struct file *, loff_t start, loff_t end, int datasync);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*sendpage) (struct file *, struct page *, int, size_t,
-			loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long,
 			unsigned long, unsigned long, unsigned long);
 	int (*check_flags)(int);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 769be5230210..cb2a97e49872 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1086,7 +1086,6 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		int (*fsync) (struct file *, loff_t, loff_t, int datasync);
 		int (*fasync) (int, struct file *, int);
 		int (*lock) (struct file *, int, struct file_lock *);
-		ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 		unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 		int (*check_flags)(int);
 		int (*flock) (struct file *, int, struct file_lock *);
diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 3d435caa3ef2..92c9fb46d6a2 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -269,8 +269,8 @@ a single application thread handles flows with many different flow hashes.
 rps_sock_flow_table is a global flow table that contains the *desired* CPU
 for flows: the CPU that is currently processing the flow in userspace.
 Each table value is a CPU index that is updated during calls to recvmsg
-and sendmsg (specifically, inet_recvmsg(), inet_sendmsg(), inet_sendpage()
-and tcp_splice_read()).
+and sendmsg (specifically, inet_recvmsg(), inet_sendmsg() and
+tcp_splice_read()).
 
 When the scheduler moves a thread to a new CPU while it has outstanding
 receive packets on the old CPU, packets may arrive out of order. To
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 7d4b6016b83d..11229f3bcf84 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -482,7 +482,6 @@ static const struct proto_ops alg_proto_ops = {
 	.listen		=	sock_no_listen,
 	.shutdown	=	sock_no_shutdown,
 	.mmap		=	sock_no_mmap,
-	.sendpage	=	sock_no_sendpage,
 	.sendmsg	=	sock_no_sendmsg,
 	.recvmsg	=	sock_no_recvmsg,
 
@@ -1106,33 +1105,6 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 }
 EXPORT_SYMBOL_GPL(af_alg_sendmsg);
 
-/**
- * af_alg_sendpage - sendpage system call handler
- * @sock: socket of connection to user space to write to
- * @page: data to send
- * @offset: offset into page to begin sending
- * @size: length of data
- * @flags: message send/receive flags
- *
- * This is a generic implementation of sendpage to fill ctx->tsgl_list.
- */
-ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
-			int offset, size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = {
-		.msg_flags = flags | MSG_SPLICE_PAGES,
-	};
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return sock_sendmsg(sock, &msg);
-}
-EXPORT_SYMBOL_GPL(af_alg_sendpage);
-
 /**
  * af_alg_free_resources - release resources required for crypto request
  * @areq: Request holding the TX and RX SGL
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 35bfa283748d..7d58cbbce4af 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -9,10 +9,10 @@
  * The following concept of the memory management is used:
  *
  * The kernel maintains two SGLs, the TX SGL and the RX SGL. The TX SGL is
- * filled by user space with the data submitted via sendpage. Filling up
- * the TX SGL does not cause a crypto operation -- the data will only be
- * tracked by the kernel. Upon receipt of one recvmsg call, the caller must
- * provide a buffer which is tracked with the RX SGL.
+ * filled by user space with the data submitted via sendmsg (maybe with
+ * MSG_SPLICE_PAGES).  Filling up the TX SGL does not cause a crypto operation
+ * -- the data will only be tracked by the kernel. Upon receipt of one recvmsg
+ * call, the caller must provide a buffer which is tracked with the RX SGL.
  *
  * During the processing of the recvmsg operation, the cipher request is
  * allocated and prepared. As part of the recvmsg operation, the processed
@@ -370,7 +370,6 @@ static struct proto_ops algif_aead_ops = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	aead_sendmsg,
-	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	aead_recvmsg,
 	.poll		=	af_alg_poll,
 };
@@ -422,18 +421,6 @@ static int aead_sendmsg_nokey(struct socket *sock, struct msghdr *msg,
 	return aead_sendmsg(sock, msg, size);
 }
 
-static ssize_t aead_sendpage_nokey(struct socket *sock, struct page *page,
-				       int offset, size_t size, int flags)
-{
-	int err;
-
-	err = aead_check_key(sock);
-	if (err)
-		return err;
-
-	return af_alg_sendpage(sock, page, offset, size, flags);
-}
-
 static int aead_recvmsg_nokey(struct socket *sock, struct msghdr *msg,
 				  size_t ignored, int flags)
 {
@@ -461,7 +448,6 @@ static struct proto_ops algif_aead_ops_nokey = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	aead_sendmsg_nokey,
-	.sendpage	=	aead_sendpage_nokey,
 	.recvmsg	=	aead_recvmsg_nokey,
 	.poll		=	af_alg_poll,
 };
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 407408c43730..10c41adac3b1 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -174,7 +174,6 @@ static struct proto_ops algif_rng_ops = {
 	.bind		=	sock_no_bind,
 	.accept		=	sock_no_accept,
 	.sendmsg	=	sock_no_sendmsg,
-	.sendpage	=	sock_no_sendpage,
 
 	.release	=	af_alg_release,
 	.recvmsg	=	rng_recvmsg,
@@ -192,7 +191,6 @@ static struct proto_ops __maybe_unused algif_rng_test_ops = {
 	.mmap		=	sock_no_mmap,
 	.bind		=	sock_no_bind,
 	.accept		=	sock_no_accept,
-	.sendpage	=	sock_no_sendpage,
 
 	.release	=	af_alg_release,
 	.recvmsg	=	rng_test_recvmsg,
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index b1f321b9f846..9ada9b741af8 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -194,7 +194,6 @@ static struct proto_ops algif_skcipher_ops = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	skcipher_sendmsg,
-	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	skcipher_recvmsg,
 	.poll		=	af_alg_poll,
 };
@@ -246,18 +245,6 @@ static int skcipher_sendmsg_nokey(struct socket *sock, struct msghdr *msg,
 	return skcipher_sendmsg(sock, msg, size);
 }
 
-static ssize_t skcipher_sendpage_nokey(struct socket *sock, struct page *page,
-				       int offset, size_t size, int flags)
-{
-	int err;
-
-	err = skcipher_check_key(sock);
-	if (err)
-		return err;
-
-	return af_alg_sendpage(sock, page, offset, size, flags);
-}
-
 static int skcipher_recvmsg_nokey(struct socket *sock, struct msghdr *msg,
 				  size_t ignored, int flags)
 {
@@ -285,7 +272,6 @@ static struct proto_ops algif_skcipher_ops_nokey = {
 
 	.release	=	af_alg_release,
 	.sendmsg	=	skcipher_sendmsg_nokey,
-	.sendpage	=	skcipher_sendpage_nokey,
 	.recvmsg	=	skcipher_recvmsg_nokey,
 	.poll		=	af_alg_poll,
 };
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index da4818d2c856..68562a82d036 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -569,8 +569,6 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int chtls_recvmsg(struct sock *sk, struct msghdr *msg,
 		  size_t len, int flags, int *addr_len);
 void chtls_splice_eof(struct socket *sock);
-int chtls_sendpage(struct sock *sk, struct page *page,
-		   int offset, size_t size, int flags);
 int send_tx_flowc_wr(struct sock *sk, int compl,
 		     u32 snd_nxt, u32 rcv_nxt);
 void chtls_tcp_push(struct sock *sk, int flags);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index e08ac960c967..5fc64e47568a 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1246,20 +1246,6 @@ void chtls_splice_eof(struct socket *sock)
 	release_sock(sk);
 }
 
-int chtls_sendpage(struct sock *sk, struct page *page,
-		   int offset, size_t size, int flags)
-{
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-	struct bio_vec bvec;
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return chtls_sendmsg(sk, &msg, size);
-}
-
 static void chtls_select_window(struct sock *sk)
 {
 	struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 6b6787eafd2f..455a54708be4 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -607,7 +607,6 @@ static void __init chtls_init_ulp_ops(void)
 	chtls_cpl_prot.shutdown		= chtls_shutdown;
 	chtls_cpl_prot.sendmsg		= chtls_sendmsg;
 	chtls_cpl_prot.splice_eof	= chtls_splice_eof;
-	chtls_cpl_prot.sendpage		= chtls_sendpage;
 	chtls_cpl_prot.recvmsg		= chtls_recvmsg;
 	chtls_cpl_prot.setsockopt	= chtls_setsockopt;
 	chtls_cpl_prot.getsockopt	= chtls_getsockopt;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index db67f8e19344..8879e207ff5a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -936,7 +936,7 @@ nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
 
 /*
  * Grab and keep cached pages associated with a file in the svc_rqst
- * so that they can be passed to the network sendmsg/sendpage routines
+ * so that they can be passed to the network sendmsg routines
  * directly. They will be released after the sending has completed.
  *
  * Return values: Number of bytes consumed, or -EIO if there are no
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 34224e77f5a2..ef8ce86b1f78 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -229,8 +229,6 @@ void af_alg_wmem_wakeup(struct sock *sk);
 int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min);
 int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		   unsigned int ivsize);
-ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
-			int offset, size_t size, int flags);
 void af_alg_free_resources(struct af_alg_async_req *areq);
 void af_alg_async_cb(void *data, int err);
 __poll_t af_alg_poll(struct file *file, struct socket *sock,
diff --git a/include/linux/net.h b/include/linux/net.h
index 23324e9a2b3d..41c608c1b02c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -207,8 +207,6 @@ struct proto_ops {
 				      size_t total_len, int flags);
 	int		(*mmap)	     (struct file *file, struct socket *sock,
 				      struct vm_area_struct * vma);
-	ssize_t		(*sendpage)  (struct socket *sock, struct page *page,
-				      int offset, size_t size, int flags);
 	ssize_t 	(*splice_read)(struct socket *sock,  loff_t *ppos,
 				       struct pipe_inode_info *pipe, size_t len, unsigned int flags);
 	void		(*splice_eof)(struct socket *sock);
@@ -222,8 +220,6 @@ struct proto_ops {
 				     sk_read_actor_t recv_actor);
 	/* This is different from read_sock(), it reads an entire skb at a time. */
 	int		(*read_skb)(struct sock *sk, skb_read_actor_t recv_actor);
-	int		(*sendpage_locked)(struct sock *sk, struct page *page,
-					   int offset, size_t size, int flags);
 	int		(*sendmsg_locked)(struct sock *sk, struct msghdr *msg,
 					  size_t size);
 	int		(*set_rcvlowat)(struct sock *sk, int val);
@@ -341,10 +337,6 @@ int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags);
 int kernel_getsockname(struct socket *sock, struct sockaddr *addr);
 int kernel_getpeername(struct socket *sock, struct sockaddr *addr);
-int kernel_sendpage(struct socket *sock, struct page *page, int offset,
-		    size_t size, int flags);
-int kernel_sendpage_locked(struct sock *sk, struct page *page, int offset,
-			   size_t size, int flags);
 int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how);
 
 /* Routine returns the IP overhead imposed by a (caller-protected) socket. */
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index a75333342c4e..b86b8e21de7f 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -36,8 +36,6 @@ void __inet_accept(struct socket *sock, struct socket *newsock,
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
 void inet_splice_eof(struct socket *sock);
-ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
-		      size_t size, int flags);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
diff --git a/include/net/sock.h b/include/net/sock.h
index 62a1b99da349..121284f455a8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1277,8 +1277,6 @@ struct proto {
 					   size_t len);
 	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
 					   size_t len, int flags, int *addr_len);
-	int			(*sendpage)(struct sock *sk, struct page *page,
-					int offset, size_t size, int flags);
 	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
 					struct sockaddr *addr, int addr_len);
@@ -1919,10 +1917,6 @@ int sock_no_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
 int sock_no_recvmsg(struct socket *, struct msghdr *, size_t, int);
 int sock_no_mmap(struct file *file, struct socket *sock,
 		 struct vm_area_struct *vma);
-ssize_t sock_no_sendpage(struct socket *sock, struct page *page, int offset,
-			 size_t size, int flags);
-ssize_t sock_no_sendpage_locked(struct sock *sk, struct page *page,
-				int offset, size_t size, int flags);
 
 /*
  * Functions to fill in entries in struct proto_ops when a protocol
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9c08eab647a2..95e4507febed 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -328,10 +328,6 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 			 size_t size, struct ubuf_info *uarg);
 void tcp_splice_eof(struct socket *sock);
-int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
-		 int flags);
-int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
-			size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
 int tcp_wmem_schedule(struct sock *sk, int copy);
 void tcp_push(struct sock *sk, int flags, int mss_now, int nonagle,
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index a06f4d4a6f47..8978fb6212ff 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1929,7 +1929,6 @@ static const struct proto_ops atalk_dgram_ops = {
 	.sendmsg	= atalk_sendmsg,
 	.recvmsg	= atalk_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 static struct notifier_block ddp_notifier = {
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 53e7d3f39e26..66d9a9bd5896 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -126,7 +126,6 @@ static const struct proto_ops pvc_proto_ops = {
 	.sendmsg =	vcc_sendmsg,
 	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 
diff --git a/net/atm/svc.c b/net/atm/svc.c
index d83556d8beb9..36a814f1fbd1 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -654,7 +654,6 @@ static const struct proto_ops svc_proto_ops = {
 	.sendmsg =	vcc_sendmsg,
 	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d8da400cb4de..5db805d5f74d 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -2022,7 +2022,6 @@ static const struct proto_ops ax25_proto_ops = {
 	.sendmsg	= ax25_sendmsg,
 	.recvmsg	= ax25_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 /*
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 4eebcc66c19a..9c82698da4f5 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -976,7 +976,6 @@ static const struct proto_ops caif_seqpacket_ops = {
 	.sendmsg = caif_seqpkt_sendmsg,
 	.recvmsg = caif_seqpkt_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 };
 
 static const struct proto_ops caif_stream_ops = {
@@ -996,7 +995,6 @@ static const struct proto_ops caif_stream_ops = {
 	.sendmsg = caif_stream_sendmsg,
 	.recvmsg = caif_stream_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 };
 
 /* This function is called when a socket is finally destroyed. */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a962ec2b8ba5..9ba35685b043 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1703,7 +1703,6 @@ static const struct proto_ops bcm_ops = {
 	.sendmsg       = bcm_sendmsg,
 	.recvmsg       = bcm_recvmsg,
 	.mmap          = sock_no_mmap,
-	.sendpage      = sock_no_sendpage,
 };
 
 static struct proto bcm_proto __read_mostly = {
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 84f9aba02901..1f25b45868cf 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1699,7 +1699,6 @@ static const struct proto_ops isotp_ops = {
 	.sendmsg = isotp_sendmsg,
 	.recvmsg = isotp_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 };
 
 static struct proto isotp_proto __read_mostly = {
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 35970c25496a..feaec4ad6d16 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1306,7 +1306,6 @@ static const struct proto_ops j1939_ops = {
 	.sendmsg = j1939_sk_sendmsg,
 	.recvmsg = j1939_sk_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 };
 
 static struct proto j1939_proto __read_mostly = {
diff --git a/net/can/raw.c b/net/can/raw.c
index f64469b98260..15c79b079184 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -962,7 +962,6 @@ static const struct proto_ops raw_ops = {
 	.sendmsg       = raw_sendmsg,
 	.recvmsg       = raw_recvmsg,
 	.mmap          = sock_no_mmap,
-	.sendpage      = sock_no_sendpage,
 };
 
 static struct proto raw_proto __read_mostly = {
diff --git a/net/core/sock.c b/net/core/sock.c
index cff3e82514d1..5c4948fe8ab1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3267,36 +3267,6 @@ void __receive_sock(struct file *file)
 	}
 }
 
-ssize_t sock_no_sendpage(struct socket *sock, struct page *page, int offset, size_t size, int flags)
-{
-	ssize_t res;
-	struct msghdr msg = {.msg_flags = flags};
-	struct kvec iov;
-	char *kaddr = kmap(page);
-	iov.iov_base = kaddr + offset;
-	iov.iov_len = size;
-	res = kernel_sendmsg(sock, &msg, &iov, 1, size);
-	kunmap(page);
-	return res;
-}
-EXPORT_SYMBOL(sock_no_sendpage);
-
-ssize_t sock_no_sendpage_locked(struct sock *sk, struct page *page,
-				int offset, size_t size, int flags)
-{
-	ssize_t res;
-	struct msghdr msg = {.msg_flags = flags};
-	struct kvec iov;
-	char *kaddr = kmap(page);
-
-	iov.iov_base = kaddr + offset;
-	iov.iov_len = size;
-	res = kernel_sendmsg_locked(sk, &msg, &iov, 1, size);
-	kunmap(page);
-	return res;
-}
-EXPORT_SYMBOL(sock_no_sendpage_locked);
-
 /*
  *	Default Socket Callbacks
  */
@@ -4052,7 +4022,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 {
 
 	seq_printf(seq, "%-9s %4u %6d  %6ld   %-3s %6u   %-3s  %-10s "
-			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
+			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,
 		   sock_prot_inuse_get(seq_file_net(seq), proto),
@@ -4073,7 +4043,6 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 		   proto_method_implemented(proto->getsockopt),
 		   proto_method_implemented(proto->sendmsg),
 		   proto_method_implemented(proto->recvmsg),
-		   proto_method_implemented(proto->sendpage),
 		   proto_method_implemented(proto->bind),
 		   proto_method_implemented(proto->backlog_rcv),
 		   proto_method_implemented(proto->hash),
@@ -4094,7 +4063,7 @@ static int proto_seq_show(struct seq_file *seq, void *v)
 			   "maxhdr",
 			   "slab",
 			   "module",
-			   "cl co di ac io in de sh ss gs se re sp bi br ha uh gp em\n");
+			   "cl co di ac io in de sh ss gs se re bi br ha uh gp em\n");
 	else
 		proto_seq_printf(seq, list_entry(v, struct proto, node));
 	return 0;
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 3ab68415d121..fa8079303cb0 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1010,7 +1010,6 @@ static const struct proto_ops inet_dccp_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 };
 
 static struct inet_protosw dccp_v4_protosw = {
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 93c98990d726..7249ef218178 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1087,7 +1087,6 @@ static const struct proto_ops inet6_dccp_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 9c124705120d..00302e8b9615 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -426,7 +426,6 @@ static const struct proto_ops ieee802154_raw_ops = {
 	.sendmsg	   = ieee802154_sock_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 };
 
 /* DGRAM Sockets (802.15.4 dataframes) */
@@ -989,7 +988,6 @@ static const struct proto_ops ieee802154_dgram_ops = {
 	.sendmsg	   = ieee802154_sock_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 };
 
 static void ieee802154_sock_destruct(struct sock *sk)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 38e649fb4474..9b2ca2fcc5a1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -847,23 +847,6 @@ void inet_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
-ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
-		      size_t size, int flags)
-{
-	struct sock *sk = sock->sk;
-	const struct proto *prot;
-
-	if (unlikely(inet_send_prepare(sk)))
-		return -EAGAIN;
-
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
-	prot = READ_ONCE(sk->sk_prot);
-	if (prot->sendpage)
-		return prot->sendpage(sk, page, offset, size, flags);
-	return sock_no_sendpage(sock, page, offset, size, flags);
-}
-EXPORT_SYMBOL(inet_sendpage);
-
 INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
 					  size_t, int, int *));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1067,12 +1050,10 @@ const struct proto_ops inet_stream_ops = {
 	.mmap		   = tcp_mmap,
 #endif
 	.splice_eof	   = inet_splice_eof,
-	.sendpage	   = inet_sendpage,
 	.splice_read	   = tcp_splice_read,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.sendmsg_locked    = tcp_sendmsg_locked,
-	.sendpage_locked   = tcp_sendpage_locked,
 	.peek_len	   = tcp_peek_len,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
@@ -1102,7 +1083,6 @@ const struct proto_ops inet_dgram_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.splice_eof	   = inet_splice_eof,
-	.sendpage	   = inet_sendpage,
 	.set_peek_off	   = sk_set_peek_off,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
@@ -1134,7 +1114,6 @@ static const struct proto_ops inet_sockraw_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.splice_eof	   = inet_splice_eof,
-	.sendpage	   = inet_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
 #endif
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0e21ea92dc1d..38f9250999cc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -923,11 +923,10 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 	return mss_now;
 }
 
-/* In some cases, both sendpage() and sendmsg() could have added
- * an skb to the write queue, but failed adding payload on it.
- * We need to remove it to consume less memory, but more
- * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
- * users.
+/* In some cases, both sendmsg() could have added an skb to the write queue,
+ * but failed adding payload on it.  We need to remove it to consume less
+ * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
+ * epoll() users.
  */
 void tcp_remove_empty_skb(struct sock *sk)
 {
@@ -975,40 +974,6 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
 	return min(copy, sk->sk_forward_alloc);
 }
 
-int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
-			size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-
-	if (!(sk->sk_route_caps & NETIF_F_SG))
-		return sock_no_sendpage_locked(sk, page, offset, size, flags);
-
-	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	return tcp_sendmsg_locked(sk, &msg, size);
-}
-EXPORT_SYMBOL_GPL(tcp_sendpage_locked);
-
-int tcp_sendpage(struct sock *sk, struct page *page, int offset,
-		 size_t size, int flags)
-{
-	int ret;
-
-	lock_sock(sk);
-	ret = tcp_sendpage_locked(sk, page, offset, size, flags);
-	release_sock(sk);
-
-	return ret;
-}
-EXPORT_SYMBOL(tcp_sendpage);
-
 void tcp_free_fastopen_req(struct tcp_sock *tp)
 {
 	if (tp->fastopen_req) {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 31d6005cea9b..81f0dff69e0b 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -486,7 +486,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	long timeo;
 	int flags;
 
-	/* Don't let internal sendpage flags through */
+	/* Don't let internal flags through */
 	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
 	flags |= MSG_NO_SHARED_FRAGS;
 
@@ -566,23 +566,6 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	return copied ? copied : err;
 }
 
-static int tcp_bpf_sendpage(struct sock *sk, struct page *page, int offset,
-			    size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = {
-		.msg_flags = flags | MSG_SPLICE_PAGES,
-	};
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	return tcp_bpf_sendmsg(sk, &msg, size);
-}
-
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
@@ -612,7 +595,6 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
-	prot[TCP_BPF_TX].sendpage		= tcp_bpf_sendpage;
 
 	prot[TCP_BPF_RX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_RX].recvmsg		= tcp_bpf_recvmsg_parser;
@@ -647,8 +629,7 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	 * indeed valid assumptions.
 	 */
 	return ops->recvmsg  == tcp_recvmsg &&
-	       ops->sendmsg  == tcp_sendmsg &&
-	       ops->sendpage == tcp_sendpage ? 0 : -ENOTSUPP;
+	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
 }
 
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84a5d557dc1a..a228cdb23831 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3117,7 +3117,6 @@ struct proto tcp_prot = {
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.splice_eof		= tcp_splice_eof,
-	.sendpage		= tcp_sendpage,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.release_cb		= tcp_release_cb,
 	.hash			= inet_hash,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 48fdcd3cad9c..42a96b3547c9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1340,20 +1340,6 @@ void udp_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(udp_splice_eof);
 
-int udp_sendpage(struct sock *sk, struct page *page, int offset,
-		 size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES };
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return udp_sendmsg(sk, &msg, size);
-}
-
 #define UDP_SKB_IS_STATELESS 0x80000000
 
 /* all head states (dst, sk, nf conntrack) except skb extensions are
@@ -2933,7 +2919,6 @@ struct proto udp_prot = {
 	.sendmsg		= udp_sendmsg,
 	.recvmsg		= udp_recvmsg,
 	.splice_eof		= udp_splice_eof,
-	.sendpage		= udp_sendpage,
 	.release_cb		= ip4_datagram_release_cb,
 	.hash			= udp_lib_hash,
 	.unhash			= udp_lib_unhash,
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index 4ba7a88a1b1d..e1ff3a375996 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -19,8 +19,6 @@ int udp_getsockopt(struct sock *sk, int level, int optname,
 
 int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		int *addr_len);
-int udp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
-		 int flags);
 void udp_destroy_sock(struct sock *sk);
 
 #ifdef CONFIG_PROC_FS
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index 143f93a12f25..39ecdad1b50c 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -56,7 +56,6 @@ struct proto 	udplite_prot = {
 	.getsockopt	   = udp_getsockopt,
 	.sendmsg	   = udp_sendmsg,
 	.recvmsg	   = udp_recvmsg,
-	.sendpage	   = udp_sendpage,
 	.hash		   = udp_lib_hash,
 	.unhash		   = udp_lib_unhash,
 	.rehash		   = udp_v4_rehash,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b3451cf47d29..5d593ddc0347 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -696,9 +696,7 @@ const struct proto_ops inet6_stream_ops = {
 	.mmap		   = tcp_mmap,
 #endif
 	.splice_eof	   = inet_splice_eof,
-	.sendpage	   = inet_sendpage,
 	.sendmsg_locked    = tcp_sendmsg_locked,
-	.sendpage_locked   = tcp_sendpage_locked,
 	.splice_read	   = tcp_splice_read,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
@@ -729,7 +727,6 @@ const struct proto_ops inet6_dgram_ops = {
 	.recvmsg	   = inet6_recvmsg,		/* retpoline's sake */
 	.read_skb	   = udp_read_skb,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 	.set_peek_off	   = sk_set_peek_off,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index c9caeb5a43ed..ac1cef094c5f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1296,7 +1296,6 @@ const struct proto_ops inet6_sockraw_ops = {
 	.sendmsg	   = inet_sendmsg,		/* ok		*/
 	.recvmsg	   = sock_common_recvmsg,	/* ok		*/
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c17c8ff94b79..40dd92a2f480 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2151,7 +2151,6 @@ struct proto tcpv6_prot = {
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
 	.splice_eof		= tcp_splice_eof,
-	.sendpage		= tcp_sendpage,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,
 	.hash			= inet6_hash,
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d75d775e9462..b512f9958e43 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -961,24 +961,6 @@ static void kcm_splice_eof(struct socket *sock)
 	release_sock(sk);
 }
 
-static ssize_t kcm_sendpage(struct socket *sock, struct page *page,
-			    int offset, size_t size, int flags)
-
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	if (flags & MSG_OOB)
-		return -EOPNOTSUPP;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return kcm_sendmsg(sock, &msg, size);
-}
-
 static int kcm_recvmsg(struct socket *sock, struct msghdr *msg,
 		       size_t len, int flags)
 {
@@ -1767,7 +1749,6 @@ static const struct proto_ops kcm_dgram_ops = {
 	.recvmsg =	kcm_recvmsg,
 	.mmap =		sock_no_mmap,
 	.splice_eof =	kcm_splice_eof,
-	.sendpage =	kcm_sendpage,
 };
 
 static const struct proto_ops kcm_seqpacket_ops = {
@@ -1789,7 +1770,6 @@ static const struct proto_ops kcm_seqpacket_ops = {
 	.recvmsg =	kcm_recvmsg,
 	.mmap =		sock_no_mmap,
 	.splice_eof =	kcm_splice_eof,
-	.sendpage =	kcm_sendpage,
 	.splice_read =	kcm_splice_read,
 };
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 31ab12fd720a..ede3c6a60353 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3761,7 +3761,6 @@ static const struct proto_ops pfkey_ops = {
 	.listen		=	sock_no_listen,
 	.shutdown	=	sock_no_shutdown,
 	.mmap		=	sock_no_mmap,
-	.sendpage	=	sock_no_sendpage,
 
 	/* Now the operations that really occur. */
 	.release	=	pfkey_release,
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 2b795c1064f5..f9073bc7281f 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -624,7 +624,6 @@ static const struct proto_ops l2tp_ip_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 };
 
 static struct inet_protosw l2tp_ip_protosw = {
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 5137ea1861ce..b1623f9c4f92 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -751,7 +751,6 @@ static const struct proto_ops l2tp_ip6_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 9ffbc667be6c..57c35c960b2c 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1232,7 +1232,6 @@ static const struct proto_ops llc_ui_ops = {
 	.sendmsg     = llc_ui_sendmsg,
 	.recvmsg     = llc_ui_recvmsg,
 	.mmap	     = sock_no_mmap,
-	.sendpage    = sock_no_sendpage,
 };
 
 static const char llc_proc_err_msg[] __initconst =
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index bb4bd0b6a4f7..f6be58b68c6f 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -485,7 +485,6 @@ static const struct proto_ops mctp_dgram_ops = {
 	.sendmsg	= mctp_sendmsg,
 	.recvmsg	= mctp_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= mctp_compat_ioctl,
 #endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 992b89c75631..e67983bd3bc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3891,7 +3891,6 @@ static const struct proto_ops mptcp_stream_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = inet_sendpage,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -3986,7 +3985,6 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.sendmsg	   = inet6_sendmsg,
 	.recvmsg	   = inet6_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = inet_sendpage,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index cbd9aa7ee24a..39cfb778ebc5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2815,7 +2815,6 @@ static const struct proto_ops netlink_ops = {
 	.sendmsg =	netlink_sendmsg,
 	.recvmsg =	netlink_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 static const struct net_proto_family netlink_family_ops = {
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 5a4cb796150f..eb8ccbd58df7 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -1364,7 +1364,6 @@ static const struct proto_ops nr_proto_ops = {
 	.sendmsg	=	nr_sendmsg,
 	.recvmsg	=	nr_recvmsg,
 	.mmap		=	sock_no_mmap,
-	.sendpage	=	sock_no_sendpage,
 };
 
 static struct notifier_block nr_dev_notifier = {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a2dbeb264f26..85ff90a03b0c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4621,7 +4621,6 @@ static const struct proto_ops packet_ops_spkt = {
 	.sendmsg =	packet_sendmsg_spkt,
 	.recvmsg =	packet_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 static const struct proto_ops packet_ops = {
@@ -4643,7 +4642,6 @@ static const struct proto_ops packet_ops = {
 	.sendmsg =	packet_sendmsg,
 	.recvmsg =	packet_recvmsg,
 	.mmap =		packet_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 static const struct net_proto_family packet_family_ops = {
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 967f9b4dc026..1018340d89a7 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -441,7 +441,6 @@ const struct proto_ops phonet_dgram_ops = {
 	.sendmsg	= pn_socket_sendmsg,
 	.recvmsg	= sock_common_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 const struct proto_ops phonet_stream_ops = {
@@ -462,7 +461,6 @@ const struct proto_ops phonet_stream_ops = {
 	.sendmsg	= pn_socket_sendmsg,
 	.recvmsg	= sock_common_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 EXPORT_SYMBOL(phonet_stream_ops);
 
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 76f0434d3d06..78beb74146e7 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1244,7 +1244,6 @@ static const struct proto_ops qrtr_proto_ops = {
 	.shutdown	= sock_no_shutdown,
 	.release	= qrtr_release,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 static struct proto qrtr_proto = {
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 3ff6995244e5..01c4cdfef45d 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -653,7 +653,6 @@ static const struct proto_ops rds_proto_ops = {
 	.sendmsg =	rds_sendmsg,
 	.recvmsg =	rds_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 static void rds_sock_destruct(struct sock *sk)
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index ca2b17f32670..49dafe9ac72f 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1496,7 +1496,6 @@ static const struct proto_ops rose_proto_ops = {
 	.sendmsg	=	rose_sendmsg,
 	.recvmsg	=	rose_recvmsg,
 	.mmap		=	sock_no_mmap,
-	.sendpage	=	sock_no_sendpage,
 };
 
 static struct notifier_block rose_dev_notifier = {
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index da0b3b5157d5..f2cf4aa99db2 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -954,7 +954,6 @@ static const struct proto_ops rxrpc_rpc_ops = {
 	.sendmsg	= rxrpc_sendmsg,
 	.recvmsg	= rxrpc_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 static struct proto rxrpc_proto = {
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 664d1f2e9121..274d07bd774f 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1133,7 +1133,6 @@ static const struct proto_ops inet_seqpacket_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
-	.sendpage	   = sock_no_sendpage,
 };
 
 /* Registration with AF_INET family.  */
diff --git a/net/socket.c b/net/socket.c
index b778fc03c6e0..8c3c8b29995a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3552,54 +3552,6 @@ int kernel_getpeername(struct socket *sock, struct sockaddr *addr)
 }
 EXPORT_SYMBOL(kernel_getpeername);
 
-/**
- *	kernel_sendpage - send a &page through a socket (kernel space)
- *	@sock: socket
- *	@page: page
- *	@offset: page offset
- *	@size: total size in bytes
- *	@flags: flags (MSG_DONTWAIT, ...)
- *
- *	Returns the total amount sent in bytes or an error.
- */
-
-int kernel_sendpage(struct socket *sock, struct page *page, int offset,
-		    size_t size, int flags)
-{
-	if (sock->ops->sendpage) {
-		/* Warn in case the improper page to zero-copy send */
-		WARN_ONCE(!sendpage_ok(page), "improper page for zero-copy send");
-		return sock->ops->sendpage(sock, page, offset, size, flags);
-	}
-	return sock_no_sendpage(sock, page, offset, size, flags);
-}
-EXPORT_SYMBOL(kernel_sendpage);
-
-/**
- *	kernel_sendpage_locked - send a &page through the locked sock (kernel space)
- *	@sk: sock
- *	@page: page
- *	@offset: page offset
- *	@size: total size in bytes
- *	@flags: flags (MSG_DONTWAIT, ...)
- *
- *	Returns the total amount sent in bytes or an error.
- *	Caller must hold @sk.
- */
-
-int kernel_sendpage_locked(struct sock *sk, struct page *page, int offset,
-			   size_t size, int flags)
-{
-	struct socket *sock = sk->sk_socket;
-
-	if (sock->ops->sendpage_locked)
-		return sock->ops->sendpage_locked(sk, page, offset, size,
-						  flags);
-
-	return sock_no_sendpage_locked(sk, page, offset, size, flags);
-}
-EXPORT_SYMBOL(kernel_sendpage_locked);
-
 /**
  *	kernel_sock_shutdown - shut down part of a full-duplex connection (kernel space)
  *	@sock: socket
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index dd73d71c02a9..ef8e5139a873 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3375,7 +3375,6 @@ static const struct proto_ops msg_ops = {
 	.sendmsg	= tipc_sendmsg,
 	.recvmsg	= tipc_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage
 };
 
 static const struct proto_ops packet_ops = {
@@ -3396,7 +3395,6 @@ static const struct proto_ops packet_ops = {
 	.sendmsg	= tipc_send_packet,
 	.recvmsg	= tipc_recvmsg,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage
 };
 
 static const struct proto_ops stream_ops = {
@@ -3417,7 +3415,6 @@ static const struct proto_ops stream_ops = {
 	.sendmsg	= tipc_sendstream,
 	.recvmsg	= tipc_recvstream,
 	.mmap		= sock_no_mmap,
-	.sendpage	= sock_no_sendpage
 };
 
 static const struct net_proto_family tipc_family_ops = {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index d002c3af1966..86cef1c68e03 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -98,10 +98,6 @@ void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_sw_splice_eof(struct socket *sock);
-int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
-			   int offset, size_t size, int flags);
-int tls_sw_sendpage(struct sock *sk, struct page *page,
-		    int offset, size_t size, int flags);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
 void tls_sw_free_ctx_tx(struct tls_context *tls_ctx);
@@ -117,8 +113,6 @@ ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_device_splice_eof(struct socket *sock);
-int tls_device_sendpage(struct sock *sk, struct page *page,
-			int offset, size_t size, int flags);
 int tls_tx_records(struct sock *sk, int flags);
 
 void tls_sw_write_space(struct sock *sk, struct tls_context *ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 975299d7213b..840ee06f1708 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -621,23 +621,6 @@ void tls_device_splice_eof(struct socket *sock)
 	mutex_unlock(&tls_ctx->tx_lock);
 }
 
-int tls_device_sendpage(struct sock *sk, struct page *page,
-			int offset, size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	if (flags & MSG_OOB)
-		return -EOPNOTSUPP;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return tls_device_sendmsg(sk, &msg, size);
-}
-
 struct tls_record_info *tls_get_record(struct tls_offload_context_tx *context,
 				       u32 seq, u64 *p_record_sn)
 {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7b9c83dd7de2..d5ed4d47b16e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -958,7 +958,6 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 
 	ops[TLS_SW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
 	ops[TLS_SW  ][TLS_BASE].splice_eof	= tls_sw_splice_eof;
-	ops[TLS_SW  ][TLS_BASE].sendpage_locked	= tls_sw_sendpage_locked;
 
 	ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
 	ops[TLS_BASE][TLS_SW  ].splice_read	= tls_sw_splice_read;
@@ -970,17 +969,14 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 
 #ifdef CONFIG_TLS_DEVICE
 	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
-	ops[TLS_HW  ][TLS_BASE].sendpage_locked	= NULL;
 
 	ops[TLS_HW  ][TLS_SW  ] = ops[TLS_BASE][TLS_SW  ];
-	ops[TLS_HW  ][TLS_SW  ].sendpage_locked	= NULL;
 
 	ops[TLS_BASE][TLS_HW  ] = ops[TLS_BASE][TLS_SW  ];
 
 	ops[TLS_SW  ][TLS_HW  ] = ops[TLS_SW  ][TLS_SW  ];
 
 	ops[TLS_HW  ][TLS_HW  ] = ops[TLS_HW  ][TLS_SW  ];
-	ops[TLS_HW  ][TLS_HW  ].sendpage_locked	= NULL;
 #endif
 #ifdef CONFIG_TLS_TOE
 	ops[TLS_HW_RECORD][TLS_HW_RECORD] = *base;
@@ -1029,7 +1025,6 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_SW][TLS_BASE].sendmsg		= tls_sw_sendmsg;
 	prot[TLS_SW][TLS_BASE].splice_eof	= tls_sw_splice_eof;
-	prot[TLS_SW][TLS_BASE].sendpage		= tls_sw_sendpage;
 
 	prot[TLS_BASE][TLS_SW] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_BASE][TLS_SW].recvmsg		  = tls_sw_recvmsg;
@@ -1045,12 +1040,10 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_HW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
 	prot[TLS_HW][TLS_BASE].sendmsg		= tls_device_sendmsg;
 	prot[TLS_HW][TLS_BASE].splice_eof	= tls_device_splice_eof;
-	prot[TLS_HW][TLS_BASE].sendpage		= tls_device_sendpage;
 
 	prot[TLS_HW][TLS_SW] = prot[TLS_BASE][TLS_SW];
 	prot[TLS_HW][TLS_SW].sendmsg		= tls_device_sendmsg;
 	prot[TLS_HW][TLS_SW].splice_eof		= tls_device_splice_eof;
-	prot[TLS_HW][TLS_SW].sendpage		= tls_device_sendpage;
 
 	prot[TLS_BASE][TLS_HW] = prot[TLS_BASE][TLS_SW];
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 319f61590d2c..9b3aa89a4292 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1281,41 +1281,6 @@ void tls_sw_splice_eof(struct socket *sock)
 	mutex_unlock(&tls_ctx->tx_lock);
 }
 
-int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
-			   int offset, size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
-		      MSG_NO_SHARED_FRAGS))
-		return -EOPNOTSUPP;
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return tls_sw_sendmsg_locked(sk, &msg, size);
-}
-
-int tls_sw_sendpage(struct sock *sk, struct page *page,
-		    int offset, size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES, };
-
-	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
-		return -EOPNOTSUPP;
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return tls_sw_sendmsg(sk, &msg, size);
-}
-
 static int
 tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		bool released)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 73c61a010b01..3953daa2e1d0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -758,8 +758,6 @@ static int unix_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 static int unix_shutdown(struct socket *, int);
 static int unix_stream_sendmsg(struct socket *, struct msghdr *, size_t);
 static int unix_stream_recvmsg(struct socket *, struct msghdr *, size_t, int);
-static ssize_t unix_stream_sendpage(struct socket *, struct page *, int offset,
-				    size_t size, int flags);
 static ssize_t unix_stream_splice_read(struct socket *,  loff_t *ppos,
 				       struct pipe_inode_info *, size_t size,
 				       unsigned int flags);
@@ -852,7 +850,6 @@ static const struct proto_ops unix_stream_ops = {
 	.recvmsg =	unix_stream_recvmsg,
 	.read_skb =	unix_stream_read_skb,
 	.mmap =		sock_no_mmap,
-	.sendpage =	unix_stream_sendpage,
 	.splice_read =	unix_stream_splice_read,
 	.set_peek_off =	unix_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
@@ -878,7 +875,6 @@ static const struct proto_ops unix_dgram_ops = {
 	.read_skb =	unix_read_skb,
 	.recvmsg =	unix_dgram_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 	.set_peek_off =	unix_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
 };
@@ -902,7 +898,6 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_seqpacket_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 	.set_peek_off =	unix_set_peek_off,
 	.show_fdinfo =	unix_show_fdinfo,
 };
@@ -2294,20 +2289,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	return sent ? : err;
 }
 
-static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
-				    int offset, size_t size, int flags)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = flags | MSG_SPLICE_PAGES };
-
-	if (flags & MSG_SENDPAGE_NOTLAST)
-		msg.msg_flags |= MSG_MORE;
-
-	bvec_set_page(&bvec, page, size, offset);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-	return unix_stream_sendmsg(socket, &msg, size);
-}
-
 static int unix_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
 				  size_t len)
 {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index efb8a0937a13..020cf17ab7e4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1306,7 +1306,6 @@ static const struct proto_ops vsock_dgram_ops = {
 	.sendmsg = vsock_dgram_sendmsg,
 	.recvmsg = vsock_dgram_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 	.read_skb = vsock_read_skb,
 };
 
@@ -2234,7 +2233,6 @@ static const struct proto_ops vsock_stream_ops = {
 	.sendmsg = vsock_connectible_sendmsg,
 	.recvmsg = vsock_connectible_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 	.set_rcvlowat = vsock_set_rcvlowat,
 	.read_skb = vsock_read_skb,
 };
@@ -2257,7 +2255,6 @@ static const struct proto_ops vsock_seqpacket_ops = {
 	.sendmsg = vsock_connectible_sendmsg,
 	.recvmsg = vsock_connectible_recvmsg,
 	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
 	.read_skb = vsock_read_skb,
 };
 
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5c7ad301d742..0fb5143bec7a 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1757,7 +1757,6 @@ static const struct proto_ops x25_proto_ops = {
 	.sendmsg =	x25_sendmsg,
 	.recvmsg =	x25_recvmsg,
 	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
 };
 
 static struct packet_type x25_packet_type __read_mostly = {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cc1e7f15fa73..5a8c0dd250af 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1389,7 +1389,6 @@ static const struct proto_ops xsk_proto_ops = {
 	.sendmsg	= xsk_sendmsg,
 	.recvmsg	= xsk_recvmsg,
 	.mmap		= xsk_mmap,
-	.sendpage	= sock_no_sendpage,
 };
 
 static void xsk_destruct(struct sock *sk)

