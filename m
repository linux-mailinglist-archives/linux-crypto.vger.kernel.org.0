Return-Path: <linux-crypto+bounces-307-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F07F9BD5
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD711C20839
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA46171AC
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H7+h9Bh0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE021BF7
	for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc34b6890so6559505ad.1
        for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068872; x=1701673672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65aClSoG7Vvogs/9DSpZCzSUcof37h/9Wvainxt/D1s=;
        b=H7+h9Bh00LE8XR7Jr/vBNO2taq3FUyH8g0iUjXm7Os3QHcR0RlIrXXGT61SP8IPi28
         xrY09NcEU+fW6ayTRmLyGCJrvcLbkeVikGZuT5wpd+/Ix0zyPktUU+M3HVBu5tyE1hGj
         WOnAdPluO5L2nejsKOjdsFMPIPutyS+ZoomZUHR0HcyoG/f/J+OXfDE0berae91+ntjl
         SygPY0Zipe/WL15rg0R9crrcR4EeUzODaJfz9crQJF+EwFWYezDs4Q3kBPBz/oRYKDMT
         hfu5Oic44rutV8jgym3/FiHaF1Gb+zKZs8KjKXOcBio1zeFIqCjZA2a2VgEDIYcihec3
         oOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068872; x=1701673672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65aClSoG7Vvogs/9DSpZCzSUcof37h/9Wvainxt/D1s=;
        b=Ep21AAH7dujrgOTdMBnzQtvfrLiGnHXKo82dvgcrgfYhaUBVnk5Ef+RrA0sMJEyWbI
         xaYk6Rk+Q8Vax8i7jhHqN5nAuP2yKNQ5eBjd4C0yRY1WieK6uTJCMpMIu51CLyqHmgub
         XIMF7J62C0sIpii4u24/DXHrKm3XBfZWI8xCSiHpdE8xWaXpNMy9lhQnC9nxb/PXSS7d
         P9AuOQsInelAMOHS11BW+r2BHZhfiR4COI1N06zNKLB/2Q0sqUL+65GARWSQgy2gBiyh
         OnFhQtulVDWR8JSzj7D8o0BFi3hLbQYFj/jsw1zTc93+HAg6DVY/HpDTwWA9B37GAu12
         rWAg==
X-Gm-Message-State: AOJu0YzCIx2+Xfv9/dERM3GXZ7y69hTkdrkpnqH2QH+/DsRgrdNwbL+8
	nc3DcuxVAhc43UDAuuGmSlGXeQ==
X-Google-Smtp-Source: AGHT+IHcnauxtqQExXlH4Csib1LUNoeakDZRIE0yrXb2DtrTMmRFI7ZHKdBCpbiQLIdAZt7kTNKppQ==
X-Received: by 2002:a17:902:c942:b0:1cd:f823:456d with SMTP id i2-20020a170902c94200b001cdf823456dmr14867788pla.20.1701068872601;
        Sun, 26 Nov 2023 23:07:52 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:52 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 13/13] RISC-V: crypto: add Zvkb accelerated ChaCha20 implementation
Date: Mon, 27 Nov 2023 15:07:03 +0800
Message-Id: <20231127070703.1697-14-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a ChaCha20 vector implementation from OpenSSL(openssl/openssl#21923).

Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v2:
 - Do not turn on kconfig `CHACHA20_RISCV64` option by default.
 - Use simd skcipher interface.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Reorder structure riscv64_chacha_alg_zvkb members initialization in
   the order declared.
 - Use smaller iv buffer instead of whole state matrix as chacha20's
   input.
---
 arch/riscv/crypto/Kconfig                |  12 +
 arch/riscv/crypto/Makefile               |   7 +
 arch/riscv/crypto/chacha-riscv64-glue.c  | 122 +++++++++
 arch/riscv/crypto/chacha-riscv64-zvkb.pl | 321 +++++++++++++++++++++++
 4 files changed, 462 insertions(+)
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 7415fb303785..1932297a1e73 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -34,6 +34,18 @@ config CRYPTO_AES_BLOCK_RISCV64
 	  - Zvkb vector crypto extension (CTR/XTS)
 	  - Zvkg vector crypto extension (XTS)
 
+config CRYPTO_CHACHA20_RISCV64
+	tristate "Ciphers: ChaCha20"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_SIMD
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	help
+	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
+
+	  Architecture: riscv64 using:
+	  - Zvkb vector crypto extension
+
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
 	depends on 64BIT && RISCV_ISA_V
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index b1f857695c1c..748c53aa38dc 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,6 +9,9 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
+obj-$(CONFIG_CRYPTO_CHACHA20_RISCV64) += chacha-riscv64.o
+chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
+
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
@@ -36,6 +39,9 @@ $(obj)/aes-riscv64-zvkned-zvbb-zvkg.S: $(src)/aes-riscv64-zvkned-zvbb-zvkg.pl
 $(obj)/aes-riscv64-zvkned-zvkb.S: $(src)/aes-riscv64-zvkned-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/chacha-riscv64-zvkb.S: $(src)/chacha-riscv64-zvkb.pl
+	$(call cmd,perlasm)
+
 $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 	$(call cmd,perlasm)
 
@@ -54,6 +60,7 @@ $(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
+clean-files += chacha-riscv64-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha_or_zvknhb-zvkb.S
 clean-files += sha512-riscv64-zvknhb-zvkb.S
diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/crypto/chacha-riscv64-glue.c
new file mode 100644
index 000000000000..96047cb75222
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-glue.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Port of the OpenSSL ChaCha20 implementation for RISC-V 64
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/chacha.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/* chacha20 using zvkb vector crypto extension */
+asmlinkage void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t len,
+				    const u32 *key, const u32 *counter);
+
+static int chacha20_encrypt(struct skcipher_request *req)
+{
+	u32 iv[CHACHA_IV_SIZE / sizeof(u32)];
+	u8 block_buffer[CHACHA_BLOCK_SIZE];
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	unsigned int tail_bytes;
+	int err;
+
+	iv[0] = get_unaligned_le32(req->iv);
+	iv[1] = get_unaligned_le32(req->iv + 4);
+	iv[2] = get_unaligned_le32(req->iv + 8);
+	iv[3] = get_unaligned_le32(req->iv + 12);
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while (walk.nbytes) {
+		nbytes = walk.nbytes & (~(CHACHA_BLOCK_SIZE - 1));
+		tail_bytes = walk.nbytes & (CHACHA_BLOCK_SIZE - 1);
+		kernel_vector_begin();
+		if (nbytes) {
+			ChaCha20_ctr32_zvkb(walk.dst.virt.addr,
+					    walk.src.virt.addr, nbytes,
+					    ctx->key, iv);
+			iv[0] += nbytes / CHACHA_BLOCK_SIZE;
+		}
+		if (walk.nbytes == walk.total && tail_bytes > 0) {
+			memcpy(block_buffer, walk.src.virt.addr + nbytes,
+			       tail_bytes);
+			ChaCha20_ctr32_zvkb(block_buffer, block_buffer,
+					    CHACHA_BLOCK_SIZE, ctx->key, iv);
+			memcpy(walk.dst.virt.addr + nbytes, block_buffer,
+			       tail_bytes);
+			tail_bytes = 0;
+		}
+		kernel_vector_end();
+
+		err = skcipher_walk_done(&walk, tail_bytes);
+	}
+
+	return err;
+}
+
+static struct skcipher_alg riscv64_chacha_alg_zvkb[] = {
+	{
+		.setkey = chacha20_setkey,
+		.encrypt = chacha20_encrypt,
+		.decrypt = chacha20_encrypt,
+		.min_keysize = CHACHA_KEY_SIZE,
+		.max_keysize = CHACHA_KEY_SIZE,
+		.ivsize = CHACHA_IV_SIZE,
+		.chunksize = CHACHA_BLOCK_SIZE,
+		.walksize = CHACHA_BLOCK_SIZE * 4,
+		.base = {
+			.cra_flags = CRYPTO_ALG_INTERNAL,
+			.cra_blocksize = 1,
+			.cra_ctxsize = sizeof(struct chacha_ctx),
+			.cra_priority = 300,
+			.cra_name = "__chacha20",
+			.cra_driver_name = "__chacha20-riscv64-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct simd_skcipher_alg
+	*riscv64_chacha_simd_alg_zvkb[ARRAY_SIZE(riscv64_chacha_alg_zvkb)];
+
+static inline bool check_chacha20_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_chacha_mod_init(void)
+{
+	if (check_chacha20_ext())
+		return simd_register_skciphers_compat(
+			riscv64_chacha_alg_zvkb,
+			ARRAY_SIZE(riscv64_chacha_alg_zvkb),
+			riscv64_chacha_simd_alg_zvkb);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_chacha_mod_fini(void)
+{
+	simd_unregister_skciphers(riscv64_chacha_alg_zvkb,
+				  ARRAY_SIZE(riscv64_chacha_alg_zvkb),
+				  riscv64_chacha_simd_alg_zvkb);
+}
+
+module_init(riscv64_chacha_mod_init);
+module_exit(riscv64_chacha_mod_fini);
+
+MODULE_DESCRIPTION("ChaCha20 (RISC-V accelerated)");
+MODULE_AUTHOR("Jerry Shih <jerry.shih@sifive.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("chacha20");
diff --git a/arch/riscv/crypto/chacha-riscv64-zvkb.pl b/arch/riscv/crypto/chacha-riscv64-zvkb.pl
new file mode 100644
index 000000000000..6602ef79452f
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-zvkb.pl
@@ -0,0 +1,321 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023-2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License").  You may not use
+# this file except in compliance with the License.  You can obtain a copy
+# in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output  = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop   : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.|          ? shift : undef;
+
+$output and open STDOUT, ">$output";
+
+my $code = <<___;
+.text
+___
+
+# void ChaCha20_ctr32_zvkb(unsigned char *out, const unsigned char *inp,
+#                          size_t len, const unsigned int key[8],
+#                          const unsigned int counter[4]);
+################################################################################
+my ( $OUTPUT, $INPUT, $LEN, $KEY, $COUNTER ) = ( "a0", "a1", "a2", "a3", "a4" );
+my ( $T0 ) = ( "t0" );
+my ( $CONST_DATA0, $CONST_DATA1, $CONST_DATA2, $CONST_DATA3 ) =
+  ( "a5", "a6", "a7", "t1" );
+my ( $KEY0, $KEY1, $KEY2,$KEY3, $KEY4, $KEY5, $KEY6, $KEY7,
+     $COUNTER0, $COUNTER1, $NONCE0, $NONCE1
+) = ( "s0", "s1", "s2", "s3", "s4", "s5", "s6",
+    "s7", "s8", "s9", "s10", "s11" );
+my ( $VL, $STRIDE, $CHACHA_LOOP_COUNT ) = ( "t2", "t3", "t4" );
+my (
+    $V0,  $V1,  $V2,  $V3,  $V4,  $V5,  $V6,  $V7,  $V8,  $V9,  $V10,
+    $V11, $V12, $V13, $V14, $V15, $V16, $V17, $V18, $V19, $V20, $V21,
+    $V22, $V23, $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map( "v$_", ( 0 .. 31 ) );
+
+sub chacha_quad_round_group {
+    my (
+        $A0, $B0, $C0, $D0, $A1, $B1, $C1, $D1,
+        $A2, $B2, $C2, $D2, $A3, $B3, $C3, $D3
+    ) = @_;
+
+    my $code = <<___;
+    # a += b; d ^= a; d <<<= 16;
+    @{[vadd_vv $A0, $A0, $B0]}
+    @{[vadd_vv $A1, $A1, $B1]}
+    @{[vadd_vv $A2, $A2, $B2]}
+    @{[vadd_vv $A3, $A3, $B3]}
+    @{[vxor_vv $D0, $D0, $A0]}
+    @{[vxor_vv $D1, $D1, $A1]}
+    @{[vxor_vv $D2, $D2, $A2]}
+    @{[vxor_vv $D3, $D3, $A3]}
+    @{[vror_vi $D0, $D0, 32 - 16]}
+    @{[vror_vi $D1, $D1, 32 - 16]}
+    @{[vror_vi $D2, $D2, 32 - 16]}
+    @{[vror_vi $D3, $D3, 32 - 16]}
+    # c += d; b ^= c; b <<<= 12;
+    @{[vadd_vv $C0, $C0, $D0]}
+    @{[vadd_vv $C1, $C1, $D1]}
+    @{[vadd_vv $C2, $C2, $D2]}
+    @{[vadd_vv $C3, $C3, $D3]}
+    @{[vxor_vv $B0, $B0, $C0]}
+    @{[vxor_vv $B1, $B1, $C1]}
+    @{[vxor_vv $B2, $B2, $C2]}
+    @{[vxor_vv $B3, $B3, $C3]}
+    @{[vror_vi $B0, $B0, 32 - 12]}
+    @{[vror_vi $B1, $B1, 32 - 12]}
+    @{[vror_vi $B2, $B2, 32 - 12]}
+    @{[vror_vi $B3, $B3, 32 - 12]}
+    # a += b; d ^= a; d <<<= 8;
+    @{[vadd_vv $A0, $A0, $B0]}
+    @{[vadd_vv $A1, $A1, $B1]}
+    @{[vadd_vv $A2, $A2, $B2]}
+    @{[vadd_vv $A3, $A3, $B3]}
+    @{[vxor_vv $D0, $D0, $A0]}
+    @{[vxor_vv $D1, $D1, $A1]}
+    @{[vxor_vv $D2, $D2, $A2]}
+    @{[vxor_vv $D3, $D3, $A3]}
+    @{[vror_vi $D0, $D0, 32 - 8]}
+    @{[vror_vi $D1, $D1, 32 - 8]}
+    @{[vror_vi $D2, $D2, 32 - 8]}
+    @{[vror_vi $D3, $D3, 32 - 8]}
+    # c += d; b ^= c; b <<<= 7;
+    @{[vadd_vv $C0, $C0, $D0]}
+    @{[vadd_vv $C1, $C1, $D1]}
+    @{[vadd_vv $C2, $C2, $D2]}
+    @{[vadd_vv $C3, $C3, $D3]}
+    @{[vxor_vv $B0, $B0, $C0]}
+    @{[vxor_vv $B1, $B1, $C1]}
+    @{[vxor_vv $B2, $B2, $C2]}
+    @{[vxor_vv $B3, $B3, $C3]}
+    @{[vror_vi $B0, $B0, 32 - 7]}
+    @{[vror_vi $B1, $B1, 32 - 7]}
+    @{[vror_vi $B2, $B2, 32 - 7]}
+    @{[vror_vi $B3, $B3, 32 - 7]}
+___
+
+    return $code;
+}
+
+$code .= <<___;
+.p2align 3
+.globl ChaCha20_ctr32_zvkb
+.type ChaCha20_ctr32_zvkb,\@function
+ChaCha20_ctr32_zvkb:
+    srli $LEN, $LEN, 6
+    beqz $LEN, .Lend
+
+    addi sp, sp, -96
+    sd s0, 0(sp)
+    sd s1, 8(sp)
+    sd s2, 16(sp)
+    sd s3, 24(sp)
+    sd s4, 32(sp)
+    sd s5, 40(sp)
+    sd s6, 48(sp)
+    sd s7, 56(sp)
+    sd s8, 64(sp)
+    sd s9, 72(sp)
+    sd s10, 80(sp)
+    sd s11, 88(sp)
+
+    li $STRIDE, 64
+
+    #### chacha block data
+    # "expa" little endian
+    li $CONST_DATA0, 0x61707865
+    # "nd 3" little endian
+    li $CONST_DATA1, 0x3320646e
+    # "2-by" little endian
+    li $CONST_DATA2, 0x79622d32
+    # "te k" little endian
+    li $CONST_DATA3, 0x6b206574
+
+    lw $KEY0, 0($KEY)
+    lw $KEY1, 4($KEY)
+    lw $KEY2, 8($KEY)
+    lw $KEY3, 12($KEY)
+    lw $KEY4, 16($KEY)
+    lw $KEY5, 20($KEY)
+    lw $KEY6, 24($KEY)
+    lw $KEY7, 28($KEY)
+
+    lw $COUNTER0, 0($COUNTER)
+    lw $COUNTER1, 4($COUNTER)
+    lw $NONCE0, 8($COUNTER)
+    lw $NONCE1, 12($COUNTER)
+
+.Lblock_loop:
+    @{[vsetvli $VL, $LEN, "e32", "m1", "ta", "ma"]}
+
+    # init chacha const states
+    @{[vmv_v_x $V0, $CONST_DATA0]}
+    @{[vmv_v_x $V1, $CONST_DATA1]}
+    @{[vmv_v_x $V2, $CONST_DATA2]}
+    @{[vmv_v_x $V3, $CONST_DATA3]}
+
+    # init chacha key states
+    @{[vmv_v_x $V4, $KEY0]}
+    @{[vmv_v_x $V5, $KEY1]}
+    @{[vmv_v_x $V6, $KEY2]}
+    @{[vmv_v_x $V7, $KEY3]}
+    @{[vmv_v_x $V8, $KEY4]}
+    @{[vmv_v_x $V9, $KEY5]}
+    @{[vmv_v_x $V10, $KEY6]}
+    @{[vmv_v_x $V11, $KEY7]}
+
+    # init chacha key states
+    @{[vid_v $V12]}
+    @{[vadd_vx $V12, $V12, $COUNTER0]}
+    @{[vmv_v_x $V13, $COUNTER1]}
+
+    # init chacha nonce states
+    @{[vmv_v_x $V14, $NONCE0]}
+    @{[vmv_v_x $V15, $NONCE1]}
+
+    # load the top-half of input data
+    @{[vlsseg_nf_e32_v 8, $V16, $INPUT, $STRIDE]}
+
+    li $CHACHA_LOOP_COUNT, 10
+.Lround_loop:
+    addi $CHACHA_LOOP_COUNT, $CHACHA_LOOP_COUNT, -1
+    @{[chacha_quad_round_group
+      $V0, $V4, $V8, $V12,
+      $V1, $V5, $V9, $V13,
+      $V2, $V6, $V10, $V14,
+      $V3, $V7, $V11, $V15]}
+    @{[chacha_quad_round_group
+      $V0, $V5, $V10, $V15,
+      $V1, $V6, $V11, $V12,
+      $V2, $V7, $V8, $V13,
+      $V3, $V4, $V9, $V14]}
+    bnez $CHACHA_LOOP_COUNT, .Lround_loop
+
+    # load the bottom-half of input data
+    addi $T0, $INPUT, 32
+    @{[vlsseg_nf_e32_v 8, $V24, $T0, $STRIDE]}
+
+    # add chacha top-half initial block states
+    @{[vadd_vx $V0, $V0, $CONST_DATA0]}
+    @{[vadd_vx $V1, $V1, $CONST_DATA1]}
+    @{[vadd_vx $V2, $V2, $CONST_DATA2]}
+    @{[vadd_vx $V3, $V3, $CONST_DATA3]}
+    @{[vadd_vx $V4, $V4, $KEY0]}
+    @{[vadd_vx $V5, $V5, $KEY1]}
+    @{[vadd_vx $V6, $V6, $KEY2]}
+    @{[vadd_vx $V7, $V7, $KEY3]}
+    # xor with the top-half input
+    @{[vxor_vv $V16, $V16, $V0]}
+    @{[vxor_vv $V17, $V17, $V1]}
+    @{[vxor_vv $V18, $V18, $V2]}
+    @{[vxor_vv $V19, $V19, $V3]}
+    @{[vxor_vv $V20, $V20, $V4]}
+    @{[vxor_vv $V21, $V21, $V5]}
+    @{[vxor_vv $V22, $V22, $V6]}
+    @{[vxor_vv $V23, $V23, $V7]}
+
+    # save the top-half of output
+    @{[vssseg_nf_e32_v 8, $V16, $OUTPUT, $STRIDE]}
+
+    # add chacha bottom-half initial block states
+    @{[vadd_vx $V8, $V8, $KEY4]}
+    @{[vadd_vx $V9, $V9, $KEY5]}
+    @{[vadd_vx $V10, $V10, $KEY6]}
+    @{[vadd_vx $V11, $V11, $KEY7]}
+    @{[vid_v $V0]}
+    @{[vadd_vx $V12, $V12, $COUNTER0]}
+    @{[vadd_vx $V13, $V13, $COUNTER1]}
+    @{[vadd_vx $V14, $V14, $NONCE0]}
+    @{[vadd_vx $V15, $V15, $NONCE1]}
+    @{[vadd_vv $V12, $V12, $V0]}
+    # xor with the bottom-half input
+    @{[vxor_vv $V24, $V24, $V8]}
+    @{[vxor_vv $V25, $V25, $V9]}
+    @{[vxor_vv $V26, $V26, $V10]}
+    @{[vxor_vv $V27, $V27, $V11]}
+    @{[vxor_vv $V29, $V29, $V13]}
+    @{[vxor_vv $V28, $V28, $V12]}
+    @{[vxor_vv $V30, $V30, $V14]}
+    @{[vxor_vv $V31, $V31, $V15]}
+
+    # save the bottom-half of output
+    addi $T0, $OUTPUT, 32
+    @{[vssseg_nf_e32_v 8, $V24, $T0, $STRIDE]}
+
+    # update counter
+    add $COUNTER0, $COUNTER0, $VL
+    sub $LEN, $LEN, $VL
+    # increase offset for `4 * 16 * VL = 64 * VL`
+    slli $T0, $VL, 6
+    add $INPUT, $INPUT, $T0
+    add $OUTPUT, $OUTPUT, $T0
+    bnez $LEN, .Lblock_loop
+
+    ld s0, 0(sp)
+    ld s1, 8(sp)
+    ld s2, 16(sp)
+    ld s3, 24(sp)
+    ld s4, 32(sp)
+    ld s5, 40(sp)
+    ld s6, 48(sp)
+    ld s7, 56(sp)
+    ld s8, 64(sp)
+    ld s9, 72(sp)
+    ld s10, 80(sp)
+    ld s11, 88(sp)
+    addi sp, sp, 96
+
+.Lend:
+    ret
+.size ChaCha20_ctr32_zvkb,.-ChaCha20_ctr32_zvkb
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0


