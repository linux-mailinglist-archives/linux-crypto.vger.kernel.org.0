Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C419E35EDD6
	for <lists+linux-crypto@lfdr.de>; Wed, 14 Apr 2021 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbhDNGxf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Apr 2021 02:53:35 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47569 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349501AbhDNGx3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Apr 2021 02:53:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UVWI.CM_1618383179;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVWI.CM_1618383179)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 14:53:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ayush.sawal@chelsio.com
Cc:     vinay.yadav@chelsio.com, rohitm@chelsio.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: chelsio - remove unused function
Date:   Wed, 14 Apr 2021 14:52:57 +0800
Message-Id: <1618383177-9832-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following clang warning:

drivers/crypto/chelsio/chcr_algo.c:129:19: warning: unused function
'is_ofld_imm' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index f5a3366..c04cb49 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -126,11 +126,6 @@ static inline struct uld_ctx *ULD_CTX(struct chcr_context *ctx)
 	return container_of(ctx->dev, struct uld_ctx, dev);
 }
 
-static inline int is_ofld_imm(const struct sk_buff *skb)
-{
-	return (skb->len <= SGE_MAX_WR_LEN);
-}
-
 static inline void chcr_init_hctx_per_wr(struct chcr_ahash_req_ctx *reqctx)
 {
 	memset(&reqctx->hctx_wr, 0, sizeof(struct chcr_hctx_per_wr));
-- 
1.8.3.1

