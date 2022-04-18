Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C3504E2C
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Apr 2022 11:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbiDRJHW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Apr 2022 05:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiDRJHO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Apr 2022 05:07:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0F101D2
        for <linux-crypto@vger.kernel.org>; Mon, 18 Apr 2022 02:04:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q12so17766666pgj.13
        for <linux-crypto@vger.kernel.org>; Mon, 18 Apr 2022 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMvFUIaJUZFaJh2w5O1uB3m37o1dGCP/mCJGRZ5s3NE=;
        b=IBECHa46OyWpM94Z/h4vDnACfq0tVl58F+SMJ9PfXQAAMiqg2Y09tHJr0N2hoPaJ5q
         4bTUHlZebBHyp3V2cptNxrnvXndYD+xsIaUvqnLbOSY+1zQGy6UzHUEgb3sqkzI+2D/h
         uc12HSLcFjEAYO4ddKfKGjceCIXX9GTHkenXEN4DFjbjsFn+eAtdrz8CzyJMxHeFoMSR
         pmfiLvNEsEYi9K+5NLPHOQ7n8GdjW9WkG2NBuF8rjVzommUw87UPeqdQiTzvUo0N48TV
         KBnv5L4F25f/50rHEgUZY1cyyWx+SddThQZA4PEGWI0CMCFkpmnD338sddKoy2fR+U2G
         kirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMvFUIaJUZFaJh2w5O1uB3m37o1dGCP/mCJGRZ5s3NE=;
        b=iazxUHjFNpMBxC6PeK1rayhiUbXlJHxXndaB+lAhdrnCYC2/fBdD5OO/G8WWKDHHFr
         jEVg85HrAu5IoCq8tvaYdZWyjJ7xQZ0XlUxCsOlWYA/BzGHjCclxFSK3LBCn+dkIN3YF
         VsG3n14uzbR9Hv1Qz8UwwY5sSiz1nxr8bw6NkDGMqwb9RFeNo5wgMxcOd03yu7qptk2A
         Bqhx3hdhJkKQyh6A4aEVbDO1xY0s1dklZXmBywntNhqdZu9YMAVcIHlkvLXD/eVxRiUD
         zgQLi0FBgSb2iCslHZ2Hj2ngMV7HERy4vDgobNszeklQexU84FWv4PDv/80zlAbPWiH9
         NxLQ==
X-Gm-Message-State: AOAM531vXJkCT/lGooI+knSestsxevM1H+yCtLjf5VfST1qS11fJGytx
        CqHg5CAUc3K65Kxrj31/unFs0t39hNt3Sg==
X-Google-Smtp-Source: ABdhPJz4Nb26RqRQjtNIYYqsan0fWQfU6kBj4xxwdkTln4B7PpiksAP6pXThqAg3kASRrwDF0XSBXg==
X-Received: by 2002:a05:6a00:c8d:b0:50a:62e5:6d30 with SMTP id a13-20020a056a000c8d00b0050a62e56d30mr7319810pfv.47.1650272674434;
        Mon, 18 Apr 2022 02:04:34 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:04:33 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/4] virtio-crypto: wait ctrl queue instead of busy polling
Date:   Mon, 18 Apr 2022 17:00:48 +0800
Message-Id: <20220418090051.372803-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418090051.372803-1-pizhenwei@bytedance.com>
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Originally, after submitting request into virtio crypto control
queue, the guest side polls the result from the virt queue. This
allows all of the requests share a single request buffer in
struct virtio_crypto(ctrl&input&ctrl_status).
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
                  busy poll virtqueue
                           |
              spin_unlock(&vcrypto->ctrl_lock)
                          ...

There are two problems:
1, The queue depth is always 1, the performance of a virtio crypto
   device gets limited. Multi user processes share a single control
   queue, and hit spin lock race from control queue. Test on Intel
   Platinum 8260, a single worker gets ~35K/s create/close session
   operations, and 8 workers get ~40K/s operations with 800% CPU
   utilization.
2, The control request is supposed to get handled immediately, but
   in the current implementation of QEMU(v6.2), the vCPU thread kicks
   another thread to do this work, the latency also gets unstable.
   Tracking latency of virtio_crypto_alg_akcipher_close_session in 5s:
        usecs               : count     distribution
         0 -> 1          : 0        |                        |
         2 -> 3          : 7        |                        |
         4 -> 7          : 72       |                        |
         8 -> 15         : 186485   |************************|
        16 -> 31         : 687      |                        |
        32 -> 63         : 5        |                        |
        64 -> 127        : 3        |                        |
       128 -> 255        : 1        |                        |
       256 -> 511        : 0        |                        |
       512 -> 1023       : 0        |                        |
      1024 -> 2047       : 0        |                        |
      2048 -> 4095       : 0        |                        |
      4096 -> 8191       : 0        |                        |
      8192 -> 16383      : 2        |                        |
   This means that a CPU may hold vcrypto->ctrl_lock as long as 8192~16383us.

To improve the performance of control queue, remove ctrl&input&ctrl_status from
struct virtio_crypto, each request allocates request buffer dynamically, waits
completion instead of busy polling to reduce lock racing, and gets completed by
control queue callback.
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
      ---------spin_unlock(&vcrypto->ctrl_lock)------
     /      /                                  \     \
     |      |                                  |     |
    wait   wait                               wait  wait

Test this patch, the guest side get ~200K/s operations with 300% CPU
utilization.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  90 ++++++------
 drivers/crypto/virtio/virtio_crypto_common.c  |  61 ++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  25 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |   2 +-
 .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
 6 files changed, 185 insertions(+), 127 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
index bfa6cbae342e..49c1fa80e465 100644
--- a/drivers/crypto/virtio/Makefile
+++ b/drivers/crypto/virtio/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
 virtio_crypto-objs := \
 	virtio_crypto_skcipher_algs.o \
 	virtio_crypto_akcipher_algs.o \
+	virtio_crypto_common.o \
 	virtio_crypto_mgr.o \
 	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index f3ec9420215e..9561bc2df62b 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -102,8 +102,8 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 {
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
 	uint8_t *pkey;
-	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
 
@@ -111,98 +111,91 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	if (!pkey)
 		return -ENOMEM;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
-	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req) {
+		err = -ENOMEM;
+		goto out;
+	}
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	memcpy(&vc_ctrl_req->ctrl.header, header, sizeof(vc_ctrl_req->ctrl.header));
+	memcpy(&vc_ctrl_req->ctrl.u, para, sizeof(vc_ctrl_req->ctrl.u));
+	sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
 	sg_init_one(&key_sg, pkey, keylen);
 	sgs[num_out++] = &key_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	sg_init_one(&inhdr_sg, &vc_ctrl_req->input, sizeof(vc_ctrl_req->input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
 	if (err < 0)
 		goto out;
 
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
+		pr_err("virtio_crypto: Create session failed status: %u\n",
+			le32_to_cpu(vc_ctrl_req->input.status));
 		err = -EINVAL;
 		goto out;
 	}
 
-	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_id = le64_to_cpu(vc_ctrl_req->input.session_id);
 	ctx->session_valid = true;
 	err = 0;
 
 out:
-	spin_unlock(&vcrypto->ctrl_lock);
+	kfree(vc_ctrl_req);
 	kfree_sensitive(pkey);
 
-	if (err < 0)
-		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
-
 	return err;
 }
 
 static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
 {
 	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
-	unsigned int num_out = 0, num_in = 0, inlen;
+	unsigned int num_out = 0, num_in = 0;
 	int err;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	if (!ctx->session_valid) {
-		err = 0;
-		goto out;
-	}
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
-	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
-	vcrypto->ctrl.header.queue_id = 0;
+	if (!ctx->session_valid)
+		return 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req)
+		return -ENOMEM;
+
+	vc_ctrl_req->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	vc_ctrl_req->ctrl.header.queue_id = 0;
+
+	destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
 	destroy_session->session_id = cpu_to_le64(ctx->session_id);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	sg_init_one(&inhdr_sg, &vc_ctrl_req->ctrl_status.status,
+		sizeof(vc_ctrl_req->ctrl_status.status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
 	if (err < 0)
 		goto out;
 
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
+		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
+			vc_ctrl_req->ctrl_status.status, destroy_session->session_id);
 		goto out;
 	}
 
 	err = 0;
 	ctx->session_valid = false;
-
 out:
-	spin_unlock(&vcrypto->ctrl_lock);
-	if (err < 0) {
-		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status, destroy_session->session_id);
-	}
+	kfree(vc_ctrl_req);
 
 	return err;
 }
@@ -210,14 +203,11 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
 		struct akcipher_request *req, struct data_queue *data_vq)
 {
-	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
 	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
-	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
 	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
 	void *src_buf = NULL, *dst_buf = NULL;
 	unsigned int num_out = 0, num_in = 0;
-	int node = dev_to_node(&vcrypto->vdev->dev);
 	unsigned long flags;
 	int ret = -ENOMEM;
 	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
@@ -228,7 +218,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	sgs[num_out++] = &outhdr_sg;
 
 	/* src data */
-	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
+	src_buf = kcalloc(src_len, 1, GFP_KERNEL);
 	if (!src_buf)
 		goto err;
 
@@ -243,7 +233,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 		sgs[num_out++] = &srcdata_sg;
 
 		/* dst data */
-		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
+		dst_buf = kcalloc(req->dst_len, 1, GFP_KERNEL);
 		if (!dst_buf)
 			goto err;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
new file mode 100644
index 000000000000..93df73c40dd3
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_common.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Common functions and helpers
+ *
+ * Authors: zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * Copyright 2022 Bytedance CO., LTD.
+ */
+
+#include "virtio_crypto_common.h"
+
+static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	complete(&vc_ctrl_req->compl);
+}
+
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+				  unsigned int out_sgs, unsigned int in_sgs,
+				  struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	int err;
+	unsigned long flags;
+
+	init_completion(&vc_ctrl_req->compl);
+	vc_ctrl_req->ctrl_cb =  virtio_crypto_ctrlq_callback;
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+		return err;
+	}
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+
+	wait_for_completion(&vc_ctrl_req->compl);
+
+	return 0;
+}
+
+void virtcrypto_ctrlq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+			if (vc_ctrl_req->ctrl_cb)
+				vc_ctrl_req->ctrl_cb(vc_ctrl_req);
+			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+		}
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index e693d4ee83a6..b90ac0ce30d2 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -13,6 +13,7 @@
 #include <crypto/aead.h>
 #include <crypto/aes.h>
 #include <crypto/engine.h>
+#include <uapi/linux/virtio_crypto.h>
 
 
 /* Internal representation of a data virtqueue */
@@ -65,11 +66,6 @@ struct virtio_crypto {
 	/* Maximum size of per request */
 	u64 max_size;
 
-	/* Control VQ buffers: protected by the ctrl_lock */
-	struct virtio_crypto_op_ctrl_req ctrl;
-	struct virtio_crypto_session_input input;
-	struct virtio_crypto_inhdr ctrl_status;
-
 	unsigned long status;
 	atomic_t ref_count;
 	struct list_head list;
@@ -85,6 +81,20 @@ struct virtio_crypto_sym_session_info {
 	__u64 session_id;
 };
 
+struct virtio_crypto_ctrl_request;
+typedef void (*virtio_crypto_ctrl_callback)
+		(struct virtio_crypto_ctrl_request *vc_ctrl_req);
+
+/* Note: there are padding fields in request, clear them to zero before sending to host,
+ * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48] */
+struct virtio_crypto_ctrl_request {
+	struct virtio_crypto_op_ctrl_req ctrl;
+	struct virtio_crypto_session_input input;
+	struct virtio_crypto_inhdr ctrl_status;
+	virtio_crypto_ctrl_callback ctrl_cb;
+	struct completion compl;
+};
+
 struct virtio_crypto_request;
 typedef void (*virtio_crypto_data_callback)
 		(struct virtio_crypto_request *vc_req, int len);
@@ -135,4 +145,9 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
 
+void virtcrypto_ctrlq_callback(struct virtqueue *vq);
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+				  unsigned int out_sgs, unsigned int in_sgs,
+				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
+
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c6f482db0bc0..e668d4b1bc6a 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -73,7 +73,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		goto err_names;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = NULL;
+	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
 	names[total_vqs - 1] = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index a618c46a52b8..fef355ff461c 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -118,11 +118,13 @@ static int virtio_crypto_alg_skcipher_init_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
-	unsigned int tmp;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+	struct virtio_crypto_ctrl_header *header;
+	struct virtio_crypto_sym_create_session_req *sym_create_session;
 
 	/*
 	 * Avoid to do DMA from the stack, switch to using
@@ -133,26 +135,27 @@ static int virtio_crypto_alg_skcipher_init_session(
 	if (!cipher_key)
 		return -ENOMEM;
 
-	spin_lock(&vcrypto->ctrl_lock);
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
-	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	header = &vc_ctrl_req->ctrl.header;
+	header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	header->algo = cpu_to_le32(alg);
 	/* Set the default dataqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	header->queue_id = 0;
 
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 	/* Pad cipher's parameters */
-	vcrypto->ctrl.u.sym_create_session.op_type =
-		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
-		vcrypto->ctrl.header.algo;
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
-		cpu_to_le32(keylen);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
-		cpu_to_le32(op);
-
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sym_create_session = &vc_ctrl_req->ctrl.u.sym_create_session;
+	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	sym_create_session->u.cipher.para.algo = header->algo;
+	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
+	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
+
+	sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Set key */
@@ -160,45 +163,34 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sgs[num_out++] = &key_sg;
 
 	/* Return status and session id back */
-	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	sg_init_one(&inhdr, &vc_ctrl_req->input, sizeof(vc_ctrl_req->input));
 	sgs[num_out + num_in++] = &inhdr;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-				num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
-		kfree_sensitive(cipher_key);
-		return err;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	/*
-	 * Trapping into the hypervisor, so the request should be
-	 * handled immediately.
-	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
-		kfree_sensitive(cipher_key);
-		return -EINVAL;
+			le32_to_cpu(vc_ctrl_req->input.status));
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (encrypt)
 		ctx->enc_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+			le64_to_cpu(vc_ctrl_req->input.session_id);
 	else
 		ctx->dec_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
-
-	spin_unlock(&vcrypto->ctrl_lock);
+			le64_to_cpu(vc_ctrl_req->input.session_id);
 
+	err = 0;
+out:
+	kfree(vc_ctrl_req);
 	kfree_sensitive(cipher_key);
-	return 0;
+
+	return err;
 }
 
 static int virtio_crypto_alg_skcipher_close_session(
@@ -206,21 +198,24 @@ static int virtio_crypto_alg_skcipher_close_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, status_sg, *sgs[2];
-	unsigned int tmp;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+	struct virtio_crypto_ctrl_header *header;
+
+	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
+	if (!vc_ctrl_req)
+		return -ENOMEM;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	header = &vc_ctrl_req->ctrl.header;
+	header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
 	/* Set the default virtqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	header->queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
 
 	if (encrypt)
 		destroy_session->session_id =
@@ -229,37 +224,33 @@ static int virtio_crypto_alg_skcipher_close_session(
 		destroy_session->session_id =
 			cpu_to_le64(ctx->dec_sess_info.session_id);
 
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Return status and session id back */
-	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
-		sizeof(vcrypto->ctrl_status.status));
+	vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	sg_init_one(&status_sg, &vc_ctrl_req->ctrl_status.status,
+		sizeof(vc_ctrl_req->ctrl_status.status));
 	sgs[num_out + num_in++] = &status_sg;
 
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-			num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
-		return err;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
+		goto out;
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status,
+			vc_ctrl_req->ctrl_status.status,
 			destroy_session->session_id);
 
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
-	spin_unlock(&vcrypto->ctrl_lock);
 
-	return 0;
+	err = 0;
+out:
+	kfree(vc_ctrl_req);
+
+	return err;
 }
 
 static int virtio_crypto_alg_skcipher_init_sessions(
-- 
2.20.1

