Return-Path: <linux-crypto+bounces-12013-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E9A9447C
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Apr 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C5F179579
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Apr 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888521E0E14;
	Sat, 19 Apr 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrPT0/Cy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472271DFE20;
	Sat, 19 Apr 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079454; cv=none; b=GmkrRjXKcV1IPVTJ+L9+0+hSZF5B6Wq3kShnpNfaGoZlUFgDyZ6ySx48yuXVDDoGJm0SZu2GcEL9+94wByx6TO4nW8MFoQQK7N2sZULqWtjJH0FxPE/ChsMrgCdDyRr2USi/c/sFGdz2qDlZJ9LUriJqPGAq1/mKfvTDd1g2Zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079454; c=relaxed/simple;
	bh=I3PlMZtGBwQ0VoD5S3H7Kd+Kw85TXV6dUPiiZk7OQX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV5oOna8Arpvq/xmfnelO4YDrg6oxkHS7M9GkQFiQMw6cLqP67eI2+2/vTVNQrF63EQU7/YLWgmkbKwO2Zy0jaEt+IwdRmncyI4yVIoX9+vSqu7aMBsX4uN0xnYR9Uz+upSGq97jmbFF8sycNvXfR7RuD+ZrMdJujkf6MLAqU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrPT0/Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EDC4CEEC;
	Sat, 19 Apr 2025 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745079453;
	bh=I3PlMZtGBwQ0VoD5S3H7Kd+Kw85TXV6dUPiiZk7OQX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrPT0/CyV9tNE+ezX4SRJWhwPpdDcFfZ4GPvWro0UbKDt5Xs6zN/cmpfuRe3sL1x/
	 xq/a9JKC8WmKYHIyPMbZ8nQpBOtbYMb7zXy1UCCwFD2WbtbIFfDMzn3HyDzqGNctrp
	 EKsnIw0otcQbm+mbPnP+lCWfYuN7VwKNNXObaVc1VyVsnfeiEZ57+DqmsWUhpVggnI
	 Pvh7wxAIC/aQgOLOJvHd1ZmhvpuSP7b5ZhoaDvEgxktpsDBqJGY6FzST+1mnfSJICu
	 tG3pP6dTQqZ+xr6iuku8Uu3q8mFO3pDCmPfTFD4bYmGEjfilGQlb1zYsRoZyXiyONK
	 9W08EAc9tUfiA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] crypto: testmgr - replace CRYPTO_MANAGER_DISABLE_TESTS with CRYPTO_SELFTESTS
Date: Sat, 19 Apr 2025 09:15:39 -0700
Message-ID: <20250419161543.139344-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419161543.139344-1-ebiggers@kernel.org>
References: <20250419161543.139344-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The negative-sense of CRYPTO_MANAGER_DISABLE_TESTS is a longstanding
mistake that regularly causes confusion.  Especially bad is that you can
have CRYPTO=n && CRYPTO_MANAGER_DISABLE_TESTS=n, which is ambiguous.

Replace CRYPTO_MANAGER_DISABLE_TESTS with CRYPTO_SELFTESTS which has the
expected behavior.

The tests continue to be disabled by default.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig                | 23 ++++++++++++++---------
 crypto/algapi.c               |  4 ++--
 crypto/algboss.c              |  2 +-
 crypto/api.c                  |  3 +--
 crypto/hkdf.c                 |  2 +-
 crypto/internal.h             |  5 ++---
 crypto/kdf_sp800108.c         |  2 +-
 crypto/testmgr.c              | 12 ++++++------
 lib/crypto/Makefile           |  8 +++-----
 lib/crypto/aescfb.c           |  2 +-
 lib/crypto/aesgcm.c           |  2 +-
 lib/crypto/blake2s.c          |  2 +-
 lib/crypto/chacha20poly1305.c |  2 +-
 lib/crypto/curve25519.c       |  2 +-
 14 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 48283975fb2b..8bac10e4c1cc 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -23,11 +23,11 @@ if CRYPTO
 
 menu "Crypto core or helper"
 
 config CRYPTO_FIPS
 	bool "FIPS 200 compliance"
-	depends on (CRYPTO_ANSI_CPRNG || CRYPTO_DRBG) && !CRYPTO_MANAGER_DISABLE_TESTS
+	depends on (CRYPTO_ANSI_CPRNG || CRYPTO_DRBG) && CRYPTO_SELFTESTS
 	depends on (MODULE_SIG || !MODULES)
 	help
 	  This option enables the fips boot option which is
 	  required if you want the system to operate in a FIPS 200
 	  certification.  You should say no unless you know what
@@ -141,12 +141,12 @@ config CRYPTO_ACOMP
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 
 config CRYPTO_HKDF
 	tristate
-	select CRYPTO_SHA256 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
-	select CRYPTO_SHA512 if !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+	select CRYPTO_SHA256 if CRYPTO_SELFTESTS
+	select CRYPTO_SHA512 if CRYPTO_SELFTESTS
 	select CRYPTO_HASH2
 
 config CRYPTO_MANAGER
 	tristate "Cryptographic algorithm manager"
 	select CRYPTO_MANAGER2
@@ -171,20 +171,25 @@ config CRYPTO_USER
 	select CRYPTO_MANAGER
 	help
 	  Userspace configuration for cryptographic instantiations such as
 	  cbc(aes).
 
-config CRYPTO_MANAGER_DISABLE_TESTS
-	bool "Disable run-time self tests"
-	default y
+config CRYPTO_SELFTESTS
+	bool "Enable crypto self-tests"
 	help
-	  Disable run-time self tests that normally take place at
-	  algorithm registration.
+	  Enable the cryptographic self-tests.
+
+	  The cryptographic self-tests run at boot time, or at algorithm
+	  registration time if algorithms are dynamically loaded later.
+
+	  This is primarily intended for developer use.  It should not be
+	  enabled in production kernels, unless you are trying to use these
+	  tests to fulfill a FIPS testing requirement.
 
 config CRYPTO_MANAGER_EXTRA_TESTS
 	bool "Enable extra run-time crypto self tests"
-	depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS && CRYPTO_MANAGER
+	depends on DEBUG_KERNEL && CRYPTO_SELFTESTS && CRYPTO_MANAGER
 	help
 	  Enable extra run-time self tests of registered crypto algorithms,
 	  including randomized fuzz tests.
 
 	  This is intended for developer use only, as these tests take much
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 532d3efc3c7d..9030a30c89e8 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -273,11 +273,11 @@ static void crypto_alg_finish_registration(struct crypto_alg *alg,
 static struct crypto_larval *crypto_alloc_test_larval(struct crypto_alg *alg)
 {
 	struct crypto_larval *larval;
 
 	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER) ||
-	    IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) ||
+	    !IS_ENABLED(CONFIG_CRYPTO_SELFTESTS) ||
 	    (alg->cra_flags & CRYPTO_ALG_INTERNAL))
 		return NULL; /* No self-test needed */
 
 	larval = crypto_larval_alloc(alg->cra_name,
 				     alg->cra_flags | CRYPTO_ALG_TESTED, 0);
@@ -1057,11 +1057,11 @@ EXPORT_SYMBOL_GPL(crypto_type_has_alg);
 static void __init crypto_start_tests(void)
 {
 	if (!IS_BUILTIN(CONFIG_CRYPTO_ALGAPI))
 		return;
 
-	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+	if (!IS_ENABLED(CONFIG_CRYPTO_SELFTESTS))
 		return;
 
 	set_crypto_boot_test_finished();
 
 	for (;;) {
diff --git a/crypto/algboss.c b/crypto/algboss.c
index a20926bfd34e..14b131c5d86a 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -187,11 +187,11 @@ static int cryptomgr_test(void *data)
 static int cryptomgr_schedule_test(struct crypto_alg *alg)
 {
 	struct task_struct *thread;
 	struct crypto_test_param *param;
 
-	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+	if (!IS_ENABLED(CONFIG_CRYPTO_SELFTESTS))
 		return NOTIFY_DONE;
 
 	if (!try_module_get(THIS_MODULE))
 		goto err;
 
diff --git a/crypto/api.c b/crypto/api.c
index e427cc5662b5..038db19e375f 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -29,12 +29,11 @@ DECLARE_RWSEM(crypto_alg_sem);
 EXPORT_SYMBOL_GPL(crypto_alg_sem);
 
 BLOCKING_NOTIFIER_HEAD(crypto_chain);
 EXPORT_SYMBOL_GPL(crypto_chain);
 
-#if IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) && \
-    !IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS)
+#if IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) && IS_ENABLED(CONFIG_CRYPTO_SELFTESTS)
 DEFINE_STATIC_KEY_FALSE(__crypto_boot_test_finished);
 #endif
 
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg,
 					     u32 type, u32 mask);
diff --git a/crypto/hkdf.c b/crypto/hkdf.c
index 2434c5c42545..f24c2a8d4df9 100644
--- a/crypto/hkdf.c
+++ b/crypto/hkdf.c
@@ -541,11 +541,11 @@ static int hkdf_test(const char *shash, const struct hkdf_testvec *tv)
 
 static int __init crypto_hkdf_module_init(void)
 {
 	int ret = 0, i;
 
-	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+	if (!IS_ENABLED(CONFIG_CRYPTO_SELFTESTS))
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(hkdf_sha256_tv); i++) {
 		ret = hkdf_test("hmac(sha256)", &hkdf_sha256_tv[i]);
 		if (ret)
diff --git a/crypto/internal.h b/crypto/internal.h
index 2ed79bf208ca..b9afd68767c1 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -65,12 +65,11 @@ extern struct list_head crypto_alg_list;
 extern struct rw_semaphore crypto_alg_sem;
 extern struct blocking_notifier_head crypto_chain;
 
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask);
 
-#if !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) || \
-    IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS)
+#if !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) || !IS_ENABLED(CONFIG_CRYPTO_SELFTESTS)
 static inline bool crypto_boot_test_finished(void)
 {
 	return true;
 }
 static inline void set_crypto_boot_test_finished(void)
@@ -85,11 +84,11 @@ static inline bool crypto_boot_test_finished(void)
 static inline void set_crypto_boot_test_finished(void)
 {
 	static_branch_enable(&__crypto_boot_test_finished);
 }
 #endif /* !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) ||
-	* IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS)
+	* !IS_ENABLED(CONFIG_CRYPTO_SELFTESTS)
 	*/
 
 #ifdef CONFIG_PROC_FS
 void __init crypto_init_proc(void);
 void __exit crypto_exit_proc(void);
diff --git a/crypto/kdf_sp800108.c b/crypto/kdf_sp800108.c
index c3f9938e1ad2..b7a6bf9da773 100644
--- a/crypto/kdf_sp800108.c
+++ b/crypto/kdf_sp800108.c
@@ -125,11 +125,11 @@ static const struct kdf_testvec kdf_ctr_hmac_sha256_tv_template[] = {
 
 static int __init crypto_kdf108_init(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+	if (!IS_ENABLED(CONFIG_CRYPTO_SELFTESTS))
 		return 0;
 
 	ret = kdf_test(&kdf_ctr_hmac_sha256_tv_template[0], "hmac(sha256)",
 		       crypto_kdf108_setkey, crypto_kdf108_ctr_generate);
 	if (ret) {
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index d075c48ff1a2..1b2f7a4724d8 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -53,11 +53,11 @@ MODULE_PARM_DESC(noextratests, "disable expensive crypto self-tests");
 static unsigned int fuzz_iterations = 100;
 module_param(fuzz_iterations, uint, 0644);
 MODULE_PARM_DESC(fuzz_iterations, "number of fuzz test iterations");
 #endif
 
-#ifdef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+#ifndef CONFIG_CRYPTO_SELFTESTS
 
 /* a perfect nop */
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 {
 	return 0;
@@ -319,14 +319,14 @@ struct testvec_config {
 
 #define TESTVEC_CONFIG_NAMELEN	192
 
 /*
  * The following are the lists of testvec_configs to test for each algorithm
- * type when the basic crypto self-tests are enabled, i.e. when
- * CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is unset.  They aim to provide good test
- * coverage, while keeping the test time much shorter than the full fuzz tests
- * so that the basic tests can be enabled in a wider range of circumstances.
+ * type when the basic crypto self-tests are enabled.  They aim to provide good
+ * test coverage, while keeping the test time much shorter than the full fuzz
+ * tests so that the basic tests can be enabled in a wider range of
+ * circumstances.
  */
 
 /* Configs for skciphers and aeads */
 static const struct testvec_config default_cipher_testvec_configs[] = {
 	{
@@ -5903,8 +5903,8 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 	return 0;
 non_fips_alg:
 	return alg_fips_disabled(driver, alg);
 }
 
-#endif /* CONFIG_CRYPTO_MANAGER_DISABLE_TESTS */
+#endif /* CONFIG_CRYPTO_SELFTESTS */
 
 EXPORT_SYMBOL_GPL(alg_test);
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 4dd62bc5bee3..5a41bf5bf819 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -49,15 +49,13 @@ obj-$(CONFIG_CRYPTO_LIB_SHA1)			+= libsha1.o
 libsha1-y					:= sha1.o
 
 obj-$(CONFIG_CRYPTO_LIB_SHA256)			+= libsha256.o
 libsha256-y					:= sha256.o
 
-ifneq ($(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS),y)
-libblake2s-y					+= blake2s-selftest.o
-libchacha20poly1305-y				+= chacha20poly1305-selftest.o
-libcurve25519-y					+= curve25519-selftest.o
-endif
+libblake2s-$(CONFIG_CRYPTO_SELFTESTS)		+= blake2s-selftest.o
+libchacha20poly1305-$(CONFIG_CRYPTO_SELFTESTS)	+= chacha20poly1305-selftest.o
+libcurve25519-$(CONFIG_CRYPTO_SELFTESTS)	+= curve25519-selftest.o
 
 obj-$(CONFIG_MPILIB) += mpi/
 
 obj-$(CONFIG_CRYPTO_MANAGER_EXTRA_TESTS)	+= simd.o
 
diff --git a/lib/crypto/aescfb.c b/lib/crypto/aescfb.c
index 749dc1258a44..437613265e14 100644
--- a/lib/crypto/aescfb.c
+++ b/lib/crypto/aescfb.c
@@ -97,11 +97,11 @@ EXPORT_SYMBOL(aescfb_decrypt);
 
 MODULE_DESCRIPTION("Generic AES-CFB library");
 MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
 MODULE_LICENSE("GPL");
 
-#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+#ifdef CONFIG_CRYPTO_SELFTESTS
 
 /*
  * Test code below. Vectors taken from crypto/testmgr.h
  */
 
diff --git a/lib/crypto/aesgcm.c b/lib/crypto/aesgcm.c
index 902e49410aaf..277824d6b4af 100644
--- a/lib/crypto/aesgcm.c
+++ b/lib/crypto/aesgcm.c
@@ -197,11 +197,11 @@ EXPORT_SYMBOL(aesgcm_decrypt);
 
 MODULE_DESCRIPTION("Generic AES-GCM library");
 MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
 MODULE_LICENSE("GPL");
 
-#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+#ifdef CONFIG_CRYPTO_SELFTESTS
 
 /*
  * Test code below. Vectors taken from crypto/testmgr.h
  */
 
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 71a316552cc5..b0f9a678300b 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -58,11 +58,11 @@ void blake2s_final(struct blake2s_state *state, u8 *out)
 }
 EXPORT_SYMBOL(blake2s_final);
 
 static int __init blake2s_mod_init(void)
 {
-	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
+	if (IS_ENABLED(CONFIG_CRYPTO_SELFTESTS) &&
 	    WARN_ON(!blake2s_selftest()))
 		return -ENODEV;
 	return 0;
 }
 
diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
index 9cfa886f1f89..57a84fee179e 100644
--- a/lib/crypto/chacha20poly1305.c
+++ b/lib/crypto/chacha20poly1305.c
@@ -353,11 +353,11 @@ bool chacha20poly1305_decrypt_sg_inplace(struct scatterlist *src, size_t src_len
 }
 EXPORT_SYMBOL(chacha20poly1305_decrypt_sg_inplace);
 
 static int __init chacha20poly1305_init(void)
 {
-	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
+	if (IS_ENABLED(CONFIG_CRYPTO_SELFTESTS) &&
 	    WARN_ON(!chacha20poly1305_selftest()))
 		return -ENODEV;
 	return 0;
 }
 
diff --git a/lib/crypto/curve25519.c b/lib/crypto/curve25519.c
index 064b352c6907..6850b76a80c9 100644
--- a/lib/crypto/curve25519.c
+++ b/lib/crypto/curve25519.c
@@ -13,11 +13,11 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
 static int __init curve25519_init(void)
 {
-	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
+	if (IS_ENABLED(CONFIG_CRYPTO_SELFTESTS) &&
 	    WARN_ON(!curve25519_selftest()))
 		return -ENODEV;
 	return 0;
 }
 
-- 
2.49.0


