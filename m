Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6954E776065
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Aug 2023 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjHINQU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Aug 2023 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjHINQT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Aug 2023 09:16:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B1D210B
        for <linux-crypto@vger.kernel.org>; Wed,  9 Aug 2023 06:16:18 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLVK51mXRzZfqR;
        Wed,  9 Aug 2023 20:50:33 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.118) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:51:44 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Lu Jialin <lujialin4@huawei.com>, <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto:padata: Fix return err for PADATA_RESET
Date:   Wed, 9 Aug 2023 12:50:48 +0000
Message-ID: <20230809125048.503619-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.118]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

We found a hungtask bug in test_aead_vec_cfg as follows:

INFO: task cryptomgr_test:391009 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Call trace:
 __switch_to+0x98/0xe0
 __schedule+0x6c4/0xf40
 schedule+0xd8/0x1b4
 schedule_timeout+0x474/0x560
 wait_for_common+0x368/0x4e0
 wait_for_completion+0x20/0x30
 test_aead_vec_cfg+0xab4/0xd50
 test_aead+0x144/0x1f0
 alg_test_aead+0xd8/0x1e0
 alg_test+0x634/0x890
 cryptomgr_test+0x40/0x70
 kthread+0x1e0/0x220
 ret_from_fork+0x10/0x18
Kernel panic - not syncing: hung_task: blocked tasks

For padata_do_parallel, when the return err is 0 or -EBUSY, it will call
wait_for_completion(&wait->completion) in test_aead_vec_cfg. In normal
case, aead_request_complete() will be called in pcrypt_aead_serial and the
return err is 0 for padata_do_parallel. But, when pinst->flags is
PADATA_RESET, the return err is -EBUSY for padata_do_parallel, and it
won't call aead_request_complete(). Therefore, test_aead_vec_cfg will
hung at wait_for_completion(&wait->completion), which will cause
hungtask.

The problem comes as following:
(padata_do_parallel)                 |
    rcu_read_lock_bh();              |
    err = -EINVAL;                   |   (padata_replace)
                                     |     pinst->flags |= PADATA_RESET;
    err = -EBUSY                     |
    if (pinst->flags & PADATA_RESET) |
        rcu_read_unlock_bh()         |
        return err                   |

In order to resolve the problem, change the return err to -EINVAL when
pinst->flags is set PADATA_RESET.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 kernel/padata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 222d60195de6..cc326ffb209a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -202,7 +202,6 @@ int padata_do_parallel(struct padata_shell *ps,
 		*cb_cpu = cpu;
 	}
 
-	err =  -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-- 
2.34.1

