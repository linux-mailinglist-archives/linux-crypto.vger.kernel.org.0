Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CEDE56A
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Oct 2019 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfJUHka (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Oct 2019 03:40:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbfJUHk3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Oct 2019 03:40:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFF893A74AC0FA1125C0;
        Mon, 21 Oct 2019 15:40:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 21 Oct 2019 15:40:19 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <wangzhou1@hisilicon.com>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 2/4] crypto: hisilicon - Fix using plain integer as NULL pointer
Date:   Mon, 21 Oct 2019 15:41:01 +0800
Message-ID: <1571643663-29593-3-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571643663-29593-1-git-send-email-tanshukun1@huawei.com>
References: <1571643663-29593-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fix sparse warning:
zip_crypto.c:425:26: warning: Using plain integer as NULL pointer

Replaces assignment of 0 to pointer with NULL assignment.

Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 9d31b80..795428c 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -42,7 +42,7 @@ enum hisi_zip_alg_type {
 
 #define TO_HEAD(req_type)						\
 	(((req_type) == HZIP_ALG_TYPE_ZLIB) ? zlib_head :		\
-	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? gzip_head : 0)		\
+	 ((req_type) == HZIP_ALG_TYPE_GZIP) ? gzip_head : NULL)		\
 
 struct hisi_zip_req {
 	struct acomp_req *req;
-- 
2.7.4

