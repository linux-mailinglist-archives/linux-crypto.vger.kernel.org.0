Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0F34F652
	for <lists+linux-crypto@lfdr.de>; Wed, 31 Mar 2021 03:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCaBoA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Mar 2021 21:44:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15109 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaBna (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Mar 2021 21:43:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F98DL3NR9z19K7t;
        Wed, 31 Mar 2021 09:41:22 +0800 (CST)
Received: from ubuntu180.huawei.com (10.175.100.227) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 09:43:17 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <tangyizhou@huawei.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] crypto: ccp - Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 31 Mar 2021 10:00:55 +0800
Message-ID: <20210331020055.4631-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.100.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 drivers/crypto/ccp/ccp-crypto-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-main.c b/drivers/crypto/ccp/ccp-crypto-main.c
index 88275b4867ea..5976530c00a8 100644
--- a/drivers/crypto/ccp/ccp-crypto-main.c
+++ b/drivers/crypto/ccp/ccp-crypto-main.c
@@ -59,7 +59,7 @@ struct ccp_crypto_queue {
 #define CCP_CRYPTO_MAX_QLEN	100
 
 static struct ccp_crypto_queue req_queue;
-static spinlock_t req_queue_lock;
+static DEFINE_SPINLOCK(req_queue_lock);
 
 struct ccp_crypto_cmd {
 	struct list_head entry;
@@ -410,7 +410,6 @@ static int ccp_crypto_init(void)
 		return ret;
 	}
 
-	spin_lock_init(&req_queue_lock);
 	INIT_LIST_HEAD(&req_queue.cmds);
 	req_queue.backlog = &req_queue.cmds;
 	req_queue.cmd_count = 0;

