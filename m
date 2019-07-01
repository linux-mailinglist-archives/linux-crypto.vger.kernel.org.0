Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8612E53A
	for <lists+linux-crypto@lfdr.de>; Wed, 29 May 2019 21:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2TYe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 May 2019 15:24:34 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:21490 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2TYe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 May 2019 15:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559157869;
        s=strato-dkim-0002; d=chronox.de;
        h=Message-ID:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=MhvGGt3jtr1LjYGyq8Of3/1e8Sx+HlDCoBnlxG7xZqU=;
        b=P1iko3T7nVGw3wnvjS+b7d0IKerXlFynM22ossBV0wPsNi0cNnR49nCxKCDDY+u30n
        rmp/hKwEMQYEJwdkogIbGdOfyzX5km0DzcHyO88C4BL5o5bE6QXlpy5ewqXpLUca2xhz
        p896TUPwjnNgtFAgOHHuu/is9pxWA1/VZj+W9tD1243NtCovvBRIS+yW5+9FVtKsoAIA
        wXuGZAyyf1Nz2y3jf5J/448L7C9iEp53jg7stVvWNDpmfQcxivvJMNqkCpdyWFPIYNr2
        TTuc5SXjISYPWN9mqshRoj2dRbP3sn542bzchXvGWHw4pZeF1r9EA3VyPHKNLbMhYgli
        z3Ow==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbLvSf34ur"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id R0373fv4TJOQxiD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 29 May 2019 21:24:26 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, Reto Buerki <reet@codelabs.ch>
Subject: [PATCH] crypto: Jitter RNG - update implementation to 2.1.2
Date:   Wed, 29 May 2019 21:24:25 +0200
Message-ID: <6808423.xveKLjRae5@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The Jitter RNG implementation is updated to comply with upstream version
2.1.2. The change covers the following aspects:

* Time variation measurement is conducted over the LFSR operation
instead of the XOR folding

* Invcation of stuck test during initialization

* Removal of the stirring functionality and the Von-Neumann
unbiaser as the LFSR using a primitive and irreducible polynomial
generates an identical distribution of random bits

This implementation was successfully used in FIPS 140-2 validations
as well as in German BSI evaluations.

This kernel implementation was tested as follows:

* The unchanged kernel code file jitterentropy.c is compiled as part
of user space application to generate raw unconditioned noise
data. That data is processed with the NIST SP800-90B non-IID test
tool to verify that the kernel code exhibits an equal amount of noise
as the upstream Jitter RNG version 2.1.2.

* Using AF_ALG with the libkcapi tool of kcapi-rng the Jitter RNG was
output tested with dieharder to verify that the output does not
exhibit statistical weaknesses. The following command was used:
kcapi-rng -n "jitterentropy_rng" -b 100000000000 | dieharder -a -g 200

* The unchanged kernel code file jitterentropy.c is compiled as part
of user space application to test the LFSR implementation. The
LFSR is injected a monotonically increasing counter as input and
the output is fed into dieharder to verify that the LFSR operation
does not exhibit statistical weaknesses.

* The patch was tested on the Muen separation kernel which returns
a more coarse time stamp to verify that the Jitter RNG does not cause
regressions with its initialization test considering that the Jitter
RNG depends on a high-resolution timer.

Tested-by: Reto Buerki <reet@codelabs.ch>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/jitterentropy-kcapi.c |   5 -
 crypto/jitterentropy.c       | 305 ++++++++++-------------------------
 2 files changed, 82 insertions(+), 228 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 6ea1a270b8dc..699db1726ead 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -56,11 +56,6 @@ void jent_entropy_collector_free(struct rand_data *entropy_collector);
  * Helper function
  ***************************************************************************/
 
-__u64 jent_rol64(__u64 word, unsigned int shift)
-{
-	return rol64(word, shift);
-}
-
 void *jent_zalloc(unsigned int len)
 {
 	return kzalloc(len, GFP_KERNEL);
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index acf44b2d2d1d..77fa2120fe0c 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -2,7 +2,7 @@
  * Non-physical true random number generator based on timing jitter --
  * Jitter RNG standalone code.
  *
- * Copyright Stephan Mueller <smueller@chronox.de>, 2015
+ * Copyright Stephan Mueller <smueller@chronox.de>, 2015 - 2019
  *
  * Design
  * ======
@@ -47,7 +47,7 @@
 
 /*
  * This Jitterentropy RNG is based on the jitterentropy library
- * version 1.1.0 provided at http://www.chronox.de/jent.html
+ * version 2.1.2 provided at http://www.chronox.de/jent.html
  */
 
 #ifdef __OPTIMIZE__
@@ -71,10 +71,7 @@ struct rand_data {
 #define DATA_SIZE_BITS ((sizeof(__u64)) * 8)
 	__u64 last_delta;	/* SENSITIVE stuck test */
 	__s64 last_delta2;	/* SENSITIVE stuck test */
-	unsigned int stuck:1;	/* Time measurement stuck */
 	unsigned int osr;	/* Oversample rate */
-	unsigned int stir:1;		/* Post-processing stirring */
-	unsigned int disable_unbias:1;	/* Deactivate Von-Neuman unbias */
 #define JENT_MEMORY_BLOCKS 64
 #define JENT_MEMORY_BLOCKSIZE 32
 #define JENT_MEMORY_ACCESSLOOPS 128
@@ -89,8 +86,6 @@ struct rand_data {
 };
 
 /* Flags that can be used to initialize the RNG */
-#define JENT_DISABLE_STIR (1<<0) /* Disable stirring the entropy pool */
-#define JENT_DISABLE_UNBIAS (1<<1) /* Disable the Von-Neuman Unbiaser */
 #define JENT_DISABLE_MEMORY_ACCESS (1<<2) /* Disable memory access for more
 					   * entropy, saves MEMORY_SIZE RAM for
 					   * entropy collector */
@@ -99,19 +94,16 @@ struct rand_data {
 #define JENT_ENOTIME		1 /* Timer service not available */
 #define JENT_ECOARSETIME	2 /* Timer too coarse for RNG */
 #define JENT_ENOMONOTONIC	3 /* Timer is not monotonic increasing */
-#define JENT_EMINVARIATION	4 /* Timer variations too small for RNG */
 #define JENT_EVARVAR		5 /* Timer does not produce variations of
 				   * variations (2nd derivation of time is
 				   * zero). */
-#define JENT_EMINVARVAR		6 /* Timer variations of variations is tooi
-				   * small. */
+#define JENT_ESTUCK		8 /* Too many stuck results during init. */
 
 /***************************************************************************
  * Helper functions
  ***************************************************************************/
 
 void jent_get_nstime(__u64 *out);
-__u64 jent_rol64(__u64 word, unsigned int shift);
 void *jent_zalloc(unsigned int len);
 void jent_zfree(void *ptr);
 int jent_fips_enabled(void);
@@ -140,16 +132,16 @@ static __u64 jent_loop_shuffle(struct rand_data *ec,
 
 	jent_get_nstime(&time);
 	/*
-	 * mix the current state of the random number into the shuffle
-	 * calculation to balance that shuffle a bit more
+	 * Mix the current state of the random number into the shuffle
+	 * calculation to balance that shuffle a bit more.
 	 */
 	if (ec)
 		time ^= ec->data;
 	/*
-	 * we fold the time value as much as possible to ensure that as many
-	 * bits of the time stamp are included as possible
+	 * We fold the time value as much as possible to ensure that as many
+	 * bits of the time stamp are included as possible.
 	 */
-	for (i = 0; (DATA_SIZE_BITS / bits) > i; i++) {
+	for (i = 0; ((DATA_SIZE_BITS + bits - 1) / bits) > i; i++) {
 		shuffle ^= time & mask;
 		time = time >> bits;
 	}
@@ -169,38 +161,28 @@ static __u64 jent_loop_shuffle(struct rand_data *ec,
  * CPU Jitter noise source -- this is the noise source based on the CPU
  *			      execution time jitter
  *
- * This function folds the time into one bit units by iterating
- * through the DATA_SIZE_BITS bit time value as follows: assume our time value
- * is 0xabcd
- * 1st loop, 1st shift generates 0xd000
- * 1st loop, 2nd shift generates 0x000d
- * 2nd loop, 1st shift generates 0xcd00
- * 2nd loop, 2nd shift generates 0x000c
- * 3rd loop, 1st shift generates 0xbcd0
- * 3rd loop, 2nd shift generates 0x000b
- * 4th loop, 1st shift generates 0xabcd
- * 4th loop, 2nd shift generates 0x000a
- * Now, the values at the end of the 2nd shifts are XORed together.
+ * This function injects the individual bits of the time value into the
+ * entropy pool using an LFSR.
  *
- * The code is deliberately inefficient and shall stay that way. This function
- * is the root cause why the code shall be compiled without optimization. This
- * function not only acts as folding operation, but this function's execution
- * is used to measure the CPU execution time jitter. Any change to the loop in
- * this function implies that careful retesting must be done.
+ * The code is deliberately inefficient with respect to the bit shifting
+ * and shall stay that way. This function is the root cause why the code
+ * shall be compiled without optimization. This function not only acts as
+ * folding operation, but this function's execution is used to measure
+ * the CPU execution time jitter. Any change to the loop in this function
+ * implies that careful retesting must be done.
  *
  * Input:
  * @ec entropy collector struct -- may be NULL
- * @time time stamp to be folded
+ * @time time stamp to be injected
  * @loop_cnt if a value not equal to 0 is set, use the given value as number of
  *	     loops to perform the folding
  *
  * Output:
- * @folded result of folding operation
+ * updated ec->data
  *
  * @return Number of loops the folding operation is performed
  */
-static __u64 jent_fold_time(struct rand_data *ec, __u64 time,
-			    __u64 *folded, __u64 loop_cnt)
+static __u64 jent_lfsr_time(struct rand_data *ec, __u64 time, __u64 loop_cnt)
 {
 	unsigned int i;
 	__u64 j = 0;
@@ -217,15 +199,34 @@ static __u64 jent_fold_time(struct rand_data *ec, __u64 time,
 	if (loop_cnt)
 		fold_loop_cnt = loop_cnt;
 	for (j = 0; j < fold_loop_cnt; j++) {
-		new = 0;
+		new = ec->data;
 		for (i = 1; (DATA_SIZE_BITS) >= i; i++) {
 			__u64 tmp = time << (DATA_SIZE_BITS - i);
 
 			tmp = tmp >> (DATA_SIZE_BITS - 1);
+
+			/*
+			* Fibonacci LSFR with polynomial of
+			*  x^64 + x^61 + x^56 + x^31 + x^28 + x^23 + 1 which is
+			*  primitive according to
+			*   http://poincare.matf.bg.ac.rs/~ezivkovm/publications/primpol1.pdf
+			* (the shift values are the polynomial values minus one
+			* due to counting bits from 0 to 63). As the current
+			* position is always the LSB, the polynomial only needs
+			* to shift data in from the left without wrap.
+			*/
+			tmp ^= ((new >> 63) & 1);
+			tmp ^= ((new >> 60) & 1);
+			tmp ^= ((new >> 55) & 1);
+			tmp ^= ((new >> 30) & 1);
+			tmp ^= ((new >> 27) & 1);
+			tmp ^= ((new >> 22) & 1);
+			new <<= 1;
 			new ^= tmp;
 		}
 	}
-	*folded = new;
+	ec->data = new;
+
 	return fold_loop_cnt;
 }
 
@@ -258,7 +259,6 @@ static __u64 jent_fold_time(struct rand_data *ec, __u64 time,
  */
 static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
 {
-	unsigned char *tmpval = NULL;
 	unsigned int wrap = 0;
 	__u64 i = 0;
 #define MAX_ACC_LOOP_BIT 7
@@ -278,7 +278,7 @@ static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
 		acc_loop_cnt = loop_cnt;
 
 	for (i = 0; i < (ec->memaccessloops + acc_loop_cnt); i++) {
-		tmpval = ec->mem + ec->memlocation;
+		unsigned char *tmpval = ec->mem + ec->memlocation;
 		/*
 		 * memory access: just add 1 to one byte,
 		 * wrap at 255 -- memory access implies read
@@ -316,7 +316,7 @@ static unsigned int jent_memaccess(struct rand_data *ec, __u64 loop_cnt)
  *	0 jitter measurement not stuck (good bit)
  *	1 jitter measurement stuck (reject bit)
  */
-static void jent_stuck(struct rand_data *ec, __u64 current_delta)
+static int jent_stuck(struct rand_data *ec, __u64 current_delta)
 {
 	__s64 delta2 = ec->last_delta - current_delta;
 	__s64 delta3 = delta2 - ec->last_delta2;
@@ -325,14 +325,15 @@ static void jent_stuck(struct rand_data *ec, __u64 current_delta)
 	ec->last_delta2 = delta2;
 
 	if (!current_delta || !delta2 || !delta3)
-		ec->stuck = 1;
+		return 1;
+
+	return 0;
 }
 
 /**
  * This is the heart of the entropy generation: calculate time deltas and
- * use the CPU jitter in the time deltas. The jitter is folded into one
- * bit. You can call this function the "random bit generator" as it
- * produces one random bit per invocation.
+ * use the CPU jitter in the time deltas. The jitter is injected into the
+ * entropy pool.
  *
  * WARNING: ensure that ->prev_time is primed before using the output
  *	    of this function! This can be done by calling this function
@@ -341,12 +342,11 @@ static void jent_stuck(struct rand_data *ec, __u64 current_delta)
  * Input:
  * @entropy_collector Reference to entropy collector
  *
- * @return One random bit
+ * @return result of stuck test
  */
-static __u64 jent_measure_jitter(struct rand_data *ec)
+static int jent_measure_jitter(struct rand_data *ec)
 {
 	__u64 time = 0;
-	__u64 data = 0;
 	__u64 current_delta = 0;
 
 	/* Invoke one noise source before time measurement to add variations */
@@ -360,109 +360,11 @@ static __u64 jent_measure_jitter(struct rand_data *ec)
 	current_delta = time - ec->prev_time;
 	ec->prev_time = time;
 
-	/* Now call the next noise sources which also folds the data */
-	jent_fold_time(ec, current_delta, &data, 0);
-
-	/*
-	 * Check whether we have a stuck measurement. The enforcement
-	 * is performed after the stuck value has been mixed into the
-	 * entropy pool.
-	 */
-	jent_stuck(ec, current_delta);
-
-	return data;
-}
-
-/**
- * Von Neuman unbias as explained in RFC 4086 section 4.2. As shown in the
- * documentation of that RNG, the bits from jent_measure_jitter are considered
- * independent which implies that the Von Neuman unbias operation is applicable.
- * A proof of the Von-Neumann unbias operation to remove skews is given in the
- * document "A proposal for: Functionality classes for random number
- * generators", version 2.0 by Werner Schindler, section 5.4.1.
- *
- * Input:
- * @entropy_collector Reference to entropy collector
- *
- * @return One random bit
- */
-static __u64 jent_unbiased_bit(struct rand_data *entropy_collector)
-{
-	do {
-		__u64 a = jent_measure_jitter(entropy_collector);
-		__u64 b = jent_measure_jitter(entropy_collector);
-
-		if (a == b)
-			continue;
-		if (1 == a)
-			return 1;
-		else
-			return 0;
-	} while (1);
-}
-
-/**
- * Shuffle the pool a bit by mixing some value with a bijective function (XOR)
- * into the pool.
- *
- * The function generates a mixer value that depends on the bits set and the
- * location of the set bits in the random number generated by the entropy
- * source. Therefore, based on the generated random number, this mixer value
- * can have 2**64 different values. That mixer value is initialized with the
- * first two SHA-1 constants. After obtaining the mixer value, it is XORed into
- * the random number.
- *
- * The mixer value is not assumed to contain any entropy. But due to the XOR
- * operation, it can also not destroy any entropy present in the entropy pool.
- *
- * Input:
- * @entropy_collector Reference to entropy collector
- */
-static void jent_stir_pool(struct rand_data *entropy_collector)
-{
-	/*
-	 * to shut up GCC on 32 bit, we have to initialize the 64 variable
-	 * with two 32 bit variables
-	 */
-	union c {
-		__u64 u64;
-		__u32 u32[2];
-	};
-	/*
-	 * This constant is derived from the first two 32 bit initialization
-	 * vectors of SHA-1 as defined in FIPS 180-4 section 5.3.1
-	 */
-	union c constant;
-	/*
-	 * The start value of the mixer variable is derived from the third
-	 * and fourth 32 bit initialization vector of SHA-1 as defined in
-	 * FIPS 180-4 section 5.3.1
-	 */
-	union c mixer;
-	unsigned int i = 0;
-
-	/*
-	 * Store the SHA-1 constants in reverse order to make up the 64 bit
-	 * value -- this applies to a little endian system, on a big endian
-	 * system, it reverses as expected. But this really does not matter
-	 * as we do not rely on the specific numbers. We just pick the SHA-1
-	 * constants as they have a good mix of bit set and unset.
-	 */
-	constant.u32[1] = 0x67452301;
-	constant.u32[0] = 0xefcdab89;
-	mixer.u32[1] = 0x98badcfe;
-	mixer.u32[0] = 0x10325476;
+	/* Now call the next noise sources which also injects the data */
+	jent_lfsr_time(ec, current_delta, 0);
 
-	for (i = 0; i < DATA_SIZE_BITS; i++) {
-		/*
-		 * get the i-th bit of the input random number and only XOR
-		 * the constant into the mixer value when that bit is set
-		 */
-		if ((entropy_collector->data >> i) & 1)
-			mixer.u64 ^= constant.u64;
-		mixer.u64 = jent_rol64(mixer.u64, 1);
-	}
-	entropy_collector->data ^= mixer.u64;
+	/* Check whether we have a stuck measurement. */
+	return jent_stuck(ec, current_delta);
 }
 
 /**
@@ -480,48 +382,9 @@ static void jent_gen_entropy(struct rand_data *ec)
 	jent_measure_jitter(ec);
 
 	while (1) {
-		__u64 data = 0;
-
-		if (ec->disable_unbias == 1)
-			data = jent_measure_jitter(ec);
-		else
-			data = jent_unbiased_bit(ec);
-
-		/* enforcement of the jent_stuck test */
-		if (ec->stuck) {
-			/*
-			 * We only mix in the bit considered not appropriate
-			 * without the LSFR. The reason is that if we apply
-			 * the LSFR and we do not rotate, the 2nd bit with LSFR
-			 * will cancel out the first LSFR application on the
-			 * bad bit.
-			 *
-			 * And we do not rotate as we apply the next bit to the
-			 * current bit location again.
-			 */
-			ec->data ^= data;
-			ec->stuck = 0;
+		/* If a stuck measurement is received, repeat measurement */
+		if (jent_measure_jitter(ec))
 			continue;
-		}
-
-		/*
-		 * Fibonacci LSFR with polynom of
-		 *  x^64 + x^61 + x^56 + x^31 + x^28 + x^23 + 1 which is
-		 *  primitive according to
-		 *   http://poincare.matf.bg.ac.rs/~ezivkovm/publications/primpol1.pdf
-		 * (the shift values are the polynom values minus one
-		 * due to counting bits from 0 to 63). As the current
-		 * position is always the LSB, the polynom only needs
-		 * to shift data in from the left without wrap.
-		 */
-		ec->data ^= data;
-		ec->data ^= ((ec->data >> 63) & 1);
-		ec->data ^= ((ec->data >> 60) & 1);
-		ec->data ^= ((ec->data >> 55) & 1);
-		ec->data ^= ((ec->data >> 30) & 1);
-		ec->data ^= ((ec->data >> 27) & 1);
-		ec->data ^= ((ec->data >> 22) & 1);
-		ec->data = jent_rol64(ec->data, 1);
 
 		/*
 		 * We multiply the loop value with ->osr to obtain the
@@ -530,8 +393,6 @@ static void jent_gen_entropy(struct rand_data *ec)
 		if (++k >= (DATA_SIZE_BITS * ec->osr))
 			break;
 	}
-	if (ec->stir)
-		jent_stir_pool(ec);
 }
 
 /**
@@ -639,12 +500,6 @@ struct rand_data *jent_entropy_collector_alloc(unsigned int osr,
 		osr = 1; /* minimum sampling rate is 1 */
 	entropy_collector->osr = osr;
 
-	entropy_collector->stir = 1;
-	if (flags & JENT_DISABLE_STIR)
-		entropy_collector->stir = 0;
-	if (flags & JENT_DISABLE_UNBIAS)
-		entropy_collector->disable_unbias = 1;
-
 	/* fill the data pad with non-zero values */
 	jent_gen_entropy(entropy_collector);
 
@@ -656,7 +511,6 @@ void jent_entropy_collector_free(struct rand_data *entropy_collector)
 	jent_zfree(entropy_collector->mem);
 	entropy_collector->mem = NULL;
 	jent_zfree(entropy_collector);
-	entropy_collector = NULL;
 }
 
 int jent_entropy_init(void)
@@ -665,8 +519,9 @@ int jent_entropy_init(void)
 	__u64 delta_sum = 0;
 	__u64 old_delta = 0;
 	int time_backwards = 0;
-	int count_var = 0;
 	int count_mod = 0;
+	int count_stuck = 0;
+	struct rand_data ec = { 0 };
 
 	/* We could perform statistical tests here, but the problem is
 	 * that we only have a few loop counts to do testing. These
@@ -695,12 +550,14 @@ int jent_entropy_init(void)
 	for (i = 0; (TESTLOOPCOUNT + CLEARCACHE) > i; i++) {
 		__u64 time = 0;
 		__u64 time2 = 0;
-		__u64 folded = 0;
 		__u64 delta = 0;
 		unsigned int lowdelta = 0;
+		int stuck;
 
+		/* Invoke core entropy collection logic */
 		jent_get_nstime(&time);
-		jent_fold_time(NULL, time, &folded, 1<<MIN_FOLD_LOOP_BIT);
+		ec.prev_time = time;
+		jent_lfsr_time(&ec, time, 0);
 		jent_get_nstime(&time2);
 
 		/* test whether timer works */
@@ -715,6 +572,8 @@ int jent_entropy_init(void)
 		if (!delta)
 			return JENT_ECOARSETIME;
 
+		stuck = jent_stuck(&ec, delta);
+
 		/*
 		 * up to here we did not modify any variable that will be
 		 * evaluated later, but we already performed some work. Thus we
@@ -725,14 +584,14 @@ int jent_entropy_init(void)
 		if (CLEARCACHE > i)
 			continue;
 
+		if (stuck)
+			count_stuck++;
+
 		/* test whether we have an increasing timer */
 		if (!(time2 > time))
 			time_backwards++;
 
-		/*
-		 * Avoid modulo of 64 bit integer to allow code to compile
-		 * on 32 bit architectures.
-		 */
+		/* use 32 bit value to ensure compilation on 32 bit arches */
 		lowdelta = time2 - time;
 		if (!(lowdelta % 100))
 			count_mod++;
@@ -743,14 +602,10 @@ int jent_entropy_init(void)
 		 * only after the first loop is executed as we need to prime
 		 * the old_data value
 		 */
-		if (i) {
-			if (delta != old_delta)
-				count_var++;
-			if (delta > old_delta)
-				delta_sum += (delta - old_delta);
-			else
-				delta_sum += (old_delta - delta);
-		}
+		if (delta > old_delta)
+			delta_sum += (delta - old_delta);
+		else
+			delta_sum += (old_delta - delta);
 		old_delta = delta;
 	}
 
@@ -763,25 +618,29 @@ int jent_entropy_init(void)
 	 */
 	if (3 < time_backwards)
 		return JENT_ENOMONOTONIC;
-	/* Error if the time variances are always identical */
-	if (!delta_sum)
-		return JENT_EVARVAR;
 
 	/*
 	 * Variations of deltas of time must on average be larger
 	 * than 1 to ensure the entropy estimation
 	 * implied with 1 is preserved
 	 */
-	if (delta_sum <= 1)
-		return JENT_EMINVARVAR;
+	if ((delta_sum) <= 1)
+		return JENT_EVARVAR;
 
 	/*
 	 * Ensure that we have variations in the time stamp below 10 for at
-	 * least 10% of all checks -- on some platforms, the counter
-	 * increments in multiples of 100, but not always
+	 * least 10% of all checks -- on some platforms, the counter increments
+	 * in multiples of 100, but not always
 	 */
 	if ((TESTLOOPCOUNT/10 * 9) < count_mod)
 		return JENT_ECOARSETIME;
 
+	/*
+	 * If we have more than 90% stuck results, then this Jitter RNG is
+	 * likely to not work well.
+	 */
+	if ((TESTLOOPCOUNT/10 * 9) < count_stuck)
+		return JENT_ESTUCK;
+
 	return 0;
 }
-- 
2.21.0




