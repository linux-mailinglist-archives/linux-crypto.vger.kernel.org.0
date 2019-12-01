Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9541010E3B1
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Dec 2019 22:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLAVyU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 1 Dec 2019 16:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLAVyU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 1 Dec 2019 16:54:20 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A88215F1
        for <linux-crypto@vger.kernel.org>; Sun,  1 Dec 2019 21:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575237260;
        bh=VSQfZ9WnmSpg9pL0yDSuqYs8FkDuRuK6VaZ+NTs01g8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pQhMY7AvC040nOYDEP0pRItsS0N89BcbJERBnEPw582rxbBnYo7CnMAQWnO7B4lXF
         N8CZHi34nORHc3zku5+SmvTNf4TMbFAHYR6Up/EzHUqPomO9+AHt3tPe+A/GuffjNQ
         +7XoXoxuu3hhGAG2DqQBYBscn0WuddjOxWPYZNuY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 1/7] crypto: aead - move crypto_aead_maxauthsize() to <crypto/aead.h>
Date:   Sun,  1 Dec 2019 13:53:24 -0800
Message-Id: <20191201215330.171990-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191201215330.171990-1-ebiggers@kernel.org>
References: <20191201215330.171990-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Move crypto_aead_maxauthsize() to <crypto/aead.h> so that it's available
to users of the API, not just AEAD implementations.

This will be used by the self-tests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/aead.h          | 10 ++++++++++
 include/crypto/internal/aead.h | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index a3bdadf6221e..1b3ebe8593c0 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -227,6 +227,16 @@ static inline unsigned int crypto_aead_authsize(struct crypto_aead *tfm)
 	return tfm->authsize;
 }
 
+static inline unsigned int crypto_aead_alg_maxauthsize(struct aead_alg *alg)
+{
+	return alg->maxauthsize;
+}
+
+static inline unsigned int crypto_aead_maxauthsize(struct crypto_aead *aead)
+{
+	return crypto_aead_alg_maxauthsize(crypto_aead_alg(aead));
+}
+
 /**
  * crypto_aead_blocksize() - obtain block size of cipher
  * @tfm: cipher handle
diff --git a/include/crypto/internal/aead.h b/include/crypto/internal/aead.h
index c509ec30fc65..374185a7567f 100644
--- a/include/crypto/internal/aead.h
+++ b/include/crypto/internal/aead.h
@@ -113,16 +113,6 @@ static inline void crypto_aead_set_reqsize(struct crypto_aead *aead,
 	aead->reqsize = reqsize;
 }
 
-static inline unsigned int crypto_aead_alg_maxauthsize(struct aead_alg *alg)
-{
-	return alg->maxauthsize;
-}
-
-static inline unsigned int crypto_aead_maxauthsize(struct crypto_aead *aead)
-{
-	return crypto_aead_alg_maxauthsize(crypto_aead_alg(aead));
-}
-
 static inline void aead_init_queue(struct aead_queue *queue,
 				   unsigned int max_qlen)
 {
-- 
2.24.0

