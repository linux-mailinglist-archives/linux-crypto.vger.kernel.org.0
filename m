Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C12A954B
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFL2q (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 06:28:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:59373 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgKFL2q (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 06:28:46 -0500
IronPort-SDR: 3DvVl2qZw0RU18DjqjxJuP3xAuEGbDjTlwsh7Vay8JmjA10xXLbiueJFTkt3OyLPH8moxoSwR1
 IWmiZvMabKQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233698288"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="233698288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 03:28:45 -0800
IronPort-SDR: VyzCfC/iNtnjZY3lKgDe1qkjUTBHM9d7jeAEjE31CMPj8ulriu0rAOfqhczLYGPtISv/RqyecX
 7cYSD5XyPKJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="529779204"
Received: from haps801-neoncity02.sh.intel.com ([10.67.114.160])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2020 03:28:43 -0800
From:   Jack Xu <jack.xu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 07/32] crypto: qat - loader: rename qat_uclo_del_uof_obj()
Date:   Fri,  6 Nov 2020 19:27:45 +0800
Message-Id: <20201106112810.2566-8-jack.xu@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201106112810.2566-1-jack.xu@intel.com>
References: <20201106112810.2566-1-jack.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Rename the function qat_uclo_del_uof_obj() in qat_uclo_del_obj() since
it frees the memory allocated for all firmware objects.

Signed-off-by: Jack Xu <jack.xu@intel.com>
Co-developed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_accel_engine.c | 2 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h   | 2 +-
 drivers/crypto/qat/qat_common/qat_uclo.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_engine.c b/drivers/crypto/qat/qat_common/adf_accel_engine.c
index 1da4176356ab..2c4a8c7c736e 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_engine.c
+++ b/drivers/crypto/qat/qat_common/adf_accel_engine.c
@@ -61,7 +61,7 @@ void adf_ae_fw_release(struct adf_accel_dev *accel_dev)
 	if (!hw_device->fw_name)
 		return;
 
-	qat_uclo_del_uof_obj(loader_data->fw_loader);
+	qat_uclo_del_obj(loader_data->fw_loader);
 	qat_hal_deinit(loader_data->fw_loader);
 	release_firmware(loader_data->uof_fw);
 	release_firmware(loader_data->mmp_fw);
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 8e6e346fd841..22ac0517d15d 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -180,7 +180,7 @@ int qat_hal_init_nn(struct icp_qat_fw_loader_handle *handle,
 int qat_hal_wr_lm(struct icp_qat_fw_loader_handle *handle,
 		  unsigned char ae, unsigned short lm_addr, unsigned int value);
 int qat_uclo_wr_all_uimage(struct icp_qat_fw_loader_handle *handle);
-void qat_uclo_del_uof_obj(struct icp_qat_fw_loader_handle *handle);
+void qat_uclo_del_obj(struct icp_qat_fw_loader_handle *handle);
 int qat_uclo_wr_mimage(struct icp_qat_fw_loader_handle *handle, void *addr_ptr,
 		       int mem_size);
 int qat_uclo_map_obj(struct icp_qat_fw_loader_handle *handle,
diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
index 4b2079353aa3..dc2f2dcf21b8 100644
--- a/drivers/crypto/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/qat/qat_common/qat_uclo.c
@@ -1705,7 +1705,7 @@ int qat_uclo_map_obj(struct icp_qat_fw_loader_handle *handle,
 			qat_uclo_map_uof_obj(handle, obj_addr, obj_size);
 }
 
-void qat_uclo_del_uof_obj(struct icp_qat_fw_loader_handle *handle)
+void qat_uclo_del_obj(struct icp_qat_fw_loader_handle *handle)
 {
 	struct icp_qat_uclo_objhandle *obj_handle = handle->obj_handle;
 	unsigned int a;
-- 
2.25.4

