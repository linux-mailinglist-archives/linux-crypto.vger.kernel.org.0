Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401D2A9558
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 12:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgKFL3H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 06:29:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:59432 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgKFL3G (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 06:29:06 -0500
IronPort-SDR: RAlkdh7OdmpN9S+oIjiXwhKJJCWs8VCc/qVn6dJTA6PQfua+ZnLotMQWIR5D/zum7eJ1rXS59O
 187xQNywlquw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233698319"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="233698319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 03:29:06 -0800
IronPort-SDR: CaqQLylYaIrkm63uiL5WcRTuYQ5SrIg+touVHKUvynEgDKTsGyImrwrVkmmX/nxBYCPErbCc63
 il0egO4JEgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="529779314"
Received: from haps801-neoncity02.sh.intel.com ([10.67.114.160])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2020 03:29:04 -0800
From:   Jack Xu <jack.xu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 19/32] crypto: qat - loader: add support for lm2 and lm3
Date:   Fri,  6 Nov 2020 19:27:57 +0800
Message-Id: <20201106112810.2566-20-jack.xu@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201106112810.2566-1-jack.xu@intel.com>
References: <20201106112810.2566-1-jack.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add support for local memory lm2 and lm3 which is introduced in the next
generation of QAT devices.

Signed-off-by: Jack Xu <jack.xu@intel.com>
Co-developed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_common/adf_common_drv.h    |  2 +
 .../qat/qat_common/icp_qat_fw_loader_handle.h |  1 +
 drivers/crypto/qat/qat_common/icp_qat_hal.h   |  9 +++
 drivers/crypto/qat/qat_common/icp_qat_uclo.h  |  5 ++
 drivers/crypto/qat/qat_common/qat_hal.c       | 70 ++++++++++++++++++-
 drivers/crypto/qat/qat_common/qat_uclo.c      | 16 +++++
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 945608b71937..f4c90c701670 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -178,6 +178,8 @@ int qat_hal_init_nn(struct icp_qat_fw_loader_handle *handle,
 		    unsigned short reg_num, unsigned int regdata);
 int qat_hal_wr_lm(struct icp_qat_fw_loader_handle *handle,
 		  unsigned char ae, unsigned short lm_addr, unsigned int value);
+void qat_hal_set_ae_tindex_mode(struct icp_qat_fw_loader_handle *handle,
+				unsigned char ae, unsigned char mode);
 int qat_uclo_wr_all_uimage(struct icp_qat_fw_loader_handle *handle);
 void qat_uclo_del_obj(struct icp_qat_fw_loader_handle *handle);
 int qat_uclo_wr_mimage(struct icp_qat_fw_loader_handle *handle, void *addr_ptr,
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h b/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
index 8025be597d18..3c587105d09d 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
@@ -25,6 +25,7 @@ struct icp_qat_fw_loader_hal_handle {
 struct icp_qat_fw_loader_chip_info {
 	bool sram_visible;
 	bool nn;
+	bool lm2lm3;
 	bool fw_auth;
 };
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hal.h b/drivers/crypto/qat/qat_common/icp_qat_hal.h
index eff9a3811435..82ac33a4500f 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hal.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hal.h
@@ -26,8 +26,14 @@ enum hal_ae_csr {
 	CTX_WAKEUP_EVENTS_INDIRECT = 0x050,
 	LM_ADDR_0_INDIRECT = 0x060,
 	LM_ADDR_1_INDIRECT = 0x068,
+	LM_ADDR_2_INDIRECT = 0x0cc,
+	LM_ADDR_3_INDIRECT = 0x0d4,
 	INDIRECT_LM_ADDR_0_BYTE_INDEX = 0x0e0,
 	INDIRECT_LM_ADDR_1_BYTE_INDEX = 0x0e8,
+	INDIRECT_LM_ADDR_2_BYTE_INDEX = 0x10c,
+	INDIRECT_LM_ADDR_3_BYTE_INDEX = 0x114,
+	INDIRECT_T_INDEX = 0x0f8,
+	INDIRECT_T_INDEX_BYTE_INDEX = 0x0fc,
 	FUTURE_COUNT_SIGNAL_INDIRECT = 0x078,
 	TIMESTAMP_LOW = 0x0c0,
 	TIMESTAMP_HIGH = 0x0c4,
@@ -68,6 +74,9 @@ enum fcu_sts {
 #define CE_ENABLE_BITPOS            0x8
 #define CE_LMADDR_0_GLOBAL_BITPOS   16
 #define CE_LMADDR_1_GLOBAL_BITPOS   17
+#define CE_LMADDR_2_GLOBAL_BITPOS   22
+#define CE_LMADDR_3_GLOBAL_BITPOS   23
+#define CE_T_INDEX_GLOBAL_BITPOS    21
 #define CE_NN_MODE_BITPOS           20
 #define CE_REG_PAR_ERR_BITPOS       25
 #define CE_BREAKPOINT_BITPOS        27
diff --git a/drivers/crypto/qat/qat_common/icp_qat_uclo.h b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
index 101de1430896..5728a81d9dea 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_uclo.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
@@ -69,6 +69,9 @@
 
 #define ICP_QAT_LOC_MEM0_MODE(ae_mode) (((ae_mode) >> 0x8) & 0x1)
 #define ICP_QAT_LOC_MEM1_MODE(ae_mode) (((ae_mode) >> 0x9) & 0x1)
+#define ICP_QAT_LOC_MEM2_MODE(ae_mode) (((ae_mode) >> 0x6) & 0x1)
+#define ICP_QAT_LOC_MEM3_MODE(ae_mode) (((ae_mode) >> 0x7) & 0x1)
+#define ICP_QAT_LOC_TINDEX_MODE(ae_mode) (((ae_mode) >> 0xe) & 0x1)
 
 enum icp_qat_uof_mem_region {
 	ICP_QAT_UOF_SRAM_REGION = 0x0,
@@ -98,6 +101,8 @@ enum icp_qat_uof_regtype {
 	ICP_LMEM0	= 27,
 	ICP_LMEM1	= 28,
 	ICP_NEIGH_REL	= 31,
+	ICP_LMEM2	= 61,
+	ICP_LMEM3	= 62,
 };
 
 enum icp_qat_css_fwtype {
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/qat/qat_common/qat_hal.c
index e0d0ab43fd12..70fc93f31e79 100644
--- a/drivers/crypto/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/qat/qat_common/qat_hal.c
@@ -210,6 +210,16 @@ int qat_hal_set_ae_lm_mode(struct icp_qat_fw_loader_handle *handle,
 			SET_BIT(csr, CE_LMADDR_1_GLOBAL_BITPOS) :
 			CLR_BIT(csr, CE_LMADDR_1_GLOBAL_BITPOS);
 		break;
+	case ICP_LMEM2:
+		new_csr = (mode) ?
+			SET_BIT(csr, CE_LMADDR_2_GLOBAL_BITPOS) :
+			CLR_BIT(csr, CE_LMADDR_2_GLOBAL_BITPOS);
+		break;
+	case ICP_LMEM3:
+		new_csr = (mode) ?
+			SET_BIT(csr, CE_LMADDR_3_GLOBAL_BITPOS) :
+			CLR_BIT(csr, CE_LMADDR_3_GLOBAL_BITPOS);
+		break;
 	default:
 		pr_err("QAT: lmType = 0x%x\n", lm_type);
 		return -EINVAL;
@@ -220,6 +230,20 @@ int qat_hal_set_ae_lm_mode(struct icp_qat_fw_loader_handle *handle,
 	return 0;
 }
 
+void qat_hal_set_ae_tindex_mode(struct icp_qat_fw_loader_handle *handle,
+				unsigned char ae, unsigned char mode)
+{
+	unsigned int csr, new_csr;
+
+	csr = qat_hal_rd_ae_csr(handle, ae, CTX_ENABLES);
+	csr &= IGNORE_W1C_MASK;
+	new_csr = (mode) ?
+		  SET_BIT(csr, CE_T_INDEX_GLOBAL_BITPOS) :
+		  CLR_BIT(csr, CE_T_INDEX_GLOBAL_BITPOS);
+	if (new_csr != csr)
+		qat_hal_wr_ae_csr(handle, ae, CTX_ENABLES, new_csr);
+}
+
 static unsigned short qat_hal_get_reg_addr(unsigned int type,
 					   unsigned short reg_num)
 {
@@ -259,6 +283,12 @@ static unsigned short qat_hal_get_reg_addr(unsigned int type,
 	case ICP_LMEM1:
 		reg_addr = 0x220;
 		break;
+	case ICP_LMEM2:
+		reg_addr = 0x2c0;
+		break;
+	case ICP_LMEM3:
+		reg_addr = 0x2e0;
+		break;
 	case ICP_NO_DEST:
 		reg_addr = 0x300 | (reg_num & 0xff);
 		break;
@@ -668,11 +698,13 @@ static int qat_hal_chip_init(struct icp_qat_fw_loader_handle *handle,
 	case PCI_DEVICE_ID_INTEL_QAT_C3XXX:
 		handle->chip_info->sram_visible = false;
 		handle->chip_info->nn = true;
+		handle->chip_info->lm2lm3 = false;
 		handle->chip_info->fw_auth = true;
 		break;
 	case PCI_DEVICE_ID_INTEL_QAT_DH895XCC:
 		handle->chip_info->sram_visible = true;
 		handle->chip_info->nn = true;
+		handle->chip_info->lm2lm3 = false;
 		handle->chip_info->fw_auth = false;
 		break;
 	default:
@@ -889,9 +921,12 @@ static int qat_hal_exec_micro_inst(struct icp_qat_fw_loader_handle *handle,
 				   int code_off, unsigned int max_cycle,
 				   unsigned int *endpc)
 {
+	unsigned int ind_lm_addr_byte0 = 0, ind_lm_addr_byte1 = 0;
+	unsigned int ind_lm_addr_byte2 = 0, ind_lm_addr_byte3 = 0;
+	unsigned int ind_t_index = 0, ind_t_index_byte = 0;
+	unsigned int ind_lm_addr0 = 0, ind_lm_addr1 = 0;
+	unsigned int ind_lm_addr2 = 0, ind_lm_addr3 = 0;
 	u64 savuwords[MAX_EXEC_INST];
-	unsigned int ind_lm_addr0, ind_lm_addr1;
-	unsigned int ind_lm_addr_byte0, ind_lm_addr_byte1;
 	unsigned int ind_cnt_sig;
 	unsigned int ind_sig, act_sig;
 	unsigned int csr_val = 0, newcsr_val;
@@ -910,6 +945,20 @@ static int qat_hal_exec_micro_inst(struct icp_qat_fw_loader_handle *handle,
 						INDIRECT_LM_ADDR_0_BYTE_INDEX);
 	ind_lm_addr_byte1 = qat_hal_rd_indr_csr(handle, ae, ctx,
 						INDIRECT_LM_ADDR_1_BYTE_INDEX);
+	if (handle->chip_info->lm2lm3) {
+		ind_lm_addr2 = qat_hal_rd_indr_csr(handle, ae, ctx,
+						   LM_ADDR_2_INDIRECT);
+		ind_lm_addr3 = qat_hal_rd_indr_csr(handle, ae, ctx,
+						   LM_ADDR_3_INDIRECT);
+		ind_lm_addr_byte2 = qat_hal_rd_indr_csr(handle, ae, ctx,
+							INDIRECT_LM_ADDR_2_BYTE_INDEX);
+		ind_lm_addr_byte3 = qat_hal_rd_indr_csr(handle, ae, ctx,
+							INDIRECT_LM_ADDR_3_BYTE_INDEX);
+		ind_t_index = qat_hal_rd_indr_csr(handle, ae, ctx,
+						  INDIRECT_T_INDEX);
+		ind_t_index_byte = qat_hal_rd_indr_csr(handle, ae, ctx,
+						       INDIRECT_T_INDEX_BYTE_INDEX);
+	}
 	if (inst_num <= MAX_EXEC_INST)
 		qat_hal_get_uwords(handle, ae, 0, inst_num, savuwords);
 	qat_hal_get_wakeup_event(handle, ae, ctx, &wakeup_events);
@@ -967,6 +1016,23 @@ static int qat_hal_exec_micro_inst(struct icp_qat_fw_loader_handle *handle,
 			    INDIRECT_LM_ADDR_0_BYTE_INDEX, ind_lm_addr_byte0);
 	qat_hal_wr_indr_csr(handle, ae, (1 << ctx),
 			    INDIRECT_LM_ADDR_1_BYTE_INDEX, ind_lm_addr_byte1);
+	if (handle->chip_info->lm2lm3) {
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx), LM_ADDR_2_INDIRECT,
+				    ind_lm_addr2);
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx), LM_ADDR_3_INDIRECT,
+				    ind_lm_addr3);
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx),
+				    INDIRECT_LM_ADDR_2_BYTE_INDEX,
+				    ind_lm_addr_byte2);
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx),
+				    INDIRECT_LM_ADDR_3_BYTE_INDEX,
+				    ind_lm_addr_byte3);
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx),
+				    INDIRECT_T_INDEX, ind_t_index);
+		qat_hal_wr_indr_csr(handle, ae, BIT(ctx),
+				    INDIRECT_T_INDEX_BYTE_INDEX,
+				    ind_t_index_byte);
+	}
 	qat_hal_wr_indr_csr(handle, ae, (1 << ctx),
 			    FUTURE_COUNT_SIGNAL_INDIRECT, ind_cnt_sig);
 	qat_hal_wr_indr_csr(handle, ae, (1 << ctx),
diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
index fce075874962..4a90b150199c 100644
--- a/drivers/crypto/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/qat/qat_common/qat_uclo.c
@@ -904,6 +904,22 @@ static int qat_hal_set_modes(struct icp_qat_fw_loader_handle *handle,
 		pr_err("QAT: qat_hal_set_ae_lm_mode LMEM1 error\n");
 		return ret;
 	}
+	if (handle->chip_info->lm2lm3) {
+		mode = ICP_QAT_LOC_MEM2_MODE(uof_image->ae_mode);
+		ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM2, mode);
+		if (ret) {
+			pr_err("QAT: qat_hal_set_ae_lm_mode LMEM2 error\n");
+			return ret;
+		}
+		mode = ICP_QAT_LOC_MEM3_MODE(uof_image->ae_mode);
+		ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM3, mode);
+		if (ret) {
+			pr_err("QAT: qat_hal_set_ae_lm_mode LMEM3 error\n");
+			return ret;
+		}
+		mode = ICP_QAT_LOC_TINDEX_MODE(uof_image->ae_mode);
+		qat_hal_set_ae_tindex_mode(handle, ae, mode);
+	}
 	return 0;
 }
 
-- 
2.25.4

