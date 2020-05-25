Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBEA1E043D
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2020 02:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgEYA4t (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 24 May 2020 20:56:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388303AbgEYA4s (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 24 May 2020 20:56:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 854FEC909179FD7431D5;
        Mon, 25 May 2020 08:56:46 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.151.115) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 25 May 2020 08:56:39 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <linux-crypto@vger.kernel.org>
CC:     "Longpeng(Mike)" <longpeng2@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe@baylibre.com>
Subject: [PATCH 1/2] crypto: virtio: fix src/dst scatterlist calculation
Date:   Mon, 25 May 2020 08:56:26 +0800
Message-ID: <20200525005627.707-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20200525005627.707-1-longpeng2@huawei.com>
References: <20200525005627.707-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.115]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The system will crash when we insmod crypto/tcrypt.ko whit mode=38.

Usually the next entry of one sg will be @sg@ + 1, but if this sg element
is part of a chained scatterlist, it could jump to the start of a new
scatterlist array. Let's fix it by sg_next() on calculation of src/dst
scatterlist.

BTW I add a check for sg_nents_for_len() its return value since
sg_nents_for_len() function could fail.

Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Reported-by: LABBE Corentin <clabbe@baylibre.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 372babb44112..2fa1129f96d6 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -359,8 +359,14 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
 	unsigned int num_out = 0, num_in = 0;
 	int sg_total;
 	uint8_t *iv;
+	struct scatterlist *sg;
 
 	src_nents = sg_nents_for_len(req->src, req->cryptlen);
+	if (src_nents < 0) {
+		pr_err("Invalid number of src SG.\n");
+		return src_nents;
+	}
+
 	dst_nents = sg_nents(req->dst);
 
 	pr_debug("virtio_crypto: Number of sgs (src_nents: %d, dst_nents: %d)\n",
@@ -446,12 +452,12 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
 	vc_sym_req->iv = iv;
 
 	/* Source data */
-	for (i = 0; i < src_nents; i++)
-		sgs[num_out++] = &req->src[i];
+	for (sg = req->src, i = 0; sg && i < src_nents; sg = sg_next(sg), i++)
+		sgs[num_out++] = sg;
 
 	/* Destination data */
-	for (i = 0; i < dst_nents; i++)
-		sgs[num_out + num_in++] = &req->dst[i];
+	for (sg = req->dst, i = 0; sg && i < dst_nents; sg = sg_next(sg), i++)
+		sgs[num_out + num_in++] = sg;
 
 	/* Status */
 	sg_init_one(&status_sg, &vc_req->status, sizeof(vc_req->status));
-- 
2.17.1

