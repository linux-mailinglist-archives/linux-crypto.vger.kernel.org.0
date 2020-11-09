Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6D2AB30B
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Nov 2020 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKIJCA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Nov 2020 04:02:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7157 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIJCA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Nov 2020 04:02:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CV4k64dkmz15TLS
        for <linux-crypto@vger.kernel.org>; Mon,  9 Nov 2020 17:01:50 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:01:57 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto:hisilicon/sec2 - Fix aead authentication setting key error.
Date:   Mon, 9 Nov 2020 17:00:27 +0800
Message-ID: <1604912427-10543-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix aead auth setting key process error. if use soft shash function, driver
need to use digest size replace of the user input key length.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 87bc08a..891e049 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -857,7 +857,7 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 				 struct crypto_authenc_keys *keys)
 {
 	struct crypto_shash *hash_tfm = ctx->hash_tfm;
-	int blocksize, ret;
+	int blocksize, digestsize, ret;
 
 	if (!keys->authkeylen) {
 		pr_err("hisi_sec2: aead auth key error!\n");
@@ -865,6 +865,7 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 	}
 
 	blocksize = crypto_shash_blocksize(hash_tfm);
+	digestsize = crypto_shash_digestsize(hash_tfm);
 	if (keys->authkeylen > blocksize) {
 		ret = crypto_shash_tfm_digest(hash_tfm, keys->authkey,
 					      keys->authkeylen, ctx->a_key);
@@ -872,7 +873,7 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
 			pr_err("hisi_sec2: aead auth digest error!\n");
 			return -EINVAL;
 		}
-		ctx->a_key_len = blocksize;
+		ctx->a_key_len = digestsize;
 	} else {
 		memcpy(ctx->a_key, keys->authkey, keys->authkeylen);
 		ctx->a_key_len = keys->authkeylen;
-- 
2.8.1

