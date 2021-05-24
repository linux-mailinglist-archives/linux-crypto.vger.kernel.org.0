Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC238E5E6
	for <lists+linux-crypto@lfdr.de>; Mon, 24 May 2021 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhEXLz3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 May 2021 07:55:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEXLz3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 May 2021 07:55:29 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpbBz3RhYz1BR43;
        Mon, 24 May 2021 19:51:07 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:53:57 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 19:53:43 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <l.stelmach@samsung.com>, <krzysztof.kozlowski@canonical.com>
CC:     <linux-samsung-soc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2] hwrng: exynos: Use pm_runtime_resume_and_get() to replace open coding
Date:   Mon, 24 May 2021 19:53:38 +0800
Message-ID: <1621857218-28590-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. this change is just to simplify the code, no
actual functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
v2: drop unnecessary change about if condition.
---
 drivers/char/hw_random/exynos-trng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index c8db62b..9cc3d54 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -196,10 +196,9 @@ static int __maybe_unused exynos_trng_resume(struct device *dev)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "Could not get runtime PM.\n");
-		pm_runtime_put_noidle(dev);
 		return ret;
 	}
 
-- 
2.7.4

