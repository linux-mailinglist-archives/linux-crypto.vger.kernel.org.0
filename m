Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009E7D7370
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Oct 2023 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjJYSjC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Oct 2023 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjJYSib (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Oct 2023 14:38:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8E172E
        for <linux-crypto@vger.kernel.org>; Wed, 25 Oct 2023 11:37:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so95058a12.1
        for <linux-crypto@vger.kernel.org>; Wed, 25 Oct 2023 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259064; x=1698863864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt3WTfvjOI4LHPOMyEbRdhIq5hHcz3LzqQvN0TjWHcA=;
        b=kmqU2GTAA3zJ6DhfUM2XtTT9eX5DUOeyQVNJlC4dam4VL4wBlOfoOjhoR7IqHy62PH
         OVoSTot4sv+cbpsjVCHEM48KLrTrUJ3dTpXV5AwllttK5Wz2lejRynaLT4BaDmStUffV
         RCJokDmwcQZuw6906hGMxIgxuAOSRGRTxrc+P0JF4wE9+j/QukQUIOxRC84vgE/Iwiiq
         EbLugRWGk6CWv8j1HOPT64PtyKgy69my8QAPcDvfn0QUJojSvMjRpS/dAg87XZwzkVeL
         ZflsBvibo3bChHV72YxlIoC4K3ighhwHPjrvo4SyAz5BxRBqNpxByqQyY62PK8fH/Wog
         Nj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259064; x=1698863864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt3WTfvjOI4LHPOMyEbRdhIq5hHcz3LzqQvN0TjWHcA=;
        b=QylwnQDbjp/iHLXC9ZFHz6jaY+XQ4T14qGoMKPmu3A8Xj/pBO+TiyBwOa77owRdXy4
         7kUUxv4jSzGU3+msRhAiHlyJlOJV/EHofp1nwBdfkw6AX/gG5ZA/UqH9enVYLEsWkVj3
         2XOqQ5w60A2efsAmjX7lveY0lRJ0/eR4d2FFj2LkskXF0980hTj3QoMzL4HEjcVT/MsD
         iRCMIVg5s2ADHMmno9HAy5f25RHMQAI5aIkgRWFO4arPwH30jEJMudlf7iU93UWk6jhM
         pBn36ebEjJdBhZYCwqBOUEAnnFVgJuC9FK9Jx27ICENmpWLHMZ1p2jzCAoL41+NmmBfj
         3Tiw==
X-Gm-Message-State: AOJu0YzYNG9Rf6UKFtAZuH1z2g2Lix1mRGKCAH10NDxpsgAbjb2x0pwa
        a4Hh3b7pcYi4UDNKvR1bZYIDjw==
X-Google-Smtp-Source: AGHT+IFqpwEuw2xGu3F8rzTjT0tmzzxKRCVTrSIiTxria3fgff4tabeHnvS5oCOlsSllxSVw8iiIsg==
X-Received: by 2002:a17:90a:a38d:b0:27d:3a34:2194 with SMTP id x13-20020a17090aa38d00b0027d3a342194mr15580807pjp.14.1698259064157;
        Wed, 25 Oct 2023 11:37:44 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:43 -0700 (PDT)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ebiggers@kernel.org, ardb@kernel.org,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20 implementation
Date:   Thu, 26 Oct 2023 02:36:44 +0800
Message-Id: <20231025183644.8735-13-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add a ChaCha20 vector implementation from OpenSSL(openssl/openssl#21923).

Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/crypto/Kconfig                |  12 +
 arch/riscv/crypto/Makefile               |   7 +
 arch/riscv/crypto/chacha-riscv64-glue.c  | 120 +++++++++
 arch/riscv/crypto/chacha-riscv64-zvkb.pl | 322 +++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 2797b37394bb..41ce453afafa 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -35,6 +35,18 @@ config CRYPTO_AES_BLOCK_RISCV64
 	  - Zvkg vector crypto extension (XTS)
 	  - Zvkned vector crypto extension
 
+config CRYPTO_CHACHA20_RISCV64
+	default y if RISCV_ISA_V
+	tristate "Ciphers: ChaCha20"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	help
+	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
+
+	  Architecture: riscv64 using:
+	  - Zvkb vector crypto extension
+
 config CRYPTO_GHASH_RISCV64
 	default y if RISCV_ISA_V
 	tristate "Hash functions: GHASH"
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index b772417703fd..80b0ebc956a3 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,6 +9,9 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvbb-zvkg-zvkned.o aes-riscv64-zvkb-zvkned.o
 
+obj-$(CONFIG_CRYPTO_CHACHA20_RISCV64) += chacha-riscv64.o
+chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
+
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
@@ -36,6 +39,9 @@ $(obj)/aes-riscv64-zvbb-zvkg-zvkned.S: $(src)/aes-riscv64-zvbb-zvkg-zvkned.pl
 $(obj)/aes-riscv64-zvkb-zvkned.S: $(src)/aes-riscv64-zvkb-zvkned.pl
 	$(call cmd,perlasm)
 
+$(obj)/chacha-riscv64-zvkb.S: $(src)/chacha-riscv64-zvkb.pl
+	$(call cmd,perlasm)
+
 $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 	$(call cmd,perlasm)
 
@@ -54,6 +60,7 @@ $(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvbb-zvkg-zvkned.S
 clean-files += aes-riscv64-zvkb-zvkned.S
+clean-files += chacha-riscv64-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvkb-zvknha_or_zvknhb.S
 clean-files += sha512-riscv64-zvkb-zvknhb.S
diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/crypto/chacha-riscv64-glue.c
new file mode 100644
index 000000000000..72011949f705
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-glue.c
@@ -0,0 +1,120 @@
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
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define CHACHA_BLOCK_VALID_SIZE_MASK (~(CHACHA_BLOCK_SIZE - 1))
+#define CHACHA_BLOCK_REMAINING_SIZE_MASK (CHACHA_BLOCK_SIZE - 1)
+#define CHACHA_KEY_OFFSET 4
+#define CHACHA_IV_OFFSET 12
+
+/* chacha20 using zvkb vector crypto extension */
+void ChaCha20_ctr32_zvkb(u8 *out, const u8 *input, size_t len, const u32 *key,
+			 const u32 *counter);
+
+static int chacha20_encrypt(struct skcipher_request *req)
+{
+	u32 state[CHACHA_STATE_WORDS];
+	u8 block_buffer[CHACHA_BLOCK_SIZE];
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	unsigned int tail_bytes;
+	int err;
+
+	chacha_init_generic(state, ctx->key, req->iv);
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while (walk.nbytes) {
+		nbytes = walk.nbytes & CHACHA_BLOCK_VALID_SIZE_MASK;
+		tail_bytes = walk.nbytes & CHACHA_BLOCK_REMAINING_SIZE_MASK;
+		kernel_vector_begin();
+		if (nbytes) {
+			ChaCha20_ctr32_zvkb(walk.dst.virt.addr,
+					    walk.src.virt.addr, nbytes,
+					    state + CHACHA_KEY_OFFSET,
+					    state + CHACHA_IV_OFFSET);
+			state[CHACHA_IV_OFFSET] += nbytes / CHACHA_BLOCK_SIZE;
+		}
+		if (walk.nbytes == walk.total && tail_bytes > 0) {
+			memcpy(block_buffer, walk.src.virt.addr + nbytes,
+			       tail_bytes);
+			ChaCha20_ctr32_zvkb(block_buffer, block_buffer,
+					    CHACHA_BLOCK_SIZE,
+					    state + CHACHA_KEY_OFFSET,
+					    state + CHACHA_IV_OFFSET);
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
+static struct skcipher_alg riscv64_chacha_alg_zvkb[] = { {
+	.base = {
+		.cra_name = "chacha20",
+		.cra_driver_name = "chacha20-riscv64-zvkb",
+		.cra_priority = 300,
+		.cra_blocksize = 1,
+		.cra_ctxsize = sizeof(struct chacha_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.min_keysize = CHACHA_KEY_SIZE,
+	.max_keysize = CHACHA_KEY_SIZE,
+	.ivsize = CHACHA_IV_SIZE,
+	.chunksize = CHACHA_BLOCK_SIZE,
+	.walksize = CHACHA_BLOCK_SIZE * 4,
+	.setkey = chacha20_setkey,
+	.encrypt = chacha20_encrypt,
+	.decrypt = chacha20_encrypt,
+} };
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
+		return crypto_register_skciphers(
+			riscv64_chacha_alg_zvkb,
+			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_chacha_mod_fini(void)
+{
+	if (check_chacha20_ext())
+		crypto_unregister_skciphers(
+			riscv64_chacha_alg_zvkb,
+			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
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
index 000000000000..9caf7b247804
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-zvkb.pl
@@ -0,0 +1,322 @@
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
+# - RISC-V Zicclsm(Main memory supports misaligned loads/stores)
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

