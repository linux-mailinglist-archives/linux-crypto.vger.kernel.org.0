Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B770F1A5391
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Apr 2020 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDKTnu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 11 Apr 2020 15:43:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:24507 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgDKTnu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 11 Apr 2020 15:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586634225;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BfXdJ5x/tQ54TRaTxRtoYTA0ETxoNFCKhHZsis5zuOg=;
        b=agPCa1ZIDhVdkIAevH7mMmFxe4WdidMTcVFYg/Y2h9fk6ZxhGajsdm78VLqvR7jJeL
        kr1JyavVsyFfmROkrM5CCXMmSBP+qfwKERyviuKkOyAZzgG0ni6H8WuLbuuX67Hv7StZ
        XrE1U6fEYunOezo88sD78kSm3gC1/8YFd6AtWQxcrvAPuDX8sXSU8MX+04tgw5/0zZ+b
        I2Zp1xBygaBVyzVH5XdVZ8XW6rz6WufLmWEHoZkthE1ZZLIF1vibni263R+VVHbq9g6y
        N24fWgki9+T+9d1RQAzZpXFlghU4mwGEFHo2yDtmUypLYSyM48wsQHVRx930YqWA5tNj
        xStQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIPSfmHxF"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id q0554fw3BJbdJt0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 11 Apr 2020 21:37:39 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au
Subject: [PATCH 1/2] crypto: Jitter RNG SP800-90B compliance
Date:   Sat, 11 Apr 2020 21:35:03 +0200
Message-ID: <4128830.EzT7ouGoCQ@positron.chronox.de>
In-Reply-To: <16276478.9hrKPGv45q@positron.chronox.de>
References: <16276478.9hrKPGv45q@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SP800-90B specifies various requirements for the noise source(s) that
may seed any DRNG including SP800-90A DRBGs. In November 2020,
SP800-90B will be mandated for all noise sources that provide entropy
to DRBGs as part of a FIPS 140-[2|3] validation or other evaluation
types. Without SP800-90B compliance, a noise source is defined to always
deliver zero bits of entropy.

This patch ports the SP800-90B compliance from the user space Jitter RNG
version 2.2.0.

The following changes are applied:

- addition of (an enhanced version of) the repetitive count test (RCT)
  from SP800-90B section 4.4.1 - the enhancement is due to the fact of
  using the stuck test as input to the RCT.

- addition of the adaptive proportion test (APT) from SP800-90B section
  4.4.2

- update of the power-on self test to perform a test measurement of 1024
  noise samples compliant to SP800-90B section 4.3

- remove of the continuous random number generator test which is
  replaced by APT and RCT

Health test failures due to the SP800-90B operation are only enforced in
FIPS mode. If a runtime health test failure is detected, the Jitter RNG
is reset. If more than 1024 resets in a row are performed, a permanent
error is returned to the caller.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/jitterentropy-kcapi.c |  41 ++++
 crypto/jitterentropy.c       | 389 ++++++++++++++++++++++++++---------
 2 files changed, 329 insertions(+), 101 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index a5ce8f96790f..d59292a55505 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -108,6 +108,7 @@ void jent_get_nstime(__u64 *out)
 struct jitterentropy {
 	spinlock_t jent_lock;
 	struct rand_data *entropy_collector;
+	unsigned int reset_cnt;
 };
 
 static int jent_kcapi_init(struct crypto_tfm *tfm)
@@ -142,7 +143,47 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 	int ret = 0;
 
 	spin_lock(&rng->jent_lock);
+
+	/* Return a permanent error in case we had too many resets in a row. */
+	if (rng->reset_cnt > (1<<10)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
 	ret = jent_read_entropy(rng->entropy_collector, rdata, dlen);
+
+	/* Reset RNG in case of health failures */
+	if (ret < -1) {
+		pr_warn_ratelimited("Reset Jitter RNG due to health test failure: %s failure\n",
+				    (ret == -2) ? "Repetition Count Test" :
+						  "Adaptive Proportion Test");
+
+		rng->reset_cnt++;
+
+		ret = jent_entropy_init();
+		if (ret) {
+			pr_warn_ratelimited("Jitter RNG self-tests failed: %d\n",
+					    ret);
+			ret = -EFAULT;
+			goto out;
+		}
+		jent_entropy_collector_free(rng->entropy_collector);
+		rng->entropy_collector = jent_entropy_collector_alloc(1, 0);
+		if (!rng->entropy_collector) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = -EAGAIN;
+	} else {
+		rng->reset_cnt = 0;
+
+		/* Convert the Jitter RNG error into a usable error code */
+		if (ret == -1)
+			ret = -EINVAL;
+	}
+
+out:
 	spin_unlock(&rng->jent_lock);
 
 	return ret;
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 042157f0d28b..dfc38156c570 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -2,7 +2,7 @@
  * Non-physical true random number generator based on timing jitter --
  * Jitter RNG standalone code.
  *
- * Copyright Stephan Mueller <smueller@chronox.de>, 2015 - 2019
+ * Copyright Stephan Mueller <smueller@chronox.de>, 2015 - 2020
  *
  * Design
  * ======
@@ -47,7 +47,7 @@
 
 /*
  * This Jitterentropy RNG is based on the jitterentropy library
- * version 2.1.2 provided at http://www.chronox.de/jent.html
+ * version 2.2.0 provided at http://www.chronox.de/jent.html
  */
 
 #ifdef __OPTIMIZE__
@@ -83,6 +83,22 @@ struct rand_data {
 	unsigned int memblocksize; /* Size of one memory block in bytes */
 	unsigned int memaccessloops; /* Number of memory accesses per random
 				      * bit generation */
+
+	/* Repetition Count Test */
+	int rct_count;			/* Number of stuck values */
+
+	/* Adaptive Proportion Test for a significance level of 2^-30 */
+#define JENT_APT_CUTOFF		325	/* Taken from SP800-90B sec 4.4.2 */
+#define JENT_APT_WINDOW_SIZE	512	/* Data window size */
+	/* LSB of time stamp to process */
+#define JENT_APT_LSB		16
+#define JENT_APT_WORD_MASK	(JENT_APT_LSB - 1)
+	unsigned int apt_observations;	/* Number of collected observations */
+	unsigned int apt_count;		/* APT counter */
+	unsigned int apt_base;		/* APT base reference */
+	unsigned int apt_base_set:1;	/* APT base reference set? */
+
+	unsigned int health_failure:1;	/* Permanent health failure */
 };
 
 /* Flags that can be used to initialize the RNG */
@@ -98,12 +114,201 @@ struct rand_data {
 				   * variations (2nd derivation of time is
 				   * zero). */
 #define JENT_ESTUCK		8 /* Too many stuck results during init. */
+#define JENT_EHEALTH		9 /* Health test failed during initialization */
+#define JENT_ERCT		10 /* RCT failed during initialization */
+
+#include "jitterentropy.h"
 
 /***************************************************************************
- * Helper functions
+ * Adaptive Proportion Test
+ *
+ * This test complies with SP800-90B section 4.4.2.
  ***************************************************************************/
 
-#include "jitterentropy.h"
+/**
+ * Reset the APT counter
+ *
+ * @ec [in] Reference to entropy collector
+ */
+static void jent_apt_reset(struct rand_data *ec, unsigned int delta_masked)
+{
+	/* Reset APT counter */
+	ec->apt_count = 0;
+	ec->apt_base = delta_masked;
+	ec->apt_observations = 0;
+}
+
+/**
+ * Insert a new entropy event into APT
+ *
+ * @ec [in] Reference to entropy collector
+ * @delta_masked [in] Masked time delta to process
+ */
+static void jent_apt_insert(struct rand_data *ec, unsigned int delta_masked)
+{
+	/* Initialize the base reference */
+	if (!ec->apt_base_set) {
+		ec->apt_base = delta_masked;
+		ec->apt_base_set = 1;
+		return;
+	}
+
+	if (delta_masked == ec->apt_base) {
+		ec->apt_count++;
+
+		if (ec->apt_count >= JENT_APT_CUTOFF)
+			ec->health_failure = 1;
+	}
+
+	ec->apt_observations++;
+
+	if (ec->apt_observations >= JENT_APT_WINDOW_SIZE)
+		jent_apt_reset(ec, delta_masked);
+}
+
+/***************************************************************************
+ * Stuck Test and its use as Repetition Count Test
+ *
+ * The Jitter RNG uses an enhanced version of the Repetition Count Test
+ * (RCT) specified in SP800-90B section 4.4.1. Instead of counting identical
+ * back-to-back values, the input to the RCT is the counting of the stuck
+ * values during the generation of one Jitter RNG output block.
+ *
+ * The RCT is applied with an alpha of 2^{-30} compliant to FIPS 140-2 IG 9.8.
+ *
+ * During the counting operation, the Jitter RNG always calculates the RCT
+ * cut-off value of C. If that value exceeds the allowed cut-off value,
+ * the Jitter RNG output block will be calculated completely but discarded at
+ * the end. The caller of the Jitter RNG is informed with an error code.
+ ***************************************************************************/
+
+/**
+ * Repetition Count Test as defined in SP800-90B section 4.4.1
+ *
+ * @ec [in] Reference to entropy collector
+ * @stuck [in] Indicator whether the value is stuck
+ */
+static void jent_rct_insert(struct rand_data *ec, int stuck)
+{
+	/*
+	 * If we have a count less than zero, a previous RCT round identified
+	 * a failure. We will not overwrite it.
+	 */
+	if (ec->rct_count < 0)
+		return;
+
+	if (stuck) {
+		ec->rct_count++;
+
+		/*
+		 * The cutoff value is based on the following consideration:
+		 * alpha = 2^-30 as recommended in FIPS 140-2 IG 9.8.
+		 * In addition, we require an entropy value H of 1/OSR as this
+		 * is the minimum entropy required to provide full entropy.
+		 * Note, we collect 64 * OSR deltas for inserting them into
+		 * the entropy pool which should then have (close to) 64 bits
+		 * of entropy.
+		 *
+		 * Note, ec->rct_count (which equals to value B in the pseudo
+		 * code of SP800-90B section 4.4.1) starts with zero. Hence
+		 * we need to subtract one from the cutoff value as calculated
+		 * following SP800-90B.
+		 */
+		if ((unsigned int)ec->rct_count >= (31 * ec->osr)) {
+			ec->rct_count = -1;
+			ec->health_failure = 1;
+		}
+	} else {
+		ec->rct_count = 0;
+	}
+}
+
+/**
+ * Is there an RCT health test failure?
+ *
+ * @ec [in] Reference to entropy collector
+ *
+ * @return
+ * 	0 No health test failure
+ * 	1 Permanent health test failure
+ */
+static int jent_rct_failure(struct rand_data *ec)
+{
+	if (ec->rct_count < 0)
+		return 1;
+	return 0;
+}
+
+static inline __u64 jent_delta(__u64 prev, __u64 next)
+{
+#define JENT_UINT64_MAX		(__u64)(~((__u64) 0))
+	return (prev < next) ? (next - prev) :
+			       (JENT_UINT64_MAX - prev + 1 + next);
+}
+
+/**
+ * Stuck test by checking the:
+ * 	1st derivative of the jitter measurement (time delta)
+ * 	2nd derivative of the jitter measurement (delta of time deltas)
+ * 	3rd derivative of the jitter measurement (delta of delta of time deltas)
+ *
+ * All values must always be non-zero.
+ *
+ * @ec [in] Reference to entropy collector
+ * @current_delta [in] Jitter time delta
+ *
+ * @return
+ * 	0 jitter measurement not stuck (good bit)
+ * 	1 jitter measurement stuck (reject bit)
+ */
+static int jent_stuck(struct rand_data *ec, __u64 current_delta)
+{
+	__u64 delta2 = jent_delta(ec->last_delta, current_delta);
+	__u64 delta3 = jent_delta(ec->last_delta2, delta2);
+	unsigned int delta_masked = current_delta & JENT_APT_WORD_MASK;
+
+	ec->last_delta = current_delta;
+	ec->last_delta2 = delta2;
+
+	/*
+	 * Insert the result of the comparison of two back-to-back time
+	 * deltas.
+	 */
+	jent_apt_insert(ec, delta_masked);
+
+	if (!current_delta || !delta2 || !delta3) {
+		/* RCT with a stuck bit */
+		jent_rct_insert(ec, 1);
+		return 1;
+	}
+
+	/* RCT with a non-stuck bit */
+	jent_rct_insert(ec, 0);
+
+	return 0;
+}
+
+/**
+ * Report any health test failures
+ *
+ * @ec [in] Reference to entropy collector
+ *
+ * @return
+ * 	0 No health test failure
+ * 	1 Permanent health test failure
+ */
+static int jent_health_failure(struct rand_data *ec)
+{
+	/* Test is only enabled in FIPS mode */
+	if (!jent_fips_enabled())
+		return 0;
+
+	return ec->health_failure;
+}
+
+/***************************************************************************
+ * Noise sources
+ ***************************************************************************/
 
 /**
  * Update of the loop count used for the next round of
@@ -148,10 +353,6 @@ static __u64 jent_loop_shuffle(struct rand_data *ec,
 	return (shuffle + (1<<min));
 }
 
-/***************************************************************************
- * Noise sources
- ***************************************************************************/
-
 /**
  * CPU Jitter noise source -- this is the noise source based on the CPU
  *			      execution time jitter
@@ -166,18 +367,19 @@ static __u64 jent_loop_shuffle(struct rand_data *ec,
  * the CPU execution time jitter. Any change to the loop in this function
  * implies that careful retesting must be done.
  *
- * Input:
- * @ec entropy collector struct
- * @time time stamp to be injected
- * @loop_cnt if a value not equal to 0 is set, use the given value as number of
- *	     loops to perform the folding
+ * @ec [in] entropy collector struct
+ * @time [in] time stamp to be injected
+ * @loop_cnt [in] if a value not equal to 0 is set, use the given value as
+ *		  number of loops to perform the folding
+ * @stuck [in] Is the time stamp identified as stuck?
  *
  * Output:
  * updated ec->data
  *
  * @return Number of loops the folding operation is performed
  */
-static __u64 jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt)
+static void jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt,
+			   int stuck)
 {
 	unsigned int i;
 	__u64 j = 0;
@@ -220,9 +422,17 @@ static __u64 jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt)
 			new ^= tmp;
 		}
 	}
-	ec->data = new;
 
-	return fold_loop_cnt;
+	/*
+	 * If the time stamp is stuck, do not finally insert the value into
+	 * the entropy pool. Although this operation should not do any harm
+	 * even when the time stamp has no entropy, SP800-90B requires that
+	 * any conditioning operation (SP800-90B considers the LFSR to be a
+	 * conditioning operation) to have an identical amount of input
+	 * data according to section 3.1.5.
+	 */
+	if (!stuck)
+		ec->data = new;
 }
 
 /**
@@ -243,16 +453,13 @@ static __u64 jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt)
  * to reliably access either L3 or memory, the ec->mem memory must be quite
  * large which is usually not desirable.
  *
- * Input:
- * @ec Reference to the entropy collector with the memory access data -- if
- *     the reference to the memory block to be accessed is NULL, this noise
- *     source is disabled
- * @loop_cnt if a value not equal to 0 is set, use the given value as number of
- *	     loops to perform the folding
- *
- * @return Number of memory access operations
+ * @ec [in] Reference to the entropy collector with the memory access data -- if
+ *	    the reference to the memory block to be accessed is NULL, this noise
+ *	    source is disabled
+ * @loop_cnt [in] if a value not equal to 0 is set, use the given value
+ *		  number of loops to perform the LFSR
  */
-static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
+static void jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
 {
 	unsigned int wrap = 0;
 	__u64 i = 0;
@@ -262,7 +469,7 @@ static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
 		jent_loop_shuffle(ec, MAX_ACC_LOOP_BIT, MIN_ACC_LOOP_BIT);
 
 	if (NULL == ec || NULL == ec->mem)
-		return 0;
+		return;
 	wrap = ec->memblocksize * ec->memblocks;
 
 	/*
@@ -288,43 +495,11 @@ static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
 		ec->memlocation = ec->memlocation + ec->memblocksize - 1;
 		ec->memlocation = ec->memlocation % wrap;
 	}
-	return i;
 }
 
 /***************************************************************************
  * Start of entropy processing logic
  ***************************************************************************/
-
-/**
- * Stuck test by checking the:
- *	1st derivation of the jitter measurement (time delta)
- *	2nd derivation of the jitter measurement (delta of time deltas)
- *	3rd derivation of the jitter measurement (delta of delta of time deltas)
- *
- * All values must always be non-zero.
- *
- * Input:
- * @ec Reference to entropy collector
- * @current_delta Jitter time delta
- *
- * @return
- *	0 jitter measurement not stuck (good bit)
- *	1 jitter measurement stuck (reject bit)
- */
-static int jent_stuck(struct rand_data *ec, __u64 current_delta)
-{
-	__s64 delta2 = ec->last_delta - current_delta;
-	__s64 delta3 = delta2 - ec->last_delta2;
-
-	ec->last_delta = current_delta;
-	ec->last_delta2 = delta2;
-
-	if (!current_delta || !delta2 || !delta3)
-		return 1;
-
-	return 0;
-}
-
 /**
  * This is the heart of the entropy generation: calculate time deltas and
  * use the CPU jitter in the time deltas. The jitter is injected into the
@@ -334,8 +509,7 @@ static int jent_stuck(struct rand_data *ec, __u64 current_delta)
  *	    of this function! This can be done by calling this function
  *	    and not using its result.
  *
- * Input:
- * @entropy_collector Reference to entropy collector
+ * @ec [in] Reference to entropy collector
  *
  * @return result of stuck test
  */
@@ -343,6 +517,7 @@ static int jent_measure_jitter(struct rand_data *ec)
 {
 	__u64 time = 0;
 	__u64 current_delta = 0;
+	int stuck;
 
 	/* Invoke one noise source before time measurement to add variations */
 	jent_memaccess(ec, 0);
@@ -352,22 +527,23 @@ static int jent_measure_jitter(struct rand_data *ec)
 	 * invocation to measure the timing variations
 	 */
 	jent_get_nstime(&time);
-	current_delta = time - ec->prev_time;
+	current_delta = jent_delta(ec->prev_time, time);
 	ec->prev_time = time;
 
+	/* Check whether we have a stuck measurement. */
+	stuck = jent_stuck(ec, current_delta);
+
 	/* Now call the next noise sources which also injects the data */
-	jent_lfsr_time(ec, current_delta, 0);
+	jent_lfsr_time(ec, current_delta, 0, stuck);
 
-	/* Check whether we have a stuck measurement. */
-	return jent_stuck(ec, current_delta);
+	return stuck;
 }
 
 /**
  * Generator of one 64 bit random number
  * Function fills rand_data->data
  *
- * Input:
- * @ec Reference to entropy collector
+ * @ec [in] Reference to entropy collector
  */
 static void jent_gen_entropy(struct rand_data *ec)
 {
@@ -390,31 +566,6 @@ static void jent_gen_entropy(struct rand_data *ec)
 	}
 }
 
-/**
- * The continuous test required by FIPS 140-2 -- the function automatically
- * primes the test if needed.
- *
- * Return:
- * returns normally if FIPS test passed
- * panics the kernel if FIPS test failed
- */
-static void jent_fips_test(struct rand_data *ec)
-{
-	if (!jent_fips_enabled())
-		return;
-
-	/* prime the FIPS test */
-	if (!ec->old_data) {
-		ec->old_data = ec->data;
-		jent_gen_entropy(ec);
-	}
-
-	if (ec->data == ec->old_data)
-		jent_panic("jitterentropy: Duplicate output detected\n");
-
-	ec->old_data = ec->data;
-}
-
 /**
  * Entry function: Obtain entropy for the caller.
  *
@@ -425,17 +576,18 @@ static void jent_fips_test(struct rand_data *ec)
  * This function truncates the last 64 bit entropy value output to the exact
  * size specified by the caller.
  *
- * Input:
- * @ec Reference to entropy collector
- * @data pointer to buffer for storing random data -- buffer must already
- *	 exist
- * @len size of the buffer, specifying also the requested number of random
- *	in bytes
+ * @ec [in] Reference to entropy collector
+ * @data [in] pointer to buffer for storing random data -- buffer must already
+ *	      exist
+ * @len [in] size of the buffer, specifying also the requested number of random
+ *	     in bytes
  *
  * @return 0 when request is fulfilled or an error
  *
  * The following error codes can occur:
  *	-1	entropy_collector is NULL
+ *	-2	RCT failed
+ *	-3	APT test failed
  */
 int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 		      unsigned int len)
@@ -449,7 +601,14 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 		unsigned int tocopy;
 
 		jent_gen_entropy(ec);
-		jent_fips_test(ec);
+
+		if (jent_health_failure(ec)) {
+			if (jent_rct_failure(ec))
+				return -2;
+			else
+				return -3;
+		}
+
 		if ((DATA_SIZE_BITS / 8) < len)
 			tocopy = (DATA_SIZE_BITS / 8);
 		else
@@ -513,11 +672,15 @@ int jent_entropy_init(void)
 	int i;
 	__u64 delta_sum = 0;
 	__u64 old_delta = 0;
+	unsigned int nonstuck = 0;
 	int time_backwards = 0;
 	int count_mod = 0;
 	int count_stuck = 0;
 	struct rand_data ec = { 0 };
 
+	/* Required for RCT */
+	ec.osr = 1;
+
 	/* We could perform statistical tests here, but the problem is
 	 * that we only have a few loop counts to do testing. These
 	 * loop counts may show some slight skew and we produce
@@ -539,8 +702,10 @@ int jent_entropy_init(void)
 	/*
 	 * TESTLOOPCOUNT needs some loops to identify edge systems. 100 is
 	 * definitely too little.
+	 *
+	 * SP800-90B requires at least 1024 initial test cycles.
 	 */
-#define TESTLOOPCOUNT 300
+#define TESTLOOPCOUNT 1024
 #define CLEARCACHE 100
 	for (i = 0; (TESTLOOPCOUNT + CLEARCACHE) > i; i++) {
 		__u64 time = 0;
@@ -552,13 +717,13 @@ int jent_entropy_init(void)
 		/* Invoke core entropy collection logic */
 		jent_get_nstime(&time);
 		ec.prev_time = time;
-		jent_lfsr_time(&ec, time, 0);
+		jent_lfsr_time(&ec, time, 0, 0);
 		jent_get_nstime(&time2);
 
 		/* test whether timer works */
 		if (!time || !time2)
 			return JENT_ENOTIME;
-		delta = time2 - time;
+		delta = jent_delta(time, time2);
 		/*
 		 * test whether timer is fine grained enough to provide
 		 * delta even when called shortly after each other -- this
@@ -581,6 +746,28 @@ int jent_entropy_init(void)
 
 		if (stuck)
 			count_stuck++;
+		else {
+			nonstuck++;
+
+			/*
+			 * Ensure that the APT succeeded.
+			 *
+			 * With the check below that count_stuck must be less
+			 * than 10% of the overall generated raw entropy values
+			 * it is guaranteed that the APT is invoked at
+			 * floor((TESTLOOPCOUNT * 0.9) / 64) == 14 times.
+			 */
+			if ((nonstuck % JENT_APT_WINDOW_SIZE) == 0) {
+				jent_apt_reset(&ec,
+					       delta & JENT_APT_WORD_MASK);
+				if (jent_health_failure(&ec))
+					return JENT_EHEALTH;
+			}
+		}
+
+		/* Validate RCT */
+		if (jent_rct_failure(&ec))
+			return JENT_ERCT;
 
 		/* test whether we have an increasing timer */
 		if (!(time2 > time))
-- 
2.25.2




