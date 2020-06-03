Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE71ED50D
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jun 2020 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgFCRfM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 13:35:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:31625 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgFCRfL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 13:35:11 -0400
IronPort-SDR: X2JQjx4pQeBZvrdcIpfQH2kkez6IBCooQMvsGG89iSGBm3WyPTgQ4GPRs1f39UHNIyl6yBq4F4
 wD9t0rf9v+LA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 10:34:11 -0700
IronPort-SDR: 7gSEIM41KAiZvVxQjgiSLrTV7X5RT1zreAc2Wxr63s8FS/ALofzV55FDd/QSF7dMgVoc3eDtJk
 +0ljkMFgL4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="304445567"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2020 10:34:09 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 2/3] crypto: qat - replace user types with kernel ABI __u types
Date:   Wed,  3 Jun 2020 18:33:45 +0100
Message-Id: <20200603173346.96967-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603173346.96967-1-giovanni.cabiddu@intel.com>
References: <20200603173346.96967-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Wojciech Ziemba <wojciech.ziemba@intel.com>

Kernel source code should not contain stdint.h types.
This patch replaces uintXX_t types with kernel space ABI types.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_common/adf_cfg_common.h    |  24 +--
 drivers/crypto/qat/qat_common/adf_cfg_user.h  |  10 +-
 drivers/crypto/qat/qat_common/icp_qat_fw.h    |  58 +++----
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  46 ++---
 drivers/crypto/qat/qat_common/icp_qat_fw_la.h | 158 +++++++++---------
 .../crypto/qat/qat_common/icp_qat_fw_pke.h    |  52 +++---
 drivers/crypto/qat/qat_common/icp_qat_hw.h    |  16 +-
 7 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_cfg_common.h b/drivers/crypto/qat/qat_common/adf_cfg_common.h
index e818033c1012..1ef46ccfba47 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_common.h
@@ -37,16 +37,16 @@ enum adf_device_type {
 
 struct adf_dev_status_info {
 	enum adf_device_type type;
-	u32 accel_id;
-	u32 instance_id;
-	uint8_t num_ae;
-	uint8_t num_accel;
-	uint8_t num_logical_accel;
-	uint8_t banks_per_accel;
-	uint8_t state;
-	uint8_t bus;
-	uint8_t dev;
-	uint8_t fun;
+	__u32 accel_id;
+	__u32 instance_id;
+	__u8 num_ae;
+	__u8 num_accel;
+	__u8 num_logical_accel;
+	__u8 banks_per_accel;
+	__u8 state;
+	__u8 bus;
+	__u8 dev;
+	__u8 fun;
 	char name[MAX_DEVICE_NAME_SIZE];
 };
 
@@ -57,6 +57,6 @@ struct adf_dev_status_info {
 		struct adf_user_cfg_ctl_data)
 #define IOCTL_START_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 2, \
 		struct adf_user_cfg_ctl_data)
-#define IOCTL_STATUS_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 3, uint32_t)
-#define IOCTL_GET_NUM_DEVICES _IOW(ADF_CTL_IOC_MAGIC, 4, int32_t)
+#define IOCTL_STATUS_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 3, __u32)
+#define IOCTL_GET_NUM_DEVICES _IOW(ADF_CTL_IOC_MAGIC, 4, __s32)
 #endif
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_user.h b/drivers/crypto/qat/qat_common/adf_cfg_user.h
index 86b4a3e3f355..421f4fb8b4dd 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_user.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_user.h
@@ -11,7 +11,7 @@ struct adf_user_cfg_key_val {
 	char val[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
 	union {
 		struct adf_user_cfg_key_val *next;
-		uint64_t padding3;
+		__u64 padding3;
 	};
 	enum adf_cfg_val_type type;
 } __packed;
@@ -20,19 +20,19 @@ struct adf_user_cfg_section {
 	char name[ADF_CFG_MAX_SECTION_LEN_IN_BYTES];
 	union {
 		struct adf_user_cfg_key_val *params;
-		uint64_t padding1;
+		__u64 padding1;
 	};
 	union {
 		struct adf_user_cfg_section *next;
-		uint64_t padding3;
+		__u64 padding3;
 	};
 } __packed;
 
 struct adf_user_cfg_ctl_data {
 	union {
 		struct adf_user_cfg_section *config_section;
-		uint64_t padding;
+		__u64 padding;
 	};
-	uint8_t device_id;
+	__u8 device_id;
 } __packed;
 #endif
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw.h b/drivers/crypto/qat/qat_common/icp_qat_fw.h
index 1b9a11f574ee..6dc09d270082 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw.h
@@ -45,41 +45,41 @@ enum icp_qat_fw_comn_request_id {
 struct icp_qat_fw_comn_req_hdr_cd_pars {
 	union {
 		struct {
-			uint64_t content_desc_addr;
-			uint16_t content_desc_resrvd1;
-			uint8_t content_desc_params_sz;
-			uint8_t content_desc_hdr_resrvd2;
-			uint32_t content_desc_resrvd3;
+			__u64 content_desc_addr;
+			__u16 content_desc_resrvd1;
+			__u8 content_desc_params_sz;
+			__u8 content_desc_hdr_resrvd2;
+			__u32 content_desc_resrvd3;
 		} s;
 		struct {
-			uint32_t serv_specif_fields[4];
+			__u32 serv_specif_fields[4];
 		} s1;
 	} u;
 };
 
 struct icp_qat_fw_comn_req_mid {
-	uint64_t opaque_data;
-	uint64_t src_data_addr;
-	uint64_t dest_data_addr;
-	uint32_t src_length;
-	uint32_t dst_length;
+	__u64 opaque_data;
+	__u64 src_data_addr;
+	__u64 dest_data_addr;
+	__u32 src_length;
+	__u32 dst_length;
 };
 
 struct icp_qat_fw_comn_req_cd_ctrl {
-	uint32_t content_desc_ctrl_lw[ICP_QAT_FW_NUM_LONGWORDS_5];
+	__u32 content_desc_ctrl_lw[ICP_QAT_FW_NUM_LONGWORDS_5];
 };
 
 struct icp_qat_fw_comn_req_hdr {
-	uint8_t resrvd1;
-	uint8_t service_cmd_id;
-	uint8_t service_type;
-	uint8_t hdr_flags;
-	uint16_t serv_specif_flags;
-	uint16_t comn_req_flags;
+	__u8 resrvd1;
+	__u8 service_cmd_id;
+	__u8 service_type;
+	__u8 hdr_flags;
+	__u16 serv_specif_flags;
+	__u16 comn_req_flags;
 };
 
 struct icp_qat_fw_comn_req_rqpars {
-	uint32_t serv_specif_rqpars_lw[ICP_QAT_FW_NUM_LONGWORDS_13];
+	__u32 serv_specif_rqpars_lw[ICP_QAT_FW_NUM_LONGWORDS_13];
 };
 
 struct icp_qat_fw_comn_req {
@@ -91,24 +91,24 @@ struct icp_qat_fw_comn_req {
 };
 
 struct icp_qat_fw_comn_error {
-	uint8_t xlat_err_code;
-	uint8_t cmp_err_code;
+	__u8 xlat_err_code;
+	__u8 cmp_err_code;
 };
 
 struct icp_qat_fw_comn_resp_hdr {
-	uint8_t resrvd1;
-	uint8_t service_id;
-	uint8_t response_type;
-	uint8_t hdr_flags;
+	__u8 resrvd1;
+	__u8 service_id;
+	__u8 response_type;
+	__u8 hdr_flags;
 	struct icp_qat_fw_comn_error comn_error;
-	uint8_t comn_status;
-	uint8_t cmd_id;
+	__u8 comn_status;
+	__u8 cmd_id;
 };
 
 struct icp_qat_fw_comn_resp {
 	struct icp_qat_fw_comn_resp_hdr comn_hdr;
-	uint64_t opaque_data;
-	uint32_t resrvd[ICP_QAT_FW_NUM_LONGWORDS_4];
+	__u64 opaque_data;
+	__u32 resrvd[ICP_QAT_FW_NUM_LONGWORDS_4];
 };
 
 #define ICP_QAT_FW_COMN_REQ_FLAG_SET 1
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
index 2024babd7fc7..c867e9a0a540 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
@@ -23,35 +23,35 @@ enum icp_qat_fw_init_admin_resp_status {
 };
 
 struct icp_qat_fw_init_admin_req {
-	uint16_t init_cfg_sz;
-	uint8_t resrvd1;
-	uint8_t init_admin_cmd_id;
-	uint32_t resrvd2;
-	uint64_t opaque_data;
-	uint64_t init_cfg_ptr;
-	uint64_t resrvd3;
+	__u16 init_cfg_sz;
+	__u8 resrvd1;
+	__u8 init_admin_cmd_id;
+	__u32 resrvd2;
+	__u64 opaque_data;
+	__u64 init_cfg_ptr;
+	__u64 resrvd3;
 };
 
 struct icp_qat_fw_init_admin_resp_hdr {
-	uint8_t flags;
-	uint8_t resrvd1;
-	uint8_t status;
-	uint8_t init_admin_cmd_id;
+	__u8 flags;
+	__u8 resrvd1;
+	__u8 status;
+	__u8 init_admin_cmd_id;
 };
 
 struct icp_qat_fw_init_admin_resp_pars {
 	union {
-		uint32_t resrvd1[ICP_QAT_FW_NUM_LONGWORDS_4];
+		__u32 resrvd1[ICP_QAT_FW_NUM_LONGWORDS_4];
 		struct {
-			uint32_t version_patch_num;
-			uint8_t context_id;
-			uint8_t ae_id;
-			uint16_t resrvd1;
-			uint64_t resrvd2;
+			__u32 version_patch_num;
+			__u8 context_id;
+			__u8 ae_id;
+			__u16 resrvd1;
+			__u64 resrvd2;
 		} s1;
 		struct {
-			uint64_t req_rec_count;
-			uint64_t resp_sent_count;
+			__u64 req_rec_count;
+			__u64 resp_sent_count;
 		} s2;
 	} u;
 };
@@ -59,13 +59,13 @@ struct icp_qat_fw_init_admin_resp_pars {
 struct icp_qat_fw_init_admin_resp {
 	struct icp_qat_fw_init_admin_resp_hdr init_resp_hdr;
 	union {
-		uint32_t resrvd2;
+		__u32 resrvd2;
 		struct {
-			uint16_t version_minor_num;
-			uint16_t version_major_num;
+			__u16 version_minor_num;
+			__u16 version_major_num;
 		} s;
 	} u;
-	uint64_t opaque_data;
+	__u64 opaque_data;
 	struct icp_qat_fw_init_admin_resp_pars init_resp_pars;
 };
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_la.h b/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
index ee0a0c944b31..6757ec09d81f 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
@@ -182,14 +182,14 @@ struct icp_qat_fw_la_bulk_req {
 struct icp_qat_fw_cipher_req_hdr_cd_pars {
 	union {
 		struct {
-			uint64_t content_desc_addr;
-			uint16_t content_desc_resrvd1;
-			uint8_t content_desc_params_sz;
-			uint8_t content_desc_hdr_resrvd2;
-			uint32_t content_desc_resrvd3;
+			__u64 content_desc_addr;
+			__u16 content_desc_resrvd1;
+			__u8 content_desc_params_sz;
+			__u8 content_desc_hdr_resrvd2;
+			__u32 content_desc_resrvd3;
 		} s;
 		struct {
-			uint32_t cipher_key_array[ICP_QAT_FW_NUM_LONGWORDS_4];
+			__u32 cipher_key_array[ICP_QAT_FW_NUM_LONGWORDS_4];
 		} s1;
 	} u;
 };
@@ -197,70 +197,70 @@ struct icp_qat_fw_cipher_req_hdr_cd_pars {
 struct icp_qat_fw_cipher_auth_req_hdr_cd_pars {
 	union {
 		struct {
-			uint64_t content_desc_addr;
-			uint16_t content_desc_resrvd1;
-			uint8_t content_desc_params_sz;
-			uint8_t content_desc_hdr_resrvd2;
-			uint32_t content_desc_resrvd3;
+			__u64 content_desc_addr;
+			__u16 content_desc_resrvd1;
+			__u8 content_desc_params_sz;
+			__u8 content_desc_hdr_resrvd2;
+			__u32 content_desc_resrvd3;
 		} s;
 		struct {
-			uint32_t cipher_key_array[ICP_QAT_FW_NUM_LONGWORDS_4];
+			__u32 cipher_key_array[ICP_QAT_FW_NUM_LONGWORDS_4];
 		} sl;
 	} u;
 };
 
 struct icp_qat_fw_cipher_cd_ctrl_hdr {
-	uint8_t cipher_state_sz;
-	uint8_t cipher_key_sz;
-	uint8_t cipher_cfg_offset;
-	uint8_t next_curr_id;
-	uint8_t cipher_padding_sz;
-	uint8_t resrvd1;
-	uint16_t resrvd2;
-	uint32_t resrvd3[ICP_QAT_FW_NUM_LONGWORDS_3];
+	__u8 cipher_state_sz;
+	__u8 cipher_key_sz;
+	__u8 cipher_cfg_offset;
+	__u8 next_curr_id;
+	__u8 cipher_padding_sz;
+	__u8 resrvd1;
+	__u16 resrvd2;
+	__u32 resrvd3[ICP_QAT_FW_NUM_LONGWORDS_3];
 };
 
 struct icp_qat_fw_auth_cd_ctrl_hdr {
-	uint32_t resrvd1;
-	uint8_t resrvd2;
-	uint8_t hash_flags;
-	uint8_t hash_cfg_offset;
-	uint8_t next_curr_id;
-	uint8_t resrvd3;
-	uint8_t outer_prefix_sz;
-	uint8_t final_sz;
-	uint8_t inner_res_sz;
-	uint8_t resrvd4;
-	uint8_t inner_state1_sz;
-	uint8_t inner_state2_offset;
-	uint8_t inner_state2_sz;
-	uint8_t outer_config_offset;
-	uint8_t outer_state1_sz;
-	uint8_t outer_res_sz;
-	uint8_t outer_prefix_offset;
+	__u32 resrvd1;
+	__u8 resrvd2;
+	__u8 hash_flags;
+	__u8 hash_cfg_offset;
+	__u8 next_curr_id;
+	__u8 resrvd3;
+	__u8 outer_prefix_sz;
+	__u8 final_sz;
+	__u8 inner_res_sz;
+	__u8 resrvd4;
+	__u8 inner_state1_sz;
+	__u8 inner_state2_offset;
+	__u8 inner_state2_sz;
+	__u8 outer_config_offset;
+	__u8 outer_state1_sz;
+	__u8 outer_res_sz;
+	__u8 outer_prefix_offset;
 };
 
 struct icp_qat_fw_cipher_auth_cd_ctrl_hdr {
-	uint8_t cipher_state_sz;
-	uint8_t cipher_key_sz;
-	uint8_t cipher_cfg_offset;
-	uint8_t next_curr_id_cipher;
-	uint8_t cipher_padding_sz;
-	uint8_t hash_flags;
-	uint8_t hash_cfg_offset;
-	uint8_t next_curr_id_auth;
-	uint8_t resrvd1;
-	uint8_t outer_prefix_sz;
-	uint8_t final_sz;
-	uint8_t inner_res_sz;
-	uint8_t resrvd2;
-	uint8_t inner_state1_sz;
-	uint8_t inner_state2_offset;
-	uint8_t inner_state2_sz;
-	uint8_t outer_config_offset;
-	uint8_t outer_state1_sz;
-	uint8_t outer_res_sz;
-	uint8_t outer_prefix_offset;
+	__u8 cipher_state_sz;
+	__u8 cipher_key_sz;
+	__u8 cipher_cfg_offset;
+	__u8 next_curr_id_cipher;
+	__u8 cipher_padding_sz;
+	__u8 hash_flags;
+	__u8 hash_cfg_offset;
+	__u8 next_curr_id_auth;
+	__u8 resrvd1;
+	__u8 outer_prefix_sz;
+	__u8 final_sz;
+	__u8 inner_res_sz;
+	__u8 resrvd2;
+	__u8 inner_state1_sz;
+	__u8 inner_state2_offset;
+	__u8 inner_state2_sz;
+	__u8 outer_config_offset;
+	__u8 outer_state1_sz;
+	__u8 outer_res_sz;
+	__u8 outer_prefix_offset;
 };
 
 #define ICP_QAT_FW_AUTH_HDR_FLAG_DO_NESTED 1
@@ -271,48 +271,48 @@ struct icp_qat_fw_cipher_auth_cd_ctrl_hdr {
 #define ICP_QAT_FW_CIPHER_REQUEST_PARAMETERS_OFFSET (0)
 
 struct icp_qat_fw_la_cipher_req_params {
-	uint32_t cipher_offset;
-	uint32_t cipher_length;
+	__u32 cipher_offset;
+	__u32 cipher_length;
 	union {
-		uint32_t cipher_IV_array[ICP_QAT_FW_NUM_LONGWORDS_4];
+		__u32 cipher_IV_array[ICP_QAT_FW_NUM_LONGWORDS_4];
 		struct {
-			uint64_t cipher_IV_ptr;
-			uint64_t resrvd1;
+			__u64 cipher_IV_ptr;
+			__u64 resrvd1;
 		} s;
 	} u;
 };
 
 struct icp_qat_fw_la_auth_req_params {
-	uint32_t auth_off;
-	uint32_t auth_len;
+	__u32 auth_off;
+	__u32 auth_len;
 	union {
-		uint64_t auth_partial_st_prefix;
-		uint64_t aad_adr;
+		__u64 auth_partial_st_prefix;
+		__u64 aad_adr;
 	} u1;
-	uint64_t auth_res_addr;
+	__u64 auth_res_addr;
 	union {
-		uint8_t inner_prefix_sz;
-		uint8_t aad_sz;
+		__u8 inner_prefix_sz;
+		__u8 aad_sz;
 	} u2;
-	uint8_t resrvd1;
-	uint8_t hash_state_sz;
-	uint8_t auth_res_sz;
+	__u8 resrvd1;
+	__u8 hash_state_sz;
+	__u8 auth_res_sz;
 } __packed;
 
 struct icp_qat_fw_la_auth_req_params_resrvd_flds {
-	uint32_t resrvd[ICP_QAT_FW_NUM_LONGWORDS_6];
+	__u32 resrvd[ICP_QAT_FW_NUM_LONGWORDS_6];
 	union {
-		uint8_t inner_prefix_sz;
-		uint8_t aad_sz;
+		__u8 inner_prefix_sz;
+		__u8 aad_sz;
 	} u2;
-	uint8_t resrvd1;
-	uint16_t resrvd2;
+	__u8 resrvd1;
+	__u16 resrvd2;
 };
 
 struct icp_qat_fw_la_resp {
 	struct icp_qat_fw_comn_resp_hdr comn_resp;
-	uint64_t opaque_data;
-	uint32_t resrvd[ICP_QAT_FW_NUM_LONGWORDS_4];
+	__u64 opaque_data;
+	__u32 resrvd[ICP_QAT_FW_NUM_LONGWORDS_4];
 };
 
 #define ICP_QAT_FW_CIPHER_NEXT_ID_GET(cd_ctrl_hdr_t) \
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h b/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
index 4354a68de327..9dddae0009fc 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
@@ -6,51 +6,51 @@
 #include "icp_qat_fw.h"
 
 struct icp_qat_fw_req_hdr_pke_cd_pars {
-	u64 content_desc_addr;
-	u32 content_desc_resrvd;
-	u32 func_id;
+	__u64 content_desc_addr;
+	__u32 content_desc_resrvd;
+	__u32 func_id;
 };
 
 struct icp_qat_fw_req_pke_mid {
-	u64 opaque;
-	u64 src_data_addr;
-	u64 dest_data_addr;
+	__u64 opaque;
+	__u64 src_data_addr;
+	__u64 dest_data_addr;
 };
 
 struct icp_qat_fw_req_pke_hdr {
-	u8 resrvd1;
-	u8 resrvd2;
-	u8 service_type;
-	u8 hdr_flags;
-	u16 comn_req_flags;
-	u16 resrvd4;
+	__u8 resrvd1;
+	__u8 resrvd2;
+	__u8 service_type;
+	__u8 hdr_flags;
+	__u16 comn_req_flags;
+	__u16 resrvd4;
 	struct icp_qat_fw_req_hdr_pke_cd_pars cd_pars;
 };
 
 struct icp_qat_fw_pke_request {
 	struct icp_qat_fw_req_pke_hdr pke_hdr;
 	struct icp_qat_fw_req_pke_mid pke_mid;
-	u8 output_param_count;
-	u8 input_param_count;
-	u16 resrvd1;
-	u32 resrvd2;
-	u64 next_req_adr;
+	__u8 output_param_count;
+	__u8 input_param_count;
+	__u16 resrvd1;
+	__u32 resrvd2;
+	__u64 next_req_adr;
 };
 
 struct icp_qat_fw_resp_pke_hdr {
-	u8 resrvd1;
-	u8 resrvd2;
-	u8 response_type;
-	u8 hdr_flags;
-	u16 comn_resp_flags;
-	u16 resrvd4;
+	__u8 resrvd1;
+	__u8 resrvd2;
+	__u8 response_type;
+	__u8 hdr_flags;
+	__u16 comn_resp_flags;
+	__u16 resrvd4;
 };
 
 struct icp_qat_fw_pke_resp {
 	struct icp_qat_fw_resp_pke_hdr pke_resp_hdr;
-	u64 opaque;
-	u64 src_data_addr;
-	u64 dest_data_addr;
+	__u64 opaque;
+	__u64 src_data_addr;
+	__u64 dest_data_addr;
 };
 
 #define ICP_QAT_FW_PKE_HDR_VALID_FLAG_BITPOS              7
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw.h b/drivers/crypto/qat/qat_common/icp_qat_hw.h
index 1f1e7465f3c1..c4b6ef1506ab 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hw.h
@@ -61,8 +61,8 @@ enum icp_qat_hw_auth_mode {
 };
 
 struct icp_qat_hw_auth_config {
-	uint32_t config;
-	uint32_t reserved;
+	__u32 config;
+	__u32 reserved;
 };
 
 #define QAT_AUTH_MODE_BITPOS 4
@@ -87,7 +87,7 @@ struct icp_qat_hw_auth_config {
 
 struct icp_qat_hw_auth_counter {
 	__be32 counter;
-	uint32_t reserved;
+	__u32 reserved;
 };
 
 #define QAT_AUTH_COUNT_MASK 0xFFFFFFFF
@@ -147,9 +147,9 @@ struct icp_qat_hw_auth_setup {
 
 struct icp_qat_hw_auth_sha512 {
 	struct icp_qat_hw_auth_setup inner_setup;
-	uint8_t state1[ICP_QAT_HW_SHA512_STATE1_SZ];
+	__u8 state1[ICP_QAT_HW_SHA512_STATE1_SZ];
 	struct icp_qat_hw_auth_setup outer_setup;
-	uint8_t state2[ICP_QAT_HW_SHA512_STATE2_SZ];
+	__u8 state2[ICP_QAT_HW_SHA512_STATE2_SZ];
 };
 
 struct icp_qat_hw_auth_algo_blk {
@@ -183,8 +183,8 @@ enum icp_qat_hw_cipher_mode {
 };
 
 struct icp_qat_hw_cipher_config {
-	uint32_t val;
-	uint32_t reserved;
+	__u32 val;
+	__u32 reserved;
 };
 
 enum icp_qat_hw_cipher_dir {
@@ -252,7 +252,7 @@ enum icp_qat_hw_cipher_convert {
 
 struct icp_qat_hw_cipher_aes256_f8 {
 	struct icp_qat_hw_cipher_config cipher_config;
-	uint8_t key[ICP_QAT_HW_AES_256_F8_KEY_SZ];
+	__u8 key[ICP_QAT_HW_AES_256_F8_KEY_SZ];
 };
 
 struct icp_qat_hw_cipher_algo_blk {
-- 
2.26.2

