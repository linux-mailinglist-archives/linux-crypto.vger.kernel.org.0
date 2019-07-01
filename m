Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 580F23CD52
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Jun 2019 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbfFKNsF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jun 2019 09:48:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbfFKNsF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jun 2019 09:48:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so3042347wmj.3
        for <linux-crypto@vger.kernel.org>; Tue, 11 Jun 2019 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CZ7XNP6ncpKBw0YJudQO1JgyRd0fuR40ry6DWOpcj4=;
        b=Jpyybqlurfd8p8HkRweWx9A0ZRZRilrim08I8+62egJ0xAS8tiahGPiVz7xuNNXCBg
         6nCHBPnqGNKdvljtQN9d1ojCYrj5nfQwrvCnKva3USqRdCqmYd3Komp1ou8KiqViYDQp
         Y47OauyVN8Fzy4YQxyG90+u2pC9mcRjt7BiKS0kTyG9Sk8HZQ/8dbxiGdoKRWVu7HaxD
         tQiw4lsxthogrO0uShmlz2yz68rPA2p/vNfA55oQAH/nTEEte46iJRn3S+Zbj5aU+4Ve
         V+AclEU688L+c2wmvK445FKZBCHYQCq3jMQKNoYDWdskNjbYLPJj+NY61LIH1l1/gZC3
         RMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CZ7XNP6ncpKBw0YJudQO1JgyRd0fuR40ry6DWOpcj4=;
        b=ETJoBgDFZCyzFi/XmnOOPe4zOWag7meXRrwR/VYFPdDD5dA2AXrT0m5jSqKjlMXuRL
         9OktVwMZKg9OLOoj8Lm3kE/vHf6dkK2llbCvMygac8mDjC/+V0Xw28YVbRWi+5qIx/h9
         wtxn89iK/MZu7PEkSvw0JYx50g6z/ZTFQSOwgE1J4hureau0nj6eY7qJ4z+migdds2lI
         do9EWc9LDkuIw4GR5+aWlBycdD3sXlrFz8dwmQZ6oHV0S77dcfAhMCocX+67GJSEj61F
         MNZVV3ivmA1lAzt4KF6K2s3wzY2+M43rXRpwUugXZi5tT3UE7nTS519H3uLZBIY824Gi
         5Bog==
X-Gm-Message-State: APjAAAWbI6XP2p7I5qTcMRRe+M4BuqAlf5g1P9lNyrkdGKgzTLZmbANZ
        Rvfmx08tdXZqkA52QQ9VuzTkweWkAB3aLF9H
X-Google-Smtp-Source: APXvYqykFvdzrVY18edtq46qoHfHf3p2RGGd1PJ7mo4pHhVHCSHHI4aen/Ca4c6s/pQLyrvXyxHavw==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr18173175wmu.137.1560260883273;
        Tue, 11 Jun 2019 06:48:03 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:24bb:7f31:25fe:43a7])
        by smtp.gmail.com with ESMTPSA id o126sm3964305wmo.31.2019.06.11.06.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:48:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>
Subject: [PATCH v3 7/7] fs: cifs: switch to RC4 library interface
Date:   Tue, 11 Jun 2019 15:47:50 +0200
Message-Id: <20190611134750.2974-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611134750.2974-1-ard.biesheuvel@linaro.org>
References: <20190611134750.2974-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The CIFS code uses the sync skcipher API to invoke the ecb(arc4) skcipher,
of which only a single generic C code implementation exists. This means
that going through all the trouble of using scatterlists etc buys us
very little, and we're better off just invoking the arc4 library directly.

Cc: linux-cifs@vger.kernel.org
Cc: Steve French <sfrench@samba.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 fs/cifs/Kconfig       |  2 +-
 fs/cifs/cifsencrypt.c | 53 ++++++--------------
 2 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index aae2b8b2adf5..523e9ea78a28 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -10,7 +10,7 @@ config CIFS
 	select CRYPTO_SHA512
 	select CRYPTO_CMAC
 	select CRYPTO_HMAC
-	select CRYPTO_ARC4
+	select CRYPTO_LIB_ARC4
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
 	select CRYPTO_ECB
diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index d2a05e46d6f5..3b7b5e83493d 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -33,7 +33,8 @@
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/highmem.h>
-#include <crypto/skcipher.h>
+#include <linux/fips.h>
+#include <crypto/arc4.h>
 #include <crypto/aead.h>
 
 int __cifs_calc_signature(struct smb_rqst *rqst,
@@ -772,11 +773,12 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 int
 calc_seckey(struct cifs_ses *ses)
 {
-	int rc;
-	struct crypto_skcipher *tfm_arc4;
-	struct scatterlist sgin, sgout;
-	struct skcipher_request *req;
+	struct arc4_ctx *ctx_arc4;
 	unsigned char *sec_key;
+	int rc = 0;
+
+	if (fips_enabled)
+		return -ENODEV;
 
 	sec_key = kmalloc(CIFS_SESS_KEY_SIZE, GFP_KERNEL);
 	if (sec_key == NULL)
@@ -784,49 +786,24 @@ calc_seckey(struct cifs_ses *ses)
 
 	get_random_bytes(sec_key, CIFS_SESS_KEY_SIZE);
 
-	tfm_arc4 = crypto_alloc_skcipher("ecb(arc4)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm_arc4)) {
-		rc = PTR_ERR(tfm_arc4);
-		cifs_dbg(VFS, "could not allocate crypto API arc4\n");
-		goto out;
-	}
-
-	rc = crypto_skcipher_setkey(tfm_arc4, ses->auth_key.response,
-					CIFS_SESS_KEY_SIZE);
-	if (rc) {
-		cifs_dbg(VFS, "%s: Could not set response as a key\n",
-			 __func__);
-		goto out_free_cipher;
-	}
-
-	req = skcipher_request_alloc(tfm_arc4, GFP_KERNEL);
-	if (!req) {
+	ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+	if (!ctx_arc4) {
 		rc = -ENOMEM;
-		cifs_dbg(VFS, "could not allocate crypto API arc4 request\n");
-		goto out_free_cipher;
+		cifs_dbg(VFS, "could not allocate arc4 context\n");
+		goto out;
 	}
 
-	sg_init_one(&sgin, sec_key, CIFS_SESS_KEY_SIZE);
-	sg_init_one(&sgout, ses->ntlmssp->ciphertext, CIFS_CPHTXT_SIZE);
-
-	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, &sgin, &sgout, CIFS_CPHTXT_SIZE, NULL);
-
-	rc = crypto_skcipher_encrypt(req);
-	skcipher_request_free(req);
-	if (rc) {
-		cifs_dbg(VFS, "could not encrypt session key rc: %d\n", rc);
-		goto out_free_cipher;
-	}
+	arc4_setkey(ctx_arc4, ses->auth_key.response, CIFS_SESS_KEY_SIZE);
+	arc4_crypt(ctx_arc4, ses->ntlmssp->ciphertext, sec_key,
+		   CIFS_CPHTXT_SIZE);
 
 	/* make secondary_key/nonce as session key */
 	memcpy(ses->auth_key.response, sec_key, CIFS_SESS_KEY_SIZE);
 	/* and make len as that of session key only */
 	ses->auth_key.len = CIFS_SESS_KEY_SIZE;
 
-out_free_cipher:
-	crypto_free_skcipher(tfm_arc4);
 out:
+	kfree(ctx_arc4);
 	kfree(sec_key);
 	return rc;
 }
-- 
2.20.1

