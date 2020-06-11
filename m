Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906171F6B2F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2020 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFKPjl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jun 2020 11:39:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPjk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jun 2020 11:39:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jjPIk-0007Go-OY; Thu, 11 Jun 2020 15:39:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/qi2: remove redundant assignment to ret
Date:   Thu, 11 Jun 2020 16:39:34 +0100
Message-Id: <20200611153934.928021-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read, the
error exit path via label 'unmap' returns -ENOMEM anyhow, so assigning
ret with -ENOMEM is redundamt.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 28669cbecf77..ef2c4e095db3 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4044,7 +4044,6 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 					  DMA_TO_DEVICE);
 	if (dma_mapping_error(ctx->dev, edesc->qm_sg_dma)) {
 		dev_err(ctx->dev, "unable to map S/G table\n");
-		ret = -ENOMEM;
 		goto unmap;
 	}
 	edesc->qm_sg_bytes = qm_sg_bytes;
@@ -4055,7 +4054,6 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	if (dma_mapping_error(ctx->dev, state->ctx_dma)) {
 		dev_err(ctx->dev, "unable to map ctx\n");
 		state->ctx_dma = 0;
-		ret = -ENOMEM;
 		goto unmap;
 	}
 
-- 
2.27.0.rc0

