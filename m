Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5B68C56
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jul 2019 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfGONu7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jul 2019 09:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732045AbfGONu7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jul 2019 09:50:59 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9EA212F5;
        Mon, 15 Jul 2019 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198657;
        bh=5fiYdVdy8du8mtSVqQvBcRDYu3eo8LkCIAii7fdOsto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS1roxOHzRYtqoA6fX/zABeXEM9aZd0/7HrBDpkgyfBrWbRmxCSVPHiHEoiJWXx7e
         QphMPbSP44RwfwUoaVDuvZKC/+oBOZVVKp5vzmMmOdym6cT0kLHUHAEN6yyC+bsvRi
         an7SvUF3dijEA/RyuSr6ImxvdrZC1apvlheMx83w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 074/249] crypto: inside-secure - do not rely on the hardware last bit for result descriptors
Date:   Mon, 15 Jul 2019 09:43:59 -0400
Message-Id: <20190715134655.4076-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 89332590427235680236b9470e851afc49b3caa1 ]

When performing a transformation the hardware is given result
descriptors to save the result data. Those result descriptors are
batched using a 'first' and a 'last' bit. There are cases were more
descriptors than needed are given to the engine, leading to the engine
only using some of them, and not setting the last bit on the last
descriptor we gave. This causes issues were the driver and the hardware
aren't in sync anymore about the number of result descriptors given (as
the driver do not give a pool of descriptor to use for any
transformation, but a pool of descriptors to use *per* transformation).

This patch fixes it by attaching the number of given result descriptors
to the requests, and by using this number instead of the 'last' bit
found on the descriptors to process them.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/inside-secure/safexcel_cipher.c    | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index de4be10b172f..ccacdcf07ffc 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -51,6 +51,8 @@ struct safexcel_cipher_ctx {
 
 struct safexcel_cipher_req {
 	enum safexcel_cipher_direction direction;
+	/* Number of result descriptors associated to the request */
+	unsigned int rdescs;
 	bool needs_inv;
 };
 
@@ -333,7 +335,10 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int rin
 
 	*ret = 0;
 
-	do {
+	if (unlikely(!sreq->rdescs))
+		return 0;
+
+	while (sreq->rdescs--) {
 		rdesc = safexcel_ring_next_rptr(priv, &priv->ring[ring].rdr);
 		if (IS_ERR(rdesc)) {
 			dev_err(priv->dev,
@@ -346,7 +351,7 @@ static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int rin
 			*ret = safexcel_rdesc_check_errors(priv, rdesc);
 
 		ndesc++;
-	} while (!rdesc->last_seg);
+	}
 
 	safexcel_complete(priv, ring);
 
@@ -501,6 +506,7 @@ static int safexcel_send_req(struct crypto_async_request *base, int ring,
 static int safexcel_handle_inv_result(struct safexcel_crypto_priv *priv,
 				      int ring,
 				      struct crypto_async_request *base,
+				      struct safexcel_cipher_req *sreq,
 				      bool *should_complete, int *ret)
 {
 	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(base->tfm);
@@ -509,7 +515,10 @@ static int safexcel_handle_inv_result(struct safexcel_crypto_priv *priv,
 
 	*ret = 0;
 
-	do {
+	if (unlikely(!sreq->rdescs))
+		return 0;
+
+	while (sreq->rdescs--) {
 		rdesc = safexcel_ring_next_rptr(priv, &priv->ring[ring].rdr);
 		if (IS_ERR(rdesc)) {
 			dev_err(priv->dev,
@@ -522,7 +531,7 @@ static int safexcel_handle_inv_result(struct safexcel_crypto_priv *priv,
 			*ret = safexcel_rdesc_check_errors(priv, rdesc);
 
 		ndesc++;
-	} while (!rdesc->last_seg);
+	}
 
 	safexcel_complete(priv, ring);
 
@@ -564,7 +573,7 @@ static int safexcel_skcipher_handle_result(struct safexcel_crypto_priv *priv,
 
 	if (sreq->needs_inv) {
 		sreq->needs_inv = false;
-		err = safexcel_handle_inv_result(priv, ring, async,
+		err = safexcel_handle_inv_result(priv, ring, async, sreq,
 						 should_complete, ret);
 	} else {
 		err = safexcel_handle_req_result(priv, ring, async, req->src,
@@ -587,7 +596,7 @@ static int safexcel_aead_handle_result(struct safexcel_crypto_priv *priv,
 
 	if (sreq->needs_inv) {
 		sreq->needs_inv = false;
-		err = safexcel_handle_inv_result(priv, ring, async,
+		err = safexcel_handle_inv_result(priv, ring, async, sreq,
 						 should_complete, ret);
 	} else {
 		err = safexcel_handle_req_result(priv, ring, async, req->src,
@@ -633,6 +642,8 @@ static int safexcel_skcipher_send(struct crypto_async_request *async, int ring,
 		ret = safexcel_send_req(async, ring, sreq, req->src,
 					req->dst, req->cryptlen, 0, 0, req->iv,
 					commands, results);
+
+	sreq->rdescs = *results;
 	return ret;
 }
 
@@ -655,6 +666,7 @@ static int safexcel_aead_send(struct crypto_async_request *async, int ring,
 					req->cryptlen, req->assoclen,
 					crypto_aead_authsize(tfm), req->iv,
 					commands, results);
+	sreq->rdescs = *results;
 	return ret;
 }
 
-- 
2.20.1

