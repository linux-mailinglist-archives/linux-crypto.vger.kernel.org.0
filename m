Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2242B20C4
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Nov 2020 17:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMQqx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Nov 2020 11:46:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:5727 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKMQqx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Nov 2020 11:46:53 -0500
IronPort-SDR: 7qcWWkkbG7dYtJLuqvcqvlVaw4Wh28bJrirl7fyTg+bBaXfHDR5w2pf9DyalXLyiY1CweYPaww
 O8qcwdMljz6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="234655782"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="234655782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 08:46:52 -0800
IronPort-SDR: L9914xPYc/4WrWbhS48b0A2+EfuRDETehnez0K15BgUMfxmwqV+Co/TU71EtmQ/TkfK54oqKBI
 tJK+rcevw9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="328926313"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2020 08:46:51 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: [PATCH 2/3] crypto: qat - add hook to initialize vector routing table
Date:   Fri, 13 Nov 2020 16:46:42 +0000
Message-Id: <20201113164643.103383-3-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
References: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add an hook to initialize the vector routing table with the default
values before MSIx is enabled.
The new function set_msix_rttable() is called only if present in the
struct adf_hw_device_data of the device. This is to allow for QAT
devices that do not support that functionality.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
---
 drivers/crypto/qat/qat_common/adf_accel_devices.h | 1 +
 drivers/crypto/qat/qat_common/adf_isr.c           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 1484f10dbfdf..26164d71f1d6 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -175,6 +175,7 @@ struct adf_hw_device_data {
 	void (*enable_ints)(struct adf_accel_dev *accel_dev);
 	int (*enable_vf2pf_comms)(struct adf_accel_dev *accel_dev);
 	void (*reset_device)(struct adf_accel_dev *accel_dev);
+	void (*set_msix_rttable)(struct adf_accel_dev *accel_dev);
 	char *(*uof_get_name)(u32 obj_num);
 	u32 (*uof_get_num_objs)(void);
 	u32 (*uof_get_ae_mask)(u32 obj_num);
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 5444f0ea0a1d..c45853463530 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -21,6 +21,9 @@ static int adf_enable_msix(struct adf_accel_dev *accel_dev)
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	u32 msix_num_entries = 1;
 
+	if (hw_data->set_msix_rttable)
+		hw_data->set_msix_rttable(accel_dev);
+
 	/* If SR-IOV is disabled, add entries for each bank */
 	if (!accel_dev->pf.vf_info) {
 		int i;
-- 
2.28.0

