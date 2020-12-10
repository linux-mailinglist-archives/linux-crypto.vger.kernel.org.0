Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0C2D5903
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Dec 2020 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgLJLMt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 06:12:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9580 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389128AbgLJLMi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 06:12:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsB74381CzM2vQ;
        Thu, 10 Dec 2020 19:11:12 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Dec 2020
 19:11:53 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] crypto: hisilicon/hpre - add version adapt to new algorithms
Date:   Thu, 10 Dec 2020 19:10:02 +0800
Message-ID: <1607598607-8728-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
References: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Meng Yu <yumeng18@huawei.com>

A new generation of accelerator Kunpeng930 has appeared, and the
corresponding driver needs to be updated to support some new
algorithms of Kunpeng930. To be compatible with Kunpeng920, we
add parameter 'struct hisi_qm *qm' to sec_algs_(un)register to
identify the chip's version.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reviewed-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre.h        | 5 +++--
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 4 ++--
 drivers/crypto/hisilicon/qm.c               | 4 ++--
 drivers/crypto/hisilicon/qm.h               | 4 ++--
 drivers/crypto/hisilicon/sec2/sec.h         | 4 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 4 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.h  | 4 ++--
 drivers/crypto/hisilicon/zip/zip.h          | 4 ++--
 drivers/crypto/hisilicon/zip/zip_crypto.c   | 4 ++--
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index f69252b..e784712 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -91,7 +91,8 @@ struct hpre_sqe {
 };
 
 struct hisi_qp *hpre_create_qp(void);
-int hpre_algs_register(void);
-void hpre_algs_unregister(void);
+int hpre_algs_register(struct hisi_qm *qm);
+void hpre_algs_unregister(struct hisi_qm *qm);
+
 
 #endif
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index a87f990..d89b2f5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1154,7 +1154,7 @@ static struct kpp_alg dh = {
 };
 #endif
 
-int hpre_algs_register(void)
+int hpre_algs_register(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -1171,7 +1171,7 @@ int hpre_algs_register(void)
 	return ret;
 }
 
-void hpre_algs_unregister(void)
+void hpre_algs_unregister(struct hisi_qm *qm)
 {
 	crypto_unregister_akcipher(&rsa);
 #ifdef CONFIG_CRYPTO_DH
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f21ccae..e25636b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4012,7 +4012,7 @@ int hisi_qm_alg_register(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 	mutex_unlock(&qm_list->lock);
 
 	if (flag) {
-		ret = qm_list->register_to_crypto();
+		ret = qm_list->register_to_crypto(qm);
 		if (ret) {
 			mutex_lock(&qm_list->lock);
 			list_del(&qm->list);
@@ -4040,7 +4040,7 @@ void hisi_qm_alg_unregister(struct hisi_qm *qm, struct hisi_qm_list *qm_list)
 	mutex_unlock(&qm_list->lock);
 
 	if (list_empty(&qm_list->list))
-		qm_list->unregister_from_crypto();
+		qm_list->unregister_from_crypto(qm);
 }
 EXPORT_SYMBOL_GPL(hisi_qm_alg_unregister);
 
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index 8624d12..a63256a 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -193,8 +193,8 @@ struct hisi_qm_err_ini {
 struct hisi_qm_list {
 	struct mutex lock;
 	struct list_head list;
-	int (*register_to_crypto)(void);
-	void (*unregister_from_crypto)(void);
+	int (*register_to_crypto)(struct hisi_qm *qm);
+	void (*unregister_from_crypto)(struct hisi_qm *qm);
 };
 
 struct hisi_qm {
diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 0849191..17ddb20 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -183,6 +183,6 @@ struct sec_dev {
 
 void sec_destroy_qps(struct hisi_qp **qps, int qp_num);
 struct hisi_qp **sec_create_qps(void);
-int sec_register_to_crypto(void);
-void sec_unregister_from_crypto(void);
+int sec_register_to_crypto(struct hisi_qm *qm);
+void sec_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 2eaa516..f835514 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1634,7 +1634,7 @@ static struct aead_alg sec_aeads[] = {
 		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
 };
 
-int sec_register_to_crypto(void)
+int sec_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -1651,7 +1651,7 @@ int sec_register_to_crypto(void)
 	return ret;
 }
 
-void sec_unregister_from_crypto(void)
+void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
 	crypto_unregister_skciphers(sec_skciphers,
 				    ARRAY_SIZE(sec_skciphers));
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index b2786e1..0e933e7 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -211,6 +211,6 @@ struct sec_sqe {
 	struct sec_sqe_type2 type2;
 };
 
-int sec_register_to_crypto(void);
-void sec_unregister_from_crypto(void);
+int sec_register_to_crypto(struct hisi_qm *qm);
+void sec_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 92397f9..9ed7461 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -62,6 +62,6 @@ struct hisi_zip_sqe {
 };
 
 int zip_create_qps(struct hisi_qp **qps, int ctx_num, int node);
-int hisi_zip_register_to_crypto(void);
-void hisi_zip_unregister_from_crypto(void);
+int hisi_zip_register_to_crypto(struct hisi_qm *qm);
+void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 08b4660..41f6966 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -665,7 +665,7 @@ static struct acomp_alg hisi_zip_acomp_gzip = {
 	}
 };
 
-int hisi_zip_register_to_crypto(void)
+int hisi_zip_register_to_crypto(struct hisi_qm *qm)
 {
 	int ret;
 
@@ -684,7 +684,7 @@ int hisi_zip_register_to_crypto(void)
 	return ret;
 }
 
-void hisi_zip_unregister_from_crypto(void)
+void hisi_zip_unregister_from_crypto(struct hisi_qm *qm)
 {
 	crypto_unregister_acomp(&hisi_zip_acomp_gzip);
 	crypto_unregister_acomp(&hisi_zip_acomp_zlib);
-- 
2.8.1

