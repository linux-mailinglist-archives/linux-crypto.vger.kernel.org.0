Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CEC11792
	for <lists+linux-crypto@lfdr.de>; Thu,  2 May 2019 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBKsD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 May 2019 06:48:03 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:32869 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKsD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 May 2019 06:48:03 -0400
Received: from beagle7.asicdesigners.com (beagle7.asicdesigners.com [10.192.192.157])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x42AlxuD028174;
        Thu, 2 May 2019 03:47:59 -0700
From:   Atul Gupta <atul.gupta@chelsio.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net, dt@chelsio.com,
        atul.gupta@chelsio.com
Subject: [PATCH 3/4] crypto:chelsio count incomplete block in IV
Date:   Thu,  2 May 2019 03:47:57 -0700
Message-Id: <20190502104757.22234-1-atul.gupta@chelsio.com>
X-Mailer: git-send-email 2.20.0.rc2.7.g965798d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The partial block should count as one and appropriately appended
to IV. eg 499B for AES CTR should count 32 block than 31 and
correct count value is updated in iv out.

Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 73bbd49..177f572 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -1094,8 +1094,8 @@ static int chcr_final_cipher_iv(struct ablkcipher_request *req,
 	int ret = 0;
 
 	if (subtype == CRYPTO_ALG_SUB_TYPE_CTR)
-		ctr_add_iv(iv, req->info, (reqctx->processed /
-			   AES_BLOCK_SIZE));
+		ctr_add_iv(iv, req->info, DIV_ROUND_UP(reqctx->processed,
+						       AES_BLOCK_SIZE));
 	else if (subtype == CRYPTO_ALG_SUB_TYPE_XTS)
 		ret = chcr_update_tweak(req, iv, 1);
 	else if (subtype == CRYPTO_ALG_SUB_TYPE_CBC) {
-- 
1.8.3.1

