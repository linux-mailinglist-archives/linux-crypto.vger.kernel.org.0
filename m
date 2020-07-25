Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0F22D45A
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 05:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGYDqw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jul 2020 23:46:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbgGYDqw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jul 2020 23:46:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA5C1A56A7D3833017A7;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:39 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 01/10] crypto: hisilicon/zip - remove some useless parameters
Date:   Sat, 25 Jul 2020 11:44:34 +0800
Message-ID: <1595648683-50590-2-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1.Remove the macro 'HZIP_VF_NUM'.
2.Remove 'list' of the struct 'hisi_zip'

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip.h      | 1 -
 drivers/crypto/hisilicon/zip/zip_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 4484be1..4b3aae8 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -39,7 +39,6 @@ struct hisi_zip_ctrl;

 struct hisi_zip {
 	struct hisi_qm qm;
-	struct list_head list;
 	struct hisi_zip_ctrl *ctrl;
 	struct hisi_zip_dfx dfx;
 };
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 7e86b0f..445db04 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -17,7 +17,6 @@
 #define PCI_DEVICE_ID_ZIP_PF		0xa250
 #define PCI_DEVICE_ID_ZIP_VF		0xa251

-#define HZIP_VF_NUM			63
 #define HZIP_QUEUE_NUM_V1		4096
 #define HZIP_QUEUE_NUM_V2		1024

--
2.7.4

