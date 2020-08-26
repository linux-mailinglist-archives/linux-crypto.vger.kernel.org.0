Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B932534ED
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Aug 2020 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHZQaP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Aug 2020 12:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgHZQaE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Aug 2020 12:30:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE96D20825;
        Wed, 26 Aug 2020 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459403;
        bh=dDEoV+9r/Llmk77Z0OE2S9FotxUgZu9Y4tOYpgAYbG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIYgQARZVzbxjgaQuNE+3CwamharL89IZNlCpKsFbIcvS4K5RaqpIsW2v7qqfROfU
         8QAjDNlGCx3kdcuY86EMjMq/iWSRus1UWo7Z5G2rTGdaAtJjDwyHn/N1afmmuhT5AK
         +pogMuiZ9A8HSaI1syxSeCqg2xMzj7xd3HaZB/vc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] crypto: sa2ul - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 18:29:53 +0200
Message-Id: <20200826162954.28636-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826162954.28636-1-krzk@kernel.org>
References: <20200826162954.28636-1-krzk@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/sa2ul.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 4a950437bf44..5a11c2fb7a3a 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2243,25 +2243,21 @@ static int sa_dma_init(struct sa_crypto_data *dd)
 		return ret;
 
 	dd->dma_rx1 = dma_request_chan(dd->dev, "rx1");
-	if (IS_ERR(dd->dma_rx1)) {
-		if (PTR_ERR(dd->dma_rx1) != -EPROBE_DEFER)
-			dev_err(dd->dev, "Unable to request rx1 DMA channel\n");
-		return PTR_ERR(dd->dma_rx1);
-	}
+	if (IS_ERR(dd->dma_rx1))
+		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_rx1),
+				     "Unable to request rx1 DMA channel\n");
 
 	dd->dma_rx2 = dma_request_chan(dd->dev, "rx2");
 	if (IS_ERR(dd->dma_rx2)) {
 		dma_release_channel(dd->dma_rx1);
-		if (PTR_ERR(dd->dma_rx2) != -EPROBE_DEFER)
-			dev_err(dd->dev, "Unable to request rx2 DMA channel\n");
-		return PTR_ERR(dd->dma_rx2);
+		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_rx2),
+				     "Unable to request rx2 DMA channel\n");
 	}
 
 	dd->dma_tx = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_tx)) {
-		if (PTR_ERR(dd->dma_tx) != -EPROBE_DEFER)
-			dev_err(dd->dev, "Unable to request tx DMA channel\n");
-		ret = PTR_ERR(dd->dma_tx);
+		ret = dev_err_probe(dd->dev, PTR_ERR(dd->dma_tx),
+				    "Unable to request tx DMA channel\n");
 		goto err_dma_tx;
 	}
 
-- 
2.17.1

