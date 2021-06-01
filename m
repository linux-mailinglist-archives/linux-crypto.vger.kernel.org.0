Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE008391472
	for <lists+linux-crypto@lfdr.de>; Wed, 26 May 2021 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhEZKJO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 May 2021 06:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhEZKJL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 May 2021 06:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19C286144B;
        Wed, 26 May 2021 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622023660;
        bh=zZsfTRIWpr/rVpn9y1ymm+6HWbjDGZwu3+fT61XPcQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSTKzmWzlYOfrr3JVFlK6x3nmdS2bSave1weOqQMWlvWgrHx4CXoEEJimPZM8PgIZ
         Uaf0j+hLHL9h+XkXXRoTHrRW5Lpp4NecnitUkyeZ07ahYy4t+lZevxuZNrFxRAJrf2
         rH9lFUcCsekgR/GTnQENdE3Cipo15/BGr/8wgmlUjtVzMA25tCpq6UkuOLH3sLwjSG
         EJYKZAZCZ1lVXJlBxkxRDkHkwyA6Oi2sawcRGhDhfilbmmNW5pNp00xQNgWtuReKGp
         Zd5iSoDH5wFWhWbbrLvqVE0yWjVPYEaUucB06dos7acEEKUt3DfoJ2ko4Q6FMtYVQH
         jrKDqZtvJWPUg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, will@kernel.org,
        kernel-team@android.com, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v6 3/6] crypto: arm64/aes-ce - stop using SIMD helper for skciphers
Date:   Wed, 26 May 2021 12:07:26 +0200
Message-Id: <20210526100729.12939-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526100729.12939-1-ardb@kernel.org>
References: <20210526100729.12939-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Calls into the skcipher API can only occur from contexts where the SIMD
unit is available, so there is no need for the SIMD helper.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/Kconfig    |   4 -
 arch/arm64/crypto/aes-glue.c | 102 +++-----------------
 2 files changed, 13 insertions(+), 93 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index ed1e8cadeb3a..454621a20eaa 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -88,16 +88,12 @@ config CRYPTO_AES_ARM64_CE_BLK
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_CE
-	select CRYPTO_AES_ARM64
-	select CRYPTO_SIMD
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
-	select CRYPTO_AES_ARM64
 	select CRYPTO_LIB_AES
-	select CRYPTO_SIMD
 
 config CRYPTO_CHACHA20_NEON
 	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index 17e735931a0c..30b7cc6a7079 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -444,7 +444,7 @@ static int __maybe_unused essiv_cbc_decrypt(struct skcipher_request *req)
 	return err ?: cbc_decrypt_walk(req, &walk);
 }
 
-static int ctr_encrypt(struct skcipher_request *req)
+static int __maybe_unused ctr_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -485,29 +485,6 @@ static int ctr_encrypt(struct skcipher_request *req)
 	return err;
 }
 
-static void ctr_encrypt_one(struct crypto_skcipher *tfm, const u8 *src, u8 *dst)
-{
-	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	unsigned long flags;
-
-	/*
-	 * Temporarily disable interrupts to avoid races where
-	 * cachelines are evicted when the CPU is interrupted
-	 * to do something else.
-	 */
-	local_irq_save(flags);
-	aes_encrypt(ctx, dst, src);
-	local_irq_restore(flags);
-}
-
-static int __maybe_unused ctr_encrypt_sync(struct skcipher_request *req)
-{
-	if (!crypto_simd_usable())
-		return crypto_ctr_encrypt_walk(req, ctr_encrypt_one);
-
-	return ctr_encrypt(req);
-}
-
 static int __maybe_unused xts_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -656,10 +633,9 @@ static int __maybe_unused xts_decrypt(struct skcipher_request *req)
 static struct skcipher_alg aes_algs[] = { {
 #if defined(USE_V8_CRYPTO_EXTENSIONS) || !IS_ENABLED(CONFIG_CRYPTO_AES_ARM64_BS)
 	.base = {
-		.cra_name		= "__ecb(aes)",
-		.cra_driver_name	= "__ecb-aes-" MODE,
+		.cra_name		= "ecb(aes)",
+		.cra_driver_name	= "ecb-aes-" MODE,
 		.cra_priority		= PRIO,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
 		.cra_module		= THIS_MODULE,
@@ -671,10 +647,9 @@ static struct skcipher_alg aes_algs[] = { {
 	.decrypt	= ecb_decrypt,
 }, {
 	.base = {
-		.cra_name		= "__cbc(aes)",
-		.cra_driver_name	= "__cbc-aes-" MODE,
+		.cra_name		= "cbc(aes)",
+		.cra_driver_name	= "cbc-aes-" MODE,
 		.cra_priority		= PRIO,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
 		.cra_module		= THIS_MODULE,
@@ -687,10 +662,9 @@ static struct skcipher_alg aes_algs[] = { {
 	.decrypt	= cbc_decrypt,
 }, {
 	.base = {
-		.cra_name		= "__ctr(aes)",
-		.cra_driver_name	= "__ctr-aes-" MODE,
+		.cra_name		= "ctr(aes)",
+		.cra_driver_name	= "ctr-aes-" MODE,
 		.cra_priority		= PRIO,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
 		.cra_module		= THIS_MODULE,
@@ -704,26 +678,9 @@ static struct skcipher_alg aes_algs[] = { {
 	.decrypt	= ctr_encrypt,
 }, {
 	.base = {
-		.cra_name		= "ctr(aes)",
-		.cra_driver_name	= "ctr-aes-" MODE,
-		.cra_priority		= PRIO - 1,
-		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
-		.cra_module		= THIS_MODULE,
-	},
-	.min_keysize	= AES_MIN_KEY_SIZE,
-	.max_keysize	= AES_MAX_KEY_SIZE,
-	.ivsize		= AES_BLOCK_SIZE,
-	.chunksize	= AES_BLOCK_SIZE,
-	.setkey		= skcipher_aes_setkey,
-	.encrypt	= ctr_encrypt_sync,
-	.decrypt	= ctr_encrypt_sync,
-}, {
-	.base = {
-		.cra_name		= "__xts(aes)",
-		.cra_driver_name	= "__xts-aes-" MODE,
+		.cra_name		= "xts(aes)",
+		.cra_driver_name	= "xts-aes-" MODE,
 		.cra_priority		= PRIO,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_xts_ctx),
 		.cra_module		= THIS_MODULE,
@@ -738,10 +695,9 @@ static struct skcipher_alg aes_algs[] = { {
 }, {
 #endif
 	.base = {
-		.cra_name		= "__cts(cbc(aes))",
-		.cra_driver_name	= "__cts-cbc-aes-" MODE,
+		.cra_name		= "cts(cbc(aes))",
+		.cra_driver_name	= "cts-cbc-aes-" MODE,
 		.cra_priority		= PRIO,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_ctx),
 		.cra_module		= THIS_MODULE,
@@ -755,10 +711,9 @@ static struct skcipher_alg aes_algs[] = { {
 	.decrypt	= cts_cbc_decrypt,
 }, {
 	.base = {
-		.cra_name		= "__essiv(cbc(aes),sha256)",
-		.cra_driver_name	= "__essiv-cbc-aes-sha256-" MODE,
+		.cra_name		= "essiv(cbc(aes),sha256)",
+		.cra_driver_name	= "essiv-cbc-aes-sha256-" MODE,
 		.cra_priority		= PRIO + 1,
-		.cra_flags		= CRYPTO_ALG_INTERNAL,
 		.cra_blocksize		= AES_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct crypto_aes_essiv_cbc_ctx),
 		.cra_module		= THIS_MODULE,
@@ -997,28 +952,15 @@ static struct shash_alg mac_algs[] = { {
 	.descsize		= sizeof(struct mac_desc_ctx),
 } };
 
-static struct simd_skcipher_alg *aes_simd_algs[ARRAY_SIZE(aes_algs)];
-
 static void aes_exit(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aes_simd_algs); i++)
-		if (aes_simd_algs[i])
-			simd_skcipher_free(aes_simd_algs[i]);
-
 	crypto_unregister_shashes(mac_algs, ARRAY_SIZE(mac_algs));
 	crypto_unregister_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 }
 
 static int __init aes_init(void)
 {
-	struct simd_skcipher_alg *simd;
-	const char *basename;
-	const char *algname;
-	const char *drvname;
 	int err;
-	int i;
 
 	err = crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 	if (err)
@@ -1028,26 +970,8 @@ static int __init aes_init(void)
 	if (err)
 		goto unregister_ciphers;
 
-	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
-		if (!(aes_algs[i].base.cra_flags & CRYPTO_ALG_INTERNAL))
-			continue;
-
-		algname = aes_algs[i].base.cra_name + 2;
-		drvname = aes_algs[i].base.cra_driver_name + 2;
-		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
-		err = PTR_ERR(simd);
-		if (IS_ERR(simd))
-			goto unregister_simds;
-
-		aes_simd_algs[i] = simd;
-	}
-
 	return 0;
 
-unregister_simds:
-	aes_exit();
-	return err;
 unregister_ciphers:
 	crypto_unregister_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
 	return err;
-- 
2.20.1

