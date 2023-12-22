Return-Path: <linux-crypto+bounces-973-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283A81C83E
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 11:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD6285FD0
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF64168BC;
	Fri, 22 Dec 2023 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlSQqoiB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8248168A2
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241492; x=1734777492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7J9dz0SdFdUsPqSGfxVRIeV6x/jBQpOAvtSbAfZtIl8=;
  b=PlSQqoiBbWRS2wdWOG2k9JO8/KMuq3IwE4gfnyDdV03LvIhlGwkGcR9y
   fkEhdgOcrINI4PGxNercgkZ8D0lvzKknplncfcJNzqi3/ASR2MTg0+2Kr
   noupLNSHW4zLV5LgmvfvAkcESq07646QxZz23OQ+yQNUKSlQfVHDhDOvC
   /F52ilfnkOD/YBe8Na4c7e8lMWoL61z7y2oEy35/hMZGTfqfxMXo+ltsy
   Wwy8U+dLnstPYr7fMZerDpr06sxnA7dhlen26fRkzlJrkUBc7k8bVmVQU
   61sC5wO4+V2FXmxkkpdArXwkTqweJRAn3fwW9pPrB9JVB35s6BsdgOJb4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2948174"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2948174"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726742876"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726742876"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2023 02:38:11 -0800
From: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>
Subject: [PATCH v2 2/4] crypto: qat - add admin msgs for telemetry
Date: Fri, 22 Dec 2023 11:35:06 +0100
Message-ID: <20231222103508.1037442-3-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222103508.1037442-1-lucas.segarra.fernandez@intel.com>
References: <20231222103508.1037442-1-lucas.segarra.fernandez@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the admin interface with two new public APIs to enable
and disable the telemetry feature: adf_send_admin_tl_start() and
adf_send_admin_tl_stop().

The first, sends to the firmware, through the ICP_QAT_FW_TL_START
message, the IO address where the firmware will write telemetry
metrics and a list of ring pairs (maximum 4) to be monitored.
It returns the number of accelerators of each type supported by
this hardware. After this message is sent, the firmware starts
periodically reporting telemetry data using by writing into the
dma buffer specified as input.

The second, sends the admin message ICP_QAT_FW_TL_STOP
which stops the reporting of telemetry data.

This patch is based on earlier work done by Wojciech Ziemba.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
---
 .../crypto/intel/qat/qat_common/adf_admin.c   | 37 +++++++++++++++++++
 .../crypto/intel/qat/qat_common/adf_admin.h   |  4 ++
 .../qat/qat_common/icp_qat_fw_init_admin.h    | 10 +++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.c b/drivers/crypto/intel/qat/qat_common/adf_admin.c
index 54b673ec2362..acad526eb741 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.c
@@ -498,6 +498,43 @@ int adf_get_cnv_stats(struct adf_accel_dev *accel_dev, u16 ae, u16 *err_cnt,
 	return ret;
 }
 
+int adf_send_admin_tl_start(struct adf_accel_dev *accel_dev,
+			    dma_addr_t tl_dma_addr, size_t layout_sz, u8 *rp_indexes,
+			    struct icp_qat_fw_init_admin_slice_cnt *slice_count)
+{
+	u32 ae_mask = GET_HW_DATA(accel_dev)->admin_ae_mask;
+	struct icp_qat_fw_init_admin_resp resp = { };
+	struct icp_qat_fw_init_admin_req req = { };
+	int ret;
+
+	req.cmd_id = ICP_QAT_FW_TL_START;
+	req.init_cfg_ptr = tl_dma_addr;
+	req.init_cfg_sz = layout_sz;
+
+	if (rp_indexes)
+		memcpy(&req.rp_indexes, rp_indexes, sizeof(req.rp_indexes));
+
+	ret = adf_send_admin(accel_dev, &req, &resp, ae_mask);
+	if (ret)
+		return ret;
+
+	memcpy(slice_count, &resp.slices, sizeof(*slice_count));
+
+	return 0;
+}
+
+int adf_send_admin_tl_stop(struct adf_accel_dev *accel_dev)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	struct icp_qat_fw_init_admin_resp resp = { };
+	struct icp_qat_fw_init_admin_req req = { };
+	u32 ae_mask = hw_data->admin_ae_mask;
+
+	req.cmd_id = ICP_QAT_FW_TL_STOP;
+
+	return adf_send_admin(accel_dev, &req, &resp, ae_mask);
+}
+
 int adf_init_admin_comms(struct adf_accel_dev *accel_dev)
 {
 	struct adf_admin_comms *admin;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_admin.h b/drivers/crypto/intel/qat/qat_common/adf_admin.h
index 55cbcbc66c9f..647c8e196752 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_admin.h
@@ -23,5 +23,9 @@ int adf_send_admin_rl_delete(struct adf_accel_dev *accel_dev, u16 node_id,
 int adf_get_fw_timestamp(struct adf_accel_dev *accel_dev, u64 *timestamp);
 int adf_get_pm_info(struct adf_accel_dev *accel_dev, dma_addr_t p_state_addr, size_t buff_size);
 int adf_get_cnv_stats(struct adf_accel_dev *accel_dev, u16 ae, u16 *err_cnt, u16 *latest_err);
+int adf_send_admin_tl_start(struct adf_accel_dev *accel_dev,
+			    dma_addr_t tl_dma_addr, size_t layout_sz, u8 *rp_indexes,
+			    struct icp_qat_fw_init_admin_slice_cnt *slice_count);
+int adf_send_admin_tl_stop(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
index cd418b51d9f3..63cf18e2a4e5 100644
--- a/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h
@@ -29,6 +29,8 @@ enum icp_qat_fw_init_admin_cmd_id {
 	ICP_QAT_FW_RL_ADD = 134,
 	ICP_QAT_FW_RL_UPDATE = 135,
 	ICP_QAT_FW_RL_REMOVE = 136,
+	ICP_QAT_FW_TL_START = 137,
+	ICP_QAT_FW_TL_STOP = 138,
 };
 
 enum icp_qat_fw_init_admin_resp_status {
@@ -36,6 +38,13 @@ enum icp_qat_fw_init_admin_resp_status {
 	ICP_QAT_FW_INIT_RESP_STATUS_FAIL
 };
 
+struct icp_qat_fw_init_admin_tl_rp_indexes {
+	__u8 rp_num_index_0;
+	__u8 rp_num_index_1;
+	__u8 rp_num_index_2;
+	__u8 rp_num_index_3;
+};
+
 struct icp_qat_fw_init_admin_slice_cnt {
 	__u8 cpr_cnt;
 	__u8 xlt_cnt;
@@ -87,6 +96,7 @@ struct icp_qat_fw_init_admin_req {
 			__u8 rp_count;
 		};
 		__u32 idle_filter;
+		struct icp_qat_fw_init_admin_tl_rp_indexes rp_indexes;
 	};
 
 	__u32 resrvd4;
-- 
2.41.0


