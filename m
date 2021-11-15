Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED52450400
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Nov 2021 13:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhKOMHD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Nov 2021 07:07:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:13629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhKOMG4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Nov 2021 07:06:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233265526"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233265526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="535486340"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2021 04:03:52 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 04/24] crypto: qat - move VF message handler to adf_vf2pf_msg.c
Date:   Mon, 15 Nov 2021 12:03:16 +0000
Message-Id: <20211115120336.22292-5-giovanni.cabiddu@intel.com>
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

Move the reading and parsing of a PF2VF message from the bottom half
function in adf_vf_isr.c, adf_pf2vf_bh_handler(), to the PFVF protocol
file adf_vf2pf_msg.c, for better code organization.

The receive and handle logic has been moved to a new function called
adf_recv_and_handle_pf2vf_msg() which returns a boolean indicating if
interrupts need to be re-enabled or not.
A slight refactoring has been done to avoid calculating the PF2VF CSR
offset twice and repeating the clearing of the PF2VFINT bit.

The "PF restarting" logic, now defined in the function
adf_pf2vf_handle_pf_restaring(), has been kept in adf_vf_isr.c due to
the dependencies with the adf_vf_stop_wq workqueue.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_common/adf_common_drv.h    |  2 +
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c | 59 ++++++++++++
 drivers/crypto/qat/qat_common/adf_vf_isr.c    | 91 +++++--------------
 3 files changed, 86 insertions(+), 66 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index d06b5aab7fc3..050db8967983 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -194,6 +194,8 @@ void adf_disable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 				  u32 vf_mask);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 				 u32 vf_mask);
+bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev);
+int adf_pf2vf_handle_pf_restarting(struct adf_accel_dev *accel_dev);
 int adf_enable_pf2vf_comms(struct adf_accel_dev *accel_dev);
 void adf_enable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
index 8d11bb24cea0..064477fcb5fb 100644
--- a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
@@ -46,3 +46,62 @@ void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 				"Failed to send Shutdown event to PF\n");
 }
 EXPORT_SYMBOL_GPL(adf_vf2pf_notify_shutdown);
+
+bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct adf_bar *pmisc =
+			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
+	void __iomem *pmisc_bar_addr = pmisc->virt_addr;
+	u32 offset = hw_data->get_pf2vf_offset(0);
+	bool ret;
+	u32 msg;
+
+	/* Read the message from PF */
+	msg = ADF_CSR_RD(pmisc_bar_addr, offset);
+	if (!(msg & ADF_PF2VF_INT)) {
+		dev_info(&GET_DEV(accel_dev),
+			 "Spurious PF2VF interrupt, msg %X. Ignored\n", msg);
+		return true;
+	}
+
+	if (!(msg & ADF_PF2VF_MSGORIGIN_SYSTEM))
+		/* Ignore legacy non-system (non-kernel) PF2VF messages */
+		goto err;
+
+	switch ((msg & ADF_PF2VF_MSGTYPE_MASK) >> ADF_PF2VF_MSGTYPE_SHIFT) {
+	case ADF_PF2VF_MSGTYPE_RESTARTING:
+		dev_dbg(&GET_DEV(accel_dev),
+			"Restarting msg received from PF 0x%x\n", msg);
+
+		adf_pf2vf_handle_pf_restarting(accel_dev);
+		ret = false;
+		break;
+	case ADF_PF2VF_MSGTYPE_VERSION_RESP:
+		dev_dbg(&GET_DEV(accel_dev),
+			"Version resp received from PF 0x%x\n", msg);
+		accel_dev->vf.pf_version =
+			(msg & ADF_PF2VF_VERSION_RESP_VERS_MASK) >>
+			ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
+		accel_dev->vf.compatible =
+			(msg & ADF_PF2VF_VERSION_RESP_RESULT_MASK) >>
+			ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
+		complete(&accel_dev->vf.iov_msg_completion);
+		ret = true;
+		break;
+	default:
+		goto err;
+	}
+
+	/* To ack, clear the PF2VFINT bit */
+	msg &= ~ADF_PF2VF_INT;
+	ADF_CSR_WR(pmisc_bar_addr, offset, msg);
+	return ret;
+
+err:
+	dev_err(&GET_DEV(accel_dev),
+		"Unknown message from PF (0x%x); leaving PF2VF ints disabled\n",
+		msg);
+
+	return false;
+}
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index db5e7abbe5f3..b17040b8a4b9 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -85,78 +85,37 @@ static void adf_dev_stop_async(struct work_struct *work)
 	kfree(stop_data);
 }
 
-static void adf_pf2vf_bh_handler(void *data)
+int adf_pf2vf_handle_pf_restarting(struct adf_accel_dev *accel_dev)
 {
-	struct adf_accel_dev *accel_dev = data;
-	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct adf_bar *pmisc =
-			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
-	void __iomem *pmisc_bar_addr = pmisc->virt_addr;
-	u32 msg;
-
-	/* Read the message from PF */
-	msg = ADF_CSR_RD(pmisc_bar_addr, hw_data->get_pf2vf_offset(0));
-	if (!(msg & ADF_PF2VF_INT)) {
-		dev_info(&GET_DEV(accel_dev),
-			 "Spurious PF2VF interrupt, msg %X. Ignored\n", msg);
-		goto out;
-	}
+	struct adf_vf_stop_data *stop_data;
 
-	if (!(msg & ADF_PF2VF_MSGORIGIN_SYSTEM))
-		/* Ignore legacy non-system (non-kernel) PF2VF messages */
-		goto err;
-
-	switch ((msg & ADF_PF2VF_MSGTYPE_MASK) >> ADF_PF2VF_MSGTYPE_SHIFT) {
-	case ADF_PF2VF_MSGTYPE_RESTARTING: {
-		struct adf_vf_stop_data *stop_data;
-
-		dev_dbg(&GET_DEV(accel_dev),
-			"Restarting msg received from PF 0x%x\n", msg);
-
-		clear_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
-
-		stop_data = kzalloc(sizeof(*stop_data), GFP_ATOMIC);
-		if (!stop_data) {
-			dev_err(&GET_DEV(accel_dev),
-				"Couldn't schedule stop for vf_%d\n",
-				accel_dev->accel_id);
-			return;
-		}
-		stop_data->accel_dev = accel_dev;
-		INIT_WORK(&stop_data->work, adf_dev_stop_async);
-		queue_work(adf_vf_stop_wq, &stop_data->work);
-		/* To ack, clear the PF2VFINT bit */
-		msg &= ~ADF_PF2VF_INT;
-		ADF_CSR_WR(pmisc_bar_addr, hw_data->get_pf2vf_offset(0), msg);
-		return;
-	}
-	case ADF_PF2VF_MSGTYPE_VERSION_RESP:
-		dev_dbg(&GET_DEV(accel_dev),
-			"Version resp received from PF 0x%x\n", msg);
-		accel_dev->vf.pf_version =
-			(msg & ADF_PF2VF_VERSION_RESP_VERS_MASK) >>
-			ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
-		accel_dev->vf.compatible =
-			(msg & ADF_PF2VF_VERSION_RESP_RESULT_MASK) >>
-			ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
-		complete(&accel_dev->vf.iov_msg_completion);
-		break;
-	default:
-		goto err;
+	clear_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
+	stop_data = kzalloc(sizeof(*stop_data), GFP_ATOMIC);
+	if (!stop_data) {
+		dev_err(&GET_DEV(accel_dev),
+			"Couldn't schedule stop for vf_%d\n",
+			accel_dev->accel_id);
+		return -ENOMEM;
 	}
+	stop_data->accel_dev = accel_dev;
+	INIT_WORK(&stop_data->work, adf_dev_stop_async);
+	queue_work(adf_vf_stop_wq, &stop_data->work);
 
-	/* To ack, clear the PF2VFINT bit */
-	msg &= ~ADF_PF2VF_INT;
-	ADF_CSR_WR(pmisc_bar_addr, hw_data->get_pf2vf_offset(0), msg);
+	return 0;
+}
+
+static void adf_pf2vf_bh_handler(void *data)
+{
+	struct adf_accel_dev *accel_dev = data;
+	bool ret;
+
+	ret = adf_recv_and_handle_pf2vf_msg(accel_dev);
+	if (ret)
+		/* Re-enable PF2VF interrupts */
+		adf_enable_pf2vf_interrupts(accel_dev);
 
-out:
-	/* Re-enable PF2VF interrupts */
-	adf_enable_pf2vf_interrupts(accel_dev);
 	return;
-err:
-	dev_err(&GET_DEV(accel_dev),
-		"Unknown message from PF (0x%x); leaving PF2VF ints disabled\n",
-		msg);
+
 }
 
 static int adf_setup_pf2vf_bh(struct adf_accel_dev *accel_dev)
-- 
2.33.1

