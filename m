Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFA28EB1C
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Oct 2020 04:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgJOCY2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Oct 2020 22:24:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbgJOCY1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Oct 2020 22:24:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1857598554734E10E3CB
        for <linux-crypto@vger.kernel.org>; Thu, 15 Oct 2020 10:24:25 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 10:24:21 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 2/2] crypto: hisilicon - fixes some coding style
Date:   Thu, 15 Oct 2020 10:23:04 +0800
Message-ID: <1602728584-47722-3-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
References: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Clean up extra blank lines

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 17 ++++++-----------
 drivers/crypto/hisilicon/sec2/sec_main.c   | 30 ++++++++++++------------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index bb49342..87bc08a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -101,6 +101,7 @@ static int sec_alloc_req_id(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
 
 	req->qp_ctx = qp_ctx;
 	qp_ctx->req_list[req_id] = req;
+
 	return req_id;
 }
 
@@ -317,6 +318,7 @@ static int sec_alloc_pbuf_resource(struct device *dev, struct sec_alg_res *res)
 				j * SEC_PBUF_PKG + pbuf_page_offset;
 		}
 	}
+
 	return 0;
 }
 
@@ -345,12 +347,12 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 	}
 
 	return 0;
+
 alloc_pbuf_fail:
 	if (ctx->alg_type == SEC_AEAD)
 		sec_free_mac_resource(dev, qp_ctx->res);
 alloc_fail:
 	sec_free_civ_resource(dev, res);
-
 	return ret;
 }
 
@@ -419,7 +421,6 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	hisi_acc_free_sgl_pool(dev, qp_ctx->c_in_pool);
 err_destroy_idr:
 	idr_destroy(&qp_ctx->req_idr);
-
 	return ret;
 }
 
@@ -557,9 +558,9 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 		goto err_cipher_init;
 
 	return 0;
+
 err_cipher_init:
 	sec_ctx_base_uninit(ctx);
-
 	return ret;
 }
 
@@ -740,7 +741,6 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
 
 	if (unlikely(pbuf_length != copy_size))
 		dev_err(dev, "copy pbuf data to dst error!\n");
-
 }
 
 static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
@@ -913,9 +913,9 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 	}
 
 	return 0;
+
 bad_key:
 	memzero_explicit(&keys, sizeof(struct crypto_authenc_keys));
-
 	return -EINVAL;
 }
 
@@ -966,7 +966,6 @@ static int sec_request_transfer(struct sec_ctx *ctx, struct sec_req *req)
 
 unmap_req_buf:
 	ctx->req_op->buf_unmap(ctx, req);
-
 	return ret;
 }
 
@@ -1107,7 +1106,6 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 		atomic64_inc(&ctx->sec->debug.dfx.recv_busy_cnt);
 	}
 
-
 	sk_req->base.complete(&sk_req->base, err);
 }
 
@@ -1279,7 +1277,6 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 	sec_request_untransfer(ctx, req);
 err_uninit_req:
 	sec_request_uninit(ctx, req);
-
 	return ret;
 }
 
@@ -1349,7 +1346,6 @@ static int sec_aead_init(struct crypto_aead *tfm)
 	sec_auth_uninit(ctx);
 err_auth_init:
 	sec_ctx_base_uninit(ctx);
-
 	return ret;
 }
 
@@ -1437,8 +1433,8 @@ static int sec_skcipher_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		}
 		return 0;
 	}
-
 	dev_err(dev, "skcipher algorithm error!\n");
+
 	return -EINVAL;
 }
 
@@ -1554,7 +1550,6 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (unlikely(c_alg != SEC_CALG_AES)) {
 		dev_err(SEC_CTX_DEV(ctx), "aead crypto alg error!\n");
 		return -EINVAL;
-
 	}
 	if (sreq->c_req.encrypt)
 		sreq->c_req.c_len = req->cryptlen;
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 5488963..2f52581 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -660,12 +660,10 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 	if (ret)
 		goto failed_to_create;
 
-
 	return 0;
 
 failed_to_create:
 	debugfs_remove_recursive(sec_debugfs_root);
-
 	return ret;
 }
 
@@ -683,13 +681,13 @@ static void sec_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 	while (errs->msg) {
 		if (errs->int_msk & err_sts) {
 			dev_err(dev, "%s [error status=0x%x] found\n",
-				errs->msg, errs->int_msk);
+					errs->msg, errs->int_msk);
 
 			if (SEC_CORE_INT_STATUS_M_ECC & errs->int_msk) {
 				err_val = readl(qm->io_base +
 						SEC_CORE_SRAM_ECC_ERR_INFO);
 				dev_err(dev, "multi ecc sram num=0x%x\n",
-					SEC_ECC_NUM(err_val));
+						SEC_ECC_NUM(err_val));
 			}
 		}
 		errs++;
@@ -724,13 +722,13 @@ static const struct hisi_qm_err_ini sec_err_ini = {
 	.log_dev_hw_err		= sec_log_hw_error,
 	.open_axi_master_ooo	= sec_open_axi_master_ooo,
 	.err_info		= {
-		.ce			= QM_BASE_CE,
-		.nfe			= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT |
-					  QM_ACC_WB_NOT_READY_TIMEOUT,
-		.fe			= 0,
-		.ecc_2bits_mask		= SEC_CORE_INT_STATUS_M_ECC,
-		.msi_wr_port		= BIT(0),
-		.acpi_rst		= "SRST",
+		.ce		= QM_BASE_CE,
+		.nfe		= QM_BASE_NFE | QM_ACC_DO_TASK_TIMEOUT |
+				  QM_ACC_WB_NOT_READY_TIMEOUT,
+		.fe		= 0,
+		.ecc_2bits_mask	= SEC_CORE_INT_STATUS_M_ECC,
+		.msi_wr_port	= BIT(0),
+		.acpi_rst	= "SRST",
 	}
 };
 
@@ -899,17 +897,13 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_alg_unregister:
 	hisi_qm_alg_unregister(qm, &sec_devices);
-
 err_qm_stop:
 	sec_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
-
 err_probe_uninit:
 	sec_probe_uninit(qm);
-
 err_qm_uninit:
 	sec_qm_uninit(qm);
-
 	return ret;
 }
 
@@ -936,9 +930,9 @@ static void sec_remove(struct pci_dev *pdev)
 
 static const struct pci_error_handlers sec_err_handler = {
 	.error_detected = hisi_qm_dev_err_detected,
-	.slot_reset =  hisi_qm_dev_slot_reset,
-	.reset_prepare		= hisi_qm_reset_prepare,
-	.reset_done		= hisi_qm_reset_done,
+	.slot_reset	= hisi_qm_dev_slot_reset,
+	.reset_prepare	= hisi_qm_reset_prepare,
+	.reset_done	= hisi_qm_reset_done,
 };
 
 static struct pci_driver sec_pci_driver = {
-- 
2.8.1

