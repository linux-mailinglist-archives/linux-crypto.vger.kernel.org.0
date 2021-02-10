Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16008316019
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBJHgL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:36:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12889 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhBJHgK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:36:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DbBMw240vz7jXv
        for <linux-crypto@vger.kernel.org>; Wed, 10 Feb 2021 15:34:04 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 15:35:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-crypto@vger.kernel.org>
Subject: [PATCH -next] crypto: keembay-ocs-hcu - Fix error return code in kmb_ocs_hcu_probe()
Date:   Wed, 10 Feb 2021 07:43:50 +0000
Message-ID: <20210210074350.867341-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 472b04444cd3 ("crypto: keembay - Add Keem Bay OCS HCU driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/crypto/keembay/keembay-ocs-hcu-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
index c4b97b4160e9..322c51a6936f 100644
--- a/drivers/crypto/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
@@ -1220,8 +1220,10 @@ static int kmb_ocs_hcu_probe(struct platform_device *pdev)
 
 	/* Initialize crypto engine */
 	hcu_dev->engine = crypto_engine_alloc_init(dev, 1);
-	if (!hcu_dev->engine)
+	if (!hcu_dev->engine) {
+		rc = -ENOMEM;
 		goto list_del;
+	}
 
 	rc = crypto_engine_start(hcu_dev->engine);
 	if (rc) {

