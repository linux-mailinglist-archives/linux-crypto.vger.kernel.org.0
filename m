Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A55E767B
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Sep 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiIWJIr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Sep 2022 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiIWJIj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Sep 2022 05:08:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9AC12ED83
        for <linux-crypto@vger.kernel.org>; Fri, 23 Sep 2022 02:08:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYmR12M5nzMpZ6;
        Fri, 23 Sep 2022 17:03:41 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:08:24 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ardb@kernel.org>, <t-kristo@ti.com>, <cuigaosheng1@huawei.com>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 2/3] crypto: aead - Remove unused inline functions from aead
Date:   Fri, 23 Sep 2022 17:08:22 +0800
Message-ID: <20220923090823.509656-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923090823.509656-1-cuigaosheng1@huawei.com>
References: <20220923090823.509656-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The aead_enqueue_request, aead_dequeue_request and aead_get_backlog
are no longer used since commit 04a4616e6a21 ("crypto: omap-aes-gcm
- convert to use crypto engine"), their functinoality has been
replaced by crypto engine, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/crypto/internal/aead.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/crypto/internal/aead.h b/include/crypto/internal/aead.h
index 27b7b0224ea6..d482017f3e20 100644
--- a/include/crypto/internal/aead.h
+++ b/include/crypto/internal/aead.h
@@ -114,31 +114,6 @@ static inline void aead_init_queue(struct aead_queue *queue,
 	crypto_init_queue(&queue->base, max_qlen);
 }
 
-static inline int aead_enqueue_request(struct aead_queue *queue,
-				       struct aead_request *request)
-{
-	return crypto_enqueue_request(&queue->base, &request->base);
-}
-
-static inline struct aead_request *aead_dequeue_request(
-	struct aead_queue *queue)
-{
-	struct crypto_async_request *req;
-
-	req = crypto_dequeue_request(&queue->base);
-
-	return req ? container_of(req, struct aead_request, base) : NULL;
-}
-
-static inline struct aead_request *aead_get_backlog(struct aead_queue *queue)
-{
-	struct crypto_async_request *req;
-
-	req = crypto_get_backlog(&queue->base);
-
-	return req ? container_of(req, struct aead_request, base) : NULL;
-}
-
 static inline unsigned int crypto_aead_alg_chunksize(struct aead_alg *alg)
 {
 	return alg->chunksize;
-- 
2.25.1

