Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1C2F9B19
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Jan 2021 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbhARISe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Jan 2021 03:18:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11107 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbhARISd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Jan 2021 03:18:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DK4Pn3LNNz15vKw;
        Mon, 18 Jan 2021 16:16:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 16:17:44 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: hisilicon/hpre - delete ECC 1bit error reported threshold
Date:   Mon, 18 Jan 2021 16:15:40 +0800
Message-ID: <1610957740-2989-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Delete 'HPRE_RAS_ECC1BIT_TH' register setting of hpre,
since register 'QM_RAS_CE_THRESHOLD' of qm has done this work.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index ad8b691..bf1fa08 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -36,7 +36,6 @@
 #define HPRE_INT_STATUS			0x301800
 #define HPRE_CORE_INT_ENABLE		0
 #define HPRE_CORE_INT_DISABLE		0x003fffff
-#define HPRE_RAS_ECC_1BIT_TH		0x30140c
 #define HPRE_RDCHN_INI_ST		0x301a00
 #define HPRE_CLSTR_BASE			0x302000
 #define HPRE_CORE_EN_OFFSET		0x04
@@ -312,7 +311,6 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 	writel(HPRE_QM_VFG_AX_MASK, HPRE_ADDR(qm, HPRE_VFG_AXCACHE));
 	writel(0x0, HPRE_ADDR(qm, HPRE_BD_ENDIAN));
 	writel(0x0, HPRE_ADDR(qm, HPRE_INT_MASK));
-	writel(0x0, HPRE_ADDR(qm, HPRE_RAS_ECC_1BIT_TH));
 	writel(0x0, HPRE_ADDR(qm, HPRE_POISON_BYPASS));
 	writel(0x0, HPRE_ADDR(qm, HPRE_COMM_CNT_CLR_CE));
 	writel(0x0, HPRE_ADDR(qm, HPRE_ECC_BYPASS));
-- 
2.8.1

