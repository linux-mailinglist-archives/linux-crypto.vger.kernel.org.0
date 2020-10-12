Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADF928C2B3
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Oct 2020 22:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgJLUjy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Oct 2020 16:39:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:34122 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387887AbgJLUjw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Oct 2020 16:39:52 -0400
IronPort-SDR: hGBxlh11juclquOQ3QUOR/o+HjF4dZZ0Z6XdWqFTK65xXdpk33HcS3wH7lDw3WDbJOf9vZkDcq
 pzVu1fEo3NrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165913184"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165913184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:39:51 -0700
IronPort-SDR: A0k7SAbh8+GeN4FdgbWs9urU+nI2JpZvQ5HE789tsfeKYG/rLCdGjuNjs9vKverCwFK7n8Lavh
 +DLCoz6eQHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="299328272"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 13:39:50 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 27/31] crypto: qat - change return value in adf_cfg_key_val_get()
Date:   Mon, 12 Oct 2020 21:38:43 +0100
Message-Id: <20201012203847.340030-28-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
References: <20201012203847.340030-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

If a key is not found in the internal key value storage, return -ENODATA
instead of -1 that is treated as -EPERM and may confuse.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/crypto/qat/qat_common/adf_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_cfg.c b/drivers/crypto/qat/qat_common/adf_cfg.c
index f2a29c70d61a..575b6f002303 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg.c
+++ b/drivers/crypto/qat/qat_common/adf_cfg.c
@@ -196,7 +196,7 @@ static int adf_cfg_key_val_get(struct adf_accel_dev *accel_dev,
 		memcpy(val, keyval->val, ADF_CFG_MAX_VAL_LEN_IN_BYTES);
 		return 0;
 	}
-	return -1;
+	return -ENODATA;
 }
 
 /**
-- 
2.26.2

