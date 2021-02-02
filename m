Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CA30B50C
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Feb 2021 03:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhBBCHS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 1 Feb 2021 21:07:18 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40368 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhBBCHR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 1 Feb 2021 21:07:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNdnP7L_1612231576;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNdnP7L_1612231576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 10:06:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     horia.geanta@nxp.com
Cc:     aymen.sghaier@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] crypto: caam - Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue,  2 Feb 2021 10:06:15 +0800
Message-Id: <1612231575-15646-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following coccicheck warning:

./drivers/crypto/caam/debugfs.c:23:0-23: WARNING: caam_fops_u64_ro
should be defined with DEFINE_DEBUGFS_ATTRIBUTE.

./drivers/crypto/caam/debugfs.c:22:0-23: WARNING: caam_fops_u32_ro
should be defined with DEFINE_DEBUGFS_ATTRIBUTE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Modified subject.

 drivers/crypto/caam/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 8ebf183..806bb20 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -19,8 +19,8 @@ static int caam_debugfs_u32_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u32_ro, caam_debugfs_u32_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u64_ro, caam_debugfs_u64_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(caam_fops_u32_ro, caam_debugfs_u32_get, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(caam_fops_u64_ro, caam_debugfs_u64_get, NULL, "%llu\n");
 
 #ifdef CONFIG_CAAM_QI
 /*
-- 
1.8.3.1

