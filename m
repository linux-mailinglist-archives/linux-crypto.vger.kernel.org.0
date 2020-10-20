Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669A928EB1D
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Oct 2020 04:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgJOCYa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Oct 2020 22:24:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgJOCYa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Oct 2020 22:24:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1513588EEF68F4D4E5F7
        for <linux-crypto@vger.kernel.org>; Thu, 15 Oct 2020 10:24:25 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 10:24:20 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 1/2] crypto: hisilicon - delete unused structure member variables
Date:   Thu, 15 Oct 2020 10:23:03 +0800
Message-ID: <1602728584-47722-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
References: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1. Remove unused member‘pending_reqs' in‘sec_qp_ctx' structure.
2. Remove unused member‘status'  in‘sec_dev' structure.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 037762b..0849191 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -109,7 +109,6 @@ struct sec_qp_ctx {
 	struct list_head backlog;
 	struct hisi_acc_sgl_pool *c_in_pool;
 	struct hisi_acc_sgl_pool *c_out_pool;
-	atomic_t pending_reqs;
 };
 
 enum sec_alg_type {
@@ -180,7 +179,6 @@ struct sec_dev {
 	struct sec_debug debug;
 	u32 ctx_q_num;
 	bool iommu_used;
-	unsigned long status;
 };
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
-- 
2.8.1

