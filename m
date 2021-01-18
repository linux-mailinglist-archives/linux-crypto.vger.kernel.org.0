Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3422F9B25
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Jan 2021 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbhARIV0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Jan 2021 03:21:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11552 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbhARIVX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Jan 2021 03:21:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DK4SZ2BpmzMLkB;
        Mon, 18 Jan 2021 16:19:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 16:20:24 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - add ecc algorithm inqury for uacce device
Date:   Mon, 18 Jan 2021 16:18:19 +0800
Message-ID: <1610957899-6692-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Uacce SysFS support more algorithms inqury such as
'ecdh/ecdsa/sm2/x25519/x448'

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index d46086e..3b3481e 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -778,7 +778,10 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return -EINVAL;
 	}
 
-	qm->algs = "rsa\ndh\n";
+	if (pdev->revision >= QM_HW_V3)
+		qm->algs = "rsa\ndh\necdh\nx25519\nx448\necdsa\nsm2\n";
+	else
+		qm->algs = "rsa\ndh\n";
 	qm->mode = uacce_mode;
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
-- 
2.8.1

