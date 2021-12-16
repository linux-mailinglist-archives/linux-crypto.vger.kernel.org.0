Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70323476D05
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Dec 2021 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhLPJL4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Dec 2021 04:11:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:9697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhLPJLv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639645911; x=1671181911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouyMvUDAN3KXYSLCbWLt66R/lZCAu8o3pCcKUKN0fOU=;
  b=XnH376esNVxLlndh3VThK4T/mQUJ7/nZ09C3z4DW3qcUydLyKUJ9aFVt
   BzxuD1mSdiXamb+V6LDOEk8pf6eF6UJzJwLb+C38uiV6VFMfbO4IfyXV3
   jTeMf6h6/tGxwTdRwdTpkf9lkSgXQTGbk+IeDuTlWyD0V85c3NAgbGYav
   xtI9AMkGiBvhfu75df884Iuc1V3P63atNDeSfpvHt3eYKUn8D1CD/1ABJ
   I7QRYOZjU5iWB5Jn01ogRSU2UssTSbe/XsPk/uZfm8nVnQ9CeVwuq9d6m
   QiiQJt36EkTLW9fN2KalzhA7OiIn8AmoBGpfOS1xGS5Zu/oV/jtc0iEgh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219458474"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219458474"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="465968602"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 01:11:44 -0800
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, marco.chiappero@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 18/24] crypto: qat - support fast ACKs in the PFVF protocol
Date:   Thu, 16 Dec 2021 09:13:28 +0000
Message-Id: <20211216091334.402420-19-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216091334.402420-1-marco.chiappero@intel.com>
References: <20211216091334.402420-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The original design and current implementation of the PFVF protocol
expects the sender to both acquire and relinquish the ownership of the
shared CSR by setting and clearing the "in use" pattern on the remote
half of the register when sending a message. This happens regardless of
the acknowledgment of the reception, to guarantee changes, including
collisions, are surely detected.

However, in the case of a request that requires a response, collisions
can also be detected by the lack of a reply. This can be exploited to
speed up and simplify the above behaviour, letting the receiver both
acknowledge the message and release the CSR in a single transaction:

1) the sender can return as soon as the message has been acknowledged
2) the receiver doesn't have to wait long before acquiring ownership
of the CSR for the response message, greatly improving the overall
throughput.

Howerver, this improvement cannot be leveraged for fire-and-forget
notifications, as it would be impossible for the sender to clearly
distinguish between a collision and an ack immediately followed by a new
message.

This patch implements this optimization in a new version of the protocol
(v3), which applies the fast-ack logic only whenever possible and
guarantees backward compatibility with older versions. For requests, a
new retry loop guarantees a correct behaviour.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 .../crypto/qat/qat_common/adf_accel_devices.h |  2 +-
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c | 68 ++++++++++++++++---
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h  |  4 +-
 .../crypto/qat/qat_common/adf_pfvf_pf_proto.c |  3 +-
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.c | 44 ++++++------
 5 files changed, 91 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 55e8948a8c5e..1b9d4ed03dd0 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -158,7 +158,7 @@ struct adf_pfvf_ops {
 	int (*send_msg)(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 			u32 pfvf_offset, struct mutex *csr_lock);
 	struct pfvf_message (*recv_msg)(struct adf_accel_dev *accel_dev,
-					u32 pfvf_offset);
+					u32 pfvf_offset, u8 compat_ver);
 };
 
 struct adf_hw_device_data {
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
index feab01ec4bbb..1a9072aac2ca 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -124,11 +124,34 @@ static bool is_legacy_user_pfvf_message(u32 msg)
 	return !(msg & ADF_PFVF_MSGORIGIN_SYSTEM);
 }
 
+static bool is_pf2vf_notification(u8 msg_type)
+{
+	switch (msg_type) {
+	case ADF_PF2VF_MSGTYPE_RESTARTING:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool is_vf2pf_notification(u8 msg_type)
+{
+	switch (msg_type) {
+	case ADF_VF2PF_MSGTYPE_INIT:
+	case ADF_VF2PF_MSGTYPE_SHUTDOWN:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct pfvf_gen2_params {
 	u32 pfvf_offset;
 	struct mutex *csr_lock; /* lock preventing concurrent access of CSR */
 	enum gen2_csr_pos local_offset;
 	enum gen2_csr_pos remote_offset;
+	bool (*is_notification_message)(u8 msg_type);
+	u8 compat_ver;
 };
 
 static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev,
@@ -190,15 +213,27 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev,
 		csr_val &= ~int_bit;
 	}
 
-	if (csr_val != csr_msg) {
-		dev_dbg(&GET_DEV(accel_dev),
-			"Collision - PFVF CSR overwritten by remote function\n");
+	/* For fire-and-forget notifications, the receiver does not clear
+	 * the in-use pattern. This is used to detect collisions.
+	 */
+	if (params->is_notification_message(msg.type) && csr_val != csr_msg) {
+		/* Collision must have overwritten the message */
+		dev_err(&GET_DEV(accel_dev),
+			"Collision on notification - PFVF CSR overwritten by remote function\n");
 		goto retry;
 	}
 
-	/* Finished with the PFVF CSR; relinquish it and leave msg in CSR */
-	gen2_csr_clear_in_use(&csr_val, remote_offset);
-	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
+	/* If the far side did not clear the in-use pattern it is either
+	 * 1) Notification - message left intact to detect collision
+	 * 2) Older protocol (compatibility version < 3) on the far side
+	 *    where the sender is responsible for clearing the in-use
+	 *    pattern after the received has acknowledged receipt.
+	 * In either case, clear the in-use pattern now.
+	 */
+	if (gen2_csr_is_in_use(csr_val, remote_offset)) {
+		gen2_csr_clear_in_use(&csr_val, remote_offset);
+		ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
+	}
 
 out:
 	mutex_unlock(lock);
@@ -218,6 +253,7 @@ static struct pfvf_message adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
 					      struct pfvf_gen2_params *params)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	enum gen2_csr_pos remote_offset = params->remote_offset;
 	enum gen2_csr_pos local_offset = params->local_offset;
 	u32 pfvf_offset = params->pfvf_offset;
 	struct pfvf_message msg = { 0 };
@@ -242,12 +278,22 @@ static struct pfvf_message adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
 	if (unlikely(is_legacy_user_pfvf_message(csr_msg))) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"Ignored non-system message (0x%.8x);\n", csr_val);
+		/* Because this must be a legacy message, the far side
+		 * must clear the in-use pattern, so don't do it.
+		 */
 		return msg;
 	}
 
 	/* Return the pfvf_message format */
 	msg = adf_pfvf_message_of(accel_dev, csr_msg, &csr_gen2_fmt);
 
+	/* The in-use pattern is not cleared for notifications (so that
+	 * it can be used for collision detection) or older implementations
+	 */
+	if (params->compat_ver >= ADF_PFVF_COMPAT_FAST_ACK &&
+	    !params->is_notification_message(msg.type))
+		gen2_csr_clear_in_use(&csr_val, remote_offset);
+
 	/* To ACK, clear the INT bit */
 	csr_val &= ~int_bit;
 	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
@@ -263,6 +309,7 @@ static int adf_gen2_pf2vf_send(struct adf_accel_dev *accel_dev, struct pfvf_mess
 		.pfvf_offset = pfvf_offset,
 		.local_offset = ADF_GEN2_CSR_PF2VF_OFFSET,
 		.remote_offset = ADF_GEN2_CSR_VF2PF_OFFSET,
+		.is_notification_message = is_pf2vf_notification,
 	};
 
 	return adf_gen2_pfvf_send(accel_dev, msg, &params);
@@ -276,30 +323,35 @@ static int adf_gen2_vf2pf_send(struct adf_accel_dev *accel_dev, struct pfvf_mess
 		.pfvf_offset = pfvf_offset,
 		.local_offset = ADF_GEN2_CSR_VF2PF_OFFSET,
 		.remote_offset = ADF_GEN2_CSR_PF2VF_OFFSET,
+		.is_notification_message = is_vf2pf_notification,
 	};
 
 	return adf_gen2_pfvf_send(accel_dev, msg, &params);
 }
 
 static struct pfvf_message adf_gen2_pf2vf_recv(struct adf_accel_dev *accel_dev,
-					       u32 pfvf_offset)
+					       u32 pfvf_offset, u8 compat_ver)
 {
 	struct pfvf_gen2_params params = {
 		.pfvf_offset = pfvf_offset,
 		.local_offset = ADF_GEN2_CSR_PF2VF_OFFSET,
 		.remote_offset = ADF_GEN2_CSR_VF2PF_OFFSET,
+		.is_notification_message = is_pf2vf_notification,
+		.compat_ver = compat_ver,
 	};
 
 	return adf_gen2_pfvf_recv(accel_dev, &params);
 }
 
 static struct pfvf_message adf_gen2_vf2pf_recv(struct adf_accel_dev *accel_dev,
-					       u32 pfvf_offset)
+					       u32 pfvf_offset, u8 compat_ver)
 {
 	struct pfvf_gen2_params params = {
 		.pfvf_offset = pfvf_offset,
 		.local_offset = ADF_GEN2_CSR_VF2PF_OFFSET,
 		.remote_offset = ADF_GEN2_CSR_PF2VF_OFFSET,
+		.is_notification_message = is_vf2pf_notification,
+		.compat_ver = compat_ver,
 	};
 
 	return adf_gen2_pfvf_recv(accel_dev, &params);
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
index f418dd26a742..df052194ece7 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
@@ -89,8 +89,10 @@ enum vf2pf_msgtype {
 enum pfvf_compatibility_version {
 	/* Support for extended capabilities */
 	ADF_PFVF_COMPAT_CAPABILITIES		= 0x02,
+	/* In-use pattern cleared by receiver */
+	ADF_PFVF_COMPAT_FAST_ACK		= 0x03,
 	/* Reference to the latest version */
-	ADF_PFVF_COMPAT_THIS_VERSION		= 0x02,
+	ADF_PFVF_COMPAT_THIS_VERSION		= 0x03,
 };
 
 /* PF->VF Version Response */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
index 1256d68c3efd..cd728d5ac9ab 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
@@ -48,10 +48,11 @@ int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, struct pfvf_me
  */
 static struct pfvf_message adf_recv_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr)
 {
+	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_vf2pf_offset(vf_nr);
 
-	return pfvf_ops->recv_msg(accel_dev, pfvf_offset);
+	return pfvf_ops->recv_msg(accel_dev, pfvf_offset, vf_info->vf_compat_ver);
 }
 
 static adf_pf2vf_blkmsg_provider get_blkmsg_response_provider(u8 type)
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
index a85bd6dcb62a..b9a1cf5d58a9 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
@@ -15,6 +15,8 @@
 #define ADF_PFVF_MSG_ACK_DELAY			2
 #define ADF_PFVF_MSG_ACK_MAX_RETRY		100
 
+/* How often to retry if there is no response */
+#define ADF_PFVF_MSG_RESP_RETRIES	5
 #define ADF_PFVF_MSG_RESP_TIMEOUT	(ADF_PFVF_MSG_ACK_DELAY * \
 					 ADF_PFVF_MSG_ACK_MAX_RETRY + \
 					 ADF_PFVF_MSG_COLLISION_DETECT_DELAY)
@@ -50,7 +52,7 @@ static struct pfvf_message adf_recv_pf2vf_msg(struct adf_accel_dev *accel_dev)
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_pf2vf_offset(0);
 
-	return pfvf_ops->recv_msg(accel_dev, pfvf_offset);
+	return pfvf_ops->recv_msg(accel_dev, pfvf_offset, accel_dev->vf.pf_compat_ver);
 }
 
 /**
@@ -68,33 +70,37 @@ int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 		       struct pfvf_message *resp)
 {
 	unsigned long timeout = msecs_to_jiffies(ADF_PFVF_MSG_RESP_TIMEOUT);
+	unsigned int retries = ADF_PFVF_MSG_RESP_RETRIES;
 	int ret;
 
 	reinit_completion(&accel_dev->vf.msg_received);
 
 	/* Send request from VF to PF */
-	ret = adf_send_vf2pf_msg(accel_dev, msg);
-	if (ret) {
-		dev_err(&GET_DEV(accel_dev),
-			"Failed to send request msg to PF\n");
-		return ret;
-	}
+	do {
+		ret = adf_send_vf2pf_msg(accel_dev, msg);
+		if (ret) {
+			dev_err(&GET_DEV(accel_dev),
+				"Failed to send request msg to PF\n");
+			return ret;
+		}
 
-	/* Wait for response */
-	if (!wait_for_completion_timeout(&accel_dev->vf.msg_received,
-					 timeout)) {
-		dev_err(&GET_DEV(accel_dev),
-			"PFVF request/response message timeout expired\n");
-		return -EIO;
-	}
+		/* Wait for response, if it times out retry */
+		ret = wait_for_completion_timeout(&accel_dev->vf.msg_received,
+						  timeout);
+		if (ret) {
+			if (likely(resp))
+				*resp = accel_dev->vf.response;
 
-	if (likely(resp))
-		*resp = accel_dev->vf.response;
+			/* Once copied, set to an invalid value */
+			accel_dev->vf.response.type = 0;
 
-	/* Once copied, set to an invalid value */
-	accel_dev->vf.response.type = 0;
+			return 0;
+		}
 
-	return 0;
+		dev_err(&GET_DEV(accel_dev), "PFVF response message timeout\n");
+	} while (--retries);
+
+	return -EIO;
 }
 
 static int adf_vf2pf_blkmsg_data_req(struct adf_accel_dev *accel_dev, bool crc,
-- 
2.31.1

