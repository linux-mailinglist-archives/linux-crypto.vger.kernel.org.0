Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5D4584DF
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Nov 2021 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhKUQxc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Nov 2021 11:53:32 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:10841 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbhKUQxC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Nov 2021 11:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513321;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Kb/fhfUUNBmMQAjq+fwP/FS7bj/uNZObBjcQ2yLpfKM=;
    b=QXp9Ng6d5LLjnAyjUpsHd8Plp5itRx2X0iCZm76MLgW5Wnccyi9uP1HIeqi6higdm0
    J0HfLhr+UA/ghSgmCN9g/WnsK2N7ZgCYL307p3xVEcVm206M+EOpIygf/29UgIBW3vcL
    rS1SRTw8cke6m84EqyL4x7ijC707VI4pa7bkvy8HY4C/2sN2A35SQ/4KKtWlipFf39gG
    7cGfcHcDOjPPVsqVeZJ6xCZa/jlXkf6AkaJDOLnodfN2NxdZEKgRzhiWk/9F3dyOZpz/
    s4hWUPg3fhya3DCHcT09vbpkyLRb0EpW8bIa7yejxMq6yvlZTmZiRS110FTdwmbldORF
    jvbQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGme3Wm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:40 +0100 (CET)
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
Subject: [PATCH v43 03/15] LRNG - sysctls and /proc interface
Date:   Sun, 21 Nov 2021 17:40:57 +0100
Message-ID: <2386316.XAFRqVoOGU@positron.chronox.de>
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The LRNG sysctl interface provides the same controls as the existing
/dev/random implementation. These sysctls behave identically and are
implemented identically. The goal is to allow a possible merge of the
existing /dev/random implementation with this implementation which
implies that this patch tries have a very close similarity. Yet, all
sysctls are documented at [1].

In addition, it provides the file lrng_type which provides details about
the LRNG:

- the name of the DRNG that produces the random numbers for /dev/random,
/dev/urandom, getrandom(2)

- the hash used to produce random numbers from the entropy pool

- the number of secondary DRNG instances

- indicator whether the LRNG operates SP800-90B compliant

- indicator whether a high-resolution timer is identified - only with a
high-resolution timer the interrupt noise source will deliver sufficient
entropy

- indicator whether the LRNG has been minimally seeded (i.e. is the
secondary DRNG seeded with at least 128 bits of entropy)

- indicator whether the LRNG has been fully seeded (i.e. is the
secondary DRNG seeded with at least 256 bits of entropy)

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
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Makefile          |   1 +
 drivers/char/lrng/lrng_interfaces.c |   2 -
 drivers/char/lrng/lrng_proc.c       | 199 ++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 drivers/char/lrng/lrng_proc.c

diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index d321d6d21a44..d7df72a702e4 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -8,3 +8,4 @@ obj-y				+= lrng_es_mgr.o lrng_aux.o \
 				   lrng_interfaces.o lrng_es_aux.o
 
 obj-$(CONFIG_LRNG_IRQ)		+= lrng_es_irq.o
+obj-$(CONFIG_SYSCTL)		+= lrng_proc.o
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_interfaces.c
index 6316a534bb54..b656aaf0c6cb 100644
--- a/drivers/char/lrng/lrng_interfaces.c
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -38,8 +38,6 @@ static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
 static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
 static struct fasync_struct *fasync;
 
-struct ctl_table random_table[];
-
 /********************************** Helper ***********************************/
 
 /* Is the DRNG seed level too low? */
diff --git a/drivers/char/lrng/lrng_proc.c b/drivers/char/lrng/lrng_proc.c
new file mode 100644
index 000000000000..b48094c32b95
--- /dev/null
+++ b/drivers/char/lrng/lrng_proc.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG proc and sysctl interfaces
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#include <linux/lrng.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/sysctl.h>
+#include <linux/uuid.h>
+
+#include "lrng_internal.h"
+
+/*
+ * This function is used to return both the bootid UUID, and random
+ * UUID.  The difference is in whether table->data is NULL; if it is,
+ * then a new UUID is generated and returned to the user.
+ *
+ * If the user accesses this via the proc interface, the UUID will be
+ * returned as an ASCII string in the standard UUID format; if via the
+ * sysctl system call, as 16 bytes of binary data.
+ */
+static int lrng_proc_do_uuid(struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table fake_table;
+	unsigned char buf[64], tmp_uuid[16], *uuid;
+
+	uuid = table->data;
+	if (!uuid) {
+		uuid = tmp_uuid;
+		generate_random_uuid(uuid);
+	} else {
+		static DEFINE_SPINLOCK(bootid_spinlock);
+
+		spin_lock(&bootid_spinlock);
+		if (!uuid[8])
+			generate_random_uuid(uuid);
+		spin_unlock(&bootid_spinlock);
+	}
+
+	sprintf(buf, "%pU", uuid);
+
+	fake_table.data = buf;
+	fake_table.maxlen = sizeof(buf);
+
+	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_proc_do_entropy(struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table fake_table;
+	int entropy_count;
+
+	entropy_count = lrng_avail_entropy();
+
+	fake_table.data = &entropy_count;
+	fake_table.maxlen = sizeof(entropy_count);
+
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_proc_do_poolsize(struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table fake_table;
+	int entropy_count;
+
+	/* LRNG can at most retain entropy in per-CPU pools and aux pool */
+	entropy_count = lrng_get_digestsize() + lrng_pcpu_avail_pool_size();
+
+	fake_table.data = &entropy_count;
+	fake_table.maxlen = sizeof(entropy_count);
+
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_min_write_thresh;
+static int lrng_max_write_thresh = (LRNG_WRITE_WAKEUP_ENTROPY << 3);
+static char lrng_sysctl_bootid[16];
+static int lrng_drng_reseed_max_min;
+
+void lrng_proc_update_max_write_thresh(u32 new_digestsize)
+{
+	lrng_max_write_thresh = (int)new_digestsize;
+	mb();
+}
+
+struct ctl_table random_table[] = {
+	{
+		.procname	= "poolsize",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_poolsize,
+	},
+	{
+		.procname	= "entropy_avail",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_entropy,
+	},
+	{
+		.procname	= "write_wakeup_threshold",
+		.data		= &lrng_write_wakeup_bits,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &lrng_min_write_thresh,
+		.extra2		= &lrng_max_write_thresh,
+	},
+	{
+		.procname	= "boot_id",
+		.data		= &lrng_sysctl_bootid,
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_uuid,
+	},
+	{
+		.procname	= "uuid",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_uuid,
+	},
+	{
+		.procname       = "urandom_min_reseed_secs",
+		.data           = &lrng_drng_reseed_max_time,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+		.extra1		= &lrng_drng_reseed_max_min,
+	},
+	{ }
+};
+
+/* Number of online DRNGs */
+static u32 numa_drngs = 1;
+
+void lrng_pool_inc_numa_node(void)
+{
+	numa_drngs++;
+}
+
+static int lrng_proc_type_show(struct seq_file *m, void *v)
+{
+	struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+	unsigned long flags = 0;
+	unsigned char buf[250], irq[200], aux[100], cpu[90], jent[45];
+
+	lrng_drng_lock(lrng_drng_init, &flags);
+	snprintf(buf, sizeof(buf),
+		 "DRNG name: %s\n"
+		 "LRNG security strength in bits: %d\n"
+		 "number of DRNG instances: %u\n"
+		 "Standards compliance: %s\n"
+		 "Entropy Sources: %s%s%sAuxiliary\n"
+		 "LRNG minimally seeded: %s\n"
+		 "LRNG fully seeded: %s\n",
+		 lrng_drng_init->crypto_cb->lrng_drng_name(),
+		 lrng_security_strength(),
+		 numa_drngs,
+		 lrng_sp80090c_compliant() ? "SP800-90C " : "",
+		 IS_ENABLED(CONFIG_LRNG_IRQ) ? "IRQ " : "",
+		 IS_ENABLED(CONFIG_LRNG_JENT) ? "JitterRNG " : "",
+		 IS_ENABLED(CONFIG_LRNG_CPU) ? "CPU " : "",
+		 lrng_state_min_seeded() ? "true" : "false",
+		 lrng_state_fully_seeded() ? "true" : "false");
+
+	lrng_aux_es_state(aux, sizeof(aux));
+
+	irq[0] = '\0';
+	lrng_irq_es_state(irq, sizeof(irq));
+
+	jent[0] = '\0';
+	lrng_jent_es_state(jent, sizeof(jent));
+
+	cpu[0] = '\0';
+	lrng_arch_es_state(cpu, sizeof(cpu));
+
+	lrng_drng_unlock(lrng_drng_init, &flags);
+
+	seq_write(m, buf, strlen(buf));
+	seq_write(m, aux, strlen(aux));
+	seq_write(m, irq, strlen(irq));
+	seq_write(m, jent, strlen(jent));
+	seq_write(m, cpu, strlen(cpu));
+
+	return 0;
+}
+
+static int __init lrng_proc_type_init(void)
+{
+	proc_create_single("lrng_type", 0444, NULL, &lrng_proc_type_show);
+	return 0;
+}
+
+module_init(lrng_proc_type_init);
-- 
2.31.1




