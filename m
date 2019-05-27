Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8492B7DC
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE0Ovp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:51:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44561 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfE0Ovn (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:51:43 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8EFE8FF80A;
        Mon, 27 May 2019 14:51:38 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 10/14] crypto: inside-secure - fix queued len computation
Date:   Mon, 27 May 2019 16:51:02 +0200
Message-Id: <20190527145106.8693-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes the queued len computation, which could theoretically
be wrong if req->len[1] - req->processed[1] > 1. Be future-proof here,
and fix it.

Fixes: b460edb6230a ("crypto: inside-secure - sha512 support")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index ba0732fd4ed4..a9197d2c5a48 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -50,10 +50,12 @@ struct safexcel_ahash_req {
 
 static inline u64 safexcel_queued_len(struct safexcel_ahash_req *req)
 {
-	if (req->len[1] > req->processed[1])
-		return 0xffffffff - (req->len[0] - req->processed[0]);
+	u64 len, processed;
 
-	return req->len[0] - req->processed[0];
+	len = (0xffffffff * req->len[1]) + req->len[0];
+	processed = (0xffffffff * req->processed[1]) + req->processed[0];
+
+	return len - processed;
 }
 
 static void safexcel_hash_token(struct safexcel_command_desc *cdesc,
-- 
2.21.0

