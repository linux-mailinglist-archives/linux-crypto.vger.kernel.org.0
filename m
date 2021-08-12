Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5E3EAB95
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhHLUWV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 16:22:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:4146 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbhHLUWU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215474005"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="215474005"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 13:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="517608559"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2021 13:21:40 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Marco Chiappero <marco.chiappero@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 02/20] crypto: qat - remove empty sriov_configure()
Date:   Thu, 12 Aug 2021 21:21:11 +0100
Message-Id: <20210812202129.18831-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812202129.18831-1-giovanni.cabiddu@intel.com>
References: <20210812202129.18831-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

Remove the empty implementation of sriov_configure() and set the
sriov_configure member of the pci_driver structure to NULL.
This way, if a user tries to enable VFs on a device, when kernel and
driver are built with CONFIG_PCI_IOV=n, the kernel reports an error
message saying that the driver does not support SRIOV configuration via
sysfs.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/qat_common/adf_common_drv.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index c61476553728..c7deca7f0607 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -205,10 +205,7 @@ void adf_exit_pf_wq(void);
 int adf_init_vf_wq(void);
 void adf_exit_vf_wq(void);
 #else
-static inline int adf_sriov_configure(struct pci_dev *pdev, int numvfs)
-{
-	return 0;
-}
+#define adf_sriov_configure NULL
 
 static inline void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 {
-- 
2.31.1

