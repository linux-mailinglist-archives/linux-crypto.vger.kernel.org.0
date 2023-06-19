Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBB7349FD
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jun 2023 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFSCQQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 18 Jun 2023 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFSCQP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 18 Jun 2023 22:16:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75864E4F
        for <linux-crypto@vger.kernel.org>; Sun, 18 Jun 2023 19:16:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QktfP6b53zqTfk;
        Mon, 19 Jun 2023 10:15:57 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Jun
 2023 10:16:02 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH RFC v2 1/3] MPI: Export mpi_add_ui and mpi_mod for SM9
Date:   Mon, 19 Jun 2023 10:15:01 +0800
Message-ID: <20230619021503.29814-2-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230619021503.29814-1-guozihua@huawei.com>
References: <20230619021503.29814-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SM9 which could be built as a module would be using mpi_add_ui and mpi_mod.
So export them.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 lib/mpi/mpi-add.c | 2 +-
 lib/mpi/mpi-mod.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
index 9056fc5167fc..d34c6c1c6fab 100644
--- a/lib/mpi/mpi-add.c
+++ b/lib/mpi/mpi-add.c
@@ -62,7 +62,7 @@ void mpi_add_ui(MPI w, MPI u, unsigned long v)
 	w->nlimbs = wsize;
 	w->sign   = wsign;
 }
-
+EXPORT_SYMBOL_GPL(mpi_add_ui);
 
 void mpi_add(MPI w, MPI u, MPI v)
 {
diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
index 54fcc01564d9..8136f4aff287 100644
--- a/lib/mpi/mpi-mod.c
+++ b/lib/mpi/mpi-mod.c
@@ -26,6 +26,7 @@ void mpi_mod(MPI rem, MPI dividend, MPI divisor)
 {
 	mpi_fdiv_r(rem, dividend, divisor);
 }
+EXPORT_SYMBOL_GPL(mpi_mod);
 
 /* This function returns a new context for Barrett based operations on
  * the modulus M.  This context needs to be released using
-- 
2.17.1

