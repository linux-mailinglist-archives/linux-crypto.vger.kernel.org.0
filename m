Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A14584E3
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Nov 2021 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhKUQxq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Nov 2021 11:53:46 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.176]:18556 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhKUQxU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Nov 2021 11:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513324;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=68x09uK12ZaSAehT9JWikQO/E4GBS1AIEycnTx1BIvE=;
    b=h1Kr1lyDdQ5Z4ci+z0BxDg0ugiPAPQ6XkE7pbqwjC4HgQvb5BRwlTgE7ZVsGcvyJIS
    EBOduiyRFNqFFyFM7Nl3Io+WNNzfuDcBcT+Ji6JiuOpZ9OTpEfEJe6BargihKMHeU4Q/
    aUioppSJa26WEEBwD0uR7lZ45LBDu8GhdtkwOcUmqKgEPb/JcKaWr2AS3l5lwqgPRuxC
    Kf5IEww9HF2Y9ckK10s7pnZiGFio6Y74vGh6sI2VngGFOdqlrnSbQwa4y0a68VbtB+Ms
    +CFxHUb22+sdsgZIlsDvx/QO/6JHR8BO0+zzEeOWp93R3Q0LOcbnLjFyHuaVnXwZRSqe
    ZFpQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGmh3Wo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:43 +0100 (CET)
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
Subject: [PATCH v43 01/15] Linux Random Number Generator
Date:   Sun, 21 Nov 2021 17:40:01 +0100
Message-ID: <4641592.OV4Wx5bFTl@positron.chronox.de>
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In an effort to provide a flexible implementation for a random number
generator that also delivers entropy during early boot time, allows
replacement of the deterministic random number generation mechanism,
implement the various components in separate code for easier
maintenance, and provide compliance to SP800-90[A|B|C], introduce
the Linux Random Number Generator (LRNG) framework.

The LRNG framework provides a flexible random number generator which
allows developers and system integrators to achieve different goals
by ensuring that each solution establishes a secure state.

The general design is as follows. Additional implementation details
are given in [1]. The LRNG consists of the following components:

1. The LRNG implements a DRNG. The DRNG always generates the
requested amount of output. When using the SP800-90A terminology
it operates without prediction resistance. The DRNG maintains a counter
of how many bytes were generated since last re-seed and a timer of the
elapsed time since last re-seed. If either the counter or the timer reaches
a threshold, the DRNG is seeded from the entropy pool.

In case the Linux kernel detects a NUMA system, one DRNG instance per NUMA
node is maintained.

2. The DRNG is seeded by concatenating the data from the following sources
   which deliver data and are credited with entropy if enabled:

(a) the output of the IRQ per-CPU entropy pools,

(b) the auxiliary entropy pool,

(c) the Jitter RNG if available and enabled, and

(d) the CPU-based noise source such as Intel RDSEED.

The entropy estimate of the data of all noise sources are added to
form the entropy estimate of the data used to seed the DRNG with.
The LRNG ensures, however, that the DRNG after seeding is at
maximum the security strength of the DRNG.

The LRNG is designed such that none of these noise sources can dominate
the other noise sources to provide seed data to the DRNG during due to
the following:

(a) During boot time, the amount of received entropy at the different
entropy sources are the trigger points to (re)seed the DRNG.

(b) At runtime, the available entropy from the slow noise source is
concatenated with a pre-defined amount of data from the fast noise
sources. In addition, each DRNG reseed operation triggers external
noise source providers to deliver one block of data.

3. The IRQ entropy pool collects noise data from interrupt timing.
Any data received by the LRNG from the interrupt noise sources is
inserted into a per-CPU entropy pool using a hash operation that can
be changed during runtime. Per default, SHA-256 is used.

 (a) When an interrupt occurs, the 8 least significant bits of the
 high-resolution time stamp divided by the greatest common divisor (GCD)
 is mixed into the per-CPU entropy pool. This time stamp is credited with
 heuristically implied entropy.

 (b) HID event data like the key stroke or the mouse coordinates are
 mixed into the per-CPU entropy pool. This data is not credited with
 entropy by the LRNG.

5. Any data provided from user space by either writing to /dev/random,
/dev/urandom or the IOCTL of RNDADDENTROPY on both device files
are always injected into the auxiliary pool. Also, device drivers may
provide data that is mixed into an auxiliary pool using the same hash
that is used to process the per-CPU entropy pool. This data is not
credited with entropy by the LRNG.

In addition, when a hardware random number generator covered by the
Linux kernel HW generator framework wants to deliver random numbers,
it is injected into the auxiliary pool as well. HW generator noise source
is handled separately from the other noise source due to the fact that
the HW generator framework may decide by itself when to deliver data
whereas the other noise sources always requested for data driven by the
LRNG operation. Similarly any user space provided data is inserted into
the entropy pool.

When seed data for the DRNG is to be generated, all per-CPU
entropy pools are hashed. The message digest forms the data used for
seeding the DRNG.

To speed up the interrupt handling code of the LRNG, the time stamp
collected for an interrupt event is divided by the greatest common
divisor to eliminate fixed low bits and then truncated to the 8 least
significant bits. 1024 truncated time stamps are concatenated and then
jointly inserted into the per-CPU entropy pool. During boot time,
until the fully seeded stage is reached, each time stamp with its
32 least significant bits is are concatenated. When 1024/32 = 32 such
events are received, they are injected into the per-CPU entropy pool.

The LRNG allows the DRNG mechanism to be changed at runtime. Per default,
a ChaCha20-based DRNG is used. The ChaCha20-DRNG implemented for the
LRNG is also provided as a stand-alone user space deterministic random
number generator. The LRNG also offers an SP800-90A DRBG based on the
Linux kernel crypto API DRBG implementation.

The processing of entropic data from the noise source before injecting
them into the DRNG is performed with the following mathematical
operations:

1. Truncation: The received time stamps divided by the GCD are
truncated to 8 least significant bits (or 32 least significant bits
during boot time)

2. Concatenation: The received and truncated time stamps as well as
auxiliary 32 bit words are concatenated to fill the per-CPU data
array that is capable of holding 64 8-bit words.

3. Hashing: A set of concatenated time stamp data received from the
interrupts are hashed together with the current existing per-CPU
entropy pool state. The resulting message digest is the new per-CPU
entropy pool state.

4. Hashing: When new data is added to the auxiliary pool, the data
is hashed together with the auxiliary pool to form a new auxiliary
pool state.

5. Hashing: A message digest of all per-CPU entropy pools and the
is calculated which forms the new auxiliary pool state.

6. Truncation: The most-significant bits (MSB) defined by the
requested number of bits (commonly equal to the security strength
of the DRBG) or the entropy available transported with the buffer
(which is the minimum of the message digest size and the available
entropy in all entropy pools and the auxiliary pool), whatever is
smaller, are obtained from the slow noise source output buffer.

7. Concatenation: The temporary seed buffer used to seed the DRNG
is a concatenation of the slow noise source buffer, the Jitter RNG
output, the CPU noise source output, and the current time.

The DRNG always tries to seed itself with 256 bits of entropy, except
during boot. In any case, if the noise sources cannot deliver that
amount, the available entropy is used and the DRNG keeps track on how
much entropy it was seeded with. The entropy implied by the LRNG
available in the entropy pool may be too conservative. To ensure
that during boot time all available entropy from the entropy pool is
transferred to the DRNG, the hash_df function always generates 256
data bits during boot to seed the DRNG. During boot, the DRNG is
seeded as follows:

1. The DRNG is reseeded from the entropy sources if the entropy sources
collectively have at least 32 bits of entropy. The goal of this step is
to ensure that the DRNG receives some initial entropy as early as
possible.

2. The DRNG is reseeded from the entropy sources if all entropy sources
collectively can provide at least 128 bits of entropy.

3. The DRNG is reseeded from the entropy sources if all entropy sources
collectively can provide at least 256 bits.

At the time of the reseeding steps, the DRNG requests as much entropy as
is available in order to skip certain steps and reach the seeding level
of 256 bits. This may imply that one or more of the aforementioned steps
are skipped.

Before the DRNG is seeded with 256 bits of entropy in step 3,
requests of random data from /dev/random and the getrandom system
call are not processed.

The reseeding of the DRNG always ensures that all entropy sources
collectively can deliver at least 128 entropy bits during runtime once
the DRNG is fully seeded.

The DRNG operates as deterministic random number generator with the
following properties:

* The maximum number of random bytes that can be generated with one
DRNG generate operation is limited to 4096 bytes. When longer random
numbers are requested, multiple DRNG generate operations are performed.
The ChaCha20 DRNG as well as the SP800-90A DRBGs implement an update of
their state after completing a generate request for backtracking
resistance.

* The DRNG is reseeded with whatever entropy is available -
in the worst case where no additional entropy can be provided by the
entropy sources, the DRNG is not re-seeded and continues its operation
to try to reseed again after again the expiry of one of these thresholds:

 - If the last reseeding of the DRNG is more than 600 seconds
   ago, or

 - 2^20 DRNG generate operations are performed, whatever comes first, or

 - the DRNG is forced to reseed before the next generation of
   random numbers if data has been injected into the LRNG by writing data
   into /dev/random or /dev/urandom.

 - If the DRNG was not successfully reseeded after 2^30 generate requests,
   the DRNG reverts back to an unseeded stage implying that the blocking
   interfaces of /dev/random and getrandom will block again.

The chosen values prevent high-volume requests from user space to cause
frequent reseeding operations which drag down the performance of the
DRNG.

With the automatic reseeding after 600 seconds, the LRNG is triggered
to reseed itself before the first request after a suspend that put the
hardware to sleep for longer than 600 seconds.

To support smaller devices including IoT environments, this patch
allows reducing the runtime memory footprint of the LRNG at compile
time by selecting smaller collection data sizes.

When selecting the compilation of a kernel for a small environment,
prevent the allocation of a buffer up to 4096 bytes to serve user space
requests. In this case, the stack variable of 64 bytes is used to serve
all user space requests.

The LRNG has the following properties:

* internal noise source: interrupts timing with fast boot time seeding

* high performance of interrupt handling code: The LRNG impact on the
interrupt handling has been reduced to a minimum. On one example
system, the LRNG interrupt handling code in its fastest configuration
executes within an average 55 cycles whereas the existing
/dev/random on the same device takes about 97 cycles when measuring
the execution time of add_interrupt_randomness().

* use of almost never contended lock for hashing operation to collect
  raw entropy supporting concurrency-free use of massive parallel
  systems - worst case rate of contention is the number of DRNG
  reseeds, usually: number of NUMA nodes contentions per 5 minutes.

* use of standalone ChaCha20 based RNG with the option to use a
  different DRNG selectable at compile time

* instantiate one DRNG per NUMA node

* support for runtime switchable output DRNGs

* use of runtime-switchable hash for conditioning implementation
following widely accepted approach

* compile-time selectable collection size

* support of small systems by allowing the reduction of the
runtime memory needs

Further details including the rationale for the design choices and
properties of the LRNG together with testing is provided at [1].
In addition, the documentation explains the conducted regression
tests to verify that the LRNG is API and ABI compatible with the
existing /dev/random implementation.

Note, this patch covers the entropy sources manager, the API
implementation, the built-in ChaCha20 DRNG and the auxiliary entropy
pool.

[1] https://www.chronox.de/lrng.html

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
Mathematical aspects Reviewed-by: "Peter, Matthias" <matthias.peter@bsi.bund.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 MAINTAINERS                         |   7 +
 drivers/char/Kconfig                |   2 +
 drivers/char/Makefile               |   9 +-
 drivers/char/lrng/Kconfig           |  58 +++
 drivers/char/lrng/Makefile          |   8 +
 drivers/char/lrng/lrng_aux.c        | 136 ++++++
 drivers/char/lrng/lrng_chacha20.c   | 321 ++++++++++++++
 drivers/char/lrng/lrng_chacha20.h   |  25 ++
 drivers/char/lrng/lrng_drng.c       | 451 +++++++++++++++++++
 drivers/char/lrng/lrng_es_aux.c     | 294 +++++++++++++
 drivers/char/lrng/lrng_es_mgr.c     | 373 ++++++++++++++++
 drivers/char/lrng/lrng_interfaces.c | 656 ++++++++++++++++++++++++++++
 drivers/char/lrng/lrng_internal.h   | 485 ++++++++++++++++++++
 include/linux/lrng.h                |  81 ++++
 14 files changed, 2905 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.h
 create mode 100644 drivers/char/lrng/lrng_drng.c
 create mode 100644 drivers/char/lrng/lrng_es_aux.c
 create mode 100644 drivers/char/lrng/lrng_es_mgr.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 include/linux/lrng.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c79388b78818..ea4f88da1601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10817,6 +10817,13 @@ F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 
+LINUX RANDOM NUMBER GENERATOR (LRNG) DRIVER
+M:	Stephan Mueller <smueller@chronox.de>
+S:	Maintained
+W:	https://www.chronox.de/lrng.html
+F:	drivers/char/lrng/*
+F:	include/linux/lrng.h
+
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 740811893c57..a52d575ca756 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -451,4 +451,6 @@ config RANDOM_TRUST_BOOTLOADER
 	pool. Otherwise, say N here so it will be regarded as device input that
 	only mixes the entropy pool.
 
+source "drivers/char/lrng/Kconfig"
+
 endmenu
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 264eb398fdd4..7371f7464a49 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -3,7 +3,14 @@
 # Makefile for the kernel character device drivers.
 #
 
-obj-y				+= mem.o random.o
+obj-y				+= mem.o
+
+ifeq ($(CONFIG_LRNG),y)
+  obj-y				+= lrng/
+else
+  obj-y				+= random.o
+endif
+
 obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
new file mode 100644
index 000000000000..655d873480b0
--- /dev/null
+++ b/drivers/char/lrng/Kconfig
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Linux Random Number Generator configuration
+#
+
+menuconfig LRNG
+	bool "Linux Random Number Generator"
+	select CRYPTO_LIB_SHA256 if CRYPTO
+	help
+	  The Linux Random Number Generator (LRNG) is the replacement
+	  of the existing /dev/random provided with drivers/char/random.c.
+	  It generates entropy from different noise sources and
+	  delivers significant entropy during boot.
+
+if LRNG
+
+menu "Specific DRNG seeding strategies"
+
+config LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	bool "Oversample entropy sources"
+	default n
+	help
+	  When enabling this option, the entropy sources are
+	  over-sampled with the following approach: First, the
+	  the entropy sources are requested to provide 64 bits more
+	  entropy than the size of the entropy buffer. For example,
+	  if the entropy buffer is 256 bits, 320 bits of entropy
+	  is requested to fill that buffer.
+
+	  Second, the seed operation of the deterministic RNG
+	  requests 128 bits more data from each entropy source than
+	  the security strength of the DRNG during initialization.
+	  A prerequisite for this operation is that the digest size
+	  of the used hash must be at least equally large to generate
+	  that buffer. If the prerequisite is not met, this
+	  oversampling is not applied.
+
+	  This strategy is intended to offset the asymptotic entropy
+	  increase to reach full entropy in a buffer.
+
+	  The strategy is consistent with the requirements in
+	  NIST SP800-90C and is only enforced with fips=1.
+
+	  If unsure, say N.
+
+config LRNG_OVERSAMPLE_ES_BITS
+	int
+	default 0 if !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	default 64 if LRNG_OVERSAMPLE_ENTROPY_SOURCES
+
+config LRNG_SEED_BUFFER_INIT_ADD_BITS
+	int
+	default 0 if !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	default 128 if LRNG_OVERSAMPLE_ENTROPY_SOURCES
+
+endmenu # "Specific DRNG seeding strategies"
+
+endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
new file mode 100644
index 000000000000..6f4603f897cd
--- /dev/null
+++ b/drivers/char/lrng/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux Random Number Generator.
+#
+
+obj-y				+= lrng_es_mgr.o lrng_aux.o \
+				   lrng_drng.o lrng_chacha20.o \
+				   lrng_interfaces.o lrng_es_aux.o
diff --git a/drivers/char/lrng/lrng_aux.c b/drivers/char/lrng/lrng_aux.c
new file mode 100644
index 000000000000..e3b994f6e4c1
--- /dev/null
+++ b/drivers/char/lrng/lrng_aux.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG auxiliary interfaces
+ *
+ * Copyright (C) 2019 - 2021 Stephan Mueller <smueller@chronox.de>
+ * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All
+ * Rights Reserved.
+ * Copyright (C) 2016 Jason Cooper <jason@lakedaemon.net>
+ */
+
+#include <linux/mm.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+struct batched_entropy {
+	union {
+		u64 entropy_u64[LRNG_DRNG_BLOCKSIZE / sizeof(u64)];
+		u32 entropy_u32[LRNG_DRNG_BLOCKSIZE / sizeof(u32)];
+	};
+	unsigned int position;
+	spinlock_t batch_lock;
+};
+
+/*
+ * Get a random word for internal kernel use only. The quality of the random
+ * number is as good as /dev/urandom, but there is no backtrack protection,
+ * with the goal of being quite fast and not depleting entropy.
+ */
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
+	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+};
+
+u64 get_random_u64(void)
+{
+	u64 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+	lrng_debug_report_seedlevel("get_random_u64");
+
+	batch = raw_cpu_ptr(&batched_entropy_u64);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
+		lrng_drng_get_atomic((u8 *)batch->entropy_u64,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position = 0;
+	}
+	ret = batch->entropy_u64[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u64);
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
+	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+};
+
+u32 get_random_u32(void)
+{
+	u32 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+	lrng_debug_report_seedlevel("get_random_u32");
+
+	batch = raw_cpu_ptr(&batched_entropy_u32);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
+		lrng_drng_get_atomic((u8 *)batch->entropy_u32,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position = 0;
+	}
+	ret = batch->entropy_u32[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u32);
+
+/*
+ * It's important to invalidate all potential batched entropy that might
+ * be stored before the crng is initialized, which we can do lazily by
+ * simply resetting the counter to zero so that it's re-extracted on the
+ * next usage.
+ */
+void invalidate_batched_entropy(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	for_each_possible_cpu(cpu) {
+		struct batched_entropy *batched_entropy;
+
+		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
+		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
+		batched_entropy->position = 0;
+		spin_unlock(&batched_entropy->batch_lock);
+
+		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
+		spin_lock(&batched_entropy->batch_lock);
+		batched_entropy->position = 0;
+		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
+	}
+}
+
+/*
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -= PAGE_ALIGN(start) - start;
+		start = PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range = ULONG_MAX - start;
+
+	range >>= PAGE_SHIFT;
+
+	if (range == 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
diff --git a/drivers/char/lrng/lrng_chacha20.c b/drivers/char/lrng/lrng_chacha20.c
new file mode 100644
index 000000000000..51f693c2971f
--- /dev/null
+++ b/drivers/char/lrng/lrng_chacha20.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using
+ * ChaCha20 cipher implementations.
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/chacha.h>
+#include <linux/lrng.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+
+#include "lrng_chacha20.h"
+#include "lrng_internal.h"
+
+/******************************* ChaCha20 DRNG *******************************/
+
+#define CHACHA_BLOCK_WORDS	(CHACHA_BLOCK_SIZE / sizeof(u32))
+
+struct chacha20_state {
+	struct chacha20_block block;
+};
+
+/*
+ * Have a static memory blocks for the ChaCha20 DRNG instance to avoid calling
+ * kmalloc too early in the boot cycle. For subsequent allocation requests,
+ * such as per-NUMA-node DRNG instances, kmalloc will be used.
+ */
+struct chacha20_state chacha20 __latent_entropy;
+
+/*
+ * Update of the ChaCha20 state by either using an unused buffer part or by
+ * generating one ChaCha20 block which is half of the state of the ChaCha20.
+ * The block is XORed into the key part of the state. This shall ensure
+ * backtracking resistance as well as a proper mix of the ChaCha20 state once
+ * the key is injected.
+ */
+static void lrng_chacha20_update(struct chacha20_state *chacha20_state,
+				 __le32 *buf, u32 used_words)
+{
+	struct chacha20_block *chacha20 = &chacha20_state->block;
+	u32 i;
+	__le32 tmp[CHACHA_BLOCK_WORDS];
+
+	BUILD_BUG_ON(sizeof(struct chacha20_block) != CHACHA_BLOCK_SIZE);
+	BUILD_BUG_ON(CHACHA_BLOCK_SIZE != 2 * CHACHA_KEY_SIZE);
+
+	if (used_words > CHACHA_KEY_SIZE_WORDS) {
+		chacha20_block(&chacha20->constants[0], (u8 *)tmp);
+		for (i = 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^= le32_to_cpu(tmp[i]);
+		memzero_explicit(tmp, sizeof(tmp));
+	} else {
+		for (i = 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^= le32_to_cpu(buf[i + used_words]);
+	}
+
+	/* Deterministic increment of nonce as required in RFC 7539 chapter 4 */
+	chacha20->nonce[0]++;
+	if (chacha20->nonce[0] == 0) {
+		chacha20->nonce[1]++;
+		if (chacha20->nonce[1] == 0)
+			chacha20->nonce[2]++;
+	}
+
+	/* Leave counter untouched as it is start value is undefined in RFC */
+}
+
+/*
+ * Seed the ChaCha20 DRNG by injecting the input data into the key part of
+ * the ChaCha20 state. If the input data is longer than the ChaCha20 key size,
+ * perform a ChaCha20 operation after processing of key size input data.
+ * This operation shall spread out the entropy into the ChaCha20 state before
+ * new entropy is injected into the key part.
+ */
+static int lrng_cc20_drng_seed_helper(void *drng, const u8 *inbuf, u32 inbuflen)
+{
+	struct chacha20_state *chacha20_state = (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 = &chacha20_state->block;
+
+	while (inbuflen) {
+		u32 i, todo = min_t(u32, inbuflen, CHACHA_KEY_SIZE);
+
+		for (i = 0; i < todo; i++)
+			chacha20->key.b[i] ^= inbuf[i];
+
+		/* Break potential dependencies between the inbuf key blocks */
+		lrng_chacha20_update(chacha20_state, NULL,
+				     CHACHA_BLOCK_WORDS);
+		inbuf += todo;
+		inbuflen -= todo;
+	}
+
+	return 0;
+}
+
+/*
+ * Chacha20 DRNG generation of random numbers: the stream output of ChaCha20
+ * is the random number. After the completion of the generation of the
+ * stream, the entire ChaCha20 state is updated.
+ *
+ * Note, as the ChaCha20 implements a 32 bit counter, we must ensure
+ * that this function is only invoked for at most 2^32 - 1 ChaCha20 blocks
+ * before a reseed or an update happens. This is ensured by the variable
+ * outbuflen which is a 32 bit integer defining the number of bytes to be
+ * generated by the ChaCha20 DRNG. At the end of this function, an update
+ * operation is invoked which implies that the 32 bit counter will never be
+ * overflown in this implementation.
+ */
+static int lrng_cc20_drng_generate_helper(void *drng, u8 *outbuf, u32 outbuflen)
+{
+	struct chacha20_state *chacha20_state = (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 = &chacha20_state->block;
+	__le32 aligned_buf[CHACHA_BLOCK_WORDS];
+	u32 ret = outbuflen, used = CHACHA_BLOCK_WORDS;
+	int zeroize_buf = 0;
+
+	while (outbuflen >= CHACHA_BLOCK_SIZE) {
+		chacha20_block(&chacha20->constants[0], outbuf);
+		outbuf += CHACHA_BLOCK_SIZE;
+		outbuflen -= CHACHA_BLOCK_SIZE;
+	}
+
+	if (outbuflen) {
+		chacha20_block(&chacha20->constants[0], (u8 *)aligned_buf);
+		memcpy(outbuf, aligned_buf, outbuflen);
+		used = ((outbuflen + sizeof(aligned_buf[0]) - 1) /
+			sizeof(aligned_buf[0]));
+		zeroize_buf = 1;
+	}
+
+	lrng_chacha20_update(chacha20_state, aligned_buf, used);
+
+	if (zeroize_buf)
+		memzero_explicit(aligned_buf, sizeof(aligned_buf));
+
+	return ret;
+}
+
+void lrng_cc20_init_state(struct chacha20_state *state)
+{
+	lrng_cc20_init_rfc7539(&state->block);
+}
+
+/*
+ * Allocation of the DRNG state
+ */
+static void *lrng_cc20_drng_alloc(u32 sec_strength)
+{
+	struct chacha20_state *state = NULL;
+
+	if (sec_strength > CHACHA_KEY_SIZE) {
+		pr_err("Security strength of ChaCha20 DRNG (%u bits) lower than requested by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+		return ERR_PTR(-EINVAL);
+	}
+	if (sec_strength < CHACHA_KEY_SIZE)
+		pr_warn("Security strength of ChaCha20 DRNG (%u bits) higher than requested by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+
+	state = kmalloc(sizeof(struct chacha20_state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+	pr_debug("memory for ChaCha20 core allocated\n");
+
+	lrng_cc20_init_state(state);
+
+	return state;
+}
+
+static void lrng_cc20_drng_dealloc(void *drng)
+{
+	struct chacha20_state *chacha20_state = (struct chacha20_state *)drng;
+
+	if (drng == &chacha20) {
+		memzero_explicit(chacha20_state, sizeof(*chacha20_state));
+		pr_debug("static ChaCha20 core zeroized\n");
+		return;
+	}
+
+	pr_debug("ChaCha20 core zeroized and freed\n");
+	kfree_sensitive(chacha20_state);
+}
+
+/******************************* Hash Operation *******************************/
+
+#ifdef CONFIG_CRYPTO_LIB_SHA256
+
+#include <crypto/sha2.h>
+
+static u32 lrng_cc20_hash_digestsize(void *hash)
+{
+	return SHA256_DIGEST_SIZE;
+}
+
+static int lrng_cc20_hash_init(struct shash_desc *shash, void *hash)
+{
+	/*
+	 * We do not need a TFM - we only need sufficient space for
+	 * struct sha256_state on the stack.
+	 */
+	sha256_init(shash_desc_ctx(shash));
+	return 0;
+}
+
+static int lrng_cc20_hash_update(struct shash_desc *shash,
+				 const u8 *inbuf, u32 inbuflen)
+{
+	sha256_update(shash_desc_ctx(shash), inbuf, inbuflen);
+	return 0;
+}
+
+static int lrng_cc20_hash_final(struct shash_desc *shash, u8 *digest)
+{
+	sha256_final(shash_desc_ctx(shash), digest);
+	return 0;
+}
+
+static const char *lrng_cc20_hash_name(void)
+{
+	return "SHA-256";
+}
+
+static void lrng_cc20_hash_desc_zero(struct shash_desc *shash)
+{
+	memzero_explicit(shash_desc_ctx(shash), sizeof(struct sha256_state));
+}
+
+#else /* CONFIG_CRYPTO_LIB_SHA256 */
+
+#include <crypto/sha1.h>
+#include <crypto/sha1_base.h>
+
+/*
+ * If the SHA-256 support is not compiled, we fall back to SHA-1 that is always
+ * compiled and present in the kernel.
+ */
+static u32 lrng_cc20_hash_digestsize(void *hash)
+{
+	return SHA1_DIGEST_SIZE;
+}
+
+static void lrng_sha1_block_fn(struct sha1_state *sctx, const u8 *src,
+			       int blocks)
+{
+	u32 temp[SHA1_WORKSPACE_WORDS];
+
+	while (blocks--) {
+		sha1_transform(sctx->state, src, temp);
+		src += SHA1_BLOCK_SIZE;
+	}
+	memzero_explicit(temp, sizeof(temp));
+}
+
+static int lrng_cc20_hash_init(struct shash_desc *shash, void *hash)
+{
+	/*
+	 * We do not need a TFM - we only need sufficient space for
+	 * struct sha1_state on the stack.
+	 */
+	sha1_base_init(shash);
+	return 0;
+}
+
+static int lrng_cc20_hash_update(struct shash_desc *shash,
+				 const u8 *inbuf, u32 inbuflen)
+{
+	return sha1_base_do_update(shash, inbuf, inbuflen, lrng_sha1_block_fn);
+}
+
+static int lrng_cc20_hash_final(struct shash_desc *shash, u8 *digest)
+{
+	return sha1_base_do_finalize(shash, lrng_sha1_block_fn) ?:
+	       sha1_base_finish(shash, digest);
+}
+
+static const char *lrng_cc20_hash_name(void)
+{
+	return "SHA-1";
+}
+
+static void lrng_cc20_hash_desc_zero(struct shash_desc *shash)
+{
+	memzero_explicit(shash_desc_ctx(shash), sizeof(struct sha1_state));
+}
+
+#endif /* CONFIG_CRYPTO_LIB_SHA256 */
+
+static void *lrng_cc20_hash_alloc(void)
+{
+	pr_info("Hash %s allocated\n", lrng_cc20_hash_name());
+	return NULL;
+}
+
+static void lrng_cc20_hash_dealloc(void *hash)
+{
+}
+
+static const char *lrng_cc20_drng_name(void)
+{
+	return "ChaCha20 DRNG";
+}
+
+const struct lrng_crypto_cb lrng_cc20_crypto_cb = {
+	.lrng_drng_name			= lrng_cc20_drng_name,
+	.lrng_hash_name			= lrng_cc20_hash_name,
+	.lrng_drng_alloc		= lrng_cc20_drng_alloc,
+	.lrng_drng_dealloc		= lrng_cc20_drng_dealloc,
+	.lrng_drng_seed_helper		= lrng_cc20_drng_seed_helper,
+	.lrng_drng_generate_helper	= lrng_cc20_drng_generate_helper,
+	.lrng_hash_alloc		= lrng_cc20_hash_alloc,
+	.lrng_hash_dealloc		= lrng_cc20_hash_dealloc,
+	.lrng_hash_digestsize		= lrng_cc20_hash_digestsize,
+	.lrng_hash_init			= lrng_cc20_hash_init,
+	.lrng_hash_update		= lrng_cc20_hash_update,
+	.lrng_hash_final		= lrng_cc20_hash_final,
+	.lrng_hash_desc_zero		= lrng_cc20_hash_desc_zero,
+};
diff --git a/drivers/char/lrng/lrng_chacha20.h b/drivers/char/lrng/lrng_chacha20.h
new file mode 100644
index 000000000000..bd0c0bee38f3
--- /dev/null
+++ b/drivers/char/lrng/lrng_chacha20.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * LRNG ChaCha20 definitions
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#include <crypto/chacha.h>
+
+/* State according to RFC 7539 section 2.3 */
+struct chacha20_block {
+	u32 constants[4];
+	union {
+#define CHACHA_KEY_SIZE_WORDS (CHACHA_KEY_SIZE / sizeof(u32))
+		u32 u[CHACHA_KEY_SIZE_WORDS];
+		u8  b[CHACHA_KEY_SIZE];
+	} key;
+	u32 counter;
+	u32 nonce[3];
+};
+
+static inline void lrng_cc20_init_rfc7539(struct chacha20_block *chacha20)
+{
+	chacha_init_consts(chacha20->constants);
+}
diff --git a/drivers/char/lrng/lrng_drng.c b/drivers/char/lrng/lrng_drng.c
new file mode 100644
index 000000000000..1ab533263239
--- /dev/null
+++ b/drivers/char/lrng/lrng_drng.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG DRNG processing
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fips.h>
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Maximum number of seconds between DRNG reseed intervals of the DRNG. Note,
+ * this is enforced with the next request of random numbers from the
+ * DRNG. Setting this value to zero implies a reseeding attempt before every
+ * generated random number.
+ */
+int lrng_drng_reseed_max_time = 600;
+
+static atomic_t lrng_avail = ATOMIC_INIT(0);
+
+DEFINE_MUTEX(lrng_crypto_cb_update);
+
+/* DRNG for /dev/urandom, getrandom(2), get_random_bytes */
+static struct lrng_drng lrng_drng_init = {
+	.drng		= &chacha20,
+	.crypto_cb	= &lrng_cc20_crypto_cb,
+	.lock		= __MUTEX_INITIALIZER(lrng_drng_init.lock),
+	.spin_lock	= __SPIN_LOCK_UNLOCKED(lrng_drng_init.spin_lock),
+	.hash_lock	= __RW_LOCK_UNLOCKED(lrng_drng_init.hash_lock)
+};
+
+/*
+ * DRNG for get_random_bytes when called in atomic context. This
+ * DRNG will always use the ChaCha20 DRNG. It will never benefit from a
+ * DRNG switch like the "regular" DRNG. If there was no DRNG switch, the atomic
+ * DRNG is identical to the "regular" DRNG.
+ *
+ * The reason for having this is due to the fact that DRNGs other than
+ * the ChaCha20 DRNG may sleep.
+ */
+static struct lrng_drng lrng_drng_atomic = {
+	.drng		= &chacha20,
+	.crypto_cb	= &lrng_cc20_crypto_cb,
+	.spin_lock	= __SPIN_LOCK_UNLOCKED(lrng_drng_atomic.spin_lock),
+	.hash_lock	= __RW_LOCK_UNLOCKED(lrng_drng_atomic.hash_lock)
+};
+
+static u32 max_wo_reseed = LRNG_DRNG_MAX_WITHOUT_RESEED;
+#ifdef CONFIG_LRNG_RUNTIME_MAX_WO_RESEED_CONFIG
+module_param(max_wo_reseed, uint, 0444);
+MODULE_PARM_DESC(max_wo_reseed,
+		 "Maximum number of DRNG generate operation without full reseed\n");
+#endif
+
+/********************************** Helper ************************************/
+
+bool lrng_get_available(void)
+{
+	return likely(atomic_read(&lrng_avail));
+}
+
+void lrng_set_available(void)
+{
+	atomic_set(&lrng_avail, 1);
+}
+
+struct lrng_drng *lrng_drng_init_instance(void)
+{
+	return &lrng_drng_init;
+}
+
+struct lrng_drng *lrng_drng_atomic_instance(void)
+{
+	return &lrng_drng_atomic;
+}
+
+void lrng_drng_reset(struct lrng_drng *drng)
+{
+	atomic_set(&drng->requests, LRNG_DRNG_RESEED_THRESH);
+	atomic_set(&drng->requests_since_fully_seeded, 0);
+	drng->last_seeded = jiffies;
+	drng->fully_seeded = false;
+	drng->force_reseed = true;
+	pr_debug("reset DRNG\n");
+}
+
+/* Initialize the default DRNG during boot */
+static void lrng_drng_seed(struct lrng_drng *drng);
+void lrng_drngs_init_cc20(bool force_seed)
+{
+	unsigned long flags = 0;
+
+	if (lrng_get_available())
+		return;
+
+	lrng_drng_lock(&lrng_drng_init, &flags);
+	if (lrng_get_available()) {
+		lrng_drng_unlock(&lrng_drng_init, &flags);
+		if (force_seed)
+			goto seed;
+		return;
+	}
+
+	lrng_drng_reset(&lrng_drng_init);
+	lrng_cc20_init_state(&chacha20);
+	lrng_drng_unlock(&lrng_drng_init, &flags);
+
+	lrng_drng_lock(&lrng_drng_atomic, &flags);
+	lrng_drng_reset(&lrng_drng_atomic);
+	/*
+	 * We do not initialize the state of the atomic DRNG as it is identical
+	 * to the DRNG at this point.
+	 */
+	lrng_drng_unlock(&lrng_drng_atomic, &flags);
+
+	lrng_set_available();
+
+seed:
+	/* Seed the DRNG with any entropy available */
+	if (!lrng_pool_trylock()) {
+		lrng_drng_seed(&lrng_drng_init);
+		pr_info("ChaCha20 core initialized with first seeding\n");
+		lrng_pool_unlock();
+	} else {
+		pr_info("ChaCha20 core initialized without seeding\n");
+	}
+}
+
+bool lrng_sp80090c_compliant(void)
+{
+	if (!IS_ENABLED(CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES))
+		return false;
+
+	/* Entropy source hash must be capable of transporting enough entropy */
+	if (lrng_get_digestsize() <
+	    (lrng_security_strength() + CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS))
+		return false;
+
+	/* SP800-90C only requested in FIPS mode */
+	return fips_enabled;
+}
+
+/************************* Random Number Generation ***************************/
+
+/* Inject a data buffer into the DRNG */
+static void lrng_drng_inject(struct lrng_drng *drng,
+			     const u8 *inbuf, u32 inbuflen, bool fully_seeded)
+{
+	const char *drng_type = unlikely(drng == &lrng_drng_atomic) ?
+				"atomic" : "regular";
+	unsigned long flags = 0;
+
+	BUILD_BUG_ON(LRNG_DRNG_RESEED_THRESH > INT_MAX);
+	pr_debug("seeding %s DRNG with %u bytes\n", drng_type, inbuflen);
+	lrng_drng_lock(drng, &flags);
+	if (drng->crypto_cb->lrng_drng_seed_helper(drng->drng,
+						   inbuf, inbuflen) < 0) {
+		pr_warn("seeding of %s DRNG failed\n", drng_type);
+		drng->force_reseed = true;
+	} else {
+		int gc = LRNG_DRNG_RESEED_THRESH - atomic_read(&drng->requests);
+
+		pr_debug("%s DRNG stats since last seeding: %lu secs; generate calls: %d\n",
+			 drng_type,
+			 (time_after(jiffies, drng->last_seeded) ?
+			  (jiffies - drng->last_seeded) : 0) / HZ, gc);
+
+		/* Count the numbers of generate ops since last fully seeded */
+		if (fully_seeded)
+			atomic_set(&drng->requests_since_fully_seeded, 0);
+		else
+			atomic_add(gc, &drng->requests_since_fully_seeded);
+
+		drng->last_seeded = jiffies;
+		atomic_set(&drng->requests, LRNG_DRNG_RESEED_THRESH);
+		drng->force_reseed = false;
+
+		if (!drng->fully_seeded) {
+			drng->fully_seeded = fully_seeded;
+			if (drng->fully_seeded)
+				pr_debug("DRNG fully seeded\n");
+		}
+
+		if (drng->drng == lrng_drng_atomic.drng) {
+			lrng_drng_atomic.last_seeded = jiffies;
+			atomic_set(&lrng_drng_atomic.requests,
+				   LRNG_DRNG_RESEED_THRESH);
+			lrng_drng_atomic.force_reseed = false;
+		}
+	}
+	lrng_drng_unlock(drng, &flags);
+}
+
+/*
+ * Perform the seeding of the DRNG with data from noise source
+ */
+static inline void _lrng_drng_seed(struct lrng_drng *drng)
+{
+	struct entropy_buf seedbuf __aligned(LRNG_KCAPI_ALIGN);
+
+	lrng_fill_seed_buffer(&seedbuf,
+			      lrng_get_seed_entropy_osr(drng->fully_seeded));
+	lrng_init_ops(&seedbuf);
+	lrng_drng_inject(drng, (u8 *)&seedbuf, sizeof(seedbuf),
+			 lrng_fully_seeded(drng->fully_seeded, &seedbuf));
+	memzero_explicit(&seedbuf, sizeof(seedbuf));
+}
+
+static int lrng_drng_get(struct lrng_drng *drng, u8 *outbuf, u32 outbuflen);
+static void lrng_drng_seed(struct lrng_drng *drng)
+{
+	_lrng_drng_seed(drng);
+
+	BUILD_BUG_ON(LRNG_MIN_SEED_ENTROPY_BITS >
+		     LRNG_DRNG_SECURITY_STRENGTH_BITS);
+
+	/*
+	 * Reseed atomic DRNG from current DRNG,
+	 *
+	 * We can obtain random numbers from DRNG as the lock type
+	 * chosen by lrng_drng_get is usable with the current caller.
+	 */
+	if ((drng->drng != lrng_drng_atomic.drng) &&
+	    (lrng_drng_atomic.force_reseed ||
+	     atomic_read(&lrng_drng_atomic.requests) <= 0 ||
+	     time_after(jiffies, lrng_drng_atomic.last_seeded +
+			lrng_drng_reseed_max_time * HZ))) {
+		u8 seedbuf[LRNG_DRNG_SECURITY_STRENGTH_BYTES]
+						__aligned(LRNG_KCAPI_ALIGN);
+		int ret = lrng_drng_get(drng, seedbuf, sizeof(seedbuf));
+
+		if (ret < 0) {
+			pr_warn("Error generating random numbers for atomic DRNG: %d\n",
+				ret);
+		} else {
+			lrng_drng_inject(&lrng_drng_atomic, seedbuf, ret, true);
+		}
+		memzero_explicit(&seedbuf, sizeof(seedbuf));
+	}
+}
+
+static inline void _lrng_drng_seed_work(struct lrng_drng *drng, u32 node)
+{
+	pr_debug("reseed triggered by interrupt noise source for DRNG on NUMA node %d\n",
+		 node);
+	lrng_drng_seed(drng);
+	if (drng->fully_seeded) {
+		/* Prevent reseed storm */
+		drng->last_seeded += node * 100 * HZ;
+		/* Prevent draining of pool on idle systems */
+		lrng_drng_reseed_max_time += 100;
+	}
+}
+
+/*
+ * DRNG reseed trigger: Kernel thread handler triggered by the schedule_work()
+ */
+void lrng_drng_seed_work(struct work_struct *dummy)
+{
+	struct lrng_drng **lrng_drng = lrng_drng_instances();
+	u32 node;
+
+	if (lrng_drng) {
+		for_each_online_node(node) {
+			struct lrng_drng *drng = lrng_drng[node];
+
+			if (drng && !drng->fully_seeded) {
+				_lrng_drng_seed_work(drng, node);
+				goto out;
+			}
+		}
+	} else {
+		if (!lrng_drng_init.fully_seeded) {
+			_lrng_drng_seed_work(&lrng_drng_init, 0);
+			goto out;
+		}
+	}
+
+	lrng_pool_all_numa_nodes_seeded(true);
+
+out:
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+}
+
+/* Force all DRNGs to reseed before next generation */
+void lrng_drng_force_reseed(void)
+{
+	struct lrng_drng **lrng_drng = lrng_drng_instances();
+	u32 node;
+
+	/*
+	 * If the initial DRNG is over the reseed threshold, allow a forced
+	 * reseed only for the initial DRNG as this is the fallback for all. It
+	 * must be kept seeded before all others to keep the LRNG operational.
+	 */
+	if (!lrng_drng ||
+	    (atomic_read_u32(&lrng_drng_init.requests_since_fully_seeded) >
+	     LRNG_DRNG_RESEED_THRESH)) {
+		lrng_drng_init.force_reseed = lrng_drng_init.fully_seeded;
+		pr_debug("force reseed of initial DRNG\n");
+		return;
+	}
+	for_each_online_node(node) {
+		struct lrng_drng *drng = lrng_drng[node];
+
+		if (!drng)
+			continue;
+
+		drng->force_reseed = drng->fully_seeded;
+		pr_debug("force reseed of DRNG on node %u\n", node);
+	}
+	lrng_drng_atomic.force_reseed = lrng_drng_atomic.fully_seeded;
+}
+
+/*
+ * lrng_drng_get() - Get random data out of the DRNG which is reseeded
+ * frequently.
+ *
+ * @outbuf: buffer for storing random data
+ * @outbuflen: length of outbuf
+ *
+ * Return:
+ * * < 0 in error case (DRNG generation or update failed)
+ * * >=0 returning the returned number of bytes
+ */
+static int lrng_drng_get(struct lrng_drng *drng, u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags = 0;
+	u32 processed = 0;
+
+	if (!outbuf || !outbuflen)
+		return 0;
+
+	outbuflen = min_t(size_t, outbuflen, INT_MAX);
+
+	lrng_drngs_init_cc20(false);
+
+	/* If DRNG operated without proper reseed for too long, block LRNG */
+	BUILD_BUG_ON(LRNG_DRNG_MAX_WITHOUT_RESEED < LRNG_DRNG_RESEED_THRESH);
+	if (atomic_read_u32(&drng->requests_since_fully_seeded) > max_wo_reseed)
+		lrng_unset_fully_seeded(drng);
+
+	while (outbuflen) {
+		u32 todo = min_t(u32, outbuflen, LRNG_DRNG_MAX_REQSIZE);
+		int ret;
+
+		/* All but the atomic DRNG are seeded during generation */
+		if (atomic_dec_and_test(&drng->requests) ||
+		    drng->force_reseed ||
+		    time_after(jiffies, drng->last_seeded +
+			       lrng_drng_reseed_max_time * HZ)) {
+			if (likely(drng != &lrng_drng_atomic)) {
+				if (lrng_pool_trylock()) {
+					drng->force_reseed = true;
+				} else {
+					lrng_drng_seed(drng);
+					lrng_pool_unlock();
+				}
+			}
+		}
+
+		lrng_drng_lock(drng, &flags);
+		ret = drng->crypto_cb->lrng_drng_generate_helper(
+					drng->drng, outbuf + processed, todo);
+		lrng_drng_unlock(drng, &flags);
+		if (ret <= 0) {
+			pr_warn("getting random data from DRNG failed (%d)\n",
+				ret);
+			return -EFAULT;
+		}
+		processed += ret;
+		outbuflen -= ret;
+	}
+
+	return processed;
+}
+
+int lrng_drng_get_atomic(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_drng_get(&lrng_drng_atomic, outbuf, outbuflen);
+}
+
+int lrng_drng_get_sleep(u8 *outbuf, u32 outbuflen)
+{
+	struct lrng_drng **lrng_drng = lrng_drng_instances();
+	struct lrng_drng *drng = &lrng_drng_init;
+	int node = numa_node_id();
+
+	might_sleep();
+
+	if (lrng_drng && lrng_drng[node] && lrng_drng[node]->fully_seeded)
+		drng = lrng_drng[node];
+
+	return lrng_drng_get(drng, outbuf, outbuflen);
+}
+
+/* Reset LRNG such that all existing entropy is gone */
+static void _lrng_reset(struct work_struct *work)
+{
+	struct lrng_drng **lrng_drng = lrng_drng_instances();
+	unsigned long flags = 0;
+
+	if (!lrng_drng) {
+		lrng_drng_lock(&lrng_drng_init, &flags);
+		lrng_drng_reset(&lrng_drng_init);
+		lrng_drng_unlock(&lrng_drng_init, &flags);
+	} else {
+		u32 node;
+
+		for_each_online_node(node) {
+			struct lrng_drng *drng = lrng_drng[node];
+
+			if (!drng)
+				continue;
+			lrng_drng_lock(drng, &flags);
+			lrng_drng_reset(drng);
+			lrng_drng_unlock(drng, &flags);
+		}
+	}
+	lrng_set_entropy_thresh(LRNG_INIT_ENTROPY_BITS);
+
+	lrng_reset_state();
+}
+
+static DECLARE_WORK(lrng_reset_work, _lrng_reset);
+
+void lrng_reset(void)
+{
+	schedule_work(&lrng_reset_work);
+}
+
+/***************************** Initialize LRNG *******************************/
+
+static int __init lrng_init(void)
+{
+	lrng_drngs_init_cc20(false);
+
+	lrng_drngs_numa_alloc();
+	return 0;
+}
+
+late_initcall(lrng_init);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator");
diff --git a/drivers/char/lrng/lrng_es_aux.c b/drivers/char/lrng/lrng_es_aux.c
new file mode 100644
index 000000000000..cd51c7311feb
--- /dev/null
+++ b/drivers/char/lrng/lrng_es_aux.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Slow Entropy Source: Auxiliary entropy pool
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+/*
+ * This is the auxiliary pool
+ *
+ * The aux pool array is aligned to 8 bytes to comfort the kernel crypto API
+ * cipher implementations of the hash functions used to read the pool: for some
+ * accelerated implementations, we need an alignment to avoid a realignment
+ * which involves memcpy(). The alignment to 8 bytes should satisfy all crypto
+ * implementations.
+ */
+struct lrng_pool {
+	u8 aux_pool[LRNG_POOL_SIZE];	/* Aux pool: digest state */
+	atomic_t aux_entropy_bits;
+	atomic_t digestsize;		/* Digest size of used hash */
+	bool initialized;		/* Aux pool initialized? */
+
+	/* Serialize read of entropy pool and update of aux pool */
+	spinlock_t lock;
+};
+
+static struct lrng_pool lrng_pool __aligned(LRNG_KCAPI_ALIGN) = {
+	.aux_entropy_bits	= ATOMIC_INIT(0),
+	.digestsize		= ATOMIC_INIT(LRNG_ATOMIC_DIGEST_SIZE),
+	.initialized		= false,
+	.lock			= __SPIN_LOCK_UNLOCKED(lrng_pool.lock)
+};
+
+/********************************** Helper ***********************************/
+
+/* Entropy in bits present in aux pool */
+u32 lrng_avail_aux_entropy(void)
+{
+	/* Cap available entropy with max entropy */
+	u32 avail_bits = min_t(u32, lrng_get_digestsize(),
+			       atomic_read_u32(&lrng_pool.aux_entropy_bits));
+
+	/* Consider oversampling rate due to aux pool conditioning */
+	return lrng_reduce_by_osr(avail_bits);
+}
+
+/* Set the digest size of the used hash in bytes */
+static inline void lrng_set_digestsize(u32 digestsize)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	u32 ent_bits = atomic_xchg_relaxed(&pool->aux_entropy_bits, 0),
+	    old_digestsize = lrng_get_digestsize();
+
+	atomic_set(&lrng_pool.digestsize, digestsize);
+
+	/*
+	 * Update the /proc/.../write_wakeup_threshold which must not be larger
+	 * than the digest size of the curent conditioning hash.
+	 */
+	digestsize <<= 3;
+	lrng_proc_update_max_write_thresh(digestsize);
+	if (lrng_write_wakeup_bits > digestsize)
+		lrng_write_wakeup_bits = digestsize;
+
+	/*
+	 * In case the new digest is larger than the old one, cap the available
+	 * entropy to the old message digest used to process the existing data.
+	 */
+	ent_bits = min_t(u32, ent_bits, old_digestsize);
+	atomic_add(ent_bits, &pool->aux_entropy_bits);
+}
+
+/* Obtain the digest size provided by the used hash in bits */
+u32 lrng_get_digestsize(void)
+{
+	return atomic_read_u32(&lrng_pool.digestsize) << 3;
+}
+
+/* Set entropy content in user-space controllable aux pool */
+void lrng_pool_set_entropy(u32 entropy_bits)
+{
+	atomic_set(&lrng_pool.aux_entropy_bits, entropy_bits);
+}
+
+/*
+ * Replace old with new hash for auxiliary pool handling
+ *
+ * Assumption: the caller must guarantee that the new_cb is available during the
+ * entire operation (e.g. it must hold the write lock against pointer updating).
+ */
+int lrng_aux_switch_hash(const struct lrng_crypto_cb *new_cb, void *new_hash,
+			 const struct lrng_crypto_cb *old_cb)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	struct shash_desc *shash = (struct shash_desc *)pool->aux_pool;
+	u8 digest[LRNG_MAX_DIGESTSIZE];
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_LRNG_DRNG_SWITCH))
+		return -EOPNOTSUPP;
+
+	if (unlikely(!pool->initialized))
+		return 0;
+
+	/* Get the aux pool hash with old digest ... */
+	ret = old_cb->lrng_hash_final(shash, digest) ?:
+	      /* ... re-initialize the hash with the new digest ... */
+	      new_cb->lrng_hash_init(shash, new_hash) ?:
+	      /*
+	       * ... feed the old hash into the new state. We may feed
+	       * uninitialized memory into the new state, but this is
+	       * considered no issue and even good as we have some more
+	       * uncertainty here.
+	       */
+	      new_cb->lrng_hash_update(shash, digest, sizeof(digest));
+	if (!ret) {
+		lrng_set_digestsize(new_cb->lrng_hash_digestsize(new_hash));
+		pr_debug("Re-initialize aux entropy pool with hash %s\n",
+			 new_cb->lrng_hash_name());
+	}
+
+	memzero_explicit(digest, sizeof(digest));
+	return ret;
+}
+
+/* Insert data into auxiliary pool by using the hash update function. */
+static int
+lrng_pool_insert_aux_locked(const u8 *inbuf, u32 inbuflen, u32 entropy_bits)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	struct shash_desc *shash = (struct shash_desc *)pool->aux_pool;
+	struct lrng_drng *drng = lrng_drng_init_instance();
+	const struct lrng_crypto_cb *crypto_cb;
+	unsigned long flags;
+	void *hash;
+	int ret;
+
+	entropy_bits = min_t(u32, entropy_bits, inbuflen << 3);
+
+	lrng_hash_lock(drng, &flags);
+
+	crypto_cb = drng->crypto_cb;
+	hash = drng->hash;
+
+	if (unlikely(!pool->initialized)) {
+		ret = crypto_cb->lrng_hash_init(shash, hash);
+		if (ret)
+			goto out;
+		pool->initialized = true;
+	}
+
+	ret = crypto_cb->lrng_hash_update(shash, inbuf, inbuflen);
+	if (ret)
+		goto out;
+
+	/*
+	 * Cap the available entropy to the hash output size compliant to
+	 * SP800-90B section 3.1.5.1 table 1.
+	 */
+	entropy_bits += atomic_read_u32(&pool->aux_entropy_bits);
+	atomic_set(&pool->aux_entropy_bits,
+		   min_t(u32, entropy_bits,
+			 crypto_cb->lrng_hash_digestsize(hash) << 3));
+
+out:
+	lrng_hash_unlock(drng, flags);
+	return ret;
+}
+
+int lrng_pool_insert_aux(const u8 *inbuf, u32 inbuflen, u32 entropy_bits)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	ret = lrng_pool_insert_aux_locked(inbuf, inbuflen, entropy_bits);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	lrng_pool_add_entropy();
+
+	return ret;
+}
+
+/************************* Get data from entropy pool *************************/
+
+/*
+ * Get auxiliary entropy pool and its entropy content for seed buffer.
+ * Caller must hold lrng_pool.pool->lock.
+ * @outbuf: buffer to store data in with size requested_bits
+ * @requested_bits: Requested amount of entropy
+ * @return: amount of entropy in outbuf in bits.
+ */
+static inline u32 lrng_get_aux_pool(u8 *outbuf, u32 requested_bits)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	struct shash_desc *shash = (struct shash_desc *)pool->aux_pool;
+	struct lrng_drng *drng = lrng_drng_init_instance();
+	const struct lrng_crypto_cb *crypto_cb;
+	unsigned long flags;
+	void *hash;
+	u32 collected_ent_bits, returned_ent_bits, unused_bits = 0,
+	    digestsize;
+	u8 aux_output[LRNG_MAX_DIGESTSIZE];
+
+	if (unlikely(!pool->initialized))
+		return 0;
+
+	lrng_hash_lock(drng, &flags);
+
+	crypto_cb = drng->crypto_cb;
+	hash = drng->hash;
+	digestsize = crypto_cb->lrng_hash_digestsize(hash);
+
+	/* Ensure that no more than the size of aux_pool can be requested */
+	requested_bits = min_t(u32, requested_bits, (LRNG_MAX_DIGESTSIZE << 3));
+
+	/* Cap entropy with entropy counter from aux pool and the used digest */
+	collected_ent_bits = min_t(u32, digestsize << 3,
+			       atomic_xchg_relaxed(&pool->aux_entropy_bits, 0));
+
+	/* We collected too much entropy and put the overflow back */
+	if (collected_ent_bits > (requested_bits + lrng_compress_osr())) {
+		/* Amount of bits we collected too much */
+		unused_bits = collected_ent_bits - requested_bits;
+		/* Put entropy back */
+		atomic_add(unused_bits, &pool->aux_entropy_bits);
+		/* Fix collected entropy */
+		collected_ent_bits = requested_bits;
+	}
+
+	/* Apply oversampling: discount requested oversampling rate */
+	returned_ent_bits = lrng_reduce_by_osr(collected_ent_bits);
+
+	pr_debug("obtained %u bits by collecting %u bits of entropy from aux pool, %u bits of entropy remaining\n",
+		 returned_ent_bits, collected_ent_bits, unused_bits);
+
+	/* Get the digest for the aux pool to be returned to the caller ... */
+	if (crypto_cb->lrng_hash_final(shash, aux_output) ||
+	    /*
+	     * ... and re-initialize the aux state. Do not add the aux pool
+	     * digest for backward secrecy as it will be added with the
+	     * insertion of the complete seed buffer after it has been filled.
+	     */
+	    crypto_cb->lrng_hash_init(shash, hash)) {
+		returned_ent_bits = 0;
+	} else {
+		/*
+		 * Do not truncate the output size exactly to collected_ent_bits
+		 * as the aux pool may contain data that is not credited with
+		 * entropy, but we want to use them to stir the DRNG state.
+		 */
+		memcpy(outbuf, aux_output, requested_bits >> 3);
+	}
+
+	lrng_hash_unlock(drng, flags);
+	memzero_explicit(aux_output, digestsize);
+	return returned_ent_bits;
+}
+
+void lrng_get_backtrack_aux(struct entropy_buf *entropy_buf, u32 requested_bits)
+{
+	struct lrng_pool *pool = &lrng_pool;
+	unsigned long flags;
+
+	/* Ensure aux pool extraction and backtracking op are atomic */
+	spin_lock_irqsave(&pool->lock, flags);
+
+	entropy_buf->a_bits = lrng_get_aux_pool(entropy_buf->a, requested_bits);
+
+	/* Mix the extracted data back into pool for backtracking resistance */
+	if (lrng_pool_insert_aux_locked((u8 *)entropy_buf,
+					sizeof(struct entropy_buf), 0))
+		pr_warn("Backtracking resistance operation failed\n");
+
+	spin_unlock_irqrestore(&pool->lock, flags);
+}
+
+void lrng_aux_es_state(unsigned char *buf, size_t buflen)
+{
+	const struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+
+	/* Assume the lrng_drng_init lock is taken by caller */
+	snprintf(buf, buflen,
+		 "Auxiliary ES properties:\n"
+		 " Hash for operating entropy pool: %s\n",
+		 lrng_drng_init->crypto_cb->lrng_hash_name());
+}
diff --git a/drivers/char/lrng/lrng_es_mgr.c b/drivers/char/lrng/lrng_es_mgr.c
new file mode 100644
index 000000000000..c0025ad2b54a
--- /dev/null
+++ b/drivers/char/lrng/lrng_es_mgr.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Entropy sources management
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/irq_regs.h>
+#include <linux/percpu.h>
+#include <linux/random.h>
+#include <linux/utsname.h>
+#include <linux/workqueue.h>
+
+#include "lrng_internal.h"
+
+struct lrng_state {
+	bool can_invalidate;		/* Can invalidate batched entropy? */
+	bool perform_seedwork;		/* Can seed work be performed? */
+	bool lrng_operational;		/* Is DRNG operational? */
+	bool lrng_fully_seeded;		/* Is DRNG fully seeded? */
+	bool lrng_min_seeded;		/* Is DRNG minimally seeded? */
+	bool all_online_numa_node_seeded;/* All NUMA DRNGs seeded? */
+
+	/*
+	 * To ensure that external entropy providers cannot dominate the
+	 * internal noise sources but yet cannot be dominated by internal
+	 * noise sources, the following booleans are intended to allow
+	 * external to provide seed once when a DRNG reseed occurs. This
+	 * triggering of external noise source is performed even when the
+	 * entropy pool has sufficient entropy.
+	 */
+	bool lrng_seed_hw;		/* Allow HW to provide seed */
+	bool lrng_seed_user;		/* Allow user space to provide seed */
+
+	atomic_t boot_entropy_thresh;	/* Reseed threshold */
+	atomic_t reseed_in_progress;	/* Flag for on executing reseed */
+	struct work_struct lrng_seed_work;	/* (re)seed work queue */
+};
+
+static struct lrng_state lrng_state = {
+	false, false, false, false, false, false, true, true,
+	.boot_entropy_thresh	= ATOMIC_INIT(LRNG_INIT_ENTROPY_BITS),
+	.reseed_in_progress	= ATOMIC_INIT(0),
+};
+
+/********************************** Helper ***********************************/
+
+/* External entropy provider is allowed to provide seed data */
+bool lrng_state_exseed_allow(enum lrng_external_noise_source source)
+{
+	if (source == lrng_noise_source_hw)
+		return lrng_state.lrng_seed_hw;
+	return lrng_state.lrng_seed_user;
+}
+
+/* Enable / disable external entropy provider to furnish seed */
+void lrng_state_exseed_set(enum lrng_external_noise_source source, bool type)
+{
+	if (source == lrng_noise_source_hw)
+		lrng_state.lrng_seed_hw = type;
+	else
+		lrng_state.lrng_seed_user = type;
+}
+
+static inline void lrng_state_exseed_allow_all(void)
+{
+	lrng_state_exseed_set(lrng_noise_source_hw, true);
+	lrng_state_exseed_set(lrng_noise_source_user, true);
+}
+
+/*
+ * Reading of the LRNG pool is only allowed by one caller. The reading is
+ * only performed to (re)seed DRNGs. Thus, if this "lock" is already taken,
+ * the reseeding operation is in progress. The caller is not intended to wait
+ * but continue with its other operation.
+ */
+int lrng_pool_trylock(void)
+{
+	return atomic_cmpxchg(&lrng_state.reseed_in_progress, 0, 1);
+}
+
+void lrng_pool_unlock(void)
+{
+	atomic_set(&lrng_state.reseed_in_progress, 0);
+}
+
+/* Set new entropy threshold for reseeding during boot */
+void lrng_set_entropy_thresh(u32 new_entropy_bits)
+{
+	atomic_set(&lrng_state.boot_entropy_thresh, new_entropy_bits);
+}
+
+/*
+ * Reset LRNG state - the entropy counters are reset, but the data that may
+ * or may not have entropy remains in the pools as this data will not hurt.
+ */
+void lrng_reset_state(void)
+{
+	lrng_pool_set_entropy(0);
+	lrng_pcpu_reset();
+	lrng_state.lrng_operational = false;
+	lrng_state.lrng_fully_seeded = false;
+	lrng_state.lrng_min_seeded = false;
+	lrng_state.all_online_numa_node_seeded = false;
+	pr_debug("reset LRNG\n");
+}
+
+/* Set flag that all DRNGs are fully seeded */
+void lrng_pool_all_numa_nodes_seeded(bool set)
+{
+	lrng_state.all_online_numa_node_seeded = set;
+}
+
+/* Return boolean whether LRNG reached minimally seed level */
+bool lrng_state_min_seeded(void)
+{
+	return lrng_state.lrng_min_seeded;
+}
+
+/* Return boolean whether LRNG reached fully seed level */
+bool lrng_state_fully_seeded(void)
+{
+	return lrng_state.lrng_fully_seeded;
+}
+
+/* Return boolean whether LRNG is considered fully operational */
+bool lrng_state_operational(void)
+{
+	return lrng_state.lrng_operational;
+}
+
+/* Policy to check whether entropy buffer contains full seeded entropy */
+bool lrng_fully_seeded(bool fully_seeded, struct entropy_buf *eb)
+{
+	return ((eb->a_bits + eb->b_bits + eb->c_bits + eb->d_bits) >=
+		lrng_get_seed_entropy_osr(fully_seeded));
+}
+
+/* Mark one DRNG as not fully seeded */
+void lrng_unset_fully_seeded(struct lrng_drng *drng)
+{
+	drng->fully_seeded = false;
+	lrng_pool_all_numa_nodes_seeded(false);
+
+	/*
+	 * The init DRNG instance must always be fully seeded as this instance
+	 * is the fall-back if any of the per-NUMA node DRNG instances is
+	 * insufficiently seeded. Thus, we mark the entire LRNG as
+	 * non-operational if the initial DRNG becomes not fully seeded.
+	 */
+	if (drng == lrng_drng_init_instance() && lrng_state_operational()) {
+		pr_debug("LRNG set to non-operational\n");
+		lrng_state.lrng_operational = false;
+		lrng_state.lrng_fully_seeded = false;
+
+		/* If sufficient entropy is available, reseed now. */
+		lrng_pool_add_entropy();
+	}
+}
+
+/* Policy to enable LRNG operational mode */
+static inline void lrng_set_operational(u32 external_es)
+{
+	/* LRNG is operational if the initial DRNG is fully seeded ... */
+	if (lrng_state.lrng_fully_seeded &&
+	    /* ... and either internal ES SP800-90B startup is complete ... */
+	    (lrng_sp80090b_startup_complete() ||
+	    /* ... or the external ES provided sufficient entropy. */
+	     (lrng_get_seed_entropy_osr(lrng_state_fully_seeded()) <=
+	      external_es))) {
+		lrng_state.lrng_operational = true;
+		lrng_process_ready_list();
+		lrng_init_wakeup();
+		pr_info("LRNG fully operational\n");
+	}
+}
+
+/* Available entropy in the entire LRNG considering all entropy sources */
+u32 lrng_avail_entropy(void)
+{
+	u32 ent_thresh = lrng_security_strength();
+
+	/*
+	 * Apply oversampling during initialization according to SP800-90C as
+	 * we request a larger buffer from the ES.
+	 */
+	if (lrng_sp80090c_compliant() &&
+	    !lrng_state.all_online_numa_node_seeded)
+		ent_thresh += CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS;
+
+	return lrng_pcpu_avail_entropy() + lrng_avail_aux_entropy() +
+	       lrng_archrandom_entropylevel(ent_thresh) +
+	       lrng_jent_entropylevel(ent_thresh);
+}
+
+/*
+ * lrng_init_ops() - Set seed stages of LRNG
+ *
+ * Set the slow noise source reseed trigger threshold. The initial threshold
+ * is set to the minimum data size that can be read from the pool: a word. Upon
+ * reaching this value, the next seed threshold of 128 bits is set followed
+ * by 256 bits.
+ *
+ * @eb: buffer containing the size of entropy currently injected into DRNG
+ */
+void lrng_init_ops(struct entropy_buf *eb)
+{
+	struct lrng_state *state = &lrng_state;
+	u32 requested_bits, seed_bits, external_es;
+
+	if (state->lrng_operational)
+		return;
+
+	requested_bits = lrng_get_seed_entropy_osr(
+					state->all_online_numa_node_seeded);
+
+	/*
+	 * Entropy provided by external entropy sources - if they provide
+	 * the requested amount of entropy, unblock the interface.
+	 */
+	external_es = eb->a_bits + eb->c_bits + eb->d_bits;
+	seed_bits = external_es + eb->b_bits;
+
+	/* DRNG is seeded with full security strength */
+	if (state->lrng_fully_seeded) {
+		lrng_set_operational(external_es);
+		lrng_set_entropy_thresh(requested_bits);
+	} else if (lrng_fully_seeded(state->all_online_numa_node_seeded, eb)) {
+		if (state->can_invalidate)
+			invalidate_batched_entropy();
+
+		state->lrng_fully_seeded = true;
+		lrng_set_operational(external_es);
+		state->lrng_min_seeded = true;
+		pr_info("LRNG fully seeded with %u bits of entropy\n",
+			seed_bits);
+		lrng_set_entropy_thresh(requested_bits);
+	} else if (!state->lrng_min_seeded) {
+
+		/* DRNG is seeded with at least 128 bits of entropy */
+		if (seed_bits >= LRNG_MIN_SEED_ENTROPY_BITS) {
+			if (state->can_invalidate)
+				invalidate_batched_entropy();
+
+			state->lrng_min_seeded = true;
+			pr_info("LRNG minimally seeded with %u bits of entropy\n",
+				seed_bits);
+			lrng_set_entropy_thresh(requested_bits);
+			lrng_init_wakeup();
+
+		/* DRNG is seeded with at least LRNG_INIT_ENTROPY_BITS bits */
+		} else if (seed_bits >= LRNG_INIT_ENTROPY_BITS) {
+			pr_info("LRNG initial entropy level %u bits of entropy\n",
+				seed_bits);
+			lrng_set_entropy_thresh(LRNG_MIN_SEED_ENTROPY_BITS);
+		}
+	}
+}
+
+int __init rand_initialize(void)
+{
+	struct seed {
+		ktime_t time;
+		unsigned long data[(LRNG_MAX_DIGESTSIZE /
+				    sizeof(unsigned long))];
+		struct new_utsname utsname;
+	} seed __aligned(LRNG_KCAPI_ALIGN);
+	unsigned int i;
+
+	BUILD_BUG_ON(LRNG_MAX_DIGESTSIZE % sizeof(unsigned long));
+
+	seed.time = ktime_get_real();
+
+	for (i = 0; i < ARRAY_SIZE(seed.data); i++) {
+		if (!arch_get_random_seed_long_early(&(seed.data[i])) &&
+		    !arch_get_random_long_early(&seed.data[i]))
+			seed.data[i] = random_get_entropy();
+	}
+	memcpy(&seed.utsname, utsname(), sizeof(*(utsname())));
+
+	lrng_pool_insert_aux((u8 *)&seed, sizeof(seed), 0);
+	memzero_explicit(&seed, sizeof(seed));
+
+	/* Initialize the seed work queue */
+	INIT_WORK(&lrng_state.lrng_seed_work, lrng_drng_seed_work);
+	lrng_state.perform_seedwork = true;
+
+	lrng_drngs_init_cc20(true);
+	invalidate_batched_entropy();
+
+	lrng_state.can_invalidate = true;
+
+	return 0;
+}
+
+/* Interface requesting a reseed of the DRNG */
+void lrng_pool_add_entropy(void)
+{
+	/*
+	 * Once all DRNGs are fully seeded, the interrupt noise
+	 * sources will not trigger any reseeding any more.
+	 */
+	if (likely(lrng_state.all_online_numa_node_seeded))
+		return;
+
+	/* Only try to reseed if the DRNG is alive. */
+	if (!lrng_get_available())
+		return;
+
+	/* Only trigger the DRNG reseed if we have collected entropy. */
+	if (lrng_avail_entropy() <
+	    atomic_read_u32(&lrng_state.boot_entropy_thresh))
+		return;
+
+	/* Ensure that the seeding only occurs once at any given time. */
+	if (lrng_pool_trylock())
+		return;
+
+	/* Seed the DRNG with any available noise. */
+	if (lrng_state.perform_seedwork)
+		schedule_work(&lrng_state.lrng_seed_work);
+	else
+		lrng_drng_seed_work(NULL);
+}
+
+/* Fill the seed buffer with data from the noise sources */
+void lrng_fill_seed_buffer(struct entropy_buf *entropy_buf, u32 requested_bits)
+{
+	struct lrng_state *state = &lrng_state;
+	u32 req_ent = lrng_sp80090c_compliant() ?
+			  lrng_security_strength() : LRNG_MIN_SEED_ENTROPY_BITS;
+
+	/* Guarantee that requested bits is a multiple of bytes */
+	BUILD_BUG_ON(LRNG_DRNG_SECURITY_STRENGTH_BITS % 8);
+
+	/* always reseed the DRNG with the current time stamp */
+	entropy_buf->now = random_get_entropy();
+
+	/*
+	 * Require at least 128 bits of entropy for any reseed. If the LRNG is
+	 * operated SP800-90C compliant we want to comply with SP800-90A section
+	 * 9.2 mandating that DRNG is reseeded with the security strength.
+	 */
+	if (state->lrng_fully_seeded && (lrng_avail_entropy() < req_ent)) {
+		entropy_buf->a_bits = entropy_buf->b_bits = 0;
+		entropy_buf->c_bits = entropy_buf->d_bits = 0;
+		goto wakeup;
+	}
+
+	/* Concatenate the output of the entropy sources. */
+	entropy_buf->b_bits = lrng_pcpu_pool_hash(entropy_buf->b,
+						  requested_bits,
+						  state->lrng_fully_seeded);
+	entropy_buf->c_bits = lrng_get_arch(entropy_buf->c, requested_bits);
+	entropy_buf->d_bits = lrng_get_jent(entropy_buf->d, requested_bits);
+	lrng_get_backtrack_aux(entropy_buf, requested_bits);
+
+	/* allow external entropy provider to provide seed */
+	lrng_state_exseed_allow_all();
+
+wakeup:
+	/*
+	 * Shall we wake up user space writers? This location covers
+	 * ensures that the user space provider does not dominate the internal
+	 * noise sources since in case the first call of this function finds
+	 * sufficient entropy in the entropy pool, it will not trigger the
+	 * wakeup. This implies that when the next /dev/urandom read happens,
+	 * the entropy pool is drained.
+	 */
+	lrng_writer_wakeup();
+}
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_interfaces.c
new file mode 100644
index 000000000000..6316a534bb54
--- /dev/null
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG User and kernel space interfaces
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/freezer.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/hw_random.h>
+#include <linux/kthread.h>
+#include <linux/poll.h>
+#include <linux/preempt.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/timex.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * If the entropy count falls under this number of bits, then we
+ * should wake up processes which are selecting or polling on write
+ * access to /dev/random.
+ */
+u32 lrng_write_wakeup_bits = (LRNG_WRITE_WAKEUP_ENTROPY << 3);
+
+static LIST_HEAD(lrng_ready_list);
+static DEFINE_SPINLOCK(lrng_ready_list_lock);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
+static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
+static struct fasync_struct *fasync;
+
+struct ctl_table random_table[];
+
+/********************************** Helper ***********************************/
+
+/* Is the DRNG seed level too low? */
+static inline bool lrng_need_entropy(void)
+{
+	return (lrng_avail_aux_entropy() < lrng_write_wakeup_bits);
+}
+
+void lrng_writer_wakeup(void)
+{
+	if (lrng_need_entropy() && wq_has_sleeper(&lrng_write_wait)) {
+		wake_up_interruptible(&lrng_write_wait);
+		kill_fasync(&fasync, SIGIO, POLL_OUT);
+	}
+}
+
+void lrng_init_wakeup(void)
+{
+	wake_up_all(&lrng_init_wait);
+	kill_fasync(&fasync, SIGIO, POLL_IN);
+}
+
+/**
+ * lrng_process_ready_list() - Ping all kernel internal callers waiting until
+ * the DRNG is completely initialized to inform that the DRNG reached that
+ * seed level.
+ *
+ * When the SP800-90B testing is enabled, the ping only happens if the SP800-90B
+ * startup health tests are completed. This implies that kernel internal
+ * callers always have an SP800-90B compliant noise source when being
+ * pinged.
+ */
+void lrng_process_ready_list(void)
+{
+	unsigned long flags;
+	struct random_ready_callback *rdy, *tmp;
+
+	if (!lrng_state_operational())
+		return;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	list_for_each_entry_safe(rdy, tmp, &lrng_ready_list, list) {
+		struct module *owner = rdy->owner;
+
+		list_del_init(&rdy->list);
+		rdy->func(rdy);
+		module_put(owner);
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+}
+
+void lrng_debug_report_seedlevel(const char *name)
+{
+#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
+	static void *previous = NULL;
+	void *caller = (void *) _RET_IP_;
+
+	if (READ_ONCE(previous) == caller)
+		return;
+
+	if (!lrng_state_min_seeded())
+		pr_notice("%pS %s called without reaching minimally seeded level (available entropy %u)\n",
+			  caller, name, lrng_avail_entropy());
+
+	WRITE_ONCE(previous, caller);
+#endif
+}
+
+/************************ LRNG kernel input interfaces ************************/
+
+/*
+ * add_hwgenerator_randomness() - Interface for in-kernel drivers of true
+ * hardware RNGs.
+ *
+ * Those devices may produce endless random bits and will be throttled
+ * when our pool is full.
+ *
+ * @buffer: buffer holding the entropic data from HW noise sources to be used to
+ *	    insert into entropy pool.
+ * @count: length of buffer
+ * @entropy_bits: amount of entropy in buffer (value is in bits)
+ */
+void add_hwgenerator_randomness(const char *buffer, size_t count,
+				size_t entropy_bits)
+{
+	/*
+	 * Suspend writing if we are fully loaded with entropy.
+	 * We'll be woken up again once below lrng_write_wakeup_thresh,
+	 * or when the calling thread is about to terminate.
+	 */
+	wait_event_interruptible(lrng_write_wait,
+				lrng_need_entropy() ||
+				lrng_state_exseed_allow(lrng_noise_source_hw) ||
+				kthread_should_stop());
+	lrng_state_exseed_set(lrng_noise_source_hw, false);
+	lrng_pool_insert_aux(buffer, count, entropy_bits);
+}
+EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/*
+ * add_bootloader_randomness() - Handle random seed passed by bootloader.
+ *
+ * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
+ * it would be regarded as device data.
+ * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
+ *
+ * @buf: buffer holding the entropic data from HW noise sources to be used to
+ *	 insert into entropy pool.
+ * @size: length of buffer
+ */
+void add_bootloader_randomness(const void *buf, unsigned int size)
+{
+	lrng_pool_insert_aux(buf, size,
+			     IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ?
+			     size * 8 : 0);
+}
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
+/*
+ * Callback for HID layer -- use the HID event values to stir the entropy pool
+ */
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value)
+{
+	static unsigned char last_value;
+
+	/* ignore autorepeat and the like */
+	if (value == last_value)
+		return;
+
+	last_value = value;
+
+	lrng_pcpu_array_add_u32((type << 4) ^ code ^ (code >> 4) ^ value);
+}
+EXPORT_SYMBOL_GPL(add_input_randomness);
+
+/*
+ * add_device_randomness() - Add device- or boot-specific data to the entropy
+ * pool to help initialize it.
+ *
+ * None of this adds any entropy; it is meant to avoid the problem of
+ * the entropy pool having similar initial state across largely
+ * identical devices.
+ *
+ * @buf: buffer holding the entropic data from HW noise sources to be used to
+ *	 insert into entropy pool.
+ * @size: length of buffer
+ */
+void add_device_randomness(const void *buf, unsigned int size)
+{
+	lrng_pool_insert_aux((u8 *)buf, size, 0);
+}
+EXPORT_SYMBOL(add_device_randomness);
+
+#ifdef CONFIG_BLOCK
+void rand_initialize_disk(struct gendisk *disk) { }
+void add_disk_randomness(struct gendisk *disk) { }
+EXPORT_SYMBOL(add_disk_randomness);
+#endif
+
+#ifndef CONFIG_LRNG_IRQ
+void add_interrupt_randomness(int irq, int irq_flg) { }
+EXPORT_SYMBOL(add_interrupt_randomness);
+#endif
+
+/*
+ * del_random_ready_callback() - Delete a previously registered readiness
+ * callback function.
+ *
+ * @rdy: callback definition that was registered initially
+ */
+void del_random_ready_callback(struct random_ready_callback *rdy)
+{
+	unsigned long flags;
+	struct module *owner = NULL;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (!list_empty(&rdy->list)) {
+		list_del_init(&rdy->list);
+		owner = rdy->owner;
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+}
+EXPORT_SYMBOL(del_random_ready_callback);
+
+/*
+ * add_random_ready_callback() - Add a callback function that will be invoked
+ * when the DRNG is fully initialized and seeded.
+ *
+ * @rdy: callback definition to be invoked when the LRNG is seeded
+ *
+ * Return:
+ * * 0 if callback is successfully added
+ * * -EALREADY if pool is already initialised (callback not called)
+ * * -ENOENT if module for callback is not alive
+ */
+int add_random_ready_callback(struct random_ready_callback *rdy)
+{
+	struct module *owner;
+	unsigned long flags;
+	int err = -EALREADY;
+
+	if (likely(lrng_state_operational()))
+		return err;
+
+	owner = rdy->owner;
+	if (!try_module_get(owner))
+		return -ENOENT;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (lrng_state_operational())
+		goto out;
+
+	owner = NULL;
+
+	list_add(&rdy->list, &lrng_ready_list);
+	err = 0;
+
+out:
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+
+	return err;
+}
+EXPORT_SYMBOL(add_random_ready_callback);
+
+/*********************** LRNG kernel output interfaces ************************/
+
+/*
+ * get_random_bytes() - Provider of cryptographic strong random numbers for
+ * kernel-internal usage.
+ *
+ * This function is appropriate for all in-kernel use cases. However,
+ * it will always use the ChaCha20 DRNG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes(void *buf, int nbytes)
+{
+	lrng_drng_get_atomic((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes");
+}
+EXPORT_SYMBOL(get_random_bytes);
+
+/*
+ * get_random_bytes_full() - Provider of cryptographic strong random numbers
+ * for kernel-internal usage.
+ *
+ * This function is appropriate only for non-atomic use cases as this
+ * function may sleep. Though, it provides access to the full functionality
+ * of LRNG including the switchable DRNG support, that may support other
+ * DRNGs such as the SP800-90A DRBG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes_full(void *buf, int nbytes)
+{
+	lrng_drng_get_sleep((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes_full");
+}
+EXPORT_SYMBOL(get_random_bytes_full);
+
+/*
+ * wait_for_random_bytes() - Wait for the LRNG to be seeded and thus
+ * guaranteed to supply cryptographically secure random numbers.
+ *
+ * This applies to: the /dev/urandom device, the get_random_bytes function,
+ * and the get_random_{u32,u64,int,long} family of functions. Using any of
+ * these functions without first calling this function forfeits the guarantee
+ * of security.
+ *
+ * Return:
+ * * 0 if the LRNG has been seeded.
+ * * -ERESTARTSYS if the function was interrupted by a signal.
+ */
+int wait_for_random_bytes(void)
+{
+	if (likely(lrng_state_min_seeded()))
+		return 0;
+	return wait_event_interruptible(lrng_init_wait,
+					lrng_state_min_seeded());
+}
+EXPORT_SYMBOL(wait_for_random_bytes);
+
+/*
+ * get_random_bytes_arch() - This function will use the architecture-specific
+ * hardware random number generator if it is available.
+ *
+ * The arch-specific hw RNG will almost certainly be faster than what we can
+ * do in software, but it is impossible to verify that it is implemented
+ * securely (as opposed, to, say, the AES encryption of a sequence number using
+ * a key known by the NSA).  So it's useful if we need the speed, but only if
+ * we're willing to trust the hardware manufacturer not to have put in a back
+ * door.
+ *
+ * @buf: buffer allocated by caller to store the random data in
+ * @nbytes: length of outbuf
+ *
+ * Return: number of bytes filled in.
+ */
+int __must_check get_random_bytes_arch(void *buf, int nbytes)
+{
+	u8 *p = buf;
+
+	while (nbytes) {
+		unsigned long v;
+		int chunk = min_t(int, nbytes, sizeof(unsigned long));
+
+		if (!arch_get_random_long(&v))
+			break;
+
+		memcpy(p, &v, chunk);
+		p += chunk;
+		nbytes -= chunk;
+	}
+
+	if (nbytes)
+		lrng_drng_get_atomic((u8 *)p, (u32)nbytes);
+
+	return nbytes;
+}
+EXPORT_SYMBOL(get_random_bytes_arch);
+
+/*
+ * Returns whether or not the LRNG has been seeded.
+ *
+ * Returns: true if the urandom pool has been seeded.
+ *          false if the urandom pool has not been seeded.
+ */
+bool rng_is_initialized(void)
+{
+	return lrng_state_operational();
+}
+EXPORT_SYMBOL(rng_is_initialized);
+
+/************************ LRNG user output interfaces *************************/
+
+static ssize_t lrng_read_common(char __user *buf, size_t nbytes)
+{
+	ssize_t ret = 0;
+	u8 tmpbuf[LRNG_DRNG_BLOCKSIZE] __aligned(LRNG_KCAPI_ALIGN);
+	u8 *tmp_large = NULL, *tmp = tmpbuf;
+	u32 tmplen = sizeof(tmpbuf);
+
+	if (nbytes == 0)
+		return 0;
+
+	/*
+	 * Satisfy large read requests -- as the common case are smaller
+	 * request sizes, such as 16 or 32 bytes, avoid a kmalloc overhead for
+	 * those by using the stack variable of tmpbuf.
+	 */
+	if (!CONFIG_BASE_SMALL && (nbytes > sizeof(tmpbuf))) {
+		tmplen = min_t(u32, nbytes, LRNG_DRNG_MAX_REQSIZE);
+		tmp_large = kmalloc(tmplen + LRNG_KCAPI_ALIGN, GFP_KERNEL);
+		if (!tmp_large)
+			tmplen = sizeof(tmpbuf);
+		else
+			tmp = PTR_ALIGN(tmp_large, LRNG_KCAPI_ALIGN);
+	}
+
+	while (nbytes) {
+		u32 todo = min_t(u32, nbytes, tmplen);
+		int rc = 0;
+
+		/* Reschedule if we received a large request. */
+		if ((tmp_large) && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		rc = lrng_drng_get_sleep(tmp, todo);
+		if (rc <= 0) {
+			if (rc < 0)
+				ret = rc;
+			break;
+		}
+		if (copy_to_user(buf, tmp, rc)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		nbytes -= rc;
+		buf += rc;
+		ret += rc;
+	}
+
+	/* Wipe data just returned from memory */
+	if (tmp_large)
+		kfree_sensitive(tmp_large);
+	else
+		memzero_explicit(tmpbuf, sizeof(tmpbuf));
+
+	return ret;
+}
+
+static ssize_t
+lrng_read_common_block(int nonblock, char __user *buf, size_t nbytes)
+{
+	if (nbytes == 0)
+		return 0;
+
+	if (unlikely(!lrng_state_operational())) {
+		int ret;
+
+		if (nonblock)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(lrng_init_wait,
+					       lrng_state_operational());
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return lrng_read_common(buf, nbytes);
+}
+
+static ssize_t lrng_drng_read_block(struct file *file, char __user *buf,
+				     size_t nbytes, loff_t *ppos)
+{
+	return lrng_read_common_block(file->f_flags & O_NONBLOCK, buf, nbytes);
+}
+
+static __poll_t lrng_random_poll(struct file *file, poll_table *wait)
+{
+	__poll_t mask;
+
+	poll_wait(file, &lrng_init_wait, wait);
+	poll_wait(file, &lrng_write_wait, wait);
+	mask = 0;
+	if (lrng_state_operational())
+		mask |= EPOLLIN | EPOLLRDNORM;
+	if (lrng_need_entropy() ||
+	    lrng_state_exseed_allow(lrng_noise_source_user)) {
+		lrng_state_exseed_set(lrng_noise_source_user, false);
+		mask |= EPOLLOUT | EPOLLWRNORM;
+	}
+	return mask;
+}
+
+static ssize_t lrng_drng_write_common(const char __user *buffer, size_t count,
+				      u32 entropy_bits)
+{
+	ssize_t ret = 0;
+	u8 buf[64] __aligned(LRNG_KCAPI_ALIGN);
+	const char __user *p = buffer;
+	u32 orig_entropy_bits = entropy_bits;
+
+	if (!lrng_get_available())
+		return -EAGAIN;
+
+	count = min_t(size_t, count, INT_MAX);
+	while (count > 0) {
+		size_t bytes = min_t(size_t, count, sizeof(buf));
+		u32 ent = min_t(u32, bytes<<3, entropy_bits);
+
+		if (copy_from_user(&buf, p, bytes))
+			return -EFAULT;
+		/* Inject data into entropy pool */
+		lrng_pool_insert_aux(buf, bytes, ent);
+
+		count -= bytes;
+		p += bytes;
+		ret += bytes;
+		entropy_bits -= ent;
+
+		cond_resched();
+	}
+
+	/* Force reseed of DRNG during next data request. */
+	if (!orig_entropy_bits)
+		lrng_drng_force_reseed();
+
+	return ret;
+}
+
+static ssize_t lrng_drng_read(struct file *file, char __user *buf,
+			      size_t nbytes, loff_t *ppos)
+{
+	if (!lrng_state_min_seeded())
+		pr_notice_ratelimited("%s - use of insufficiently seeded DRNG (%zu bytes read)\n",
+				      current->comm, nbytes);
+	else if (!lrng_state_operational())
+		pr_debug_ratelimited("%s - use of not fully seeded DRNG (%zu bytes read)\n",
+				     current->comm, nbytes);
+
+	return lrng_read_common(buf, nbytes);
+}
+
+static ssize_t lrng_drng_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
+{
+	return lrng_drng_write_common(buffer, count, 0);
+}
+
+static long lrng_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	u32 digestsize_bits;
+	int size, ent_count_bits;
+	int __user *p = (int __user *)arg;
+
+	switch (cmd) {
+	case RNDGETENTCNT:
+		ent_count_bits = lrng_avail_entropy();
+		if (put_user(ent_count_bits, p))
+			return -EFAULT;
+		return 0;
+	case RNDADDTOENTCNT:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p))
+			return -EFAULT;
+		ent_count_bits = (int)lrng_avail_aux_entropy() + ent_count_bits;
+		if (ent_count_bits < 0)
+			ent_count_bits = 0;
+		digestsize_bits = lrng_get_digestsize();
+		if (ent_count_bits > digestsize_bits)
+			ent_count_bits = digestsize_bits;
+		lrng_pool_set_entropy(ent_count_bits);
+		return 0;
+	case RNDADDENTROPY:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p++))
+			return -EFAULT;
+		if (ent_count_bits < 0)
+			return -EINVAL;
+		if (get_user(size, p++))
+			return -EFAULT;
+		if (size < 0)
+			return -EINVAL;
+		/* there cannot be more entropy than data */
+		ent_count_bits = min(ent_count_bits, size<<3);
+		return lrng_drng_write_common((const char __user *)p, size,
+					      ent_count_bits);
+	case RNDZAPENTCNT:
+	case RNDCLEARPOOL:
+		/* Clear the entropy pool counter. */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		lrng_pool_set_entropy(0);
+		return 0;
+	case RNDRESEEDCRNG:
+		/*
+		 * We leave the capability check here since it is present
+		 * in the upstream's RNG implementation. Yet, user space
+		 * can trigger a reseed as easy as writing into /dev/random
+		 * or /dev/urandom where no privilege is needed.
+		 */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/* Force a reseed of all DRNGs */
+		lrng_drng_force_reseed();
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lrng_fasync(int fd, struct file *filp, int on)
+{
+	return fasync_helper(fd, filp, on, &fasync);
+}
+
+const struct file_operations random_fops = {
+	.read  = lrng_drng_read_block,
+	.write = lrng_drng_write,
+	.poll  = lrng_random_poll,
+	.unlocked_ioctl = lrng_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.fasync = lrng_fasync,
+	.llseek = noop_llseek,
+};
+
+const struct file_operations urandom_fops = {
+	.read  = lrng_drng_read,
+	.write = lrng_drng_write,
+	.unlocked_ioctl = lrng_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.fasync = lrng_fasync,
+	.llseek = noop_llseek,
+};
+
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
+		unsigned int, flags)
+{
+	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE))
+		return -EINVAL;
+
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags &
+	     (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|GRND_RANDOM))
+		return -EINVAL;
+
+	if (count > INT_MAX)
+		count = INT_MAX;
+
+	if (flags & GRND_INSECURE)
+		return lrng_drng_read(NULL, buf, count, NULL);
+
+	return lrng_read_common_block(flags & GRND_NONBLOCK, buf, count);
+}
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_internal.h
new file mode 100644
index 000000000000..d67aa3c335b9
--- /dev/null
+++ b/drivers/char/lrng/lrng_internal.h
@@ -0,0 +1,485 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#ifndef _LRNG_INTERNAL_H
+#define _LRNG_INTERNAL_H
+
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rwlock.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/*************************** General LRNG parameter ***************************/
+
+/* Security strength of LRNG -- this must match DRNG security strength */
+#define LRNG_DRNG_SECURITY_STRENGTH_BYTES 32
+#define LRNG_DRNG_SECURITY_STRENGTH_BITS (LRNG_DRNG_SECURITY_STRENGTH_BYTES * 8)
+#define LRNG_DRNG_BLOCKSIZE 64		/* Maximum of DRNG block sizes */
+#define LRNG_DRNG_INIT_SEED_SIZE_BITS (LRNG_DRNG_SECURITY_STRENGTH_BITS +      \
+				       CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS)
+#define LRNG_DRNG_INIT_SEED_SIZE_BYTES (LRNG_DRNG_INIT_SEED_SIZE_BITS >> 3)
+
+/*
+ * SP800-90A defines a maximum request size of 1<<16 bytes. The given value is
+ * considered a safer margin.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_MAX_REQSIZE		(1<<12)
+
+/*
+ * SP800-90A defines a maximum number of requests between reseeds of 2^48.
+ * The given value is considered a much safer margin, balancing requests for
+ * frequent reseeds with the need to conserve entropy. This value MUST NOT be
+ * larger than INT_MAX because it is used in an atomic_t.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_RESEED_THRESH		(1<<20)
+
+/*
+ * Maximum DRNG generation operations without reseed having full entropy
+ * This value defines the absolute maximum value of DRNG generation operations
+ * without a reseed holding full entropy. LRNG_DRNG_RESEED_THRESH is the
+ * threshold when a new reseed is attempted. But it is possible that this fails
+ * to deliver full entropy. In this case the DRNG will continue to provide data
+ * even though it was not reseeded with full entropy. To avoid in the extreme
+ * case that no reseed is performed for too long, this threshold is enforced.
+ * If that absolute low value is reached, the LRNG is marked as not operational.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_MAX_WITHOUT_RESEED	(1<<30)
+
+/*
+ * Min required seed entropy is 128 bits covering the minimum entropy
+ * requirement of SP800-131A and the German BSI's TR02102.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_FULL_SEED_ENTROPY_BITS	LRNG_DRNG_SECURITY_STRENGTH_BITS
+#define LRNG_MIN_SEED_ENTROPY_BITS	128
+#define LRNG_INIT_ENTROPY_BITS		32
+
+/*
+ * Wakeup value
+ *
+ * This value is allowed to be changed but must not be larger than the
+ * digest size of the hash operation used update the aux_pool.
+ */
+#ifdef CONFIG_CRYPTO_LIB_SHA256
+# define LRNG_ATOMIC_DIGEST_SIZE	SHA256_DIGEST_SIZE
+#else
+# define LRNG_ATOMIC_DIGEST_SIZE	SHA1_DIGEST_SIZE
+#endif
+#define LRNG_WRITE_WAKEUP_ENTROPY	LRNG_ATOMIC_DIGEST_SIZE
+
+/*
+ * If the switching support is configured, we must provide support up to
+ * the largest digest size. Without switching support, we know it is only
+ * the built-in digest size.
+ */
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+# define LRNG_MAX_DIGESTSIZE		64
+#else
+# define LRNG_MAX_DIGESTSIZE		LRNG_ATOMIC_DIGEST_SIZE
+#endif
+
+/*
+ * Oversampling factor of IRQ events to obtain
+ * LRNG_DRNG_SECURITY_STRENGTH_BYTES. This factor is used when a
+ * high-resolution time stamp is not available. In this case, jiffies and
+ * register contents are used to fill the entropy pool. These noise sources
+ * are much less entropic than the high-resolution timer. The entropy content
+ * is the entropy content assumed with LRNG_IRQ_ENTROPY_BITS divided by
+ * LRNG_IRQ_OVERSAMPLING_FACTOR.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_IRQ_OVERSAMPLING_FACTOR	10
+
+/* Alignmask that is intended to be identical to CRYPTO_MINALIGN */
+#define LRNG_KCAPI_ALIGN		ARCH_KMALLOC_MINALIGN
+
+/*
+ * This definition must provide a buffer that is equal to SHASH_DESC_ON_STACK
+ * as it will be casted into a struct shash_desc.
+ */
+#define LRNG_POOL_SIZE	(sizeof(struct shash_desc) + HASH_MAX_DESCSIZE)
+
+/************************ Default DRNG implementation *************************/
+
+extern struct chacha20_state chacha20;
+extern const struct lrng_crypto_cb lrng_cc20_crypto_cb;
+void lrng_cc20_init_state(struct chacha20_state *state);
+
+/********************************** /proc *************************************/
+
+#ifdef CONFIG_SYSCTL
+void lrng_pool_inc_numa_node(void);
+void lrng_proc_update_max_write_thresh(u32 new_digestsize);
+#else
+static inline void lrng_pool_inc_numa_node(void) { }
+static inline void lrng_proc_update_max_write_thresh(u32 new_digestsize) { }
+#endif
+
+/****************************** LRNG interfaces *******************************/
+
+extern u32 lrng_write_wakeup_bits;
+extern int lrng_drng_reseed_max_time;
+
+void lrng_writer_wakeup(void);
+void lrng_init_wakeup(void);
+void lrng_debug_report_seedlevel(const char *name);
+void lrng_process_ready_list(void);
+
+/* External interface to use of the switchable DRBG inside the kernel */
+void get_random_bytes_full(void *buf, int nbytes);
+
+/************************* Jitter RNG Entropy Source **************************/
+
+#ifdef CONFIG_LRNG_JENT
+u32 lrng_get_jent(u8 *outbuf, u32 requested_bits);
+u32 lrng_jent_entropylevel(u32 requested_bits);
+void lrng_jent_es_state(unsigned char *buf, size_t buflen);
+#else /* CONFIG_LRNG_JENT */
+static inline u32 lrng_get_jent(u8 *outbuf, u32 requested_bits) { return 0; }
+static inline u32 lrng_jent_entropylevel(u32 requested_bits) { return 0; }
+static inline void lrng_jent_es_state(unsigned char *buf, size_t buflen) { }
+#endif /* CONFIG_LRNG_JENT */
+
+/************************** CPU-based Entropy Source **************************/
+
+static inline u32 lrng_fast_noise_entropylevel(u32 ent_bits, u32 requested_bits)
+{
+	/* Obtain entropy statement */
+	ent_bits = ent_bits * requested_bits / LRNG_DRNG_SECURITY_STRENGTH_BITS;
+	/* Cap entropy to buffer size in bits */
+	ent_bits = min_t(u32, ent_bits, requested_bits);
+	return ent_bits;
+}
+
+#ifdef CONFIG_LRNG_CPU
+u32 lrng_get_arch(u8 *outbuf, u32 requested_bits);
+u32 lrng_archrandom_entropylevel(u32 requested_bits);
+void lrng_arch_es_state(unsigned char *buf, size_t buflen);
+#else /* CONFIG_LRNG_CPU */
+static inline u32 lrng_get_arch(u8 *outbuf, u32 requested_bits) { return 0; }
+static inline u32 lrng_archrandom_entropylevel(u32 requested_bits) { return 0; }
+static inline void lrng_arch_es_state(unsigned char *buf, size_t buflen) { }
+#endif /* CONFIG_LRNG_CPU */
+
+/************************** Interrupt Entropy Source **************************/
+
+#ifdef CONFIG_LRNG_IRQ
+void lrng_pcpu_reset(void);
+u32 lrng_pcpu_avail_pool_size(void);
+u32 lrng_pcpu_avail_entropy(void);
+int lrng_pcpu_switch_hash(int node,
+			  const struct lrng_crypto_cb *new_cb, void *new_hash,
+			  const struct lrng_crypto_cb *old_cb);
+u32 lrng_pcpu_pool_hash(u8 *outbuf, u32 requested_bits, bool fully_seeded);
+void lrng_pcpu_array_add_u32(u32 data);
+u32 lrng_gcd_analyze(u32 *history, size_t nelem);
+void lrng_irq_es_state(unsigned char *buf, size_t buflen);
+#else /* CONFIG_LRNG_IRQ */
+static inline void lrng_pcpu_reset(void) { }
+static inline u32 lrng_pcpu_avail_pool_size(void) { return 0; }
+static inline u32 lrng_pcpu_avail_entropy(void) { return 0; }
+static inline int lrng_pcpu_switch_hash(int node,
+			  const struct lrng_crypto_cb *new_cb, void *new_hash,
+			  const struct lrng_crypto_cb *old_cb)
+{
+	return 0;
+}
+static inline u32 lrng_pcpu_pool_hash(u8 *outbuf, u32 requested_bits,
+				      bool fully_seeded)
+{
+	return 0;
+}
+static inline void lrng_pcpu_array_add_u32(u32 data) { }
+static inline void lrng_irq_es_state(unsigned char *buf, size_t buflen) { }
+#endif /* CONFIG_LRNG_IRQ */
+
+/****************************** DRNG processing *******************************/
+
+/* DRNG state handle */
+struct lrng_drng {
+	void *drng;				/* DRNG handle */
+	void *hash;				/* Hash handle */
+	const struct lrng_crypto_cb *crypto_cb;	/* Crypto callbacks */
+	atomic_t requests;			/* Number of DRNG requests */
+	atomic_t requests_since_fully_seeded;	/* Number DRNG requests since
+						   last fully seeded */
+	unsigned long last_seeded;		/* Last time it was seeded */
+	bool fully_seeded;			/* Is DRNG fully seeded? */
+	bool force_reseed;			/* Force a reseed */
+
+	/* Lock write operations on DRNG state, DRNG replacement of crypto_cb */
+	struct mutex lock;
+	spinlock_t spin_lock;
+	/* Lock *hash replacement - always take before DRNG lock */
+	rwlock_t hash_lock;
+};
+
+extern struct mutex lrng_crypto_cb_update;
+
+struct lrng_drng *lrng_drng_init_instance(void);
+struct lrng_drng *lrng_drng_atomic_instance(void);
+
+static __always_inline bool lrng_drng_is_atomic(struct lrng_drng *drng)
+{
+	return (drng->drng == lrng_drng_atomic_instance()->drng);
+}
+
+/* Lock the DRNG */
+static __always_inline void lrng_drng_lock(struct lrng_drng *drng,
+					   unsigned long *flags)
+	__acquires(&drng->spin_lock)
+{
+	/* Use spin lock in case the atomic DRNG context is used */
+	if (lrng_drng_is_atomic(drng)) {
+		spin_lock_irqsave(&drng->spin_lock, *flags);
+
+		/*
+		 * In case a lock transition happened while we were spinning,
+		 * catch this case and use the new lock type.
+		 */
+		if (!lrng_drng_is_atomic(drng)) {
+			spin_unlock_irqrestore(&drng->spin_lock, *flags);
+			__acquire(&drng->spin_lock);
+			mutex_lock(&drng->lock);
+		}
+	} else {
+		__acquire(&drng->spin_lock);
+		mutex_lock(&drng->lock);
+	}
+}
+
+/* Unlock the DRNG */
+static __always_inline void lrng_drng_unlock(struct lrng_drng *drng,
+					     unsigned long *flags)
+	__releases(&drng->spin_lock)
+{
+	if (lrng_drng_is_atomic(drng)) {
+		spin_unlock_irqrestore(&drng->spin_lock, *flags);
+	} else {
+		mutex_unlock(&drng->lock);
+		__release(&drng->spin_lock);
+	}
+}
+
+void lrng_reset(void);
+void lrng_drngs_init_cc20(bool force_seed);
+bool lrng_sp80090c_compliant(void);
+
+static inline u32 lrng_compress_osr(void)
+{
+	return lrng_sp80090c_compliant() ?  CONFIG_LRNG_OVERSAMPLE_ES_BITS : 0;
+}
+
+static inline u32 lrng_reduce_by_osr(u32 entropy_bits)
+{
+	u32 osr_bits = lrng_compress_osr();
+	return (entropy_bits >= osr_bits) ? (entropy_bits - osr_bits) : 0;
+}
+
+bool lrng_get_available(void);
+void lrng_set_available(void);
+void lrng_drng_reset(struct lrng_drng *drng);
+int lrng_drng_get_atomic(u8 *outbuf, u32 outbuflen);
+int lrng_drng_get_sleep(u8 *outbuf, u32 outbuflen);
+void lrng_drng_force_reseed(void);
+void lrng_drng_seed_work(struct work_struct *dummy);
+
+#ifdef CONFIG_NUMA
+struct lrng_drng **lrng_drng_instances(void);
+void lrng_drngs_numa_alloc(void);
+#else	/* CONFIG_NUMA */
+static inline struct lrng_drng **lrng_drng_instances(void) { return NULL; }
+static inline void lrng_drngs_numa_alloc(void) { return; }
+#endif /* CONFIG_NUMA */
+
+/************************* Entropy sources management *************************/
+
+enum lrng_external_noise_source {
+	lrng_noise_source_hw,
+	lrng_noise_source_user
+};
+
+void lrng_set_entropy_thresh(u32 new);
+u32 lrng_avail_entropy(void);
+void lrng_reset_state(void);
+
+bool lrng_state_exseed_allow(enum lrng_external_noise_source source);
+void lrng_state_exseed_set(enum lrng_external_noise_source source, bool type);
+bool lrng_state_min_seeded(void);
+bool lrng_state_fully_seeded(void);
+bool lrng_state_operational(void);
+
+int lrng_pool_trylock(void);
+void lrng_pool_unlock(void);
+void lrng_pool_all_numa_nodes_seeded(bool set);
+void lrng_pool_add_entropy(void);
+
+struct entropy_buf {
+	u8 a[LRNG_DRNG_INIT_SEED_SIZE_BYTES];
+	u8 b[LRNG_DRNG_INIT_SEED_SIZE_BYTES];
+	u8 c[LRNG_DRNG_INIT_SEED_SIZE_BYTES];
+	u8 d[LRNG_DRNG_INIT_SEED_SIZE_BYTES];
+	u32 now, a_bits, b_bits, c_bits, d_bits;
+};
+
+bool lrng_fully_seeded(bool fully_seeded, struct entropy_buf *eb);
+void lrng_unset_fully_seeded(struct lrng_drng *drng);
+void lrng_fill_seed_buffer(struct entropy_buf *entropy_buf, u32 requested_bits);
+void lrng_init_ops(struct entropy_buf *eb);
+
+/*********************** Auxiliary Pool Entropy Source ************************/
+
+u32 lrng_avail_aux_entropy(void);
+void lrng_aux_es_state(unsigned char *buf, size_t buflen);
+u32 lrng_get_digestsize(void);
+void lrng_pool_set_entropy(u32 entropy_bits);
+int lrng_aux_switch_hash(const struct lrng_crypto_cb *new_cb, void *new_hash,
+			 const struct lrng_crypto_cb *old_cb);
+int lrng_pool_insert_aux(const u8 *inbuf, u32 inbuflen, u32 entropy_bits);
+void lrng_get_backtrack_aux(struct entropy_buf *entropy_buf,
+			    u32 requested_bits);
+
+/* Obtain the security strength of the LRNG in bits */
+static inline u32 lrng_security_strength(void)
+{
+	/*
+	 * We use a hash to read the entropy in the entropy pool. According to
+	 * SP800-90B table 1, the entropy can be at most the digest size.
+	 * Considering this together with the last sentence in section 3.1.5.1.2
+	 * the security strength of a (approved) hash is equal to its output
+	 * size. On the other hand the entropy cannot be larger than the
+	 * security strength of the used DRBG.
+	 */
+	return min_t(u32, LRNG_FULL_SEED_ENTROPY_BITS, lrng_get_digestsize());
+}
+
+static inline u32 lrng_get_seed_entropy_osr(bool fully_seeded)
+{
+	u32 requested_bits = lrng_security_strength();
+
+	/* Apply oversampling during initialization according to SP800-90C */
+	if (lrng_sp80090c_compliant() && !fully_seeded)
+		requested_bits += CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS;
+	return requested_bits;
+}
+
+/************************** Health Test linking code **************************/
+
+enum lrng_health_res {
+	lrng_health_pass,		/* Health test passes on time stamp */
+	lrng_health_fail_use,		/* Time stamp unhealthy, but mix in */
+	lrng_health_fail_drop		/* Time stamp unhealthy, drop it */
+};
+
+#ifdef CONFIG_LRNG_HEALTH_TESTS
+bool lrng_sp80090b_startup_complete(void);
+bool lrng_sp80090b_compliant(void);
+
+enum lrng_health_res lrng_health_test(u32 now_time);
+void lrng_health_disable(void);
+
+#else	/* CONFIG_LRNG_HEALTH_TESTS */
+static inline bool lrng_sp80090b_startup_complete(void) { return true; }
+static inline bool lrng_sp80090b_compliant(void) { return false; }
+
+static inline enum lrng_health_res
+lrng_health_test(u32 now_time) { return lrng_health_pass; }
+static inline void lrng_health_disable(void) { }
+#endif	/* CONFIG_LRNG_HEALTH_TESTS */
+
+/****************************** Helper code ***********************************/
+
+static inline u32 atomic_read_u32(atomic_t *v)
+{
+	return (u32)atomic_read(v);
+}
+
+/******************** Crypto Primitive Switching Support **********************/
+
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+static inline void lrng_hash_lock(struct lrng_drng *drng, unsigned long *flags)
+{
+	read_lock_irqsave(&drng->hash_lock, *flags);
+}
+
+static inline void lrng_hash_unlock(struct lrng_drng *drng, unsigned long flags)
+{
+	read_unlock_irqrestore(&drng->hash_lock, flags);
+}
+#else /* CONFIG_LRNG_DRNG_SWITCH */
+static inline void lrng_hash_lock(struct lrng_drng *drng, unsigned long *flags)
+{ }
+
+static inline void lrng_hash_unlock(struct lrng_drng *drng, unsigned long flags)
+{ }
+#endif /* CONFIG_LRNG_DRNG_SWITCH */
+
+/*************************** Auxiliary functions ******************************/
+
+void invalidate_batched_entropy(void);
+
+/***************************** Testing code ***********************************/
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+bool lrng_raw_hires_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+static inline bool lrng_raw_hires_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+bool lrng_raw_jiffies_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+static inline bool lrng_raw_jiffies_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+bool lrng_raw_irq_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+static inline bool lrng_raw_irq_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+bool lrng_raw_irqflags_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+static inline bool lrng_raw_irqflags_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+bool lrng_raw_retip_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_RETIP_ENTROPY */
+static inline bool lrng_raw_retip_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_RETIP_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_REGS_ENTROPY
+bool lrng_raw_regs_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_REGS_ENTROPY */
+static inline bool lrng_raw_regs_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_REGS_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_ARRAY
+bool lrng_raw_array_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_ARRAY */
+static inline bool lrng_raw_array_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_ARRAY */
+
+#ifdef CONFIG_LRNG_IRQ_PERF
+bool lrng_perf_time(u32 start);
+#else /* CONFIG_LRNG_IRQ_PERF */
+static inline bool lrng_perf_time(u32 start) { return false; }
+#endif /*CONFIG_LRNG_IRQ_PERF */
+
+#endif /* _LRNG_INTERNAL_H */
diff --git a/include/linux/lrng.h b/include/linux/lrng.h
new file mode 100644
index 000000000000..3e8f93b53c84
--- /dev/null
+++ b/include/linux/lrng.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#ifndef _LRNG_H
+#define _LRNG_H
+
+#include <crypto/hash.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/*
+ * struct lrng_crypto_cb - cryptographic callback functions
+ * @lrng_drng_name		Name of DRNG
+ * @lrng_hash_name		Name of Hash used for reading entropy pool
+ * @lrng_drng_alloc:		Allocate DRNG -- the provided integer should be
+ *				used for sanity checks.
+ *				return: allocated data structure or PTR_ERR on
+ *					error
+ * @lrng_drng_dealloc:		Deallocate DRNG
+ * @lrng_drng_seed_helper:	Seed the DRNG with data of arbitrary length
+ *				drng: is pointer to data structure allocated
+ *				      with lrng_drng_alloc
+ *				return: >= 0 on success, < 0 on error
+ * @lrng_drng_generate_helper:	Generate random numbers from the DRNG with
+ *				arbitrary length
+ * @lrng_hash_alloc:		Allocate the hash for reading the entropy pool
+ *				return: allocated data structure (NULL is
+ *					success too) or ERR_PTR on error
+ * @lrng_hash_dealloc:		Deallocate Hash
+ * @lrng_hash_digestsize:	Return the digestsize for the used hash to read
+ *				out entropy pool
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: size of digest of hash in bytes
+ * @lrng_hash_init:		Initialize hash
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_update:		Update hash operation
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_final		Final hash operation
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_desc_zero		Zeroization of hash state buffer
+ *
+ * Assumptions:
+ *
+ * 1. Hash operation will not sleep
+ * 2. The hash' volatile state information is provided with *shash by caller.
+ */
+struct lrng_crypto_cb {
+	const char *(*lrng_drng_name)(void);
+	const char *(*lrng_hash_name)(void);
+	void *(*lrng_drng_alloc)(u32 sec_strength);
+	void (*lrng_drng_dealloc)(void *drng);
+	int (*lrng_drng_seed_helper)(void *drng, const u8 *inbuf, u32 inbuflen);
+	int (*lrng_drng_generate_helper)(void *drng, u8 *outbuf, u32 outbuflen);
+	void *(*lrng_hash_alloc)(void);
+	void (*lrng_hash_dealloc)(void *hash);
+	u32 (*lrng_hash_digestsize)(void *hash);
+	int (*lrng_hash_init)(struct shash_desc *shash, void *hash);
+	int (*lrng_hash_update)(struct shash_desc *shash, const u8 *inbuf,
+				u32 inbuflen);
+	int (*lrng_hash_final)(struct shash_desc *shash, u8 *digest);
+	void (*lrng_hash_desc_zero)(struct shash_desc *shash);
+};
+
+/* Register cryptographic backend */
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb);
+#else	/* CONFIG_LRNG_DRNG_SWITCH */
+static inline int
+lrng_set_drng_cb(const struct lrng_crypto_cb *cb) { return -EOPNOTSUPP; }
+#endif	/* CONFIG_LRNG_DRNG_SWITCH */
+
+#endif /* _LRNG_H */
-- 
2.31.1




