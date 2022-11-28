Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C378963A833
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Nov 2022 13:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiK1MYK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Nov 2022 07:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiK1MX3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Nov 2022 07:23:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD2D70
        for <linux-crypto@vger.kernel.org>; Mon, 28 Nov 2022 04:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669638103; x=1701174103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IP2DGIevAm+lsCx/q/MWnUzRKPLBAVFNQY/guqI7c6M=;
  b=e1IIzhVnbemO9Dg3jzJWZToME7i5Uy6sReTHCUKtiqsnjMKqTEXfXYMZ
   C/x9CBQVz4Hp58DnTfaeQjzeg3FKNHDrCizvu/O2OSK9sfj8ZSsjfjwOJ
   THlEpDuAIQl09EWz8vS/0/Yux7lY9+64d3FnQaWulnYZfutj7l4fomUFw
   vzba3X77HUcgstD1eXMYmdB4/CxjHfvaKSQfnUmKHdFyw4RVkqMWFKB52
   wbDHeuVl3nfqWw3x3lBYGzbKNFuOTuaD9OfpaMyFxxT0kVi9dD7jSmUnD
   plOzKyFFdWEXRaF+Mj1RRGf95zpRqCmDsKk2xBq1DPXOvXnnyZoEp6Ruw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313517795"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313517795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 04:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817806101"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817806101"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 04:21:40 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>
Subject: [PATCH v3 06/12] crypto: qat - relocate backlog related structures
Date:   Mon, 28 Nov 2022 12:21:17 +0000
Message-Id: <20221128122123.130459-7-giovanni.cabiddu@intel.com>
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

Move the structures qat_instance_backlog and qat_alg_req from
qat_crypto.h to qat_algs_send.h since they are not unique to crypto.
Both structures will be used by the compression service to support
requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Adam Guerin <adam.guerin@intel.com>
---
 drivers/crypto/qat/qat_common/qat_algs_send.h | 16 +++++++++++++++-
 drivers/crypto/qat/qat_common/qat_crypto.h    | 14 +-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.h b/drivers/crypto/qat/qat_common/qat_algs_send.h
index 5ce9f4f69d8f..0baca16e1eff 100644
--- a/drivers/crypto/qat/qat_common/qat_algs_send.h
+++ b/drivers/crypto/qat/qat_common/qat_algs_send.h
@@ -3,7 +3,21 @@
 #ifndef QAT_ALGS_SEND_H
 #define QAT_ALGS_SEND_H
 
-#include "qat_crypto.h"
+#include <linux/list.h>
+#include "adf_transport_internal.h"
+
+struct qat_instance_backlog {
+	struct list_head list;
+	spinlock_t lock; /* protects backlog list */
+};
+
+struct qat_alg_req {
+	u32 *fw_req;
+	struct adf_etr_ring_data *tx_ring;
+	struct crypto_async_request *base;
+	struct list_head list;
+	struct qat_instance_backlog *backlog;
+};
 
 int qat_alg_send_message(struct qat_alg_req *req);
 void qat_alg_send_backlog(struct qat_instance_backlog *backlog);
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index bb116357a568..505e881022a7 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -8,21 +8,9 @@
 #include <linux/slab.h>
 #include "adf_accel_devices.h"
 #include "icp_qat_fw_la.h"
+#include "qat_algs_send.h"
 #include "qat_bl.h"
 
-struct qat_instance_backlog {
-	struct list_head list;
-	spinlock_t lock; /* protects backlog list */
-};
-
-struct qat_alg_req {
-	u32 *fw_req;
-	struct adf_etr_ring_data *tx_ring;
-	struct crypto_async_request *base;
-	struct list_head list;
-	struct qat_instance_backlog *backlog;
-};
-
 struct qat_crypto_instance {
 	struct adf_etr_ring_data *sym_tx;
 	struct adf_etr_ring_data *sym_rx;
-- 
2.38.1

