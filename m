Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3839360B
	for <lists+linux-crypto@lfdr.de>; Thu, 27 May 2021 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhE0TPA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 May 2021 15:15:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:7489 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234635AbhE0TO7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 May 2021 15:14:59 -0400
IronPort-SDR: +8F/DGXIb2avip/D7jt9JEp0kg8JIYMLmqu/eXjkAMjALxZGOG7+MuCmR7kqnIW16kok6a6hKG
 N8qQqyd9smMg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="264012431"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="264012431"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 12:13:25 -0700
IronPort-SDR: 3pHGXxP8QbQ+k4FwRxTkooEtBQ7EcaPa25QLBEGnR62k4OcV6kn+AkmYOMbu/scuJ18pIzuBVi
 83wppLkV6eDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="480717742"
Received: from silpixa00393544.ir.intel.com ([10.237.213.118])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2021 12:13:24 -0700
From:   Marco Chiappero <marco.chiappero@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Marco Chiappero <marco.chiappero@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 02/10] crypto: qat - remove empty sriov_configure()
Date:   Thu, 27 May 2021 20:12:43 +0100
Message-Id: <20210527191251.6317-3-marco.chiappero@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210527191251.6317-1-marco.chiappero@intel.com>
References: <20210527191251.6317-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove the empty implementation of sriov_configure() and set the
sriov_configure member of the pci_driver structure to NULL.
This way, if a user tries to enable VFs on a device, when kernel and
driver are built with CONFIG_PCI_IOV=n, the kernel reports an error
message saying that the driver does not support SRIOV configuration via
sysfs.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Co-developed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c          | 2 ++
 drivers/crypto/qat/qat_c3xxx/adf_drv.c         | 2 ++
 drivers/crypto/qat/qat_c62x/adf_drv.c          | 2 ++
 drivers/crypto/qat/qat_common/adf_common_drv.h | 5 -----
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c      | 2 ++
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index a8805c815d16..b77290d3da10 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -309,7 +309,9 @@ static struct pci_driver adf_driver = {
 	.name = ADF_4XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+#ifdef CONFIG_PCI_IOV
 	.sriov_configure = adf_sriov_configure,
+#endif
 };
 
 module_pci_driver(adf_driver);
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index 7fb3343ae8b0..70be2383dce2 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -32,7 +32,9 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C3XXX_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+#ifdef CONFIG_PCI_IOV
 	.sriov_configure = adf_sriov_configure,
+#endif
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index 1f5de442e1e6..ab03acb06365 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -32,7 +32,9 @@ static struct pci_driver adf_driver = {
 	.name = ADF_C62X_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+#ifdef CONFIG_PCI_IOV
 	.sriov_configure = adf_sriov_configure,
+#endif
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index c61476553728..0150fce09600 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -205,11 +205,6 @@ void adf_exit_pf_wq(void);
 int adf_init_vf_wq(void);
 void adf_exit_vf_wq(void);
 #else
-static inline int adf_sriov_configure(struct pci_dev *pdev, int numvfs)
-{
-	return 0;
-}
-
 static inline void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 {
 }
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index a9ec4357144c..31dd2a8e32b0 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -32,7 +32,9 @@ static struct pci_driver adf_driver = {
 	.name = ADF_DH895XCC_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+#ifdef CONFIG_PCI_IOV
 	.sriov_configure = adf_sriov_configure,
+#endif
 };
 
 static void adf_cleanup_pci_dev(struct adf_accel_dev *accel_dev)
-- 
2.26.2

