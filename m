Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EA450406
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Nov 2021 13:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhKOMHG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Nov 2021 07:07:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:13626 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhKOMG5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Nov 2021 07:06:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233265533"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233265533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="535486352"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2021 04:03:56 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 06/24] crypto: qat - change PFVF ACK behaviour
Date:   Mon, 15 Nov 2021 12:03:18 +0000
Message-Id: <20211115120336.22292-7-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
References: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Change the PFVF receipt flow on the VF side to read, ack and handle the
message instead of read, handle and ack.
This is done for (1) consistency with the PF side, see the function
adf_recv_and_handle_vf2pf_msg() in adf_pf2vf_msg.c, and (2) performance
reasons, to avoid keeping the CSR busy while parsing the message.

In addition, do not ACK PFVF legacy messages, as this driver is not
capable of handling PFVF legacy messages.
If a PFVF message with MSGORIGIN not set is received, do nothing.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
---
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 8 ++++----
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index 796301e9fe5b..4922ee2a2a08 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -195,14 +195,14 @@ bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr)
 		return true;
 	}
 
-	/* To ACK, clear the VF2PFINT bit */
-	msg &= ~ADF_VF2PF_INT;
-	ADF_CSR_WR(pmisc_addr, hw_data->get_pf2vf_offset(vf_nr), msg);
-
 	if (!(msg & ADF_VF2PF_MSGORIGIN_SYSTEM))
 		/* Ignore legacy non-system (non-kernel) VF2PF messages */
 		goto err;
 
+	/* To ACK, clear the VF2PFINT bit */
+	msg &= ~ADF_VF2PF_INT;
+	ADF_CSR_WR(pmisc_addr, hw_data->get_pf2vf_offset(vf_nr), msg);
+
 	switch ((msg & ADF_VF2PF_MSGTYPE_MASK) >> ADF_VF2PF_MSGTYPE_SHIFT) {
 	case ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ:
 		{
diff --git a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
index 064477fcb5fb..a6eaf93d5462 100644
--- a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
@@ -69,6 +69,10 @@ bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev)
 		/* Ignore legacy non-system (non-kernel) PF2VF messages */
 		goto err;
 
+	/* To ack, clear the PF2VFINT bit */
+	msg &= ~ADF_PF2VF_INT;
+	ADF_CSR_WR(pmisc_bar_addr, offset, msg);
+
 	switch ((msg & ADF_PF2VF_MSGTYPE_MASK) >> ADF_PF2VF_MSGTYPE_SHIFT) {
 	case ADF_PF2VF_MSGTYPE_RESTARTING:
 		dev_dbg(&GET_DEV(accel_dev),
@@ -93,9 +97,6 @@ bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev)
 		goto err;
 	}
 
-	/* To ack, clear the PF2VFINT bit */
-	msg &= ~ADF_PF2VF_INT;
-	ADF_CSR_WR(pmisc_bar_addr, offset, msg);
 	return ret;
 
 err:
-- 
2.33.1

