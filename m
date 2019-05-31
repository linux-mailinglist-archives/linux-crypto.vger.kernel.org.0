Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB130B4E
	for <lists+linux-crypto@lfdr.de>; Fri, 31 May 2019 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfEaJVS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 May 2019 05:21:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfEaJVR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 May 2019 05:21:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E44ABCCF2B6157DC235;
        Fri, 31 May 2019 17:21:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 17:21:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] crypto: pcrypt: Fix possible deadlock in padata_sysfs_release
Date:   Fri, 31 May 2019 17:29:23 +0800
Message-ID: <20190531092923.4874-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

There is a deadlock issue in pcrypt_init_padata(),

pcrypt_init_padata()
    cpus_read_lock()
      padata_free()
        padata_sysfs_release()
          cpus_read_lock()

Narrow rcu_read_lock/unlock() and move put_online_cpus()
before padata_free() to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 crypto/pcrypt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 0e9ce329fd47..662228b48b70 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -407,13 +407,14 @@ static int pcrypt_init_padata(struct padata_pcrypt *pcrypt,
 	int ret = -ENOMEM;
 	struct pcrypt_cpumask *mask;
 
-	get_online_cpus();
 
 	pcrypt->wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE,
 				     1, name);
 	if (!pcrypt->wq)
 		goto err;
 
+	get_online_cpus();
+
 	pcrypt->pinst = padata_alloc_possible(pcrypt->wq);
 	if (!pcrypt->pinst)
 		goto err_destroy_workqueue;
@@ -448,12 +449,11 @@ static int pcrypt_init_padata(struct padata_pcrypt *pcrypt,
 	free_cpumask_var(mask->mask);
 	kfree(mask);
 err_free_padata:
+	put_online_cpus();
 	padata_free(pcrypt->pinst);
 err_destroy_workqueue:
 	destroy_workqueue(pcrypt->wq);
 err:
-	put_online_cpus();
-
 	return ret;
 }
 
-- 
2.20.1

