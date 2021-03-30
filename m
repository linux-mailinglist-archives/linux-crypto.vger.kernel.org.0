Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9177B34E520
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Mar 2021 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC3KKu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Mar 2021 06:10:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44718 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhC3KKp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Mar 2021 06:10:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UTrGkMO_1617099031;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UTrGkMO_1617099031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 18:10:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     thomas.lendacky@amd.com
Cc:     john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] crypto: ccp -A value assigned to a variable is never used.
Date:   Tue, 30 Mar 2021 18:10:29 +0800
Message-Id: <1617099029-50434-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following whitescan warning:

Assigning value "64" to "dst.address" here, but that stored value is
overwritten before it can be used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/crypto/ccp/ccp-ops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index d6a8f4e..bb88198 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -2418,7 +2418,6 @@ static int ccp_run_ecc_pm_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	dst.address += CCP_ECC_OUTPUT_SIZE;
 	ccp_reverse_get_dm_area(&dst, 0, ecc->u.pm.result.y, 0,
 				CCP_ECC_MODULUS_BYTES);
-	dst.address += CCP_ECC_OUTPUT_SIZE;
 
 	/* Restore the workarea address */
 	dst.address = save;
-- 
1.8.3.1

