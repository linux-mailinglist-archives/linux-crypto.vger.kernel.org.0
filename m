Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBA13E457
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbgAPRHs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 12:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387474AbgAPRHq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51619217F4;
        Thu, 16 Jan 2020 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194466;
        bh=Yw7Sxwca5v+5wc2avdjj/iOaHU0AHaZFoEdAY1dbTaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8p+xcfMr6RUXwVUWCf7TRoWlxWlFkcB5gFffskG8LlD1BtLEh6A3uhCMFXh1nmfJ
         Jlx6eyCk0jGwG1NDTJlCVfCbg3HY49m8WEYgrByh0dgfpTnyN8kRhQYWjHhPSq6fxA
         mQ3Zmuk/REDx5VNr1mVm+yO/G898R/Ur7+z07iN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Hook, Gary" <Gary.Hook@amd.com>, Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 372/671] crypto: ccp - Fix 3DES complaint from ccp-crypto module
Date:   Thu, 16 Jan 2020 12:00:10 -0500
Message-Id: <20200116170509.12787-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: "Hook, Gary" <Gary.Hook@amd.com>

[ Upstream commit 89646fdda4cae203185444ac7988835f36a21ee1 ]

Crypto self-tests reveal an error:

alg: skcipher: cbc-des3-ccp encryption test failed (wrong output IV) on test vector 0, cfg="in-place"

The offset value should not be recomputed when retrieving the context.
Also, a code path exists which makes decisions based on older (version 3)
hardware; a v3 device deosn't support 3DES so remove this check.

Fixes: 990672d48515 ('crypto: ccp - Enable 3DES function on v5 CCPs')

Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-ops.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index 1e2e42106dee..4b48b8523a40 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -1293,6 +1293,9 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	int ret;
 
 	/* Error checks */
+	if (cmd_q->ccp->vdata->version < CCP_VERSION(5, 0))
+		return -EINVAL;
+
 	if (!cmd_q->ccp->vdata->perform->des3)
 		return -EINVAL;
 
@@ -1375,8 +1378,6 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	 * passthru option to convert from big endian to little endian.
 	 */
 	if (des3->mode != CCP_DES3_MODE_ECB) {
-		u32 load_mode;
-
 		op.sb_ctx = cmd_q->sb_ctx;
 
 		ret = ccp_init_dm_workarea(&ctx, cmd_q,
@@ -1392,12 +1393,8 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 		if (ret)
 			goto e_ctx;
 
-		if (cmd_q->ccp->vdata->version == CCP_VERSION(3, 0))
-			load_mode = CCP_PASSTHRU_BYTESWAP_NOOP;
-		else
-			load_mode = CCP_PASSTHRU_BYTESWAP_256BIT;
 		ret = ccp_copy_to_sb(cmd_q, &ctx, op.jobid, op.sb_ctx,
-				     load_mode);
+				     CCP_PASSTHRU_BYTESWAP_256BIT);
 		if (ret) {
 			cmd->engine_error = cmd_q->cmd_error;
 			goto e_ctx;
@@ -1459,10 +1456,6 @@ static int ccp_run_des3_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 		}
 
 		/* ...but we only need the last DES3_EDE_BLOCK_SIZE bytes */
-		if (cmd_q->ccp->vdata->version == CCP_VERSION(3, 0))
-			dm_offset = CCP_SB_BYTES - des3->iv_len;
-		else
-			dm_offset = 0;
 		ccp_get_dm_area(&ctx, dm_offset, des3->iv, 0,
 				DES3_EDE_BLOCK_SIZE);
 	}
-- 
2.20.1

