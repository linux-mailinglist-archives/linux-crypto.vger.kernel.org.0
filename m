Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EF241434
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Aug 2020 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHKAkZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Aug 2020 20:40:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:53559 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgHKAkW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Aug 2020 20:40:22 -0400
IronPort-SDR: +lbkEo8UTbqsYEy+Kx5Wkgs/IrHHvk8HhZHkpjUGC7vBPDw3W9wg7Q3TuCvbi0D3+gvX6w1BnK
 q3o2GBxcKzfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="133702730"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="133702730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 17:40:22 -0700
IronPort-SDR: 4KwrpTikzKV4zjn64At1FloqSN6qds/J4ji62sT+PCJogKM79T8JM18IrbJHXYLkr4NH8ATg14
 P3072sUllW4Q==
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="494978727"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 17:40:21 -0700
From:   ira.weiny@intel.com
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto/ux500: Fix kmap() bug
Date:   Mon, 10 Aug 2020 17:40:14 -0700
Message-Id: <20200811004015.2800392-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200811004015.2800392-1-ira.weiny@intel.com>
References: <20200811004015.2800392-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Once the crypto hash walk is started by crypto_hash_walk_first()
returning non-zero, crypto_hash_walk_done() must be called to unmap any
memory which was mapped by *_walk_first().

Ensure crypto_hash_walk_done() is called properly by:

	1) Re-arranging the check for device data to be prior to calling
	   *_walk_first()
	2) on error call crypto_hash_walk_done() with an error code to
	   allow the hash walk code to clean up.

While we are at it clean up the 'out' label to be more meaningful.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
	Not tested.
	Found via code inspection.
---
 drivers/crypto/ux500/hash/hash_core.c | 30 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index c24f2db8d5e8..5f407a3420f8 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -1071,27 +1071,32 @@ int hash_hw_update(struct ahash_request *req)
 	struct hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct hash_req_ctx *req_ctx = ahash_request_ctx(req);
 	struct crypto_hash_walk walk;
-	int msg_length = crypto_hash_walk_first(req, &walk);
-
-	/* Empty message ("") is correct indata */
-	if (msg_length == 0)
-		return ret;
+	int msg_length;
 
 	index = req_ctx->state.index;
 	buffer = (u8 *)req_ctx->state.buffer;
 
+	ret = hash_get_device_data(ctx, &device_data);
+	if (ret)
+		return ret;
+
+	msg_length = crypto_hash_walk_first(req, &walk);
+
+	/* Empty message ("") is correct indata */
+	if (msg_length == 0) {
+		ret = 0;
+		goto release_dev;
+	}
+
 	/* Check if ctx->state.length + msg_length
 	   overflows */
 	if (msg_length > (req_ctx->state.length.low_word + msg_length) &&
 	    HASH_HIGH_WORD_MAX_VAL == req_ctx->state.length.high_word) {
 		pr_err("%s: HASH_MSG_LENGTH_OVERFLOW!\n", __func__);
-		return -EPERM;
+		ret = crypto_hash_walk_done(&walk, -EPERM);
+		goto release_dev;
 	}
 
-	ret = hash_get_device_data(ctx, &device_data);
-	if (ret)
-		return ret;
-
 	/* Main loop */
 	while (0 != msg_length) {
 		data_buffer = walk.data;
@@ -1101,7 +1106,8 @@ int hash_hw_update(struct ahash_request *req)
 		if (ret) {
 			dev_err(device_data->dev, "%s: hash_internal_hw_update() failed!\n",
 				__func__);
-			goto out;
+			crypto_hash_walk_done(&walk, ret);
+			goto release_dev;
 		}
 
 		msg_length = crypto_hash_walk_done(&walk, 0);
@@ -1111,7 +1117,7 @@ int hash_hw_update(struct ahash_request *req)
 	dev_dbg(device_data->dev, "%s: indata length=%d, bin=%d\n",
 		__func__, req_ctx->state.index, req_ctx->state.bit_index);
 
-out:
+release_dev:
 	release_hash_device(device_data);
 
 	return ret;
-- 
2.28.0.rc0.12.gb6a658bd00c9

