Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF3729B5D
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Jun 2023 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbjFINSr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Jun 2023 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjFINSk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Jun 2023 09:18:40 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A513596;
        Fri,  9 Jun 2023 06:18:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VkiFAAr_1686316709;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VkiFAAr_1686316709)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 21:18:29 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, amit@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <tianxianting.txt@alibaba-inc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free unused bufs
Date:   Fri,  9 Jun 2023 21:18:15 +0800
Message-Id: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Xianting Tian <tianxianting.txt@alibaba-inc.com>

Cpu stall issue may happen if device is configured with multi queues
and large queue depth, so fix it.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 1198bd306365..94849fa3bd74 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
 			kfree(vc_req->req_data);
 			kfree(vc_req->sgs);
 		}
+		cond_resched();
 	}
 }
 
-- 
2.17.1

