Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D83DC2E8
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Jul 2021 05:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhGaD1k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Jul 2021 23:27:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhGaD1j (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Jul 2021 23:27:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gc8kT6mnXzcjNw;
        Sat, 31 Jul 2021 11:24:01 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 11:27:30 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 31 Jul
 2021 11:27:29 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 3/5] crypto: hisilicon/sec - fix the max length of AAD for the CCM mode
Date:   Sat, 31 Jul 2021 11:26:34 +0800
Message-ID: <1627701996-4589-4-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627701996-4589-1-git-send-email-yekai13@huawei.com>
References: <1627701996-4589-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the maximum length of AAD for the CCM mode due to the hardware limited

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index b3ac1bd..010bde9 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -63,6 +63,7 @@
 #define SEC_AUTH_CIPHER		0x1
 #define SEC_MAX_MAC_LEN		64
 #define SEC_MAX_AAD_LEN		65535
+#define SEC_MAX_CCM_AAD_LEN	65279
 #define SEC_TOTAL_MAC_SZ	(SEC_MAX_MAC_LEN * QM_Q_DEPTH)
 
 #define SEC_PBUF_SZ			512
@@ -2218,6 +2219,10 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	}
 
 	if (c_mode == SEC_CMODE_CCM) {
+		if (unlikely(req->assoclen > SEC_MAX_CCM_AAD_LEN)) {
+			dev_err(dev, "CCM input aad parameter is too long!\n");
+			return -EINVAL;
+		}
 		ret = aead_iv_demension_check(req);
 		if (ret) {
 			dev_err(dev, "aead input iv param error!\n");
-- 
2.7.4

