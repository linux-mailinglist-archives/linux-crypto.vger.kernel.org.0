Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCD217757
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2020 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGGS7k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Jul 2020 14:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgGGS7j (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Jul 2020 14:59:39 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB8A2075B;
        Tue,  7 Jul 2020 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594148378;
        bh=yec1njmKLiBQbL430CAWuVargfebtEX7oU/i/15IxkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuvUmIg6lxEG+618O/cAH5T/ToASKVew0VoGLAbqFpaRm2p2jGcpebe+bfwRIhgIA
         V6A9gUdXbamSLjEHxWFywoekLhiJfnxbdKmpyBPwuhl2gqebLuF/Gtj430rDnPOU4D
         zoU3iZlpc0CLzjPpn3SEAVId9UJ8HHU/ehkZZr84=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     mptcp@lists.01.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 3/4] mptcp: use sha256() instead of open coding
Date:   Tue,  7 Jul 2020 11:58:17 -0700
Message-Id: <20200707185818.80177-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
References: <20200707185818.80177-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that there's a function that calculates the SHA-256 digest of a
buffer in one step, use it instead of sha256_init() + sha256_update() +
sha256_final().

Cc: mptcp@lists.01.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/mptcp/crypto.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 3d980713a9e2..82bd2b54d741 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -32,11 +32,8 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 {
 	__be32 mptcp_hashed_key[SHA256_DIGEST_WORDS];
 	__be64 input = cpu_to_be64(key);
-	struct sha256_state state;
 
-	sha256_init(&state);
-	sha256_update(&state, (__force u8 *)&input, sizeof(input));
-	sha256_final(&state, (u8 *)mptcp_hashed_key);
+	sha256((__force u8 *)&input, sizeof(input), (u8 *)mptcp_hashed_key);
 
 	if (token)
 		*token = be32_to_cpu(mptcp_hashed_key[0]);
@@ -47,7 +44,6 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac)
 {
 	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
-	struct sha256_state state;
 	u8 key1be[8];
 	u8 key2be[8];
 	int i;
@@ -67,13 +63,10 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac)
 
 	memcpy(&input[SHA256_BLOCK_SIZE], msg, len);
 
-	sha256_init(&state);
-	sha256_update(&state, input, SHA256_BLOCK_SIZE + len);
-
 	/* emit sha256(K1 || msg) on the second input block, so we can
 	 * reuse 'input' for the last hashing
 	 */
-	sha256_final(&state, &input[SHA256_BLOCK_SIZE]);
+	sha256(input, SHA256_BLOCK_SIZE + len, &input[SHA256_BLOCK_SIZE]);
 
 	/* Prepare second part of hmac */
 	memset(input, 0x5C, SHA256_BLOCK_SIZE);
@@ -82,9 +75,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac)
 	for (i = 0; i < 8; i++)
 		input[i + 8] ^= key2be[i];
 
-	sha256_init(&state);
-	sha256_update(&state, input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE);
-	sha256_final(&state, (u8 *)hmac);
+	sha256(input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE, hmac);
 }
 
 #ifdef CONFIG_MPTCP_HMAC_TEST
-- 
2.27.0

