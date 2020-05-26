Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B941C2344
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 07:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEBFdo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 01:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgEBFdn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 01:33:43 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FA52184D;
        Sat,  2 May 2020 05:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397623;
        bh=k4dI0GB0gHrRZ6B5OBnAUKIW8i+go/Lv5d59euHt+Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjTav+cQbSGGWuldY8NMdzkNO9onUEpro0ZMhr7pU/UC45gNISZdISyLZYb1Yt5kL
         sq4MdkpOsrSi/PXa8+SRJyip5LNo3edeeuS+SDs1dl8g7NFX1yYZ4WWf7rlPyFo1J6
         8A2RzD4pK7I4AfqqYyCcGvGqQDrlWuZfz5iWZuzc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>
Subject: [PATCH 06/20] crypto: ccree - use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:08 -0700
Message-Id: <20200502053122.995648-7-ebiggers@kernel.org>
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

Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/crypto/ccree/cc_cipher.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index a84335328f371c..872ea3ff1c6ba7 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -427,12 +427,9 @@ static int cc_cipher_setkey(struct crypto_skcipher *sktfm, const u8 *key,
 		int key_len = keylen >> 1;
 		int err;
 
-		SHASH_DESC_ON_STACK(desc, ctx_p->shash_tfm);
-
-		desc->tfm = ctx_p->shash_tfm;
-
-		err = crypto_shash_digest(desc, ctx_p->user.key, key_len,
-					  ctx_p->user.key + key_len);
+		err = crypto_shash_tfm_digest(ctx_p->shash_tfm,
+					      ctx_p->user.key, key_len,
+					      ctx_p->user.key + key_len);
 		if (err) {
 			dev_err(dev, "Failed to hash ESSIV key.\n");
 			return err;
-- 
2.26.2

