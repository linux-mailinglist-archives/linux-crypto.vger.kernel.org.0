Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F073AA9BA
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Jun 2021 05:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFQDxx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Jun 2021 23:53:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7340 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhFQDxt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Jun 2021 23:53:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G57L52rymz6yS5;
        Thu, 17 Jun 2021 11:47:41 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 11:51:35 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 17
 Jun 2021 11:51:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ulli.kroll@googlemail.com>, <linus.walleij@linaro.org>,
        <clabbe@baylibre.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: sl3516 - Fix build warning without CONFIG_PM
Date:   Thu, 17 Jun 2021 11:51:29 +0800
Message-ID: <20210617035129.4948-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

drivers/crypto/gemini/sl3516-ce-core.c:345:12:
 warning: ‘sl3516_ce_pm_resume’ defined but not used [-Wunused-function]
 static int sl3516_ce_pm_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~

Use #ifdef macro to guard this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/gemini/sl3516-ce-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/gemini/sl3516-ce-core.c b/drivers/crypto/gemini/sl3516-ce-core.c
index da6cd529a6c0..00bfc5e19818 100644
--- a/drivers/crypto/gemini/sl3516-ce-core.c
+++ b/drivers/crypto/gemini/sl3516-ce-core.c
@@ -320,6 +320,7 @@ static void sl3516_ce_unregister_algs(struct sl3516_ce_dev *ce)
 	}
 }
 
+#ifdef CONFIG_PM
 static void sl3516_ce_start(struct sl3516_ce_dev *ce)
 {
 	ce->ctx = 0;
@@ -365,6 +366,7 @@ static int sl3516_ce_pm_resume(struct device *dev)
 	sl3516_ce_pm_suspend(dev);
 	return err;
 }
+#endif
 
 static const struct dev_pm_ops sl3516_ce_pm_ops = {
 	SET_RUNTIME_PM_OPS(sl3516_ce_pm_suspend, sl3516_ce_pm_resume, NULL)
-- 
2.17.1

