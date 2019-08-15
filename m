Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94D98F732
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2019 00:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfHOWrp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 18:47:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57370 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfHOWrp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 18:47:45 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hyOX1-0008T2-Eq; Fri, 16 Aug 2019 08:47:43 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hyOX1-0000qt-8P; Fri, 16 Aug 2019 08:47:43 +1000
Date:   Fri, 16 Aug 2019 08:47:43 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>, linux-crypto@vger.kernel.org
Subject: [v3 PATCH] crypto: hisilicon - Fix warning on printing %p with
 dma_addr_t
Message-ID: <20190815224743.GA3261@gondor.apana.org.au>
References: <20190815120313.GA29253@gondor.apana.org.au>
 <20190815224521.GA3188@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815224521.GA3188@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a printk format warning by replacing %p with %#llx
for dma_addr_t.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index d72e062..4ad4de4 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -347,8 +353,8 @@ static int qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
 	struct qm_mailbox mailbox;
 	int ret = 0;
 
-	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-%pad\n", queue,
-		cmd, dma_addr);
+	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-%llx\n",
+		queue, cmd, (unsigned long long)dma_addr);
 
 	mailbox.w0 = cmd |
 		     (op ? 0x1 << QM_MB_OP_SHIFT : 0) |
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
