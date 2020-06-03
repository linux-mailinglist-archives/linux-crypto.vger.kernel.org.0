Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7751ED50F
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jun 2020 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgFCRfM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 13:35:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:31629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgFCRfL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 13:35:11 -0400
IronPort-SDR: ChMnS104+jnlv0+BKsS8Q4eMUmqST1JslnIHIzrxxsqyxFU2u//p3xHYPYAwreM75fUz5RM6hw
 FI1e/YWeuYbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 10:34:12 -0700
IronPort-SDR: Qjagn2qTwswd7B5iFG6HwkFweFoRElRj6j7dcPFhD0F8xSQW4QhIfKd9iYjPzLGQCpsuP0UnjG
 PWSW8IbLYBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="304445572"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2020 10:34:11 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 3/3] crypto: qat - remove packed attribute in etr structs
Date:   Wed,  3 Jun 2020 18:33:46 +0100
Message-Id: <20200603173346.96967-4-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603173346.96967-1-giovanni.cabiddu@intel.com>
References: <20200603173346.96967-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove packed attribute in adf_etr_bank_data and adf_etr_ring_data.
Fields in these structures are reordered in order to avoid holes.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_common/adf_transport_internal.h  | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_transport_internal.h b/drivers/crypto/qat/qat_common/adf_transport_internal.h
index df4c7195daae..c7faf4e2d302 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_internal.h
+++ b/drivers/crypto/qat/qat_common/adf_transport_internal.h
@@ -15,32 +15,31 @@ struct adf_etr_ring_debug_entry {
 struct adf_etr_ring_data {
 	void *base_addr;
 	atomic_t *inflights;
-	spinlock_t lock;	/* protects ring data struct */
 	adf_callback_fn callback;
 	struct adf_etr_bank_data *bank;
 	dma_addr_t dma_addr;
+	struct adf_etr_ring_debug_entry *ring_debug;
+	spinlock_t lock;	/* protects ring data struct */
 	u16 head;
 	u16 tail;
 	u8 ring_number;
 	u8 ring_size;
 	u8 msg_size;
-	u8 reserved;
-	struct adf_etr_ring_debug_entry *ring_debug;
-} __packed;
+};
 
 struct adf_etr_bank_data {
 	struct adf_etr_ring_data rings[ADF_ETR_MAX_RINGS_PER_BANK];
 	struct tasklet_struct resp_handler;
 	void __iomem *csr_addr;
-	struct adf_accel_dev *accel_dev;
 	u32 irq_coalesc_timer;
+	u32 bank_number;
 	u16 ring_mask;
 	u16 irq_mask;
 	spinlock_t lock;	/* protects bank data struct */
+	struct adf_accel_dev *accel_dev;
 	struct dentry *bank_debug_dir;
 	struct dentry *bank_debug_cfg;
-	u32 bank_number;
-} __packed;
+};
 
 struct adf_etr_data {
 	struct adf_etr_bank_data *banks;
-- 
2.26.2

