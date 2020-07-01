Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBA21031C
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2020 06:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGAEwa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Jul 2020 00:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgGAEwa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Jul 2020 00:52:30 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACCB20775;
        Wed,  1 Jul 2020 04:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593579149;
        bh=pjtYKg3a4yPgXFmSMtIISdeywp+iOm0aU2WdN3N7TFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ysKMaizt9kQB9YxQLGGnRpS1LbzLHbbZu0jGmhFMuDpRzOYKwagfQkoGAzEPbr5j
         MU1jpnOLm1PvvE3GLpz8II1dQJT0ij51mCFGCh1T8ICfh1GkcppBmA/2LagLpsx2Z7
         moWOYZyeA7ZraV9wy59KpHUl0c/7i2tJ4Y1DwGfI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>, linux-crypto@vger.kernel.org
Cc:     dm-devel@redhat.com
Subject: [PATCH 3/6] crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
Date:   Tue, 30 Jun 2020 21:52:14 -0700
Message-Id: <20200701045217.121126-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701045217.121126-1-ebiggers@kernel.org>
References: <20200701045217.121126-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Introduce a new algorithm flag CRYPTO_ALG_ALLOCATES_MEMORY.  If this
flag is set, then the driver allocates memory in its request routine.
Such drivers are not suitable for disk encryption because GFP_ATOMIC
allocation can fail anytime (causing random I/O errors) and GFP_KERNEL
allocation can recurse into the block layer, causing a deadlock.

For now, this flag is only implemented for some algorithm types.  We
also assume some usage constraints for it to be meaningful, since there
are lots of edge cases the crypto API allows (e.g., misaligned or
fragmented scatterlists) that mean that nearly any crypto algorithm can
allocate memory in some case.  See the comment for details.

Also add this flag to CRYPTO_ALG_INHERITED_FLAGS so that when a template
is instantiated, this flag is set on the template instance if it is set
on any algorithm the instance uses.

Originally-from: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/algapi.h |  3 ++-
 include/linux/crypto.h  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 5385443dcf9b..dce57c89cf98 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -246,7 +246,8 @@ static inline u32 crypto_requires_off(u32 type, u32 mask, u32 off)
  * algorithm if any "inner" algorithm has them set.  In some cases other flags
  * are inherited too; these are just the flags that are *always* inherited.
  */
-#define CRYPTO_ALG_INHERITED_FLAGS	CRYPTO_ALG_ASYNC
+#define CRYPTO_ALG_INHERITED_FLAGS	\
+	(CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY)
 
 /*
  * Given the type and mask that specify the flags restrictions on a template
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 763863dbc079..5e7c04391be8 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -101,6 +101,38 @@
  */
 #define CRYPTO_NOLOAD			0x00008000
 
+/*
+ * The algorithm may allocate memory during request processing, i.e. during
+ * encryption, decryption, or hashing.  Users can request an algorithm with this
+ * flag unset if they can't handle memory allocation failures.
+ *
+ * This flag is currently only implemented for algorithms of type "skcipher",
+ * "aead", "ahash", "shash", and "cipher".  Algorithms of other types might not
+ * have this flag set even if they allocate memory.
+ *
+ * In some edge cases, algorithms can allocate memory regardless of this flag.
+ * To avoid these cases, users must obey the following usage constraints:
+ *    skcipher:
+ *	- The IV buffer and all scatterlist elements must be aligned to the
+ *	  algorithm's alignmask.
+ *	- If the data were to be divided into chunks of size
+ *	  crypto_skcipher_walksize() (with any remainder going at the end), no
+ *	  chunk can cross a page boundary or a scatterlist element boundary.
+ *    aead:
+ *	- The IV buffer and all scatterlist elements must be aligned to the
+ *	  algorithm's alignmask.
+ *	- The first scatterlist element must contain all the associated data,
+ *	  and its pages must be !PageHighMem.
+ *	- If the plaintext/ciphertext were to be divided into chunks of size
+ *	  crypto_aead_walksize() (with the remainder going at the end), no chunk
+ *	  can cross a page boundary or a scatterlist element boundary.
+ *    ahash:
+ *	- The result buffer must be aligned to the algorithm's alignmask.
+ *	- crypto_ahash_finup() must not be used unless the algorithm implements
+ *	  ->finup() natively.
+ */
+#define CRYPTO_ALG_ALLOCATES_MEMORY	0x00010000
+
 /*
  * Transform masks and values (for crt_flags).
  */
-- 
2.27.0

