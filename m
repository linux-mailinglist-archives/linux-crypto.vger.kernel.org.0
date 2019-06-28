Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF859EAD
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jun 2019 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF1PV1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 11:21:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55386 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfF1PV1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 11:21:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so9493233wmj.5
        for <linux-crypto@vger.kernel.org>; Fri, 28 Jun 2019 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0xMggx8sCHtYZoWnbFzfVaWIhHt1NMPrlumCkcxi6s=;
        b=XTt1qMvcC5Qsj4Wo2Ce/aVoENh3IZytnAHLte8E+icGXB+/D5lkW5C7cqCj13e5/CB
         JCfxfxWAlZjD8CzZ4ZKDU2fJeggYHATnW3zDVQYjgTVVAozPvSPDv6/6yNqo5zPcvgRf
         mbCCNNVlVm+fFLyoY+JONk8UJj9PlsPVn0n992gXkhRrr5bksH24Jc60CRv45gynrvio
         UjcgqC9TOiR4VyxAVMQkAK5VaCyjYYI60K+AqhEK9Qi5u1cyvFkQ0BdqbyKS4yIpf/AU
         UflExKu8M+1il+8U1cBZ1G4NYeu8gpPkxVwmIPBFp1GmjkKywxnj39Omc37B4fgrrKEI
         oICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0xMggx8sCHtYZoWnbFzfVaWIhHt1NMPrlumCkcxi6s=;
        b=tmWYN/nUqjH8+yjw2n6xsvzGaCwbLirKR+TM/5ZkT8+Ctq8x7DuSZP2FDS0LkPymQM
         0o0KgHa3aJCnAGA0IP/irxca+M+OFGpISMCmDIRlcFFDZrMzHo1HmesCxYose4lfcne9
         0djs7hhaFLAyR0dKxG0Z8V7axI2i5g/LRfBl5jNC2kTk8u7vnBIKKzrPjaLqcGwF30uo
         4nPBD9cquwEhzB9Y8FtOnGxR1BVwq7TQxUWjYa88bdMG0k1SbpuzlKReqgTIJnq45Duh
         HbVDH3ckCrq8bv31uMTWIhFnsSaxugJ61GJZUZBJ68cXhd6avnITVe7e10Pc6l+DQfFS
         jcOQ==
X-Gm-Message-State: APjAAAVVGH3yyM0L+pmfwvTzluS+rn4uTG9wGDcCmLPHBbhZ6zas5+IT
        qLXwldvQNaB5mVh/0j3tlDJm4HWLx0g=
X-Google-Smtp-Source: APXvYqx4zniHuiQJqL2VN4wy4jAV4+HW2ydEhHiWygp74CczJuVPEG199rMZThTtteb8T1+qx4wHHw==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr7457904wma.41.1561735284106;
        Fri, 28 Jun 2019 08:21:24 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id u13sm2734319wrq.62.2019.06.28.08.21.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 08:21:23 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>, dm-devel@redhat.com,
        linux-fscrypt@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v6 2/7] fs: crypto: invoke crypto API for ESSIV handling
Date:   Fri, 28 Jun 2019 17:21:07 +0200
Message-Id: <20190628152112.914-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628152112.914-1-ard.biesheuvel@linaro.org>
References: <20190628152112.914-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Instead of open coding the calculations for ESSIV handling, use a
ESSIV skcipher which does all of this under the hood.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 fs/crypto/Kconfig           |  1 +
 fs/crypto/crypto.c          |  5 --
 fs/crypto/fscrypt_private.h |  9 --
 fs/crypto/keyinfo.c         | 95 +-------------------
 4 files changed, 5 insertions(+), 105 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 24ed99e2eca0..b0292da8613c 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -5,6 +5,7 @@ config FS_ENCRYPTION
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_ECB
+	select CRYPTO_ESSIV
 	select CRYPTO_XTS
 	select CRYPTO_CTS
 	select CRYPTO_SHA256
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 335a362ee446..c53ce262a06c 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -136,9 +136,6 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 
 	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY)
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
-
-	if (ci->ci_essiv_tfm != NULL)
-		crypto_cipher_encrypt_one(ci->ci_essiv_tfm, iv->raw, iv->raw);
 }
 
 int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
@@ -492,8 +489,6 @@ static void __exit fscrypt_exit(void)
 		destroy_workqueue(fscrypt_read_workqueue);
 	kmem_cache_destroy(fscrypt_ctx_cachep);
 	kmem_cache_destroy(fscrypt_info_cachep);
-
-	fscrypt_essiv_cleanup();
 }
 module_exit(fscrypt_exit);
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 7da276159593..59d0cba9cfb9 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -61,12 +61,6 @@ struct fscrypt_info {
 	/* The actual crypto transform used for encryption and decryption */
 	struct crypto_skcipher *ci_ctfm;
 
-	/*
-	 * Cipher for ESSIV IV generation.  Only set for CBC contents
-	 * encryption, otherwise is NULL.
-	 */
-	struct crypto_cipher *ci_essiv_tfm;
-
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either
 	 * ci_data_mode or ci_filename_mode, depending on the inode type.
@@ -166,9 +160,6 @@ struct fscrypt_mode {
 	int keysize;
 	int ivsize;
 	bool logged_impl_name;
-	bool needs_essiv;
 };
 
-extern void __exit fscrypt_essiv_cleanup(void);
-
 #endif /* _FSCRYPT_PRIVATE_H */
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index dcd91a3fbe49..f39667d4316a 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -13,14 +13,10 @@
 #include <linux/hashtable.h>
 #include <linux/scatterlist.h>
 #include <linux/ratelimit.h>
-#include <crypto/aes.h>
 #include <crypto/algapi.h>
-#include <crypto/sha.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
-static struct crypto_shash *essiv_hash_tfm;
-
 /* Table of keys referenced by FS_POLICY_FLAG_DIRECT_KEY policies */
 static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
 static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
@@ -144,10 +140,9 @@ static struct fscrypt_mode available_modes[] = {
 	},
 	[FS_ENCRYPTION_MODE_AES_128_CBC] = {
 		.friendly_name = "AES-128-CBC",
-		.cipher_str = "cbc(aes)",
+		.cipher_str = "essiv(cbc(aes),aes,sha256)",
 		.keysize = 16,
-		.ivsize = 16,
-		.needs_essiv = true,
+		.ivsize = 8,
 	},
 	[FS_ENCRYPTION_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
@@ -377,72 +372,6 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
 	return ERR_PTR(err);
 }
 
-static int derive_essiv_salt(const u8 *key, int keysize, u8 *salt)
-{
-	struct crypto_shash *tfm = READ_ONCE(essiv_hash_tfm);
-
-	/* init hash transform on demand */
-	if (unlikely(!tfm)) {
-		struct crypto_shash *prev_tfm;
-
-		tfm = crypto_alloc_shash("sha256", 0, 0);
-		if (IS_ERR(tfm)) {
-			fscrypt_warn(NULL,
-				     "error allocating SHA-256 transform: %ld",
-				     PTR_ERR(tfm));
-			return PTR_ERR(tfm);
-		}
-		prev_tfm = cmpxchg(&essiv_hash_tfm, NULL, tfm);
-		if (prev_tfm) {
-			crypto_free_shash(tfm);
-			tfm = prev_tfm;
-		}
-	}
-
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-		desc->tfm = tfm;
-
-		return crypto_shash_digest(desc, key, keysize, salt);
-	}
-}
-
-static int init_essiv_generator(struct fscrypt_info *ci, const u8 *raw_key,
-				int keysize)
-{
-	int err;
-	struct crypto_cipher *essiv_tfm;
-	u8 salt[SHA256_DIGEST_SIZE];
-
-	essiv_tfm = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(essiv_tfm))
-		return PTR_ERR(essiv_tfm);
-
-	ci->ci_essiv_tfm = essiv_tfm;
-
-	err = derive_essiv_salt(raw_key, keysize, salt);
-	if (err)
-		goto out;
-
-	/*
-	 * Using SHA256 to derive the salt/key will result in AES-256 being
-	 * used for IV generation. File contents encryption will still use the
-	 * configured keysize (AES-128) nevertheless.
-	 */
-	err = crypto_cipher_setkey(essiv_tfm, salt, sizeof(salt));
-	if (err)
-		goto out;
-
-out:
-	memzero_explicit(salt, sizeof(salt));
-	return err;
-}
-
-void __exit fscrypt_essiv_cleanup(void)
-{
-	crypto_free_shash(essiv_hash_tfm);
-}
-
 /*
  * Given the encryption mode and key (normally the derived key, but for
  * FS_POLICY_FLAG_DIRECT_KEY mode it's the master key), set up the inode's
@@ -454,7 +383,6 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 {
 	struct fscrypt_master_key *mk;
 	struct crypto_skcipher *ctfm;
-	int err;
 
 	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) {
 		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
@@ -470,19 +398,6 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
 	ci->ci_master_key = mk;
 	ci->ci_ctfm = ctfm;
 
-	if (mode->needs_essiv) {
-		/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-		WARN_ON(mode->ivsize != AES_BLOCK_SIZE);
-		WARN_ON(ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY);
-
-		err = init_essiv_generator(ci, raw_key, mode->keysize);
-		if (err) {
-			fscrypt_warn(inode->i_sb,
-				     "error initializing ESSIV generator for inode %lu: %d",
-				     inode->i_ino, err);
-			return err;
-		}
-	}
 	return 0;
 }
 
@@ -491,12 +406,10 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (!ci)
 		return;
 
-	if (ci->ci_master_key) {
+	if (ci->ci_master_key)
 		put_master_key(ci->ci_master_key);
-	} else {
+	else
 		crypto_free_skcipher(ci->ci_ctfm);
-		crypto_free_cipher(ci->ci_essiv_tfm);
-	}
 	kmem_cache_free(fscrypt_info_cachep, ci);
 }
 
-- 
2.20.1

