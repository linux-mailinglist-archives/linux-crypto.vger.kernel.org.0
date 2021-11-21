Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B16D4584D7
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Nov 2021 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhKUQxW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Nov 2021 11:53:22 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:12435 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbhKUQxA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Nov 2021 11:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513305;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zjbd0tP5oE3K18k5XhXFfznov394RduCD+HvvvL6SVw=;
    b=Sr0tpIssRKEWHh6Q8HfZtMMOZr1D4Jozyc4J0BtpsXDJAc0JOTCxrkA3jmYGRqBhLw
    9SIIpFBCxg8b8yGXKAKqeoiYmhlHRqYaoQyb8yC2A0neTLtiCjJJRKLipez1JF87hS/n
    KRsWX/e4f9eTVnw5Mg2V4iA/7zvps3+sy9aeQcbHaQ8cHxjT+bcA4YbMe62zZEKdcTVS
    EhDGLYrIXNAMoO+7I/61hk07zLDnjOXEpsoFJVCWx6E3xGr+E1OYuYUPpipamYSOSXQP
    gt33xiEavRCa0p+3XUrbr/wxNy1X/HDyKfPWGeYFbJQEHxf5F4VqpLcxFVbpaiA2x9eh
    e5JA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGmO3Wa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:24 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Tso Ted <tytso@mit.edu>, linux-crypto@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: [PATCH v43 14/15] LRNG - add interface for gathering of raw entropy
Date:   Sun, 21 Nov 2021 17:47:26 +0100
Message-ID: <2631178.QOukoFCf94@positron.chronox.de>
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The test interface allows a privileged process to capture the raw
unconditioned noise that is collected by the LRNG for statistical
analysis. Such testing allows the analysis how much entropy
the interrupt noise source provides on a given platform.
Extracted noise data is not used to seed the LRNG. This
is a test interface and not appropriate for production systems.
Yet, the interface is considered to be sufficiently secured for
production systems.

Access to the data is given through the lrng_raw debugfs file. The
data buffer should be multiples of sizeof(u32) to fill the entire
buffer. Using the option lrng_testing.boot_test=1 the raw noise of
the first 1000 entropy events since boot can be sampled.

This test interface allows generating the data required for
analysis whether the LRNG is in compliance with SP800-90B
sections 3.1.3 and 3.1.4.

In addition, the test interface allows gathering of the concatenated raw
entropy data to verify that the concatenation works appropriately.
This includes sampling of the following raw data:

* high-resolution time stamp

* Jiffies

* IRQ number

* IRQ flags

* return instruction pointer

* interrupt register state

* array logic batching the high-resolution time stamp

* enabling the runtime configuration of entropy source entropy rates

Also, a testing interface to support ACVT of the hash implementation
is provided. The reason why only hash testing is supported (as
opposed to also provide testing for the DRNG) is the fact that the
LRNG software hash implementation contains glue code that may
warrant testing in addition to the testing of the software ciphers
via the kernel crypto API. Also, for testing the CTR-DRBG, the
underlying AES implementation would need to be tested. However,
such AES test interface cannot be provided by the LRNG as it has no
means to access the AES operation.

Finally, the execution duration for processing a time stamp can be
obtained with the LRNG raw entropy interface.

If a test interface is not compiled, its code is a noop which has no
impact on the performance.

CC: Torsten Duwe <duwe@lst.de>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
Reviewed-by: Alexander Lobakin <alobakin@pm.me>
Tested-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig        | 180 ++++++++
 drivers/char/lrng/Makefile       |   1 +
 drivers/char/lrng/lrng_testing.c | 689 +++++++++++++++++++++++++++++++
 3 files changed, 870 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index bc1b85929b94..72b572cb7df5 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -380,4 +380,184 @@ config LRNG_KCAPI
 	  provided by the selected kernel crypto API RNG.
 endif # LRNG_DRNG_SWITCH
 
+menuconfig LRNG_TESTING_MENU
+	bool "LRNG testing interfaces"
+	depends on DEBUG_FS
+	help
+	  Enable one or more of the following test interfaces.
+
+	  If unsure, say N.
+
+if LRNG_TESTING_MENU
+
+config LRNG_RAW_HIRES_ENTROPY
+	bool "Enable entropy test interface to hires timer noise source"
+	default y
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned high resolution time stamp noise that
+	  is collected by the LRNG for statistical analysis. Extracted
+	  noise data is not used to seed the LRNG.
+
+	  The raw noise data can be obtained using the lrng_raw_hires
+	  debugfs file. Using the option lrng_testing.boot_raw_hires_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_JIFFIES_ENTROPY
+	bool "Enable entropy test interface to Jiffies noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned Jiffies that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the LRNG if a high-resolution time stamp is not
+	  available. If a high-resolution time stamp is detected,
+	  the Jiffies value is not collected by the LRNG and no
+	  data is provided via the test interface. Extracted noise
+	  data is not used to seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_jiffies
+	  debugfs file. Using the option lrng_testing.boot_raw_jiffies_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_IRQ_ENTROPY
+	bool "Enable entropy test interface to IRQ number noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned interrupt number that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the random32 PRNG external to the LRNG if a
+	  high-resolution time stamp is available or it will be used to
+	  seed the LRNG otherwise. Extracted noise data is not used to
+	  seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_irq
+	  debugfs file. Using the option lrng_testing.boot_raw_irq_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_IRQFLAGS_ENTROPY
+	bool "Enable entropy test interface to IRQ flags noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned interrupt flags that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the random32 PRNG external to the LRNG if a
+	  high-resolution time stamp is available or it will be used to
+	  seed the LRNG otherwise. Extracted noise data is not used to
+	  seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_irqflags
+	  debugfs file. Using the option lrng_testing.boot_raw_irqflags_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_RETIP_ENTROPY
+	bool "Enable entropy test interface to RETIP value noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned return instruction pointer value
+	  that is collected by the LRNG for statistical analysis.
+	  This data is used for seeding the random32 PRNG external
+	  to the LRNG if a high-resolution time stamp is available or
+	  it will be used to seed the LRNG otherwise. Extracted noise
+	  data is not used to seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_retip
+	  debugfs file. Using the option lrng_testing.boot_raw_retip_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_REGS_ENTROPY
+	bool "Enable entropy test interface to IRQ register value noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned interrupt register value that is
+	  collected by the LRNG for statistical analysis. Extracted noise
+	  data is not used to seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_regs
+	  debugfs file. Using the option lrng_testing.boot_raw_regs_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_ARRAY
+	bool "Enable test interface to LRNG raw entropy storage array"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw noise data that is collected by the LRNG
+	  in the per-CPU array for statistical analysis. The purpose
+	  of this interface is to verify that the array handling code
+	  truly only concatenates data and provides the same entropy
+	  rate as the raw unconditioned noise source when assessing
+	  the collected data byte-wise.
+
+	  The data can be obtained using the lrng_raw_array debugfs
+	  file. Using the option lrng_testing.boot_raw_array=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_IRQ_PERF
+	bool "Enable LRNG interrupt performance monitor"
+	help
+	  With this option, the performance monitor of the LRNG
+	  interrupt handling code is enabled. The file provides
+	  the execution time of the interrupt handler in
+	  cycles.
+
+	  The interrupt performance data can be obtained using
+	  the lrng_irq_perf debugfs file. Using the option
+	  lrng_testing.boot_irq_perf=1 the performance data of
+	  the first 1000 entropy events since boot can be sampled.
+
+config LRNG_ACVT_HASH
+	bool "Enable LRNG ACVT Hash interface"
+	help
+	  With this option, the LRNG built-in hash function used for
+	  auxiliary pool management and prior to switching the
+	  cryptographic backends is made available for ACVT. The
+	  interface allows writing of the data to be hashed
+	  into the interface. The read operation triggers the hash
+	  operation to generate message digest.
+
+	  The ACVT interface is available with the lrng_acvt_hash
+	  debugfs file.
+
+config LRNG_RUNTIME_ES_CONFIG
+	bool "Enable runtime configuration of entropy sources"
+	help
+	  When enabling this option, the LRNG provides the mechanism
+	  allowing to alter the entropy rate of each entropy source
+	  during boot time and runtime.
+
+	  The following interfaces are available:
+	  lrng_archrandom.archrandom for the CPU entropy source,
+	  lrng_jent.jitterrng for the Jitter RNG entropy source, and
+	  lrng_sw_noise.irq_entropy for the interrupt entropy source.
+
+config LRNG_RUNTIME_MAX_WO_RESEED_CONFIG
+	bool "Enable runtime configuration of max reseed threshold"
+	help
+	  When enabling this option, the LRNG provides an interface
+	  allowing the setting of the maximum number of DRNG generate
+	  operations without a reseed that has full entropy. The
+	  interface is lrng_drng.max_wo_reseed.
+
+config LRNG_TEST_CPU_ES_COMPRESSION
+	bool "Force CPU ES compression operation"
+	help
+	  When enabling this option, the CPU ES compression operation
+	  is forced by setting an arbitrary value > 1 for the data
+	  multiplier even when the CPU ES would deliver full entropy.
+	  This allows testing of the compression operation. It
+	  therefore forces to pull more data from the CPU ES
+	  than what may be required.
+
+config LRNG_TESTING
+	bool
+	default y if (LRNG_RAW_HIRES_ENTROPY || LRNG_RAW_JIFFIES_ENTROPY ||LRNG_RAW_IRQ_ENTROPY || LRNG_RAW_IRQFLAGS_ENTROPY || LRNG_RAW_RETIP_ENTROPY || LRNG_RAW_REGS_ENTROPY || LRNG_RAW_ARRAY || LRNG_IRQ_PERF || LRNG_ACVT_HASH)
+
+endif #LRNG_TESTING_MENU
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index f868f9fe53a6..6d5035aa611e 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_LRNG_DRBG)		+= lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+= lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+= lrng_es_jent.o
 obj-$(CONFIG_LRNG_HEALTH_TESTS)	+= lrng_health.o
+obj-$(CONFIG_LRNG_TESTING)	+= lrng_testing.o
diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_testing.c
new file mode 100644
index 000000000000..99cc35abf45c
--- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) testing interfaces
+ *
+ * Copyright (C) 2019 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/debugfs.h>
+#include <linux/lrng.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+#include <asm/errno.h>
+
+#include "lrng_internal.h"
+
+#define LRNG_TESTING_RINGBUFFER_SIZE	1024
+#define LRNG_TESTING_RINGBUFFER_MASK	(LRNG_TESTING_RINGBUFFER_SIZE - 1)
+
+struct lrng_testing {
+	u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
+	u32 rb_reader;
+	u32 rb_writer;
+	atomic_t lrng_testing_enabled;
+	spinlock_t lock;
+	wait_queue_head_t read_wait;
+};
+
+/*************************** Generic Data Handling ****************************/
+
+/*
+ * boot variable:
+ * 0 ==> No boot test, gathering of runtime data allowed
+ * 1 ==> Boot test enabled and ready for collecting data, gathering runtime
+ *	 data is disabled
+ * 2 ==> Boot test completed and disabled, gathering of runtime data is
+ *	 disabled
+ */
+
+static inline void lrng_testing_reset(struct lrng_testing *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	data->rb_reader = 0;
+	data->rb_writer = 0;
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static inline void lrng_testing_init(struct lrng_testing *data, u32 boot)
+{
+	/*
+	 * The boot time testing implies we have a running test. If the
+	 * caller wants to clear it, he has to unset the boot_test flag
+	 * at runtime via sysfs to enable regular runtime testing
+	 */
+	if (boot)
+		return;
+
+	lrng_testing_reset(data);
+	atomic_set(&data->lrng_testing_enabled, 1);
+	pr_warn("Enabling data collection\n");
+}
+
+static inline void lrng_testing_fini(struct lrng_testing *data, u32 boot)
+{
+	/* If we have boot data, we do not reset yet to allow data to be read */
+	if (boot)
+		return;
+
+	atomic_set(&data->lrng_testing_enabled, 0);
+	lrng_testing_reset(data);
+	pr_warn("Disabling data collection\n");
+}
+
+static inline bool lrng_testing_store(struct lrng_testing *data, u32 value,
+				      u32 *boot)
+{
+	unsigned long flags;
+
+	if (!atomic_read(&data->lrng_testing_enabled) && (*boot != 1))
+		return false;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	/*
+	 * Disable entropy testing for boot time testing after ring buffer
+	 * is filled.
+	 */
+	if (*boot) {
+		if (data->rb_writer > LRNG_TESTING_RINGBUFFER_SIZE) {
+			*boot = 2;
+			pr_warn_once("One time data collection test disabled\n");
+			spin_unlock_irqrestore(&data->lock, flags);
+			return false;
+		}
+
+		if (data->rb_writer == 1)
+			pr_warn("One time data collection test enabled\n");
+	}
+
+	data->lrng_testing_rb[data->rb_writer & LRNG_TESTING_RINGBUFFER_MASK] =
+									value;
+	data->rb_writer++;
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	if (wq_has_sleeper(&data->read_wait))
+		wake_up_interruptible(&data->read_wait);
+
+	return true;
+}
+
+static inline bool lrng_testing_have_data(struct lrng_testing *data)
+{
+	return ((data->rb_writer & LRNG_TESTING_RINGBUFFER_MASK) !=
+		 (data->rb_reader & LRNG_TESTING_RINGBUFFER_MASK));
+}
+
+static inline int lrng_testing_reader(struct lrng_testing *data, u32 *boot,
+				      u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags;
+	int collected_data = 0;
+
+	lrng_testing_init(data, *boot);
+
+	while (outbuflen) {
+		spin_lock_irqsave(&data->lock, flags);
+
+		/* We have no data or reached the writer. */
+		if (!data->rb_writer ||
+		    (data->rb_writer == data->rb_reader)) {
+
+			spin_unlock_irqrestore(&data->lock, flags);
+
+			/*
+			 * Now we gathered all boot data, enable regular data
+			 * collection.
+			 */
+			if (*boot) {
+				*boot = 0;
+				goto out;
+			}
+
+			wait_event_interruptible(data->read_wait,
+						 lrng_testing_have_data(data));
+			if (signal_pending(current)) {
+				collected_data = -ERESTARTSYS;
+				goto out;
+			}
+
+			continue;
+		}
+
+		/* We copy out word-wise */
+		if (outbuflen < sizeof(u32)) {
+			spin_unlock_irqrestore(&data->lock, flags);
+			goto out;
+		}
+
+		memcpy(outbuf, &data->lrng_testing_rb[data->rb_reader],
+		       sizeof(u32));
+		data->rb_reader++;
+
+		spin_unlock_irqrestore(&data->lock, flags);
+
+		outbuf += sizeof(u32);
+		outbuflen -= sizeof(u32);
+		collected_data += sizeof(u32);
+	}
+
+out:
+	lrng_testing_fini(data, *boot);
+	return collected_data;
+}
+
+static int lrng_testing_extract_user(struct file *file, char __user *buf,
+				     size_t nbytes, loff_t *ppos,
+				     int (*reader)(u8 *outbuf, u32 outbuflen))
+{
+	u8 *tmp, *tmp_aligned;
+	int ret = 0, large_request = (nbytes > 256);
+
+	if (!nbytes)
+		return 0;
+
+	/*
+	 * The intention of this interface is for collecting at least
+	 * 1000 samples due to the SP800-90B requirements. So, we make no
+	 * effort in avoiding allocating more memory that actually needed
+	 * by the user. Hence, we allocate sufficient memory to always hold
+	 * that amount of data.
+	 */
+	tmp = kmalloc(LRNG_TESTING_RINGBUFFER_SIZE + sizeof(u32), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp_aligned = PTR_ALIGN(tmp, sizeof(u32));
+
+	while (nbytes) {
+		int i;
+
+		if (large_request && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		i = min_t(int, nbytes, LRNG_TESTING_RINGBUFFER_SIZE);
+		i = reader(tmp_aligned, i);
+		if (i <= 0) {
+			if (i < 0)
+				ret = i;
+			break;
+		}
+		if (copy_to_user(buf, tmp_aligned, i)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		nbytes -= i;
+		buf += i;
+		ret += i;
+	}
+
+	kfree_sensitive(tmp);
+
+	if (ret > 0)
+		*ppos += ret;
+
+	return ret;
+}
+
+/************** Raw High-Resolution Timer Entropy Data Handling ***************/
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+
+static u32 boot_raw_hires_test = 0;
+module_param(boot_raw_hires_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_hires_test, "Enable gathering boot time high resolution timer entropy of the first entropy events");
+
+static struct lrng_testing lrng_raw_hires = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_hires.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_hires.read_wait)
+};
+
+bool lrng_raw_hires_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_hires, value, &boot_raw_hires_test);
+}
+
+static int lrng_raw_hires_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_hires, &boot_raw_hires_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_hires_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_hires_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_hires_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_hires_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+
+/********************* Raw Jiffies Entropy Data Handling **********************/
+
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+
+static u32 boot_raw_jiffies_test = 0;
+module_param(boot_raw_jiffies_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_jiffies_test, "Enable gathering boot time high resolution timer entropy of the first entropy events");
+
+static struct lrng_testing lrng_raw_jiffies = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_jiffies.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_jiffies.read_wait)
+};
+
+bool lrng_raw_jiffies_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_jiffies, value,
+				  &boot_raw_jiffies_test);
+}
+
+static int lrng_raw_jiffies_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_jiffies, &boot_raw_jiffies_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_jiffies_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_jiffies_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_jiffies_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_jiffies_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+
+/************************** Raw IRQ Data Handling ****************************/
+
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+
+static u32 boot_raw_irq_test = 0;
+module_param(boot_raw_irq_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_irq_test, "Enable gathering boot time entropy of the first IRQ entropy events");
+
+static struct lrng_testing lrng_raw_irq = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_irq.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_irq.read_wait)
+};
+
+bool lrng_raw_irq_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_irq, value, &boot_raw_irq_test);
+}
+
+static int lrng_raw_irq_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_irq, &boot_raw_irq_test, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_raw_irq_read(struct file *file, char __user *to,
+				 size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_irq_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_irq_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_irq_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+
+/************************ Raw IRQFLAGS Data Handling **************************/
+
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+
+static u32 boot_raw_irqflags_test = 0;
+module_param(boot_raw_irqflags_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_irqflags_test, "Enable gathering boot time entropy of the first IRQ flags entropy events");
+
+static struct lrng_testing lrng_raw_irqflags = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_irqflags.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_irqflags.read_wait)
+};
+
+bool lrng_raw_irqflags_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_irqflags, value,
+				  &boot_raw_irqflags_test);
+}
+
+static int lrng_raw_irqflags_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_irqflags, &boot_raw_irqflags_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_irqflags_read(struct file *file, char __user *to,
+				      size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_irqflags_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_irqflags_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_irqflags_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+
+/************************ Raw _RET_IP_ Data Handling **************************/
+
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+
+static u32 boot_raw_retip_test = 0;
+module_param(boot_raw_retip_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_retip_test, "Enable gathering boot time entropy of the first return instruction pointer entropy events");
+
+static struct lrng_testing lrng_raw_retip = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_retip.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_retip.read_wait)
+};
+
+bool lrng_raw_retip_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_retip, value, &boot_raw_retip_test);
+}
+
+static int lrng_raw_retip_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_retip, &boot_raw_retip_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_retip_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_retip_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_retip_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_retip_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_RETIP_ENTROPY */
+
+/********************** Raw IRQ register Data Handling ************************/
+
+#ifdef CONFIG_LRNG_RAW_REGS_ENTROPY
+
+static u32 boot_raw_regs_test = 0;
+module_param(boot_raw_regs_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_regs_test, "Enable gathering boot time entropy of the first interrupt register entropy events");
+
+static struct lrng_testing lrng_raw_regs = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_regs.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_regs.read_wait)
+};
+
+bool lrng_raw_regs_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_regs, value, &boot_raw_regs_test);
+}
+
+static int lrng_raw_regs_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_regs, &boot_raw_regs_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_regs_read(struct file *file, char __user *to,
+				  size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_regs_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_regs_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_regs_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_REGS_ENTROPY */
+
+/********************** Raw Entropy Array Data Handling ***********************/
+
+#ifdef CONFIG_LRNG_RAW_ARRAY
+
+static u32 boot_raw_array = 0;
+module_param(boot_raw_array, uint, 0644);
+MODULE_PARM_DESC(boot_raw_array, "Enable gathering boot time raw noise array data of the first entropy events");
+
+static struct lrng_testing lrng_raw_array = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_raw_array.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_array.read_wait)
+};
+
+bool lrng_raw_array_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_array, value, &boot_raw_array);
+}
+
+static int lrng_raw_array_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_array, &boot_raw_array, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_raw_array_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_array_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_array_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_array_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_ARRAY */
+
+/******************** Interrupt Performance Data Handling *********************/
+
+#ifdef CONFIG_LRNG_IRQ_PERF
+
+static u32 boot_irq_perf = 0;
+module_param(boot_irq_perf, uint, 0644);
+MODULE_PARM_DESC(boot_irq_perf, "Enable gathering boot time interrupt performance data of the first entropy events");
+
+static struct lrng_testing lrng_irq_perf = {
+	.rb_reader = 0,
+	.rb_writer = 0,
+	.lock      = __SPIN_LOCK_UNLOCKED(lrng_irq_perf.lock),
+	.read_wait = __WAIT_QUEUE_HEAD_INITIALIZER(lrng_irq_perf.read_wait)
+};
+
+bool lrng_perf_time(u32 start)
+{
+	return lrng_testing_store(&lrng_irq_perf, random_get_entropy() - start,
+				  &boot_irq_perf);
+}
+
+static int lrng_irq_perf_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_irq_perf, &boot_irq_perf, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_irq_perf_read(struct file *file, char __user *to,
+				  size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_irq_perf_reader);
+}
+
+static const struct file_operations lrng_irq_perf_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_irq_perf_read,
+};
+
+#endif /* CONFIG_LRNG_IRQ_PERF */
+
+/*********************************** ACVT ************************************/
+
+#ifdef CONFIG_LRNG_ACVT_HASH
+
+/* maximum amount of data to be hashed as defined by ACVP */
+#define LRNG_ACVT_MAX_SHA_MSG	(65536 >> 3)
+
+/*
+ * As we use static variables to store the data, it is clear that the
+ * test interface is only able to handle single threaded testing. This is
+ * considered to be sufficient for testing. If multi-threaded use of the
+ * ACVT test interface would be performed, the caller would get garbage
+ * but the kernel operation is unaffected by this.
+ */
+static u8 lrng_acvt_hash_data[LRNG_ACVT_MAX_SHA_MSG]
+						__aligned(LRNG_KCAPI_ALIGN);
+static atomic_t lrng_acvt_hash_data_size = ATOMIC_INIT(0);
+static u8 lrng_acvt_hash_digest[LRNG_ATOMIC_DIGEST_SIZE];
+
+static ssize_t lrng_acvt_hash_write(struct file *file, const char __user *buf,
+				    size_t nbytes, loff_t *ppos)
+{
+	if (nbytes > LRNG_ACVT_MAX_SHA_MSG)
+		return -EINVAL;
+
+	atomic_set(&lrng_acvt_hash_data_size, (int)nbytes);
+
+	return simple_write_to_buffer(lrng_acvt_hash_data,
+				      LRNG_ACVT_MAX_SHA_MSG, ppos, buf, nbytes);
+}
+
+static ssize_t lrng_acvt_hash_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	SHASH_DESC_ON_STACK(shash, NULL);
+	const struct lrng_crypto_cb *crypto_cb = &lrng_cc20_crypto_cb;
+	ssize_t ret;
+
+	if (count > LRNG_ATOMIC_DIGEST_SIZE)
+		return -EINVAL;
+
+	ret = crypto_cb->lrng_hash_init(shash, NULL) ?:
+	      crypto_cb->lrng_hash_update(shash, lrng_acvt_hash_data,
+				atomic_read_u32(&lrng_acvt_hash_data_size)) ?:
+	      crypto_cb->lrng_hash_final(shash, lrng_acvt_hash_digest);
+	if (ret)
+		return ret;
+
+	return simple_read_from_buffer(to, count, ppos, lrng_acvt_hash_digest,
+				       sizeof(lrng_acvt_hash_digest));
+}
+
+static const struct file_operations lrng_acvt_hash_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.llseek = default_llseek,
+	.read = lrng_acvt_hash_read,
+	.write = lrng_acvt_hash_write,
+};
+
+#endif /* CONFIG_LRNG_ACVT_DRNG */
+
+/**************************************************************************
+ * Debugfs interface
+ **************************************************************************/
+
+static int __init lrng_raw_init(void)
+{
+	struct dentry *lrng_raw_debugfs_root;
+
+	lrng_raw_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_hires", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_hires_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_jiffies", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_jiffies_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_irq", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_raw_irq_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_irqflags", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_irqflags_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_retip", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_retip_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_REGS_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_regs", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_regs_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_ARRAY
+	debugfs_create_file_unsafe("lrng_raw_array", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_array_fops);
+#endif
+#ifdef CONFIG_LRNG_IRQ_PERF
+	debugfs_create_file_unsafe("lrng_irq_perf", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_irq_perf_fops);
+#endif
+#ifdef CONFIG_LRNG_ACVT_HASH
+	debugfs_create_file_unsafe("lrng_acvt_hash", 0600,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_acvt_hash_fops);
+#endif
+
+	return 0;
+}
+
+module_init(lrng_raw_init);
-- 
2.31.1




