Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A2476CF8
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Dec 2021 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhLPJL1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Dec 2021 04:11:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:9675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhLPJLY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639645884; x=1671181884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPcFhnGpGv4coA6PjVyx9bd8vAp9Mj8XyaqhdemWpWU=;
  b=Vq+V34RE09Fvf2T0HOQXYea+lwyNz0fzSDfbEtk8QUSn3u3HFydeG+cI
   grvxw2u8LP1DCdYyAu4GdlVtBB0RjUfmWgcxNSheWCbfZgW0WiH1YL50g
   R4mBOeUDv5XdoBLGf0Q46sWPRodoplGa3tbqo8FxWWb8ptcxTNNgdT5qn
   JC6clZk398swmajQLNZh52+N6KZLwJ2+wO3HXg2nwmHogFxqsxdTnGb4p
   h/bYY8Ztxds8hwtWI953VewttjmMWLJ95xzqmDVt3ayf9kNKlzHIGu0hy
   9ogy0KLVZqmqTHqJc8iBSVOG9GefvAWny1dqz5oQBdP3sbxJteX9xHorc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219458386"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219458386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="465968451"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 01:11:22 -0800
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, marco.chiappero@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 07/24] crypto: qat - make PFVF message construction direction agnostic
Date:   Thu, 16 Dec 2021 09:13:17 +0000
Message-Id: <20211216091334.402420-8-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216091334.402420-1-marco.chiappero@intel.com>
References: <20211216091334.402420-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently PFVF messages are created upfront in the CSR format, that is
PF2VF messages starting from bit 0 and VF2PF from bit 16, and passed
along unmodified to the PFVF send function.

Refactor the code to allow the VF2PF messages to be built starting from
bit 0, as for the PF2VF messages. Shift the VF to PF messages just
before sending them, and refactor the send logic to handle messages
properly depending on the direction.

As a result all the messages are composed the same way regardless of
the direction.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c | 129 +++++++++++++-----
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h  |  26 ++--
 .../crypto/qat/qat_common/adf_pfvf_pf_msg.c   |   4 +-
 .../crypto/qat/qat_common/adf_pfvf_pf_proto.c |  10 +-
 .../crypto/qat/qat_common/adf_pfvf_vf_msg.c   |  20 +--
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.c |   2 +-
 6 files changed, 120 insertions(+), 71 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
index 5ac69ece34a8..2e0b9ac27393 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -17,6 +17,14 @@
 #define ADF_GEN2_PF_PF2VF_OFFSET(i)	(0x3A000 + 0x280 + ((i) * 0x04))
 #define ADF_GEN2_VF_PF2VF_OFFSET	0x200
 
+#define ADF_GEN2_CSR_IN_USE		0x6AC2
+#define ADF_GEN2_CSR_IN_USE_MASK	0xFFFE
+
+enum gen2_csr_pos {
+	ADF_GEN2_CSR_PF2VF_OFFSET	=  0,
+	ADF_GEN2_CSR_VF2PF_OFFSET	= 16,
+};
+
 #define ADF_PFVF_MSG_ACK_DELAY		2
 #define ADF_PFVF_MSG_ACK_MAX_RETRY	100
 
@@ -72,38 +80,81 @@ static void adf_gen2_disable_vf2pf_interrupts(void __iomem *pmisc_addr,
 	}
 }
 
+static u32 gen2_csr_get_int_bit(enum gen2_csr_pos offset)
+{
+	return ADF_PFVF_INT << offset;
+}
+
+static u32 gen2_csr_msg_to_position(u32 csr_msg, enum gen2_csr_pos offset)
+{
+	return (csr_msg & 0xFFFF) << offset;
+}
+
+static u32 gen2_csr_msg_from_position(u32 csr_val, enum gen2_csr_pos offset)
+{
+	return (csr_val >> offset) & 0xFFFF;
+}
+
+static bool gen2_csr_is_in_use(u32 msg, enum gen2_csr_pos offset)
+{
+	return ((msg >> offset) & ADF_GEN2_CSR_IN_USE_MASK) == ADF_GEN2_CSR_IN_USE;
+}
+
+static void gen2_csr_clear_in_use(u32 *msg, enum gen2_csr_pos offset)
+{
+	*msg &= ~(ADF_GEN2_CSR_IN_USE_MASK << offset);
+}
+
+static void gen2_csr_set_in_use(u32 *msg, enum gen2_csr_pos offset)
+{
+	*msg |= (ADF_GEN2_CSR_IN_USE << offset);
+}
+
+static bool is_legacy_user_pfvf_message(u32 msg)
+{
+	return !(msg & ADF_PFVF_MSGORIGIN_SYSTEM);
+}
+
 static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 			      u8 vf_nr)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	unsigned int retries = ADF_PFVF_MSG_MAX_RETRIES;
-	u32 remote_in_use_mask, remote_in_use_pattern;
-	u32 local_in_use_mask, local_in_use_pattern;
-	u32 val, pfvf_offset, count = 0;
+	enum gen2_csr_pos remote_offset;
+	enum gen2_csr_pos local_offset;
 	struct mutex *lock;	/* lock preventing concurrent acces of CSR */
+	u32 pfvf_offset;
+	u32 count = 0;
 	u32 int_bit;
+	u32 csr_val;
 	int ret;
 
+	/* Gen2 messages, both PF->VF and VF->PF, are all 16 bits long. This
+	 * allows us to build and read messages as if they where all 0 based.
+	 * However, send and receive are in a single shared 32 bits register,
+	 * so we need to shift and/or mask the message half before decoding
+	 * it and after encoding it. Which one to shift depends on the
+	 * direction.
+	 */
 	if (accel_dev->is_vf) {
 		pfvf_offset = GET_PFVF_OPS(accel_dev)->get_vf2pf_offset(0);
 		lock = &accel_dev->vf.vf2pf_lock;
-		local_in_use_mask = ADF_VF2PF_IN_USE_BY_VF_MASK;
-		local_in_use_pattern = ADF_VF2PF_IN_USE_BY_VF;
-		remote_in_use_mask = ADF_PF2VF_IN_USE_BY_PF_MASK;
-		remote_in_use_pattern = ADF_PF2VF_IN_USE_BY_PF;
-		int_bit = ADF_VF2PF_INT;
+		local_offset = ADF_GEN2_CSR_VF2PF_OFFSET;
+		remote_offset = ADF_GEN2_CSR_PF2VF_OFFSET;
 	} else {
 		pfvf_offset = GET_PFVF_OPS(accel_dev)->get_pf2vf_offset(vf_nr);
 		lock = &accel_dev->pf.vf_info[vf_nr].pf2vf_lock;
-		local_in_use_mask = ADF_PF2VF_IN_USE_BY_PF_MASK;
-		local_in_use_pattern = ADF_PF2VF_IN_USE_BY_PF;
-		remote_in_use_mask = ADF_VF2PF_IN_USE_BY_VF_MASK;
-		remote_in_use_pattern = ADF_VF2PF_IN_USE_BY_VF;
-		int_bit = ADF_PF2VF_INT;
+		local_offset = ADF_GEN2_CSR_PF2VF_OFFSET;
+		remote_offset = ADF_GEN2_CSR_VF2PF_OFFSET;
 	}
 
-	msg &= ~local_in_use_mask;
-	msg |= local_in_use_pattern;
+	int_bit = gen2_csr_get_int_bit(local_offset);
+
+	/* Pre-calculate message, shifting it in place and setting
+	 * the in use pattern
+	 */
+	msg = gen2_csr_msg_to_position(msg, local_offset);
+	gen2_csr_set_in_use(&msg, remote_offset);
 
 	mutex_lock(lock);
 
@@ -111,8 +162,8 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	ret = 0;
 
 	/* Check if the PFVF CSR is in use by remote function */
-	val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
-	if ((val & remote_in_use_mask) == remote_in_use_pattern) {
+	csr_val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
+	if (gen2_csr_is_in_use(csr_val, local_offset)) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"PFVF CSR in use by remote function\n");
 		goto retry;
@@ -124,23 +175,25 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	/* Wait for confirmation from remote func it received the message */
 	do {
 		msleep(ADF_PFVF_MSG_ACK_DELAY);
-		val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
-	} while ((val & int_bit) && (count++ < ADF_PFVF_MSG_ACK_MAX_RETRY));
+		csr_val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
+	} while ((csr_val & int_bit) && (count++ < ADF_PFVF_MSG_ACK_MAX_RETRY));
 
-	if (val & int_bit) {
+	if (csr_val & int_bit) {
 		dev_dbg(&GET_DEV(accel_dev), "ACK not received from remote\n");
-		val &= ~int_bit;
+		csr_val &= ~int_bit;
 		ret = -EIO;
 	}
 
-	if (val != msg) {
+	if (csr_val != msg) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"Collision - PFVF CSR overwritten by remote function\n");
 		goto retry;
 	}
 
 	/* Finished with the PFVF CSR; relinquish it and leave msg in CSR */
-	ADF_CSR_WR(pmisc_addr, pfvf_offset, val & ~local_in_use_mask);
+	gen2_csr_clear_in_use(&csr_val, remote_offset);
+	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
+
 out:
 	mutex_unlock(lock);
 	return ret;
@@ -158,39 +211,43 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 static u32 adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev, u8 vf_nr)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	enum gen2_csr_pos local_offset;
 	u32 pfvf_offset;
-	u32 msg_origin;
 	u32 int_bit;
+	u32 csr_val;
 	u32 msg;
 
 	if (accel_dev->is_vf) {
 		pfvf_offset = GET_PFVF_OPS(accel_dev)->get_pf2vf_offset(0);
-		int_bit = ADF_PF2VF_INT;
-		msg_origin = ADF_PF2VF_MSGORIGIN_SYSTEM;
+		local_offset = ADF_GEN2_CSR_PF2VF_OFFSET;
 	} else {
 		pfvf_offset = GET_PFVF_OPS(accel_dev)->get_vf2pf_offset(vf_nr);
-		int_bit = ADF_VF2PF_INT;
-		msg_origin = ADF_VF2PF_MSGORIGIN_SYSTEM;
+		local_offset = ADF_GEN2_CSR_VF2PF_OFFSET;
 	}
 
+	int_bit = gen2_csr_get_int_bit(local_offset);
+
 	/* Read message */
-	msg = ADF_CSR_RD(pmisc_addr, pfvf_offset);
-	if (!(msg & int_bit)) {
+	csr_val = ADF_CSR_RD(pmisc_addr, pfvf_offset);
+	if (!(csr_val & int_bit)) {
 		dev_info(&GET_DEV(accel_dev),
-			 "Spurious PFVF interrupt, msg 0x%.8x. Ignored\n", msg);
+			 "Spurious PFVF interrupt, msg 0x%.8x. Ignored\n", csr_val);
 		return 0;
 	}
 
-	/* Ignore legacy non-system (non-kernel) VF2PF messages */
-	if (!(msg & msg_origin)) {
+	/* Extract the message from the CSR */
+	msg = gen2_csr_msg_from_position(csr_val, local_offset);
+
+	/* Ignore legacy non-system (non-kernel) messages */
+	if (unlikely(is_legacy_user_pfvf_message(msg))) {
 		dev_dbg(&GET_DEV(accel_dev),
-			"Ignored non-system message (0x%.8x);\n", msg);
+			"Ignored non-system message (0x%.8x);\n", csr_val);
 		return 0;
 	}
 
 	/* To ACK, clear the INT bit */
-	msg &= ~int_bit;
-	ADF_CSR_WR(pmisc_addr, pfvf_offset, msg);
+	csr_val &= ~int_bit;
+	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
 
 	return msg;
 }
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
index 8b476072df28..3ba88bcd0726 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
@@ -53,27 +53,19 @@
  * adf_gen2_pfvf_send() in adf_pf2vf_msg.c).
  */
 
-/* PF->VF messages */
-#define ADF_PF2VF_INT				BIT(0)
-#define ADF_PF2VF_MSGORIGIN_SYSTEM		BIT(1)
-#define ADF_PF2VF_IN_USE_BY_PF			0x6AC20000
-#define ADF_PF2VF_IN_USE_BY_PF_MASK		0xFFFE0000
-#define ADF_PF2VF_MSGTYPE_MASK			0x0000003C
-#define ADF_PF2VF_MSGTYPE_SHIFT			2
+/* PFVF message common bits */
+#define ADF_PFVF_INT				BIT(0)
+#define ADF_PFVF_MSGORIGIN_SYSTEM		BIT(1)
+#define ADF_PFVF_MSGTYPE_SHIFT			2
+#define ADF_PFVF_MSGTYPE_MASK			0x0F
 
+/* PF->VF messages */
 enum pf2vf_msgtype {
 	ADF_PF2VF_MSGTYPE_RESTARTING		= 0x01,
 	ADF_PF2VF_MSGTYPE_VERSION_RESP		= 0x02,
 };
 
 /* VF->PF messages */
-#define ADF_VF2PF_INT				BIT(16)
-#define ADF_VF2PF_MSGORIGIN_SYSTEM		BIT(17)
-#define ADF_VF2PF_IN_USE_BY_VF			0x00006AC2
-#define ADF_VF2PF_IN_USE_BY_VF_MASK		0x0000FFFE
-#define ADF_VF2PF_MSGTYPE_MASK			0x003C0000
-#define ADF_VF2PF_MSGTYPE_SHIFT			18
-
 enum vf2pf_msgtype {
 	ADF_VF2PF_MSGTYPE_INIT			= 0x03,
 	ADF_VF2PF_MSGTYPE_SHUTDOWN		= 0x04,
@@ -90,10 +82,10 @@ enum pfvf_compatibility_version {
 /* PF->VF Version Response */
 #define ADF_PF2VF_MINORVERSION_SHIFT		6
 #define ADF_PF2VF_MAJORVERSION_SHIFT		10
-#define ADF_PF2VF_VERSION_RESP_VERS_MASK	0x00003FC0
 #define ADF_PF2VF_VERSION_RESP_VERS_SHIFT	6
-#define ADF_PF2VF_VERSION_RESP_RESULT_MASK	0x0000C000
+#define ADF_PF2VF_VERSION_RESP_VERS_MASK	0xFF
 #define ADF_PF2VF_VERSION_RESP_RESULT_SHIFT	14
+#define ADF_PF2VF_VERSION_RESP_RESULT_MASK	0x03
 
 enum pf2vf_compat_response {
 	ADF_PF2VF_VF_COMPATIBLE			= 0x01,
@@ -102,6 +94,6 @@ enum pf2vf_compat_response {
 };
 
 /* VF->PF Compatible Version Request */
-#define ADF_VF2PF_COMPAT_VER_REQ_SHIFT		22
+#define ADF_VF2PF_COMPAT_VER_REQ_SHIFT		6
 
 #endif /* ADF_PFVF_MSG_H */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
index 647b82e6c4ba..4057d7d74d62 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
@@ -9,8 +9,8 @@
 void adf_pf2vf_notify_restarting(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_vf_info *vf;
-	u32 msg = (ADF_PF2VF_MSGORIGIN_SYSTEM |
-		(ADF_PF2VF_MSGTYPE_RESTARTING << ADF_PF2VF_MSGTYPE_SHIFT));
+	u32 msg = (ADF_PFVF_MSGORIGIN_SYSTEM |
+		(ADF_PF2VF_MSGTYPE_RESTARTING << ADF_PFVF_MSGTYPE_SHIFT));
 	int i, num_vfs = pci_num_vf(accel_to_pci_dev(accel_dev));
 
 	for (i = 0, vf = accel_dev->pf.vf_info; i < num_vfs; i++, vf++) {
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
index 4f20dd35fcd4..fb477eb89fef 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
@@ -42,7 +42,7 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
 	u32 resp = 0;
 
-	switch ((msg & ADF_VF2PF_MSGTYPE_MASK) >> ADF_VF2PF_MSGTYPE_SHIFT) {
+	switch ((msg >> ADF_PFVF_MSGTYPE_SHIFT) & ADF_PFVF_MSGTYPE_MASK) {
 	case ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ:
 		{
 		u8 vf_compat_ver = msg >> ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
@@ -57,9 +57,9 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		else
 			compat = ADF_PF2VF_VF_COMPAT_UNKNOWN;
 
-		resp =  ADF_PF2VF_MSGORIGIN_SYSTEM;
+		resp =  ADF_PFVF_MSGORIGIN_SYSTEM;
 		resp |= ADF_PF2VF_MSGTYPE_VERSION_RESP <<
-			ADF_PF2VF_MSGTYPE_SHIFT;
+			ADF_PFVF_MSGTYPE_SHIFT;
 		resp |= ADF_PFVF_COMPAT_THIS_VERSION <<
 			ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
 		resp |= compat << ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
@@ -76,9 +76,9 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		/* PF always newer than legacy VF */
 		compat = ADF_PF2VF_VF_COMPATIBLE;
 
-		resp = ADF_PF2VF_MSGORIGIN_SYSTEM;
+		resp = ADF_PFVF_MSGORIGIN_SYSTEM;
 		resp |= ADF_PF2VF_MSGTYPE_VERSION_RESP <<
-			ADF_PF2VF_MSGTYPE_SHIFT;
+			ADF_PFVF_MSGTYPE_SHIFT;
 		/* Set legacy major and minor version num */
 		resp |= 1 << ADF_PF2VF_MAJORVERSION_SHIFT |
 			1 << ADF_PF2VF_MINORVERSION_SHIFT;
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
index 763581839902..c9e929651a7d 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
@@ -16,8 +16,8 @@
  */
 int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev)
 {
-	u32 msg = (ADF_VF2PF_MSGORIGIN_SYSTEM |
-		(ADF_VF2PF_MSGTYPE_INIT << ADF_VF2PF_MSGTYPE_SHIFT));
+	u32 msg = (ADF_PFVF_MSGORIGIN_SYSTEM |
+		(ADF_VF2PF_MSGTYPE_INIT << ADF_PFVF_MSGTYPE_SHIFT));
 
 	if (adf_send_vf2pf_msg(accel_dev, msg)) {
 		dev_err(&GET_DEV(accel_dev),
@@ -39,8 +39,8 @@ EXPORT_SYMBOL_GPL(adf_vf2pf_notify_init);
  */
 void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 {
-	u32 msg = (ADF_VF2PF_MSGORIGIN_SYSTEM |
-	    (ADF_VF2PF_MSGTYPE_SHUTDOWN << ADF_VF2PF_MSGTYPE_SHIFT));
+	u32 msg = (ADF_PFVF_MSGORIGIN_SYSTEM |
+	    (ADF_VF2PF_MSGTYPE_SHUTDOWN << ADF_PFVF_MSGTYPE_SHIFT));
 
 	if (test_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status))
 		if (adf_send_vf2pf_msg(accel_dev, msg))
@@ -57,8 +57,8 @@ int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 	u32 resp;
 	int ret;
 
-	msg = ADF_VF2PF_MSGORIGIN_SYSTEM;
-	msg |= ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ << ADF_VF2PF_MSGTYPE_SHIFT;
+	msg = ADF_PFVF_MSGORIGIN_SYSTEM;
+	msg |= ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ << ADF_PFVF_MSGTYPE_SHIFT;
 	msg |= ADF_PFVF_COMPAT_THIS_VERSION << ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
 	BUILD_BUG_ON(ADF_PFVF_COMPAT_THIS_VERSION > 255);
 
@@ -69,10 +69,10 @@ int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 		return ret;
 	}
 
-	pf_version = (resp & ADF_PF2VF_VERSION_RESP_VERS_MASK)
-		     >> ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
-	compat = (resp & ADF_PF2VF_VERSION_RESP_RESULT_MASK)
-		 >> ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
+	pf_version = (resp >> ADF_PF2VF_VERSION_RESP_VERS_SHIFT)
+		     & ADF_PF2VF_VERSION_RESP_VERS_MASK;
+	compat = (resp >> ADF_PF2VF_VERSION_RESP_RESULT_SHIFT)
+		 & ADF_PF2VF_VERSION_RESP_RESULT_MASK;
 
 	/* Response from PF received, check compatibility */
 	switch (compat) {
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
index 9c7489ed122c..f8d1c7d0ec4e 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
@@ -88,7 +88,7 @@ int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp)
 
 static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev, u32 msg)
 {
-	switch ((msg & ADF_PF2VF_MSGTYPE_MASK) >> ADF_PF2VF_MSGTYPE_SHIFT) {
+	switch ((msg >> ADF_PFVF_MSGTYPE_SHIFT) & ADF_PFVF_MSGTYPE_MASK) {
 	case ADF_PF2VF_MSGTYPE_RESTARTING:
 		dev_dbg(&GET_DEV(accel_dev), "Restarting message received from PF\n");
 
-- 
2.31.1

