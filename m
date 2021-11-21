Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703244584D3
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Nov 2021 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhKUQxG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Nov 2021 11:53:06 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.178]:33816 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbhKUQwz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Nov 2021 11:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513317;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R/qN8ZJhYSbGmxPnkIQFfUc6pPA6Du/OhZt/p+rVCWU=;
    b=iUoKImdUcSES92a/tcAU+0Usp7CPXiBf04emTKu+qLu21h/qNnN3wg9R/QmAPKMx/R
    X553JWP8DGWvEiG/ja/Ut/cwTIqIAUZZ6Viw+YzIauSRcnM7BAW/yFYrWMFIJnE7SGa1
    GwPz8s+99hrf324zIjdfDd5rGMTZE/Rm6mITyEO5hOJRVHpc0q7fwl9olvOwfZyZQrpz
    wd9vUQUycum3xNcNr69WWaIu2iF27wjBPAXJzJ6f55qC0k2IKIj3E5/6IKD68PKRbhaF
    K8fJx6iMp43VuX5LupysOIKE+hm2Y73fthZqS8gl1T6J9WhqlyYJGeknrzNbcHf3ipDi
    QVyw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGma3Wj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:36 +0100 (CET)
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
Subject: [PATCH v43 06/15] LRNG - add switchable DRNG support
Date:   Sun, 21 Nov 2021 17:42:41 +0100
Message-ID: <20730758.4csPzL39Zc@positron.chronox.de>
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The DRNG switch support allows replacing the DRNG mechanism of the
LRNG. The switching support rests on the interface definition of
include/linux/lrng.h. A new DRNG is implemented by filling in the
interface defined in this header file.

In addition to the DRNG, the extension also has to provide a hash
implementation that is used to hash the entropy pool for random number
extraction.

Note: It is permissible to implement a DRNG whose operations may sleep.
However, the hash function must not sleep.

The switchable DRNG support allows replacing the DRNG at runtime.
However, only one DRNG extension is allowed to be loaded at any given
time. Before replacing it with another DRNG implementation, the possibly
existing DRNG extension must be unloaded.

The switchable DRNG extension activates the new DRNG during load time.
It is expected, however, that such a DRNG switch would be done only once
by an administrator to load the intended DRNG implementation.

It is permissible to compile DRNG extensions either as kernel modules or
statically. The initialization of the DRNG extension should be performed
with a late_initcall to ensure the extension is available when user
space starts but after all other initialization completed.
The initialization is performed by registering the function call data
structure with the lrng_set_drng_cb function. In order to unload the
DRNG extension, lrng_set_drng_cb must be invoked with the NULL
parameter.

The DRNG extension should always provide a security strength that is at
least as strong as LRNG_DRNG_SECURITY_STRENGTH_BITS.

The hash extension must not sleep and must not maintain a separate
state.

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
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig       |   7 +
 drivers/char/lrng/Makefile      |   1 +
 drivers/char/lrng/lrng_switch.c | 226 ++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_switch.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index d3abdfa28493..9fea73b72f88 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -255,4 +255,11 @@ config LRNG_CPU_ENTROPY_RATE
 
 endmenu # "Entropy Source Configuration"
 
+menuconfig LRNG_DRNG_SWITCH
+	bool "Support DRNG runtime switching"
+	help
+	  The Linux RNG per default uses a ChaCha20 DRNG that is
+	  accessible via the external interfaces. With this configuration
+	  option other DRNGs can be selected and loaded at runtime.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 1e18e2c1016b..2202aa78b63f 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_LRNG_IRQ)		+= lrng_es_irq.o
 obj-$(CONFIG_SYSCTL)		+= lrng_proc.o
 obj-$(CONFIG_NUMA)		+= lrng_numa.o
 obj-$(CONFIG_LRNG_CPU)		+= lrng_es_archrandom.o
+obj-$(CONFIG_LRNG_DRNG_SWITCH)	+= lrng_switch.o
diff --git a/drivers/char/lrng/lrng_switch.c b/drivers/char/lrng/lrng_switch.c
new file mode 100644
index 000000000000..5fce40149911
--- /dev/null
+++ b/drivers/char/lrng/lrng_switch.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG DRNG switching support
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
+static int lrng_drng_switch(struct lrng_drng *drng_store,
+			    const struct lrng_crypto_cb *cb, int node)
+{
+	const struct lrng_crypto_cb *old_cb;
+	unsigned long flags = 0, flags2 = 0;
+	int ret;
+	u8 seed[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	void *new_drng = cb->lrng_drng_alloc(LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+	void *old_drng, *new_hash, *old_hash;
+	u32 current_security_strength;
+	bool sl = false, reset_drng = !lrng_get_available();
+
+	if (IS_ERR(new_drng)) {
+		pr_warn("could not allocate new DRNG for NUMA node %d (%ld)\n",
+			node, PTR_ERR(new_drng));
+		return PTR_ERR(new_drng);
+	}
+
+	new_hash = cb->lrng_hash_alloc();
+	if (IS_ERR(new_hash)) {
+		pr_warn("could not allocate new LRNG pool hash (%ld)\n",
+			PTR_ERR(new_hash));
+		cb->lrng_drng_dealloc(new_drng);
+		return PTR_ERR(new_hash);
+	}
+
+	if (cb->lrng_hash_digestsize(new_hash) > LRNG_MAX_DIGESTSIZE) {
+		pr_warn("digest size of newly requested hash too large\n");
+		cb->lrng_hash_dealloc(new_hash);
+		cb->lrng_drng_dealloc(new_drng);
+		return -EINVAL;
+	}
+
+	current_security_strength = lrng_security_strength();
+	lrng_drng_lock(drng_store, &flags);
+
+	/*
+	 * Pull from existing DRNG to seed new DRNG regardless of seed status
+	 * of old DRNG -- the entropy state for the DRNG is left unchanged which
+	 * implies that als the new DRNG is reseeded when deemed necessary. This
+	 * seeding of the new DRNG shall only ensure that the new DRNG has the
+	 * same entropy as the old DRNG.
+	 */
+	ret = drng_store->crypto_cb->lrng_drng_generate_helper(
+				drng_store->drng, seed, sizeof(seed));
+	lrng_drng_unlock(drng_store, &flags);
+
+	if (ret < 0) {
+		reset_drng = true;
+		pr_warn("getting random data from DRNG failed for NUMA node %d (%d)\n",
+			node, ret);
+	} else {
+		/* seed new DRNG with data */
+		ret = cb->lrng_drng_seed_helper(new_drng, seed, ret);
+		memzero_explicit(seed, sizeof(seed));
+		if (ret < 0) {
+			reset_drng = true;
+			pr_warn("seeding of new DRNG failed for NUMA node %d (%d)\n",
+				node, ret);
+		} else {
+			pr_debug("seeded new DRNG of NUMA node %d instance from old DRNG instance\n",
+				 node);
+		}
+	}
+
+	mutex_lock(&drng_store->lock);
+	write_lock_irqsave(&drng_store->hash_lock, flags2);
+	/*
+	 * If we switch the DRNG from the initial ChaCha20 DRNG to something
+	 * else, there is a lock transition from spin lock to mutex (see
+	 * lrng_drng_is_atomic and how the lock is taken in lrng_drng_lock).
+	 * Thus, we need to take both locks during the transition phase.
+	 */
+	if (lrng_drng_is_atomic(drng_store)) {
+		spin_lock_irqsave(&drng_store->spin_lock, flags);
+		sl = true;
+	} else {
+		__acquire(&drng_store->spin_lock);
+	}
+
+	/* Trigger the switch of the aux entropy pool for current node. */
+	if (drng_store == lrng_drng_init_instance()) {
+		ret = lrng_aux_switch_hash(cb, new_hash, drng_store->crypto_cb);
+		if (ret)
+			goto err;
+	}
+
+	/* Trigger the switch of the per-CPU entropy pools for current node. */
+	ret = lrng_pcpu_switch_hash(node, cb, new_hash, drng_store->crypto_cb);
+	if (ret) {
+		/* Switch the crypto operation back to be consistent */
+		WARN_ON(lrng_aux_switch_hash(drng_store->crypto_cb,
+					     drng_store->hash, cb));
+	} else {
+		if (reset_drng)
+			lrng_drng_reset(drng_store);
+
+		old_drng = drng_store->drng;
+		old_cb = drng_store->crypto_cb;
+		drng_store->drng = new_drng;
+		drng_store->crypto_cb = cb;
+
+		old_hash = drng_store->hash;
+		drng_store->hash = new_hash;
+		pr_info("Entropy pool read-hash allocated for DRNG for NUMA node %d\n",
+			node);
+
+		/* Reseed if previous LRNG security strength was insufficient */
+		if (current_security_strength < lrng_security_strength())
+			drng_store->force_reseed = true;
+
+		/* Force oversampling seeding as we initialize DRNG */
+		if (IS_ENABLED(CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES))
+			lrng_unset_fully_seeded(drng_store);
+
+		if (lrng_state_min_seeded())
+			lrng_set_entropy_thresh(lrng_get_seed_entropy_osr(
+						drng_store->fully_seeded));
+
+		/* ChaCha20 serves as atomic instance left untouched. */
+		if (old_drng != &chacha20) {
+			old_cb->lrng_drng_dealloc(old_drng);
+			old_cb->lrng_hash_dealloc(old_hash);
+		}
+
+		pr_info("DRNG of NUMA node %d switched\n", node);
+	}
+
+err:
+	if (sl)
+		spin_unlock_irqrestore(&drng_store->spin_lock, flags);
+	else
+		__release(&drng_store->spin_lock);
+	write_unlock_irqrestore(&drng_store->hash_lock, flags2);
+	mutex_unlock(&drng_store->lock);
+
+	return ret;
+}
+
+/*
+ * Switch the existing DRNG instances with new using the new crypto callbacks.
+ * The caller must hold the lrng_crypto_cb_update lock.
+ */
+static int lrng_drngs_switch(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_drng **lrng_drng = lrng_drng_instances();
+	struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+	int ret = 0;
+
+	/* Update DRNG */
+	if (lrng_drng) {
+		u32 node;
+
+		for_each_online_node(node) {
+			if (lrng_drng[node])
+				ret = lrng_drng_switch(lrng_drng[node], cb,
+						       node);
+		}
+	} else {
+		ret = lrng_drng_switch(lrng_drng_init, cb, 0);
+	}
+
+	if (!ret)
+		lrng_set_available();
+
+	return 0;
+}
+
+/*
+ * lrng_set_drng_cb - Register new cryptographic callback functions for DRNG
+ * The registering implies that all old DRNG states are replaced with new
+ * DRNG states.
+ *
+ * @cb: Callback functions to be registered -- if NULL, use the default
+ *	callbacks pointing to the ChaCha20 DRNG.
+ *
+ * Return:
+ * * 0 on success
+ * * < 0 on error
+ */
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+	int ret;
+
+	if (!cb)
+		cb = &lrng_cc20_crypto_cb;
+
+	mutex_lock(&lrng_crypto_cb_update);
+
+	/*
+	 * If a callback other than the default is set, allow it only to be
+	 * set back to the default callback. This ensures that multiple
+	 * different callbacks can be registered at the same time. If a
+	 * callback different from the current callback and the default
+	 * callback shall be set, the current callback must be deregistered
+	 * (e.g. the kernel module providing it must be unloaded) and the new
+	 * implementation can be registered.
+	 */
+	if ((cb != &lrng_cc20_crypto_cb) &&
+	    (lrng_drng_init->crypto_cb != &lrng_cc20_crypto_cb)) {
+		pr_warn("disallow setting new cipher callbacks, unload the old callbacks first!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = lrng_drngs_switch(cb);
+
+out:
+	mutex_unlock(&lrng_crypto_cb_update);
+	return ret;
+}
+EXPORT_SYMBOL(lrng_set_drng_cb);
-- 
2.31.1




