Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD7418B0
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407951AbfFKXJ4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jun 2019 19:09:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35610 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407949AbfFKXJ4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jun 2019 19:09:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so4600161wml.0
        for <linux-crypto@vger.kernel.org>; Tue, 11 Jun 2019 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcVl9rz8wdPQIbvWbTWkIx9A5zksK1bSEdXxVyTfU04=;
        b=LultKpVs+ZyWYS4B7p0E4oNY5tofY/00+gUA9E6/KHX7ZyefpHt4v43CaQD262NQIt
         4+xgUlvWZ1HMIEocfxvODtLt6OO1UgM8fX5sWFiEDIt3vJNkN/rr0Dc4Px6q7/xAFP8s
         WiRc9K6DFFTCfm+V+GRp116GaLDmNSU+Wbn0KSVJcD5DyCdpWxoC25NC4Xqi9QdM2RXV
         8NM20AjEluabPhyNSDFei0KC5AslhURWH5kv86/IpoX+S/GruCHog8QzDUH3Bzh40B3n
         3KX5I+I+VkoOWLfVfvoMmvs8yg+lDZ123hbOcvzf+UOvwk6KyoHNp4a+/ntWMp9J1R8l
         n0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcVl9rz8wdPQIbvWbTWkIx9A5zksK1bSEdXxVyTfU04=;
        b=DhF7Evm4qnv/4KRMjokxlj5VNHFpdZHM7z2RcVkfLfTuJFIw03mvd9zusL7Y6lYArd
         xSXPSIjkc02GAIcblX77NuvpzR+Mt4FVm9/6KBL+HeZKGYOCbrIdRz4nBcbKvoeYmlWW
         bbV9nN2uGdQWxx65eZs8j2QZciequ1NJSwQlSPgxe2J44LIkozckpT0IbIEL+5mSYfc6
         U0+/xeDtV+x/tnn9jd9a+rDw64LCBXchftlxSiwcJBtqoDgkZz37XFIlVhp56J3O5K6F
         RiVHxtUUEL7Xfm6sD91SkDg9er67unrpUCjI6WqRNfDE6lfr5RR3WEdz54lpDLkU+8OB
         yf+A==
X-Gm-Message-State: APjAAAVGGQbiYCXbNNtbYDOXk9azQ8CFM0qqIC1sDbSJa1NLfCH+N+0W
        CiZ6PzhnlokKIQTmQwKsQF8E6eOgMnhIf/9/
X-Google-Smtp-Source: APXvYqxMYHAeVYdfTTXvxynycbxYcJMfEGnmDqOm92MaSQs3Me3gFx2MvUhL4WRxySzxerOlZfkE6A==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr372887wmk.30.1560294592714;
        Tue, 11 Jun 2019 16:09:52 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:24bb:7f31:25fe:43a7])
        by smtp.gmail.com with ESMTPSA id g11sm10827813wrq.89.2019.06.11.16.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 16:09:52 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>
Subject: [PATCH v4 7/7] fs: cifs: switch to RC4 library interface
Date:   Wed, 12 Jun 2019 01:09:38 +0200
Message-Id: <20190611230938.19265-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611230938.19265-1-ard.biesheuvel@linaro.org>
References: <20190611230938.19265-1-ard.biesheuvel@linaro.org>
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

This also reverts commit 5f4b55699aaf ("CIFS: Fix BUG() in calc_seckey()"),
since it is no longer necessary to allocate sec_key on the heap.

Cc: linux-cifs@vger.kernel.org
Cc: Steve French <sfrench@samba.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 fs/cifs/Kconfig       |  2 +-
 fs/cifs/cifsencrypt.c | 62 +++++---------------
 fs/cifs/cifsfs.c      |  1 -
 3 files changed, 17 insertions(+), 48 deletions(-)

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
index d2a05e46d6f5..97b7497c13ef 100644
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
@@ -772,63 +773,32 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 int
 calc_seckey(struct cifs_ses *ses)
 {
-	int rc;
-	struct crypto_skcipher *tfm_arc4;
-	struct scatterlist sgin, sgout;
-	struct skcipher_request *req;
-	unsigned char *sec_key;
+	unsigned char sec_key[CIFS_SESS_KEY_SIZE]; /* a nonce */
+	struct arc4_ctx *ctx_arc4;
 
-	sec_key = kmalloc(CIFS_SESS_KEY_SIZE, GFP_KERNEL);
-	if (sec_key == NULL)
-		return -ENOMEM;
+	if (fips_enabled)
+		return -ENODEV;
 
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
-		rc = -ENOMEM;
-		cifs_dbg(VFS, "could not allocate crypto API arc4 request\n");
-		goto out_free_cipher;
+	ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+	if (!ctx_arc4) {
+		cifs_dbg(VFS, "could not allocate arc4 context\n");
+		return -ENOMEM;
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
-out:
-	kfree(sec_key);
-	return rc;
+	memzero_explicit(sec_key, CIFS_SESS_KEY_SIZE);
+	kzfree(ctx_arc4);
+	return 0;
 }
 
 void
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f5fcd6360056..e55afaf9e5a3 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1590,7 +1590,6 @@ MODULE_DESCRIPTION
 	("VFS to access SMB3 servers e.g. Samba, Macs, Azure and Windows (and "
 	"also older servers complying with the SNIA CIFS Specification)");
 MODULE_VERSION(CIFS_VERSION);
-MODULE_SOFTDEP("pre: arc4");
 MODULE_SOFTDEP("pre: des");
 MODULE_SOFTDEP("pre: ecb");
 MODULE_SOFTDEP("pre: hmac");
-- 
2.20.1

