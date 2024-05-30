Return-Path: <linux-crypto+bounces-4527-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60748D4B97
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3432DB225AC
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2024 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539A13213E;
	Thu, 30 May 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ozxdcjL4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4713212C;
	Thu, 30 May 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071925; cv=none; b=G4WFmUcdGLIIBcCy4dpHgWzIGDBWakIpN4mnDMcEki5aX5uqy6WAU1VfKurGOmQDHyO7DOhoju46cDXxlinELlRZenGhZRa6NYQVKufQ0+WLg7y2tShctTBpeqGXSLCWlTTfyzBJ0So+lx0Spt6SvtXQ1aD3B0xYR5bAZf76Fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071925; c=relaxed/simple;
	bh=pawKyIUgyhAicTXDCKFAYSVB9rffockciMu5An0WLYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1mQCqkRKDSUNf5gqP5RU2luPwZGPSMRC/jz4xCIemM6Zl+mOImOtOenVefivnDIb5gO5fDWwaJMruCfU4S6zu56ShgM6iLfn9WmV585i5g5n3OPA7crc2Ucecl/YOkhmkOVnkvsfdwINmf9EGTVvz5jJX+sNbsG6CxpyW5g4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ozxdcjL4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UCOj0e097823;
	Thu, 30 May 2024 07:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717071885;
	bh=GVhylKWTFUhHVDQ+dYT40iN8UHVVdQwcs6myHVRMYro=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ozxdcjL4X7rVBM4WmVy4eeG10wXla74U1zpCNqXB/0XS7kn/duvm8R+heeL2d2e9L
	 +S2Ur4p0h0DhJmI3OmsnNa14GpK3orbFUAv1wtdJ/11/qv7OJvJsWA1Uj+IUUiQ9B/
	 xOEHTt/OwbeJXLKuD8Gkl0nXcYlR84vGbkO583Zw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UCOj8s031310
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 07:24:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 07:24:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 07:24:45 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UCOixF114757;
	Thu, 30 May 2024 07:24:45 -0500
From: <kamlesh@ti.com>
To: <herbert@gondor.apana.org.au>, <kristo@kernel.org>, <will@kernel.org>
CC: <akpm@linux-foundation.org>, <davem@davemloft.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Kamlesh
 Gurudasani <kamlesh@ti.com>
Subject: [PATCH v3 2/6] crypto: crc64 - add crc64-iso3309 framework
Date: Thu, 30 May 2024 17:54:24 +0530
Message-ID: <20240524-mcrc64-upstream-v3-2-24b94d8e8578@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524-mcrc64-upstream-v3-0-24b94d8e8578@ti.com>
References: <20240524-mcrc64-upstream-v3-0-24b94d8e8578@ti.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Kamlesh Gurudasani <kamlesh@ti.com>

Hardware specific features may be able to calculate a crc64-iso3309,
so provide a framework for drivers to register their implementation.
If nothing is registered, fallback to the generic table lookup
implementation. The implementation is modeled after the crc64-rocksoft
equivalent.

Add testmgr, tcrypt tests and vectors for 64-bit cyclic
redundancy checks (CRC) according to the ISO 3309 standard.

The ISO 3309 64-bit CRC model parameters are as follows:
    Generator Polynomial: x^64 + x^4 + x^3 + x + 1
    Polynomial Value: 0x000000000000001B
    Initial value: 0x0000000000000000
    Reflected Input: False
    Reflected Output: False
    Xor Final: 0x0000000000000000

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 crypto/Kconfig                 |  11 +++
 crypto/Makefile                |   1 +
 crypto/crc64_iso3309_generic.c | 119 +++++++++++++++++++++++++++
 crypto/tcrypt.c                |   6 ++
 crypto/testmgr.c               |   7 ++
 crypto/testmgr.h               | 404 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/crc64.h          |   1 +
 7 files changed, 549 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5688d42a59c2..125cc88805ae 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1124,6 +1124,17 @@ config CRYPTO_CRCT10DIF
 
 	  CRC algorithm used by the SCSI Block Commands standard.
 
+config CRYPTO_CRC64_ISO3309
+	tristate "CRC64 based on ISO 3309 Model algorithm"
+	depends on CRC64
+	select CRYPTO_HASH
+	help
+	  CRC64 CRC algorithm based on the ISO 3309 Model CRC Algorithm
+
+	  Generator polynomial: x^64 + x^4 + x^3 + x + 1
+	  Polynomial value: 0x000000000000001b
+	  See https://en.wikipedia.org/wiki/Cyclic_redundancy_check
+
 config CRYPTO_CRC64_ROCKSOFT
 	tristate "CRC64 based on Rocksoft Model algorithm"
 	depends on CRC64
diff --git a/crypto/Makefile b/crypto/Makefile
index de9a3312a2c8..4d419e5fb379 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -158,6 +158,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32_generic.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_common.o crct10dif_generic.o
+obj-$(CONFIG_CRYPTO_CRC64_ISO3309) += crc64_iso3309_generic.o
 obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
diff --git a/crypto/crc64_iso3309_generic.c b/crypto/crc64_iso3309_generic.c
new file mode 100644
index 000000000000..8fcc092de787
--- /dev/null
+++ b/crypto/crc64_iso3309_generic.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include <crypto/internal/hash.h>
+#include <asm/unaligned.h>
+
+static int chksum_cra_init(struct crypto_tfm *tfm)
+{
+	u64 *key = crypto_tfm_ctx(tfm);
+
+	*key = 0;
+	return 0;
+}
+
+static int chksum_init(struct shash_desc *desc)
+{
+	u64 *key = crypto_shash_ctx(desc->tfm);
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = *key;
+	return 0;
+}
+
+static int chksum_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int length)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = crc64_iso3309_generic(*crc, data, length);
+	return 0;
+}
+
+static int chksum_final(struct shash_desc *desc, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	put_unaligned_le64(*crc, out);
+	return 0;
+}
+
+static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
+{
+	crc = crc64_iso3309_generic(crc, data, len);
+
+	put_unaligned_le64(crc, out);
+	return 0;
+}
+
+static int chksum_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	return __chksum_finup(*crc, data, len, out);
+}
+
+static int chksum_digest(struct shash_desc *desc, const u8 *data,
+			 unsigned int length, u8 *out)
+{
+	u64 *key = crypto_shash_ctx(desc->tfm);
+
+	return __chksum_finup(*key, data, length, out);
+}
+
+/*
+ * Setting the seed allows arbitrary accumulators and flexible XOR policy
+ */
+static int chksum_setkey(struct crypto_shash *tfm, const u8 *key,
+			 unsigned int keylen)
+{
+	u64 *mctx = crypto_shash_ctx(tfm);
+
+	if (keylen != sizeof(u64))
+		return -EINVAL;
+
+	*mctx = get_unaligned_le64(key);
+	return 0;
+}
+
+static struct shash_alg alg = {
+	.digestsize	=	sizeof(u64),
+	.setkey		=	chksum_setkey,
+	.init		=	chksum_init,
+	.update		=	chksum_update,
+	.final		=	chksum_final,
+	.finup		=	chksum_finup,
+	.digest		=	chksum_digest,
+	.descsize	=	sizeof(u64),
+	.base		=	{
+		.cra_name		=	CRC64_ISO3309_STRING,
+		.cra_driver_name	=	"crc64-iso3309-generic",
+		.cra_priority		=	200,
+		.cra_flags		=       CRYPTO_ALG_OPTIONAL_KEY,
+		.cra_blocksize		=	1,
+		.cra_ctxsize		=       sizeof(u64),
+		.cra_module		=	THIS_MODULE,
+		.cra_init		=       chksum_cra_init,
+	}
+};
+
+static int __init crc64_iso3309_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit crc64_iso3309_exit(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_init(crc64_iso3309_init);
+module_exit(crc64_iso3309_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kamlesh Gurudasani <kamlesh@ti.com>");
+MODULE_DESCRIPTION("ISO3309 model CRC64 calculation");
+MODULE_ALIAS_CRYPTO("crc64-iso3309");
+MODULE_ALIAS_CRYPTO("crc64-iso3309-generic");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 8aea416f6480..efc76dd9f57f 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2314,6 +2314,12 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				generic_hash_speed_template);
 		if (mode > 300 && mode < 400) break;
 		fallthrough;
+	case 329:
+		test_hash_speed("crc64-iso3309", sec,
+				generic_hash_speed_template);
+		if (mode > 300 && mode < 400)
+			break;
+		fallthrough;
 	case 399:
 		break;
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 00f5a6cf341a..d6ae74efca98 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4656,6 +4656,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(crc32c_tv_template)
 		}
+	}, {
+		.alg = "crc64-iso3309",
+		.test = alg_test_hash,
+		.fips_allowed = 1,
+		.suite = {
+			.hash = __VECS(crc64_iso3309_tv_template)
+		}
 	}, {
 		.alg = "crc64-rocksoft",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5350cfd9d325..21387e405e71 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -5355,6 +5355,410 @@ static const struct hash_testvec rmd160_tv_template[] = {
 	}
 };
 
+static const struct hash_testvec crc64_iso3309_tv_template[] = {
+	{
+		.psize = 0,
+		.digest = "\x00\x00\x00\x00\x00\x00\x00\x00",
+	},
+	{
+		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
+			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
+			     "\x11\x12\x13\x14\x15\x16\x17\x18"
+			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
+			     "\x21\x22\x23\x24\x25\x26\x27\x28",
+		.psize = 40,
+		.digest = "\xaf\x45\xba\x7d\xf2\xda\xa0\xaa",
+	},
+	{
+		.plaintext = "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50",
+		.psize = 40,
+		.digest = "\x81\x55\x2e\x76\xf8\xd0\xaa\xa0",
+	},
+	{
+		.plaintext = "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78",
+		.psize = 40,
+		.digest = "\xc6\xb6\x26\x82\x0d\x25\x5f\x55",
+	},
+	{
+		.plaintext = "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0",
+		.psize = 40,
+		.digest = "\x20\x8a\xe6\x59\xdf\xf7\x8d\x87",
+	},
+	{
+		.plaintext = "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8",
+		.psize = 40,
+		.digest = "\x19\x9e\xba\xff\x70\x58\x22\x28",
+
+	},
+	{
+		.plaintext = "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 40,
+		.digest = "\xa3\xdc\x11\x98\x16\x3e\x44\x4e",
+	},
+	{
+		.plaintext = "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50",
+		.psize = 40,
+		.digest = "\x81\x55\x2e\x76\xf8\xd0\xaa\xa0",
+	},
+	{
+		.plaintext = "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78",
+		.psize = 40,
+		.digest = "\xc6\xb6\x26\x82\x0d\x25\x5f\x55",
+	},
+	{
+		.plaintext = "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0",
+		.psize = 40,
+		.digest = "\x20\x8a\xe6\x59\xdf\xf7\x8d\x87",
+	},
+	{
+		.plaintext = "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8",
+		.psize = 40,
+		.digest = "\x19\x9e\xba\xff\x70\x58\x22\x28",
+	},
+	{
+		.plaintext = "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 40,
+		.digest = "\xa3\xdc\x11\x98\x16\x3e\x44\x4e",
+	},
+	{
+		.key = "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize = 8,
+		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
+			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
+			     "\x11\x12\x13\x14\x15\x16\x17\x18"
+			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
+			     "\x21\x22\x23\x24\x25\x26\x27\x28"
+			     "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
+			     "\x31\x32\x33\x34\x35\x36\x37\x38"
+			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
+			     "\x41\x42\x43\x44\x45\x46\x47\x48"
+			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
+			     "\x51\x52\x53\x54\x55\x56\x57\x58"
+			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
+			     "\x61\x62\x63\x64\x65\x66\x67\x68"
+			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
+			     "\x71\x72\x73\x74\x75\x76\x77\x78"
+			     "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
+			     "\x81\x82\x83\x84\x85\x86\x87\x88"
+			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
+			     "\x91\x92\x93\x94\x95\x96\x97\x98"
+			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
+			     "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
+			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
+			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
+			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
+			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8"
+			     "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
+			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
+			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
+			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
+			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
+		.psize = 240,
+		.digest = "\x8b\xa6\xd7\x91\xb4\x74\x96\x84",
+	}, {
+		.key = "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize = 8,
+		.plaintext = "\x6e\x05\x79\x10\xa7\x1b\xb2\x49"
+			     "\xe0\x54\xeb\x82\x19\x8d\x24\xbb"
+			     "\x2f\xc6\x5d\xf4\x68\xff\x96\x0a"
+			     "\xa1\x38\xcf\x43\xda\x71\x08\x7c"
+			     "\x13\xaa\x1e\xb5\x4c\xe3\x57\xee"
+			     "\x85\x1c\x90\x27\xbe\x32\xc9\x60"
+			     "\xf7\x6b\x02\x99\x0d\xa4\x3b\xd2"
+			     "\x46\xdd\x74\x0b\x7f\x16\xad\x21"
+			     "\xb8\x4f\xe6\x5a\xf1\x88\x1f\x93"
+			     "\x2a\xc1\x35\xcc\x63\xfa\x6e\x05"
+			     "\x9c\x10\xa7\x3e\xd5\x49\xe0\x77"
+			     "\x0e\x82\x19\xb0\x24\xbb\x52\xe9"
+			     "\x5d\xf4\x8b\x22\x96\x2d\xc4\x38"
+			     "\xcf\x66\xfd\x71\x08\x9f\x13\xaa"
+			     "\x41\xd8\x4c\xe3\x7a\x11\x85\x1c"
+			     "\xb3\x27\xbe\x55\xec\x60\xf7\x8e"
+			     "\x02\x99\x30\xc7\x3b\xd2\x69\x00"
+			     "\x74\x0b\xa2\x16\xad\x44\xdb\x4f"
+			     "\xe6\x7d\x14\x88\x1f\xb6\x2a\xc1"
+			     "\x58\xef\x63\xfa\x91\x05\x9c\x33"
+			     "\xca\x3e\xd5\x6c\x03\x77\x0e\xa5"
+			     "\x19\xb0\x47\xde\x52\xe9\x80\x17"
+			     "\x8b\x22\xb9\x2d\xc4\x5b\xf2\x66"
+			     "\xfd\x94\x08\x9f\x36\xcd\x41\xd8"
+			     "\x6f\x06\x7a\x11\xa8\x1c\xb3\x4a"
+			     "\xe1\x55\xec\x83\x1a\x8e\x25\xbc"
+			     "\x30\xc7\x5e\xf5\x69\x00\x97\x0b"
+			     "\xa2\x39\xd0\x44\xdb\x72\x09\x7d"
+			     "\x14\xab\x1f\xb6\x4d\xe4\x58\xef"
+			     "\x86\x1d\x91\x28\xbf\x33\xca\x61"
+			     "\xf8\x6c\x03\x9a\x0e\xa5\x3c\xd3"
+			     "\x47\xde\x75\x0c\x80\x17\xae\x22"
+			     "\xb9\x50\xe7\x5b\xf2\x89\x20\x94"
+			     "\x2b\xc2\x36\xcd\x64\xfb\x6f\x06"
+			     "\x9d\x11\xa8\x3f\xd6\x4a\xe1\x78"
+			     "\x0f\x83\x1a\xb1\x25\xbc\x53\xea"
+			     "\x5e\xf5\x8c\x00\x97\x2e\xc5\x39"
+			     "\xd0\x67\xfe\x72\x09\xa0\x14\xab"
+			     "\x42\xd9\x4d\xe4\x7b\x12\x86\x1d"
+			     "\xb4\x28\xbf\x56\xed\x61\xf8\x8f"
+			     "\x03\x9a\x31\xc8\x3c\xd3\x6a\x01"
+			     "\x75\x0c\xa3\x17\xae\x45\xdc\x50"
+			     "\xe7\x7e\x15\x89\x20\xb7\x2b\xc2"
+			     "\x59\xf0\x64\xfb\x92\x06\x9d\x34"
+			     "\xcb\x3f\xd6\x6d\x04\x78\x0f\xa6"
+			     "\x1a\xb1\x48\xdf\x53\xea\x81\x18"
+			     "\x8c\x23\xba\x2e\xc5\x5c\xf3\x67"
+			     "\xfe\x95\x09\xa0\x37\xce\x42\xd9"
+			     "\x70\x07\x7b\x12\xa9\x1d\xb4\x4b"
+			     "\xe2\x56\xed\x84\x1b\x8f\x26\xbd"
+			     "\x31\xc8\x5f\xf6\x6a\x01\x98\x0c"
+			     "\xa3\x3a\xd1\x45\xdc\x73\x0a\x7e"
+			     "\x15\xac\x20\xb7\x4e\xe5\x59\xf0"
+			     "\x87\x1e\x92\x29\xc0\x34\xcb\x62"
+			     "\xf9\x6d\x04\x9b\x0f\xa6\x3d\xd4"
+			     "\x48\xdf\x76\x0d\x81\x18\xaf\x23"
+			     "\xba\x51\xe8\x5c\xf3\x8a\x21\x95"
+			     "\x2c\xc3\x37\xce\x65\xfc\x70\x07"
+			     "\x9e\x12\xa9\x40\xd7\x4b\xe2\x79"
+			     "\x10\x84\x1b\xb2\x26\xbd\x54\xeb"
+			     "\x5f\xf6\x8d\x01\x98\x2f\xc6\x3a"
+			     "\xd1\x68\xff\x73\x0a\xa1\x15\xac"
+			     "\x43\xda\x4e\xe5\x7c\x13\x87\x1e"
+			     "\xb5\x29\xc0\x57\xee\x62\xf9\x90"
+			     "\x04\x9b\x32\xc9\x3d\xd4\x6b\x02"
+			     "\x76\x0d\xa4\x18\xaf\x46\xdd\x51"
+			     "\xe8\x7f\x16\x8a\x21\xb8\x2c\xc3"
+			     "\x5a\xf1\x65\xfc\x93\x07\x9e\x35"
+			     "\xcc\x40\xd7\x6e\x05\x79\x10\xa7"
+			     "\x1b\xb2\x49\xe0\x54\xeb\x82\x19"
+			     "\x8d\x24\xbb\x2f\xc6\x5d\xf4\x68"
+			     "\xff\x96\x0a\xa1\x38\xcf\x43\xda"
+			     "\x71\x08\x7c\x13\xaa\x1e\xb5\x4c"
+			     "\xe3\x57\xee\x85\x1c\x90\x27\xbe"
+			     "\x32\xc9\x60\xf7\x6b\x02\x99\x0d"
+			     "\xa4\x3b\xd2\x46\xdd\x74\x0b\x7f"
+			     "\x16\xad\x21\xb8\x4f\xe6\x5a\xf1"
+			     "\x88\x1f\x93\x2a\xc1\x35\xcc\x63"
+			     "\xfa\x6e\x05\x9c\x10\xa7\x3e\xd5"
+			     "\x49\xe0\x77\x0e\x82\x19\xb0\x24"
+			     "\xbb\x52\xe9\x5d\xf4\x8b\x22\x96"
+			     "\x2d\xc4\x38\xcf\x66\xfd\x71\x08"
+			     "\x9f\x13\xaa\x41\xd8\x4c\xe3\x7a"
+			     "\x11\x85\x1c\xb3\x27\xbe\x55\xec"
+			     "\x60\xf7\x8e\x02\x99\x30\xc7\x3b"
+			     "\xd2\x69\x00\x74\x0b\xa2\x16\xad"
+			     "\x44\xdb\x4f\xe6\x7d\x14\x88\x1f"
+			     "\xb6\x2a\xc1\x58\xef\x63\xfa\x91"
+			     "\x05\x9c\x33\xca\x3e\xd5\x6c\x03"
+			     "\x77\x0e\xa5\x19\xb0\x47\xde\x52"
+			     "\xe9\x80\x17\x8b\x22\xb9\x2d\xc4"
+			     "\x5b\xf2\x66\xfd\x94\x08\x9f\x36"
+			     "\xcd\x41\xd8\x6f\x06\x7a\x11\xa8"
+			     "\x1c\xb3\x4a\xe1\x55\xec\x83\x1a"
+			     "\x8e\x25\xbc\x30\xc7\x5e\xf5\x69"
+			     "\x00\x97\x0b\xa2\x39\xd0\x44\xdb"
+			     "\x72\x09\x7d\x14\xab\x1f\xb6\x4d"
+			     "\xe4\x58\xef\x86\x1d\x91\x28\xbf"
+			     "\x33\xca\x61\xf8\x6c\x03\x9a\x0e"
+			     "\xa5\x3c\xd3\x47\xde\x75\x0c\x80"
+			     "\x17\xae\x22\xb9\x50\xe7\x5b\xf2"
+			     "\x89\x20\x94\x2b\xc2\x36\xcd\x64"
+			     "\xfb\x6f\x06\x9d\x11\xa8\x3f\xd6"
+			     "\x4a\xe1\x78\x0f\x83\x1a\xb1\x25"
+			     "\xbc\x53\xea\x5e\xf5\x8c\x00\x97"
+			     "\x2e\xc5\x39\xd0\x67\xfe\x72\x09"
+			     "\xa0\x14\xab\x42\xd9\x4d\xe4\x7b"
+			     "\x12\x86\x1d\xb4\x28\xbf\x56\xed"
+			     "\x61\xf8\x8f\x03\x9a\x31\xc8\x3c"
+			     "\xd3\x6a\x01\x75\x0c\xa3\x17\xae"
+			     "\x45\xdc\x50\xe7\x7e\x15\x89\x20"
+			     "\xb7\x2b\xc2\x59\xf0\x64\xfb\x92"
+			     "\x06\x9d\x34\xcb\x3f\xd6\x6d\x04"
+			     "\x78\x0f\xa6\x1a\xb1\x48\xdf\x53"
+			     "\xea\x81\x18\x8c\x23\xba\x2e\xc5"
+			     "\x5c\xf3\x67\xfe\x95\x09\xa0\x37"
+			     "\xce\x42\xd9\x70\x07\x7b\x12\xa9"
+			     "\x1d\xb4\x4b\xe2\x56\xed\x84\x1b"
+			     "\x8f\x26\xbd\x31\xc8\x5f\xf6\x6a"
+			     "\x01\x98\x0c\xa3\x3a\xd1\x45\xdc"
+			     "\x73\x0a\x7e\x15\xac\x20\xb7\x4e"
+			     "\xe5\x59\xf0\x87\x1e\x92\x29\xc0"
+			     "\x34\xcb\x62\xf9\x6d\x04\x9b\x0f"
+			     "\xa6\x3d\xd4\x48\xdf\x76\x0d\x81"
+			     "\x18\xaf\x23\xba\x51\xe8\x5c\xf3"
+			     "\x8a\x21\x95\x2c\xc3\x37\xce\x65"
+			     "\xfc\x70\x07\x9e\x12\xa9\x40\xd7"
+			     "\x4b\xe2\x79\x10\x84\x1b\xb2\x26"
+			     "\xbd\x54\xeb\x5f\xf6\x8d\x01\x98"
+			     "\x2f\xc6\x3a\xd1\x68\xff\x73\x0a"
+			     "\xa1\x15\xac\x43\xda\x4e\xe5\x7c"
+			     "\x13\x87\x1e\xb5\x29\xc0\x57\xee"
+			     "\x62\xf9\x90\x04\x9b\x32\xc9\x3d"
+			     "\xd4\x6b\x02\x76\x0d\xa4\x18\xaf"
+			     "\x46\xdd\x51\xe8\x7f\x16\x8a\x21"
+			     "\xb8\x2c\xc3\x5a\xf1\x65\xfc\x93"
+			     "\x07\x9e\x35\xcc\x40\xd7\x6e\x05"
+			     "\x79\x10\xa7\x1b\xb2\x49\xe0\x54"
+			     "\xeb\x82\x19\x8d\x24\xbb\x2f\xc6"
+			     "\x5d\xf4\x68\xff\x96\x0a\xa1\x38"
+			     "\xcf\x43\xda\x71\x08\x7c\x13\xaa"
+			     "\x1e\xb5\x4c\xe3\x57\xee\x85\x1c"
+			     "\x90\x27\xbe\x32\xc9\x60\xf7\x6b"
+			     "\x02\x99\x0d\xa4\x3b\xd2\x46\xdd"
+			     "\x74\x0b\x7f\x16\xad\x21\xb8\x4f"
+			     "\xe6\x5a\xf1\x88\x1f\x93\x2a\xc1"
+			     "\x35\xcc\x63\xfa\x6e\x05\x9c\x10"
+			     "\xa7\x3e\xd5\x49\xe0\x77\x0e\x82"
+			     "\x19\xb0\x24\xbb\x52\xe9\x5d\xf4"
+			     "\x8b\x22\x96\x2d\xc4\x38\xcf\x66"
+			     "\xfd\x71\x08\x9f\x13\xaa\x41\xd8"
+			     "\x4c\xe3\x7a\x11\x85\x1c\xb3\x27"
+			     "\xbe\x55\xec\x60\xf7\x8e\x02\x99"
+			     "\x30\xc7\x3b\xd2\x69\x00\x74\x0b"
+			     "\xa2\x16\xad\x44\xdb\x4f\xe6\x7d"
+			     "\x14\x88\x1f\xb6\x2a\xc1\x58\xef"
+			     "\x63\xfa\x91\x05\x9c\x33\xca\x3e"
+			     "\xd5\x6c\x03\x77\x0e\xa5\x19\xb0"
+			     "\x47\xde\x52\xe9\x80\x17\x8b\x22"
+			     "\xb9\x2d\xc4\x5b\xf2\x66\xfd\x94"
+			     "\x08\x9f\x36\xcd\x41\xd8\x6f\x06"
+			     "\x7a\x11\xa8\x1c\xb3\x4a\xe1\x55"
+			     "\xec\x83\x1a\x8e\x25\xbc\x30\xc7"
+			     "\x5e\xf5\x69\x00\x97\x0b\xa2\x39"
+			     "\xd0\x44\xdb\x72\x09\x7d\x14\xab"
+			     "\x1f\xb6\x4d\xe4\x58\xef\x86\x1d"
+			     "\x91\x28\xbf\x33\xca\x61\xf8\x6c"
+			     "\x03\x9a\x0e\xa5\x3c\xd3\x47\xde"
+			     "\x75\x0c\x80\x17\xae\x22\xb9\x50"
+			     "\xe7\x5b\xf2\x89\x20\x94\x2b\xc2"
+			     "\x36\xcd\x64\xfb\x6f\x06\x9d\x11"
+			     "\xa8\x3f\xd6\x4a\xe1\x78\x0f\x83"
+			     "\x1a\xb1\x25\xbc\x53\xea\x5e\xf5"
+			     "\x8c\x00\x97\x2e\xc5\x39\xd0\x67"
+			     "\xfe\x72\x09\xa0\x14\xab\x42\xd9"
+			     "\x4d\xe4\x7b\x12\x86\x1d\xb4\x28"
+			     "\xbf\x56\xed\x61\xf8\x8f\x03\x9a"
+			     "\x31\xc8\x3c\xd3\x6a\x01\x75\x0c"
+			     "\xa3\x17\xae\x45\xdc\x50\xe7\x7e"
+			     "\x15\x89\x20\xb7\x2b\xc2\x59\xf0"
+			     "\x64\xfb\x92\x06\x9d\x34\xcb\x3f"
+			     "\xd6\x6d\x04\x78\x0f\xa6\x1a\xb1"
+			     "\x48\xdf\x53\xea\x81\x18\x8c\x23"
+			     "\xba\x2e\xc5\x5c\xf3\x67\xfe\x95"
+			     "\x09\xa0\x37\xce\x42\xd9\x70\x07"
+			     "\x7b\x12\xa9\x1d\xb4\x4b\xe2\x56"
+			     "\xed\x84\x1b\x8f\x26\xbd\x31\xc8"
+			     "\x5f\xf6\x6a\x01\x98\x0c\xa3\x3a"
+			     "\xd1\x45\xdc\x73\x0a\x7e\x15\xac"
+			     "\x20\xb7\x4e\xe5\x59\xf0\x87\x1e"
+			     "\x92\x29\xc0\x34\xcb\x62\xf9\x6d"
+			     "\x04\x9b\x0f\xa6\x3d\xd4\x48\xdf"
+			     "\x76\x0d\x81\x18\xaf\x23\xba\x51"
+			     "\xe8\x5c\xf3\x8a\x21\x95\x2c\xc3"
+			     "\x37\xce\x65\xfc\x70\x07\x9e\x12"
+			     "\xa9\x40\xd7\x4b\xe2\x79\x10\x84"
+			     "\x1b\xb2\x26\xbd\x54\xeb\x5f\xf6"
+			     "\x8d\x01\x98\x2f\xc6\x3a\xd1\x68"
+			     "\xff\x73\x0a\xa1\x15\xac\x43\xda"
+			     "\x4e\xe5\x7c\x13\x87\x1e\xb5\x29"
+			     "\xc0\x57\xee\x62\xf9\x90\x04\x9b"
+			     "\x32\xc9\x3d\xd4\x6b\x02\x76\x0d"
+			     "\xa4\x18\xaf\x46\xdd\x51\xe8\x7f"
+			     "\x16\x8a\x21\xb8\x2c\xc3\x5a\xf1"
+			     "\x65\xfc\x93\x07\x9e\x35\xcc\x40"
+			     "\xd7\x6e\x05\x79\x10\xa7\x1b\xb2"
+			     "\x49\xe0\x54\xeb\x82\x19\x8d\x24"
+			     "\xbb\x2f\xc6\x5d\xf4\x68\xff\x96"
+			     "\x0a\xa1\x38\xcf\x43\xda\x71\x08"
+			     "\x7c\x13\xaa\x1e\xb5\x4c\xe3\x57"
+			     "\xee\x85\x1c\x90\x27\xbe\x32\xc9"
+			     "\x60\xf7\x6b\x02\x99\x0d\xa4\x3b"
+			     "\xd2\x46\xdd\x74\x0b\x7f\x16\xad"
+			     "\x21\xb8\x4f\xe6\x5a\xf1\x88\x1f"
+			     "\x93\x2a\xc1\x35\xcc\x63\xfa\x6e"
+			     "\x05\x9c\x10\xa7\x3e\xd5\x49\xe0"
+			     "\x77\x0e\x82\x19\xb0\x24\xbb\x52"
+			     "\xe9\x5d\xf4\x8b\x22\x96\x2d\xc4"
+			     "\x38\xcf\x66\xfd\x71\x08\x9f\x13"
+			     "\xaa\x41\xd8\x4c\xe3\x7a\x11\x85"
+			     "\x1c\xb3\x27\xbe\x55\xec\x60\xf7"
+			     "\x8e\x02\x99\x30\xc7\x3b\xd2\x69"
+			     "\x00\x74\x0b\xa2\x16\xad\x44\xdb"
+			     "\x4f\xe6\x7d\x14\x88\x1f\xb6\x2a"
+			     "\xc1\x58\xef\x63\xfa\x91\x05\x9c"
+			     "\x33\xca\x3e\xd5\x6c\x03\x77\x0e"
+			     "\xa5\x19\xb0\x47\xde\x52\xe9\x80"
+			     "\x17\x8b\x22\xb9\x2d\xc4\x5b\xf2"
+			     "\x66\xfd\x94\x08\x9f\x36\xcd\x41"
+			     "\xd8\x6f\x06\x7a\x11\xa8\x1c\xb3"
+			     "\x4a\xe1\x55\xec\x83\x1a\x8e\x25"
+			     "\xbc\x30\xc7\x5e\xf5\x69\x00\x97"
+			     "\x0b\xa2\x39\xd0\x44\xdb\x72\x09"
+			     "\x7d\x14\xab\x1f\xb6\x4d\xe4\x58"
+			     "\xef\x86\x1d\x91\x28\xbf\x33\xca"
+			     "\x61\xf8\x6c\x03\x9a\x0e\xa5\x3c"
+			     "\xd3\x47\xde\x75\x0c\x80\x17\xae"
+			     "\x22\xb9\x50\xe7\x5b\xf2\x89\x20"
+			     "\x94\x2b\xc2\x36\xcd\x64\xfb\x6f"
+			     "\x06\x9d\x11\xa8\x3f\xd6\x4a\xe1"
+			     "\x78\x0f\x83\x1a\xb1\x25\xbc\x53"
+			     "\xea\x5e\xf5\x8c\x00\x97\x2e\xc5"
+			     "\x39\xd0\x67\xfe\x72\x09\xa0\x14"
+			     "\xab\x42\xd9\x4d\xe4\x7b\x12\x86"
+			     "\x1d\xb4\x28\xbf\x56\xed\x61\xf8"
+			     "\x8f\x03\x9a\x31\xc8\x3c\xd3\x6a"
+			     "\x01\x75\x0c\xa3\x17\xae\x45\xdc"
+			     "\x50\xe7\x7e\x15\x89\x20\xb7\x2b"
+			     "\xc2\x59\xf0\x64\xfb\x92\x06\x9d"
+			     "\x34\xcb\x3f\xd6\x6d\x04\x78\x0f"
+			     "\xa6\x1a\xb1\x48\xdf\x53\xea\x81"
+			     "\x18\x8c\x23\xba\x2e\xc5\x5c\xf3"
+			     "\x67\xfe\x95\x09\xa0\x37\xce\x42"
+			     "\xd9\x70\x07\x7b\x12\xa9\x1d\xb4"
+			     "\x4b\xe2\x56\xed\x84\x1b\x8f\x26"
+			     "\xbd\x31\xc8\x5f\xf6\x6a\x01\x98",
+		.psize = 2048,
+		.digest = "\x4b\x82\xa5\x0e\x72\x01\x0b\xc6",
+	}
+};
+
 static const u8 zeroes[4096] = { [0 ... 4095] = 0 };
 static const u8 ones[4096] = { [0 ... 4095] = 0xff };
 
diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index b791316f251c..890959372633 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 
+#define CRC64_ISO3309_STRING "crc64-iso3309"
 #define CRC64_ROCKSOFT_STRING "crc64-rocksoft"
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);

-- 
2.34.1

