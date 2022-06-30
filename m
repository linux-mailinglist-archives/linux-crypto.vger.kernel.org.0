Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297D561A36
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jun 2022 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiF3MVW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Jun 2022 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiF3MVW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Jun 2022 08:21:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFBF22BCC;
        Thu, 30 Jun 2022 05:21:20 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LYcp56W9kzkWfY;
        Thu, 30 Jun 2022 20:19:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 20:21:18 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>, <liulongfang@huawei.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH v2] crypto: hisilicon/sec - don't sleep when in softirq
Date:   Thu, 30 Jun 2022 20:26:22 +0800
Message-ID: <20220630122622.55492-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When kunpeng920 encryption driver is used to deencrypt and decrypt
packets during the softirq, it is not allowed to use mutex lock. The
kernel will report the following error:

BUG: scheduling while atomic: swapper/57/0/0x00000300
Call trace:
dump_backtrace+0x0/0x1e4
show_stack+0x20/0x2c
dump_stack+0xd8/0x140
__schedule_bug+0x68/0x80
__schedule+0x728/0x840
schedule+0x50/0xe0
schedule_preempt_disabled+0x18/0x24
__mutex_lock.constprop.0+0x594/0x5dc
__mutex_lock_slowpath+0x1c/0x30
mutex_lock+0x50/0x60
sec_request_init+0x8c/0x1a0 [hisi_sec2]
sec_process+0x28/0x1ac [hisi_sec2]
sec_skcipher_crypto+0xf4/0x1d4 [hisi_sec2]
sec_skcipher_encrypt+0x1c/0x30 [hisi_sec2]
crypto_skcipher_encrypt+0x2c/0x40
crypto_authenc_encrypt+0xc8/0xfc [authenc]
crypto_aead_encrypt+0x2c/0x40
echainiv_encrypt+0x144/0x1a0 [echainiv]
crypto_aead_encrypt+0x2c/0x40
esp_output_tail+0x348/0x5c0 [esp4]
esp_output+0x120/0x19c [esp4]
xfrm_output_one+0x25c/0x4d4
xfrm_output_resume+0x6c/0x1fc
xfrm_output+0xac/0x3c0
xfrm4_output+0x64/0x130
ip_build_and_send_pkt+0x158/0x20c
tcp_v4_send_synack+0xdc/0x1f0
tcp_conn_request+0x7d0/0x994
tcp_v4_conn_request+0x58/0x6c
tcp_v6_conn_request+0xf0/0x100
tcp_rcv_state_process+0x1cc/0xd60
tcp_v4_do_rcv+0x10c/0x250
tcp_v4_rcv+0xfc4/0x10a4
ip_protocol_deliver_rcu+0xf4/0x200
ip_local_deliver_finish+0x58/0x70
ip_local_deliver+0x68/0x120
ip_sublist_rcv_finish+0x70/0x94
ip_list_rcv_finish.constprop.0+0x17c/0x1d0
ip_sublist_rcv+0x40/0xb0
ip_list_rcv+0x140/0x1dc
__netif_receive_skb_list_core+0x154/0x28c
__netif_receive_skb_list+0x120/0x1a0
netif_receive_skb_list_internal+0xe4/0x1f0
napi_complete_done+0x70/0x1f0
gro_cell_poll+0x9c/0xb0
napi_poll+0xcc/0x264
net_rx_action+0xd4/0x21c
__do_softirq+0x130/0x358
irq_exit+0x11c/0x13c
__handle_domain_irq+0x88/0xf0
gic_handle_irq+0x78/0x2c0
el1_irq+0xb8/0x140
arch_cpu_idle+0x18/0x40
default_idle_call+0x5c/0x1c0
cpuidle_idle_call+0x174/0x1b0
do_idle+0xc8/0x160
cpu_startup_entry+0x30/0x11c
secondary_start_kernel+0x158/0x1e4
softirq: huh, entered softirq 3 NET_RX 0000000093774ee4 with
preempt_count 00000100, exited with fffffe00?

V1: use spin_lock will cause soft lockup

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  2 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 42bb486f3b6d..d2a0bc93e752 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -119,7 +119,7 @@ struct sec_qp_ctx {
 	struct idr req_idr;
 	struct sec_alg_res res[QM_Q_DEPTH];
 	struct sec_ctx *ctx;
-	struct mutex req_lock;
+	spinlock_t req_lock;
 	struct list_head backlog;
 	struct hisi_acc_sgl_pool *c_in_pool;
 	struct hisi_acc_sgl_pool *c_out_pool;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 6eebe739893c..71dfa7db6394 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -127,11 +127,11 @@ static int sec_alloc_req_id(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
 {
 	int req_id;
 
-	mutex_lock(&qp_ctx->req_lock);
+	spin_lock_bh(&qp_ctx->req_lock);
 
 	req_id = idr_alloc_cyclic(&qp_ctx->req_idr, NULL,
 				  0, QM_Q_DEPTH, GFP_ATOMIC);
-	mutex_unlock(&qp_ctx->req_lock);
+	spin_unlock_bh(&qp_ctx->req_lock);
 	if (unlikely(req_id < 0)) {
 		dev_err(req->ctx->dev, "alloc req id fail!\n");
 		return req_id;
@@ -156,9 +156,9 @@ static void sec_free_req_id(struct sec_req *req)
 	qp_ctx->req_list[req_id] = NULL;
 	req->qp_ctx = NULL;
 
-	mutex_lock(&qp_ctx->req_lock);
+	spin_lock_bh(&qp_ctx->req_lock);
 	idr_remove(&qp_ctx->req_idr, req_id);
-	mutex_unlock(&qp_ctx->req_lock);
+	spin_unlock_bh(&qp_ctx->req_lock);
 }
 
 static u8 pre_parse_finished_bd(struct bd_status *status, void *resp)
@@ -273,7 +273,7 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 	    !(req->flag & CRYPTO_TFM_REQ_MAY_BACKLOG))
 		return -EBUSY;
 
-	mutex_lock(&qp_ctx->req_lock);
+	spin_lock_bh(&qp_ctx->req_lock);
 	ret = hisi_qp_send(qp_ctx->qp, &req->sec_sqe);
 
 	if (ctx->fake_req_limit <=
@@ -281,10 +281,10 @@ static int sec_bd_send(struct sec_ctx *ctx, struct sec_req *req)
 		list_add_tail(&req->backlog_head, &qp_ctx->backlog);
 		atomic64_inc(&ctx->sec->debug.dfx.send_cnt);
 		atomic64_inc(&ctx->sec->debug.dfx.send_busy_cnt);
-		mutex_unlock(&qp_ctx->req_lock);
+		spin_unlock_bh(&qp_ctx->req_lock);
 		return -EBUSY;
 	}
-	mutex_unlock(&qp_ctx->req_lock);
+	spin_unlock_bh(&qp_ctx->req_lock);
 
 	if (unlikely(ret == -EBUSY))
 		return -ENOBUFS;
@@ -487,7 +487,7 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 
 	qp->req_cb = sec_req_cb;
 
-	mutex_init(&qp_ctx->req_lock);
+	spin_lock_init(&qp_ctx->req_lock);
 	idr_init(&qp_ctx->req_idr);
 	INIT_LIST_HEAD(&qp_ctx->backlog);
 
@@ -1382,7 +1382,7 @@ static struct sec_req *sec_back_req_clear(struct sec_ctx *ctx,
 {
 	struct sec_req *backlog_req = NULL;
 
-	mutex_lock(&qp_ctx->req_lock);
+	spin_lock_bh(&qp_ctx->req_lock);
 	if (ctx->fake_req_limit >=
 	    atomic_read(&qp_ctx->qp->qp_status.used) &&
 	    !list_empty(&qp_ctx->backlog)) {
@@ -1390,7 +1390,7 @@ static struct sec_req *sec_back_req_clear(struct sec_ctx *ctx,
 				typeof(*backlog_req), backlog_head);
 		list_del(&backlog_req->backlog_head);
 	}
-	mutex_unlock(&qp_ctx->req_lock);
+	spin_unlock_bh(&qp_ctx->req_lock);
 
 	return backlog_req;
 }
-- 
2.17.1

