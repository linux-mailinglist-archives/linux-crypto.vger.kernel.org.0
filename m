Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4416EBD8
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Feb 2020 17:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgBYQ5x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Feb 2020 11:57:53 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:54524 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYQ5x (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Feb 2020 11:57:53 -0500
Received: from localhost.localdomain (cyclone.blr.asicdesigners.com [10.193.186.206])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01PGvfo8021502;
        Tue, 25 Feb 2020 08:57:42 -0800
From:   Vinay Kumar Yadav <vinay.yadav@chelsio.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Cc:     Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Subject: [PATCH] crypto/chelsio: Fixed tls stats
Date:   Tue, 25 Feb 2020 22:21:20 +0530
Message-Id: <20200225165119.15798-1-vinay.yadav@chelsio.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Added tls rx stats and reset tls rx/tx stats when chtls driver unload.

Signed-off-by: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
---
 drivers/crypto/chelsio/chtls/chtls_io.c   | 3 +++
 drivers/crypto/chelsio/chtls/chtls_main.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 5cf9b021220b..781fe7c55a27 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1399,6 +1399,8 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
 	struct chtls_hws *hws = &csk->tlshws;
+	struct net_device *dev = csk->egress_dev;
+	struct adapter *adap = netdev2adap(dev);
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long avail;
 	int buffers_freed;
@@ -1540,6 +1542,7 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				tp->copied_seq += skb->len;
 				hws->rcvpld = skb->hdr_len;
 			} else {
+				atomic_inc(&adap->chcr_stats.tls_pdu_rx);
 				tp->copied_seq += hws->rcvpld;
 			}
 			chtls_free_skb(sk, skb);
diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index 9f06abd340cc..2110d0893bc7 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -174,9 +174,16 @@ static inline void chtls_dev_release(struct kref *kref)
 {
 	struct tls_toe_device *dev;
 	struct chtls_dev *cdev;
+	struct adapter *adap;
 
 	dev = container_of(kref, struct tls_toe_device, kref);
 	cdev = to_chtls_dev(dev);
+
+	/* Reset tls rx/tx stats */
+	adap = pci_get_drvdata(cdev->pdev);
+	atomic_set(&adap->chcr_stats.tls_pdu_tx, 0);
+	atomic_set(&adap->chcr_stats.tls_pdu_rx, 0);
+
 	chtls_free_uld(cdev);
 }
 
-- 
2.24.1

