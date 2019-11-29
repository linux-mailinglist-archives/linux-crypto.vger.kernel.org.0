Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491D310D997
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Nov 2019 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfK2SYT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Nov 2019 13:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfK2SYS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Nov 2019 13:24:18 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C49821736
        for <linux-crypto@vger.kernel.org>; Fri, 29 Nov 2019 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575051857;
        bh=oPjhjdDqYKLeD2sVzw6rzRl6CgtNz0m1bOH25zmgxOs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dm90DGDbCG2eL4b8I6zkQsZMGoXzt5vw3F2Q/bmt2043/MzAb15Qcz1KyQ/9Yzp0t
         E3ElhheffqtWpPtr9T5BrdNRjnEprjsiJoKPC0hSi2j3qf04ULGyvrRoX7hsp45F/E
         bz/f6v3Or17/qozC4pBPLUqJ/bq8isON+ApBj36A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 4/6] crypto: skcipher - remove crypto_skcipher::encrypt
Date:   Fri, 29 Nov 2019 10:23:06 -0800
Message-Id: <20191129182308.53961-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191129182308.53961-1-ebiggers@kernel.org>
References: <20191129182308.53961-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Due to the removal of the blkcipher and ablkcipher algorithm types,
crypto_skcipher::encrypt is now redundant since it always equals
crypto_skcipher_alg(tfm)->encrypt.

Remove it and update crypto_skcipher_encrypt() accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/skcipher.c         | 3 +--
 include/crypto/skcipher.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 4197b5ed57c4..926295ce1b07 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -648,7 +648,7 @@ int crypto_skcipher_encrypt(struct skcipher_request *req)
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
-		ret = tfm->encrypt(req);
+		ret = crypto_skcipher_alg(tfm)->encrypt(req);
 	crypto_stats_skcipher_encrypt(cryptlen, ret, alg);
 	return ret;
 }
@@ -684,7 +684,6 @@ static int crypto_skcipher_init_tfm(struct crypto_tfm *tfm)
 	struct crypto_skcipher *skcipher = __crypto_skcipher_cast(tfm);
 	struct skcipher_alg *alg = crypto_skcipher_alg(skcipher);
 
-	skcipher->encrypt = alg->encrypt;
 	skcipher->decrypt = alg->decrypt;
 
 	skcipher_set_needkey(skcipher);
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index ea94cc422b94..694215a59719 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -35,7 +35,6 @@ struct skcipher_request {
 };
 
 struct crypto_skcipher {
-	int (*encrypt)(struct skcipher_request *req);
 	int (*decrypt)(struct skcipher_request *req);
 
 	unsigned int reqsize;
-- 
2.24.0

