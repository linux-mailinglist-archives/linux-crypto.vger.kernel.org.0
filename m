Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DA476D03
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Dec 2021 10:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhLPJLw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Dec 2021 04:11:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:9683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232975AbhLPJLn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639645903; x=1671181903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0kOuOoWwxjjZ/ehkkqv1ecpLX08q/d/6I9XLy5GwKM=;
  b=QB4rEMCVwaCLHlTQKaVxvsAIyxlUtSGnLJL9Edkp1ulJGr9EvBRxeYFb
   0UjEm+J7RP/25uKGL+lHjofKWkkxVtY+sZrDa8cmEtm+buTnSvNRzh/Qt
   YdyNGCiMeaNN8sqv5iuH+VdLINkY0AqAdf26qWP4cMiNKasLxfKwMY7oX
   Fd7swNr3cAyGClSpbu/RI/9LEs58uQmPV/AsTbDswRO2AjiyYFM/KWYno
   weHzpJdKALFQHqHn/gyfRrEbz4nMl2S3sROxWmKkrd7MNPiNZCG/Cwn3K
   4HYMNmhsNzS0qJ7oXgIFwLualvm78/Q9B2rTbe3va0wThu+g+UJLW2D0A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219458465"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219458465"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:11:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="465968551"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 01:11:39 -0800
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, marco.chiappero@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 16/24] crypto: qat - introduce support for PFVF block messages
Date:   Thu, 16 Dec 2021 09:13:26 +0000
Message-Id: <20211216091334.402420-17-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216091334.402420-1-marco.chiappero@intel.com>
References: <20211216091334.402420-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

GEN2 devices use a single CSR for PFVF messages, which leaves up to 10 bits
of payload per single message. While such amount is sufficient for the
currently defined messages, the transfer of bigger and more complex data
streams from the PF to the VF requires a new mechanism that extends the
protocol.

This patch adds a new layer on top of the basic PFVF messaging, called
Block Messages, to encapsulate up to 126 bytes of data in a single
logical message across multiple PFVF messages of new types (SMALL,
MEDIUM and LARGE BLOCK), including (sub)types (BLKMSG_TYPE) to carry the
information about the actual Block Message.

Regardless of the size, each Block Message uses a two bytes header,
containing the version and size, to allow for extension while
maintaining compatibility. The size and the types of Block Messages are
defined as follow:

- small block messages:  up to 16 BLKMSG types of up to 30 bytes
- medium block messages: up to 8 BLKMSG types of up to 62 bytes
- large block messages:  up to 4 BLKMSG types of up to 126 bytes

It effectively works as reading a byte at a time from a block device and
for each of these new Block Messages:
- the requestor (always a VF) can either request a specific byte of the
  larger message, in order to retrieve the full message, or request the
  value of the CRC calculated for a specific message up to the provided
  size (to allow for messages to grow while maintaining forward
  compatibility)
- the responder (always the PF) will either return a single data or CRC
  byte, along with the indication of response type (or error).

This patch provides the basic infrastructure to perform the above
operations, without defining any new message.

As CRCs are required, this code now depends on the CRC8 module.

Note: as a consequence of the Block Messages design, sending multiple
PFVF messages in bursts, the interrupt rate limiting values on the PF are
increased.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/Kconfig                    |   1 +
 drivers/crypto/qat/qat_common/adf_pfvf_msg.h  |  74 +++++++
 .../crypto/qat/qat_common/adf_pfvf_pf_msg.h   |   3 +
 .../crypto/qat/qat_common/adf_pfvf_pf_proto.c | 137 ++++++++++++
 .../crypto/qat/qat_common/adf_pfvf_utils.c    |  15 ++
 .../crypto/qat/qat_common/adf_pfvf_utils.h    |   3 +
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.c | 203 +++++++++++++++++-
 .../crypto/qat/qat_common/adf_pfvf_vf_proto.h |   2 +
 drivers/crypto/qat/qat_common/adf_sriov.c     |   7 +-
 9 files changed, 442 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/qat/Kconfig
index 77783feb62b2..4b90c0f22b03 100644
--- a/drivers/crypto/qat/Kconfig
+++ b/drivers/crypto/qat/Kconfig
@@ -13,6 +13,7 @@ config CRYPTO_DEV_QAT
 	select CRYPTO_SHA512
 	select CRYPTO_LIB_AES
 	select FW_LOADER
+	select CRC8
 
 config CRYPTO_DEV_QAT_DH895xCC
 	tristate "Support for Intel(R) DH895xCC"
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
index daee3d7ceb8c..6abbb5e05809 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_msg.h
@@ -71,6 +71,7 @@ struct pfvf_message {
 enum pf2vf_msgtype {
 	ADF_PF2VF_MSGTYPE_RESTARTING		= 0x01,
 	ADF_PF2VF_MSGTYPE_VERSION_RESP		= 0x02,
+	ADF_PF2VF_MSGTYPE_BLKMSG_RESP		= 0x03,
 };
 
 /* VF->PF messages */
@@ -79,6 +80,9 @@ enum vf2pf_msgtype {
 	ADF_VF2PF_MSGTYPE_SHUTDOWN		= 0x04,
 	ADF_VF2PF_MSGTYPE_VERSION_REQ		= 0x05,
 	ADF_VF2PF_MSGTYPE_COMPAT_VER_REQ	= 0x06,
+	ADF_VF2PF_MSGTYPE_LARGE_BLOCK_REQ	= 0x07,
+	ADF_VF2PF_MSGTYPE_MEDIUM_BLOCK_REQ	= 0x08,
+	ADF_VF2PF_MSGTYPE_SMALL_BLOCK_REQ	= 0x09,
 };
 
 /* VF/PF compatibility version. */
@@ -97,4 +101,74 @@ enum pf2vf_compat_response {
 	ADF_PF2VF_VF_COMPAT_UNKNOWN		= 0x03,
 };
 
+/* PF->VF Block Responses */
+#define ADF_PF2VF_BLKMSG_RESP_TYPE_MASK		GENMASK(1, 0)
+#define ADF_PF2VF_BLKMSG_RESP_DATA_MASK		GENMASK(9, 2)
+
+enum pf2vf_blkmsg_resp_type {
+	ADF_PF2VF_BLKMSG_RESP_TYPE_DATA		= 0x00,
+	ADF_PF2VF_BLKMSG_RESP_TYPE_CRC		= 0x01,
+	ADF_PF2VF_BLKMSG_RESP_TYPE_ERROR	= 0x02,
+};
+
+/* PF->VF Block Error Code */
+enum pf2vf_blkmsg_error {
+	ADF_PF2VF_INVALID_BLOCK_TYPE		= 0x00,
+	ADF_PF2VF_INVALID_BYTE_NUM_REQ		= 0x01,
+	ADF_PF2VF_PAYLOAD_TRUNCATED		= 0x02,
+	ADF_PF2VF_UNSPECIFIED_ERROR		= 0x03,
+};
+
+/* VF->PF Block Requests */
+#define ADF_VF2PF_LARGE_BLOCK_TYPE_MASK		GENMASK(1, 0)
+#define ADF_VF2PF_LARGE_BLOCK_BYTE_MASK		GENMASK(8, 2)
+#define ADF_VF2PF_MEDIUM_BLOCK_TYPE_MASK	GENMASK(2, 0)
+#define ADF_VF2PF_MEDIUM_BLOCK_BYTE_MASK	GENMASK(8, 3)
+#define ADF_VF2PF_SMALL_BLOCK_TYPE_MASK		GENMASK(3, 0)
+#define ADF_VF2PF_SMALL_BLOCK_BYTE_MASK		GENMASK(8, 4)
+#define ADF_VF2PF_BLOCK_CRC_REQ_MASK		BIT(9)
+
+/* PF->VF Block Request Types
+ *  0..15 - 32 byte message
+ * 16..23 - 64 byte message
+ * 24..27 - 128 byte message
+ */
+/* No block messages as of yet */
+
+#define ADF_VF2PF_SMALL_BLOCK_TYPE_MAX \
+		(FIELD_MAX(ADF_VF2PF_SMALL_BLOCK_TYPE_MASK))
+
+#define ADF_VF2PF_MEDIUM_BLOCK_TYPE_MAX \
+		(FIELD_MAX(ADF_VF2PF_MEDIUM_BLOCK_TYPE_MASK) + \
+		ADF_VF2PF_SMALL_BLOCK_TYPE_MAX + 1)
+
+#define ADF_VF2PF_LARGE_BLOCK_TYPE_MAX \
+		(FIELD_MAX(ADF_VF2PF_LARGE_BLOCK_TYPE_MASK) + \
+		ADF_VF2PF_MEDIUM_BLOCK_TYPE_MAX)
+
+#define ADF_VF2PF_SMALL_BLOCK_BYTE_MAX \
+		FIELD_MAX(ADF_VF2PF_SMALL_BLOCK_BYTE_MASK)
+
+#define ADF_VF2PF_MEDIUM_BLOCK_BYTE_MAX \
+		FIELD_MAX(ADF_VF2PF_MEDIUM_BLOCK_BYTE_MASK)
+
+#define ADF_VF2PF_LARGE_BLOCK_BYTE_MAX \
+		FIELD_MAX(ADF_VF2PF_LARGE_BLOCK_BYTE_MASK)
+
+struct pfvf_blkmsg_header {
+	u8 version;
+	u8 payload_size;
+} __packed;
+
+#define ADF_PFVF_BLKMSG_HEADER_SIZE		(sizeof(struct pfvf_blkmsg_header))
+#define ADF_PFVF_BLKMSG_PAYLOAD_SIZE(blkmsg)	(sizeof(blkmsg) - \
+							ADF_PFVF_BLKMSG_HEADER_SIZE)
+#define ADF_PFVF_BLKMSG_MSG_SIZE(blkmsg)	(ADF_PFVF_BLKMSG_HEADER_SIZE + \
+							(blkmsg)->hdr.payload_size)
+#define ADF_PFVF_BLKMSG_MSG_MAX_SIZE		128
+
+/* PF->VF Block message header bytes */
+#define ADF_PFVF_BLKMSG_VER_BYTE		0
+#define ADF_PFVF_BLKMSG_LEN_BYTE		1
+
 #endif /* ADF_PFVF_MSG_H */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h
index 187807b1ff88..5c669f1de6e4 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_msg.h
@@ -7,4 +7,7 @@
 
 void adf_pf2vf_notify_restarting(struct adf_accel_dev *accel_dev);
 
+typedef int (*adf_pf2vf_blkmsg_provider)(struct adf_accel_dev *accel_dev,
+					 u8 *buffer, u8 compat);
+
 #endif /* ADF_PFVF_PF_MSG_H */
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
index f461aa0a95c7..850b5f4414a6 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
@@ -6,7 +6,16 @@
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_pfvf_msg.h"
+#include "adf_pfvf_pf_msg.h"
 #include "adf_pfvf_pf_proto.h"
+#include "adf_pfvf_utils.h"
+
+typedef u8 (*pf2vf_blkmsg_data_getter_fn)(u8 const *blkmsg, u8 byte);
+
+static const adf_pf2vf_blkmsg_provider pf2vf_blkmsg_providers[] = {
+	NULL,				  /* no message type defined for value 0 */
+	NULL,				  /* no message type defined for value 1 */
+};
 
 /**
  * adf_send_pf2vf_msg() - send PF to VF message
@@ -44,6 +53,128 @@ static struct pfvf_message adf_recv_vf2pf_msg(struct adf_accel_dev *accel_dev, u
 	return pfvf_ops->recv_msg(accel_dev, pfvf_offset);
 }
 
+static adf_pf2vf_blkmsg_provider get_blkmsg_response_provider(u8 type)
+{
+	if (type >= ARRAY_SIZE(pf2vf_blkmsg_providers))
+		return NULL;
+
+	return pf2vf_blkmsg_providers[type];
+}
+
+/* Byte pf2vf_blkmsg_data_getter_fn callback */
+static u8 adf_pf2vf_blkmsg_get_byte(u8 const *blkmsg, u8 index)
+{
+	return blkmsg[index];
+}
+
+/* CRC pf2vf_blkmsg_data_getter_fn callback */
+static u8 adf_pf2vf_blkmsg_get_crc(u8 const *blkmsg, u8 count)
+{
+	/* count is 0-based, turn it into a length */
+	return adf_pfvf_calc_blkmsg_crc(blkmsg, count + 1);
+}
+
+static int adf_pf2vf_blkmsg_get_data(struct adf_accel_vf_info *vf_info,
+				     u8 type, u8 byte, u8 max_size, u8 *data,
+				     pf2vf_blkmsg_data_getter_fn data_getter)
+{
+	u8 blkmsg[ADF_PFVF_BLKMSG_MSG_MAX_SIZE] = { 0 };
+	struct adf_accel_dev *accel_dev = vf_info->accel_dev;
+	adf_pf2vf_blkmsg_provider provider;
+	u8 msg_size;
+
+	provider = get_blkmsg_response_provider(type);
+
+	if (unlikely(!provider)) {
+		pr_err("QAT: No registered provider for message %d\n", type);
+		*data = ADF_PF2VF_INVALID_BLOCK_TYPE;
+		return -EINVAL;
+	}
+
+	if (unlikely((*provider)(accel_dev, blkmsg, vf_info->vf_compat_ver))) {
+		pr_err("QAT: unknown error from provider for message %d\n", type);
+		*data = ADF_PF2VF_UNSPECIFIED_ERROR;
+		return -EINVAL;
+	}
+
+	msg_size = ADF_PFVF_BLKMSG_HEADER_SIZE + blkmsg[ADF_PFVF_BLKMSG_LEN_BYTE];
+
+	if (unlikely(msg_size >= max_size)) {
+		pr_err("QAT: Invalid size %d provided for message type %d\n",
+		       msg_size, type);
+		*data = ADF_PF2VF_PAYLOAD_TRUNCATED;
+		return -EINVAL;
+	}
+
+	if (unlikely(byte >= msg_size)) {
+		pr_err("QAT: Out-of-bound byte number %d (msg size %d)\n",
+		       byte, msg_size);
+		*data = ADF_PF2VF_INVALID_BYTE_NUM_REQ;
+		return -EINVAL;
+	}
+
+	*data = data_getter(blkmsg, byte);
+	return 0;
+}
+
+static struct pfvf_message handle_blkmsg_req(struct adf_accel_vf_info *vf_info,
+					     struct pfvf_message req)
+{
+	u8 resp_type = ADF_PF2VF_BLKMSG_RESP_TYPE_ERROR;
+	struct pfvf_message resp = { 0 };
+	u8 resp_data = 0;
+	u8 blk_type;
+	u8 blk_byte;
+	u8 byte_max;
+
+	switch (req.type) {
+	case ADF_VF2PF_MSGTYPE_LARGE_BLOCK_REQ:
+		blk_type = FIELD_GET(ADF_VF2PF_LARGE_BLOCK_TYPE_MASK, req.data)
+			   + ADF_VF2PF_MEDIUM_BLOCK_TYPE_MAX + 1;
+		blk_byte = FIELD_GET(ADF_VF2PF_LARGE_BLOCK_BYTE_MASK, req.data);
+		byte_max = ADF_VF2PF_LARGE_BLOCK_BYTE_MAX;
+		break;
+	case ADF_VF2PF_MSGTYPE_MEDIUM_BLOCK_REQ:
+		blk_type = FIELD_GET(ADF_VF2PF_MEDIUM_BLOCK_TYPE_MASK, req.data)
+			   + ADF_VF2PF_SMALL_BLOCK_TYPE_MAX + 1;
+		blk_byte = FIELD_GET(ADF_VF2PF_MEDIUM_BLOCK_BYTE_MASK, req.data);
+		byte_max = ADF_VF2PF_MEDIUM_BLOCK_BYTE_MAX;
+		break;
+	case ADF_VF2PF_MSGTYPE_SMALL_BLOCK_REQ:
+		blk_type = FIELD_GET(ADF_VF2PF_SMALL_BLOCK_TYPE_MASK, req.data);
+		blk_byte = FIELD_GET(ADF_VF2PF_SMALL_BLOCK_BYTE_MASK, req.data);
+		byte_max = ADF_VF2PF_SMALL_BLOCK_BYTE_MAX;
+		break;
+	}
+
+	/* Is this a request for CRC or data? */
+	if (FIELD_GET(ADF_VF2PF_BLOCK_CRC_REQ_MASK, req.data)) {
+		dev_dbg(&GET_DEV(vf_info->accel_dev),
+			"BlockMsg of type %d for CRC over %d bytes received from VF%d\n",
+			blk_type, blk_byte, vf_info->vf_nr);
+
+		if (!adf_pf2vf_blkmsg_get_data(vf_info, blk_type, blk_byte,
+					       byte_max, &resp_data,
+					       adf_pf2vf_blkmsg_get_crc))
+			resp_type = ADF_PF2VF_BLKMSG_RESP_TYPE_CRC;
+	} else {
+		dev_dbg(&GET_DEV(vf_info->accel_dev),
+			"BlockMsg of type %d for data byte %d received from VF%d\n",
+			blk_type, blk_byte, vf_info->vf_nr);
+
+		if (!adf_pf2vf_blkmsg_get_data(vf_info, blk_type, blk_byte,
+					       byte_max, &resp_data,
+					       adf_pf2vf_blkmsg_get_byte))
+			resp_type = ADF_PF2VF_BLKMSG_RESP_TYPE_DATA;
+	}
+
+	resp.type = ADF_PF2VF_MSGTYPE_BLKMSG_RESP;
+	resp.data = FIELD_PREP(ADF_PF2VF_BLKMSG_RESP_TYPE_MASK, resp_type) |
+		    FIELD_PREP(ADF_PF2VF_BLKMSG_RESP_DATA_MASK, resp_data);
+
+	return resp;
+}
+
 static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr,
 				struct pfvf_message msg, struct pfvf_message *resp)
 {
@@ -106,6 +237,11 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u8 vf_nr,
 		vf_info->init = false;
 		}
 		break;
+	case ADF_VF2PF_MSGTYPE_LARGE_BLOCK_REQ:
+	case ADF_VF2PF_MSGTYPE_MEDIUM_BLOCK_REQ:
+	case ADF_VF2PF_MSGTYPE_SMALL_BLOCK_REQ:
+		*resp = handle_blkmsg_req(vf_info, msg);
+		break;
 	default:
 		dev_dbg(&GET_DEV(accel_dev),
 			"Unknown message from VF%d (type 0x%.4x, data: 0x%.4x)\n",
@@ -147,6 +283,7 @@ bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr)
  */
 int adf_enable_pf2vf_comms(struct adf_accel_dev *accel_dev)
 {
+	adf_pfvf_crc_init();
 	spin_lock_init(&accel_dev->pf.vf2pf_ints_lock);
 
 	return 0;
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.c b/drivers/crypto/qat/qat_common/adf_pfvf_utils.c
index 494da89e2048..c5f6d77d4bb8 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_utils.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_utils.c
@@ -1,11 +1,26 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2021 Intel Corporation */
+#include <linux/crc8.h>
 #include <linux/pci.h>
 #include <linux/types.h>
 #include "adf_accel_devices.h"
 #include "adf_pfvf_msg.h"
 #include "adf_pfvf_utils.h"
 
+/* CRC Calculation */
+DECLARE_CRC8_TABLE(pfvf_crc8_table);
+#define ADF_PFVF_CRC8_POLYNOMIAL 0x97
+
+void adf_pfvf_crc_init(void)
+{
+	crc8_populate_msb(pfvf_crc8_table, ADF_PFVF_CRC8_POLYNOMIAL);
+}
+
+u8 adf_pfvf_calc_blkmsg_crc(u8 const *buf, u8 buf_len)
+{
+	return crc8(pfvf_crc8_table, buf, buf_len, CRC8_INIT_VALUE);
+}
+
 static bool set_value_on_csr_msg(struct adf_accel_dev *accel_dev, u32 *csr_msg,
 				 u32 value, const struct pfvf_field_format *fmt)
 {
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_utils.h b/drivers/crypto/qat/qat_common/adf_pfvf_utils.h
index 7676fdddbe26..2be048e2287b 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_utils.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_utils.h
@@ -10,6 +10,9 @@
 #define ADF_PFVF_MSG_ACK_DELAY_US	4
 #define ADF_PFVF_MSG_ACK_MAX_DELAY_US	(1 * USEC_PER_SEC)
 
+u8 adf_pfvf_calc_blkmsg_crc(u8 const *buf, u8 buf_len);
+void adf_pfvf_crc_init(void);
+
 struct pfvf_field_format {
 	u8  offset;
 	u32 mask;
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
index 729c00c0d254..0fdd6b9892d3 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2015 - 2021 Intel Corporation */
+#include <linux/bitfield.h>
 #include <linux/completion.h>
+#include <linux/minmax.h>
 #include <linux/types.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_pfvf_msg.h"
+#include "adf_pfvf_utils.h"
 #include "adf_pfvf_vf_msg.h"
 #include "adf_pfvf_vf_proto.h"
 
@@ -94,6 +97,202 @@ int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 	return 0;
 }
 
+static int adf_vf2pf_blkmsg_data_req(struct adf_accel_dev *accel_dev, bool crc,
+				     u8 *type, u8 *data)
+{
+	struct pfvf_message req = { 0 };
+	struct pfvf_message resp = { 0 };
+	u8 blk_type;
+	u8 blk_byte;
+	u8 msg_type;
+	u8 max_data;
+	int err;
+
+	/* Convert the block type to {small, medium, large} size category */
+	if (*type <= ADF_VF2PF_SMALL_BLOCK_TYPE_MAX) {
+		msg_type = ADF_VF2PF_MSGTYPE_SMALL_BLOCK_REQ;
+		blk_type = FIELD_PREP(ADF_VF2PF_SMALL_BLOCK_TYPE_MASK, *type);
+		blk_byte = FIELD_PREP(ADF_VF2PF_SMALL_BLOCK_BYTE_MASK, *data);
+		max_data = ADF_VF2PF_SMALL_BLOCK_BYTE_MAX;
+	} else if (*type <= ADF_VF2PF_MEDIUM_BLOCK_TYPE_MAX) {
+		msg_type = ADF_VF2PF_MSGTYPE_MEDIUM_BLOCK_REQ;
+		blk_type = FIELD_PREP(ADF_VF2PF_MEDIUM_BLOCK_TYPE_MASK,
+				      *type - ADF_VF2PF_SMALL_BLOCK_TYPE_MAX);
+		blk_byte = FIELD_PREP(ADF_VF2PF_MEDIUM_BLOCK_BYTE_MASK, *data);
+		max_data = ADF_VF2PF_MEDIUM_BLOCK_BYTE_MAX;
+	} else if (*type <= ADF_VF2PF_LARGE_BLOCK_TYPE_MAX) {
+		msg_type = ADF_VF2PF_MSGTYPE_LARGE_BLOCK_REQ;
+		blk_type = FIELD_PREP(ADF_VF2PF_LARGE_BLOCK_TYPE_MASK,
+				      *type - ADF_VF2PF_MEDIUM_BLOCK_TYPE_MAX);
+		blk_byte = FIELD_PREP(ADF_VF2PF_LARGE_BLOCK_BYTE_MASK, *data);
+		max_data = ADF_VF2PF_LARGE_BLOCK_BYTE_MAX;
+	} else {
+		dev_err(&GET_DEV(accel_dev), "Invalid message type %u\n", *type);
+		return -EINVAL;
+	}
+
+	/* Sanity check */
+	if (*data > max_data) {
+		dev_err(&GET_DEV(accel_dev),
+			"Invalid byte %s %u for message type %u\n",
+			crc ? "count" : "index", *data, *type);
+		return -EINVAL;
+	}
+
+	/* Build the block message */
+	req.type = msg_type;
+	req.data = blk_type | blk_byte | FIELD_PREP(ADF_VF2PF_BLOCK_CRC_REQ_MASK, crc);
+
+	err = adf_send_vf2pf_req(accel_dev, req, &resp);
+	if (err)
+		return err;
+
+	*type = FIELD_GET(ADF_PF2VF_BLKMSG_RESP_TYPE_MASK, resp.data);
+	*data = FIELD_GET(ADF_PF2VF_BLKMSG_RESP_DATA_MASK, resp.data);
+
+	return 0;
+}
+
+static int adf_vf2pf_blkmsg_get_byte(struct adf_accel_dev *accel_dev, u8 type,
+				     u8 index, u8 *data)
+{
+	int ret;
+
+	ret = adf_vf2pf_blkmsg_data_req(accel_dev, false, &type, &index);
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(type != ADF_PF2VF_BLKMSG_RESP_TYPE_DATA)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Unexpected BLKMSG response type %u, byte 0x%x\n",
+			type, index);
+		return -EFAULT;
+	}
+
+	*data = index;
+	return 0;
+}
+
+static int adf_vf2pf_blkmsg_get_crc(struct adf_accel_dev *accel_dev, u8 type,
+				    u8 bytes, u8 *crc)
+{
+	int ret;
+
+	/* The count of bytes refers to a length, however shift it to a 0-based
+	 * count to avoid overflows. Thus, a request for 0 bytes is technically
+	 * valid.
+	 */
+	--bytes;
+
+	ret = adf_vf2pf_blkmsg_data_req(accel_dev, true, &type, &bytes);
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(type != ADF_PF2VF_BLKMSG_RESP_TYPE_CRC)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Unexpected CRC BLKMSG response type %u, crc 0x%x\n",
+			type, bytes);
+		return  -EFAULT;
+	}
+
+	*crc = bytes;
+	return 0;
+}
+
+/**
+ * adf_send_vf2pf_blkmsg_req() - retrieve block message
+ * @accel_dev:	Pointer to acceleration VF device.
+ * @type:	The block message type, see adf_pfvf_msg.h for allowed values
+ * @buffer:	input buffer where to place the received data
+ * @buffer_len:	buffer length as input, the amount of written bytes on output
+ *
+ * Request a message of type 'type' over the block message transport.
+ * This function will send the required amount block message requests and
+ * return the overall content back to the caller through the provided buffer.
+ * The buffer should be large enough to contain the requested message type,
+ * otherwise the response will be truncated.
+ *
+ * Return: 0 on success, error code otherwise.
+ */
+int adf_send_vf2pf_blkmsg_req(struct adf_accel_dev *accel_dev, u8 type,
+			      u8 *buffer, unsigned int *buffer_len)
+{
+	unsigned int index;
+	unsigned int msg_len;
+	int ret;
+	u8 remote_crc;
+	u8 local_crc;
+
+	if (unlikely(type > ADF_VF2PF_LARGE_BLOCK_TYPE_MAX)) {
+		dev_err(&GET_DEV(accel_dev), "Invalid block message type %d\n",
+			type);
+		return -EINVAL;
+	}
+
+	if (unlikely(*buffer_len < ADF_PFVF_BLKMSG_HEADER_SIZE)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Buffer size too small for a block message\n");
+		return -EINVAL;
+	}
+
+	ret = adf_vf2pf_blkmsg_get_byte(accel_dev, type,
+					ADF_PFVF_BLKMSG_VER_BYTE,
+					&buffer[ADF_PFVF_BLKMSG_VER_BYTE]);
+	if (unlikely(ret))
+		return ret;
+
+	if (unlikely(!buffer[ADF_PFVF_BLKMSG_VER_BYTE])) {
+		dev_err(&GET_DEV(accel_dev),
+			"Invalid version 0 received for block request %u", type);
+		return -EFAULT;
+	}
+
+	ret = adf_vf2pf_blkmsg_get_byte(accel_dev, type,
+					ADF_PFVF_BLKMSG_LEN_BYTE,
+					&buffer[ADF_PFVF_BLKMSG_LEN_BYTE]);
+	if (unlikely(ret))
+		return ret;
+
+	if (unlikely(!buffer[ADF_PFVF_BLKMSG_LEN_BYTE])) {
+		dev_err(&GET_DEV(accel_dev),
+			"Invalid size 0 received for block request %u", type);
+		return -EFAULT;
+	}
+
+	/* We need to pick the minimum since there is no way to request a
+	 * specific version. As a consequence any scenario is possible:
+	 * - PF has a newer (longer) version which doesn't fit in the buffer
+	 * - VF expects a newer (longer) version, so we must not ask for
+	 *   bytes in excess
+	 * - PF and VF share the same version, no problem
+	 */
+	msg_len = ADF_PFVF_BLKMSG_HEADER_SIZE + buffer[ADF_PFVF_BLKMSG_LEN_BYTE];
+	msg_len = min(*buffer_len, msg_len);
+
+	/* Get the payload */
+	for (index = ADF_PFVF_BLKMSG_HEADER_SIZE; index < msg_len; index++) {
+		ret = adf_vf2pf_blkmsg_get_byte(accel_dev, type, index,
+						&buffer[index]);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	ret = adf_vf2pf_blkmsg_get_crc(accel_dev, type, msg_len, &remote_crc);
+	if (unlikely(ret))
+		return ret;
+
+	local_crc = adf_pfvf_calc_blkmsg_crc(buffer, msg_len);
+	if (unlikely(local_crc != remote_crc)) {
+		dev_err(&GET_DEV(accel_dev),
+			"CRC error on msg type %d. Local %02X, remote %02X\n",
+			type, local_crc, remote_crc);
+		return -EIO;
+	}
+
+	*buffer_len = msg_len;
+	return 0;
+}
+
 static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev,
 				 struct pfvf_message msg)
 {
@@ -104,6 +303,7 @@ static bool adf_handle_pf2vf_msg(struct adf_accel_dev *accel_dev,
 		adf_pf2vf_handle_pf_restarting(accel_dev);
 		return false;
 	case ADF_PF2VF_MSGTYPE_VERSION_RESP:
+	case ADF_PF2VF_MSGTYPE_BLKMSG_RESP:
 		dev_dbg(&GET_DEV(accel_dev),
 			"Response Message received from PF (type 0x%.4x, data 0x%.4x)\n",
 			msg.type, msg.data);
@@ -135,12 +335,13 @@ bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev)
 /**
  * adf_enable_vf2pf_comms() - Function enables communication from vf to pf
  *
- * @accel_dev: Pointer to acceleration device virtual function.
+ * @accel_dev:	Pointer to acceleration device virtual function.
  *
  * Return: 0 on success, error code otherwise.
  */
 int adf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev)
 {
+	adf_pfvf_crc_init();
 	adf_enable_pf2vf_interrupts(accel_dev);
 	return adf_vf2pf_request_version(accel_dev);
 }
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
index e32d1bc3a740..f6ee9b38c0e1 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_vf_proto.h
@@ -9,6 +9,8 @@
 int adf_send_vf2pf_msg(struct adf_accel_dev *accel_dev, struct pfvf_message msg);
 int adf_send_vf2pf_req(struct adf_accel_dev *accel_dev, struct pfvf_message msg,
 		       struct pfvf_message *resp);
+int adf_send_vf2pf_blkmsg_req(struct adf_accel_dev *accel_dev, u8 type,
+			      u8 *buffer, unsigned int *buffer_len);
 
 int adf_enable_vf2pf_comms(struct adf_accel_dev *accel_dev);
 
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index 6366622ff8fd..971a05d62418 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -8,6 +8,9 @@
 #include "adf_cfg.h"
 #include "adf_pfvf_pf_msg.h"
 
+#define ADF_VF2PF_RATELIMIT_INTERVAL	8
+#define ADF_VF2PF_RATELIMIT_BURST	130
+
 static struct workqueue_struct *pf2vf_resp_wq;
 
 struct adf_pf2vf_resp {
@@ -62,8 +65,8 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 
 		mutex_init(&vf_info->pf2vf_lock);
 		ratelimit_state_init(&vf_info->vf2pf_ratelimit,
-				     DEFAULT_RATELIMIT_INTERVAL,
-				     DEFAULT_RATELIMIT_BURST);
+				     ADF_VF2PF_RATELIMIT_INTERVAL,
+				     ADF_VF2PF_RATELIMIT_BURST);
 	}
 
 	/* Set Valid bits in AE Thread to PCIe Function Mapping */
-- 
2.31.1

