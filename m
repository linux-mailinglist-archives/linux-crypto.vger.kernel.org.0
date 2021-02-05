Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93180310927
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Feb 2021 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBEKci (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Feb 2021 05:32:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12855 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhBEKQD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Feb 2021 05:16:03 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DXB8l50HSz7h4T;
        Fri,  5 Feb 2021 18:13:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 18:15:13 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 3/6] crypto: hisilicon/qm - fix the value of 'QM_SQC_VFT_BASE_MASK_V2'
Date:   Fri, 5 Feb 2021 18:12:55 +0800
Message-ID: <1612519978-33340-4-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612519978-33340-1-git-send-email-qianweili@huawei.com>
References: <1612519978-33340-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Since the size of base number is 16 bits, update the value of
'QM_SQC_VFT_BASE_MASK_V2' as 'GENMASK(15, 0)'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 108fc0e..908a13f 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -120,7 +120,7 @@
 #define QM_CQC_VFT_VALID		(1ULL << 28)
 
 #define QM_SQC_VFT_BASE_SHIFT_V2	28
-#define QM_SQC_VFT_BASE_MASK_V2		GENMASK(5, 0)
+#define QM_SQC_VFT_BASE_MASK_V2		GENMASK(15, 0)
 #define QM_SQC_VFT_NUM_SHIFT_V2		45
 #define QM_SQC_VFT_NUM_MASK_v2		GENMASK(9, 0)
 
-- 
2.8.1

