Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D610C476CFD
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Dec 2021 10:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhLPJLe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Dec 2021 04:11:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:9682 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232937AbhLPJLa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639645890; x=1671181890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGNi4Ns9u2KGOUTrOx1/jF1cII2To4OuoVVgWfnFSZo=;
  b=oDBcLr8xjUC74XMuhcpHHMG7E7/D3BRZ2kE0eRPprJ5hgc307nXIyOdY
   LWmhM9JRoBIZBeNbUyJGHbyqnLjGLZqC7KoV3PR5kDHMSons8og0PJ/aq
   /T92mr/VIlEHpXzAI3nYqbCV9Fx4jh/4f3RAwt/O08tcpFmLHkXVdlUM0
   qOcgxwqRqMyAggEjljbdp14Hg/F0dU1h5cbh9bHz+8qEqJeZtjbRNFYZw
   IkY+eJcI4TAvcpLBHudKzmcjhEZgis/smbIIdW88KiltkQ8/q1bmuzibm
   3+m/jo9aehk2dLsx5z5neDb6Y21cWxsqhbAHZkLZ9pSjXQFcNw2RWQT5r
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219458423"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219458423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="465968481"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 01:11:28 -0800
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, marco.chiappero@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 10/24] crypto: qat - abstract PFVF messages with struct pfvf_message
Date:   Thu, 16 Dec 2021 09:13:20 +0000
Message-Id: <20211216091334.402420-11-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216091334.402420-1-marco.chiappero@intel.com>
References: <20211216091334.402420-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This implementation of the PFVF protocol was designed around the GEN2
devices and its CSR format. In order to support future generations,
which come with differently sized fields, change the definition of the PFVF
message and make it abstract by means of a new pfvf_message struct. Also,
introduce some utilities to translate to and from the new message format
and the device specific CSR format.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/qat_common/Makefile        |  2 +-
 .../crypto/qat/qat_common/adf_accel_devices.h |  8 ++-
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c | 60 +++++++++++++------
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h  | 19 +++---
 .../crypto/qat/qat_common/adf_pfvf_pf_msg.c   |  2 +-
 .../crypto/qat/qat_common/adf_pfvf_pf_proto.c | 51 +++++++---------
 .../crypto/qat/qat_common/adf_pfvf_pf_proto.h |  2 +-
 .../crypto/qat/qat_common/adf_pfvf_utils.c    | 50 ++++++++++++++++
 .../crypto/qat/qat_common/adf_pfvf_utils.h    | 24 ++++++++
 .../crypto/qat/qat_common/adf_pfvf_vf_msg.c   | 18 +++---
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.c | 26 ++++----
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.h |  5 +-
 12 files changed, 184 insertions(+), 83 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_utils.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_pfvf_utils.h

diff --git a/drivers/crypto/qat/qat_common/Makefile b/drivers/crypto/qat/qat_common/Makefile
index 1376504d16ff..80f6cb424753 100644
--- a/drivers/crypto/qat/qat_common/Makefile
+++ b/drivers/crypto/qat/qat_common/Makefile
@@ -19,7 +19,7 @@ intel_qat-objs := adf_cfg.o \
 	qat_hal.o
 
 intel_qat-$(CONFIG_DEBUG_FS) += adf_transport_debug.o
-intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o \
+intel_qat-$(CONFIG_PCI_IOV) += adf_sriov.o adf_vf_isr.o adf_pfvf_utils.o \
 			       adf_pfvf_pf_msg.o adf_pfvf_pf_proto.o \
 			       adf_pfvf_vf_msg.o adf_pfvf_vf_proto.o \
 			       adf_gen2_pfvf.o
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index d65d8dda8fda..d5ccefc04153 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/ratelimit.h>
 #include "adf_cfg_common.h"
+#include "adf_pfvf_msg.h"
 
 #define ADF_DH895XCC_DEVICE_NAME "dh895xcc"
 #define ADF_DH895XCCVF_DEVICE_NAME "dh895xccvf"
@@ -154,9 +155,10 @@ struct adf_pfvf_ops {
 	u32 (*get_vf2pf_sources)(void __iomem *pmisc_addr);
 	void (*enable_vf2pf_interrupts)(void __iomem *pmisc_addr, u32 vf_mask);
 	void (*disable_vf2pf_interrupts)(void __iomem *pmisc_addr, u32 vf_mask);
-	int (*send_msg)(struct adf_accel_dev *accel_dev, u32 msg,
+	int (*send_msg)(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 			u32 pfvf_offset, struct mutex *csr_lock);
-	u32 (*recv_msg)(struct adf_accel_dev *accel_dev, u32 pfvf_offset);
+	struct pfvf_message (*recv_msg)(struct adf_accel_dev *accel_dev,
+					u32 pfvf_offset);
 };
 
 struct adf_hw_device_data {
@@ -275,7 +277,7 @@ struct adf_accel_dev {
 			struct tasklet_struct pf2vf_bh_tasklet;
 			struct mutex vf2pf_lock; /* protect CSR access */
 			struct completion msg_received;
-			u32 response; /* temp field holding pf2vf response */
+			struct pfvf_message response; /* temp field holding pf2vf response */
 			u8 pf_version;
 		} vf;
 	};
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
index 97bef41ddc47..7a927bea4ac6 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -9,6 +9,7 @@
 #include "adf_pfvf_msg.h"
 #include "adf_pfvf_pf_proto.h"
 #include "adf_pfvf_vf_proto.h"
+#include "adf_pfvf_utils.h"
 
  /* VF2PF interrupts */
 #define ADF_GEN2_ERR_REG_VF2PF(vf_src)	(((vf_src) & 0x01FFFE00) >> 9)
@@ -25,6 +26,16 @@ enum gen2_csr_pos {
 	ADF_GEN2_CSR_VF2PF_OFFSET	= 16,
 };
 
+#define ADF_PFVF_GEN2_MSGTYPE_SHIFT	2
+#define ADF_PFVF_GEN2_MSGTYPE_MASK	0x0F
+#define ADF_PFVF_GEN2_MSGDATA_SHIFT	6
+#define ADF_PFVF_GEN2_MSGDATA_MASK	0x3FF
+
+static const struct pfvf_csr_format csr_gen2_fmt = {
+	{ ADF_PFVF_GEN2_MSGTYPE_SHIFT, ADF_PFVF_GEN2_MSGTYPE_MASK },
+	{ ADF_PFVF_GEN2_MSGDATA_SHIFT, ADF_PFVF_GEN2_MSGDATA_MASK },
+};
+
 #define ADF_PFVF_MSG_ACK_DELAY		2
 #define ADF_PFVF_MSG_ACK_MAX_RETRY	100
 
@@ -122,7 +133,8 @@ struct pfvf_gen2_params {
 	enum gen2_csr_pos remote_offset;
 };
 
-static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
+static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev,
+			      struct pfvf_message msg,
 			      struct pfvf_gen2_params *params)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
@@ -134,6 +146,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	u32 count = 0;
 	u32 int_bit;
 	u32 csr_val;
+	u32 csr_msg;
 	int ret;
 
 	/* Gen2 messages, both PF->VF and VF->PF, are all 16 bits long. This
@@ -146,12 +159,15 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 
 	int_bit = gen2_csr_get_int_bit(local_offset);
 
-	/* Pre-calculate message, shifting it in place and setting
-	 * the in use pattern
+	csr_msg = adf_pfvf_csr_msg_of(accel_dev, msg, &csr_gen2_fmt);
+	if (unlikely(!csr_msg))
+		return -EINVAL;
+
+	/* Prepare for CSR format, shifting the wire message in place and
+	 * setting the in use pattern
 	 */
-	msg |= ADF_PFVF_MSGORIGIN_SYSTEM;
-	msg = gen2_csr_msg_to_position(msg, local_offset);
-	gen2_csr_set_in_use(&msg, remote_offset);
+	csr_msg = gen2_csr_msg_to_position(csr_msg, local_offset);
+	gen2_csr_set_in_use(&csr_msg, remote_offset);
 
 	mutex_lock(lock);
 
@@ -167,7 +183,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	}
 
 	/* Attempt to get ownership of the PFVF CSR */
-	ADF_CSR_WR(pmisc_addr, pfvf_offset, msg | int_bit);
+	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_msg | int_bit);
 
 	/* Wait for confirmation from remote func it received the message */
 	do {
@@ -181,7 +197,7 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 		ret = -EIO;
 	}
 
-	if (csr_val != msg) {
+	if (csr_val != csr_msg) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"Collision - PFVF CSR overwritten by remote function\n");
 		goto retry;
@@ -205,15 +221,16 @@ static int adf_gen2_pfvf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	}
 }
 
-static u32 adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
-			      struct pfvf_gen2_params *params)
+static struct pfvf_message adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
+					      struct pfvf_gen2_params *params)
 {
 	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
 	enum gen2_csr_pos local_offset = params->local_offset;
 	u32 pfvf_offset = params->pfvf_offset;
+	struct pfvf_message msg = { 0 };
 	u32 int_bit;
 	u32 csr_val;
-	u32 msg;
+	u16 csr_msg;
 
 	int_bit = gen2_csr_get_int_bit(local_offset);
 
@@ -222,19 +239,22 @@ static u32 adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
 	if (!(csr_val & int_bit)) {
 		dev_info(&GET_DEV(accel_dev),
 			 "Spurious PFVF interrupt, msg 0x%.8x. Ignored\n", csr_val);
-		return 0;
+		return msg;
 	}
 
 	/* Extract the message from the CSR */
-	msg = gen2_csr_msg_from_position(csr_val, local_offset);
+	csr_msg = gen2_csr_msg_from_position(csr_val, local_offset);
 
 	/* Ignore legacy non-system (non-kernel) messages */
-	if (unlikely(is_legacy_user_pfvf_message(msg))) {
+	if (unlikely(is_legacy_user_pfvf_message(csr_msg))) {
 		dev_dbg(&GET_DEV(accel_dev),
 			"Ignored non-system message (0x%.8x);\n", csr_val);
-		return 0;
+		return msg;
 	}
 
+	/* Return the pfvf_message format */
+	msg = adf_pfvf_message_of(accel_dev, csr_msg, &csr_gen2_fmt);
+
 	/* To ACK, clear the INT bit */
 	csr_val &= ~int_bit;
 	ADF_CSR_WR(pmisc_addr, pfvf_offset, csr_val);
@@ -242,7 +262,7 @@ static u32 adf_gen2_pfvf_recv(struct adf_accel_dev *accel_dev,
 	return msg;
 }
 
-static int adf_gen2_pf2vf_send(struct adf_accel_dev *accel_dev, u32 msg,
+static int adf_gen2_pf2vf_send(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 			       u32 pfvf_offset, struct mutex *csr_lock)
 {
 	struct pfvf_gen2_params params = {
@@ -255,7 +275,7 @@ static int adf_gen2_pf2vf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	return adf_gen2_pfvf_send(accel_dev, msg, &params);
 }
 
-static int adf_gen2_vf2pf_send(struct adf_accel_dev *accel_dev, u32 msg,
+static int adf_gen2_vf2pf_send(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 			       u32 pfvf_offset, struct mutex *csr_lock)
 {
 	struct pfvf_gen2_params params = {
@@ -268,7 +288,8 @@ static int adf_gen2_vf2pf_send(struct adf_accel_dev *accel_dev, u32 msg,
 	return adf_gen2_pfvf_send(accel_dev, msg, &params);
 }
 
-static u32 adf_gen2_pf2vf_recv(struct adf_accel_dev *accel_dev, u32 pfvf_offset)
+static struct pfvf_message adf_gen2_pf2vf_recv(struct adf_accel_dev *accel_dev,
+					       u32 pfvf_offset)
 {
 	struct pfvf_gen2_params params = {
 		.pfvf_offset = pfvf_offset,
@@ -279,7 +300,8 @@ static u32 adf_gen2_pf2vf_recv(struct adf_accel_dev *accel_dev, u32 pfvf_offset)
 	return adf_gen2_pfvf_recv(accel_dev, &params);
 }
 
-static u32 adf_gen2_vf2pf_recv(struct adf_accel_dev *accel_dev, u32 pfvf_offset)
+static struct pfvf_message adf_gen2_vf2pf_recv(struct adf_accel_dev *accel_dev,
+					       u32 pfvf_offset)
 {
 	struct pfvf_gen2_params params = {
 		.pfvf_offset = pfvf_offset,
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
index 3ba88bcd0726..26eb27853e83 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
@@ -56,8 +56,14 @@
 /* PFVF message common bits */
 #define ADF_PFVF_INT				BIT(0)
 #define ADF_PFVF_MSGORIGIN_SYSTEM		BIT(1)
-#define ADF_PFVF_MSGTYPE_SHIFT			2
-#define ADF_PFVF_MSGTYPE_MASK			0x0F
+
+/* Different generations have different CSR layouts, use this struct
+ * to abstract these differences away
+ */
+struct pfvf_message {
+	u8 type;
+	u32 data;
+};
 
 /* PF->VF messages */
 enum pf2vf_msgtype {
@@ -80,11 +86,9 @@ enum pfvf_compatibility_version {
 };
 
 /* PF->VF Version Response */
-#define ADF_PF2VF_MINORVERSION_SHIFT		6
-#define ADF_PF2VF_MAJORVERSION_SHIFT		10
-#define ADF_PF2VF_VERSION_RESP_VERS_SHIFT	6
+#define ADF_PF2VF_VERSION_RESP_VERS_SHIFT	0
 #define ADF_PF2VF_VERSION_RESP_VERS_MASK	0xFF
-#define ADF_PF2VF_VERSION_RESP_RESULT_SHIFT	14
+#define ADF_PF2VF_VERSION_RESP_RESULT_SHIFT	8
 #define ADF_PF2VF_VERSION_RESP_RESULT_MASK	0x03
 
 enum pf2vf_compat_response {
@@ -93,7 +97,4 @@ enum pf2vf_compat_response {
 	ADF_PF2VF_VF_COMPAT_UNKNOWN		= 0x03,
 };
 
-/* VF->PF Compatible Version Request */
-#define ADF_VF2PF_COMPAT_VER_REQ_SHIFT		6
-
 #endif /* ADF_PFVF_MSG_H */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
index f6d05cd29a82..ad198b624098 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.c
@@ -9,7 +9,7 @@
 void adf_pf2vf_notify_restarting(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_vf_info *vf;
-	u32 msg = ADF_PF2VF_MSGTYPE_RESTARTING << ADF_PFVF_MSGTYPE_SHIFT;
+	struct pfvf_message msg = { .type = ADF_PF2VF_MSGTYPE_RESTARTING };
 	int i, num_vfs = pci_num_vf(accel_to_pci_dev(accel_dev));
 
 	for (i = 0, vf = accel_dev->pf.vf_info; i < num_vfs; i++, vf++) {
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
index 9f4baa9b14fc..bb4d7db68579 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
@@ -17,7 +17,7 @@
  *
  * Return: 0 on success, error code otherwise.
  */
-int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, u32 msg)
+int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, struct pfvf_message msg)
 {
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_pf2vf_offset(vf_nr);
@@ -35,7 +35,7 @@ int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, u32 msg)
  *
  * Return: a valid message on success, zero otherwise.
  */
-static u32 adf_recv_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr)
+static struct pfvf_message adf_recv_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr)
 {
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_vf2pf_offset(vf_nr);
@@ -43,16 +43,15 @@ static u32 adf_recv_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr)
 	return pfvf_ops->recv_msg(accel_dev, pfvf_offset);
 }
 
-static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
-				u32 msg, u32 *response)
+static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr,
+				struct pfvf_message msg, struct pfvf_message *resp)
 {
 	struct adf_accel_vf_info *vf_info = &accel_dev->pf.vf_info[vf_nr];
-	u32 resp = 0;
 
-	switch ((msg >> ADF_PFVF_MSGTYPE_SHIFT) & ADF_PFVF_MSGTYPE_MASK) {
+	switch (msg.type) {
 	case ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ:
 		{
-		u8 vf_compat_ver = msg >> ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
+		u8 vf_compat_ver = msg.data;
 		u8 compat;
 
 		dev_dbg(&GET_DEV(accel_dev),
@@ -64,11 +63,10 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		else
 			compat = ADF_PF2VF_VF_COMPAT_UNKNOWN;
 
-		resp |= ADF_PF2VF_MSGTYPE_VERSION_RESP <<
-			ADF_PFVF_MSGTYPE_SHIFT;
-		resp |= ADF_PFVF_COMPAT_THIS_VERSION <<
-			ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
-		resp |= compat << ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
+		resp->type = ADF_PF2VF_MSGTYPE_VERSION_RESP;
+		resp->data = ADF_PFVF_COMPAT_THIS_VERSION <<
+			     ADF_PF2VF_VERSION_RESP_VERS_SHIFT;
+		resp->data |= compat << ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
 		}
 		break;
 	case ADF_VF2PF_MSGTYPE_VERSION_REQ:
@@ -82,12 +80,10 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		/* PF always newer than legacy VF */
 		compat = ADF_PF2VF_VF_COMPATIBLE;
 
-		resp |= ADF_PF2VF_MSGTYPE_VERSION_RESP <<
-			ADF_PFVF_MSGTYPE_SHIFT;
-		/* Set legacy major and minor version num */
-		resp |= 1 << ADF_PF2VF_MAJORVERSION_SHIFT |
-			1 << ADF_PF2VF_MINORVERSION_SHIFT;
-		resp |= compat << ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
+		resp->type = ADF_PF2VF_MSGTYPE_VERSION_RESP;
+		/* Set legacy major and minor version to the latest, 1.1 */
+		resp->data |= 0x11;
+		resp->data |= compat << ADF_PF2VF_VERSION_RESP_RESULT_SHIFT;
 		}
 		break;
 	case ADF_VF2PF_MSGTYPE_INIT:
@@ -105,29 +101,28 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		}
 		break;
 	default:
-		dev_dbg(&GET_DEV(accel_dev), "Unknown message from VF%d (0x%.8x)\n",
-			vf_nr, msg);
+		dev_dbg(&GET_DEV(accel_dev),
+			"Unknown message from VF%d (type 0x%.4x, data: 0x%.4x)\n",
+			vf_nr, msg.type, msg.data);
 		return -ENOMSG;
 	}
 
-	*response = resp;
-
 	return 0;
 }
 
 bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr)
 {
-	u32 resp = 0;
-	u32 msg;
+	struct pfvf_message req;
+	struct pfvf_message resp = {0};
 
-	msg = adf_recv_vf2pf_msg(accel_dev, vf_nr);
-	if (!msg)
+	req = adf_recv_vf2pf_msg(accel_dev, vf_nr);
+	if (!req.type)  /* Legacy or no message */
 		return true;
 
-	if (adf_handle_vf2pf_msg(accel_dev, vf_nr, msg, &resp))
+	if (adf_handle_vf2pf_msg(accel_dev, vf_nr, req, &resp))
 		return false;
 
-	if (resp && adf_send_pf2vf_msg(accel_dev, vf_nr, resp))
+	if (resp.type && adf_send_pf2vf_msg(accel_dev, vf_nr, resp))
 		dev_err(&GET_DEV(accel_dev),
 			"Failed to send response to VF%d\n", vf_nr);
 
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h
index 63245407bfb6..165d266d023d 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.h
@@ -6,7 +6,7 @@
 #include <linux/types.h>
 #include "adf_accel_devices.h"
 
-int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, u32 msg);
+int adf_send_pf2vf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr, struct pfvf_message msg);
 
 int adf_enable_pf2vf_comms(struct adf_accel_dev *accel_dev);
 
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.c b/drivers/crypto/qat/qat_common/adf_pfvf_utils.c
new file mode 100644
index 000000000000..494da89e2048
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_utils.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2021 Intel Corporation */
+#include <linux/pci.h>
+#include <linux/types.h>
+#include "adf_accel_devices.h"
+#include "adf_pfvf_msg.h"
+#include "adf_pfvf_utils.h"
+
+static bool set_value_on_csr_msg(struct adf_accel_dev *accel_dev, u32 *csr_msg,
+				 u32 value, const struct pfvf_field_format *fmt)
+{
+	if (unlikely((value & fmt->mask) != value)) {
+		dev_err(&GET_DEV(accel_dev),
+			"PFVF message value 0x%X out of range, %u max allowed\n",
+			value, fmt->mask);
+		return false;
+	}
+
+	*csr_msg |= value << fmt->offset;
+
+	return true;
+}
+
+u32 adf_pfvf_csr_msg_of(struct adf_accel_dev *accel_dev,
+			struct pfvf_message msg,
+			const struct pfvf_csr_format *fmt)
+{
+	u32 csr_msg = 0;
+
+	if (!set_value_on_csr_msg(accel_dev, &csr_msg, msg.type, &fmt->type) ||
+	    !set_value_on_csr_msg(accel_dev, &csr_msg, msg.data, &fmt->data))
+		return 0;
+
+	return csr_msg | ADF_PFVF_MSGORIGIN_SYSTEM;
+}
+
+struct pfvf_message adf_pfvf_message_of(struct adf_accel_dev *accel_dev, u32 csr_msg,
+					const struct pfvf_csr_format *fmt)
+{
+	struct pfvf_message msg = { 0 };
+
+	msg.type = (csr_msg >> fmt->type.offset) & fmt->type.mask;
+	msg.data = (csr_msg >> fmt->data.offset) & fmt->data.mask;
+
+	if (unlikely(!msg.type))
+		dev_err(&GET_DEV(accel_dev),
+			"Invalid PFVF msg with no type received\n");
+
+	return msg;
+}
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.h b/drivers/crypto/qat/qat_common/adf_pfvf_utils.h
new file mode 100644
index 000000000000..7b73b5992d03
--- /dev/null
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_utils.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2021 Intel Corporation */
+#ifndef ADF_PFVF_UTILS_H
+#define ADF_PFVF_UTILS_H
+
+#include <linux/types.h>
+#include "adf_pfvf_msg.h"
+
+struct pfvf_field_format {
+	u8  offset;
+	u32 mask;
+};
+
+struct pfvf_csr_format {
+	struct pfvf_field_format type;
+	struct pfvf_field_format data;
+};
+
+u32 adf_pfvf_csr_msg_of(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
+			const struct pfvf_csr_format *fmt);
+struct pfvf_message adf_pfvf_message_of(struct adf_accel_dev *accel_dev, u32 raw_msg,
+					const struct pfvf_csr_format *fmt);
+
+#endif /* ADF_PFVF_UTILS_H */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
index 0463743a8d43..5184a77598d2 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_msg.c
@@ -16,7 +16,7 @@
  */
 int adf_vf2pf_notify_init(struct adf_accel_dev *accel_dev)
 {
-	u32 msg = ADF_VF2PF_MSGTYPE_INIT << ADF_PFVF_MSGTYPE_SHIFT;
+	struct pfvf_message msg = { .type = ADF_VF2PF_MSGTYPE_INIT };
 
 	if (adf_send_vf2pf_msg(accel_dev, msg)) {
 		dev_err(&GET_DEV(accel_dev),
@@ -38,7 +38,7 @@ EXPORT_SYMBOL_GPL(adf_vf2pf_notify_init);
  */
 void adf_vf2pf_notify_shutdown(struct adf_accel_dev *accel_dev)
 {
-	u32 msg = ADF_VF2PF_MSGTYPE_SHUTDOWN << ADF_PFVF_MSGTYPE_SHIFT;
+	struct pfvf_message msg = { .type = ADF_VF2PF_MSGTYPE_SHUTDOWN };
 
 	if (test_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status))
 		if (adf_send_vf2pf_msg(accel_dev, msg))
@@ -50,13 +50,13 @@ EXPORT_SYMBOL_GPL(adf_vf2pf_notify_shutdown);
 int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 {
 	u8 pf_version;
-	u32 msg = 0;
 	int compat;
-	u32 resp;
 	int ret;
-
-	msg = ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ << ADF_PFVF_MSGTYPE_SHIFT |
-	      ADF_PFVF_COMPAT_THIS_VERSION << ADF_VF2PF_COMPAT_VER_REQ_SHIFT;
+	struct pfvf_message resp;
+	struct pfvf_message msg = {
+		.type = ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ,
+		.data = ADF_PFVF_COMPAT_THIS_VERSION,
+	};
 
 	BUILD_BUG_ON(ADF_PFVF_COMPAT_THIS_VERSION > 255);
 
@@ -67,9 +67,9 @@ int adf_vf2pf_request_version(struct adf_accel_dev *accel_dev)
 		return ret;
 	}
 
-	pf_version = (resp >> ADF_PF2VF_VERSION_RESP_VERS_SHIFT)
+	pf_version = (resp.data >> ADF_PF2VF_VERSION_RESP_VERS_SHIFT)
 		     & ADF_PF2VF_VERSION_RESP_VERS_MASK;
-	compat = (resp >> ADF_PF2VF_VERSION_RESP_RESULT_SHIFT)
+	compat = (resp.data >> ADF_PF2VF_VERSION_RESP_RESULT_SHIFT)
 		 & ADF_PF2VF_VERSION_RESP_RESULT_MASK;
 
 	/* Response from PF received, check compatibility */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
index 56e8185a9630..729c00c0d254 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
@@ -25,7 +25,7 @@
  *
  * Return: 0 on success, error code otherwise.
  */
-int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 msg)
+int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, struct pfvf_message msg)
 {
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_vf2pf_offset(0);
@@ -42,7 +42,7 @@ int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 msg)
  *
  * Return: a valid message on success, zero otherwise.
  */
-static u32 adf_recv_pf2vf_msg(struct adf_accel_dev *accel_dev)
+static struct pfvf_message adf_recv_pf2vf_msg(struct adf_accel_dev *accel_dev)
 {
 	struct adf_pfvf_ops *pfvf_ops = GET_PFVF_OPS(accel_dev);
 	u32 pfvf_offset = pfvf_ops->get_pf2vf_offset(0);
@@ -61,7 +61,8 @@ static u32 adf_recv_pf2vf_msg(struct adf_accel_dev *accel_dev)
  *
  * Return: 0 on success, error code otherwise.
  */
-int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp)
+int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
+		       struct pfvf_message *resp)
 {
 	unsigned long timeout = msecs_to_jiffies(ADF_PFVF_MSG_RESP_TIMEOUT);
 	int ret;
@@ -88,14 +89,15 @@ int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp)
 		*resp = accel_dev->vf.response;
 
 	/* Once copied, set to an invalid value */
-	accel_dev->vf.response = 0;
+	accel_dev->vf.response.type = 0;
 
 	return 0;
 }
 
-static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev, u32 msg)
+static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev,
+				 struct pfvf_message msg)
 {
-	switch ((msg >> ADF_PFVF_MSGTYPE_SHIFT) & ADF_PFVF_MSGTYPE_MASK) {
+	switch (msg.type) {
 	case ADF_PF2VF_MSGTYPE_RESTARTING:
 		dev_dbg(&GET_DEV(accel_dev), "Restarting message received from PF\n");
 
@@ -103,13 +105,15 @@ static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev, u32 msg)
 		return false;
 	case ADF_PF2VF_MSGTYPE_VERSION_RESP:
 		dev_dbg(&GET_DEV(accel_dev),
-			"Response message received from PF (0x%.8x)\n", msg);
+			"Response Message received from PF (type 0x%.4x, data 0x%.4x)\n",
+			msg.type, msg.data);
 		accel_dev->vf.response = msg;
 		complete(&accel_dev->vf.msg_received);
 		return true;
 	default:
 		dev_err(&GET_DEV(accel_dev),
-			"Unknown PF2VF message (0x%.8x) from PF\n", msg);
+			"Unknown message from PF (type 0x%.4x, data: 0x%.4x)\n",
+			msg.type, msg.data);
 	}
 
 	return false;
@@ -117,12 +121,14 @@ static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev, u32 msg)
 
 bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev)
 {
-	u32 msg;
+	struct pfvf_message msg;
 
 	msg = adf_recv_pf2vf_msg(accel_dev);
-	if (msg)
+	if (msg.type)  /* Invalid or no message */
 		return adf_handle_pf2vf_msg(accel_dev, msg);
 
+	/* No replies for PF->VF messages at present */
+
 	return true;
 }
 
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
index 6226d4d9d520..e32d1bc3a740 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
@@ -6,8 +6,9 @@
 #include <linux/types.h>
 #include "adf_accel_devices.h"
 
-int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 msg);
-int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, u32 msg, u32 *resp);
+int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, struct pfvf_message msg);
+int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
+		       struct pfvf_message *resp);
 
 int adf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev);
 
-- 
2.31.1

