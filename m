Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0A4CEC48
	for <lists+linux-crypto@lfdr.de>; Sun,  6 Mar 2022 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiCFQwj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 6 Mar 2022 11:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiCFQwj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 6 Mar 2022 11:52:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15CF17A81;
        Sun,  6 Mar 2022 08:51:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2978160EF4;
        Sun,  6 Mar 2022 16:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9FBC340EF;
        Sun,  6 Mar 2022 16:51:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cOzI/taB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646585502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Laylo4Gssaa7IN7BRi5RjrAx77Gcgm2U5INwrFKfCA=;
        b=cOzI/taBLbL0n+EZEdfZRlhbs1udL7ZwnVxDBWDmdC6bQx1KZqlflFInAUdqrzAKxu1pca
        Sp96HdQJ31t0ZClvL46GP4xaGqJJeyRuB386/ynuqu5HD8PE0iMdWoU4gReS4LL52Pt/Sk
        DXhPJM5su4toa4WfRWhOueoPuVH/UM0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ae0701b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 6 Mar 2022 16:51:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: [PATCH v2] random: use SipHash as interrupt entropy accumulator
Date:   Sun,  6 Mar 2022 09:51:23 -0700
Message-Id: <20220306165123.71024-1-Jason@zx2c4.com>
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

The current fast_mix() function is a piece of classic mailing list
crypto, where it just sort of sprung up by an anonymous author without a
lot of real analysis of what precisely it was accomplishing. As an ARX
permutation alone, there are some easily searchable differential trails
in it, and as a means of preventing malicious interrupts, it completely
fails, since it xors new data into the entire state every time. It can't
really be analyzed as a random permutation, because it clearly isn't,
and it can't be analyzed as an interesting linear algebraic structure
either, because it's also not that. There really is very little one can
say about it in terms of entropy accumulation. It might diffuse bits,
some of the time, maybe, we hope, I guess. But for the most part, it
fails to accomplish anything concrete.

As a reminder, the simple goal of add_interrupt_randomness() is to
simply accumulate entropy until ~64 interrupts have elapsed, and then
dump it into the main input pool, which uses a cryptographic hash.

It would be nice to have something cryptographically strong in the
interrupt handler itself, in case a malicious interrupt compromises a
per-cpu fast pool within the 64 interrupts / 1 second window, and then
inside of that same window somehow can control its return address and
cycle counter, even if that's a bit far fetched. However, with a very
CPU-limited budget, actually doing that remains an active research
project (and perhaps there'll be something useful for Linux to come out
of it). And while the abundance of caution would be nice, this isn't
*currently* the security model, and we don't yet have a fast enough
solution to make it our security model. Plus there's not exactly a
pressing need to do that. (And for the avoidance of doubt, the actual
cluster of 64 accumulated interrupts still gets dumped into our
cryptographically secure input pool.)

So, for now we are going to stick with the existing interrupt security
model, which assumes that each cluster of 64 interrupt data samples is
mostly non-malicious and not colluding with an infoleaker. With this as
our goal, we have a few more choices, simply aiming to accumulate
entropy, while discarding the least amount of it.

We know from <https://eprint.iacr.org/2019/198> that random oracles,
instantiated as computational hash functions, make good entropy
accumulators and extractors, which is the justification for using
BLAKE2s in the main input pool. As mentioned, we don't have that luxury
here, but we also don't have the same security model requirements,
because we're assuming that there aren't malicious inputs. A
pseudorandom function instance can approximately behave like a random
oracle, provided that the key is uniformly random. But since we're not
concerned with malicious inputs, we can pick a fixed key, which is not
secret, knowing that "nature" won't interact with a sufficiently chosen
fixed key by accident. So we pick a PRF with a fixed initial key, and
accumulate into it continuously, dumping the result every 64 interrupts
into our cryptographically secure input pool.

For this, we make use of SipHash-1-x on 64-bit and HalfSipHash-1-x on
32-bit, which are already in use in the kernel and achieve the same
performance as the function they replace. It would be nice to do two
rounds, but we don't exactly have the CPU budget handy for that, and one
round alone is already sufficient.

As mentioned, we start with a fixed initial key (zeros is fine), and
allow SipHash's symmetry breaking constants to turn that into a useful
starting point. Also, since we're dumping the result (or half of it on
64-bit) into the cryptographically secure input pool, there's no point
in finalizing SipHash's output, since it'll wind up being finalized by
something much stronger. This means that all we need to do is use the
ordinary round function word-by-word, as normal SipHash does.
Simplified, the flow is as follows:

Initialize:

    siphash_state_t state;
    siphash_init(&state, key={0, 0, 0, 0});

Update (accumulate) on interrupt:

    siphash_update(&state, interrupt_data_and_timing);

Dump into input pool after 64 interrupts:

    blake2s_update(&input_pool, &state, sizeof(state) / 2);

The result of all of this is that the security model is unchanged from
before -- we assume non-malicious inputs -- yet we now implement that
model with a stronger argument. I would like to emphasize, again, that
the purpose of this commit is to improve the existing design, by making
it analyzable, without changing any fundamental assumptions. There may
well be value down the road in changing up the existing design, using
something cryptographically strong, or simply using a ring buffer of
samples rather than having a fast_mix() at all, or changing which and
how much data we collect each interrupt so that we can use something
linear, or a variety of other ideas. This commit does not invalidate the
potential for those in the future.

For example, in the future, if we're able to characterize the data we're
collecting on each interrupt, we may be able to inch toward information
theoretic accumulators. <https://eprint.iacr.org/2021/523> shows that `s
= ror32(s, 7) ^ x` and `s = ror64(s, 19) ^ x` make very good
accumulators for 2-monotone distributions, which would apply to
timestamp counters, like random_get_entropy() or jiffies, but would not
apply to our current combination of the two values, or to the various
function addresses and register values we mix in. Alternatively,
<https://eprint.iacr.org/2021/1002> shows that max-period linear
functions with no non-trivial invariant subspace make good extractors,
used in the form `s = f(s) ^ x`. However, this only works if the input
data is both identical and independent, and obviously a collection of
address values and counters fails; so it goes with theoretical papers.
Future directions here may involve trying to characterize more precisely
what we actually need to collect in the interrupt handler, and building
something specific around that.

However, as mentioned, the morass of data we're gathering at the
interrupt handler presently defies characterization, and so we use
SipHash for now, which works well and performs well.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Hi Greg,

You reviewed v1 of this patch, but I did not carry your Reviewed-by over
to this v2, because it is so substantially different. I started having
some doubts about the strength of the claims that the theoretical papers
could really make, and so I dialed things up a bit with a much more
conservative choice of just using SipHash, which is more than enough for
our purposes. It's also already sort of a "known quantity" in the
kernel, in terms of security and performance, so this feels like much
less of a radical change.

Jason

 drivers/char/random.c | 86 +++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 07ca3164522c..edb5b06544da 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1175,48 +1175,51 @@ EXPORT_SYMBOL_GPL(unregister_random_vmfork_notifier);
 #endif
 
 struct fast_pool {
-	union {
-		u32 pool32[4];
-		u64 pool64[2];
-	};
 	struct work_struct mix;
+	unsigned long pool[4];
 	unsigned long last;
 	unsigned int count;
 	u16 reg_idx;
 };
 
+static DEFINE_PER_CPU(struct fast_pool, irq_randomness) = {
+#ifdef CONFIG_64BIT
+	/* SipHash constants */
+	.pool = { 0x736f6d6570736575UL, 0x646f72616e646f6dUL,
+		  0x6c7967656e657261UL, 0x7465646279746573UL }
+#else
+	/* HalfSipHash constants */
+	.pool = { 0, 0, 0x6c796765U, 0x74656462U }
+#endif
+};
+
 /*
- * This is a fast mixing routine used by the interrupt randomness
- * collector. It's hardcoded for an 128 bit pool and assumes that any
- * locks that might be needed are taken by the caller.
+ * This is [Half]SipHash-1-x, starting from an empty key. Because
+ * the key is fixed, it assumes that its inputs are non-malicious,
+ * and therefore this has no security on its own. s represents the
+ * 128 or 256-bit SipHash state, while v represents a 128-bit input.
  */
-static void fast_mix(u32 pool[4])
+static void fast_mix(unsigned long s[4], const unsigned long *v)
 {
-	u32 a = pool[0],	b = pool[1];
-	u32 c = pool[2],	d = pool[3];
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 6);	d = rol32(d, 27);
-	d ^= a;			b ^= c;
-
-	a += b;			c += d;
-	b = rol32(b, 16);	d = rol32(d, 14);
-	d ^= a;			b ^= c;
+	size_t i;
 
-	pool[0] = a;  pool[1] = b;
-	pool[2] = c;  pool[3] = d;
+	for (i = 0; i < 16 / sizeof(long); ++i) {
+		s[3] ^= v[i];
+#ifdef CONFIG_64BIT
+		s[0] += s[1]; s[1] = rol64(s[1], 13); s[1] ^= s[0]; s[0] = rol64(s[0], 32);
+		s[2] += s[3]; s[3] = rol64(s[3], 16); s[3] ^= s[2];
+		s[0] += s[3]; s[3] = rol64(s[3], 21); s[3] ^= s[0];
+		s[2] += s[1]; s[1] = rol64(s[1], 17); s[1] ^= s[2]; s[2] = rol64(s[2], 32);
+#else
+		s[0] += s[1]; s[1] = rol32(s[1],  5); s[1] ^= s[0]; s[0] = rol32(s[0], 16);
+		s[2] += s[3]; s[3] = rol32(s[3],  8); s[3] ^= s[2];
+		s[0] += s[3]; s[3] = rol32(s[3],  7); s[3] ^= s[0];
+		s[2] += s[1]; s[1] = rol32(s[1], 13); s[1] ^= s[2]; s[2] = rol32(s[2], 16);
+#endif
+		s[0] ^= v[i];
+	}
 }
 
-static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
-
 #ifdef CONFIG_SMP
 /*
  * This function is called when the CPU has just come online, with
@@ -1258,7 +1261,7 @@ static unsigned long get_reg(struct fast_pool *f, struct pt_regs *regs)
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
-	u32 pool[4];
+	u8 pool[16];
 
 	/* Check to see if we're running on the wrong CPU due to hotplug. */
 	local_irq_disable();
@@ -1271,7 +1274,7 @@ static void mix_interrupt_randomness(struct work_struct *work)
 	 * Copy the pool to the stack so that the mixer always has a
 	 * consistent view, before we reenable irqs again.
 	 */
-	memcpy(pool, fast_pool->pool32, sizeof(pool));
+	memcpy(pool, fast_pool->pool, sizeof(pool));
 	fast_pool->count = 0;
 	fast_pool->last = jiffies;
 	local_irq_enable();
@@ -1295,25 +1298,30 @@ void add_interrupt_randomness(int irq)
 	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs *regs = get_irq_regs();
 	unsigned int new_count;
+	union {
+		u32 u32[4];
+		u64 u64[2];
+		unsigned long longs[16 / sizeof(long)];
+	} irq_data;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
 
 	if (sizeof(cycles) == 8)
-		fast_pool->pool64[0] ^= cycles ^ rol64(now, 32) ^ irq;
+		irq_data.u64[0] = cycles ^ rol64(now, 32) ^ irq;
 	else {
-		fast_pool->pool32[0] ^= cycles ^ irq;
-		fast_pool->pool32[1] ^= now;
+		irq_data.u32[0] = cycles ^ irq;
+		irq_data.u32[1] = now;
 	}
 
 	if (sizeof(unsigned long) == 8)
-		fast_pool->pool64[1] ^= regs ? instruction_pointer(regs) : _RET_IP_;
+		irq_data.u64[1] = regs ? instruction_pointer(regs) : _RET_IP_;
 	else {
-		fast_pool->pool32[2] ^= regs ? instruction_pointer(regs) : _RET_IP_;
-		fast_pool->pool32[3] ^= get_reg(fast_pool, regs);
+		irq_data.u32[2] = regs ? instruction_pointer(regs) : _RET_IP_;
+		irq_data.u32[3] = get_reg(fast_pool, regs);
 	}
 
-	fast_mix(fast_pool->pool32);
+	fast_mix(fast_pool->pool, irq_data.longs);
 	new_count = ++fast_pool->count;
 
 	if (new_count & MIX_INFLIGHT)
-- 
2.35.1

