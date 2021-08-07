Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC073E34CE
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Aug 2021 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhHGKgp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 Aug 2021 06:36:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16993 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhHGKgg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 Aug 2021 06:36:36 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ghdvs5slSzZyL1;
        Sat,  7 Aug 2021 18:32:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 18:36:17 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 4/5] crypto: hisilicon - change parameter passing of debugfs function
Date:   Sat, 7 Aug 2021 18:32:35 +0800
Message-ID: <1628332356-33278-5-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1628332356-33278-1-git-send-email-qianweili@huawei.com>
References: <1628332356-33278-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

To avoid repeatedly obtaining 'qm' from 'filp', parameter passing of
debugfs function directly use 'qm' instead of 'filp'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c            | 34 +++++++++++---------------------
 drivers/crypto/hisilicon/sec2/sec_main.c | 11 ++++-------
 drivers/crypto/hisilicon/zip/zip_main.c  | 11 ++++-------
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 7474003..e29ff97 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1203,16 +1203,13 @@ static struct hisi_qm *file_to_qm(struct debugfs_file *file)
 	return container_of(debug, struct hisi_qm, debug);
 }
 
-static u32 current_q_read(struct debugfs_file *file)
+static u32 current_q_read(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = file_to_qm(file);
-
 	return readl(qm->io_base + QM_DFX_SQE_CNT_VF_SQN) >> QM_DFX_QN_SHIFT;
 }
 
-static int current_q_write(struct debugfs_file *file, u32 val)
+static int current_q_write(struct hisi_qm *qm, u32 val)
 {
-	struct hisi_qm *qm = file_to_qm(file);
 	u32 tmp;
 
 	if (val >= qm->debug.curr_qm_qp_num)
@@ -1229,18 +1226,14 @@ static int current_q_write(struct debugfs_file *file, u32 val)
 	return 0;
 }
 
-static u32 clear_enable_read(struct debugfs_file *file)
+static u32 clear_enable_read(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = file_to_qm(file);
-
 	return readl(qm->io_base + QM_DFX_CNT_CLR_CE);
 }
 
 /* rd_clr_ctrl 1 enable read clear, otherwise 0 disable it */
-static int clear_enable_write(struct debugfs_file *file, u32 rd_clr_ctrl)
+static int clear_enable_write(struct hisi_qm *qm, u32 rd_clr_ctrl)
 {
-	struct hisi_qm *qm = file_to_qm(file);
-
 	if (rd_clr_ctrl > 1)
 		return -EINVAL;
 
@@ -1249,16 +1242,13 @@ static int clear_enable_write(struct debugfs_file *file, u32 rd_clr_ctrl)
 	return 0;
 }
 
-static u32 current_qm_read(struct debugfs_file *file)
+static u32 current_qm_read(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = file_to_qm(file);
-
 	return readl(qm->io_base + QM_DFX_MB_CNT_VF);
 }
 
-static int current_qm_write(struct debugfs_file *file, u32 val)
+static int current_qm_write(struct hisi_qm *qm, u32 val)
 {
-	struct hisi_qm *qm = file_to_qm(file);
 	u32 tmp;
 
 	if (val > qm->vfs_num)
@@ -1301,13 +1291,13 @@ static ssize_t qm_debug_read(struct file *filp, char __user *buf,
 	mutex_lock(&file->lock);
 	switch (index) {
 	case CURRENT_QM:
-		val = current_qm_read(file);
+		val = current_qm_read(qm);
 		break;
 	case CURRENT_Q:
-		val = current_q_read(file);
+		val = current_q_read(qm);
 		break;
 	case CLEAR_ENABLE:
-		val = clear_enable_read(file);
+		val = clear_enable_read(qm);
 		break;
 	default:
 		goto err_input;
@@ -1356,13 +1346,13 @@ static ssize_t qm_debug_write(struct file *filp, const char __user *buf,
 	mutex_lock(&file->lock);
 	switch (index) {
 	case CURRENT_QM:
-		ret = current_qm_write(file, val);
+		ret = current_qm_write(qm, val);
 		break;
 	case CURRENT_Q:
-		ret = current_q_write(file, val);
+		ret = current_q_write(qm, val);
 		break;
 	case CLEAR_ENABLE:
-		ret = clear_enable_write(file, val);
+		ret = clear_enable_write(qm, val);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index aafa627..5902f16 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -534,17 +534,14 @@ static void sec_hw_error_disable(struct hisi_qm *qm)
 	writel(SEC_RAS_DISABLE, qm->io_base + SEC_RAS_NFE_REG);
 }
 
-static u32 sec_clear_enable_read(struct sec_debug_file *file)
+static u32 sec_clear_enable_read(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = file->qm;
-
 	return readl(qm->io_base + SEC_CTRL_CNT_CLR_CE) &
 			SEC_CTRL_CNT_CLR_CE_BIT;
 }
 
-static int sec_clear_enable_write(struct sec_debug_file *file, u32 val)
+static int sec_clear_enable_write(struct hisi_qm *qm, u32 val)
 {
-	struct hisi_qm *qm = file->qm;
 	u32 tmp;
 
 	if (val != 1 && val)
@@ -574,7 +571,7 @@ static ssize_t sec_debug_read(struct file *filp, char __user *buf,
 
 	switch (file->index) {
 	case SEC_CLEAR_ENABLE:
-		val = sec_clear_enable_read(file);
+		val = sec_clear_enable_read(qm);
 		break;
 	default:
 		goto err_input;
@@ -624,7 +621,7 @@ static ssize_t sec_debug_write(struct file *filp, const char __user *buf,
 
 	switch (file->index) {
 	case SEC_CLEAR_ENABLE:
-		ret = sec_clear_enable_write(file, val);
+		ret = sec_clear_enable_write(qm, val);
 		if (ret)
 			goto err_input;
 		break;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 61d3d94..2271e67 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -424,17 +424,14 @@ static inline struct hisi_qm *file_to_qm(struct ctrl_debug_file *file)
 	return &hisi_zip->qm;
 }
 
-static u32 clear_enable_read(struct ctrl_debug_file *file)
+static u32 clear_enable_read(struct hisi_qm *qm)
 {
-	struct hisi_qm *qm = file_to_qm(file);
-
 	return readl(qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE) &
 		     HZIP_SOFT_CTRL_CNT_CLR_CE_BIT;
 }
 
-static int clear_enable_write(struct ctrl_debug_file *file, u32 val)
+static int clear_enable_write(struct hisi_qm *qm, u32 val)
 {
-	struct hisi_qm *qm = file_to_qm(file);
 	u32 tmp;
 
 	if (val != 1 && val != 0)
@@ -463,7 +460,7 @@ static ssize_t hisi_zip_ctrl_debug_read(struct file *filp, char __user *buf,
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
 	case HZIP_CLEAR_ENABLE:
-		val = clear_enable_read(file);
+		val = clear_enable_read(qm);
 		break;
 	default:
 		goto err_input;
@@ -511,7 +508,7 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 	spin_lock_irq(&file->lock);
 	switch (file->index) {
 	case HZIP_CLEAR_ENABLE:
-		ret = clear_enable_write(file, val);
+		ret = clear_enable_write(qm, val);
 		if (ret)
 			goto err_input;
 		break;
-- 
2.8.1

