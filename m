Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E52574D7
	for <lists+linux-crypto@lfdr.de>; Mon, 31 Aug 2020 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaH6i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 31 Aug 2020 03:58:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:62616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaH6h (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 31 Aug 2020 03:58:37 -0400
IronPort-SDR: baiI939K1RhwoPtqmcGzHyVdM+rViDOkevo3zkfdp8YcpHvJ4Q32a8yIq15/4TD7HSyNMvmyG5
 OfR1rZr6AyAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156929894"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="156929894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 00:58:36 -0700
IronPort-SDR: /NfLvcjH14ZxGm0bjGvZtBi23J0r4BzRnKBPaTH8WA+1cxJzzC4R9RTsgKlXD8UBALK0lhK0Eh
 EWADzHXlNOKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="330614201"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 00:58:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A98E9FA; Mon, 31 Aug 2020 10:58:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] crypto: caam - use traditional error check pattern
Date:   Mon, 31 Aug 2020 10:58:32 +0300
Message-Id: <20200831075832.3827-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use traditional error check pattern
	ret = ...;
	if (ret)
		return ret;
	...
instead of checking error code to be 0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/crypto/caam/ctrl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 65de57f169d9..25785404a58e 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -333,11 +333,10 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 
 	kfree(desc);
 
-	if (!ret)
-		ret = devm_add_action_or_reset(ctrldev, devm_deinstantiate_rng,
-					       ctrldev);
+	if (ret)
+		return ret;
 
-	return ret;
+	return devm_add_action_or_reset(ctrldev, devm_deinstantiate_rng, ctrldev);
 }
 
 /*
-- 
2.28.0

