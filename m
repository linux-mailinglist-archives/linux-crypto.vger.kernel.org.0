Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418DA221F39
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGPJAW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 05:00:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJAW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 05:00:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 636564AB1B8F515119FB;
        Thu, 16 Jul 2020 17:00:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:00:15 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: amlogic: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:04:11 +0800
Message-ID: <20200716090411.13573-1-miaoqinglang@huawei.com>
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

From: Liu Shixin <liushixin2@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 112be2441..c57501bfa 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -96,7 +96,7 @@ static struct meson_alg_template mc_algs[] = {
 };
 
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
-static int meson_dbgfs_read(struct seq_file *seq, void *v)
+static int meson_debugfs_show(struct seq_file *seq, void *v)
 {
 	struct meson_dev *mc = seq->private;
 	int i;
@@ -117,18 +117,7 @@ static int meson_dbgfs_read(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int meson_dbgfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, meson_dbgfs_read, inode->i_private);
-}
-
-static const struct file_operations meson_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = meson_dbgfs_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(meson_debugfs);
 #endif
 
 static void meson_free_chanlist(struct meson_dev *mc, int i)
-- 
2.17.1

