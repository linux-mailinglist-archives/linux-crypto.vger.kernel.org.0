Return-Path: <linux-crypto+bounces-7253-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189499A865
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2024 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915861C236DC
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2024 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9119750B;
	Fri, 11 Oct 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbZWoXS2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF45381E
	for <linux-crypto@vger.kernel.org>; Fri, 11 Oct 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662090; cv=none; b=SRo9uHQVOJCOzC4CDmg8zUZ9rzEc9KBaHRD5NDohz8FE65TV8mCyyol4N2DQfFa0VBbtQwfywgxgfX/g3ccq91O7ekd2oTXmLeYX//9fJia967fXA1a2FfItzFSn4e7bUT8qb9vCuc/vgwQBXg/ad0e89hcSCv3+uaiidu7dx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662090; c=relaxed/simple;
	bh=WhNIzj65gNWGnme5rU2vZs15hIARWTj0Zm3oMbadQ9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWVMQinEjct4/rgk44EhgXuGNSaH3ZPhn2Rcolj240Rngyb0WoCe66nFEyZsXnDsUIl1TEHo/1Rz9+41gb7ljCDSD1ncvT2mbG9fRHn3JujFI46xL7hLho8HFx7e/R08TVPm/cKrNMWHZAIwIKnwUwLWYVFiYvbqo7OcTmqLiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbZWoXS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E65C4CED0;
	Fri, 11 Oct 2024 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662090;
	bh=WhNIzj65gNWGnme5rU2vZs15hIARWTj0Zm3oMbadQ9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbZWoXS2Duf0ixSoe3EGWtND/WiF/cjW/WFeGnzp5EIYkF9/TNcTq7GOCMIQsao0g
	 ocwVyg63AZciL/7VKbaP4yqPRtBfmMRhlMSETEZBMsq2BGbHxJGSdJCSeDlVIQrCTv
	 SiXp1iZei7AVfr1OJhxr4CDQCD0/Pzjh1OYx2/BP+bYEinObUvXdf6nta5ZacPo9W8
	 XJeGai5Dzwqno9pkPP2QeiMEmx2VVrh/g2+z8Q8JtMzrKVLMwyzBBWjegzdUXYF37H
	 er86lr2AY31ERQdTVQ/sfF7B0HCVe3xe/6Rm+aJu2zofrsjqGuUK3MNKfG6jlLlSnB
	 59h8596BJG7zw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
Date: Fri, 11 Oct 2024 17:54:22 +0200
Message-Id: <20241011155430.43450-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241011155430.43450-1-hare@kernel.org>
References: <20241011155430.43450-1-hare@kernel.org>
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
from RFC 5869 to ensure the integrity of the algorithm.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org
---
 crypto/Kconfig        |   6 +
 crypto/Makefile       |   1 +
 crypto/hkdf.c         | 402 ++++++++++++++++++++++++++++++++++++++++++
 fs/crypto/Kconfig     |   1 +
 fs/crypto/hkdf.c      |  85 ++-------
 include/crypto/hkdf.h |  18 ++
 6 files changed, 443 insertions(+), 70 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a779cab668c2..bdcee33085b6 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -141,6 +141,12 @@ config CRYPTO_ACOMP
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 
+config CRYPTO_HKDF
+	tristate
+	select CRYPTO_SHA1 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
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
index 000000000000..26dc84f441ed
--- /dev/null
+++ b/crypto/hkdf.c
@@ -0,0 +1,402 @@
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
+	u8 tmp[HASH_MAX_DIGESTSIZE];
+
+	if (WARN_ON(okmlen > 255 * hashlen ||
+		    hashlen > HASH_MAX_DIGESTSIZE))
+		return -EINVAL;
+
+	memzero_explicit(tmp, HASH_MAX_DIGESTSIZE);
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
+			"\x70\x71\x72\x73\x74\x75\x76\x77,\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
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
+		.prk = "\x06\xa6\xb8\x8c\x58\x53\x36\x1a\x06\x10\x4c\x9c\xeb\x35\xb4\x5c"
+			"\xef\x76\x00\x14\x90\x46\x71\x01\x4a\x19\x3f\x40\xc1\x5f\xc2\x44",
+		.prk_size = 32,
+		.okm = "\xb1\x1e\x39\x8d\xc8\x03\x27\xa1\xc8\xe7\xf7\x8c\x59\x6a\x49\x34"
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
+		.prk = "\0x19\xef\x24\xa3\x2c\x71\x7b\x16\x7f\x33\xa9\x1d\x6f\x64\x8b\xdf"
+			"\x96\x59\x67\x76\xaf\xdb\x63\x77\xac\x43\x4c\x1c\x29\x3c\xcb\x04",
+		.prk_size = 32,
+		.okm = "\x8d\xa4\xe7\x75\xa5\x63\xc1\x8f\x71\x5f\x80\x2a\x06\x3c\x5a\x31"
+			"\xb8\xa1\x1f\x5c\x5e\xe1\x87\x9e\xc3\x45\x4e\x5f\x3c\x73\x8d\x2d"
+			"\x9d\x20\x13\x95\xfa\xa4\xb6\x1a\x96\xc8",
+		.okm_size = 42,
+	}
+};
+
+static const struct hkdf_testvec hkdf_sha1_tv[] = {
+	{
+		.test = "basic hkdf test",
+		.ikm  = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 11,
+		.salt = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c",
+		.salt_size = 13,
+		.info = "\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9",
+		.info_size = 10,
+		.prk  = "\x9b\x6c\x18\xc4\x32\xa7\xbf\x8f\x0e\x71\xc8\xeb\x88\xf4\xb3\x0b"
+			"\xaa\x2b\xa2\x43",
+		.prk_size = 20,
+		.okm  = "\x08\x5a\x01\xea\x1b\x10\xf3\x69\x33\x06\x8b\x56\xef\xa5\xad\x81"
+			"\xa4\xf1\x4b\x82\x2f\x5b\x09\x15\x68\xa9\xcd\xd4\xf1\x55\xfd\xa2"
+			"\xc2\x2e\x42\x24\x78\xd3\x05\xf3\xf8\x96",
+		.okm_size = 42,
+	}, {
+		.test = "hkdf test with long input",
+		.ikm = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
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
+		.prk  = "\x8a\xda\xe0\x9a\x2a\x30\x70\x59\x47\x8d\x30\x9b\x26\xc4\x11\x5a"
+			"\x22\x4c\xfa\xf6",
+		.prk_size = 20,
+		.okm = "\x0b\xd7\x70\xa7\x4d\x11\x60\xf7\xc9\xf1\x2c\xd5\x91\x2a\x06\xeb"
+			"\xff\x6a\xdc\xae\x89\x9d\x92\x19\x1f\xe4\x30\x56\x73\xba\x2f\xfe"
+			"\x8f\xa3\xf1\xa4\xe5\xad\x79\xf3\xf3\x34\xb3\xb2\x02\xb2\x17\x3c"
+			"\x48\x6e\xa3\x7c\xe3\xd3\x97\xed\x03\x4c\x7f\x9d\xfe\xb1\x5c\x5e"
+			"\x92\x73\x36\xd0\x44\x1f\x4c\x43\x00\xe2\xcf\xf0\xd0\x90\x0b\x52"
+			"\xd3\xb4",
+		.okm_size = 82,
+	}, {
+		.test = "hkdf test with zero salt and info",
+		.ikm = "\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b\x0b"
+			"\x0b\x0b\x0b\x0b\x0b\x0b",
+		.ikm_size = 22,
+		.salt = NULL,
+		.salt_size = 0,
+		.info = NULL,
+		.info_size = 0,
+		.prk = "\xda\x8c\x8a\x73\xc7\xfa\x77\x28\x8e\xc6\xf5\xe7\xc2\x97\x78\x6a"
+			"\xa0\xd3\x2d\x01",
+		.prk_size = 20,
+		.okm = "\x0a\xc1\xaf\x70\x02\xb3\xd7\x61\xd1\xe5\x52\x98\xda\x9d\x05\x06"
+			"\xb9\xae\x52\x05\x72\x20\xa3\x06\xe0\x7b\x6b\x87\xe8\xdf\x21\xd0"
+			"\xea\x00\x03\x3d\xe0\x39\x84\xd3\x49\x18",
+		.okm_size = 42,
+	}, {
+		.test = "unsalted hkdf test with zero info",
+		.ikm = "\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c\x0c"
+			"\x0c\x0c\x0c\x0c\x0c\x0c",
+		.ikm_size = 22,
+		.salt = "\0x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+			"\x00\x00\x00\x00",
+		.salt_size = 20,
+		.info = NULL,
+		.info_size = 0,
+		.prk = "\x2a\xdc\xca\xda\x18\x77\x9e\x7c\x20\x77\xad\x2e\xb1\x9d\x3f\x3e"
+			"\x73\x13\x85\xdd",
+		.prk_size = 20,
+		.okm = "\x2c\x91\x11\x72\x04\xd7\x45\xf3\x50\x0d\x63\x6a\x62\xf6\x4f\x0a"
+			"\xb3\xba\xe5\x48\xaa\x53\xd4\x23\xb0\xd1\xf2\x7e\xbb\xa6\xf5\xe5"
+			"\x67\x3a\x08\x1d\x70\xcc\xe7\xac\xfc\x48",
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
+		print_hex_dump(KERN_ERR, "okm: ", DUMP_PREFIX_NONE, 16, 1, okm, tv->okm_size, false);
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
+	for (i = 0; i < ARRAY_SIZE(hkdf_sha1_tv); i++) {
+		ret = hkdf_test("hmac(sha1)", &hkdf_sha1_tv[i]);
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
+MODULE_ALIAS_CRYPTO("hkdf");
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
index 000000000000..c1f23a32a6b6
--- /dev/null
+++ b/include/crypto/hkdf.h
@@ -0,0 +1,18 @@
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
+int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
+		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
+		 u8 *prk);
+int hkdf_expand(struct crypto_shash *hmac_tfm,
+		const u8 *info, unsigned int infolen,
+		u8 *okm, unsigned int okmlen);
+#endif
-- 
2.35.3


