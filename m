Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0196F74D4
	for <lists+linux-crypto@lfdr.de>; Thu,  4 May 2023 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEDTxn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 May 2023 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjEDTwp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 May 2023 15:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43514E53;
        Thu,  4 May 2023 12:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6770637CE;
        Thu,  4 May 2023 19:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA1FC433D2;
        Thu,  4 May 2023 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229643;
        bh=TvdQX2XdC6Rd+gjChtYgSXmDF+mK9u/JwUqgSIU98/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbtxyNPLczlNi57MYGait19JBXt2u+IGxknny1PczT3SA1kN2hp+eoMtp7PvVvgYN
         Xi8Dud4VQmweWrRzPx83SChUKxBhUvJDFYD92NJKGGRl9CpJbMmYp8zS+VbmIUETOC
         Kz3otasRH5E4PRX3bY0I1jyBPq4AcHs0ZEdjfc9tYBNv7ruiEOyz53mD5KBivj+To9
         geQlwzBN+LRNhrA2cL5JP+xjO6/W7MMyaEBufmCEal3yl34mCPt6EKGuxnwrcfOdb0
         N8VywsbGc2WfSLthhkuImzD7W40iVa6k+LIdyIq76cE/llQW1jXJYHRX80g5BouRGk
         RtWtsV7FixfXA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/49] crypto: jitter - permanent and intermittent health errors
Date:   Thu,  4 May 2023 15:45:58 -0400
Message-Id: <20230504194626.3807438-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Stephan Müller <smueller@chronox.de>

[ Upstream commit 3fde2fe99aa6dacd4151c87382b07ce7f30f0a52 ]

According to SP800-90B, two health failures are allowed: the intermittend
and the permanent failure. So far, only the intermittent failure was
implemented. The permanent failure was achieved by resetting the entire
entropy source including its health test state and waiting for two or
more back-to-back health errors.

This approach is appropriate for RCT, but not for APT as APT has a
non-linear cutoff value. Thus, this patch implements 2 cutoff values
for both RCT/APT. This implies that the health state is left untouched
when an intermittent failure occurs. The noise source is reset
and a new APT powerup-self test is performed. Yet, whith the unchanged
health test state, the counting of failures continues until a permanent
failure is reached.

Any non-failing raw entropy value causes the health tests to reset.

The intermittent error has an unchanged significance level of 2^-30.
The permanent error has a significance level of 2^-60. Considering that
this level also indicates a false-positive rate (see SP800-90B section 4.2)
a false-positive must only be incurred with a low probability when
considering a fleet of Linux kernels as a whole. Hitting the permanent
error may cause a panic(), the following calculation applies: Assuming
that a fleet of 10^9 Linux kernels run concurrently with this patch in
FIPS mode and on each kernel 2 health tests are performed every minute
for one year, the chances of a false positive is about 1:1000
based on the binomial distribution.

In addition, any power-up health test errors triggered with
jent_entropy_init are treated as permanent errors.

A permanent failure causes the entire entropy source to permanently
return an error. This implies that a caller can only remedy the situation
by re-allocating a new instance of the Jitter RNG. In a subsequent
patch, a transparent re-allocation will be provided which also changes
the implied heuristic entropy assessment.

In addition, when the kernel is booted with fips=1, the Jitter RNG
is defined to be part of a FIPS module. The permanent error of the
Jitter RNG is translated as a FIPS module error. In this case, the entire
FIPS module must cease operation. This is implemented in the kernel by
invoking panic().

The patch also fixes an off-by-one in the RCT cutoff value which is now
set to 30 instead of 31. This is because the counting of the values
starts with 0.

Reviewed-by: Vladis Dronov <vdronov@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/jitterentropy-kcapi.c |  51 ++++++-------
 crypto/jitterentropy.c       | 144 +++++++++++++----------------------
 crypto/jitterentropy.h       |   1 -
 3 files changed, 76 insertions(+), 120 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 2d115bec15aeb..b9edfaa51b273 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -37,6 +37,7 @@
  * DAMAGE.
  */
 
+#include <linux/fips.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -59,11 +60,6 @@ void jent_zfree(void *ptr)
 	kfree_sensitive(ptr);
 }
 
-void jent_panic(char *s)
-{
-	panic("%s", s);
-}
-
 void jent_memcpy(void *dest, const void *src, unsigned int n)
 {
 	memcpy(dest, src, n);
@@ -102,7 +98,6 @@ void jent_get_nstime(__u64 *out)
 struct jitterentropy {
 	spinlock_t jent_lock;
 	struct rand_data *entropy_collector;
-	unsigned int reset_cnt;
 };
 
 static int jent_kcapi_init(struct crypto_tfm *tfm)
@@ -138,32 +133,30 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
 
 	spin_lock(&rng->jent_lock);
 
-	/* Return a permanent error in case we had too many resets in a row. */
-	if (rng->reset_cnt > (1<<10)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
 	ret = jent_read_entropy(rng->entropy_collector, rdata, dlen);
 
-	/* Reset RNG in case of health failures */
-	if (ret < -1) {
-		pr_warn_ratelimited("Reset Jitter RNG due to health test failure: %s failure\n",
-				    (ret == -2) ? "Repetition Count Test" :
-						  "Adaptive Proportion Test");
-
-		rng->reset_cnt++;
-
+	if (ret == -3) {
+		/* Handle permanent health test error */
+		/*
+		 * If the kernel was booted with fips=1, it implies that
+		 * the entire kernel acts as a FIPS 140 module. In this case
+		 * an SP800-90B permanent health test error is treated as
+		 * a FIPS module error.
+		 */
+		if (fips_enabled)
+			panic("Jitter RNG permanent health test failure\n");
+
+		pr_err("Jitter RNG permanent health test failure\n");
+		ret = -EFAULT;
+	} else if (ret == -2) {
+		/* Handle intermittent health test error */
+		pr_warn_ratelimited("Reset Jitter RNG due to intermittent health test failure\n");
 		ret = -EAGAIN;
-	} else {
-		rng->reset_cnt = 0;
-
-		/* Convert the Jitter RNG error into a usable error code */
-		if (ret == -1)
-			ret = -EINVAL;
+	} else if (ret == -1) {
+		/* Handle other errors */
+		ret = -EINVAL;
 	}
 
-out:
 	spin_unlock(&rng->jent_lock);
 
 	return ret;
@@ -197,6 +190,10 @@ static int __init jent_mod_init(void)
 
 	ret = jent_entropy_init();
 	if (ret) {
+		/* Handle permanent health test error */
+		if (fips_enabled)
+			panic("jitterentropy: Initialization failed with host not compliant with requirements: %d\n", ret);
+
 		pr_info("jitterentropy: Initialization failed with host not compliant with requirements: %d\n", ret);
 		return -EFAULT;
 	}
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 93bff32138238..22f48bf4c6f57 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -85,10 +85,14 @@ struct rand_data {
 				      * bit generation */
 
 	/* Repetition Count Test */
-	int rct_count;			/* Number of stuck values */
+	unsigned int rct_count;			/* Number of stuck values */
 
-	/* Adaptive Proportion Test for a significance level of 2^-30 */
+	/* Intermittent health test failure threshold of 2^-30 */
+#define JENT_RCT_CUTOFF		30	/* Taken from SP800-90B sec 4.4.1 */
 #define JENT_APT_CUTOFF		325	/* Taken from SP800-90B sec 4.4.2 */
+	/* Permanent health test failure threshold of 2^-60 */
+#define JENT_RCT_CUTOFF_PERMANENT	60
+#define JENT_APT_CUTOFF_PERMANENT	355
 #define JENT_APT_WINDOW_SIZE	512	/* Data window size */
 	/* LSB of time stamp to process */
 #define JENT_APT_LSB		16
@@ -97,8 +101,6 @@ struct rand_data {
 	unsigned int apt_count;		/* APT counter */
 	unsigned int apt_base;		/* APT base reference */
 	unsigned int apt_base_set:1;	/* APT base reference set? */
-
-	unsigned int health_failure:1;	/* Permanent health failure */
 };
 
 /* Flags that can be used to initialize the RNG */
@@ -169,19 +171,26 @@ static void jent_apt_insert(struct rand_data *ec, unsigned int delta_masked)
 		return;
 	}
 
-	if (delta_masked == ec->apt_base) {
+	if (delta_masked == ec->apt_base)
 		ec->apt_count++;
 
-		if (ec->apt_count >= JENT_APT_CUTOFF)
-			ec->health_failure = 1;
-	}
-
 	ec->apt_observations++;
 
 	if (ec->apt_observations >= JENT_APT_WINDOW_SIZE)
 		jent_apt_reset(ec, delta_masked);
 }
 
+/* APT health test failure detection */
+static int jent_apt_permanent_failure(struct rand_data *ec)
+{
+	return (ec->apt_count >= JENT_APT_CUTOFF_PERMANENT) ? 1 : 0;
+}
+
+static int jent_apt_failure(struct rand_data *ec)
+{
+	return (ec->apt_count >= JENT_APT_CUTOFF) ? 1 : 0;
+}
+
 /***************************************************************************
  * Stuck Test and its use as Repetition Count Test
  *
@@ -206,55 +215,14 @@ static void jent_apt_insert(struct rand_data *ec, unsigned int delta_masked)
  */
 static void jent_rct_insert(struct rand_data *ec, int stuck)
 {
-	/*
-	 * If we have a count less than zero, a previous RCT round identified
-	 * a failure. We will not overwrite it.
-	 */
-	if (ec->rct_count < 0)
-		return;
-
 	if (stuck) {
 		ec->rct_count++;
-
-		/*
-		 * The cutoff value is based on the following consideration:
-		 * alpha = 2^-30 as recommended in FIPS 140-2 IG 9.8.
-		 * In addition, we require an entropy value H of 1/OSR as this
-		 * is the minimum entropy required to provide full entropy.
-		 * Note, we collect 64 * OSR deltas for inserting them into
-		 * the entropy pool which should then have (close to) 64 bits
-		 * of entropy.
-		 *
-		 * Note, ec->rct_count (which equals to value B in the pseudo
-		 * code of SP800-90B section 4.4.1) starts with zero. Hence
-		 * we need to subtract one from the cutoff value as calculated
-		 * following SP800-90B.
-		 */
-		if ((unsigned int)ec->rct_count >= (31 * ec->osr)) {
-			ec->rct_count = -1;
-			ec->health_failure = 1;
-		}
 	} else {
+		/* Reset RCT */
 		ec->rct_count = 0;
 	}
 }
 
-/*
- * Is there an RCT health test failure?
- *
- * @ec [in] Reference to entropy collector
- *
- * @return
- * 	0 No health test failure
- * 	1 Permanent health test failure
- */
-static int jent_rct_failure(struct rand_data *ec)
-{
-	if (ec->rct_count < 0)
-		return 1;
-	return 0;
-}
-
 static inline __u64 jent_delta(__u64 prev, __u64 next)
 {
 #define JENT_UINT64_MAX		(__u64)(~((__u64) 0))
@@ -303,18 +271,26 @@ static int jent_stuck(struct rand_data *ec, __u64 current_delta)
 	return 0;
 }
 
-/*
- * Report any health test failures
- *
- * @ec [in] Reference to entropy collector
- *
- * @return
- * 	0 No health test failure
- * 	1 Permanent health test failure
- */
+/* RCT health test failure detection */
+static int jent_rct_permanent_failure(struct rand_data *ec)
+{
+	return (ec->rct_count >= JENT_RCT_CUTOFF_PERMANENT) ? 1 : 0;
+}
+
+static int jent_rct_failure(struct rand_data *ec)
+{
+	return (ec->rct_count >= JENT_RCT_CUTOFF) ? 1 : 0;
+}
+
+/* Report of health test failures */
 static int jent_health_failure(struct rand_data *ec)
 {
-	return ec->health_failure;
+	return jent_rct_failure(ec) | jent_apt_failure(ec);
+}
+
+static int jent_permanent_health_failure(struct rand_data *ec)
+{
+	return jent_rct_permanent_failure(ec) | jent_apt_permanent_failure(ec);
 }
 
 /***************************************************************************
@@ -600,8 +576,8 @@ static void jent_gen_entropy(struct rand_data *ec)
  *
  * The following error codes can occur:
  *	-1	entropy_collector is NULL
- *	-2	RCT failed
- *	-3	APT test failed
+ *	-2	Intermittent health failure
+ *	-3	Permanent health failure
  */
 int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 		      unsigned int len)
@@ -616,39 +592,23 @@ int jent_read_entropy(struct rand_data *ec, unsigned char *data,
 
 		jent_gen_entropy(ec);
 
-		if (jent_health_failure(ec)) {
-			int ret;
-
-			if (jent_rct_failure(ec))
-				ret = -2;
-			else
-				ret = -3;
-
+		if (jent_permanent_health_failure(ec)) {
 			/*
-			 * Re-initialize the noise source
-			 *
-			 * If the health test fails, the Jitter RNG remains
-			 * in failure state and will return a health failure
-			 * during next invocation.
+			 * At this point, the Jitter RNG instance is considered
+			 * as a failed instance. There is no rerun of the
+			 * startup test any more, because the caller
+			 * is assumed to not further use this instance.
 			 */
-			if (jent_entropy_init())
-				return ret;
-
-			/* Set APT to initial state */
-			jent_apt_reset(ec, 0);
-			ec->apt_base_set = 0;
-
-			/* Set RCT to initial state */
-			ec->rct_count = 0;
-
-			/* Re-enable Jitter RNG */
-			ec->health_failure = 0;
-
+			return -3;
+		} else if (jent_health_failure(ec)) {
 			/*
-			 * Return the health test failure status to the
-			 * caller as the generated value is not appropriate.
+			 * Perform startup health tests and return permanent
+			 * error if it fails.
 			 */
-			return ret;
+			if (jent_entropy_init())
+				return -3;
+
+			return -2;
 		}
 
 		if ((DATA_SIZE_BITS / 8) < len)
diff --git a/crypto/jitterentropy.h b/crypto/jitterentropy.h
index b7397b617ef05..5cc583f6bc6b8 100644
--- a/crypto/jitterentropy.h
+++ b/crypto/jitterentropy.h
@@ -2,7 +2,6 @@
 
 extern void *jent_zalloc(unsigned int len);
 extern void jent_zfree(void *ptr);
-extern void jent_panic(char *s);
 extern void jent_memcpy(void *dest, const void *src, unsigned int n);
 extern void jent_get_nstime(__u64 *out);
 
-- 
2.39.2

