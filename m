Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773704A9A60
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Feb 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiBDNyC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Feb 2022 08:54:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359112AbiBDNyB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Feb 2022 08:54:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 654DC61C3A;
        Fri,  4 Feb 2022 13:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF70C004E1;
        Fri,  4 Feb 2022 13:54:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oueBrYnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643982838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USo7kwb/Ii1kFVFdlhkXIIHB8R+M4SmmT1SrSzCNPyY=;
        b=oueBrYnJDSFrW5OkERcMz9iseNHv9mXFJrtm539P55cJpaIFVSUKBYgRFg2pcdRRVeDTcB
        933OEpt3z6nZGL6cULuVfHqDjQvT4IRAWN2C1woQB+YwjY0lGYupmC2UFdVoxi8yNnUgbR
        40nZDB9i5XWeBAV8UlFN/T7S96pQb0s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ffab579 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 13:53:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: [PATCH v2 3/4] random: use linear min-entropy accumulation crediting
Date:   Fri,  4 Feb 2022 14:53:24 +0100
Message-Id: <20220204135325.8327-4-Jason@zx2c4.com>
In-Reply-To: <20220204135325.8327-1-Jason@zx2c4.com>
References: <20220204135325.8327-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

30e37ec516ae ("random: account for entropy loss due to overwrites")
assumed that adding new entropy to the LFSR pool probabilistically
cancelled out old entropy there, so entropy was credited asymptotically,
approximating Shannon entropy of independent sources (rather than a
stronger min-entropy notion) using 1/8th fractional bits and replacing
a constant 2-2/√𝑒 term (~0.786938) with 3/4 (0.75) to slightly
underestimate it. This wasn't superb, but it was perhaps better than
nothing, so that's what was done. Which entropy specifically was being
cancelled out and how much precisely each time is hard to tell, though
as I showed with the attack code in my previous commit, a motivated
adversary with sufficient information can actually cancel out
everything.

Since we're no longer using an LFSR for entropy accumulation, this
probabilistic cancellation is no longer relevant. Rather, we're now
using a computational hash function as the accumulator and we've
switched to working in the random oracle model, from which we can now
revisit the question of min-entropy accumulation, which is done in
detail in <https://eprint.iacr.org/2019/198>.

Consider a long input bit string that is built by concatenating various
smaller independent input bit strings. Each one of these inputs has a
designated min-entropy, which is what we're passing to
credit_entropy_bits(h). When we pass the concatenation of these to a
random oracle, it means that an adversary trying to receive back the
same reply as us would need to become certain about each part of the
concatenated bit string we passed in, which means becoming certain about
all of those h values. That means we can estimate the accumulation by
simply adding up the h values in calls to credit_entropy_bits(h);
there's no probabilistic cancellation at play like there was said to be
for the LFSR. Incidentally, this is also what other entropy accumulators
based on computational hash functions do as well.

So this commit replaces credit_entropy_bits(h) with essentially `total =
min(POOL_BITS, total + h)`, done with a cmpxchg loop as before.

What if we're wrong and the above is nonsense? It's not, but let's
assume we don't want the actual _behavior_ of the code to change much.
Currently that behavior is not extracting from the input pool until it
has 128 bits of entropy in it. With the old algorithm, we'd hit that
magic 128 number after roughly 256 calls to credit_entropy_bits(1). So,
we can retain more or less the old behavior by waiting to extract from
the input pool until it hits 256 bits of entropy using the new code. For
people concerned about this change, it means that there's not that much
practical behavioral change. And for folks actually trying to model
the behavior rigorously, it means that we have an even higher margin
against attacks.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 112 +++++++-----------------------------------
 1 file changed, 19 insertions(+), 93 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d1a3b203ef87..b4798a3f7bf6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -286,17 +286,9 @@
 
 /* #define ADD_INTERRUPT_BENCH */
 
-enum poolinfo {
+enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
-	POOL_BITSHIFT = ilog2(POOL_BITS),
-	POOL_MIN_BITS = POOL_BITS / 2,
-
-	/* To allow fractional bits to be tracked, the entropy_count field is
-	 * denominated in units of 1/8th bits. */
-	POOL_ENTROPY_SHIFT = 3,
-#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
-	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,
-	POOL_MIN_FRACBITS = POOL_MIN_BITS << POOL_ENTROPY_SHIFT
+	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
 };
 
 /*
@@ -469,66 +461,18 @@ static void process_random_ready_list(void)
 static void credit_entropy_bits(int nbits)
 {
 	int entropy_count, orig;
-	int nfrac = nbits << POOL_ENTROPY_SHIFT;
-
-	/* Ensure that the multiplication can avoid being 64 bits wide. */
-	BUILD_BUG_ON(2 * (POOL_ENTROPY_SHIFT + POOL_BITSHIFT) > 31);
 
 	if (!nbits)
 		return;
 
-retry:
-	entropy_count = orig = READ_ONCE(input_pool.entropy_count);
-	if (nfrac < 0) {
-		/* Debit */
-		entropy_count += nfrac;
-	} else {
-		/*
-		 * Credit: we have to account for the possibility of
-		 * overwriting already present entropy.	 Even in the
-		 * ideal case of pure Shannon entropy, new contributions
-		 * approach the full value asymptotically:
-		 *
-		 * entropy <- entropy + (pool_size - entropy) *
-		 *	(1 - exp(-add_entropy/pool_size))
-		 *
-		 * For add_entropy <= pool_size/2 then
-		 * (1 - exp(-add_entropy/pool_size)) >=
-		 *    (add_entropy/pool_size)*0.7869...
-		 * so we can approximate the exponential with
-		 * 3/4*add_entropy/pool_size and still be on the
-		 * safe side by adding at most pool_size/2 at a time.
-		 *
-		 * The use of pool_size-2 in the while statement is to
-		 * prevent rounding artifacts from making the loop
-		 * arbitrarily long; this limits the loop to log2(pool_size)*2
-		 * turns no matter how large nbits is.
-		 */
-		int pnfrac = nfrac;
-		const int s = POOL_BITSHIFT + POOL_ENTROPY_SHIFT + 2;
-		/* The +2 corresponds to the /4 in the denominator */
-
-		do {
-			unsigned int anfrac = min(pnfrac, POOL_FRACBITS / 2);
-			unsigned int add =
-				((POOL_FRACBITS - entropy_count) * anfrac * 3) >> s;
-
-			entropy_count += add;
-			pnfrac -= anfrac;
-		} while (unlikely(entropy_count < POOL_FRACBITS - 2 && pnfrac));
-	}
-
-	if (WARN_ON(entropy_count < 0)) {
-		pr_warn("negative entropy/overflow: count %d\n", entropy_count);
-		entropy_count = 0;
-	} else if (entropy_count > POOL_FRACBITS)
-		entropy_count = POOL_FRACBITS;
-	if (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig)
-		goto retry;
+	do {
+		entropy_count = orig = READ_ONCE(input_pool.entropy_count);
+		entropy_count = min(POOL_BITS, entropy_count + nbits);
+	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
 
-	trace_credit_entropy_bits(nbits, entropy_count >> POOL_ENTROPY_SHIFT, _RET_IP_);
+	trace_credit_entropy_bits(nbits, entropy_count, _RET_IP_);
 
-	if (crng_init < 2 && entropy_count >= POOL_MIN_FRACBITS)
+	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
 		crng_reseed(&primary_crng, true);
 }
 
@@ -791,7 +735,7 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 		int entropy_count;
 		do {
 			entropy_count = READ_ONCE(input_pool.entropy_count);
-			if (entropy_count < POOL_MIN_FRACBITS)
+			if (entropy_count < POOL_MIN_BITS)
 				return;
 		} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
 		extract_entropy(buf.key, sizeof(buf.key));
@@ -1014,7 +958,7 @@ void add_input_randomness(unsigned int type, unsigned int code,
 	last_value = value;
 	add_timer_randomness(&input_timer_state,
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
-	trace_add_input_randomness(POOL_ENTROPY_BITS());
+	trace_add_input_randomness(input_pool.entropy_count);
 }
 EXPORT_SYMBOL_GPL(add_input_randomness);
 
@@ -1112,7 +1056,7 @@ void add_disk_randomness(struct gendisk *disk)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
 	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-	trace_add_disk_randomness(disk_devt(disk), POOL_ENTROPY_BITS());
+	trace_add_disk_randomness(disk_devt(disk), input_pool.entropy_count);
 }
 EXPORT_SYMBOL_GPL(add_disk_randomness);
 #endif
@@ -1137,7 +1081,7 @@ static void extract_entropy(void *buf, size_t nbytes)
 	} block;
 	size_t i;
 
-	trace_extract_entropy(nbytes, POOL_ENTROPY_BITS());
+	trace_extract_entropy(nbytes, input_pool.entropy_count);
 
 	for (i = 0; i < ARRAY_SIZE(block.rdrand); ++i) {
 		if (!arch_get_random_long(&block.rdrand[i]))
@@ -1486,9 +1430,9 @@ static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
 {
 	int ret;
 
-	nbytes = min_t(size_t, nbytes, INT_MAX >> (POOL_ENTROPY_SHIFT + 3));
+	nbytes = min_t(size_t, nbytes, INT_MAX >> 6);
 	ret = extract_crng_user(buf, nbytes);
-	trace_urandom_read(8 * nbytes, 0, POOL_ENTROPY_BITS());
+	trace_urandom_read(8 * nbytes, 0, input_pool.entropy_count);
 	return ret;
 }
 
@@ -1527,7 +1471,7 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	mask = 0;
 	if (crng_ready())
 		mask |= EPOLLIN | EPOLLRDNORM;
-	if (POOL_ENTROPY_BITS() < random_write_wakeup_bits)
+	if (input_pool.entropy_count < random_write_wakeup_bits)
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	return mask;
 }
@@ -1582,8 +1526,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case RNDGETENTCNT:
 		/* inherently racy, no point locking */
-		ent_count = POOL_ENTROPY_BITS();
-		if (put_user(ent_count, p))
+		if (put_user(input_pool.entropy_count, p))
 			return -EFAULT;
 		return 0;
 	case RNDADDTOENTCNT:
@@ -1734,23 +1677,6 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
 	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
 }
 
-/*
- * Return entropy available scaled to integral bits
- */
-static int proc_do_entropy(struct ctl_table *table, int write, void *buffer,
-			   size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table fake_table;
-	int entropy_count;
-
-	entropy_count = *(int *)table->data >> POOL_ENTROPY_SHIFT;
-
-	fake_table.data = &entropy_count;
-	fake_table.maxlen = sizeof(entropy_count);
-
-	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
-}
-
 static int sysctl_poolsize = POOL_BITS;
 extern struct ctl_table random_table[];
 struct ctl_table random_table[] = {
@@ -1763,10 +1689,10 @@ struct ctl_table random_table[] = {
 	},
 	{
 		.procname	= "entropy_avail",
+		.data		= &input_pool.entropy_count,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_do_entropy,
-		.data		= &input_pool.entropy_count,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "write_wakeup_threshold",
@@ -1962,7 +1888,7 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	 */
 	wait_event_interruptible_timeout(random_write_wait,
 			!system_wq || kthread_should_stop() ||
-			POOL_ENTROPY_BITS() <= random_write_wakeup_bits,
+			input_pool.entropy_count <= random_write_wakeup_bits,
 			CRNG_RESEED_INTERVAL);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
-- 
2.35.0

