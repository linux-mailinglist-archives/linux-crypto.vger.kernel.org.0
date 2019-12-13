Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081D211E2E3
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Dec 2019 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfLMLjq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Dec 2019 06:39:46 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:56925 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMLjq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Dec 2019 06:39:46 -0500
Received: from heptagon.asicdesigners.com (heptagon.blr.asicdesigners.com [10.193.186.108])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id xBDBdaGr024768;
        Fri, 13 Dec 2019 03:39:38 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     atul.gupta@chelsio.com, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [Crypto/chcr] calculating tx_channel_id as per the max number of channels
Date:   Fri, 13 Dec 2019 17:08:52 +0530
Message-Id: <1576237132-15580-1-git-send-email-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

chcr driver was not using the number of channels from lld and
assuming that there are always two channels available. With following
patch chcr will use number of channel as passed by cxgb4.

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 1b4a566..586dbc6 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -1379,7 +1379,8 @@ static int chcr_device_init(struct chcr_context *ctx)
 		txq_perchan = ntxq / u_ctx->lldi.nchan;
 		spin_lock(&ctx->dev->lock_chcr_dev);
 		ctx->tx_chan_id = ctx->dev->tx_channel_id;
-		ctx->dev->tx_channel_id = !ctx->dev->tx_channel_id;
+		ctx->dev->tx_channel_id =
+			(ctx->dev->tx_channel_id + 1) %  u_ctx->lldi.nchan;
 		spin_unlock(&ctx->dev->lock_chcr_dev);
 		rxq_idx = ctx->tx_chan_id * rxq_perchan;
 		rxq_idx += id % rxq_perchan;
-- 
2.1.4

