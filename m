Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709F936170A
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 03:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDPBG6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Apr 2021 21:06:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16595 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbhDPBG6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Apr 2021 21:06:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLyf6359Cz18H8S;
        Fri, 16 Apr 2021 09:04:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 09:06:19 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2] crypto: ccp - Make ccp_dev_suspend and ccp_dev_resume void functions
Date:   Fri, 16 Apr 2021 09:06:42 +0800
Message-ID: <1618535202-11397-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Since ccp_dev_suspend() and ccp_dev_resume() only return 0 which causes
ret to equal 0 in sp_suspend and sp_resume, making the if condition
impossible to use. it might be a more appropriate fix to have these be
void functions and eliminate the if condition in sp_suspend() and
sp_resume().

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
v2: handle the case that didn't define CONFIG_CRYPTO_DEV_SP_CCP.
---
 drivers/crypto/ccp/ccp-dev.c | 12 ++++--------
 drivers/crypto/ccp/sp-dev.c  | 12 ++----------
 drivers/crypto/ccp/sp-dev.h  | 15 ++++-----------
 3 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
index 0971ee6..6777582 100644
--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -548,7 +548,7 @@ bool ccp_queues_suspended(struct ccp_device *ccp)
 	return ccp->cmd_q_count == suspended;
 }
 
-int ccp_dev_suspend(struct sp_device *sp)
+void ccp_dev_suspend(struct sp_device *sp)
 {
 	struct ccp_device *ccp = sp->ccp_data;
 	unsigned long flags;
@@ -556,7 +556,7 @@ int ccp_dev_suspend(struct sp_device *sp)
 
 	/* If there's no device there's nothing to do */
 	if (!ccp)
-		return 0;
+		return;
 
 	spin_lock_irqsave(&ccp->cmd_lock, flags);
 
@@ -572,11 +572,9 @@ int ccp_dev_suspend(struct sp_device *sp)
 	while (!ccp_queues_suspended(ccp))
 		wait_event_interruptible(ccp->suspend_queue,
 					 ccp_queues_suspended(ccp));
-
-	return 0;
 }
 
-int ccp_dev_resume(struct sp_device *sp)
+void ccp_dev_resume(struct sp_device *sp)
 {
 	struct ccp_device *ccp = sp->ccp_data;
 	unsigned long flags;
@@ -584,7 +582,7 @@ int ccp_dev_resume(struct sp_device *sp)
 
 	/* If there's no device there's nothing to do */
 	if (!ccp)
-		return 0;
+		return;
 
 	spin_lock_irqsave(&ccp->cmd_lock, flags);
 
@@ -597,8 +595,6 @@ int ccp_dev_resume(struct sp_device *sp)
 	}
 
 	spin_unlock_irqrestore(&ccp->cmd_lock, flags);
-
-	return 0;
 }
 
 int ccp_dev_init(struct sp_device *sp)
diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 6284a15..7eb3e46 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -213,12 +213,8 @@ void sp_destroy(struct sp_device *sp)
 
 int sp_suspend(struct sp_device *sp)
 {
-	int ret;
-
 	if (sp->dev_vdata->ccp_vdata) {
-		ret = ccp_dev_suspend(sp);
-		if (ret)
-			return ret;
+		ccp_dev_suspend(sp);
 	}
 
 	return 0;
@@ -226,12 +222,8 @@ int sp_suspend(struct sp_device *sp)
 
 int sp_resume(struct sp_device *sp)
 {
-	int ret;
-
 	if (sp->dev_vdata->ccp_vdata) {
-		ret = ccp_dev_resume(sp);
-		if (ret)
-			return ret;
+		ccp_dev_resume(sp);
 	}
 
 	return 0;
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 0218d06..20377e6 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -134,8 +134,8 @@ struct sp_device *sp_get_psp_master_device(void);
 int ccp_dev_init(struct sp_device *sp);
 void ccp_dev_destroy(struct sp_device *sp);
 
-int ccp_dev_suspend(struct sp_device *sp);
-int ccp_dev_resume(struct sp_device *sp);
+void ccp_dev_suspend(struct sp_device *sp);
+void ccp_dev_resume(struct sp_device *sp);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_CCP */
 
@@ -144,15 +144,8 @@ static inline int ccp_dev_init(struct sp_device *sp)
 	return 0;
 }
 static inline void ccp_dev_destroy(struct sp_device *sp) { }
-
-static inline int ccp_dev_suspend(struct sp_device *sp)
-{
-	return 0;
-}
-static inline int ccp_dev_resume(struct sp_device *sp)
-{
-	return 0;
-}
+static inline void ccp_dev_suspend(struct sp_device *sp) { }
+static inline void ccp_dev_resume(struct sp_device *sp) { }
 #endif	/* CONFIG_CRYPTO_DEV_SP_CCP */
 
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
-- 
2.7.4

