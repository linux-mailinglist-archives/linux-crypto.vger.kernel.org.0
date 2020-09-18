Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070B226FA0E
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgIRKMS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 06:12:18 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:14261 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRKMP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 06:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600423931;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Udo8lC3v/hNITSg2eIyB+nDFhA5/Y55ZakSlnT1TN24=;
        b=gKRR4te2EK01VImNxLFgi7LRXj5lQLE2IEuUxh0MS4YFOC7b9RCZXFF1FmjVBAsEAZ
        7/CpBZGX+OqZ7auEU2uPmczFFjxdxReiuSxLCX5ISkjImf03fJgGeWZJIZG1sVNdVagR
        k6Y5vymss64XCKL2yQJB+CMuM8QuTC92AnQ9Qxl5EP62ZfpXeYSDn0CdBPwUbIsSsj9S
        r/TPnZ/vTWrGwZ//l3z2TuMtK1PJYY90b6xxkGqBunYH3E9ohkjfBq2cT0XXAIroWERg
        WEQuqH4QqC6O0Sngwty36Vc+KHeLWl0ZOnfL4ER850b3Eq/cN01ml4x7IzO2feCuGPdr
        68AA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJPScXyVH"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw8IA082T3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 18 Sep 2020 12:00:08 +0200 (CEST)
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
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>, ebiggers@kernel.org
Subject: [PATCH v35 10/13] LRNG - add Jitter RNG fast noise source
Date:   Fri, 18 Sep 2020 11:51:50 +0200
Message-ID: <3034413.5fSG56mABF@positron.chronox.de>
In-Reply-To: <5667034.lOV4Wx5bFT@positron.chronox.de>
References: <2544450.mvXUDI8C0e@positron.chronox.de> <5532247.MhkbZ0Pkbq@positron.chronox.de> <5667034.lOV4Wx5bFT@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The Jitter RNG fast noise source implemented as part of the kernel
crypto API is queried for 256 bits of entropy at the time the seed
buffer managed by the LRNG is about to be filled.

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
 drivers/char/lrng/Kconfig     | 12 +++++
 drivers/char/lrng/Makefile    |  1 +
 drivers/char/lrng/lrng_jent.c | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_jent.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index af487b3391e0..87682f57efb8 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -106,4 +106,16 @@ config LRNG_KCAPI
 	  provided by the selected kernel crypto API RNG.
 endif # LRNG_DRNG_SWITCH
=20
+config LRNG_JENT
+	bool "Enable Jitter RNG as LRNG Seed Source"
+	depends on CRYPTO
+	select CRYPTO_JITTERENTROPY
+	help
+	  The Linux RNG may use the Jitter RNG as noise source. Enabling
+	  this option enables the use of the Jitter RNG. Its default
+	  entropy level is 16 bits of entropy per 256 data bits delivered
+	  by the Jitter RNG. This entropy level can be changed at boot
+	  time or at runtime with the lrng_base.jitterrng configuration
+	  variable.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 97d2b13d3227..6be88156010a 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_KCAPI_HASH)	+=3D lrng_kcapi_hash.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
+obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jent.c
new file mode 100644
index 000000000000..225505271fcb
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_jent.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Fast Noise Source: Jitter RNG
+ *
+ * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/types.h>
+#include <crypto/internal/jitterentropy.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Estimated entropy of data is a 16th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ * Albeit a full entropy assessment is provided for the noise source indic=
ating
+ * that it provides high entropy rates and considering that it deactivates
+ * when it detects insufficient hardware, the chosen under estimation of
+ * entropy is considered to be acceptable to all reviewers.
+ */
+static u32 jitterrng =3D LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
+module_param(jitterrng, uint, 0644);
+MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from Jitter =
RNG noise source");
+
+/**
+ * lrng_get_jent() - Get Jitter RNG entropy
+ *
+ * @outbuf: buffer to store entropy
+ * @outbuflen: length of buffer
+ *
+ * Return:
+ * * > 0 on success where value provides the added entropy in bits
+ * * 0 if no fast source was available
+ */
+static struct rand_data *lrng_jent_state;
+
+u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
+{
+	int ret;
+	u32 ent_bits =3D jitterrng;
+	unsigned long flags;
+	static DEFINE_SPINLOCK(lrng_jent_lock);
+	static int lrng_jent_initialized =3D 0;
+
+	spin_lock_irqsave(&lrng_jent_lock, flags);
+
+	if (!ent_bits || (lrng_jent_initialized =3D=3D -1)) {
+		spin_unlock_irqrestore(&lrng_jent_lock, flags);
+		return 0;
+	}
+
+	if (!lrng_jent_initialized) {
+		lrng_jent_state =3D jent_lrng_entropy_collector();
+		if (!lrng_jent_state) {
+			jitterrng =3D 0;
+			lrng_jent_initialized =3D -1;
+			spin_unlock_irqrestore(&lrng_jent_lock, flags);
+			pr_info("Jitter RNG unusable on current system\n");
+			return 0;
+		}
+		lrng_jent_initialized =3D 1;
+		pr_debug("Jitter RNG working on current system\n");
+	}
+	ret =3D jent_read_entropy(lrng_jent_state, outbuf, outbuflen);
+	spin_unlock_irqrestore(&lrng_jent_lock, flags);
+
+	if (ret) {
+		pr_debug("Jitter RNG failed with %d\n", ret);
+		return 0;
+	}
+
+	/* Obtain entropy statement */
+	if (outbuflen !=3D LRNG_DRNG_SECURITY_STRENGTH_BYTES)
+		ent_bits =3D (ent_bits * outbuflen<<3) /
+			   LRNG_DRNG_SECURITY_STRENGTH_BITS;
+	/* Cap entropy to buffer size in bits */
+	ent_bits =3D min_t(u32, ent_bits, outbuflen<<3);
+	pr_debug("obtained %u bits of entropy from Jitter RNG noise source\n",
+		 ent_bits);
+
+	return ent_bits;
+}
+
+u32 lrng_jent_entropylevel(void)
+{
+	return min_t(u32, jitterrng, LRNG_DRNG_SECURITY_STRENGTH_BITS);
+}
=2D-=20
2.26.2




