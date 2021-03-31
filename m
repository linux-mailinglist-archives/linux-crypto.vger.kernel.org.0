Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919B834F789
	for <lists+linux-crypto@lfdr.de>; Wed, 31 Mar 2021 05:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhCaDfx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Mar 2021 23:35:53 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39103 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhCaDfQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Mar 2021 23:35:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTuo1y6_1617161699;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UTuo1y6_1617161699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 31 Mar 2021 11:35:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: deflate - Remove useless call "zlib_inflateEnd"
Date:   Wed, 31 Mar 2021 11:34:57 +0800
Message-Id: <1617161697-121478-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following whitescan warning:

Calling "zlib_inflateEnd(&ctx->decomp_stream)" is only useful for its
return value, which is ignored.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 crypto/deflate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index b2a46f6..cac1672 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -101,7 +101,6 @@ static void deflate_comp_exit(struct deflate_ctx *ctx)
 
 static void deflate_decomp_exit(struct deflate_ctx *ctx)
 {
-	zlib_inflateEnd(&ctx->decomp_stream);
 	vfree(ctx->decomp_stream.workspace);
 }
 
-- 
1.8.3.1

