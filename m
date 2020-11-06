Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9B2A9551
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgKFL25 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 06:28:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:59373 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbgKFL24 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 06:28:56 -0500
IronPort-SDR: GxMkbmlL6kXvJIptxoSt6o6Qu81n+JlsvuKZjPEYjlIZF7hDHCI7UiHtb2jfIRPl/UtAPdleTe
 0UW0sibT9WHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233698307"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="233698307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 03:28:56 -0800
IronPort-SDR: JoH6uQ6opN5HkB8FlftBAa8yaONzdekMhFkgI3RpdCGFqjTifDMsIbJd7apR029GC6aIzpuZmI
 NtMJONoDyQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="529779269"
Received: from haps801-neoncity02.sh.intel.com ([10.67.114.160])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2020 03:28:53 -0800
From:   Jack Xu <jack.xu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 13/32] crypto: qat - loader: move defines to header files
Date:   Fri,  6 Nov 2020 19:27:51 +0800
Message-Id: <20201106112810.2566-14-jack.xu@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201106112810.2566-1-jack.xu@intel.com>
References: <20201106112810.2566-1-jack.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Move the definition of ICP_QAT_AE_OFFSET, ICP_QAT_CAP_OFFSET,
LOCAL_TO_XFER_REG_OFFSET and ICP_QAT_EP_OFFSET from qat_hal.c to
icp_qat_hal.h to avoid the definition of generation specific constants
in qat_hal.c.

Signed-off-by: Jack Xu <jack.xu@intel.com>
Co-developed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/icp_qat_hal.h | 4 ++++
 drivers/crypto/qat/qat_common/qat_hal.c     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/icp_qat_hal.h b/drivers/crypto/qat/qat_common/icp_qat_hal.h
index c2166dacdf5b..eff9a3811435 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hal.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hal.h
@@ -85,6 +85,10 @@ enum fcu_sts {
 #define FCU_LOADED_AE_POS   0x16
 #define FW_AUTH_WAIT_PERIOD 10
 #define FW_AUTH_MAX_RETRY   300
+#define ICP_QAT_AE_OFFSET 0x20000
+#define ICP_QAT_CAP_OFFSET (ICP_QAT_AE_OFFSET + 0x10000)
+#define LOCAL_TO_XFER_REG_OFFSET 0x800
+#define ICP_QAT_EP_OFFSET 0x3a000
 
 #define SET_CAP_CSR(handle, csr, val) \
 	ADF_CSR_WR((handle)->hal_cap_g_ctl_csr_addr_v, csr, val)
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/qat/qat_common/qat_hal.c
index 15ebb57ea14a..5bf42f01a3de 100644
--- a/drivers/crypto/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/qat/qat_common/qat_hal.c
@@ -646,10 +646,6 @@ static int qat_hal_clear_gpr(struct icp_qat_fw_loader_handle *handle)
 	return 0;
 }
 
-#define ICP_QAT_AE_OFFSET	0x20000
-#define ICP_QAT_CAP_OFFSET       (ICP_QAT_AE_OFFSET + 0x10000)
-#define LOCAL_TO_XFER_REG_OFFSET    0x800
-#define ICP_QAT_EP_OFFSET	0x3a000
 int qat_hal_init(struct adf_accel_dev *accel_dev)
 {
 	unsigned char ae;
-- 
2.25.4

