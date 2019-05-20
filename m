Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4302B23DCB
	for <lists+linux-crypto@lfdr.de>; Mon, 20 May 2019 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbfETQsA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 May 2019 12:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389843AbfETQsA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 May 2019 12:48:00 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F94214DA;
        Mon, 20 May 2019 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558370879;
        bh=Yf+g9vOAw+X4k2U7oH5BvDUno0r4HEDvWSu3dcvz51c=;
        h=From:To:Cc:Subject:Date:From;
        b=SmQKeZicVRyYIsGrcWFhIi/RJTPpZFz9GLddrCrZqh4GQYosr2+3qeK0DVIkcHCFL
         9lAO8KdBH5mdjfRiEpfxWV+51VvdNm6jd+9zGVq8e2wEsDwKgE3G0qE72NY8/UzkZj
         yZlQrtD2RT/etzbJRBUrgnaQ14cTtAexc0fiRrng=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] crypto: testmgr - fix length truncation with large page size
Date:   Mon, 20 May 2019 09:47:19 -0700
Message-Id: <20190520164719.160956-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

On PowerPC with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, there is sometimes
a crash in generate_random_aead_testvec().  The problem is that the
generated test vectors use data lengths of up to about 2 * PAGE_SIZE,
which is 128 KiB on PowerPC; however, the data length fields in the test
vectors are 'unsigned short', so the lengths get truncated.  Fix this by
changing the relevant fields to 'unsigned int'.

Fixes: 40153b10d91c ("crypto: testmgr - fuzz AEADs against their generic implementation")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 9a13c634b2077..fb2afdd544e00 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -43,7 +43,7 @@ struct hash_testvec {
 	const char *key;
 	const char *plaintext;
 	const char *digest;
-	unsigned short psize;
+	unsigned int psize;
 	unsigned short ksize;
 	int setkey_error;
 	int digest_error;
@@ -74,7 +74,7 @@ struct cipher_testvec {
 	const char *ctext;
 	unsigned char wk; /* weak key flag */
 	unsigned short klen;
-	unsigned short len;
+	unsigned int len;
 	bool fips_skip;
 	bool generates_iv;
 	int setkey_error;
@@ -110,9 +110,9 @@ struct aead_testvec {
 	unsigned char novrfy;
 	unsigned char wk;
 	unsigned char klen;
-	unsigned short plen;
-	unsigned short clen;
-	unsigned short alen;
+	unsigned int plen;
+	unsigned int clen;
+	unsigned int alen;
 	int setkey_error;
 	int setauthsize_error;
 	int crypt_error;
-- 
2.21.0.1020.gf2820cf01a-goog

