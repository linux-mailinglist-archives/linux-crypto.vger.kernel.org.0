Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90212D5F4
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Dec 2019 04:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfLaDU4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Dec 2019 22:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfLaDUz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Dec 2019 22:20:55 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396492071E
        for <linux-crypto@vger.kernel.org>; Tue, 31 Dec 2019 03:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577762455;
        bh=+ySky2yed36lvWZmPEe0giozAFzjY2zLOVEfSdxW83Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xcCvP7ISEx0Pwjwi2xMrc6wVWJptJlIjQQTS8r+W2x7lZZoROEjETDJCanITRdwZR
         s7bYxBsrh9H38tjQu8/dAih/1YG3THBe+XINeFq/6DcFO/C7Kk4HQLFpYyAQbAfnhV
         BO98WhzqCIbkZ9e9mcIPPfdWWw0XGlNwujVK4Mfw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 5/8] crypto: remove CRYPTO_TFM_RES_BAD_BLOCK_LEN
Date:   Mon, 30 Dec 2019 21:19:35 -0600
Message-Id: <20191231031938.241705-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231031938.241705-1-ebiggers@kernel.org>
References: <20191231031938.241705-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The flag CRYPTO_TFM_RES_BAD_BLOCK_LEN is never checked for, and it's
only set by one driver.  And even that single driver's use is wrong
because the driver is setting the flag from ->encrypt() and ->decrypt()
with no locking, which is unsafe because ->encrypt() and ->decrypt() can
be executed by many threads in parallel on the same tfm.

Just remove this flag.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/crypto/ccree/cc_aead.c   | 1 -
 drivers/crypto/ccree/cc_cipher.c | 1 -
 include/linux/crypto.h           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 64d318dc0d47..b0085db7e211 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -1925,7 +1925,6 @@ static int cc_proc_aead(struct aead_request *req,
 	if (validate_data_size(ctx, direct, req)) {
 		dev_err(dev, "Unsupported crypt/assoc len %d/%d.\n",
 			req->cryptlen, areq_ctx->assoclen);
-		crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_BLOCK_LEN);
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 3112b58d0bb1..61b9dcaa0c05 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -837,7 +837,6 @@ static int cc_cipher_process(struct skcipher_request *req,
 	/* TODO: check data length according to mode */
 	if (validate_data_size(ctx_p, nbytes)) {
 		dev_err(dev, "Unsupported data size %d.\n", nbytes);
-		crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_BAD_BLOCK_LEN);
 		rc = -EINVAL;
 		goto exit_process;
 	}
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 950b592947b2..719a301af3f2 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -114,7 +114,6 @@
 #define CRYPTO_TFM_REQ_MAY_BACKLOG	0x00000400
 #define CRYPTO_TFM_RES_WEAK_KEY		0x00100000
 #define CRYPTO_TFM_RES_BAD_KEY_LEN   	0x00200000
-#define CRYPTO_TFM_RES_BAD_BLOCK_LEN 	0x00800000
 
 /*
  * Miscellaneous stuff.
-- 
2.24.1

