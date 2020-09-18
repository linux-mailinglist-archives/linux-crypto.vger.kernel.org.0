Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2190B26EA86
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 03:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgIRBax (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Sep 2020 21:30:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgIRBav (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Sep 2020 21:30:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC7AC86507DEF281E73B;
        Fri, 18 Sep 2020 09:30:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:30:35 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] crypto: amlogic: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Fri, 18 Sep 2020 09:31:10 +0800
Message-ID: <20200918013110.82604-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/crypto/amlogic/amlogic-gxl-core.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 466552acb..5bbeff433 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -98,7 +98,7 @@ static struct meson_alg_template mc_algs[] = {
 };
 
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
-static int meson_dbgfs_read(struct seq_file *seq, void *v)
+static int meson_debugfs_show(struct seq_file *seq, void *v)
 {
 	struct meson_dev *mc = seq->private;
 	int i;
@@ -118,19 +118,7 @@ static int meson_dbgfs_read(struct seq_file *seq, void *v)
 	}
 	return 0;
 }
-
-static int meson_dbgfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, meson_dbgfs_read, inode->i_private);
-}
-
-static const struct file_operations meson_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = meson_dbgfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(meson_debugfs);
 #endif
 
 static void meson_free_chanlist(struct meson_dev *mc, int i)
-- 
2.23.0

