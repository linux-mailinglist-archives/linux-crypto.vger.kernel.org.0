Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43C326BB9B
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Sep 2020 06:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgIPEwX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Sep 2020 00:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgIPEwV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Sep 2020 00:52:21 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91D421941;
        Wed, 16 Sep 2020 04:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600231941;
        bh=Khzx9ob+MvgjQ0zZUFBnUEEBkD2yO4DCWQCRa7GqRUM=;
        h=From:To:Cc:Subject:Date:From;
        b=azVnIX5C3XDbdyAae4TAqtNTyVKyHkkrP+Bo4LRhXgIQg/VSssl1ERzMMZzg/rxjh
         UDD/UOSSQwssC84Q9fT5NTZndJ0Ry5665o7Pn0PcQcYkmGzWfN4N2mlvqXxY+DaMy7
         kSOz5uaqPk4oMmqXJq3VFeJ2RsrBPkua6Z5bmA/w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH] random: initialize ChaCha20 constants with correct endianness
Date:   Tue, 15 Sep 2020 21:50:13 -0700
Message-Id: <20200916045013.142179-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

On big endian CPUs, the ChaCha20-based CRNG is using the wrong
endianness for the ChaCha20 constants.

This doesn't matter cryptographically, but technically it means it's not
ChaCha20 anymore.  Fix it to always use the standard constants.

Cc: linux-crypto@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/char/random.c   | 4 ++--
 include/crypto/chacha.h | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 26f0a23a6f021..09b1551d4092f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -809,7 +809,7 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 
 static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 {
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	chacha_init_consts(crng->state);
 	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
 	crng_init_try_arch(crng);
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
@@ -817,7 +817,7 @@ static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	chacha_init_consts(crng->state);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
 	if (crng_init_try_arch_early(crng) && trust_cpu) {
 		invalidate_batched_entropy();
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index 3a1c72fdb7cf5..dabaee6987186 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -47,13 +47,18 @@ static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
 		hchacha_block_generic(state, out, nrounds);
 }
 
-void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
-static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+static inline void chacha_init_consts(u32 *state)
 {
 	state[0]  = 0x61707865; /* "expa" */
 	state[1]  = 0x3320646e; /* "nd 3" */
 	state[2]  = 0x79622d32; /* "2-by" */
 	state[3]  = 0x6b206574; /* "te k" */
+}
+
+void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
+static inline void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+{
+	chacha_init_consts(state);
 	state[4]  = key[0];
 	state[5]  = key[1];
 	state[6]  = key[2];
-- 
2.28.0

