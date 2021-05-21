Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17738C3B3
	for <lists+linux-crypto@lfdr.de>; Fri, 21 May 2021 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhEUJq0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 05:46:26 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52090 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhEUJqZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 05:46:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZb3Pkt_1621590294;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZb3Pkt_1621590294)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 May 2021 17:45:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: qce - Fix inconsistent indenting
Date:   Fri, 21 May 2021 17:44:52 +0800
Message-Id: <1621590292-71009-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eliminate the follow smatch warning:

drivers/crypto/qce/aead.c:85 qce_aead_done() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/qce/aead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6d06a19..213d3a1 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -82,7 +82,7 @@ static void qce_aead_done(void *data)
 		ret = memcmp(result_buf->auth_iv, tag, ctx->authsize);
 		if (ret) {
 			pr_err("Bad message error\n");
-			 error = -EBADMSG;
+			error = -EBADMSG;
 		}
 	}
 
-- 
1.8.3.1

