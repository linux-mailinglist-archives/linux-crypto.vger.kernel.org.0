Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95799152937
	for <lists+linux-crypto@lfdr.de>; Wed,  5 Feb 2020 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBEKfB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 5 Feb 2020 05:35:01 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:41871 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEKfB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 5 Feb 2020 05:35:01 -0500
Received: from beagle7.blr.asicdesigners.com (beagle7.blr.asicdesigners.com [10.193.80.123])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 015AYswL021636;
        Wed, 5 Feb 2020 02:34:55 -0800
From:   Devulapally Shiva Krishna <shiva@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     manojmalviya@chelsio.com,
        Devulapally Shiva Krishna <shiva@chelsio.com>
Subject: [Crypto] chcr: Print the chcr driver information while module load.
Date:   Wed,  5 Feb 2020 16:04:33 +0530
Message-Id: <20200205103433.10490-1-shiva@chelsio.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

No logs are recorded in dmesg during chcr module load, hence
adding the print and also appending -ko to driver version.

Signed-off-by: Devulapally Shiva Krishna <shiva@chelsio.com>
---
 drivers/crypto/chelsio/chcr_core.c | 1 +
 drivers/crypto/chelsio/chcr_core.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index e937605670ac..507ba20f0874 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -190,6 +190,7 @@ static void *chcr_uld_add(const struct cxgb4_lld_info *lld)
 	struct uld_ctx *u_ctx;
 
 	/* Create the device and add it in the device list */
+	pr_info_once("%s - version %s\n", DRV_DESC, DRV_VERSION);
 	if (!(lld->ulp_crypto & ULP_CRYPTO_LOOKASIDE))
 		return ERR_PTR(-EOPNOTSUPP);
 
diff --git a/drivers/crypto/chelsio/chcr_core.h b/drivers/crypto/chelsio/chcr_core.h
index ad874d548aa5..b41ef1abfe74 100644
--- a/drivers/crypto/chelsio/chcr_core.h
+++ b/drivers/crypto/chelsio/chcr_core.h
@@ -43,7 +43,8 @@
 #include "cxgb4_uld.h"
 
 #define DRV_MODULE_NAME "chcr"
-#define DRV_VERSION "1.0.0.0"
+#define DRV_VERSION "1.0.0.0-ko"
+#define DRV_DESC "Chelsio T6 Crypto Co-processor Driver"
 
 #define MAX_PENDING_REQ_TO_HW 20
 #define CHCR_TEST_RESPONSE_TIMEOUT 1000
-- 
2.18.1

