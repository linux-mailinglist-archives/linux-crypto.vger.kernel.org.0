Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6378721CFD3
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2020 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgGMGjL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Jul 2020 02:39:11 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:12708 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgGMGjJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Jul 2020 02:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594622344;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=W8XWGywEHjeEqflXCEDqtmVtYoGX8m2qdX4UnTuSI4I=;
        b=AwJa+kgsDK/w6IMC7a1oS7E8XknbGol5YWmvZAsHWSQyFWLuyoNsOAHh9kGkpRltI9
        PxycGy+drj6DETGQBWMGnhKLwyjNtlkO1siidPPMAdruDj20NoLlvffylnDZ+yXH/phw
        /AHpMnhZDTr4RN0HZdUzklqJ0oJgdrBdhcdG0ISIGF9OYk85/frJ+JmOYThMnrkauP4p
        BO+sGW56RwO0n5FyGSafhT1OVCprKOB4x1xDlibc6zC1OxSNIb/zvu64tGA/wyyIOF18
        n+QmmYWyIpg9+t+5qUKuSEm1e6UDDZ9WeIkF09V1RVoQK4Oi2OSYML67PGN4G7A+g535
        1FPw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfHReW"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id y0546bw6D6bwk2Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 13 Jul 2020 08:37:58 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v31 02/12] LRNG - allocate one DRNG instance per NUMA node
Date:   Mon, 13 Jul 2020 08:18:19 +0200
Message-ID: <1742579.atdPhlSkOF@positron.chronox.de>
In-Reply-To: <2050754.Mh6RI2rZIc@positron.chronox.de>
References: <2050754.Mh6RI2rZIc@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In order to improve NUMA-locality when serving getrandom(2) requests,
allocate one DRNG instance per node.

The DRNG instance that is present right from the start of the kernel is
reused as the first per-NUMA-node DRNG. For all remaining online NUMA
nodes a new DRNG instance is allocated.

During boot time, the multiple DRNG instances are seeded sequentially.
With this, the first DRNG instance (referenced as the initial DRNG
in the code) is completely seeded with 256 bits of entropy before the
next DRNG instance is completely seeded.

When random numbers are requested, the NUMA-node-local DRNG is checked
whether it has been already fully seeded. If this is not the case, the
initial DRNG is used to serve the request.

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
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Makefile        |   2 +
 drivers/char/lrng/lrng_internal.h |   5 ++
 drivers/char/lrng/lrng_numa.c     | 101 ++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_numa.c

diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 1d2a0211973d..0a32f22c2c1a 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -7,3 +7,5 @@ obj-y				+=3D lrng_pool.o lrng_aux.o \
 				   lrng_sw_noise.o lrng_archrandom.o \
 				   lrng_drng.o lrng_chacha20.o \
 				   lrng_interfaces.o \
+
+obj-$(CONFIG_NUMA)		+=3D lrng_numa.o
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_int=
ernal.h
index 80cc287fa60f..e82a60a5336d 100644
=2D-- a/drivers/char/lrng/lrng_internal.h
+++ b/drivers/char/lrng/lrng_internal.h
@@ -247,8 +247,13 @@ int lrng_drng_get_sleep(u8 *outbuf, u32 outbuflen);
 void lrng_drng_force_reseed(void);
 void lrng_drng_seed_work(struct work_struct *dummy);
=20
+#ifdef CONFIG_NUMA
+struct lrng_drng **lrng_drng_instances(void);
+void lrng_drngs_numa_alloc(void);
+#else	/* CONFIG_NUMA */
 static inline struct lrng_drng **lrng_drng_instances(void) { return NULL; }
 static inline void lrng_drngs_numa_alloc(void) { return; }
+#endif /* CONFIG_NUMA */
=20
 /************************** Health Test linking code *********************=
*****/
=20
diff --git a/drivers/char/lrng/lrng_numa.c b/drivers/char/lrng/lrng_numa.c
new file mode 100644
index 000000000000..947c5b3ed517
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_numa.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG NUMA support
+ *
+ * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lrng.h>
+#include <linux/slab.h>
+
+#include "lrng_internal.h"
+
+static struct lrng_drng **lrng_drng __read_mostly =3D NULL;
+
+struct lrng_drng **lrng_drng_instances(void)
+{
+	return lrng_drng;
+}
+
+/* Allocate the data structures for the per-NUMA node DRNGs */
+static void _lrng_drngs_numa_alloc(struct work_struct *work)
+{
+	struct lrng_drng **drngs;
+	struct lrng_drng *lrng_drng_init =3D lrng_drng_init_instance();
+	u32 node;
+	bool init_drng_used =3D false;
+
+	mutex_lock(&lrng_crypto_cb_update);
+
+	/* per-NUMA-node DRNGs are already present */
+	if (lrng_drng)
+		goto unlock;
+
+	drngs =3D kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL|__GFP_NOFAIL);
+	for_each_online_node(node) {
+		struct lrng_drng *drng;
+
+		if (!init_drng_used) {
+			drngs[node] =3D lrng_drng_init;
+			init_drng_used =3D true;
+			continue;
+		}
+
+		drng =3D kmalloc_node(sizeof(struct lrng_drng),
+				     GFP_KERNEL|__GFP_NOFAIL, node);
+		memset(drng, 0, sizeof(lrng_drng));
+
+		drng->crypto_cb =3D lrng_drng_init->crypto_cb;
+		drng->drng =3D drng->crypto_cb->lrng_drng_alloc(
+					LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+		if (IS_ERR(drng->drng)) {
+			kfree(drng);
+			goto err;
+		}
+
+		mutex_init(&drng->lock);
+		spin_lock_init(&drng->spin_lock);
+
+		/*
+		 * No reseeding of NUMA DRNGs from previous DRNGs as this
+		 * would complicate the code. Let it simply reseed.
+		 */
+		lrng_drng_reset(drng);
+		drngs[node] =3D drng;
+
+		lrng_pool_inc_numa_node();
+		pr_info("DRNG for NUMA node %d allocated\n", node);
+	}
+
+	/* Ensure that all NUMA nodes receive changed memory here. */
+	mb();
+
+	if (!cmpxchg(&lrng_drng, NULL, drngs))
+		goto unlock;
+
+err:
+	for_each_online_node(node) {
+		struct lrng_drng *drng =3D drngs[node];
+
+		if (drng =3D=3D lrng_drng_init)
+			continue;
+
+		if (drng) {
+			drng->crypto_cb->lrng_drng_dealloc(drng->drng);
+			kfree(drng);
+		}
+	}
+	kfree(drngs);
+
+unlock:
+	mutex_unlock(&lrng_crypto_cb_update);
+}
+
+static DECLARE_WORK(lrng_drngs_numa_alloc_work, _lrng_drngs_numa_alloc);
+
+void lrng_drngs_numa_alloc(void)
+{
+	schedule_work(&lrng_drngs_numa_alloc_work);
+}
=2D-=20
2.26.2




