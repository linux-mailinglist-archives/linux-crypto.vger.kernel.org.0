Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F364ADDB5
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Feb 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382082AbiBHPyB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Feb 2022 10:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382101AbiBHPyB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Feb 2022 10:54:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3548C06157A;
        Tue,  8 Feb 2022 07:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99BBAB81BB6;
        Tue,  8 Feb 2022 15:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05A7C004E1;
        Tue,  8 Feb 2022 15:53:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bPW2N82I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGnQXWAKgKEke7Ex6iv0rHYBEDTkGuQWRHtfKLlXujQ=;
        b=bPW2N82IC/BYOQ/S0ISBuNPQv35azRvlSO4iZMIeHqhBxe36W9wSXE9SceG/wuj4mE90lJ
        3EN8fsTK9eiHLMiJVD8eBuxqzBDD/WqhfD73TaYBdf14SS91Y8QbpQ9wc73sRtfUtH9q8r
        Ex0lsvt7Q/kUPi8/AYLD65a/9oSWN1Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b8c8b38 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:53:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 1/7] random: use RDSEED instead of RDRAND in entropy extraction
Date:   Tue,  8 Feb 2022 16:53:29 +0100
Message-Id: <20220208155335.378318-2-Jason@zx2c4.com>
In-Reply-To: <20220208155335.378318-1-Jason@zx2c4.com>
References: <20220208155335.378318-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When /dev/random was directly connected with entropy extraction, without
any expansion stage, extract_buf() was called for every 10 bytes of data
read from /dev/random. For that reason, RDRAND was used rather than
RDSEED. At the same time, crng_reseed() was still only called every 5
minutes, so there RDSEED made sense.

Those olden days were also a time when the entropy collector did not use
a cryptographic hash function, which meant most bets were off in terms
of real preimage resistance. For that reason too it didn't matter
_that_ much whether RDSEED was mixed in before or after entropy
extraction; both choices were sort of bad.

But now we have a cryptographic hash function at work, and with that we
get real preimage resistance. We also now only call extract_entropy()
every 5 minutes, rather than every 10 bytes. This allows us to do two
important things.

First, we can switch to using RDSEED in extract_entropy(), as Dominik
suggested. Second, we can ensure that RDSEED input always goes into the
cryptographic hash function with other things before being used
directly. This eliminates a category of attacks in which the CPU knows
the current state of the crng and knows that we're going to xor RDSEED
into it, and so it computes a malicious RDSEED. By going through our
hash function, it would require the CPU to compute a preimage on the
fly, which isn't going to happen.

Cc: Theodore Ts'o <tytso@mit.edu>
Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index fe24d203b99b..42a3a3663767 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -722,13 +722,8 @@ static void crng_reseed(struct crng_state *crng)
 					CHACHA_KEY_SIZE);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	for (i = 0; i < 8; i++) {
-		unsigned long rv;
-		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
-			rv = random_get_entropy();
-		crng->state[i + 4] ^= buf.key[i] ^ rv;
-	}
+	for (i = 0; i < 8; i++)
+		crng->state[i + 4] ^= buf.key[i];
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
 	spin_unlock_irqrestore(&crng->lock, flags);
@@ -1064,16 +1059,17 @@ static void extract_entropy(void *buf, size_t nbytes)
 	unsigned long flags;
 	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
 	struct {
-		unsigned long rdrand[32 / sizeof(long)];
+		unsigned long rdseed[32 / sizeof(long)];
 		size_t counter;
 	} block;
 	size_t i;
 
 	trace_extract_entropy(nbytes, input_pool.entropy_count);
 
-	for (i = 0; i < ARRAY_SIZE(block.rdrand); ++i) {
-		if (!arch_get_random_long(&block.rdrand[i]))
-			block.rdrand[i] = random_get_entropy();
+	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
+		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
+		    !arch_get_random_long(&block.rdseed[i]))
+			block.rdseed[i] = random_get_entropy();
 	}
 
 	spin_lock_irqsave(&input_pool.lock, flags);
@@ -1081,7 +1077,7 @@ static void extract_entropy(void *buf, size_t nbytes)
 	/* seed = HASHPRF(last_key, entropy_input) */
 	blake2s_final(&input_pool.hash, seed);
 
-	/* next_key = HASHPRF(seed, RDRAND || 0) */
+	/* next_key = HASHPRF(seed, RDSEED || 0) */
 	block.counter = 0;
 	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
 	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
@@ -1091,7 +1087,7 @@ static void extract_entropy(void *buf, size_t nbytes)
 
 	while (nbytes) {
 		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
-		/* output = HASHPRF(seed, RDRAND || ++counter) */
+		/* output = HASHPRF(seed, RDSEED || ++counter) */
 		++block.counter;
 		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
 		nbytes -= i;
-- 
2.35.0

