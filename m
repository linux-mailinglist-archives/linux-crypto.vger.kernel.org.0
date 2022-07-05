Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950FF5660C3
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jul 2022 03:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiGEBrg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Jul 2022 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGEBrf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Jul 2022 21:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14A101D4
        for <linux-crypto@vger.kernel.org>; Mon,  4 Jul 2022 18:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C81A0B810AF
        for <linux-crypto@vger.kernel.org>; Tue,  5 Jul 2022 01:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036F2C3411E;
        Tue,  5 Jul 2022 01:47:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cAbT6qii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656985648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pzsmRfJzdNCt1kJBVZ7x9qPkjkblMZ1ORlr7GktJ6W4=;
        b=cAbT6qiiFs3awhhtbZQfdfJHyOKwgDOl74pzRneHrhzFFyERRarEF3Tu6pefsVThNtZtPk
        lBh1rWWdlVaFA1Q/RqVURTWCtP7q6JbRirRf1RW80xUvZsPSxLQIcUMJes2/JZU6W2fyom
        IPpAnMb57IG2dGqndJswo18+BLF5BFA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c16b7b67 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 5 Jul 2022 01:47:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH crypto 5.19] crypto: s390 - do not depend on CRYPTO_HW for SIMD implementations
Date:   Tue,  5 Jul 2022 03:46:53 +0200
Message-Id: <20220705014653.111335-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Various accelerated software implementation Kconfig values for S390 were
mistakenly placed into drivers/crypto/Kconfig, even though they're
mainly just SIMD code and live in arch/s390/crypto/ like usual. This
gives them the very unusual dependency on CRYPTO_HW, which leads to
problems elsewhere.

This patch fixes the issue by moving the Kconfig values for non-hardware
drivers into the usual place in crypto/Kconfig.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 crypto/Kconfig         | 114 ++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/Kconfig | 115 -----------------------------------------
 2 files changed, 114 insertions(+), 115 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1d44893a997b..7b81685b5655 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -666,6 +666,18 @@ config CRYPTO_CRC32_MIPS
 	  CRC32c and CRC32 CRC algorithms implemented using mips crypto
 	  instructions, when available.
 
+config CRYPTO_CRC32_S390
+	tristate "CRC-32 algorithms"
+	depends on S390
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  Select this option if you want to use hardware accelerated
+	  implementations of CRC algorithms.  With this option, you
+	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
+	  and CRC-32C (Castagnoli).
+
+	  It is available with IBM z13 or later.
 
 config CRYPTO_XXHASH
 	tristate "xxHash hash algorithm"
@@ -898,6 +910,16 @@ config CRYPTO_SHA512_SSSE3
 	  Extensions version 1 (AVX1), or Advanced Vector Extensions
 	  version 2 (AVX2) instructions, when available.
 
+config CRYPTO_SHA512_S390
+	tristate "SHA384 and SHA512 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA512 secure hash standard.
+
+	  It is available as of z10.
+
 config CRYPTO_SHA1_OCTEON
 	tristate "SHA1 digest algorithm (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
@@ -930,6 +952,16 @@ config CRYPTO_SHA1_PPC_SPE
 	  SHA-1 secure hash standard (DFIPS 180-4) implemented
 	  using powerpc SPE SIMD instruction set.
 
+config CRYPTO_SHA1_S390
+	tristate "SHA1 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+
+	  It is available as of z990.
+
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
@@ -970,6 +1002,16 @@ config CRYPTO_SHA256_SPARC64
 	  SHA-256 secure hash standard (DFIPS 180-2) implemented
 	  using sparc64 crypto instructions, when available.
 
+config CRYPTO_SHA256_S390
+	tristate "SHA256 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA256 secure hash standard (DFIPS 180-2).
+
+	  It is available as of z9.
+
 config CRYPTO_SHA512
 	tristate "SHA384 and SHA512 digest algorithms"
 	select CRYPTO_HASH
@@ -1010,6 +1052,26 @@ config CRYPTO_SHA3
 	  References:
 	  http://keccak.noekeon.org/
 
+config CRYPTO_SHA3_256_S390
+	tristate "SHA3_224 and SHA3_256 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA3_256 secure hash standard.
+
+	  It is available as of z14.
+
+config CRYPTO_SHA3_512_S390
+	tristate "SHA3_384 and SHA3_512 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA3_512 secure hash standard.
+
+	  It is available as of z14.
+
 config CRYPTO_SM3
 	tristate
 
@@ -1070,6 +1132,16 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 	  This is the x86_64 CLMUL-NI accelerated implementation of
 	  GHASH, the hash function used in GCM (Galois/Counter mode).
 
+config CRYPTO_GHASH_S390
+	tristate "GHASH hash function"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of GHASH,
+	  the hash function used in GCM (Galois/Counter mode).
+
+	  It is available as of z196.
+
 comment "Ciphers"
 
 config CRYPTO_AES
@@ -1185,6 +1257,23 @@ config CRYPTO_AES_PPC_SPE
 	  architecture specific assembler implementations that work on 1KB
 	  tables or 256 bytes S-boxes.
 
+config CRYPTO_AES_S390
+	tristate "AES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  AES cipher algorithms (FIPS-197).
+
+	  As of z9 the ECB and CBC modes are hardware accelerated
+	  for 128 bit keys.
+	  As of z10 the ECB and CBC modes are hardware accelerated
+	  for all AES key sizes.
+	  As of z196 the CTR mode is hardware accelerated for all AES
+	  key sizes and XTS mode is hardware accelerated for 256 and
+	  512 bit keys.
+
 config CRYPTO_ANUBIS
 	tristate "Anubis cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1415,6 +1504,19 @@ config CRYPTO_DES3_EDE_X86_64
 	  algorithm are provided; regular processing one input block and
 	  one that processes three blocks parallel.
 
+config CRYPTO_DES_S390
+	tristate "DES and Triple DES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_DES
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+
+	  As of z990 the ECB and CBC mode are hardware accelerated.
+	  As of z196 the CTR mode is hardware accelerated.
+
 config CRYPTO_FCRYPT
 	tristate "FCrypt cipher algorithm"
 	select CRYPTO_ALGAPI
@@ -1474,6 +1576,18 @@ config CRYPTO_CHACHA_MIPS
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
+config CRYPTO_CHACHA_S390
+	tristate "ChaCha20 stream cipher"
+	depends on S390
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  This is the s390 SIMD implementation of the ChaCha20 stream
+	  cipher (RFC 7539).
+
+	  It is available as of z13.
+
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index ee99c02c84e8..3e6aa319920b 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -133,98 +133,6 @@ config CRYPTO_PAES_S390
 	  Select this option if you want to use the paes cipher
 	  for example to use protected key encrypted devices.
 
-config CRYPTO_SHA1_S390
-	tristate "SHA1 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
-
-	  It is available as of z990.
-
-config CRYPTO_SHA256_S390
-	tristate "SHA256 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA256 secure hash standard (DFIPS 180-2).
-
-	  It is available as of z9.
-
-config CRYPTO_SHA512_S390
-	tristate "SHA384 and SHA512 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA512 secure hash standard.
-
-	  It is available as of z10.
-
-config CRYPTO_SHA3_256_S390
-	tristate "SHA3_224 and SHA3_256 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_256 secure hash standard.
-
-	  It is available as of z14.
-
-config CRYPTO_SHA3_512_S390
-	tristate "SHA3_384 and SHA3_512 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_512 secure hash standard.
-
-	  It is available as of z14.
-
-config CRYPTO_DES_S390
-	tristate "DES and Triple DES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_DES
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
-
-	  As of z990 the ECB and CBC mode are hardware accelerated.
-	  As of z196 the CTR mode is hardware accelerated.
-
-config CRYPTO_AES_S390
-	tristate "AES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  AES cipher algorithms (FIPS-197).
-
-	  As of z9 the ECB and CBC modes are hardware accelerated
-	  for 128 bit keys.
-	  As of z10 the ECB and CBC modes are hardware accelerated
-	  for all AES key sizes.
-	  As of z196 the CTR mode is hardware accelerated for all AES
-	  key sizes and XTS mode is hardware accelerated for 256 and
-	  512 bit keys.
-
-config CRYPTO_CHACHA_S390
-	tristate "ChaCha20 stream cipher"
-	depends on S390
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  This is the s390 SIMD implementation of the ChaCha20 stream
-	  cipher (RFC 7539).
-
-	  It is available as of z13.
-
 config S390_PRNG
 	tristate "Pseudo random number generator device driver"
 	depends on S390
@@ -238,29 +146,6 @@ config S390_PRNG
 
 	  It is available as of z9.
 
-config CRYPTO_GHASH_S390
-	tristate "GHASH hash function"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of GHASH,
-	  the hash function used in GCM (Galois/Counter mode).
-
-	  It is available as of z196.
-
-config CRYPTO_CRC32_S390
-	tristate "CRC-32 algorithms"
-	depends on S390
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  Select this option if you want to use hardware accelerated
-	  implementations of CRC algorithms.  With this option, you
-	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
-	  and CRC-32C (Castagnoli).
-
-	  It is available with IBM z13 or later.
-
 config CRYPTO_DEV_NIAGARA2
 	tristate "Niagara2 Stream Processing Unit driver"
 	select CRYPTO_LIB_DES
-- 
2.35.1

