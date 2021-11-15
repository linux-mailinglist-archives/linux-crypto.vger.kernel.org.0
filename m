Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30723450412
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Nov 2021 13:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhKOMIc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Nov 2021 07:08:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:13626 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhKOMIL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Nov 2021 07:08:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233265630"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233265630"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="535486560"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2021 04:04:26 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 23/24] crypto: qat - fix VF IDs in PFVF log messages
Date:   Mon, 15 Nov 2021 12:03:35 +0000
Message-Id: <20211115120336.22292-24-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
References: <20211115120336.22292-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Marco Chiappero <marco.chiappero@intel.com>

PFVF debug messages use a mix of zero and one based VF IDs.
Switch to zero based VF numbers in all log messages.

Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_isr.c           |  2 +-
 drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index 358200c0d598..522e0c10d9b9 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -123,7 +123,7 @@ static bool adf_handle_vf2pf_int(struct adf_accel_dev *accel_dev)
 			if (!__ratelimit(&vf_info->vf2pf_ratelimit)) {
 				dev_info(&GET_DEV(accel_dev),
 					 "Too many ints from VF%d\n",
-					  vf_info->vf_nr + 1);
+					  vf_info->vf_nr);
 				continue;
 			}
 
diff --git a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
index 2ffd1f442e35..82b6cc7162ba 100644
--- a/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/qat/qat_common/adf_pfvf_pf_proto.c
@@ -50,7 +50,7 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 
 		dev_dbg(&GET_DEV(accel_dev),
 			"Compatibility Version Request from VF%d vers=%u\n",
-			vf_nr + 1, vf_compat_ver);
+			vf_nr, vf_compat_ver);
 
 		if (vf_compat_ver <= ADF_PFVF_COMPAT_THIS_VERSION) {
 			compat = ADF_PF2VF_VF_COMPATIBLE;
@@ -76,7 +76,7 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 
 		dev_dbg(&GET_DEV(accel_dev),
 			"Legacy VersionRequest received from VF%d 0x%x\n",
-			vf_nr + 1, msg);
+			vf_nr, msg);
 
 		/* PF always newer than legacy VF */
 		compat = ADF_PF2VF_VF_COMPATIBLE;
@@ -93,7 +93,7 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		{
 		dev_dbg(&GET_DEV(accel_dev),
 			"Init message received from VF%d 0x%x\n",
-			vf_nr + 1, msg);
+			vf_nr, msg);
 		vf_info->init = true;
 		}
 		break;
@@ -101,13 +101,13 @@ static int adf_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr,
 		{
 		dev_dbg(&GET_DEV(accel_dev),
 			"Shutdown message received from VF%d 0x%x\n",
-			vf_nr + 1, msg);
+			vf_nr, msg);
 		vf_info->init = false;
 		}
 		break;
 	default:
 		dev_dbg(&GET_DEV(accel_dev), "Unknown message from VF%d (0x%x)\n",
-			vf_nr + 1, msg);
+			vf_nr, msg);
 		return -ENOMSG;
 	}
 
-- 
2.33.1

