Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862522104D2
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2020 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGAHVo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Jul 2020 03:21:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728113AbgGAHVo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Jul 2020 03:21:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0FA24A5DCD10D2318FC;
        Wed,  1 Jul 2020 15:21:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 15:21:32 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [Patch v2 7/9] crypto: hisilicon/qm - fix VF not available after PF FLR
Date:   Wed, 1 Jul 2020 15:19:53 +0800
Message-ID: <1593587995-7391-8-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593587995-7391-1-git-send-email-shenyang39@huawei.com>
References: <1593587995-7391-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Shukun Tan <tanshukun1@huawei.com>

When PF FLR, the hardware will actively trigger the VF FLR. Configuration
space of VF needs to be saved and restored to ensure that it is available
after the PF FLR.

Fixes: 7ce396fa12a9("crypto: hisilicon - add FLR support")
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index db816be..a441b3d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3334,6 +3334,9 @@ static int qm_vf_reset_prepare(struct hisi_qm *qm,
 			continue;
 
 		if (pci_physfn(virtfn) == pdev) {
+			/* save VFs PCIE BAR configuration */
+			pci_save_state(virtfn);
+
 			ret = hisi_qm_stop(vf_qm, stop_reason);
 			if (ret)
 				goto stop_fail;
@@ -3497,6 +3500,9 @@ static int qm_vf_reset_done(struct hisi_qm *qm)
 			continue;
 
 		if (pci_physfn(virtfn) == pdev) {
+			/* enable VFs PCIE BAR configuration */
+			pci_restore_state(virtfn);
+
 			ret = qm_restart(vf_qm);
 			if (ret)
 				goto restart_fail;
-- 
2.7.4

