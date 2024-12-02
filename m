Return-Path: <linux-crypto+bounces-8334-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AC9E058D
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Dec 2024 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7E6B44B20
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Dec 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7DD2036FE;
	Mon,  2 Dec 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7YVZJ3/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE15376F1
	for <linux-crypto@vger.kernel.org>; Mon,  2 Dec 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149813; cv=none; b=LRvAVYDH4amtEk2ahYPLid4v3v5nSRH53RD+n+9xStiKeSlobZvolFdszoiPxk4pSljnFfvTIu48v4t7IiBHAK0MLzLwpdCZovolHLfyX/JxqXUOrgA0ifMGy1KZd+V8+aXcWozDiLVZEXi0PPZT10U46Q4XgiCvTcTLa+QILdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149813; c=relaxed/simple;
	bh=VxNmjVC55Bixx++00nhQOYnSMgS1l3+P7Z+UwkPjATA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBSZGAbnHc2HbZes/KWDTE6JHRSttX0DbG19W8Arghl/lK3BqEdN8gYXWna/eDU7EbfNsLHZ7m7c0l/ATor3YEtjdKP6sCx1gGvyKbPxBXqsq4+mepN7B1Tyx367Q5ry+fMx9l/Mm7Sc8/S176wsC4mn+99ar5FgQZbNF5spL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7YVZJ3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA32C4CED1;
	Mon,  2 Dec 2024 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149812;
	bh=VxNmjVC55Bixx++00nhQOYnSMgS1l3+P7Z+UwkPjATA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7YVZJ3/wmyvoDY2CD5hEoU+V1RtTDi8fCLiQHQClL5XrqeY0KsvOTMb2a8CBHs2a
	 17B3P3jBbOIKIHt7lxkby1MsC0Zprj4xlqmZKOoRMiWxoLaYon1bP5CtH9sLOghN0r
	 6YipLutsZ9d57Lw9YZdGdP9Zo2CGNfboCKgMVrSbpHJajsTBzSlMPIFvNln3yAH2ra
	 RLzq9dFZ1tAtFF/qVEDlRLNoDUZ9dBeLWjofs5q5kdo4FglSmUFBPOvvW25JaNYZYL
	 EgSlHWVBYl7pWWZZc579walzpE+l77Ie53cNMMKrlMloiy62O9UKkHhOVwAy6ksAam
	 dTTdCLGVdElRQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 01/10] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
Date: Mon,  2 Dec 2024 15:29:50 +0100
Message-Id: <20241202142959.81321-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202142959.81321-1-hare@kernel.org>
References: <20241202142959.81321-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate out the HKDF functions into a separate module to
to make them available to other callers.
And add a testsuite to the module with test vectors
from RFC 5869 (and additional vectors for SHA384 and SHA512)
to ensure the integrity of the algorithm.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org
---
 crypto/Kconfig        |   6 +
 crypto/Makefile       |   1 +
 crypto/hkdf.c         | 573 ++++++++++++++++++++++++++++++++++++++++++
 fs/crypto/Kconfig     |   1 +
 fs/crypto/hkdf.c      |  85 ++-----
 include/crypto/hkdf.h |  20 ++
 6 files changed, 616 insertions(+), 70 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a779cab668c2..03656e7b55bb 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -141,6 +141,12 @@ config CRYPTO_ACOMP
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 
+config CRYPTO_HKDF
+	tristate
+	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+	select CRYPTO_SHA512 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+	select CRYPTO_HASH2
+
 config CRYPTO_MANAGER
 	tristate "Cryptographic algorithm manager"
 	select CRYPTO_MANAGER2
diff --git a/crypto/Makefile b/crypto/Makefile
index 4c99e5d376f6..5ec5b994d9ae 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CRYPTO_HASH2) += crypto_hash.o
 obj-$(CONFIG_CRYPTO_AKCIPHER2) += akcipher.o
 obj-$(CONFIG_CRYPTO_SIG2) += sig.o
 obj-$(CONFIG_CRYPTO_KPP2) += kpp.o
+obj-$(CONFIG_CRYPTO_HKDF) += hkdf.o
 
 dh_generic-y := dh.o
 dh_generic-y += dh_helper.o
diff --git a/crypto/hkdf.c b/crypto/hkdf.c
new file mode 100644
index 000000000000..2434c5c42545
--- /dev/null
+++ b/crypto/hkdf.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
+ * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
+ * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include <crypto/internal/hash.h>
+#include <crypto/sha2.h>
+#include <crypto/hkdf.h>
+#include <linux/module.h>
+
+/*
+ * HKDF consists of two steps:
+ *
+ * 1. HKDF-Extract: extract a pseudorandom key from the input keying material
+ *    and optional salt.
+ * 2. HKDF-Expand: expand the pseudorandom key into output keying material of
+ *    any length, parameterized by an application-specific info string.
+ *
+ */
+
+/**
+ * hkdf_extract - HKDF-Extract (RFC 5869 section 2.2)
+ * @hmac_tfm: an HMAC transform using the hash function desired for HKDF.  The
+ *            caller is responsible for setting the @prk afterwards.
+ * @ikm: input keying material
+ * @ikmlen: length of @ikm
+ * @salt: input salt value
+ * @saltlen: length of @salt
+ * @prk: resulting pseudorandom key
+ *
+ * Extracts a pseudorandom key @prk from the input keying material
+ * @ikm with length @ikmlen and salt @salt with length @saltlen.
+ * The length of @prk is given by the digest size of @hmac_tfm.
+ * For an 'unsalted' version of HKDF-Extract @salt must be set
+ * to all zeroes and @saltlen must be set to the length of @prk.
+ *
+ * Returns 0 on success with the pseudorandom key stored in @prk,
+ * or a negative errno value otherwise.
+ */
+int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
+		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
+		 u8 *prk)
+{
+	int err;
+
+	err = crypto_shash_setkey(hmac_tfm, salt, saltlen);
+	if (!err)
+		err = crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(hkdf_extract);
+
+/**
+ * hkdf_expand - HKDF-Expand (RFC 5869 section 2.3)
+ * @hmac_tfm: hash context keyed with pseudorandom key
+ * @info: application-specific information
+ * @infolen: length of @info
+ * @okm: output keying material
+ * @okmlen: length of @okm
+ *
+ * This expands the pseudorandom key, which was already keyed into @hmac_tfm,
+ * into @okmlen bytes of output keying material parameterized by the
+ * application-specific @info of length @infolen bytes.
+ * This is thread-safe and may be called by multiple threads in parallel.
+ *
+ * Returns 0 on success with output keying material stored in @okm,
+ * or a negative errno value otherwise.
+ */
+int hkdf_expand(struct crypto_shash *hmac_tfm,
+		const u8 *info, unsigned int infolen,
+		u8 *okm, unsigned int okmlen)
+{
+	SHASH_DESC_ON_STACK(desc, hmac_tfm);
+	unsigned int i, hashlen = crypto_shash_digestsize(hmac_tfm);
+	int err;
+	const u8 *prev = NULL;
+	u8 counter = 1;
+	u8 tmp[HASH_MAX_DIGESTSIZE] = {};
+
+	if (WARN_ON(okmlen > 255 * hashlen))
+		return -EINVAL;
+
+	desc->tfm = hmac_tfm;
+
+	for (i = 0; i < okmlen; i += hashlen) {
+		err = crypto_shash_init(desc);
+		if (err)
+			goto out;
+
+		if (prev) {
+			err = crypto_shash_update(desc, prev, hashlen);
+			if (err)
+				goto out;
+		}
+
+		if (infolen) {
+			err = crypto_shash_update(desc, info, infolen);
+			if (err)
+				goto out;
+		}
+
+		BUILD_BUG_ON(sizeof(counter) != 1);
+		if (okmlen - i < hashlen) {
+			err = crypto_shash_finup(desc, &counter, 1, tmp);
+			if (err)
+				goto out;
+			memcpy(&okm[i], tmp, okmlen - i);
+			memzero_explicit(tmp, sizeof(tmp));
+		} else {
+			err = crypto_shash_finup(desc, &counter, 1, &okm[i]);
+			if (err)
+				goto out;
+		}
+		counter++;
+		prev = &okm[i];
+	}
+	err = 0;
+out:
+	if (unlikely(err))
+		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
+	shash_desc_zero(desc);
+	memzero_explicit(tmp, HASH_MAX_DIGESTSIZE);
+	return err;
+}
+EXPORT_SYMBOL_GPL(hkdf_expand);
+
+struct hkdf_testvec {
+	const char *test;
+	const u8 *ikm;
+	const u8 *salt;
+	const u8 *info;
+	const u8 *prk;
+	const u8 *okm;
+	u16 ikm_size;
+	u16 salt_size;
+	u16 info_size;
+	u16 prk_size;
+	u16 okm_size;
+};
+
+/*
+ * HKDF test vectors from RFC5869
+ *
+ * Additional HKDF test vectors from
+ * https://github.com/brycx/Test-Vector-Generation/blob/master/HKDF/hkdf-hmac-sha2-test-vectors.md
+ */
+static const struct hkdf_testvec hkdf_sha256_tv[] = {
+	{
+		.test = "basic hdkf test",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk = "\x07\x77\x09\x36\x2c\x2e\x32\xdf\x0d\xdc\x3f\x0d\xc4\x7b\xba\x63"
+			"\x90\xb6\xc7\x3b\xb5\x0f\x9c\x31\x22\xec\x84\x4a\xd7\xc2\xb3\xe5",
+		.prk_size = 32,
+		.okm  = "\x3c\xb2\x5f\x25\xfa\xac\xd5\x7a\x90\x43\x4f\x64\xd0\x36\x2f\x2a"
+			"\x2d\x2d\x0a\x90\xcf\x1a\x5a\x4c\x5d\xb0\x2d\x56\xec\xc4\xc5\xbf"
+			"\x34\x00\x72\x08\xd5\xb8\x87\x18\x58\x65",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with long input",
+		.ikm  = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f",
+		.ikm_size = 80,
+		.salt = "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf",
+		.salt_size = 80,
+		.info = "\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.info_size = 80,
+		.prk  = "\x06\xa6\xb8\x8c\x58\x53\x36\x1a\x06\x10\x4c\x9c\xeb\x35\xb4\x5c"
+			"\xef\x76\x00\x14\x90\x46\x71\x01\x4a\x19\x3f\x40\xc1\x5f\xc2\x44",
+		.prk_size = 32,
+		.okm  = "\xb1\x1e\x39\x8d\xc8\x03\x27\xa1\xc8\xe7\xf7\x8c\x59\x6a\x49\x34"
+			"\x4f\x01\x2e\xda\x2d\x4e\xfa\xd8\xa0\x50\xcc\x4c\x19\xaf\xa9\x7c"
+			"\x59\x04\x5a\x99\xca\xc7\x82\x72\x71\xcb\x41\xc6\x5e\x59\x0e\x09"
+			"\xda\x32\x75\x60\x0c\x2f\x09\xb8\x36\x77\x93\xa9\xac\xa3\xdb\x71"
+			"\xcc\x30\xc5\x81\x79\xec\x3e\x87\xc1\x4c\x01\xd5\xc1\xf3\x43\x4f"
+			"\x1d\x87",
+		.okm_size = 82,
+	}, {
+		.test = "hkdf test with zero salt and info",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = NULL,
+		.salt_size = 0,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\x19\xef\x24\xa3\x2c\x71\x7b\x16\x7f\x33\xa9\x1d\x6f\x64\x8b\xdf"
+			"\x96\x59\x67\x76\xaf\xdb\x63\x77\xac\x43\x4c\x1c\x29\x3c\xcb\x04",
+		.prk_size = 32,
+		.okm  = "\x8d\xa4\xe7\x75\xa5\x63\xc1\x8f\x71\x5f\x80\x2a\x06\x3c\x5a\x31"
+			"\xb8\xa1\x1f\x5c\x5e\xe1\x87\x9e\xc3\x45\x4e\x5f\x3c\x73\x8d\x2d"
+			"\x9d\x20\x13\x95\xfa\xa4\xb6\x1a\x96\xc8",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with short input",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 11,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x82\x65\xf6\x9d\x7f\xf7\xe5\x01\x37\x93\x01\x5c\xa0\xef\x92\x0c"
+			"\xb1\x68\x21\x99\xc8\xbc\x3a\x00\xda\x0c\xab\x47\xb7\xb0\x0f\xdf",
+		.prk_size = 32,
+		.okm  = "\x58\xdc\xe1\x0d\x58\x01\xcd\xfd\xa8\x31\x72\x6b\xfe\xbc\xb7\x43"
+			"\xd1\x4a\x7e\xe8\x3a\xa0\x57\xa9\x3d\x59\xb0\xa1\x31\x7f\xf0\x9d"
+			"\x10\x5c\xce\xcf\x53\x56\x92\xb1\x4d\xd5",
+		.okm_size = 42,
+	}, {
+		.test = "unsalted hkdf test with zero info",
+		.ikm  = "\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c"
+			"\x0c\x0c\x0c\x0c\x0c\x0c",
+		.ikm_size = 22,
+		.salt = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
+		.salt_size = 32,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\xaa\x84\x1e\x1f\x35\x74\xf3\x2d\x13\xfb\xa8\x00\x5f\xcd\x9b\x8d"
+			"\x77\x67\x82\xa5\xdf\xa1\x92\x38\x92\xfd\x8b\x63\x5d\x3a\x89\xdf",
+		.prk_size = 32,
+		.okm  = "\x59\x68\x99\x17\x9a\xb1\xbc\x00\xa7\xc0\x37\x86\xff\x43\xee\x53"
+			"\x50\x04\xbe\x2b\xb9\xbe\x68\xbc\x14\x06\x63\x6f\x54\xbd\x33\x8a"
+			"\x66\xa2\x37\xba\x2a\xcb\xce\xe3\xc9\xa7",
+		.okm_size = 42,
+	}
+};
+
+static const struct hkdf_testvec hkdf_sha384_tv[] = {
+	{
+		.test = "basic hkdf test",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x70\x4b\x39\x99\x07\x79\xce\x1d\xc5\x48\x05\x2c\x7d\xc3\x9f\x30"
+			"\x35\x70\xdd\x13\xfb\x39\xf7\xac\xc5\x64\x68\x0b\xef\x80\xe8\xde"
+			"\xc7\x0e\xe9\xa7\xe1\xf3\xe2\x93\xef\x68\xec\xeb\x07\x2a\x5a\xde",
+		.prk_size = 48,
+		.okm  = "\x9b\x50\x97\xa8\x60\x38\xb8\x05\x30\x90\x76\xa4\x4b\x3a\x9f\x38"
+			"\x06\x3e\x25\xb5\x16\xdc\xbf\x36\x9f\x39\x4c\xfa\xb4\x36\x85\xf7"
+			"\x48\xb6\x45\x77\x63\xe4\xf0\x20\x4f\xc5",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with long input",
+		.ikm  = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f",
+		.ikm_size = 80,
+		.salt = "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf",
+		.salt_size = 80,
+		.info = "\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.info_size = 80,
+		.prk  = "\xb3\x19\xf6\x83\x1d\xff\x93\x14\xef\xb6\x43\xba\xa2\x92\x63\xb3"
+			"\x0e\x4a\x8d\x77\x9f\xe3\x1e\x9c\x90\x1e\xfd\x7d\xe7\x37\xc8\x5b"
+			"\x62\xe6\x76\xd4\xdc\x87\xb0\x89\x5c\x6a\x7d\xc9\x7b\x52\xce\xbb",
+		.prk_size = 48,
+		.okm  = "\x48\x4c\xa0\x52\xb8\xcc\x72\x4f\xd1\xc4\xec\x64\xd5\x7b\x4e\x81"
+			"\x8c\x7e\x25\xa8\xe0\xf4\x56\x9e\xd7\x2a\x6a\x05\xfe\x06\x49\xee"
+			"\xbf\x69\xf8\xd5\xc8\x32\x85\x6b\xf4\xe4\xfb\xc1\x79\x67\xd5\x49"
+			"\x75\x32\x4a\x94\x98\x7f\x7f\x41\x83\x58\x17\xd8\x99\x4f\xdb\xd6"
+			"\xf4\xc0\x9c\x55\x00\xdc\xa2\x4a\x56\x22\x2f\xea\x53\xd8\x96\x7a"
+			"\x8b\x2e",
+		.okm_size = 82,
+	}, {
+		.test = "hkdf test with zero salt and info",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = NULL,
+		.salt_size = 0,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\x10\xe4\x0c\xf0\x72\xa4\xc5\x62\x6e\x43\xdd\x22\xc1\xcf\x72\x7d"
+			"\x4b\xb1\x40\x97\x5c\x9a\xd0\xcb\xc8\xe4\x5b\x40\x06\x8f\x8f\x0b"
+			"\xa5\x7c\xdb\x59\x8a\xf9\xdf\xa6\x96\x3a\x96\x89\x9a\xf0\x47\xe5",
+		.prk_size = 48,
+		.okm  = "\xc8\xc9\x6e\x71\x0f\x89\xb0\xd7\x99\x0b\xca\x68\xbc\xde\xc8\xcf"
+			"\x85\x40\x62\xe5\x4c\x73\xa7\xab\xc7\x43\xfa\xde\x9b\x24\x2d\xaa"
+			"\xcc\x1c\xea\x56\x70\x41\x5b\x52\x84\x9c",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with short input",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 11,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x6d\x31\x69\x98\x28\x79\x80\x88\xb3\x59\xda\xd5\x0b\x8f\x01\xb0"
+			"\x15\xf1\x7a\xa3\xbd\x4e\x27\xa6\xe9\xf8\x73\xb7\x15\x85\xca\x6a"
+			"\x00\xd1\xf0\x82\x12\x8a\xdb\x3c\xf0\x53\x0b\x57\xc0\xf9\xac\x72",
+		.prk_size = 48,
+		.okm  = "\xfb\x7e\x67\x43\xeb\x42\xcd\xe9\x6f\x1b\x70\x77\x89\x52\xab\x75"
+			"\x48\xca\xfe\x53\x24\x9f\x7f\xfe\x14\x97\xa1\x63\x5b\x20\x1f\xf1"
+			"\x85\xb9\x3e\x95\x19\x92\xd8\x58\xf1\x1a",
+		.okm_size = 42,
+	}, {
+		.test = "unsalted hkdf test with zero info",
+		.ikm  = "\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c"
+			"\x0c\x0c\x0c\x0c\x0c\x0c",
+		.ikm_size = 22,
+		.salt = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
+		.salt_size = 48,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\x9d\x2d\xa5\x06\x6f\x05\xd1\x6c\x59\xfe\xdf\x6c\x5f\x32\xc7\x5e"
+			"\xda\x9a\x47\xa7\x9c\x93\x6a\xa4\x4c\xb7\x63\xa8\xe2\x2f\xfb\xfc"
+			"\xd8\xfe\x55\x43\x58\x53\x47\x21\x90\x39\xd1\x68\x28\x36\x33\xf5",
+		.prk_size = 48,
+		.okm  = "\x6a\xd7\xc7\x26\xc8\x40\x09\x54\x6a\x76\xe0\x54\x5d\xf2\x66\x78"
+			"\x7e\x2b\x2c\xd6\xca\x43\x73\xa1\xf3\x14\x50\xa7\xbd\xf9\x48\x2b"
+			"\xfa\xb8\x11\xf5\x54\x20\x0e\xad\x8f\x53",
+		.okm_size = 42,
+	}
+};
+
+static const struct hkdf_testvec hkdf_sha512_tv[] = {
+	{
+		.test = "basic hkdf test",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x66\x57\x99\x82\x37\x37\xde\xd0\x4a\x88\xe4\x7e\x54\xa5\x89\x0b"
+			"\xb2\xc3\xd2\x47\xc7\xa4\x25\x4a\x8e\x61\x35\x07\x23\x59\x0a\x26"
+			"\xc3\x62\x38\x12\x7d\x86\x61\xb8\x8c\xf8\x0e\xf8\x02\xd5\x7e\x2f"
+			"\x7c\xeb\xcf\x1e\x00\xe0\x83\x84\x8b\xe1\x99\x29\xc6\x1b\x42\x37",
+		.prk_size = 64,
+		.okm  = "\x83\x23\x90\x08\x6c\xda\x71\xfb\x47\x62\x5b\xb5\xce\xb1\x68\xe4"
+			"\xc8\xe2\x6a\x1a\x16\xed\x34\xd9\xfc\x7f\xe9\x2c\x14\x81\x57\x93"
+			"\x38\xda\x36\x2c\xb8\xd9\xf9\x25\xd7\xcb",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with long input",
+		.ikm  = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
+			"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
+			"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
+			"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
+			"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f",
+		.ikm_size = 80,
+		.salt = "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
+			"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+			"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
+			"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
+			"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf",
+		.salt_size = 80,
+		.info = "\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
+			"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
+			"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
+			"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef"
+			"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		.info_size = 80,
+		.prk  = "\x35\x67\x25\x42\x90\x7d\x4e\x14\x2c\x00\xe8\x44\x99\xe7\x4e\x1d"
+			"\xe0\x8b\xe8\x65\x35\xf9\x24\xe0\x22\x80\x4a\xd7\x75\xdd\xe2\x7e"
+			"\xc8\x6c\xd1\xe5\xb7\xd1\x78\xc7\x44\x89\xbd\xbe\xb3\x07\x12\xbe"
+			"\xb8\x2d\x4f\x97\x41\x6c\x5a\x94\xea\x81\xeb\xdf\x3e\x62\x9e\x4a",
+		.prk_size = 64,
+		.okm  = "\xce\x6c\x97\x19\x28\x05\xb3\x46\xe6\x16\x1e\x82\x1e\xd1\x65\x67"
+			"\x3b\x84\xf4\x00\xa2\xb5\x14\xb2\xfe\x23\xd8\x4c\xd1\x89\xdd\xf1"
+			"\xb6\x95\xb4\x8c\xbd\x1c\x83\x88\x44\x11\x37\xb3\xce\x28\xf1\x6a"
+			"\xa6\x4b\xa3\x3b\xa4\x66\xb2\x4d\xf6\xcf\xcb\x02\x1e\xcf\xf2\x35"
+			"\xf6\xa2\x05\x6c\xe3\xaf\x1d\xe4\x4d\x57\x20\x97\xa8\x50\x5d\x9e"
+			"\x7a\x93",
+		.okm_size = 82,
+	}, {
+		.test = "hkdf test with zero salt and info",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = NULL,
+		.salt_size = 0,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\xfd\x20\x0c\x49\x87\xac\x49\x13\x13\xbd\x4a\x2a\x13\x28\x71\x21"
+			"\x24\x72\x39\xe1\x1c\x9e\xf8\x28\x02\x04\x4b\x66\xef\x35\x7e\x5b"
+			"\x19\x44\x98\xd0\x68\x26\x11\x38\x23\x48\x57\x2a\x7b\x16\x11\xde"
+			"\x54\x76\x40\x94\x28\x63\x20\x57\x8a\x86\x3f\x36\x56\x2b\x0d\xf6",
+		.prk_size = 64,
+		.okm  = "\xf5\xfa\x02\xb1\x82\x98\xa7\x2a\x8c\x23\x89\x8a\x87\x03\x47\x2c"
+			"\x6e\xb1\x79\xdc\x20\x4c\x03\x42\x5c\x97\x0e\x3b\x16\x4b\xf9\x0f"
+			"\xff\x22\xd0\x48\x36\xd0\xe2\x34\x3b\xac",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with short input",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 11,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x67\x40\x9c\x9c\xac\x28\xb5\x2e\xe9\xfa\xd9\x1c\x2f\xda\x99\x9f"
+			"\x7c\xa2\x2e\x34\x34\xf0\xae\x77\x28\x63\x83\x65\x68\xad\x6a\x7f"
+			"\x10\xcf\x11\x3b\xfd\xdd\x56\x01\x29\xa5\x94\xa8\xf5\x23\x85\xc2"
+			"\xd6\x61\xd7\x85\xd2\x9c\xe9\x3a\x11\x40\x0c\x92\x06\x83\x18\x1d",
+		.prk_size = 64,
+		.okm  = "\x74\x13\xe8\x99\x7e\x02\x06\x10\xfb\xf6\x82\x3f\x2c\xe1\x4b\xff"
+			"\x01\x87\x5d\xb1\xca\x55\xf6\x8c\xfc\xf3\x95\x4d\xc8\xaf\xf5\x35"
+			"\x59\xbd\x5e\x30\x28\xb0\x80\xf7\xc0\x68",
+		.okm_size = 42,
+	}, {
+		.test = "unsalted hkdf test with zero info",
+		.ikm  = "\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c"
+			"\x0c\x0c\x0c\x0c\x0c\x0c",
+		.ikm_size = 22,
+		.salt = "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
+		.salt_size = 64,
+		.info = NULL,
+		.info_size = 0,
+		.prk  = "\x53\x46\xb3\x76\xbf\x3a\xa9\xf8\x4f\x8f\x6e\xd5\xb1\xc4\xf4\x89"
+			"\x17\x2e\x24\x4d\xac\x30\x3d\x12\xf6\x8e\xcc\x76\x6e\xa6\x00\xaa"
+			"\x88\x49\x5e\x7f\xb6\x05\x80\x31\x22\xfa\x13\x69\x24\xa8\x40\xb1"
+			"\xf0\x71\x9d\x2d\x5f\x68\xe2\x9b\x24\x22\x99\xd7\x58\xed\x68\x0c",
+		.prk_size = 64,
+		.okm  = "\x14\x07\xd4\x60\x13\xd9\x8b\xc6\xde\xce\xfc\xfe\xe5\x5f\x0f\x90"
+			"\xb0\xc7\xf6\x3d\x68\xeb\x1a\x80\xea\xf0\x7e\x95\x3c\xfc\x0a\x3a"
+			"\x52\x40\xa1\x55\xd6\xe4\xda\xa9\x65\xbb",
+		.okm_size = 42,
+	}
+};
+
+static int hkdf_test(const char *shash, const struct hkdf_testvec *tv)
+{	struct crypto_shash *tfm = NULL;
+	u8 *prk = NULL, *okm = NULL;
+	unsigned int prk_size;
+	const char *driver;
+	int err;
+
+	tfm = crypto_alloc_shash(shash, 0, 0);
+	if (IS_ERR(tfm)) {
+		pr_err("%s(%s): failed to allocate transform: %ld\n",
+		       tv->test, shash, PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+	driver = crypto_shash_driver_name(tfm);
+
+	prk_size = crypto_shash_digestsize(tfm);
+	prk = kzalloc(prk_size, GFP_KERNEL);
+	if (!prk) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	if (tv->prk_size != prk_size) {
+		pr_err("%s(%s): prk size mismatch (vec %u, digest %u\n",
+		       tv->test, driver, tv->prk_size, prk_size);
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	err = hkdf_extract(tfm, tv->ikm, tv->ikm_size,
+			   tv->salt, tv->salt_size, prk);
+	if (err) {
+		pr_err("%s(%s): hkdf_extract failed with %d\n",
+		       tv->test, driver, err);
+		goto out_free;
+	}
+
+	if (memcmp(prk, tv->prk, tv->prk_size)) {
+		pr_err("%s(%s): hkdf_extract prk mismatch\n",
+		       tv->test, driver);
+		print_hex_dump(KERN_ERR, "prk: ", DUMP_PREFIX_NONE,
+			       16, 1, prk, tv->prk_size, false);
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	okm = kzalloc(tv->okm_size, GFP_KERNEL);
+	if (!okm) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	err = crypto_shash_setkey(tfm, tv->prk, tv->prk_size);
+	if (err) {
+		pr_err("%s(%s): failed to set prk, error %d\n",
+		       tv->test, driver, err);
+		goto out_free;
+	}
+
+	err = hkdf_expand(tfm, tv->info, tv->info_size,
+			  okm, tv->okm_size);
+	if (err) {
+		pr_err("%s(%s): hkdf_expand() failed with %d\n",
+		       tv->test, driver, err);
+	} else if (memcmp(okm, tv->okm, tv->okm_size)) {
+		pr_err("%s(%s): hkdf_expand() okm mismatch\n",
+		       tv->test, driver);
+		print_hex_dump(KERN_ERR, "okm: ", DUMP_PREFIX_NONE,
+			       16, 1, okm, tv->okm_size, false);
+		err = -EINVAL;
+	}
+out_free:
+	kfree(okm);
+	kfree(prk);
+	crypto_free_shash(tfm);
+	return err;
+}
+
+static int __init crypto_hkdf_module_init(void)
+{
+	int ret = 0, i;
+
+	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(hkdf_sha256_tv); i++) {
+		ret = hkdf_test("hmac(sha256)", &hkdf_sha256_tv[i]);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(hkdf_sha384_tv); i++) {
+		ret = hkdf_test("hmac(sha384)", &hkdf_sha384_tv[i]);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < ARRAY_SIZE(hkdf_sha512_tv); i++) {
+		ret = hkdf_test("hmac(sha512)", &hkdf_sha512_tv[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void __exit crypto_hkdf_module_exit(void) {}
+
+module_init(crypto_hkdf_module_init);
+module_exit(crypto_hkdf_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HMAC-based Key Derivation Function (HKDF)");
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 5aff5934baa1..0ea56f588a4a 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -3,6 +3,7 @@ config FS_ENCRYPTION
 	bool "FS Encryption (Per-file encryption)"
 	select CRYPTO
 	select CRYPTO_HASH
+	select CRYPTO_HKDF
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_SHA256
 	select KEYS
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 5a384dad2c72..855a0f4b7318 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -1,9 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
- * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
- * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
- *
  * This is used to derive keys from the fscrypt master keys.
  *
  * Copyright 2019 Google LLC
@@ -11,6 +7,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha2.h>
+#include <crypto/hkdf.h>
 
 #include "fscrypt_private.h"
 
@@ -44,20 +41,6 @@
  * there's no way to persist a random salt per master key from kernel mode.
  */
 
-/* HKDF-Extract (RFC 5869 section 2.2), unsalted */
-static int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
-			unsigned int ikmlen, u8 prk[HKDF_HASHLEN])
-{
-	static const u8 default_salt[HKDF_HASHLEN];
-	int err;
-
-	err = crypto_shash_setkey(hmac_tfm, default_salt, HKDF_HASHLEN);
-	if (err)
-		return err;
-
-	return crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
-}
-
 /*
  * Compute HKDF-Extract using the given master key as the input keying material,
  * and prepare an HMAC transform object keyed by the resulting pseudorandom key.
@@ -69,6 +52,7 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 		      unsigned int master_key_size)
 {
 	struct crypto_shash *hmac_tfm;
+	static const u8 default_salt[HKDF_HASHLEN];
 	u8 prk[HKDF_HASHLEN];
 	int err;
 
@@ -84,7 +68,8 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 		goto err_free_tfm;
 	}
 
-	err = hkdf_extract(hmac_tfm, master_key, master_key_size, prk);
+	err = hkdf_extract(hmac_tfm, master_key, master_key_size,
+			   default_salt, HKDF_HASHLEN, prk);
 	if (err)
 		goto err_free_tfm;
 
@@ -118,61 +103,21 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			u8 *okm, unsigned int okmlen)
 {
 	SHASH_DESC_ON_STACK(desc, hkdf->hmac_tfm);
-	u8 prefix[9];
-	unsigned int i;
+	u8 *full_info;
 	int err;
-	const u8 *prev = NULL;
-	u8 counter = 1;
-	u8 tmp[HKDF_HASHLEN];
-
-	if (WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN))
-		return -EINVAL;
 
+	full_info = kzalloc(infolen + 9, GFP_KERNEL);
+	if (!full_info)
+		return -ENOMEM;
 	desc->tfm = hkdf->hmac_tfm;
 
-	memcpy(prefix, "fscrypt\0", 8);
-	prefix[8] = context;
-
-	for (i = 0; i < okmlen; i += HKDF_HASHLEN) {
-
-		err = crypto_shash_init(desc);
-		if (err)
-			goto out;
-
-		if (prev) {
-			err = crypto_shash_update(desc, prev, HKDF_HASHLEN);
-			if (err)
-				goto out;
-		}
-
-		err = crypto_shash_update(desc, prefix, sizeof(prefix));
-		if (err)
-			goto out;
-
-		err = crypto_shash_update(desc, info, infolen);
-		if (err)
-			goto out;
-
-		BUILD_BUG_ON(sizeof(counter) != 1);
-		if (okmlen - i < HKDF_HASHLEN) {
-			err = crypto_shash_finup(desc, &counter, 1, tmp);
-			if (err)
-				goto out;
-			memcpy(&okm[i], tmp, okmlen - i);
-			memzero_explicit(tmp, sizeof(tmp));
-		} else {
-			err = crypto_shash_finup(desc, &counter, 1, &okm[i]);
-			if (err)
-				goto out;
-		}
-		counter++;
-		prev = &okm[i];
-	}
-	err = 0;
-out:
-	if (unlikely(err))
-		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
-	shash_desc_zero(desc);
+	memcpy(full_info, "fscrypt\0", 8);
+	full_info[8] = context;
+	memcpy(full_info + 9, info, infolen);
+
+	err = hkdf_expand(hkdf->hmac_tfm, full_info, infolen + 9,
+			  okm, okmlen);
+	kfree_sensitive(full_info);
 	return err;
 }
 
diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
new file mode 100644
index 000000000000..6a9678f508f5
--- /dev/null
+++ b/include/crypto/hkdf.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HKDF: HMAC-based Key Derivation Function (HKDF), RFC 5869
+ *
+ * Extracted from fs/crypto/hkdf.c, which has
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _CRYPTO_HKDF_H
+#define _CRYPTO_HKDF_H
+
+#include <crypto/hash.h>
+
+int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
+		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
+		 u8 *prk);
+int hkdf_expand(struct crypto_shash *hmac_tfm,
+		const u8 *info, unsigned int infolen,
+		u8 *okm, unsigned int okmlen);
+#endif
-- 
2.35.3


