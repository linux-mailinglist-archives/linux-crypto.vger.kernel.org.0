Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC87EE99
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403982AbfHBIQ5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 04:16:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403974AbfHBIQ5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 04:16:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B701C3A14E74F41B24A7;
        Fri,  2 Aug 2019 16:16:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 16:16:45 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v3 5/7] Documentation: Add debugfs doc for hisi_zip
Date:   Fri, 2 Aug 2019 15:57:54 +0800
Message-ID: <1564732676-35987-6-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
References: <1564732676-35987-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add debugfs descriptions for HiSilicon ZIP and QM driver.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-zip | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-zip

diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
new file mode 100644
index 0000000..a7c63e6
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -0,0 +1,50 @@
+What:           /sys/kernel/debug/hisi_zip/<bdf>/comp_core[01]/regs
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump of compression cores related debug registers.
+		Only available for PF.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/decomp_core[0-5]/regs
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump of decompression cores related debug registers.
+		Only available for PF.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/clear_enable
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    Compression/decompression core debug registers read clear
+		control. 1 means enable register read clear, otherwise 0.
+		Writing to this file has no functional effect, only enable or
+		disable counters clear after reading of these registers.
+		Only available for PF.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/current_qm
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    One ZIP controller has one PF and multiple VFs, each function
+		has a QM. Select the QM which below qm refers to.
+		Only available for PF.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/qm_regs
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    Dump of QM related debug registers.
+		Available for PF and VF in host. VF in guest currently only
+		has one debug register.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/current_q
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    One QM may contain multiple queues. Select specific queue to
+		show its debug registers in above qm_regs.
+		Only available for PF.
+
+What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/clear_enable
+Date:           Nov 2018
+Contact:        linux-crypto@vger.kernel.org
+Description:    QM debug registers(qm_regs) read clear control. 1 means enable
+		register read clear, otherwise 0.
+		Writing to this file has no functional effect, only enable or
+		disable counters clear after reading of these registers.
+		Only available for PF.
-- 
2.8.1

