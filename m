Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9E4F80C
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Jun 2019 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFVTfH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 Jun 2019 15:35:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39432 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFVTfH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 Jun 2019 15:35:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so9707938wrt.6
        for <linux-crypto@vger.kernel.org>; Sat, 22 Jun 2019 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9xdExBrqYFWsuLQCJksPQkQTr4z/marqcQjFd4StkE=;
        b=PsBUE0nVB+7NLTRtR6PyHt8kVIKwtKhXM6MbVB3kmBDZ2Q5zJhkIli8SQnxDQIVcO+
         LTzL/3qbyvZUvuaC7BsoW+212GWkRVUA1/3CUSu5l9zMD92q5WiRmf17khCwR2dB6/gD
         x4YvZZ+MmpRkcf0iELtnKBcr0QUlDve0+gI1V7+WD77ba4mgSNpXA8dyxW5VbuXJKGIS
         nWCAWMn42S/scchluEKUaN+rWc0fuKBFufPf2+pk+L1EmlAsRtFoiAXSviPVjlgIMOyX
         8V1jXySbsLywmRGOlOpYXIhykxYKCa//Ss3BK3jsLW42RqNBLDQrkkYz2PJH1rh3Gjib
         WRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9xdExBrqYFWsuLQCJksPQkQTr4z/marqcQjFd4StkE=;
        b=FxLjAkDkpFgxchSQdLgk7qx+j7cqUi6PYRt1MGmvHucYxBoN9dnT8MPGC9QVOVvbad
         sPYpmBSNPAnalTFLNdJWJYRETHtRe09kRw9l5dRga9wtBcGzsuO9mAP8zCsTtNKHCHXj
         SfUP8KxVdl9XUGl3ywSyMndjKF9IHHArwFc2z+de0AdPsfWv2v5cKD59fU5qXZ3ejwPM
         tAfPmG5vpkzedDWjpsSYFczLAfaW4CQRPzZNq6sAEbnUHFLAizLUW+zaB4+teZjAdJU7
         a7adfpjPExfHgxoOet50IYKTOGQQDwDynsc3V3HpeL1OOTbgBvyb+NYFw7tvbIwvLij2
         Xnzw==
X-Gm-Message-State: APjAAAWYL0X/bmhHV7IT4fIFRq7R+dNrOAQ9D0ZK8ASp/T/IAKhcUVWt
        2w9+e5e8Wg5+1jEVmGavDXSeFTZ6EVZEQTFN
X-Google-Smtp-Source: APXvYqy8nWkPciJM4IFoU+/j58FBu3MzleUOUcPASWIvHlvWs3PYLIvdZzXGP+pKOHDF4x9oD3rBPw==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr15715931wrv.228.1561232105612;
        Sat, 22 Jun 2019 12:35:05 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id h8sm4814494wmf.12.2019.06.22.12.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 12:35:04 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@google.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 24/26] crypto: amcc/aes - switch to AES library for GCM key derivation
Date:   Sat, 22 Jun 2019 21:34:25 +0200
Message-Id: <20190622193427.20336-25-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622193427.20336-1-ard.biesheuvel@linaro.org>
References: <20190622193427.20336-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The AMCC code for GCM key derivation allocates a AES cipher to
perform a single block encryption. So let's switch to the new
and more lightweight AES library instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/Kconfig              |  2 +-
 drivers/crypto/amcc/crypto4xx_alg.c | 24 +++++++-------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b30b84089d11..c7ac1e6d23d4 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -311,7 +311,7 @@ config CRYPTO_DEV_PPC4XX
 	depends on PPC && 4xx
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
-	select CRYPTO_AES
+	select CRYPTO_LIB_AES
 	select CRYPTO_CCM
 	select CRYPTO_CTR
 	select CRYPTO_GCM
diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
index 26f86fd7532b..d3660703a36c 100644
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -536,28 +536,20 @@ static int crypto4xx_aes_gcm_validate_keylen(unsigned int keylen)
 static int crypto4xx_compute_gcm_hash_key_sw(__le32 *hash_start, const u8 *key,
 					     unsigned int keylen)
 {
-	struct crypto_cipher *aes_tfm = NULL;
+	struct crypto_aes_ctx ctx;
 	uint8_t src[16] = { 0 };
-	int rc = 0;
-
-	aes_tfm = crypto_alloc_cipher("aes", 0, CRYPTO_ALG_NEED_FALLBACK);
-	if (IS_ERR(aes_tfm)) {
-		rc = PTR_ERR(aes_tfm);
-		pr_warn("could not load aes cipher driver: %d\n", rc);
-		return rc;
-	}
+	int rc;
 
-	rc = crypto_cipher_setkey(aes_tfm, key, keylen);
+	rc = aes_expandkey(&ctx, key, keylen);
 	if (rc) {
-		pr_err("setkey() failed: %d\n", rc);
-		goto out;
+		pr_err("aes_expandkey() failed: %d\n", rc);
+		return rc;
 	}
 
-	crypto_cipher_encrypt_one(aes_tfm, src, src);
+	aes_encrypt(&ctx, src, src);
 	crypto4xx_memcpy_to_le32(hash_start, src, 16);
-out:
-	crypto_free_cipher(aes_tfm);
-	return rc;
+	memzero_explicit(&ctx, sizeof(ctx));
+	return 0;
 }
 
 int crypto4xx_setkey_aes_gcm(struct crypto_aead *cipher,
-- 
2.20.1

