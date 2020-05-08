Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6901CA4AC
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHG7H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 02:59:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgEHG7G (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 02:59:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1DBC28175A0C2AB20E1D;
        Fri,  8 May 2020 14:59:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 14:58:55 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 13/13] crypto: hisilicon/zip - Make negative compression not an error
Date:   Fri, 8 May 2020 14:57:48 +0800
Message-ID: <1588921068-20739-14-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
References: <1588921068-20739-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Zhou Wang <wangzhou1@hisilicon.com>

Users can decide whether to use negative compression result, so it
should not be reported as an error by driver.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 5fb9d4b..0f158d4 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -341,7 +341,7 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 
 	status = sqe->dw3 & HZIP_BD_STATUS_M;
 
-	if (status != 0 && status != HZIP_NC_ERR) {
+	if (status != 0) {
 		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
 			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
 			sqe->produced);
-- 
2.7.4

