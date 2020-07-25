Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A054A22D585
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGYGbS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 25 Jul 2020 02:31:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgGYGbR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 25 Jul 2020 02:31:17 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C09B570A2098F182DCAB;
        Sat, 25 Jul 2020 14:31:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 14:31:09 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Keerthy <j-keerthy@ti.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-crypto@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] crypto: sa2ul - fix wrong pointer passed to PTR_ERR()
Date:   Sat, 25 Jul 2020 06:34:40 +0000
Message-ID: <20200725063440.172238-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/crypto/sa2ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index ebcdffcdb686..5bc099052bd2 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2259,7 +2259,7 @@ static int sa_dma_init(struct sa_crypto_data *dd)
 
 	dd->dma_tx = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_tx)) {
-		if (PTR_ERR(dd->dma_rx1) != -EPROBE_DEFER)
+		if (PTR_ERR(dd->dma_tx) != -EPROBE_DEFER)
 			dev_err(dd->dev, "Unable to request tx DMA channel\n");
 		ret = PTR_ERR(dd->dma_tx);
 		goto err_dma_tx;



