Return-Path: <linux-crypto+bounces-51-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC37E520B
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Nov 2023 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956191C20AC3
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Nov 2023 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE837DDD9
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Nov 2023 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D9D28A
	for <linux-crypto@vger.kernel.org>; Wed,  8 Nov 2023 07:35:00 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C51706
	for <linux-crypto@vger.kernel.org>; Tue,  7 Nov 2023 23:35:00 -0800 (PST)
X-ASG-Debug-ID: 1699428896-1eb14e538d0c3a0001-Xm9f1P
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id DycMYmagTnaBQwC3 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 08 Nov 2023 15:34:56 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 Nov
 2023 15:34:56 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 Nov
 2023 15:34:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <olivia@selenic.com>, <herbert@gondor.apana.org.au>, <martin@kaiser.cx>,
	<jiajie.ho@starfivetech.com>, <jenny.zhang@starfivetech.com>,
	<mmyangfl@gmail.com>, <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>,
	<LeoLiu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
Date: Wed, 8 Nov 2023 15:34:54 +0800
X-ASG-Orig-Subj: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
Message-ID: <20231108073454.521726-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1699428896
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6875
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116459
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Add support for Zhaoxin hardware random number generator.
This driver base on rep_xstore instruction and uses the same
X86_FEATURE_XSTORE as via-rng driver. Therefore, modify the x86_cpu_id
array in the via-rng driver, so that the corresponding driver can be
correctly loader on respective platforms.

---

v1 -> v2:
1. Fix assembler code errors
2. Remove redundant CPU model check codes

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/char/hw_random/Kconfig       | 13 ++++
 drivers/char/hw_random/Makefile      |  1 +
 drivers/char/hw_random/via-rng.c     | 23 +++----
 drivers/char/hw_random/zhaoxin-rng.c | 95 ++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/hw_random/zhaoxin-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 442c40efb200..eb0e3d64a547 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -152,6 +152,19 @@ config HW_RANDOM_VIA
 
 	  If unsure, say Y.
 
+config HW_RANDOM_ZHAOXIN
+	tristate "Zhaoxin HW Random Number Generator support"
+	depends on X86
+	default HW_RANDOM
+	help
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Zhaoxin based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zhaoxin-rng.
+
+	  If unsure, say Y.
+
 config HW_RANDOM_IXP4XX
 	tristate "Intel IXP4xx NPU HW Pseudo-Random Number Generator support"
 	depends on ARCH_IXP4XX || COMPILE_TEST
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 32549a1186dc..ef5b3ae0794d 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
 obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
 n2-rng-y := n2-drv.o n2-asm.o
 obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
+obj-$(CONFIG_HW_RANDOM_ZHAOXIN) += zhaoxin-rng.o
 obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index a9a0a3b09c8b..6d1312845802 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -35,9 +35,6 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
-
-
-
 enum {
 	VIA_STRFILT_CNT_SHIFT	= 16,
 	VIA_STRFILT_FAIL	= (1 << 15),
@@ -135,7 +132,7 @@ static int via_rng_init(struct hwrng *rng)
 	 * is always enabled if CPUID rng_en is set.  There is no
 	 * RNG configuration like it used to be the case in this
 	 * register */
-	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
+	if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
 		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
 			pr_err(PFX "can't enable hardware RNG "
 				"if XSTORE is not enabled\n");
@@ -191,19 +188,25 @@ static struct hwrng via_rng = {
 	.data_read	= via_rng_data_read,
 };
 
+static const struct x86_cpu_id via_rng_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);
 
 static int __init via_rng_mod_init(void)
 {
 	int err;
 
-	if (!boot_cpu_has(X86_FEATURE_XSTORE))
+	if (!x86_match_cpu(via_rng_cpu_ids)) {
+		pr_err(PFX "The CPU isn't support XSTORE.\n");
 		return -ENODEV;
+	}
 
 	pr_info("VIA RNG detected\n");
 	err = hwrng_register(&via_rng);
 	if (err) {
-		pr_err(PFX "RNG registering failed (%d)\n",
-		       err);
+		pr_err(PFX "RNG registering failed (%d)\n", err);
 		goto out;
 	}
 out:
@@ -217,11 +220,5 @@ static void __exit via_rng_mod_exit(void)
 }
 module_exit(via_rng_mod_exit);
 
-static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
-
 MODULE_DESCRIPTION("H/W RNG driver for VIA CPU with PadLock");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/hw_random/zhaoxin-rng.c b/drivers/char/hw_random/zhaoxin-rng.c
new file mode 100644
index 000000000000..1bd171eebf71
--- /dev/null
+++ b/drivers/char/hw_random/zhaoxin-rng.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RNG driver for Zhaoxin RNGs
+ *
+ * Copyright 2023 (c) Zhaoxin Semiconductor Co., Ltd
+ */
+
+#include <crypto/padlock.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hw_random.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/cpufeature.h>
+#include <asm/cpu_device_id.h>
+#include <asm/fpu/api.h>
+
+enum {
+	ZHAOXIN_RNG_CHUNK_8		= 0x00, /* 64 rand bits, 64 stored bits */
+	ZHAOXIN_RNG_CHUNK_4		= 0x01, /* 32 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_2		= 0x02, /* 16 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_CHUNK_1		= 0x03, /*  8 rand bits, 32 stored bits */
+	ZHAOXIN_RNG_MAX_SIZE	= (128 * 1024),
+};
+
+static int zhaoxin_rng_init(struct hwrng *rng)
+{
+	if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
+		pr_err(PFX "can't enable hardware RNG if XSTORE is not enabled\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static inline int rep_xstore(size_t size, size_t factor, void *result)
+{
+	asm(".byte 0xf3, 0x0f, 0xa7, 0xc0"
+		: "=m"(*(size_t *)result), "+c"(size), "+d"(factor), "+D"(result));
+
+	return 0;
+}
+
+static int zhaoxin_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	if (max > ZHAOXIN_RNG_MAX_SIZE)
+		max = ZHAOXIN_RNG_MAX_SIZE;
+
+	rep_xstore(max, ZHAOXIN_RNG_CHUNK_1, data);
+
+	return max;
+}
+
+static struct hwrng zhaoxin_rng = {
+	.name = "zhaoxin",
+	.init = zhaoxin_rng_init,
+	.read = zhaoxin_rng_read,
+};
+
+static const struct x86_cpu_id zhaoxin_rng_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_XSTORE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_XSTORE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_XSTORE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, zhaoxin_rng_cpu_ids);
+
+static int __init zhaoxin_rng_mod_init(void)
+{
+	int err;
+
+	if (!x86_match_cpu(zhaoxin_rng_cpu_ids)) {
+		pr_err(PFX "The CPU isn't support XSTORE.\n");
+		return -ENODEV;
+	}
+
+	pr_info("Zhaoxin RNG detected\n");
+
+	err = hwrng_register(&zhaoxin_rng);
+	if (err)
+		pr_err(PFX "RNG registering failed (%d)\n", err);
+
+	return err;
+}
+module_init(zhaoxin_rng_mod_init);
+
+static void __exit zhaoxin_rng_mod_exit(void)
+{
+	hwrng_unregister(&zhaoxin_rng);
+}
+module_exit(zhaoxin_rng_mod_exit);
+
+MODULE_DESCRIPTION("H/W RNG driver for Zhaoxin CPUs");
+MODULE_AUTHOR("YunShen@zhaoxin.com");
+MODULE_LICENSE("GPL");
-- 
2.34.1


