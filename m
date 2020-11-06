Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2F2A954E
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgKFL2v (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 06:28:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:59373 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbgKFL2u (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 06:28:50 -0500
IronPort-SDR: FGqN0AYUXEr+i1/DSrVqYfrwFOszPLgdrdF+CNi0EaMnOHPLoveYMk5gP5KKK4Dp/hDTdqjSb4
 /zqQhF3aZjWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233698293"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="233698293"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 03:28:50 -0800
IronPort-SDR: yn+iAv3yiiI7V9bWZRWeJh7uajmZ1LMTHAF7XJqzS4hBY0s/eT2ymEBoxWs8jChMXvn5zhDbfy
 sne+GEwBtjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="529779232"
Received: from haps801-neoncity02.sh.intel.com ([10.67.114.160])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2020 03:28:48 -0800
From:   Jack Xu <jack.xu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 10/32] crypto: qat - loader: change micro word data mask
Date:   Fri,  6 Nov 2020 19:27:48 +0800
Message-Id: <20201106112810.2566-11-jack.xu@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201106112810.2566-1-jack.xu@intel.com>
References: <20201106112810.2566-1-jack.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Change micro word data mask since the Acceleration Engine (AE)
instruction codes have been changed in the new generation QAT devices.

Signed-off-by: Jack Xu <jack.xu@intel.com>
Co-developed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/qat_uclo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
index 1c03205c7166..6423b1ea7021 100644
--- a/drivers/crypto/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/qat/qat_common/qat_uclo.c
@@ -1752,7 +1752,7 @@ static void qat_uclo_fill_uwords(struct icp_qat_uclo_objhandle *obj_handle,
 			memcpy(&uwrd, (void *)(((uintptr_t)
 			       encap_page->uwblock[i].micro_words) + addr),
 			       obj_handle->uword_in_bytes);
-			uwrd = uwrd & 0xbffffffffffull;
+			uwrd = uwrd & GENMASK_ULL(43, 0);
 		}
 	}
 	*uword = uwrd;
-- 
2.25.4

