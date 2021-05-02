Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5E370C2B
	for <lists+linux-crypto@lfdr.de>; Sun,  2 May 2021 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhEBOFb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 2 May 2021 10:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhEBOFM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 2 May 2021 10:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87EA5613C5;
        Sun,  2 May 2021 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619964259;
        bh=kNPe/SFWIIckViLfrJ2WNeL1mt+grkRMvXYc8z6Qm3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwYCAvNA91j6kefB6bKW1ypfZaBUVGgLNU7QnERH6nP8cF7powhK7afIsVkpJxrlB
         2bGpD2uTEn0mPyUSWBM9E8FTTqfINZewAlXqnNo/lc4t5m/KF60o88QADqn96naxo0
         C2WP1zglLrg4+20LLJWnMEfLkicwWknxXvcteoF+g6Hq417WrUQNKFdDeIolQBFMCD
         sVi7w5cyfBhB6pTEFTuf9ODyUK5O/xJp6mIqJC2xbqoH7W07iDN2l3/i6SkbutkCYb
         xk+9gCFCBWduIg3up81Mq96FC/jSddFIMSCF3aaDurkouc78N0fmMHyD85y0Y4PESi
         Lead9mWw1hI+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/66] crypto: api - check for ERR pointers in crypto_destroy_tfm()
Date:   Sun,  2 May 2021 10:03:11 -0400
Message-Id: <20210502140411.2719301-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210502140411.2719301-1-sashal@kernel.org>
References: <20210502140411.2719301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 83681f2bebb34dbb3f03fecd8f570308ab8b7c2c ]

Given that crypto_alloc_tfm() may return ERR pointers, and to avoid
crashes on obscure error paths where such pointers are presented to
crypto_destroy_tfm() (such as [0]), add an ERR_PTR check there
before dereferencing the second argument as a struct crypto_tfm
pointer.

[0] https://lore.kernel.org/linux-crypto/000000000000de949705bc59e0f6@google.com/

Reported-by: syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/api.c               | 2 +-
 include/crypto/acompress.h | 2 ++
 include/crypto/aead.h      | 2 ++
 include/crypto/akcipher.h  | 2 ++
 include/crypto/hash.h      | 4 ++++
 include/crypto/kpp.h       | 2 ++
 include/crypto/rng.h       | 2 ++
 include/crypto/skcipher.h  | 2 ++
 8 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/crypto/api.c b/crypto/api.c
index ed08cbd5b9d3..c4eda56cff89 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -562,7 +562,7 @@ void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
 {
 	struct crypto_alg *alg;
 
-	if (unlikely(!mem))
+	if (IS_ERR_OR_NULL(mem))
 		return;
 
 	alg = tfm->__crt_alg;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index fcde59c65a81..cb3d6b1c655d 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -165,6 +165,8 @@ static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *req)
  * crypto_free_acomp() -- free ACOMPRESS tfm handle
  *
  * @tfm:	ACOMPRESS tfm handle allocated with crypto_alloc_acomp()
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_acomp(struct crypto_acomp *tfm)
 {
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index c32a6f5664e9..fe956629f34c 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -185,6 +185,8 @@ static inline struct crypto_tfm *crypto_aead_tfm(struct crypto_aead *tfm)
 /**
  * crypto_free_aead() - zeroize and free aead handle
  * @tfm: cipher handle to be freed
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_aead(struct crypto_aead *tfm)
 {
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 1d3aa252caba..5764b46bd1ec 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -174,6 +174,8 @@ static inline struct crypto_akcipher *crypto_akcipher_reqtfm(
  * crypto_free_akcipher() - free AKCIPHER tfm handle
  *
  * @tfm: AKCIPHER tfm handle allocated with crypto_alloc_akcipher()
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_akcipher(struct crypto_akcipher *tfm)
 {
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 13f8a6a54ca8..b2bc1e46e86a 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -281,6 +281,8 @@ static inline struct crypto_tfm *crypto_ahash_tfm(struct crypto_ahash *tfm)
 /**
  * crypto_free_ahash() - zeroize and free the ahash handle
  * @tfm: cipher handle to be freed
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_ahash(struct crypto_ahash *tfm)
 {
@@ -724,6 +726,8 @@ static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
 /**
  * crypto_free_shash() - zeroize and free the message digest handle
  * @tfm: cipher handle to be freed
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_shash(struct crypto_shash *tfm)
 {
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index 88b591215d5c..cccceadc164b 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -154,6 +154,8 @@ static inline void crypto_kpp_set_flags(struct crypto_kpp *tfm, u32 flags)
  * crypto_free_kpp() - free KPP tfm handle
  *
  * @tfm: KPP tfm handle allocated with crypto_alloc_kpp()
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_kpp(struct crypto_kpp *tfm)
 {
diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index 8b4b844b4eef..17bb3673d3c1 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -111,6 +111,8 @@ static inline struct rng_alg *crypto_rng_alg(struct crypto_rng *tfm)
 /**
  * crypto_free_rng() - zeroize and free RNG handle
  * @tfm: cipher handle to be freed
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_rng(struct crypto_rng *tfm)
 {
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 6a733b171a5d..ef0fc9ed4342 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -196,6 +196,8 @@ static inline struct crypto_tfm *crypto_skcipher_tfm(
 /**
  * crypto_free_skcipher() - zeroize and free cipher handle
  * @tfm: cipher handle to be freed
+ *
+ * If @tfm is a NULL or error pointer, this function does nothing.
  */
 static inline void crypto_free_skcipher(struct crypto_skcipher *tfm)
 {
-- 
2.30.2

