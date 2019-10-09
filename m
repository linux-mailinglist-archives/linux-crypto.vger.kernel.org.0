Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E70D1CE8
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Oct 2019 01:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfJIXjr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Oct 2019 19:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJIXjr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Oct 2019 19:39:47 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A6020659;
        Wed,  9 Oct 2019 23:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570664385;
        bh=Q/T8xsVWRWorwlYxy1MSpPnVmBkkjbYTlNrEpb7g494=;
        h=From:To:Cc:Subject:Date:From;
        b=T1gSSBjSeM9NWhzoHO3ynhx1SXPsIMCtWImEJzl4cRvoqD4jzTzdiTVezndaBR2TB
         rH+sJCb9SVS0HqE2qNpVzIqkhAbmKVYH7v6zXTArHTIXLMTxegFYIj64h/6n4TyKJ7
         XvF+buyIztSCSR9/wqXn+SA6N1NR7mG75k5M/uWg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-crypto@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] fscrypt: invoke crypto API for ESSIV handling
Date:   Wed,  9 Oct 2019 16:38:40 -0700
Message-Id: <20191009233840.224128-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of open-coding the calculations for ESSIV handling, use an ESSIV
skcipher which does all of this under the hood.  ESSIV was added to the
crypto API in v5.4.

This is based on a patch from Ard Biesheuvel, but reworked to apply
after all the fscrypt changes that went into v5.4.

Tested with 'kvm-xfstests -c ext4,f2fs -g encrypt', including the
ciphertext verification tests for v1 and v2 encryption policies.

Originally-from: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst |   5 +-
 fs/crypto/crypto.c                    |   4 -
 fs/crypto/fscrypt_private.h           |   7 --
 fs/crypto/keysetup.c                  | 110 +++-----------------------
 fs/crypto/keysetup_v1.c               |   4 -
 5 files changed, 14 insertions(+), 116 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 8a0700af95967..6ec459be3de16 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -308,8 +308,9 @@ If unsure, you should use the (AES-256-XTS, AES-256-CTS-CBC) pair.
 
 AES-128-CBC was added only for low-powered embedded devices with
 crypto accelerators such as CAAM or CESA that do not support XTS.  To
-use AES-128-CBC, CONFIG_CRYPTO_SHA256 (or another SHA-256
-implementation) must be enabled so that ESSIV can be used.
+use AES-128-CBC, CONFIG_CRYPTO_ESSIV and CONFIG_CRYPTO_SHA256 (or
+another SHA-256 implementation) must be enabled so that ESSIV can be
+used.
 
 Adiantum is a (primarily) stream cipher-based mode that is fast even
 on CPUs without dedicated crypto instructions.  It's also a true
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 32a7ad0098cc2..6bc3e4f1e657e 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -27,7 +27,6 @@
 #include <linux/ratelimit.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
-#include <crypto/aes.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
@@ -143,9 +142,6 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 
 	if (fscrypt_is_direct_key_policy(&ci->ci_policy))
 		memcpy(iv->nonce, ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE);
-
-	if (ci->ci_essiv_tfm != NULL)
-		crypto_cipher_encrypt_one(ci->ci_essiv_tfm, iv->raw, iv->raw);
 }
 
 /* Encrypt or decrypt a single filesystem block of file contents */
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index e84efc01512e4..76c64297ce187 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -163,12 +163,6 @@ struct fscrypt_info {
 	/* The actual crypto transform used for encryption and decryption */
 	struct crypto_skcipher *ci_ctfm;
 
-	/*
-	 * Cipher for ESSIV IV generation.  Only set for CBC contents
-	 * encryption, otherwise is NULL.
-	 */
-	struct crypto_cipher *ci_essiv_tfm;
-
 	/*
 	 * Encryption mode used for this inode.  It corresponds to either the
 	 * contents or filenames encryption mode, depending on the inode type.
@@ -444,7 +438,6 @@ struct fscrypt_mode {
 	int keysize;
 	int ivsize;
 	bool logged_impl_name;
-	bool needs_essiv;
 };
 
 static inline bool
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index d71c2d6dd162a..8eb5a0e762ec6 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -8,15 +8,11 @@
  * Heavily modified since then.
  */
 
-#include <crypto/aes.h>
-#include <crypto/sha.h>
 #include <crypto/skcipher.h>
 #include <linux/key.h>
 
 #include "fscrypt_private.h"
 
-static struct crypto_shash *essiv_hash_tfm;
-
 static struct fscrypt_mode available_modes[] = {
 	[FSCRYPT_MODE_AES_256_XTS] = {
 		.friendly_name = "AES-256-XTS",
@@ -31,11 +27,10 @@ static struct fscrypt_mode available_modes[] = {
 		.ivsize = 16,
 	},
 	[FSCRYPT_MODE_AES_128_CBC] = {
-		.friendly_name = "AES-128-CBC",
-		.cipher_str = "cbc(aes)",
+		.friendly_name = "AES-128-CBC-ESSIV",
+		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
 		.ivsize = 16,
-		.needs_essiv = true,
 	},
 	[FSCRYPT_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
@@ -111,97 +106,16 @@ struct crypto_skcipher *fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
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
-			if (PTR_ERR(tfm) == -ENOENT) {
-				fscrypt_warn(NULL,
-					     "Missing crypto API support for SHA-256");
-				return -ENOPKG;
-			}
-			fscrypt_err(NULL,
-				    "Error allocating SHA-256 transform: %ld",
-				    PTR_ERR(tfm));
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
-	if (WARN_ON(ci->ci_mode->ivsize != AES_BLOCK_SIZE))
-		return -EINVAL;
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
-/* Given the per-file key, set up the file's crypto transform object(s) */
+/* Given the per-file key, set up the file's crypto transform object */
 int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 {
-	struct fscrypt_mode *mode = ci->ci_mode;
-	struct crypto_skcipher *ctfm;
-	int err;
-
-	ctfm = fscrypt_allocate_skcipher(mode, derived_key, ci->ci_inode);
-	if (IS_ERR(ctfm))
-		return PTR_ERR(ctfm);
+	struct crypto_skcipher *tfm;
 
-	ci->ci_ctfm = ctfm;
+	tfm = fscrypt_allocate_skcipher(ci->ci_mode, derived_key, ci->ci_inode);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
 
-	if (mode->needs_essiv) {
-		err = init_essiv_generator(ci, derived_key, mode->keysize);
-		if (err) {
-			fscrypt_warn(ci->ci_inode,
-				     "Error initializing ESSIV generator: %d",
-				     err);
-			return err;
-		}
-	}
+	ci->ci_ctfm = tfm;
 	return 0;
 }
 
@@ -388,13 +302,11 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (!ci)
 		return;
 
-	if (ci->ci_direct_key) {
+	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
-	} else if ((ci->ci_ctfm != NULL || ci->ci_essiv_tfm != NULL) &&
-		   !fscrypt_is_direct_key_policy(&ci->ci_policy)) {
+	else if (ci->ci_ctfm != NULL &&
+		 !fscrypt_is_direct_key_policy(&ci->ci_policy))
 		crypto_free_skcipher(ci->ci_ctfm);
-		crypto_free_cipher(ci->ci_essiv_tfm);
-	}
 
 	key = ci->ci_master_key;
 	if (key) {
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index ad1a36c370c3f..5298ef22aa859 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -270,10 +270,6 @@ static int setup_v1_file_key_direct(struct fscrypt_info *ci,
 		return -EINVAL;
 	}
 
-	/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-	if (WARN_ON(mode->needs_essiv))
-		return -EINVAL;
-
 	dk = fscrypt_get_direct_key(ci, raw_master_key);
 	if (IS_ERR(dk))
 		return PTR_ERR(dk);
-- 
2.23.0.581.g78d2f28ef7-goog

