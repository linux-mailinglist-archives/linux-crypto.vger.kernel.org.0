Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649311C2340
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 07:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEBFdf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 01:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgEBFdf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 01:33:35 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E07320643
        for <linux-crypto@vger.kernel.org>; Sat,  2 May 2020 05:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397615;
        bh=mgAQWx3YPWufgVopYjpl/NTHhVsiPfEnGvfZih9FCOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1YTK2g4aZ2ZKA1ffP1YUk5Jey5HbpkpnYWpJdU9+oHOkaOT9b4pS2awMqrIEnyGPI
         9jpdKeBu6e2kF0EV5Gx1HbfeQvtzs8ZaMkVFcOhzvUwznm41qmsPZmBO3w/YUGXGQG
         sS3/uYqT56bdEUkjoA8z5+fQ2kbTQ/2YRuJphWxc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 03/20] crypto: essiv - use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:05 -0700
Message-Id: <20200502053122.995648-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/essiv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/essiv.c b/crypto/essiv.c
index 465a89c9d1effe..a7f45dbc4ee289 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -66,7 +66,6 @@ static int essiv_skcipher_setkey(struct crypto_skcipher *tfm,
 				 const u8 *key, unsigned int keylen)
 {
 	struct essiv_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
-	SHASH_DESC_ON_STACK(desc, tctx->hash);
 	u8 salt[HASH_MAX_DIGESTSIZE];
 	int err;
 
@@ -78,8 +77,7 @@ static int essiv_skcipher_setkey(struct crypto_skcipher *tfm,
 	if (err)
 		return err;
 
-	desc->tfm = tctx->hash;
-	err = crypto_shash_digest(desc, key, keylen, salt);
+	err = crypto_shash_tfm_digest(tctx->hash, key, keylen, salt);
 	if (err)
 		return err;
 
-- 
2.26.2

