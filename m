Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614A763A82F
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Nov 2022 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiK1MXz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Nov 2022 07:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiK1MX2 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Nov 2022 07:23:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41941D31E
        for <linux-crypto@vger.kernel.org>; Mon, 28 Nov 2022 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669638102; x=1701174102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0Y/gtcO93SfFJiA79y9TSnsqLSNrp6OaOuxT7jOCUs=;
  b=TJLahNS5sVsjJ6pgoFBmcIeMl8ORrFfZhVQGXiNZiPMhNiwXSepETbfB
   VdbIieNHQeUE/fHwZNdnhgbtD4384AvQB4T0MDlESk62QSJ8y7bpxknk9
   40zqWe2uAWULFQNDP3zAqCvEv85c/uGIoP5HVGhDkCRnBoJhuVP7Hu2Xf
   7YX6KmA6Q90Gsu+6e8/Gy1OobMeykBjxdW6bZCDIt1hTz2CkS5ba+wUR9
   lmjm71E6PJqbRWeJszmho9oZJCHGxy4RhU1LAWxGolq5yCAIHHh2cWkCV
   aTDqZf9PgO98y+sDu+/fxJN+mqqmVcPjWTZk+Cdzl17zUaFehVJyrx8xR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313517781"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313517781"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817806076"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817806076"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 04:21:36 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH v3 04/12] crypto: qat - generalize crypto request buffers
Date:   Mon, 28 Nov 2022 12:21:15 +0000
Message-Id: <20221128122123.130459-5-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128122123.130459-1-giovanni.cabiddu@intel.com>
References: <20221128122123.130459-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The structure qat_crypto_request_buffs which contains the source and
destination buffer lists and correspondent sizes and dma addresses is
also required for the compression service.
Rename it as qat_request_buffs and move it to qat_bl.h.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 drivers/crypto/qat/qat_common/qat_bl.c     |  4 +--
 drivers/crypto/qat/qat_common/qat_bl.h     | 38 ++++++++++++++++++++--
 drivers/crypto/qat/qat_common/qat_crypto.h | 36 ++------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_bl.c b/drivers/crypto/qat/qat_common/qat_bl.c
index 5e319887f8d6..c32b12d386f0 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.c
+++ b/drivers/crypto/qat/qat_common/qat_bl.c
@@ -11,7 +11,7 @@
 #include "qat_crypto.h"
 
 void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
-		      struct qat_crypto_request_buffs *buf)
+		      struct qat_request_buffs *buf)
 {
 	struct device *dev = &GET_DEV(accel_dev);
 	struct qat_alg_buf_list *bl = buf->bl;
@@ -53,7 +53,7 @@ void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
 int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		       struct scatterlist *sgl,
 		       struct scatterlist *sglout,
-		       struct qat_crypto_request_buffs *buf,
+		       struct qat_request_buffs *buf,
 		       gfp_t flags)
 {
 	struct device *dev = &GET_DEV(accel_dev);
diff --git a/drivers/crypto/qat/qat_common/qat_bl.h b/drivers/crypto/qat/qat_common/qat_bl.h
index 241299c219dd..1c534c57a36b 100644
--- a/drivers/crypto/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/qat/qat_common/qat_bl.h
@@ -4,14 +4,46 @@
 #define QAT_BL_H
 #include <linux/scatterlist.h>
 #include <linux/types.h>
-#include "qat_crypto.h"
+
+#define QAT_MAX_BUFF_DESC	4
+
+struct qat_alg_buf {
+	u32 len;
+	u32 resrvd;
+	u64 addr;
+} __packed;
+
+struct qat_alg_buf_list {
+	u64 resrvd;
+	u32 num_bufs;
+	u32 num_mapped_bufs;
+	struct qat_alg_buf bufers[];
+} __packed;
+
+struct qat_alg_fixed_buf_list {
+	struct qat_alg_buf_list sgl_hdr;
+	struct qat_alg_buf descriptors[QAT_MAX_BUFF_DESC];
+} __packed __aligned(64);
+
+struct qat_request_buffs {
+	struct qat_alg_buf_list *bl;
+	dma_addr_t blp;
+	struct qat_alg_buf_list *blout;
+	dma_addr_t bloutp;
+	size_t sz;
+	size_t sz_out;
+	bool sgl_src_valid;
+	bool sgl_dst_valid;
+	struct qat_alg_fixed_buf_list sgl_src;
+	struct qat_alg_fixed_buf_list sgl_dst;
+};
 
 void qat_bl_free_bufl(struct adf_accel_dev *accel_dev,
-		      struct qat_crypto_request_buffs *buf);
+		      struct qat_request_buffs *buf);
 int qat_bl_sgl_to_bufl(struct adf_accel_dev *accel_dev,
 		       struct scatterlist *sgl,
 		       struct scatterlist *sglout,
-		       struct qat_crypto_request_buffs *buf,
+		       struct qat_request_buffs *buf,
 		       gfp_t flags);
 
 #endif
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index df3c738ce323..bb116357a568 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include "adf_accel_devices.h"
 #include "icp_qat_fw_la.h"
+#include "qat_bl.h"
 
 struct qat_instance_backlog {
 	struct list_head list;
@@ -35,39 +36,6 @@ struct qat_crypto_instance {
 	struct qat_instance_backlog backlog;
 };
 
-#define QAT_MAX_BUFF_DESC	4
-
-struct qat_alg_buf {
-	u32 len;
-	u32 resrvd;
-	u64 addr;
-} __packed;
-
-struct qat_alg_buf_list {
-	u64 resrvd;
-	u32 num_bufs;
-	u32 num_mapped_bufs;
-	struct qat_alg_buf bufers[];
-} __packed;
-
-struct qat_alg_fixed_buf_list {
-	struct qat_alg_buf_list sgl_hdr;
-	struct qat_alg_buf descriptors[QAT_MAX_BUFF_DESC];
-} __packed __aligned(64);
-
-struct qat_crypto_request_buffs {
-	struct qat_alg_buf_list *bl;
-	dma_addr_t blp;
-	struct qat_alg_buf_list *blout;
-	dma_addr_t bloutp;
-	size_t sz;
-	size_t sz_out;
-	bool sgl_src_valid;
-	bool sgl_dst_valid;
-	struct qat_alg_fixed_buf_list sgl_src;
-	struct qat_alg_fixed_buf_list sgl_dst;
-};
-
 struct qat_crypto_request;
 
 struct qat_crypto_request {
@@ -80,7 +48,7 @@ struct qat_crypto_request {
 		struct aead_request *aead_req;
 		struct skcipher_request *skcipher_req;
 	};
-	struct qat_crypto_request_buffs buf;
+	struct qat_request_buffs buf;
 	void (*cb)(struct icp_qat_fw_la_resp *resp,
 		   struct qat_crypto_request *req);
 	union {
-- 
2.38.1

