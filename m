Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538CE148623
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Jan 2020 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbgAXNaT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jan 2020 08:30:19 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:56144 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbgAXNaT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jan 2020 08:30:19 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id uDW42100T5USYZQ06DW4VA; Fri, 24 Jan 2020 14:30:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-0007bH-D3; Fri, 24 Jan 2020 14:30:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iuz2C-00047C-Ba; Fri, 24 Jan 2020 14:30:04 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] debugfs: regset32: Add Runtime PM support
Date:   Fri, 24 Jan 2020 14:29:56 +0100
Message-Id: <20200124132957.15769-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124132957.15769-1-geert+renesas@glider.be>
References: <20200124132957.15769-1-geert+renesas@glider.be>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hardware registers of devices under control of power management cannot
be accessed at all times.  If such a device is suspended, register
accesses may lead to undefined behavior, like reading bogus values, or
causing exceptions or system locks.

Extend struct debugfs_regset32 with an optional field to let device
drivers specify the device the registers in the set belong to.  This
allows debugfs_show_regset32() to make sure the device is resumed while
its registers are being read.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/debugfs/file.c       | 8 ++++++++
 include/linux/debugfs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dede25247b81f72a..5e52d68421c678f2 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <linux/poll.h>
 #include <linux/security.h>
 
@@ -1057,7 +1058,14 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
 {
 	struct debugfs_regset32 *regset = s->private;
 
+	if (regset->dev)
+		pm_runtime_get_sync(regset->dev);
+
 	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
+
+	if (regset->dev)
+		pm_runtime_put(regset->dev);
+
 	return 0;
 }
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index bf9b6cafa4c26a68..5d0783ae09f365ac 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -35,6 +35,7 @@ struct debugfs_regset32 {
 	const struct debugfs_reg32 *regs;
 	int nregs;
 	void __iomem *base;
+	struct device *dev;	/* Optional device for Runtime PM */
 };
 
 extern struct dentry *arch_debugfs_dir;
-- 
2.17.1

