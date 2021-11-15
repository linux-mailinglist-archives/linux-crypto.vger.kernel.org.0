Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0E450416
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Nov 2021 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhKOMI7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Nov 2021 07:08:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:13648 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhKOMHn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Nov 2021 07:07:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233265610"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233265610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="535486531"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2021 04:04:20 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 20/24] crypto: qat - pass the PF2VF responses back to the callers
Date:   Mon, 15 Nov 2021 12:03:32 +0000
Message-Id: <20211115120336.22292-21-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
References: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

Currently, any PF response to a VF request is fully parsed during the
interrupt handling. This way the individual response values are stored
into the accel_dev structure, preventing the caller to access and decode
the full response message itself.

Change this behavior, by letting the API return back the entire message
to the caller, in order to:
  - keep correlated code together, that is, the (building of the)
    request and the (decoding of the) response;
  - avoid polluting the accel_dev data structure with unnecessary and at
    times temporary values; only the entire message is stored in a
    temporary buffer.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c      |  2 +-
 drivers/crypto/qat/qat_c62xvf/adf_drv.c       |  2 +-
 .../crypto/qat/qat_common/adf_accel_devices.h |  4 ++--
 .../crypto/qat/qat_common/adf_pfvf_vf_msg.c   | 23 +++++++++++-------
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.c | 24 +++++++++----------
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.h |  2 +-
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c   |  2 +-
 7 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
index 1df1b868978d..0ba1d293bb81 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -171,7 +171,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
-	init_completion(&accel_dev->vf.iov_msg_completion);
+	init_completion(&accel_dev->vf.msg_received);
 
 	ret = qat_crypto_dev_config(accel_dev);
 	if (ret)
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
index 8103bd81d617..176d8e2786f4 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -171,7 +171,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
-	init_completion(&accel_dev->vf.iov_msg_completion);
+	init_completion(&accel_dev->vf.msg_received);
 
 	ret = qat_crypto_dev_config(accel_dev);
 	if (ret)
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index a99800e51343..5ca9458d9158 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -271,8 +271,8 @@ struct adf_accel_dev {
 			char irq_name[ADF_MAX_MSIX_VECTOR_NAME];
 			struct tasklet_struct pf2vf_bh_tasklet;
 			struct mutex vf2pf_lock; /* protect CSR access */
-			struct completion iov_msg_completion;
-			u8 compatible;
+			struct completion msg_received;
+			u32 response; /* temp field holding pf2vf response */
 			u8 pf_version;
 		} vf;
 	};
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
index 7969a644e24b..d5cccec03a3b 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
@@ -52,7 +52,10 @@ EXPORT_SYMBOL_GPL(adf_vf2pf_notify_shutdown);
 int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	u8 pf_version;
 	u32 msg = 0;
+	int compat;
+	u32 resp;
 	int ret;
 
 	msg = ADF_VF2PF_MSGORIGIN_SYSTEM;
@@ -60,34 +63,38 @@ int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 	msg |= ADF_PFVF_COMPAT_THIS_VERSION << ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
 	BUILD_BUG_ON(ADF_PFVF_COMPAT_THIS_VERSION > 255);
 
-	ret = adf_send_vf2pf_req(accel_dev, msg);
+	ret = adf_send_vf2pf_req(accel_dev, msg, &resp);
 	if (ret) {
 		dev_err(&GET_DEV(accel_dev),
 			"Failed to send Compatibility Version Request.\n");
 		return ret;
 	}
 
+	pf_version = (resp & ADF_PF2VF_VERSION_RESP_VERS_MASK)
+		     >> ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
+	compat = (resp & ADF_PF2VF_VERSION_RESP_RESULT_MASK)
+		 >> ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
+
 	/* Response from PF received, check compatibility */
-	switch (accel_dev->vf.compatible) {
+	switch (compat) {
 	case ADF_PF2VF_VF_COMPATIBLE:
 		break;
 	case ADF_PF2VF_VF_COMPAT_UNKNOWN:
 		/* VF is newer than PF and decides whether it is compatible */
-		if (accel_dev->vf.pf_version >= hw_data->min_iov_compat_ver) {
-			accel_dev->vf.compatible = ADF_PF2VF_VF_COMPATIBLE;
+		if (pf_version >= hw_data->min_iov_compat_ver)
 			break;
-		}
 		fallthrough;
 	case ADF_PF2VF_VF_INCOMPATIBLE:
 		dev_err(&GET_DEV(accel_dev),
 			"PF (vers %d) and VF (vers %d) are not compatible\n",
-			accel_dev->vf.pf_version,
-			ADF_PFVF_COMPAT_THIS_VERSION);
+			pf_version, ADF_PFVF_COMPAT_THIS_VERSION);
 		return -EINVAL;
 	default:
 		dev_err(&GET_DEV(accel_dev),
 			"Invalid response from PF; assume not compatible\n");
 		return -EINVAL;
 	}
-	return ret;
+
+	accel_dev->vf.pf_version = pf_version;
+	return 0;
 }
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
index 62817bcec121..ea1a00e746ff 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
@@ -47,18 +47,19 @@ static u32 adf_recv_pf2vf_msg(struct adf_accel_dev *accel_dev)
  * adf_send_vf2pf_req() - send VF2PF request message
  * @accel_dev:	Pointer to acceleration device.
  * @msg:	Request message to send
+ * @resp:	Returned PF response
  *
  * This function sends a message that requires a response from the VF to the PF
  * and waits for a reply.
  *
  * Return: 0 on success, error code otherwise.
  */
-int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg)
+int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp)
 {
 	unsigned long timeout = msecs_to_jiffies(ADF_PFVF_MSG_RESP_TIMEOUT);
 	int ret;
 
-	reinit_completion(&accel_dev->vf.iov_msg_completion);
+	reinit_completion(&accel_dev->vf.msg_received);
 
 	/* Send request from VF to PF */
 	ret = adf_send_vf2pf_msg(accel_dev, msg);
@@ -69,13 +70,19 @@ int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg)
 	}
 
 	/* Wait for response */
-	if (!wait_for_completion_timeout(&accel_dev->vf.iov_msg_completion,
+	if (!wait_for_completion_timeout(&accel_dev->vf.msg_received,
 					 timeout)) {
 		dev_err(&GET_DEV(accel_dev),
 			"PFVF request/response message timeout expired\n");
 		return -EIO;
 	}
 
+	if (likely(resp))
+		*resp = accel_dev->vf.response;
+
+	/* Once copied, set to an invalid value */
+	accel_dev->vf.response = 0;
+
 	return 0;
 }
 
@@ -89,15 +96,8 @@ static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev, u32 msg)
 		adf_pf2vf_handle_pf_restarting(accel_dev);
 		return false;
 	case ADF_PF2VF_MSGTYPE_VERSION_RESP:
-		dev_dbg(&GET_DEV(accel_dev),
-			"Version resp received from PF 0x%x\n", msg);
-		accel_dev->vf.pf_version =
-			(msg & ADF_PF2VF_VERSION_RESP_VERS_MASK) >>
-			ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
-		accel_dev->vf.compatible =
-			(msg & ADF_PF2VF_VERSION_RESP_RESULT_MASK) >>
-			ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
-		complete(&accel_dev->vf.iov_msg_completion);
+		accel_dev->vf.response = msg;
+		complete(&accel_dev->vf.msg_received);
 		return true;
 	default:
 		dev_err(&GET_DEV(accel_dev),
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
index a3ab24c7d18b..6226d4d9d520 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
@@ -7,7 +7,7 @@
 #include "adf_accel_devices.h"
 
 int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 msg);
-int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg);
+int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp);
 
 int adf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev);
 
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
index 99d90f3ea2b7..ee45d688b5d7 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -171,7 +171,7 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	pci_set_master(pdev);
 	/* Completion for VF2PF request/response message exchange */
-	init_completion(&accel_dev->vf.iov_msg_completion);
+	init_completion(&accel_dev->vf.msg_received);
 
 	ret = qat_crypto_dev_config(accel_dev);
 	if (ret)
-- 
2.33.1

