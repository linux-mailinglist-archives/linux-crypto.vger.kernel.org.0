Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8992A22D460
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 05:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgGYDqz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jul 2020 23:46:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbgGYDqy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jul 2020 23:46:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D25121F6D6F8DA734F2A;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:41 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 07/10] crypto: hisilicon/zip - fix static check warning
Date:   Sat, 25 Jul 2020 11:44:40 +0800
Message-ID: <1595648683-50590-8-git-send-email-shenyang39@huawei.com>
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

Fix some code for PClint warning:
    Warning - Suspicious Cast

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 7aa8a55..fdc5bd3 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -16,7 +16,7 @@

 #define GZIP_HEAD_FLG_SHIFT			3
 #define GZIP_HEAD_FEXTRA_SHIFT			10
-#define GZIP_HEAD_FEXTRA_XLEN			2
+#define GZIP_HEAD_FEXTRA_XLEN			2UL
 #define GZIP_HEAD_FHCRC_SIZE			2

 #define HZIP_GZIP_HEAD_BUF			256
@@ -51,13 +51,13 @@ enum {

 struct hisi_zip_req {
 	struct acomp_req *req;
-	int sskip;
-	int dskip;
+	u32 sskip;
+	u32 dskip;
 	struct hisi_acc_hw_sgl *hw_src;
 	struct hisi_acc_hw_sgl *hw_dst;
 	dma_addr_t dma_src;
 	dma_addr_t dma_dst;
-	int req_id;
+	u16 req_id;
 };

 struct hisi_zip_req_q {
@@ -119,7 +119,7 @@ static void hisi_zip_config_tag(struct hisi_zip_sqe *sqe, u32 tag)

 static void hisi_zip_fill_sqe(struct hisi_zip_sqe *sqe, u8 req_type,
 			      dma_addr_t s_addr, dma_addr_t d_addr, u32 slen,
-			      u32 dlen, int sskip, int dskip)
+			      u32 dlen, u32 sskip, u32 dskip)
 {
 	memset(sqe, 0, sizeof(struct hisi_zip_sqe));

@@ -573,7 +573,7 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 		return head_size;
 	}

-	req = hisi_zip_create_req(acomp_req, qp_ctx, (size_t)head_size, true);
+	req = hisi_zip_create_req(acomp_req, qp_ctx, head_size, true);
 	if (IS_ERR(req)) {
 		dev_err_ratelimited(dev, "Create request before compress failed (%ld)!\n",
 				    PTR_ERR(req));
--
2.7.4

