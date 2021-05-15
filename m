Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC523817BC
	for <lists+linux-crypto@lfdr.de>; Sat, 15 May 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhEOKtT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 15 May 2021 06:49:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3695 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhEOKtR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 15 May 2021 06:49:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj28p1Sg7z16QB2;
        Sat, 15 May 2021 18:44:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 18:47:34 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 2/4] crypto: hisilicon/qm - modify 'QM_RESETTING' clearing error
Date:   Sat, 15 May 2021 18:44:38 +0800
Message-ID: <1621075480-52869-3-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
References: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Before device reset, the driver sets 'QM_RESETTING' flag, but after reset,
the wrong flag is cleared. This patch modifies the problem of inconsistent
flags.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 6a9c18f..09f0370 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4122,7 +4122,7 @@ void hisi_qm_reset_done(struct pci_dev *pdev)
 	if (qm_flr_reset_complete(pdev))
 		pci_info(pdev, "FLR reset complete\n");
 
-	clear_bit(QM_RESETTING, &qm->misc_ctl);
+	clear_bit(QM_RESETTING, &pf_qm->misc_ctl);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_reset_done);
 
-- 
2.8.1

