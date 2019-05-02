Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6472111791
	for <lists+linux-crypto@lfdr.de>; Thu,  2 May 2019 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBKrq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 May 2019 06:47:46 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:61744 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKrq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 May 2019 06:47:46 -0400
Received: from beagle7.asicdesigners.com (beagle7.asicdesigners.com [10.192.192.157])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x42AlfZC028171;
        Thu, 2 May 2019 03:47:41 -0700
From:   Atul Gupta <atul.gupta@chelsio.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net, dt@chelsio.com,
        atul.gupta@chelsio.com
Subject: [PATCH 2/4] crypto:chelsio Fix softlockup with heavy I/O
Date:   Thu,  2 May 2019 03:47:27 -0700
Message-Id: <20190502104727.21965-1-atul.gupta@chelsio.com>
X-Mailer: git-send-email 2.20.0.rc2.7.g965798d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

removed un-necessary lock_chcr_dev to protect device state
DETACH. lock is not required to protect I/O count

Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 13 +++----------
 drivers/crypto/chelsio/chcr_core.c |  4 ----
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 8a76fce..73bbd49 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -200,17 +200,10 @@ void chcr_verify_tag(struct aead_request *req, u8 *input, int *err)
 
 static int chcr_inc_wrcount(struct chcr_dev *dev)
 {
-	int err = 0;
-
-	spin_lock_bh(&dev->lock_chcr_dev);
 	if (dev->state == CHCR_DETACH)
-		err = 1;
-	else
-		atomic_inc(&dev->inflight);
-
-	spin_unlock_bh(&dev->lock_chcr_dev);
-
-	return err;
+		return 1;
+	atomic_inc(&dev->inflight);
+	return 0;
 }
 
 static inline void chcr_dec_wrcount(struct chcr_dev *dev)
diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index 239b933..029a735 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -243,15 +243,11 @@ static void chcr_detach_device(struct uld_ctx *u_ctx)
 {
 	struct chcr_dev *dev = &u_ctx->dev;
 
-	spin_lock_bh(&dev->lock_chcr_dev);
 	if (dev->state == CHCR_DETACH) {
-		spin_unlock_bh(&dev->lock_chcr_dev);
 		pr_debug("Detached Event received for already detach device\n");
 		return;
 	}
 	dev->state = CHCR_DETACH;
-	spin_unlock_bh(&dev->lock_chcr_dev);
-
 	if (atomic_read(&dev->inflight) != 0) {
 		schedule_delayed_work(&dev->detach_work, WQ_DETACH_TM);
 		wait_for_completion(&dev->detach_comp);
-- 
1.8.3.1

