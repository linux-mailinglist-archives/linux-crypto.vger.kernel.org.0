Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6B30D9C2
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Feb 2021 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhBCM1P (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Feb 2021 07:27:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhBCM1P (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Feb 2021 07:27:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DW1953fffzjJKm;
        Wed,  3 Feb 2021 20:25:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 20:26:27 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sumit.garg@linaro.org>, <herbert@gondor.apana.org.au>
CC:     <op-tee@lists.trustedfirmware.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2] hwrng: optee: Use device-managed registration API
Date:   Wed, 3 Feb 2021 20:26:06 +0800
Message-ID: <1612355166-11824-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use devm_hwrng_register to get rid of manual unregistration.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
v2:Fix up subject line as s/hwrng: optee -:/hwrng: optee:/
---
 drivers/char/hw_random/optee-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index a99d829..135a825 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -243,7 +243,7 @@ static int optee_rng_probe(struct device *dev)
 	if (err)
 		goto out_sess;
 
-	err = hwrng_register(&pvt_data.optee_rng);
+	err = devm_hwrng_register(dev, &pvt_data.optee_rng);
 	if (err) {
 		dev_err(dev, "hwrng registration failed (%d)\n", err);
 		goto out_sess;
@@ -263,7 +263,6 @@ static int optee_rng_probe(struct device *dev)
 
 static int optee_rng_remove(struct device *dev)
 {
-	hwrng_unregister(&pvt_data.optee_rng);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
 
-- 
2.7.4

