Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE74548D2
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Nov 2021 15:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhKQOem (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 17 Nov 2021 09:34:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:57939 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237856AbhKQOej (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 17 Nov 2021 09:34:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="257722677"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="257722677"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 06:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="735829818"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2021 06:31:39 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v3 19/25] crypto: qat - reorganize PFVF protocol definitions
Date:   Wed, 17 Nov 2021 14:30:52 +0000
Message-Id: <20211117143058.211550-20-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117143058.211550-1-giovanni.cabiddu@intel.com>
References: <20211117143058.211550-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

Organize PFVF protocol definitions by type rather than direction, by
keeping related fields close.
Also, make sure the order is consistent for both PF and VF definitions.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h | 36 +++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
index 0520466563fd..23f4c4b35dac 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
@@ -53,34 +53,21 @@
  * adf_gen2_pfvf_send() in adf_pf2vf_msg.c).
  */
 
-#define ADF_PFVF_COMPAT_THIS_VERSION		0x1	/* PF<->VF compat */
-
 /* PF->VF messages */
 #define ADF_PF2VF_INT				BIT(0)
 #define ADF_PF2VF_MSGORIGIN_SYSTEM		BIT(1)
+#define ADF_PF2VF_IN_USE_BY_PF			0x6AC20000
+#define ADF_PF2VF_IN_USE_BY_PF_MASK		0xFFFE0000
 #define ADF_PF2VF_MSGTYPE_MASK			0x0000003C
 #define ADF_PF2VF_MSGTYPE_SHIFT			2
 #define ADF_PF2VF_MSGTYPE_RESTARTING		0x01
 #define ADF_PF2VF_MSGTYPE_VERSION_RESP		0x02
-#define ADF_PF2VF_IN_USE_BY_PF			0x6AC20000
-#define ADF_PF2VF_IN_USE_BY_PF_MASK		0xFFFE0000
-
-/* PF->VF Version Response */
-#define ADF_PF2VF_VERSION_RESP_VERS_MASK	0x00003FC0
-#define ADF_PF2VF_VERSION_RESP_VERS_SHIFT	6
-#define ADF_PF2VF_VERSION_RESP_RESULT_MASK	0x0000C000
-#define ADF_PF2VF_VERSION_RESP_RESULT_SHIFT	14
-#define ADF_PF2VF_MINORVERSION_SHIFT		6
-#define ADF_PF2VF_MAJORVERSION_SHIFT		10
-#define ADF_PF2VF_VF_COMPATIBLE			1
-#define ADF_PF2VF_VF_INCOMPATIBLE		2
-#define ADF_PF2VF_VF_COMPAT_UNKNOWN		3
 
 /* VF->PF messages */
-#define ADF_VF2PF_IN_USE_BY_VF			0x00006AC2
-#define ADF_VF2PF_IN_USE_BY_VF_MASK		0x0000FFFE
 #define ADF_VF2PF_INT				BIT(16)
 #define ADF_VF2PF_MSGORIGIN_SYSTEM		BIT(17)
+#define ADF_VF2PF_IN_USE_BY_VF			0x00006AC2
+#define ADF_VF2PF_IN_USE_BY_VF_MASK		0x0000FFFE
 #define ADF_VF2PF_MSGTYPE_MASK			0x003C0000
 #define ADF_VF2PF_MSGTYPE_SHIFT			18
 #define ADF_VF2PF_MSGTYPE_INIT			0x3
@@ -88,6 +75,21 @@
 #define ADF_VF2PF_MSGTYPE_VERSION_REQ		0x5
 #define ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ	0x6
 
+/* VF/PF compatibility version. */
+/* Reference to the current version */
+#define ADF_PFVF_COMPAT_THIS_VERSION		1  /* PF<->VF compat */
+
+/* PF->VF Version Response */
+#define ADF_PF2VF_MINORVERSION_SHIFT		6
+#define ADF_PF2VF_MAJORVERSION_SHIFT		10
+#define ADF_PF2VF_VERSION_RESP_VERS_MASK	0x00003FC0
+#define ADF_PF2VF_VERSION_RESP_VERS_SHIFT	6
+#define ADF_PF2VF_VERSION_RESP_RESULT_MASK	0x0000C000
+#define ADF_PF2VF_VERSION_RESP_RESULT_SHIFT	14
+#define ADF_PF2VF_VF_COMPATIBLE			1
+#define ADF_PF2VF_VF_INCOMPATIBLE		2
+#define ADF_PF2VF_VF_COMPAT_UNKNOWN		3
+
 /* VF->PF Compatible Version Request */
 #define ADF_VF2PF_COMPAT_VER_REQ_SHIFT		22
 
-- 
2.33.1

