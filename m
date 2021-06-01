Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730FF393611
	for <lists+linux-crypto@lfdr.de>; Thu, 27 May 2021 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhE0TPJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 May 2021 15:15:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:7511 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234775AbhE0TPI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 May 2021 15:15:08 -0400
IronPort-SDR: 2zob3/fzHKRnLO7t4p3SM7jGuahaGrGYof7U8qM/d/qshTmRX+fGc/uHlR/GeYjF83Q90K9QEG
 oIVubZKzCekQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="264012458"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="264012458"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 12:13:33 -0700
IronPort-SDR: ENe62335a0arQYclZ3Pg3Ejc2ygM0u5UM3mFzF/XE2dPOz7VAuo8MSW8jdnYogJvBmBI1KA8/f
 M9jO1btISNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="480717794"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2021 12:13:32 -0700
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Marco Chiappero <marco.chiappero@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 08/10] crypto: qat - rename compatibility version definition
Date:   Thu, 27 May 2021 20:12:49 +0100
Message-Id: <20210527191251.6317-9-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210527191251.6317-1-marco.chiappero@intel.com>
References: <20210527191251.6317-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Rename ADF_PFVF_COMPATIBILITY_VERSION in ADF_PFVF_COMPAT_THIS_VERSION
since it is used to indicate the current version of the PFVF protocol.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c |  2 +-
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |  2 +-
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c      |  2 +-
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c |  2 +-
 .../crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c |  2 +-
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c  | 18 +++++++++---------
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.h  |  2 +-
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c    |  2 +-
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c    |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
index 3524ddd48930..a72142413caa 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -218,7 +218,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data)
 	hw_data->enable_ints = adf_enable_ints;
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_flr;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->admin_ae_mask = ADF_4XXX_ADMIN_AE_MASK;
 	hw_data->uof_get_num_objs = uof_get_num_objs;
 	hw_data->uof_get_name = uof_get_name;
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 1dd64af22bea..1c7f6a6f6f2d 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -211,7 +211,7 @@ void adf_init_hw_data_c3xxx(struct adf_hw_device_data *hw_data)
 	hw_data->enable_ints = adf_enable_ints;
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_flr;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->set_ssm_wdtimer = adf_gen2_set_ssm_wdtimer;
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index 15f6b9bdfb22..476a4bf3de56 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -96,7 +96,7 @@ void adf_init_hw_data_c3xxxiov(struct adf_hw_device_data *hw_data)
 	hw_data->get_sku = get_sku;
 	hw_data->enable_ints = adf_vf_void_noop;
 	hw_data->enable_vf2pf_comms = adf_enable_vf2pf_comms;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 30337390513c..a202f912820c 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -213,7 +213,7 @@ void adf_init_hw_data_c62x(struct adf_hw_device_data *hw_data)
 	hw_data->enable_ints = adf_enable_ints;
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_flr;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->set_ssm_wdtimer = adf_gen2_set_ssm_wdtimer;
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index d231583428c9..0c867208eb90 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -96,7 +96,7 @@ void adf_init_hw_data_c62xiov(struct adf_hw_device_data *hw_data)
 	hw_data->get_sku = get_sku;
 	hw_data->enable_ints = adf_vf_void_noop;
 	hw_data->enable_vf2pf_comms = adf_enable_vf2pf_comms;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index a1b77bd7a894..e29f5f1dc806 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -216,7 +216,7 @@ void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 		resp = (ADF_PF2VF_MSGORIGIN_SYSTEM |
 			 (ADF_PF2VF_MSGTYPE_VERSION_RESP <<
 			  ADF_PF2VF_MSGTYPE_SHIFT) |
-			 (ADF_PFVF_COMPATIBILITY_VERSION <<
+			 (ADF_PFVF_COMPAT_THIS_VERSION <<
 			  ADF_PF2VF_VERSION_RESP_VERS_SHIFT));
 
 		dev_dbg(&GET_DEV(accel_dev),
@@ -226,19 +226,19 @@ void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 		if (vf_compat_ver < hw_data->min_iov_compat_ver) {
 			dev_err(&GET_DEV(accel_dev),
 				"VF (vers %d) incompatible with PF (vers %d)\n",
-				vf_compat_ver, ADF_PFVF_COMPATIBILITY_VERSION);
+				vf_compat_ver, ADF_PFVF_COMPAT_THIS_VERSION);
 			resp |= ADF_PF2VF_VF_INCOMPATIBLE <<
 				ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
-		} else if (vf_compat_ver > ADF_PFVF_COMPATIBILITY_VERSION) {
+		} else if (vf_compat_ver > ADF_PFVF_COMPAT_THIS_VERSION) {
 			dev_err(&GET_DEV(accel_dev),
 				"VF (vers %d) compat with PF (vers %d) unkn.\n",
-				vf_compat_ver, ADF_PFVF_COMPATIBILITY_VERSION);
+				vf_compat_ver, ADF_PFVF_COMPAT_THIS_VERSION);
 			resp |= ADF_PF2VF_VF_COMPAT_UNKNOWN <<
 				ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
 		} else {
 			dev_dbg(&GET_DEV(accel_dev),
 				"VF (vers %d) compatible with PF (vers %d)\n",
-				vf_compat_ver, ADF_PFVF_COMPATIBILITY_VERSION);
+				vf_compat_ver, ADF_PFVF_COMPAT_THIS_VERSION);
 			resp |= ADF_PF2VF_VF_COMPATIBLE <<
 				ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
 		}
@@ -251,7 +251,7 @@ void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 		resp = (ADF_PF2VF_MSGORIGIN_SYSTEM |
 			 (ADF_PF2VF_MSGTYPE_VERSION_RESP <<
 			  ADF_PF2VF_MSGTYPE_SHIFT) |
-			 (ADF_PFVF_COMPATIBILITY_VERSION <<
+			 (ADF_PFVF_COMPAT_THIS_VERSION <<
 			  ADF_PF2VF_VERSION_RESP_VERS_SHIFT));
 		resp |= ADF_PF2VF_VF_COMPATIBLE <<
 			ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
@@ -313,8 +313,8 @@ static int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 
 	msg = ADF_VF2PF_MSGORIGIN_SYSTEM;
 	msg |= ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ << ADF_VF2PF_MSGTYPE_SHIFT;
-	msg |= ADF_PFVF_COMPATIBILITY_VERSION << ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
-	BUILD_BUG_ON(ADF_PFVF_COMPATIBILITY_VERSION > 255);
+	msg |= ADF_PFVF_COMPAT_THIS_VERSION << ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
+	BUILD_BUG_ON(ADF_PFVF_COMPAT_THIS_VERSION > 255);
 
 	/* Send request from VF to PF */
 	ret = adf_iov_putmsg(accel_dev, msg, 0);
@@ -345,7 +345,7 @@ static int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 		dev_err(&GET_DEV(accel_dev),
 			"PF (vers %d) and VF (vers %d) are not compatible\n",
 			accel_dev->vf.pf_version,
-			ADF_PFVF_COMPATIBILITY_VERSION);
+			ADF_PFVF_COMPAT_THIS_VERSION);
 		return -EINVAL;
 	default:
 		dev_err(&GET_DEV(accel_dev),
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
index 0690c031bfce..ffd43aa50b57 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
@@ -52,7 +52,7 @@
  * IN_USE_BY pattern as part of a collision control scheme (see adf_iov_putmsg).
  */
 
-#define ADF_PFVF_COMPATIBILITY_VERSION		0x1	/* PF<->VF compat */
+#define ADF_PFVF_COMPAT_THIS_VERSION		0x1	/* PF<->VF compat */
 
 /* PF->VF messages */
 #define ADF_PF2VF_INT				BIT(0)
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 7dd7cd6c3ef8..dced2426edc1 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -232,7 +232,7 @@ void adf_init_hw_data_dh895xcc(struct adf_hw_device_data *hw_data)
 	hw_data->enable_ints = adf_enable_ints;
 	hw_data->enable_vf2pf_comms = adf_pf_enable_vf2pf_comms;
 	hw_data->reset_device = adf_reset_sbr;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
 }
 
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index f14fb82ed6df..ac233a39a530 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -96,7 +96,7 @@ void adf_init_hw_data_dh895xcciov(struct adf_hw_device_data *hw_data)
 	hw_data->get_sku = get_sku;
 	hw_data->enable_ints = adf_vf_void_noop;
 	hw_data->enable_vf2pf_comms = adf_enable_vf2pf_comms;
-	hw_data->min_iov_compat_ver = ADF_PFVF_COMPATIBILITY_VERSION;
+	hw_data->min_iov_compat_ver = ADF_PFVF_COMPAT_THIS_VERSION;
 	hw_data->dev_class->instances++;
 	adf_devmgr_update_class_index(hw_data);
 	adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
-- 
2.26.2

