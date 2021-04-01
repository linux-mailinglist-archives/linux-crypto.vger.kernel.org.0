Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7323E35204E
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Apr 2021 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhDAUD3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 1 Apr 2021 16:03:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45358 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhDAUD0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 1 Apr 2021 16:03:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lRz5X-0007xh-9O; Thu, 01 Apr 2021 15:18:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: sun8i-ss: Fix memory leak of pad
Date:   Thu,  1 Apr 2021 16:18:27 +0100
Message-Id: <20210401151827.2015960-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It appears there are several failure return paths that don't seem
to be free'ing pad. Fix these.

Addresses-Coverity: ("Resource leak")
Fixes: d9b45418a917 ("crypto: sun8i-ss - support hash algorithms")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 7d1fc9aba665..3c073eb3db03 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -348,8 +348,10 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	bf = (__le32 *)pad;
 
 	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
-	if (!result)
+	if (!result) {
+		kfree(pad);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < MAX_SG; i++) {
 		rctx->t_dst[i].addr = 0;
@@ -436,10 +438,9 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 		     DMA_TO_DEVICE);
 	dma_unmap_single(ss->dev, addr_res, digestsize, DMA_FROM_DEVICE);
 
-	kfree(pad);
-
 	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
 theend:
+	kfree(pad);
 	kfree(result);
 	crypto_finalize_hash_request(engine, breq, err);
 	return 0;
-- 
2.30.2

