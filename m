Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24809EFE5F
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Nov 2019 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfKEN2o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Nov 2019 08:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388963AbfKEN2o (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Nov 2019 08:28:44 -0500
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr [92.154.90.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1142190F;
        Tue,  5 Nov 2019 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572960523;
        bh=Nh55X7sYvLj2U2aGXFSuv9DJufS5jhXrUnAVYoR+7lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGKA6jzI0/JCyVEE3DeT0DtgGL3Ax03v0vHO1u7dhmWuyhf59QN02FSu+Qd6A/J7q
         QHpaMTIVQkBwz6htket2Pv04BfuyYQmuTLsGiLZhJ00lcl+Id6oayPA6Xh6XyJ4g6W
         lV7RtZszytcimf+g1OLSta/T02zJQY7kQY9R7oZ4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gonglei <arei.gonglei@huawei.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 02/29] crypto: virtio - deal with unsupported input sizes
Date:   Tue,  5 Nov 2019 14:27:59 +0100
Message-Id: <20191105132826.1838-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105132826.1838-1-ardb@kernel.org>
References: <20191105132826.1838-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Return -EINVAL for input sizes that are not a multiple of the AES
block size, since they are not supported by our CBC chaining mode.

While at it, remove the pr_err() that reports unsupported key sizes
being used: we shouldn't spam the kernel log with that.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index 65ec10800137..82b316b2f537 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -105,8 +105,6 @@ virtio_crypto_alg_validate_key(int key_len, uint32_t *alg)
 		*alg = VIRTIO_CRYPTO_CIPHER_AES_CBC;
 		break;
 	default:
-		pr_err("virtio_crypto: Unsupported key length: %d\n",
-			key_len);
 		return -EINVAL;
 	}
 	return 0;
@@ -489,6 +487,11 @@ static int virtio_crypto_ablkcipher_encrypt(struct ablkcipher_request *req)
 	/* Use the first data virtqueue as default */
 	struct data_queue *data_vq = &vcrypto->data_vq[0];
 
+	if (!req->nbytes)
+		return 0;
+	if (req->nbytes % AES_BLOCK_SIZE)
+		return -EINVAL;
+
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
 	vc_sym_req->ablkcipher_ctx = ctx;
@@ -509,6 +512,11 @@ static int virtio_crypto_ablkcipher_decrypt(struct ablkcipher_request *req)
 	/* Use the first data virtqueue as default */
 	struct data_queue *data_vq = &vcrypto->data_vq[0];
 
+	if (!req->nbytes)
+		return 0;
+	if (req->nbytes % AES_BLOCK_SIZE)
+		return -EINVAL;
+
 	vc_req->dataq = data_vq;
 	vc_req->alg_cb = virtio_crypto_dataq_sym_callback;
 	vc_sym_req->ablkcipher_ctx = ctx;
-- 
2.20.1

