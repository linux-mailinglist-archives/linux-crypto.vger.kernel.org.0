Return-Path: <linux-crypto+bounces-12534-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C493AAA4A2F
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4ED9A31D3
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Apr 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9425A633;
	Wed, 30 Apr 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpy3p/QD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978E25A355
	for <linux-crypto@vger.kernel.org>; Wed, 30 Apr 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012910; cv=none; b=FgnifKBdd102PrCEB6Sv5/oIWODiyUt3jiQAQsGNDEfmWmqKAK7sKTFnt18KGVfSB694RtQ09MMA8ZOiTkRcVGquS2VtcCDN1wp6WI0KnB8IYonLTI/LJhEFqjO9VOaPC5BnRCX9qCwW8F4VAyRBaw9HCAxTW1PkhinCexO7P7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012910; c=relaxed/simple;
	bh=+hpRPTENswjPEWZEBdz7N9UjqWVhA28A6MWXxWBWots=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpNIos9mMUeJZ4ew9HsokF29ReGdGY2M1cUpDQuTnAxMKpjr+xoo3FibpQEBfVqncB8VprkBTRQ2Y4KGr4h3lPPla22DF6mbUg4jr0oEEVnGu0fsth9DjNGTn9bbxVkVvUuoyKnmnazhNqg9KT58qCuKhSiG+f5AsDjAb+6YH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpy3p/QD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746012908; x=1777548908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hpRPTENswjPEWZEBdz7N9UjqWVhA28A6MWXxWBWots=;
  b=Xpy3p/QDG5XVMVCJWW3mRGg2mMUJ51hmfo9qiBMFjLNA7c2dOvlIgXql
   wiW7et4LpWQL+p+Yw/iCBfrgFIbsNREksu04jJL2PhTPbLUSVFbmqq2mh
   jm3ASVy9NemLCn0KvAo6rtzT3SSovAJ5DZl43v18hgKe21eKAaCtkhkTZ
   HVY9o8bjERvvfbhWBXBLIscIs2c8A7IKnqPa28DnDGTpLI559iwlkg9X4
   UmfdpBSM5Os/npLxd8WC6Nc3CSzyrf4/8TGyCWAuifTdIFS9s5hVlPoby
   ZTxQStMIDGvLGJvjUa7VVp0Rnd24r1RzL79zEYCo++2rvcj2SOhVOcYCG
   Q==;
X-CSE-ConnectionGUID: Nw7tma2hQ6+8JxUKZgGG/g==
X-CSE-MsgGUID: JkVq2mpDQ2WbysjmI4ucEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51331137"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51331137"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 04:35:08 -0700
X-CSE-ConnectionGUID: aeWfzo9WSK+aPa2Atrzu0w==
X-CSE-MsgGUID: rySMgTLCSEm1d4OYPhjHDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="133812528"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by orviesa009.jf.intel.com with ESMTP; 30 Apr 2025 04:35:06 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 03/11] crypto: qat - use pr_fmt() in qat uclo.c
Date: Wed, 30 Apr 2025 12:34:45 +0100
Message-Id: <20250430113453.1587497-4-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
References: <20250430113453.1587497-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pr_fmt() to qat uclo.c logging and update the debug and error messages
to utilize it accordingly.

This does not introduce any functional changes.

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../crypto/intel/qat/qat_common/qat_uclo.c    | 135 +++++++++---------
 1 file changed, 65 insertions(+), 70 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index 620300e70238..9dc26f5d2d01 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2014 - 2020 Intel Corporation */
+
+#define pr_fmt(fmt)	"QAT: " fmt
+
 #include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
@@ -60,7 +63,7 @@ static int qat_uclo_free_ae_data(struct icp_qat_uclo_aedata *ae_data)
 	unsigned int i;
 
 	if (!ae_data) {
-		pr_err("QAT: bad argument, ae_data is NULL\n");
+		pr_err("bad argument, ae_data is NULL\n");
 		return -EINVAL;
 	}
 
@@ -87,12 +90,11 @@ static int qat_uclo_check_uof_format(struct icp_qat_uof_filehdr *hdr)
 	int min = hdr->min_ver & 0xff;
 
 	if (hdr->file_id != ICP_QAT_UOF_FID) {
-		pr_err("QAT: Invalid header 0x%x\n", hdr->file_id);
+		pr_err("Invalid header 0x%x\n", hdr->file_id);
 		return -EINVAL;
 	}
 	if (min != ICP_QAT_UOF_MINVER || maj != ICP_QAT_UOF_MAJVER) {
-		pr_err("QAT: bad UOF version, major 0x%x, minor 0x%x\n",
-		       maj, min);
+		pr_err("bad UOF version, major 0x%x, minor 0x%x\n", maj, min);
 		return -EINVAL;
 	}
 	return 0;
@@ -104,20 +106,19 @@ static int qat_uclo_check_suof_format(struct icp_qat_suof_filehdr *suof_hdr)
 	int min = suof_hdr->min_ver & 0xff;
 
 	if (suof_hdr->file_id != ICP_QAT_SUOF_FID) {
-		pr_err("QAT: invalid header 0x%x\n", suof_hdr->file_id);
+		pr_err("invalid header 0x%x\n", suof_hdr->file_id);
 		return -EINVAL;
 	}
 	if (suof_hdr->fw_type != 0) {
-		pr_err("QAT: unsupported firmware type\n");
+		pr_err("unsupported firmware type\n");
 		return -EINVAL;
 	}
 	if (suof_hdr->num_chunks <= 0x1) {
-		pr_err("QAT: SUOF chunk amount is incorrect\n");
+		pr_err("SUOF chunk amount is incorrect\n");
 		return -EINVAL;
 	}
 	if (maj != ICP_QAT_SUOF_MAJVER || min != ICP_QAT_SUOF_MINVER) {
-		pr_err("QAT: bad SUOF version, major 0x%x, minor 0x%x\n",
-		       maj, min);
+		pr_err("bad SUOF version, major 0x%x, minor 0x%x\n", maj, min);
 		return -EINVAL;
 	}
 	return 0;
@@ -224,24 +225,24 @@ static int qat_uclo_fetch_initmem_ae(struct icp_qat_fw_loader_handle *handle,
 	char *str;
 
 	if ((init_mem->addr + init_mem->num_in_bytes) > (size_range << 0x2)) {
-		pr_err("QAT: initmem is out of range");
+		pr_err("initmem is out of range");
 		return -EINVAL;
 	}
 	if (init_mem->scope != ICP_QAT_UOF_LOCAL_SCOPE) {
-		pr_err("QAT: Memory scope for init_mem error\n");
+		pr_err("Memory scope for init_mem error\n");
 		return -EINVAL;
 	}
 	str = qat_uclo_get_string(&obj_handle->str_table, init_mem->sym_name);
 	if (!str) {
-		pr_err("QAT: AE name assigned in UOF init table is NULL\n");
+		pr_err("AE name assigned in UOF init table is NULL\n");
 		return -EINVAL;
 	}
 	if (qat_uclo_parse_num(str, ae)) {
-		pr_err("QAT: Parse num for AE number failed\n");
+		pr_err("Parse num for AE number failed\n");
 		return -EINVAL;
 	}
 	if (*ae >= ICP_QAT_UCLO_MAX_AE) {
-		pr_err("QAT: ae %d out of range\n", *ae);
+		pr_err("ae %d out of range\n", *ae);
 		return -EINVAL;
 	}
 	return 0;
@@ -357,8 +358,7 @@ static int qat_uclo_init_ae_memory(struct icp_qat_fw_loader_handle *handle,
 			return -EINVAL;
 		break;
 	default:
-		pr_err("QAT: initmem region error. region type=0x%x\n",
-		       init_mem->region);
+		pr_err("initmem region error. region type=0x%x\n", init_mem->region);
 		return -EINVAL;
 	}
 	return 0;
@@ -432,7 +432,7 @@ static int qat_uclo_init_memory(struct icp_qat_fw_loader_handle *handle)
 	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		if (qat_hal_batch_wr_lm(handle, ae,
 					obj_handle->lm_init_tab[ae])) {
-			pr_err("QAT: fail to batch init lmem for AE %d\n", ae);
+			pr_err("fail to batch init lmem for AE %d\n", ae);
 			return -EINVAL;
 		}
 		qat_uclo_cleanup_batch_init_list(handle,
@@ -540,26 +540,26 @@ qat_uclo_check_image_compat(struct icp_qat_uof_encap_obj *encap_uof_obj,
 		       code_page->imp_expr_tab_offset);
 	if (uc_var_tab->entry_num || imp_var_tab->entry_num ||
 	    imp_expr_tab->entry_num) {
-		pr_err("QAT: UOF can't contain imported variable to be parsed\n");
+		pr_err("UOF can't contain imported variable to be parsed\n");
 		return -EINVAL;
 	}
 	neigh_reg_tab = (struct icp_qat_uof_objtable *)
 			(encap_uof_obj->beg_uof +
 			code_page->neigh_reg_tab_offset);
 	if (neigh_reg_tab->entry_num) {
-		pr_err("QAT: UOF can't contain neighbor register table\n");
+		pr_err("UOF can't contain neighbor register table\n");
 		return -EINVAL;
 	}
 	if (image->numpages > 1) {
-		pr_err("QAT: UOF can't contain multiple pages\n");
+		pr_err("UOF can't contain multiple pages\n");
 		return -EINVAL;
 	}
 	if (ICP_QAT_SHARED_USTORE_MODE(image->ae_mode)) {
-		pr_err("QAT: UOF can't use shared control store feature\n");
+		pr_err("UOF can't use shared control store feature\n");
 		return -EFAULT;
 	}
 	if (RELOADABLE_CTX_SHARED_MODE(image->ae_mode)) {
-		pr_err("QAT: UOF can't use reloadable feature\n");
+		pr_err("UOF can't use reloadable feature\n");
 		return -EFAULT;
 	}
 	return 0;
@@ -678,7 +678,7 @@ static int qat_uclo_map_ae(struct icp_qat_fw_loader_handle *handle, int max_ae)
 		}
 	}
 	if (!mflag) {
-		pr_err("QAT: uimage uses AE not set\n");
+		pr_err("uimage uses AE not set\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -738,8 +738,7 @@ qat_uclo_get_dev_type(struct icp_qat_fw_loader_handle *handle)
 	case PCI_DEVICE_ID_INTEL_QAT_420XX:
 		return ICP_QAT_AC_4XXX_A_DEV_TYPE;
 	default:
-		pr_err("QAT: unsupported device 0x%x\n",
-		       handle->pci_dev->device);
+		pr_err("unsupported device 0x%x\n", handle->pci_dev->device);
 		return 0;
 	}
 }
@@ -749,7 +748,7 @@ static int qat_uclo_check_uof_compat(struct icp_qat_uclo_objhandle *obj_handle)
 	unsigned int maj_ver, prod_type = obj_handle->prod_type;
 
 	if (!(prod_type & obj_handle->encap_uof_obj.obj_hdr->ac_dev_type)) {
-		pr_err("QAT: UOF type 0x%x doesn't match with platform 0x%x\n",
+		pr_err("UOF type 0x%x doesn't match with platform 0x%x\n",
 		       obj_handle->encap_uof_obj.obj_hdr->ac_dev_type,
 		       prod_type);
 		return -EINVAL;
@@ -757,7 +756,7 @@ static int qat_uclo_check_uof_compat(struct icp_qat_uclo_objhandle *obj_handle)
 	maj_ver = obj_handle->prod_rev & 0xff;
 	if (obj_handle->encap_uof_obj.obj_hdr->max_cpu_ver < maj_ver ||
 	    obj_handle->encap_uof_obj.obj_hdr->min_cpu_ver > maj_ver) {
-		pr_err("QAT: UOF majVer 0x%x out of range\n", maj_ver);
+		pr_err("UOF majVer 0x%x out of range\n", maj_ver);
 		return -EINVAL;
 	}
 	return 0;
@@ -800,7 +799,7 @@ static int qat_uclo_init_reg(struct icp_qat_fw_loader_handle *handle,
 	case ICP_NEIGH_REL:
 		return qat_hal_init_nn(handle, ae, ctx_mask, reg_addr, value);
 	default:
-		pr_err("QAT: UOF uses not supported reg type 0x%x\n", reg_type);
+		pr_err("UOF uses not supported reg type 0x%x\n", reg_type);
 		return -EFAULT;
 	}
 	return 0;
@@ -836,8 +835,7 @@ static int qat_uclo_init_reg_sym(struct icp_qat_fw_loader_handle *handle,
 		case ICP_QAT_UOF_INIT_REG_CTX:
 			/* check if ctx is appropriate for the ctxMode */
 			if (!((1 << init_regsym->ctx) & ctx_mask)) {
-				pr_err("QAT: invalid ctx num = 0x%x\n",
-				       init_regsym->ctx);
+				pr_err("invalid ctx num = 0x%x\n", init_regsym->ctx);
 				return -EINVAL;
 			}
 			qat_uclo_init_reg(handle, ae,
@@ -849,10 +847,10 @@ static int qat_uclo_init_reg_sym(struct icp_qat_fw_loader_handle *handle,
 					  exp_res);
 			break;
 		case ICP_QAT_UOF_INIT_EXPR:
-			pr_err("QAT: INIT_EXPR feature not supported\n");
+			pr_err("INIT_EXPR feature not supported\n");
 			return -EINVAL;
 		case ICP_QAT_UOF_INIT_EXPR_ENDIAN_SWAP:
-			pr_err("QAT: INIT_EXPR_ENDIAN_SWAP feature not supported\n");
+			pr_err("INIT_EXPR_ENDIAN_SWAP feature not supported\n");
 			return -EINVAL;
 		default:
 			break;
@@ -872,7 +870,7 @@ static int qat_uclo_init_globals(struct icp_qat_fw_loader_handle *handle)
 		return 0;
 	if (obj_handle->init_mem_tab.entry_num) {
 		if (qat_uclo_init_memory(handle)) {
-			pr_err("QAT: initialize memory failed\n");
+			pr_err("initialize memory failed\n");
 			return -EINVAL;
 		}
 	}
@@ -901,40 +899,40 @@ static int qat_hal_set_modes(struct icp_qat_fw_loader_handle *handle,
 	mode = ICP_QAT_CTX_MODE(uof_image->ae_mode);
 	ret = qat_hal_set_ae_ctx_mode(handle, ae, mode);
 	if (ret) {
-		pr_err("QAT: qat_hal_set_ae_ctx_mode error\n");
+		pr_err("qat_hal_set_ae_ctx_mode error\n");
 		return ret;
 	}
 	if (handle->chip_info->nn) {
 		mode = ICP_QAT_NN_MODE(uof_image->ae_mode);
 		ret = qat_hal_set_ae_nn_mode(handle, ae, mode);
 		if (ret) {
-			pr_err("QAT: qat_hal_set_ae_nn_mode error\n");
+			pr_err("qat_hal_set_ae_nn_mode error\n");
 			return ret;
 		}
 	}
 	mode = ICP_QAT_LOC_MEM0_MODE(uof_image->ae_mode);
 	ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM0, mode);
 	if (ret) {
-		pr_err("QAT: qat_hal_set_ae_lm_mode LMEM0 error\n");
+		pr_err("qat_hal_set_ae_lm_mode LMEM0 error\n");
 		return ret;
 	}
 	mode = ICP_QAT_LOC_MEM1_MODE(uof_image->ae_mode);
 	ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM1, mode);
 	if (ret) {
-		pr_err("QAT: qat_hal_set_ae_lm_mode LMEM1 error\n");
+		pr_err("qat_hal_set_ae_lm_mode LMEM1 error\n");
 		return ret;
 	}
 	if (handle->chip_info->lm2lm3) {
 		mode = ICP_QAT_LOC_MEM2_MODE(uof_image->ae_mode);
 		ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM2, mode);
 		if (ret) {
-			pr_err("QAT: qat_hal_set_ae_lm_mode LMEM2 error\n");
+			pr_err("qat_hal_set_ae_lm_mode LMEM2 error\n");
 			return ret;
 		}
 		mode = ICP_QAT_LOC_MEM3_MODE(uof_image->ae_mode);
 		ret = qat_hal_set_ae_lm_mode(handle, ae, ICP_LMEM3, mode);
 		if (ret) {
-			pr_err("QAT: qat_hal_set_ae_lm_mode LMEM3 error\n");
+			pr_err("qat_hal_set_ae_lm_mode LMEM3 error\n");
 			return ret;
 		}
 		mode = ICP_QAT_LOC_TINDEX_MODE(uof_image->ae_mode);
@@ -998,7 +996,7 @@ static int qat_uclo_parse_uof_obj(struct icp_qat_fw_loader_handle *handle)
 	obj_handle->prod_rev = PID_MAJOR_REV |
 			(PID_MINOR_REV & handle->hal_handle->revision_id);
 	if (qat_uclo_check_uof_compat(obj_handle)) {
-		pr_err("QAT: UOF incompatible\n");
+		pr_err("UOF incompatible\n");
 		return -EINVAL;
 	}
 	obj_handle->uword_buf = kcalloc(UWORD_CPYBUF_SIZE, sizeof(u64),
@@ -1009,7 +1007,7 @@ static int qat_uclo_parse_uof_obj(struct icp_qat_fw_loader_handle *handle)
 	if (!obj_handle->obj_hdr->file_buff ||
 	    !qat_uclo_map_str_table(obj_handle->obj_hdr, ICP_QAT_UOF_STRT,
 				    &obj_handle->str_table)) {
-		pr_err("QAT: UOF doesn't have effective images\n");
+		pr_err("UOF doesn't have effective images\n");
 		goto out_err;
 	}
 	obj_handle->uimage_num =
@@ -1018,7 +1016,7 @@ static int qat_uclo_parse_uof_obj(struct icp_qat_fw_loader_handle *handle)
 	if (!obj_handle->uimage_num)
 		goto out_err;
 	if (qat_uclo_map_ae(handle, handle->hal_handle->ae_max_num)) {
-		pr_err("QAT: Bad object\n");
+		pr_err("Bad object\n");
 		goto out_check_uof_aemask_err;
 	}
 	qat_uclo_init_uword_num(handle);
@@ -1051,7 +1049,7 @@ static int qat_uclo_map_suof_file_hdr(struct icp_qat_fw_loader_handle *handle,
 	check_sum = qat_uclo_calc_str_checksum((char *)&suof_ptr->min_ver,
 					       min_ver_offset);
 	if (check_sum != suof_ptr->check_sum) {
-		pr_err("QAT: incorrect SUOF checksum\n");
+		pr_err("incorrect SUOF checksum\n");
 		return -EINVAL;
 	}
 	suof_handle->check_sum = suof_ptr->check_sum;
@@ -1113,14 +1111,13 @@ static int qat_uclo_check_simg_compat(struct icp_qat_fw_loader_handle *handle,
 	prod_rev = PID_MAJOR_REV |
 			 (PID_MINOR_REV & handle->hal_handle->revision_id);
 	if (img_ae_mode->dev_type != prod_type) {
-		pr_err("QAT: incompatible product type %x\n",
-		       img_ae_mode->dev_type);
+		pr_err("incompatible product type %x\n", img_ae_mode->dev_type);
 		return -EINVAL;
 	}
 	maj_ver = prod_rev & 0xff;
 	if (maj_ver > img_ae_mode->devmax_ver ||
 	    maj_ver < img_ae_mode->devmin_ver) {
-		pr_err("QAT: incompatible device majver 0x%x\n", maj_ver);
+		pr_err("incompatible device majver 0x%x\n", maj_ver);
 		return -EINVAL;
 	}
 	return 0;
@@ -1163,7 +1160,7 @@ static int qat_uclo_map_suof(struct icp_qat_fw_loader_handle *handle,
 	struct icp_qat_suof_img_hdr img_header;
 
 	if (!suof_ptr || suof_size == 0) {
-		pr_err("QAT: input parameter SUOF pointer/size is NULL\n");
+		pr_err("input parameter SUOF pointer/size is NULL\n");
 		return -EINVAL;
 	}
 	if (qat_uclo_check_suof_format(suof_ptr))
@@ -1237,7 +1234,7 @@ static int qat_uclo_auth_fw(struct icp_qat_fw_loader_handle *handle,
 				return 0;
 	} while (retry++ < FW_AUTH_MAX_RETRY);
 auth_fail:
-	pr_err("QAT: authentication error (FCU_STATUS = 0x%x),retry = %d\n",
+	pr_err("authentication error (FCU_STATUS = 0x%x),retry = %d\n",
 	       fcu_sts & FCU_AUTH_STS_MASK, retry);
 	return -EINVAL;
 }
@@ -1273,14 +1270,13 @@ static int qat_uclo_broadcast_load_fw(struct icp_qat_fw_loader_handle *handle,
 		fcu_sts_csr = handle->chip_info->fcu_sts_csr;
 		fcu_loaded_csr = handle->chip_info->fcu_loaded_ae_csr;
 	} else {
-		pr_err("Chip 0x%x doesn't support broadcast load\n",
-		       handle->pci_dev->device);
+		pr_err("Chip 0x%x doesn't support broadcast load\n", handle->pci_dev->device);
 		return -EINVAL;
 	}
 
 	for_each_set_bit(ae, &ae_mask, handle->hal_handle->ae_max_num) {
 		if (qat_hal_check_ae_active(handle, (unsigned char)ae)) {
-			pr_err("QAT: Broadcast load failed. AE is not enabled or active.\n");
+			pr_err("Broadcast load failed. AE is not enabled or active.\n");
 			return -EINVAL;
 		}
 
@@ -1312,7 +1308,7 @@ static int qat_uclo_broadcast_load_fw(struct icp_qat_fw_loader_handle *handle,
 		} while (retry++ < FW_AUTH_MAX_RETRY);
 
 		if (retry > FW_AUTH_MAX_RETRY) {
-			pr_err("QAT: broadcast load failed timeout %d\n", retry);
+			pr_err("broadcast load failed timeout %d\n", retry);
 			return -EINVAL;
 		}
 	}
@@ -1397,13 +1393,13 @@ static int qat_uclo_check_image(struct icp_qat_fw_loader_handle *handle,
 		if (size > ICP_QAT_CSS_RSA3K_MAX_IMAGE_LEN)
 			goto err;
 	} else {
-		pr_err("QAT: Unsupported firmware type\n");
+		pr_err("Unsupported firmware type\n");
 		return -EINVAL;
 	}
 	return 0;
 
 err:
-	pr_err("QAT: Invalid %s firmware image\n", fw_type_name);
+	pr_err("Invalid %s firmware image\n", fw_type_name);
 	return -EINVAL;
 }
 
@@ -1422,12 +1418,12 @@ static int qat_uclo_map_auth_fw(struct icp_qat_fw_loader_handle *handle,
 
 	ret = qat_uclo_simg_alloc(handle, &img_desc, ICP_QAT_CSS_RSA4K_MAX_IMAGE_LEN);
 	if (ret) {
-		pr_err("QAT: error, allocate continuous dram fail\n");
+		pr_err("error, allocate continuous dram fail\n");
 		return ret;
 	}
 
 	if (!IS_ALIGNED(img_desc.dram_size, 8) || !img_desc.dram_bus_addr) {
-		pr_debug("QAT: invalid address\n");
+		pr_debug("invalid address\n");
 		qat_uclo_simg_free(handle, &img_desc);
 		return -EINVAL;
 	}
@@ -1489,7 +1485,7 @@ static int qat_uclo_map_auth_fw(struct icp_qat_fw_loader_handle *handle,
 	auth_desc->img_len = size - ICP_QAT_AE_IMG_OFFSET(handle);
 	if (bus_addr + auth_desc->img_len > img_desc.dram_bus_addr +
 					    ICP_QAT_CSS_RSA4K_MAX_IMAGE_LEN) {
-		pr_err("QAT: insufficient memory size for authentication data\n");
+		pr_err("insufficient memory size for authentication data\n");
 		qat_uclo_simg_free(handle, &img_desc);
 		return -ENOMEM;
 	}
@@ -1546,7 +1542,7 @@ static int qat_uclo_load_fw(struct icp_qat_fw_loader_handle *handle,
 		if (!((desc->ae_mask >> i) & 0x1))
 			continue;
 		if (qat_hal_check_ae_active(handle, i)) {
-			pr_err("QAT: AE %d is active\n", i);
+			pr_err("AE %d is active\n", i);
 			return -EINVAL;
 		}
 		SET_CAP_CSR(handle, fcu_ctl_csr,
@@ -1566,7 +1562,7 @@ static int qat_uclo_load_fw(struct icp_qat_fw_loader_handle *handle,
 			}
 		} while (retry++ < FW_AUTH_MAX_RETRY);
 		if (retry > FW_AUTH_MAX_RETRY) {
-			pr_err("QAT: firmware load failed timeout %x\n", retry);
+			pr_err("firmware load failed timeout %x\n", retry);
 			return -EINVAL;
 		}
 	}
@@ -1584,7 +1580,7 @@ static int qat_uclo_map_suof_obj(struct icp_qat_fw_loader_handle *handle,
 	handle->sobj_handle = suof_handle;
 	if (qat_uclo_map_suof(handle, addr_ptr, mem_size)) {
 		qat_uclo_del_suof(handle);
-		pr_err("QAT: map SUOF failed\n");
+		pr_err("map SUOF failed\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1608,7 +1604,7 @@ int qat_uclo_wr_mimage(struct icp_qat_fw_loader_handle *handle,
 		qat_uclo_ummap_auth_fw(handle, &desc);
 	} else {
 		if (handle->chip_info->mmp_sram_size < mem_size) {
-			pr_err("QAT: MMP size is too large: 0x%x\n", mem_size);
+			pr_err("MMP size is too large: 0x%x\n", mem_size);
 			return -EFBIG;
 		}
 		qat_uclo_wr_sram_by_words(handle, 0, addr_ptr, mem_size);
@@ -1634,7 +1630,7 @@ static int qat_uclo_map_uof_obj(struct icp_qat_fw_loader_handle *handle,
 	objhdl->obj_hdr = qat_uclo_map_chunk((char *)objhdl->obj_buf, filehdr,
 					     ICP_QAT_UOF_OBJS);
 	if (!objhdl->obj_hdr) {
-		pr_err("QAT: object file chunk is null\n");
+		pr_err("object file chunk is null\n");
 		goto out_objhdr_err;
 	}
 	handle->obj_handle = objhdl;
@@ -1669,7 +1665,7 @@ static int qat_uclo_map_mof_file_hdr(struct icp_qat_fw_loader_handle *handle,
 	checksum = qat_uclo_calc_str_checksum(&mof_ptr->min_ver,
 					      min_ver_offset);
 	if (checksum != mof_ptr->checksum) {
-		pr_err("QAT: incorrect MOF checksum\n");
+		pr_err("incorrect MOF checksum\n");
 		return -EINVAL;
 	}
 
@@ -1705,7 +1701,7 @@ static int qat_uclo_seek_obj_inside_mof(struct icp_qat_mof_handle *mobj_handle,
 		}
 	}
 
-	pr_err("QAT: object %s is not found inside MOF\n", obj_name);
+	pr_err("object %s is not found inside MOF\n", obj_name);
 	return -EINVAL;
 }
 
@@ -1722,7 +1718,7 @@ static int qat_uclo_map_obj_from_mof(struct icp_qat_mof_handle *mobj_handle,
 			    ICP_QAT_MOF_OBJ_CHUNKID_LEN)) {
 		obj = mobj_handle->sobjs_hdr + obj_chunkhdr->offset;
 	} else {
-		pr_err("QAT: unsupported chunk id\n");
+		pr_err("unsupported chunk id\n");
 		return -EINVAL;
 	}
 	mobj_hdr->obj_buf = obj;
@@ -1783,7 +1779,7 @@ static int qat_uclo_map_objs_from_mof(struct icp_qat_mof_handle *mobj_handle)
 	}
 
 	if ((uobj_chunk_num + sobj_chunk_num) != *valid_chunk) {
-		pr_err("QAT: inconsistent UOF/SUOF chunk amount\n");
+		pr_err("inconsistent UOF/SUOF chunk amount\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -1824,17 +1820,16 @@ static int qat_uclo_check_mof_format(struct icp_qat_mof_file_hdr *mof_hdr)
 	int min = mof_hdr->min_ver & 0xff;
 
 	if (mof_hdr->file_id != ICP_QAT_MOF_FID) {
-		pr_err("QAT: invalid header 0x%x\n", mof_hdr->file_id);
+		pr_err("invalid header 0x%x\n", mof_hdr->file_id);
 		return -EINVAL;
 	}
 
 	if (mof_hdr->num_chunks <= 0x1) {
-		pr_err("QAT: MOF chunk amount is incorrect\n");
+		pr_err("MOF chunk amount is incorrect\n");
 		return -EINVAL;
 	}
 	if (maj != ICP_QAT_MOF_MAJVER || min != ICP_QAT_MOF_MINVER) {
-		pr_err("QAT: bad MOF version, major 0x%x, minor 0x%x\n",
-		       maj, min);
+		pr_err("bad MOF version, major 0x%x, minor 0x%x\n", maj, min);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.40.1


