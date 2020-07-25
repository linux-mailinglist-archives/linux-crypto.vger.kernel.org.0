Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED2922D468
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGYDrL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Jul 2020 23:47:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbgGYDrG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Jul 2020 23:47:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C5FF9587C706AD736DB6;
        Sat, 25 Jul 2020 11:46:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 11:46:41 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 08/10] crypto: hisilicon/zip - move some private macros from 'zip.h' to 'zip_crypto.c'
Date:   Sat, 25 Jul 2020 11:44:41 +0800
Message-ID: <1595648683-50590-9-git-send-email-shenyang39@huawei.com>
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

Some macros which are defined in 'zip.h' are related to the struct
'hisi_zip_sqe' and are only used in 'zip_crypto.c'. So move them from
'zip.h' to 'zip_crypto.c'.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/zip/zip.h        | 14 --------------
 drivers/crypto/hisilicon/zip/zip_crypto.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 4b3aae8..92397f9 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -9,20 +9,6 @@
 #include <linux/list.h>
 #include "../qm.h"

-/* hisi_zip_sqe dw3 */
-#define HZIP_BD_STATUS_M			GENMASK(7, 0)
-/* hisi_zip_sqe dw7 */
-#define HZIP_IN_SGE_DATA_OFFSET_M		GENMASK(23, 0)
-/* hisi_zip_sqe dw8 */
-#define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
-/* hisi_zip_sqe dw9 */
-#define HZIP_REQ_TYPE_M				GENMASK(7, 0)
-#define HZIP_ALG_TYPE_ZLIB			0x02
-#define HZIP_ALG_TYPE_GZIP			0x03
-#define HZIP_BUF_TYPE_M				GENMASK(11, 8)
-#define HZIP_PBUFFER				0x0
-#define HZIP_SGL				0x1
-
 enum hisi_zip_error_type {
 	/* negative compression */
 	HZIP_NC_ERR = 0x0d,
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index fdc5bd3..7757e33 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -6,6 +6,20 @@
 #include <linux/scatterlist.h>
 #include "zip.h"

+/* hisi_zip_sqe dw3 */
+#define HZIP_BD_STATUS_M			GENMASK(7, 0)
+/* hisi_zip_sqe dw7 */
+#define HZIP_IN_SGE_DATA_OFFSET_M		GENMASK(23, 0)
+/* hisi_zip_sqe dw8 */
+#define HZIP_OUT_SGE_DATA_OFFSET_M		GENMASK(23, 0)
+/* hisi_zip_sqe dw9 */
+#define HZIP_REQ_TYPE_M				GENMASK(7, 0)
+#define HZIP_ALG_TYPE_ZLIB			0x02
+#define HZIP_ALG_TYPE_GZIP			0x03
+#define HZIP_BUF_TYPE_M				GENMASK(11, 8)
+#define HZIP_PBUFFER				0x0
+#define HZIP_SGL				0x1
+
 #define HZIP_ZLIB_HEAD_SIZE			2
 #define HZIP_GZIP_HEAD_SIZE			10

--
2.7.4

