Return-Path: <linux-crypto+bounces-948-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19481AEB7
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Dec 2023 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CC1C22FF3
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Dec 2023 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDDB654;
	Thu, 21 Dec 2023 06:21:45 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD203B647
	for <linux-crypto@vger.kernel.org>; Thu, 21 Dec 2023 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1703139686-086e237568044e0001-Xm9f1P
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id kqWSCeADc2WC5adC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 21 Dec 2023 14:21:26 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 14:21:26 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 14:21:24 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <pbonzini@redhat.com>,
	<babu.moger@amd.com>, <jiaxi.chen@linux.intel.com>, <jmattson@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>,
	<Leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v4] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
Date: Thu, 21 Dec 2023 14:21:23 +0800
X-ASG-Orig-Subj: [PATCH v4] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
Message-ID: <20231221062123.798957-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1703139686
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6989
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118357
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Add support for SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI
Instruction. The purpose of this driver is to ensure that the application
has both high performance and high security.
---
 arch/x86/crypto/Kconfig            |  10 ++
 arch/x86/crypto/Makefile           |   2 +
 arch/x86/crypto/sm2-zhaoxin-gmi.c  | 160 +++++++++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h |   2 +
 4 files changed, 174 insertions(+)
 create mode 100644 arch/x86/crypto/sm2-zhaoxin-gmi.c

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 9bbfd01cfa2f..b168596924e6 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -519,4 +519,14 @@ config CRYPTO_CRCT10DIF_PCLMUL
 	  Architecture: x86_64 using:
 	  - PCLMULQDQ (carry-less multiplication)
 
+config CRYPTO_SM2_ZHAOXIN_GMI
+	tristate "SM2 Cipher algorithm (Zhaoxin GMI Instruction)"
+	depends on X86 && (CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN)
+	select CRYPTO_AKCIPHER
+	help
+	  SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI Instruction
+
+	  Published by State Encryption Management Bureau, China,
+	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
+
 endmenu
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 9aa46093c91b..f1d64ff7b907 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -109,6 +109,8 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
 obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
 aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
 
+obj-$(CONFIG_CRYPTO_SM2_ZHAOXIN_GMI) += sm2-zhaoxin-gmi.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 $(obj)/%.S: $(src)/%.pl FORCE
diff --git a/arch/x86/crypto/sm2-zhaoxin-gmi.c b/arch/x86/crypto/sm2-zhaoxin-gmi.c
new file mode 100644
index 000000000000..dbf2f701b832
--- /dev/null
+++ b/arch/x86/crypto/sm2-zhaoxin-gmi.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SM2 asymmetric public-key algorithm
+ * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
+ * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+ *
+ * Copyright (c) 2023 Shanghai Zhaoxin Semiconductor LTD.
+ * Authors: YunShen <yunshen@zhaoxin.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mpi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/akcipher.h>
+#include <crypto/sm2.h>
+#include <asm/cpufeature.h>
+#include <asm/processor.h>
+#include <asm/cpu_device_id.h>
+
+#define SCRATCH_SIZE (4 * 2048)
+
+#define SM2_CWORD_VERIFY 0x8
+#define SM2_VERIFY_PASS 1
+
+struct sm2_cipher_data {
+	u8 pub_key[65]; /* public key */
+};
+
+/* Load supported features of the CPU to see if the SM2 is available. */
+static int zhaoxin_gmi_available(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SM2_EN)) {
+		pr_err("can't enable hardware SM2 if Zhaoxin GMI SM2 is not enabled\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+/* Zhaoxin sm2 verify function */
+static inline size_t zhaoxin_gmi_sm2_verify(unsigned char *key, unsigned char *hash,
+				unsigned char *sig, unsigned char *scratch)
+{
+	size_t result;
+
+	asm volatile(
+		".byte 0xf2, 0x0f, 0xa6, 0xc0"
+		: "=c"(result)
+		: "a"(hash), "b"(key), "d"(SM2_CWORD_VERIFY), "S"(scratch), "D"(sig)
+		: "memory");
+
+	return result;
+}
+
+/* Zhaoxin sm2 verify function */
+static int _zhaoxin_sm2_verify(struct sm2_cipher_data *ec, unsigned char *hash, unsigned char *sig)
+{
+	unsigned char *scratch = kzalloc(SCRATCH_SIZE, GFP_KERNEL);
+	int ret = -EKEYREJECTED;
+	size_t result;
+
+	result = zhaoxin_gmi_sm2_verify(ec->pub_key, hash, sig, scratch);
+	if (result == SM2_VERIFY_PASS)
+		ret = 0;
+
+	kfree(scratch);
+
+	return ret;
+}
+
+static int zhaoxin_sm2_verify(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
+	unsigned char *buffer;
+	unsigned int buf_len;
+	int ret;
+
+	buf_len = req->src_len + req->dst_len;
+	buffer = kmalloc(buf_len, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	sg_pcopy_to_buffer(req->src, sg_nents_for_len(req->src, (u64)buf_len), buffer,
+			(size_t)buf_len, 0);
+	ret = _zhaoxin_sm2_verify(ec, buffer + req->src_len, buffer);
+
+	kfree(buffer);
+
+	return ret;
+}
+
+static int zhaoxin_sm2_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+				unsigned int keylen)
+{
+	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
+
+	memcpy(ec->pub_key, key, keylen);
+
+	return 0;
+}
+
+static unsigned int zhaoxin_sm2_max_size(struct crypto_akcipher *tfm)
+{
+	/* Unlimited max size */
+	return PAGE_SIZE;
+}
+
+static int zhaoxin_sm2_init_tfm(struct crypto_akcipher *tfm)
+{
+	return zhaoxin_gmi_available();
+}
+
+static void zhaoxin_sm2_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
+
+	memset(ec, 0, sizeof(*ec));
+}
+
+static struct akcipher_alg zhaoxin_sm2 = {
+	.verify = zhaoxin_sm2_verify,
+	.set_pub_key = zhaoxin_sm2_set_pub_key,
+	.max_size = zhaoxin_sm2_max_size,
+	.init = zhaoxin_sm2_init_tfm,
+	.exit = zhaoxin_sm2_exit_tfm,
+	.base = {
+		.cra_name = "sm2",
+		.cra_driver_name = "zhaoxin-gmi-sm2",
+		.cra_priority = 150,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct sm2_cipher_data),
+	},
+};
+
+static const struct x86_cpu_id zhaoxin_sm2_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SM2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, zhaoxin_sm2_cpu_ids);
+
+static int __init zhaoxin_sm2_init(void)
+{
+	if (!x86_match_cpu(zhaoxin_sm2_cpu_ids))
+		return -ENODEV;
+
+	return crypto_register_akcipher(&zhaoxin_sm2);
+}
+
+static void __exit zhaoxin_sm2_exit(void)
+{
+	crypto_unregister_akcipher(&zhaoxin_sm2);
+}
+
+module_init(zhaoxin_sm2_init);
+module_exit(zhaoxin_sm2_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("YunShen <yunshen@zhaoxin.com>");
+MODULE_DESCRIPTION("SM2 Zhaoxin GMI Algorithm");
+MODULE_ALIAS_CRYPTO("zhaoxin-gmi-sm2");
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4af140cf5719..07a78ec83bed 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -146,6 +146,8 @@
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			(5*32 + 0) /* SM2 ZhaoXin GMI present */
+#define X86_FEATURE_SM2_EN			(5*32 + 1) /* SM2 ZhaoXin GMI enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
-- 
2.34.1


