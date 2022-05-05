Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721BC51B4AD
	for <lists+linux-crypto@lfdr.de>; Thu,  5 May 2022 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiEEAdT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 May 2022 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiEEAdR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 May 2022 20:33:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165554BEC;
        Wed,  4 May 2022 17:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6580FB81AF2;
        Thu,  5 May 2022 00:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C34C385A5;
        Thu,  5 May 2022 00:29:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="So6Pj6BX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651710574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1NOr1spTsQSWBCHL0IgAOS1hqjEpNdIRU4N7uXqbX8=;
        b=So6Pj6BXqwXr5a6pTrsjQJwy6urZ5h0f0vSCODCkFzLX6aXI9p6ZHUW8b6wqHUfazL+xL0
        wTlzmS/Wu30Wj9B5+cvPUYyNx6rXSd5xMN0mxzA+zrXHKeRJzmj9O92iiQ5gF0nYVSd2RW
        R6ZsTTMrzvTX65jxGKG5CRrK9LTI7JE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69a44044 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 00:29:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     nathan@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v7] timekeeping: Add raw clock fallback for random_get_entropy()
Date:   Thu,  5 May 2022 02:29:10 +0200
Message-Id: <20220505001924.176087-1-Jason@zx2c4.com>
In-Reply-To: <87y1zkmg0l.ffs@tglx>
References: <87y1zkmg0l.ffs@tglx>
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

The addition of random_get_entropy_fallback() provides access to
whichever time source has the highest frequency, which is useful for
gathering entropy on platforms without available cycle counters. It's
not necessarily as good as being able to quickly access a cycle counter
that the CPU has, but it's still something, even when it falls back to
being jiffies-based.

In the event that a given arch does not define get_cycles(), falling
back to the get_cycles() default implementation that returns 0 is really
not the best we can do. Instead, at least calling
random_get_entropy_fallback() would be preferable, because that always
needs to return _something_, even falling back to jiffies eventually.
It's not as though random_get_entropy_fallback() is super high precision
or guaranteed to be entropic, but basically anything that's not zero all
the time is better than returning zero all the time.

Finally, since random_get_entropy_fallback() is used during extremely
early boot when randomizing freelists in mm_init(), it can be called
before timekeeping has been initialized. In that case there really is
nothing we can do; jiffies hasn't even started ticking yet. So just give
up and return 0.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>
---
Changes v6->v7:
- Return 0 if we're called before timekeeping has been initialized,
  reported by Nathan.

 include/linux/timex.h     |  8 ++++++++
 kernel/time/timekeeping.c | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 5745c90c8800..3871b06bd302 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -62,6 +62,8 @@
 #include <linux/types.h>
 #include <linux/param.h>
 
+unsigned long random_get_entropy_fallback(void);
+
 #include <asm/timex.h>
 
 #ifndef random_get_entropy
@@ -74,8 +76,14 @@
  *
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
+ * If a given arch does not have get_cycles(), then we fallback to
+ * using random_get_entropy_fallback().
  */
+#ifdef get_cycles
 #define random_get_entropy()	((unsigned long)get_cycles())
+#else
+#define random_get_entropy()	random_get_entropy_fallback()
+#endif
 #endif
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..1d1302ca8d36 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/tick.h>
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
@@ -2380,6 +2381,17 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 	return 0;
 }
 
+/**
+ * random_get_entropy_fallback - Returns the raw clock source value,
+ * used by random.c for platforms with no valid random_get_entropy().
+ */
+unsigned long random_get_entropy_fallback(void)
+{
+	if (unlikely(!tk_core.timekeeper.tkr_mono.clock))
+		return 0;
+	return tk_clock_read(&tk_core.timekeeper.tkr_mono);
+}
+EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
-- 
2.35.1

