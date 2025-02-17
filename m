Return-Path: <linux-crypto+bounces-9777-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA0A36394
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Feb 2025 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340FF7A61A4
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Feb 2025 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1326772C;
	Fri, 14 Feb 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhPRJP1q"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF06267700
	for <linux-crypto@vger.kernel.org>; Fri, 14 Feb 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551814; cv=none; b=tQQJV8loLYy2SWee/Z0YJV1Nsr1fUqRyONeCYV/MxB6E24GQh0prW37Oxo3jqWsS2NiBjEFG2d3wWpdhrLaPGY9+GWFbGv89BI0B5X1m8csvMIMvkoNqdn67FDFWdLHnj6Ka9vcX38KeDGJ1nq7oeT7GPjDrrFQrhhcD2frjTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551814; c=relaxed/simple;
	bh=C4GgdCdyYdlET6LgM7jT8IbnqDhEDqvqz6+db2CuaKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhJbonS0YMAPDcrruFqvnU9SxyBNJrCBanQxXQF9mTbhZIt/MgYxEAKAhl2F8WkCSco2hoBAo5dO1TjKjsjgjgFJqpVi+qkgcp+myLyzd0SpQMtb/T4TPLmpHw2NKKLJIC8in4zGPe2vN0TID9t5nFuV3XGreo+s7EK76Sa5sPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhPRJP1q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739551813; x=1771087813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4GgdCdyYdlET6LgM7jT8IbnqDhEDqvqz6+db2CuaKI=;
  b=OhPRJP1qqE1XRFbidsBa+BhUfFYqEFe81tRBvJJFKMvz9rXyMBOuhqw7
   0OsxKJDVNc9NnRJkS/g2wpm9VoqS/XIHb+I0w1dJxoCrtZuL19kluCohI
   Ug7x81Ui4DWsNmz2s5BRvaIEgZN/eGOU/Q8B4xTJtVuDCgvM4C872c+P4
   Xf5K0ZIRB0c/APiTMSVBKODdYcTs3RgkNWbDcVpWa7eg3NnkZW8zLgnCd
   IlOmBqIc/Zbfl/a5WXZOr791rxrRiQ4cODjQDSJGpWOzF1gUtgyrBg7v6
   GBkoWCGttYSsKIkOVaYTy/PDuQGF/YJK3MWA3f+/HR0csrp79/8T4a42m
   w==;
X-CSE-ConnectionGUID: QLSDj+JGQP+3Lba8uz/C9g==
X-CSE-MsgGUID: zTF+QJA6SdiBOo3Tj6Odig==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43959790"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43959790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:50:11 -0800
X-CSE-ConnectionGUID: 49t4j+pfSIeFaYWzYxu1hQ==
X-CSE-MsgGUID: f8WuwzkER/a9bXv3tOyqtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118126352"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.223.156])
  by fmviesa005.fm.intel.com with ESMTP; 14 Feb 2025 08:49:23 -0800
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	andriy.shevchenko@intel.com,
	qat-linux@intel.com,
	=?UTF-8?q?Ma=C5=82gorzata=20Mielnik?= <malgorzata.mielnik@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] crypto: qat - refactor service parsing logic
Date: Fri, 14 Feb 2025 16:40:43 +0000
Message-ID: <20250214164855.64851-4-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214164855.64851-2-giovanni.cabiddu@intel.com>
References: <20250214164855.64851-2-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

From: Małgorzata Mielnik <malgorzata.mielnik@intel.com>

The service parsing logic is used to parse the configuration string
provided by the user using the attribute qat/cfg_services in sysfs.
The logic relies on hard-coded strings. For example, the service
"sym;asym" is also replicated as "asym;sym".
This makes the addition of new services or service combinations
complex as it requires the addition of new hard-coded strings for all
possible combinations.

This commit addresses this issue by:
 * reducing the number of internal service strings to only the basic
   service representations.
 * modifying the service parsing logic to analyze the service string
   token by token instead of comparing a whole string with patterns.
 * introducing the concept of a service mask where each service is
   represented by a single bit.
 * dividing the parsing logic into several functions to allow for code
   reuse (e.g. by sysfs-related functions).
 * introducing a new, device generation-specific function to verify
   whether the requested service combination is supported by the
   currently used device.

Signed-off-by: Małgorzata Mielnik <malgorzata.mielnik@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |  16 +-
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |  11 +-
 .../intel/qat/qat_common/adf_accel_devices.h  |   1 +
 .../intel/qat/qat_common/adf_cfg_services.c   | 166 ++++++++++++++++--
 .../intel/qat/qat_common/adf_cfg_services.h   |  26 ++-
 .../intel/qat/qat_common/adf_cfg_strings.h    |   6 +-
 .../intel/qat/qat_common/adf_gen4_config.c    |  15 +-
 .../intel/qat/qat_common/adf_gen4_hw_data.c   |  26 ++-
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   1 +
 .../crypto/intel/qat/qat_common/adf_sysfs.c   |  12 +-
 10 files changed, 202 insertions(+), 78 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 9faef33e54bd..87c71914ae87 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -106,8 +106,7 @@ static u32 get_ae_mask(struct adf_hw_device_data *self)
 static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
 {
 	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_CY:
-	case SVC_CY2:
+	case SVC_SYM_ASYM:
 		return ARRAY_SIZE(adf_fw_cy_config);
 	case SVC_DC:
 		return ARRAY_SIZE(adf_fw_dc_config);
@@ -118,10 +117,8 @@ static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
 	case SVC_ASYM:
 		return ARRAY_SIZE(adf_fw_asym_config);
 	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
 		return ARRAY_SIZE(adf_fw_asym_dc_config);
 	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 		return ARRAY_SIZE(adf_fw_sym_dc_config);
 	default:
 		return 0;
@@ -131,8 +128,7 @@ static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
 static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev)
 {
 	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_CY:
-	case SVC_CY2:
+	case SVC_SYM_ASYM:
 		return adf_fw_cy_config;
 	case SVC_DC:
 		return adf_fw_dc_config;
@@ -143,10 +139,8 @@ static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev
 	case SVC_ASYM:
 		return adf_fw_asym_config;
 	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
 		return adf_fw_asym_dc_config;
 	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 		return adf_fw_sym_dc_config;
 	default:
 		return NULL;
@@ -266,8 +260,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	}
 
 	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_CY:
-	case SVC_CY2:
+	case SVC_SYM_ASYM:
 		return capabilities_sym | capabilities_asym;
 	case SVC_DC:
 		return capabilities_dc;
@@ -284,10 +277,8 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	case SVC_ASYM:
 		return capabilities_asym;
 	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
 		return capabilities_asym | capabilities_dc;
 	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 		return capabilities_sym | capabilities_dc;
 	default:
 		return 0;
@@ -482,6 +473,7 @@ void adf_init_hw_data_420xx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->get_hb_clock = adf_gen4_get_heartbeat_clock;
 	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 	hw_data->clock_frequency = ADF_420XX_AE_FREQ;
+	hw_data->services_supported = adf_gen4_services_supported;
 
 	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index bbd92c017c28..36eebda3a028 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -178,8 +178,7 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	}
 
 	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_CY:
-	case SVC_CY2:
+	case SVC_SYM_ASYM:
 		return capabilities_sym | capabilities_asym;
 	case SVC_DC:
 		return capabilities_dc;
@@ -196,10 +195,8 @@ static u32 get_accel_cap(struct adf_accel_dev *accel_dev)
 	case SVC_ASYM:
 		return capabilities_asym;
 	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
 		return capabilities_asym | capabilities_dc;
 	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 		return capabilities_sym | capabilities_dc;
 	default:
 		return 0;
@@ -241,8 +238,7 @@ static u32 uof_get_num_objs(struct adf_accel_dev *accel_dev)
 static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev)
 {
 	switch (adf_get_service_enabled(accel_dev)) {
-	case SVC_CY:
-	case SVC_CY2:
+	case SVC_SYM_ASYM:
 		return adf_fw_cy_config;
 	case SVC_DC:
 		return adf_fw_dc_config;
@@ -253,10 +249,8 @@ static const struct adf_fw_config *get_fw_config(struct adf_accel_dev *accel_dev
 	case SVC_ASYM:
 		return adf_fw_asym_config;
 	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
 		return adf_fw_asym_dc_config;
 	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 		return adf_fw_sym_dc_config;
 	default:
 		return NULL;
@@ -466,6 +460,7 @@ void adf_init_hw_data_4xxx(struct adf_hw_device_data *hw_data, u32 dev_id)
 	hw_data->get_hb_clock = adf_gen4_get_heartbeat_clock;
 	hw_data->num_hb_ctrs = ADF_NUM_HB_CNT_PER_AE;
 	hw_data->clock_frequency = ADF_4XXX_AE_FREQ;
+	hw_data->services_supported = adf_gen4_services_supported;
 
 	adf_gen4_set_err_mask(&hw_data->dev_err_mask);
 	adf_gen4_init_hw_csr_ops(&hw_data->csr_ops);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 7830ecb1a1f1..9c15c31ad134 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -333,6 +333,7 @@ struct adf_hw_device_data {
 	int (*get_rp_group)(struct adf_accel_dev *accel_dev, u32 ae_mask);
 	u32 (*get_ena_thd_mask)(struct adf_accel_dev *accel_dev, u32 obj_num);
 	int (*dev_config)(struct adf_accel_dev *accel_dev);
+	bool (*services_supported)(unsigned long mask);
 	struct adf_pfvf_ops pfvf_ops;
 	struct adf_hw_csr_ops csr_ops;
 	struct adf_dc_ops dc_ops;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
index d30d686447e2..30abcd9e1283 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation */
 
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/string.h>
@@ -8,39 +10,165 @@
 #include "adf_cfg_services.h"
 #include "adf_cfg_strings.h"
 
-const char *const adf_cfg_services[] = {
-	[SVC_CY] = ADF_CFG_CY,
-	[SVC_CY2] = ADF_CFG_ASYM_SYM,
+static const char *const adf_cfg_services[] = {
+	[SVC_ASYM] = ADF_CFG_ASYM,
+	[SVC_SYM] = ADF_CFG_SYM,
 	[SVC_DC] = ADF_CFG_DC,
 	[SVC_DCC] = ADF_CFG_DCC,
-	[SVC_SYM] = ADF_CFG_SYM,
-	[SVC_ASYM] = ADF_CFG_ASYM,
-	[SVC_DC_ASYM] = ADF_CFG_DC_ASYM,
-	[SVC_ASYM_DC] = ADF_CFG_ASYM_DC,
-	[SVC_DC_SYM] = ADF_CFG_DC_SYM,
-	[SVC_SYM_DC] = ADF_CFG_SYM_DC,
 };
 
-int adf_get_service_enabled(struct adf_accel_dev *accel_dev)
+/*
+ * Ensure that the size of the array matches the number of services,
+ * SVC_BASE_COUNT, that is used to size the bitmap.
+ */
+static_assert(ARRAY_SIZE(adf_cfg_services) == SVC_BASE_COUNT);
+
+/*
+ * Ensure that the maximum number of concurrent services that can be
+ * enabled on a device is less than or equal to the number of total
+ * supported services.
+ */
+static_assert(ARRAY_SIZE(adf_cfg_services) >= MAX_NUM_CONCURR_SVC);
+
+/*
+ * Ensure that the number of services fit a single unsigned long, as each
+ * service is represented by a bit in the mask.
+ */
+static_assert(BITS_PER_LONG >= SVC_BASE_COUNT);
+
+/*
+ * Ensure that size of the concatenation of all service strings is smaller
+ * than the size of the buffer that will contain them.
+ */
+static_assert(sizeof(ADF_CFG_SYM ADF_SERVICES_DELIMITER
+		     ADF_CFG_ASYM ADF_SERVICES_DELIMITER
+		     ADF_CFG_DC ADF_SERVICES_DELIMITER
+		     ADF_CFG_DCC) < ADF_CFG_MAX_VAL_LEN_IN_BYTES);
+
+static int adf_service_string_to_mask(struct adf_accel_dev *accel_dev, const char *buf,
+				      size_t len, unsigned long *out_mask)
+{
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
+	unsigned long mask = 0;
+	char *substr, *token;
+	int id, num_svc = 0;
+
+	if (len > ADF_CFG_MAX_VAL_LEN_IN_BYTES - 1)
+		return -EINVAL;
+
+	strscpy(services, buf, ADF_CFG_MAX_VAL_LEN_IN_BYTES);
+	substr = services;
+
+	while ((token = strsep(&substr, ADF_SERVICES_DELIMITER))) {
+		id = sysfs_match_string(adf_cfg_services, token);
+		if (id < 0)
+			return id;
+
+		if (test_and_set_bit(id, &mask))
+			return -EINVAL;
+
+		if (num_svc++ == MAX_NUM_CONCURR_SVC)
+			return -EINVAL;
+	}
+
+	if (hw_data->services_supported && !hw_data->services_supported(mask))
+		return -EINVAL;
+
+	*out_mask = mask;
+
+	return 0;
+}
+
+static int adf_service_mask_to_string(unsigned long mask, char *buf, size_t len)
+{
+	int offset = 0;
+	int bit;
+
+	if (len < ADF_CFG_MAX_VAL_LEN_IN_BYTES)
+		return -ENOSPC;
+
+	for_each_set_bit(bit, &mask, SVC_BASE_COUNT) {
+		if (offset)
+			offset += scnprintf(buf + offset, len - offset,
+					    ADF_SERVICES_DELIMITER);
+
+		offset += scnprintf(buf + offset, len - offset, "%s",
+				    adf_cfg_services[bit]);
+	}
+
+	return 0;
+}
+
+int adf_parse_service_string(struct adf_accel_dev *accel_dev, const char *in,
+			     size_t in_len, char *out, size_t out_len)
 {
-	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
+	unsigned long mask;
+	int ret;
+
+	ret = adf_service_string_to_mask(accel_dev, in, in_len, &mask);
+	if (ret)
+		return ret;
+
+	if (!mask)
+		return -EINVAL;
+
+	return adf_service_mask_to_string(mask, out, out_len);
+}
+
+static int adf_get_service_mask(struct adf_accel_dev *accel_dev, unsigned long *mask)
+{
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
+	size_t len;
 	int ret;
 
 	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
 				      ADF_SERVICES_ENABLED, services);
 	if (ret) {
-		dev_err(&GET_DEV(accel_dev),
-			ADF_SERVICES_ENABLED " param not found\n");
+		dev_err(&GET_DEV(accel_dev), "%s param not found\n",
+			ADF_SERVICES_ENABLED);
 		return ret;
 	}
 
-	ret = match_string(adf_cfg_services, ARRAY_SIZE(adf_cfg_services),
-			   services);
-	if (ret < 0)
-		dev_err(&GET_DEV(accel_dev),
-			"Invalid value of " ADF_SERVICES_ENABLED " param: %s\n",
-			services);
+	len = strnlen(services, ADF_CFG_MAX_VAL_LEN_IN_BYTES);
+	ret = adf_service_string_to_mask(accel_dev, services, len, mask);
+	if (ret)
+		dev_err(&GET_DEV(accel_dev), "Invalid value of %s param: %s\n",
+			ADF_SERVICES_ENABLED, services);
 
 	return ret;
 }
+
+int adf_get_service_enabled(struct adf_accel_dev *accel_dev)
+{
+	unsigned long mask;
+	int ret;
+
+	ret = adf_get_service_mask(accel_dev, &mask);
+	if (ret)
+		return ret;
+
+	if (test_bit(SVC_SYM, &mask) && test_bit(SVC_ASYM, &mask))
+		return SVC_SYM_ASYM;
+
+	if (test_bit(SVC_SYM, &mask) && test_bit(SVC_DC, &mask))
+		return SVC_SYM_DC;
+
+	if (test_bit(SVC_ASYM, &mask) && test_bit(SVC_DC, &mask))
+		return SVC_ASYM_DC;
+
+	if (test_bit(SVC_SYM, &mask))
+		return SVC_SYM;
+
+	if (test_bit(SVC_ASYM, &mask))
+		return SVC_ASYM;
+
+	if (test_bit(SVC_DC, &mask))
+		return SVC_DC;
+
+	if (test_bit(SVC_DCC, &mask))
+		return SVC_DCC;
+
+	return -EINVAL;
+}
 EXPORT_SYMBOL_GPL(adf_get_service_enabled);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
index c6b0328b0f5b..f6bafc15cbc6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.h
@@ -8,21 +8,29 @@
 struct adf_accel_dev;
 
 enum adf_services {
-	SVC_CY = 0,
-	SVC_CY2,
+	SVC_ASYM = 0,
+	SVC_SYM,
 	SVC_DC,
 	SVC_DCC,
-	SVC_SYM,
-	SVC_ASYM,
-	SVC_DC_ASYM,
-	SVC_ASYM_DC,
-	SVC_DC_SYM,
+	SVC_BASE_COUNT
+};
+
+enum adf_composed_services {
+	SVC_SYM_ASYM = SVC_BASE_COUNT,
 	SVC_SYM_DC,
-	SVC_COUNT
+	SVC_ASYM_DC,
+};
+
+enum {
+	ADF_ONE_SERVICE = 1,
+	ADF_TWO_SERVICES,
+	ADF_THREE_SERVICES,
 };
 
-extern const char *const adf_cfg_services[SVC_COUNT];
+#define MAX_NUM_CONCURR_SVC	ADF_THREE_SERVICES
 
+int adf_parse_service_string(struct adf_accel_dev *accel_dev, const char *in,
+			     size_t in_len, char *out, size_t out_len);
 int adf_get_service_enabled(struct adf_accel_dev *accel_dev);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
index e015ad6cace2..b79982c4a856 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h
@@ -27,13 +27,9 @@
 #define ADF_CFG_CY "sym;asym"
 #define ADF_CFG_SYM "sym"
 #define ADF_CFG_ASYM "asym"
-#define ADF_CFG_ASYM_SYM "asym;sym"
-#define ADF_CFG_ASYM_DC "asym;dc"
-#define ADF_CFG_DC_ASYM "dc;asym"
-#define ADF_CFG_SYM_DC "sym;dc"
-#define ADF_CFG_DC_SYM "dc;sym"
 #define ADF_CFG_DCC "dcc"
 #define ADF_SERVICES_ENABLED "ServicesEnabled"
+#define ADF_SERVICES_DELIMITER ";"
 #define ADF_PM_IDLE_SUPPORT "PmIdleSupport"
 #define ADF_ETRMGR_COALESCING_ENABLED "InterruptCoalescingEnabled"
 #define ADF_ETRMGR_COALESCING_ENABLED_FORMAT \
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
index fe1f3d727dc5..f97e7a880f3a 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_config.c
@@ -213,7 +213,6 @@ static int adf_no_dev_config(struct adf_accel_dev *accel_dev)
  */
 int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
 {
-	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = {0};
 	int ret;
 
 	ret = adf_cfg_section_add(accel_dev, ADF_KERNEL_SEC);
@@ -224,18 +223,8 @@ int adf_gen4_dev_config(struct adf_accel_dev *accel_dev)
 	if (ret)
 		goto err;
 
-	ret = adf_cfg_get_param_value(accel_dev, ADF_GENERAL_SEC,
-				      ADF_SERVICES_ENABLED, services);
-	if (ret)
-		goto err;
-
-	ret = sysfs_match_string(adf_cfg_services, services);
-	if (ret < 0)
-		goto err;
-
-	switch (ret) {
-	case SVC_CY:
-	case SVC_CY2:
+	switch (adf_get_service_enabled(accel_dev)) {
+	case SVC_SYM_ASYM:
 		ret = adf_crypto_dev_config(accel_dev);
 		break;
 	case SVC_DC:
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
index 41a0979e68c1..ade279e48010 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
 /* Copyright(c) 2020 Intel Corporation */
+#include <linux/bitops.h>
 #include <linux/iopoll.h>
 #include <asm/div64.h>
 #include "adf_accel_devices.h"
@@ -265,18 +266,29 @@ static bool is_single_service(int service_id)
 	case SVC_SYM:
 	case SVC_ASYM:
 		return true;
-	case SVC_CY:
-	case SVC_CY2:
-	case SVC_DCC:
-	case SVC_ASYM_DC:
-	case SVC_DC_ASYM:
-	case SVC_SYM_DC:
-	case SVC_DC_SYM:
 	default:
 		return false;
 	}
 }
 
+bool adf_gen4_services_supported(unsigned long mask)
+{
+	unsigned long num_svc = hweight_long(mask);
+
+	if (mask >= BIT(SVC_BASE_COUNT))
+		return false;
+
+	switch (num_svc) {
+	case ADF_ONE_SERVICE:
+		return true;
+	case ADF_TWO_SERVICES:
+		return !test_bit(SVC_DCC, &mask);
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(adf_gen4_services_supported);
+
 int adf_gen4_init_thd2arb_map(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
index e8c53bd76f1b..51fc2eaa263e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h
@@ -179,5 +179,6 @@ int adf_gen4_bank_state_save(struct adf_accel_dev *accel_dev, u32 bank_number,
 			     struct bank_state *state);
 int adf_gen4_bank_state_restore(struct adf_accel_dev *accel_dev,
 				u32 bank_number, struct bank_state *state);
+bool adf_gen4_services_supported(unsigned long service_mask);
 
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
index 84450bffacb6..6c39194647f0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs.c
@@ -116,25 +116,27 @@ static int adf_sysfs_update_dev_config(struct adf_accel_dev *accel_dev,
 static ssize_t cfg_services_store(struct device *dev, struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
+	char services[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
 	struct adf_hw_device_data *hw_data;
 	struct adf_accel_dev *accel_dev;
 	int ret;
 
-	ret = sysfs_match_string(adf_cfg_services, buf);
-	if (ret < 0)
-		return ret;
-
 	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
 	if (!accel_dev)
 		return -EINVAL;
 
+	ret = adf_parse_service_string(accel_dev, buf, count, services,
+				       ADF_CFG_MAX_VAL_LEN_IN_BYTES);
+	if (ret)
+		return ret;
+
 	if (adf_dev_started(accel_dev)) {
 		dev_info(dev, "Device qat_dev%d must be down to reconfigure the service.\n",
 			 accel_dev->accel_id);
 		return -EINVAL;
 	}
 
-	ret = adf_sysfs_update_dev_config(accel_dev, adf_cfg_services[ret]);
+	ret = adf_sysfs_update_dev_config(accel_dev, services);
 	if (ret < 0)
 		return ret;
 
-- 
2.48.1


