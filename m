Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8538826D9C
	for <lists+linux-crypto@lfdr.de>; Wed, 22 May 2019 21:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfEVTnT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 May 2019 15:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfEVTnS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 May 2019 15:43:18 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC1B20856;
        Wed, 22 May 2019 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558554198;
        bh=Eu5uL8cehpI9lUHeQu0RY/lyRyhIwPZeIGqy8mq0Q/U=;
        h=From:To:Subject:Date:From;
        b=QrTQY/4uvadf3vyKhdLWkDjQOvLKWx0M0yoIqc3WCb+rAuBEK/Rr++xBtr+JCsUwd
         wUMP0erGXJ1YQgE/SmaQhZZUMit1P4lLkyDSO3C1NpoElq/xHVfwNTLKtxu8rcvsby
         dCzTxtjL+Po4y+zmr5PfiHsiFoDxA+5/eoLRV6vM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: hmac - fix memory leak in hmac_init_tfm()
Date:   Wed, 22 May 2019 12:42:29 -0700
Message-Id: <20190522194229.101989-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When I added the sanity check of 'descsize', I missed that the child
hash tfm needs to be freed if the sanity check fails.  Of course this
should never happen, hence the use of WARN_ON(), but it should be fixed.

Fixes: e1354400b25d ("crypto: hash - fix incorrect HASH_MAX_DESCSIZE")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/hmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/hmac.c b/crypto/hmac.c
index 241b1868c1d01..ac8c611ee33e4 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -157,8 +157,10 @@ static int hmac_init_tfm(struct crypto_tfm *tfm)
 
 	parent->descsize = sizeof(struct shash_desc) +
 			   crypto_shash_descsize(hash);
-	if (WARN_ON(parent->descsize > HASH_MAX_DESCSIZE))
+	if (WARN_ON(parent->descsize > HASH_MAX_DESCSIZE)) {
+		crypto_free_shash(hash);
 		return -EINVAL;
+	}
 
 	ctx->hash = hash;
 	return 0;
-- 
2.22.0.rc1.257.g3120a18244-goog

