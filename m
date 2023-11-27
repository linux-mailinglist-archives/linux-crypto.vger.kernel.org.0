Return-Path: <linux-crypto+bounces-303-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041D7F9BCE
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E85280C78
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DD7111A8
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="En7G7TJI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB6D60
	for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf7a8ab047so28122895ad.1
        for <linux-crypto@vger.kernel.org>; Sun, 26 Nov 2023 23:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068861; x=1701673661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2ie9UBY5BJCsnebwLbVxGGtRlv0a5BfHvQORsnSkzU=;
        b=En7G7TJI5Ej6IKWKKC783xYJ4sSl+QzALpNgLRtTsqiwb+thF+vDCcfNUd3nNdluqB
         bZB7NQmCpuJtlf1BIEGHuz/6WfBNcklsM26upCMB62XWCRcjJOG4cGBLk2Vlo5V7y9Ce
         tJDufrCwQ0eNeTVGp1zO9GlzcorSKdzotXMVE/TQ04C9UfIFaL9ug5Rmgwmrm+E2ecvg
         AlQ4xEO/Q817PJIkNN1i1YqsyLtlLoQzqgqKngdPCdk5LMYxdLrB0UqA/lBA+SnJsd8f
         RMYqLe9RKXcQehSV+Hwpu4cqFsy+S1vvYgxIKO0Pc5wCJMHuGs50vfcS7QA1JLSX+vSd
         VNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068861; x=1701673661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2ie9UBY5BJCsnebwLbVxGGtRlv0a5BfHvQORsnSkzU=;
        b=YexUlve7UcVG11SpRACZqCGa3GeNtrWa790PUv6FOiDeixQENqpNWN86U9EbPoO0Dp
         8/Oz8PmFKEF8QPxj6tBgyCuBGRxnrZ4zIFnywHBaJPX5k/mmsuEcq4RDH2Ez8t0mr02N
         rIiiusOpEXx80b7y+bTJn0pttr8OGoGCWhSPgeQdLN+kuHoafsDJnGFLQFYIXuxyrQMz
         YozmOASEWs/QpGNQEPkDLdqQigqKbDdrP2uUa1xrmAI8r/jRjYspv3Pf/HksUlEaY16N
         x9C4FOuxXRuklD/g19XgO0IzRlk5gQHkZLAQD5e6YAUQL9IdDgFlwlYqrEQm3svshk87
         hIiQ==
X-Gm-Message-State: AOJu0Yy9ywM8AoMCwHhNsGzOEszuSOc3Rd3OPpp+Kb7L47gER5XnaR3P
	+ySPVFCss57g8R8jg2ZWFwaTaA==
X-Google-Smtp-Source: AGHT+IE1JBBVZSJGyCAbSJ13cr1H5pF+3UXdDbWfyBIJioNv3kdxLCkMNdaACGujT6Ku8o5fRzSGSQ==
X-Received: by 2002:a17:902:d38d:b0:1cf:a4e8:d2a1 with SMTP id e13-20020a170902d38d00b001cfa4e8d2a1mr8132283pld.42.1701068860527;
        Sun, 26 Nov 2023 23:07:40 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:40 -0800 (PST)
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
Subject: [PATCH v2 09/13] RISC-V: crypto: add Zvknha/b accelerated SHA224/256 implementations
Date: Mon, 27 Nov 2023 15:06:59 +0800
Message-Id: <20231127070703.1697-10-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add SHA224 and 256 implementations using Zvknha or Zvknhb vector crypto
extensions from OpenSSL(openssl/openssl#21923).

Co-developed-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v2:
 - Do not turn on kconfig `SHA256_RISCV64` option by default.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Rename sha256-riscv64-zvkb-zvknha_or_zvknhb to
   sha256-riscv64-zvknha_or_zvknhb-zvkb.
 - Reorder structure sha256_algs members initialization in the order
   declared.
---
 arch/riscv/crypto/Kconfig                     |  11 +
 arch/riscv/crypto/Makefile                    |   7 +
 arch/riscv/crypto/sha256-riscv64-glue.c       | 145 ++++++++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.pl   | 318 ++++++++++++++++++
 4 files changed, 481 insertions(+)
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 6863f01a2ab0..d31af9190717 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -44,4 +44,15 @@ config CRYPTO_GHASH_RISCV64
 	  Architecture: riscv64 using:
 	  - Zvkg vector crypto extension
 
+config CRYPTO_SHA256_RISCV64
+	tristate "Hash functions: SHA-224 and SHA-256"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_SHA256
+	help
+	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using:
+	  - Zvknha or Zvknhb vector crypto extensions
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 94a7f8eaa8a7..e9d7717ec943 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -12,6 +12,9 @@ aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvk
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -27,7 +30,11 @@ $(obj)/aes-riscv64-zvkned-zvkb.S: $(src)/aes-riscv64-zvkned-zvkb.pl
 $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 	$(call cmd,perlasm)
 
+$(obj)/sha256-riscv64-zvknha_or_zvknhb-zvkb.S: $(src)/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
+clean-files += sha256-riscv64-zvknha_or_zvknhb-zvkb.S
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
new file mode 100644
index 000000000000..760d89031d1c
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-glue.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA256 implementation for RISC-V 64
+ *
+ * Copyright (C) 2022 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha256_base.h>
+
+/*
+ * sha256 using zvkb and zvknha/b vector crypto extension
+ *
+ * This asm function will just take the first 256-bit as the sha256 state from
+ * the pointer to `struct sha256_state`.
+ */
+asmlinkage void
+sha256_block_data_order_zvkb_zvknha_or_zvknhb(struct sha256_state *digest,
+					      const u8 *data, int num_blks);
+
+static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	int ret = 0;
+
+	/*
+	 * Make sure struct sha256_state begins directly with the SHA256
+	 * 256-bit internal state, as this is what the asm function expect.
+	 */
+	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		ret = sha256_base_do_update(
+			desc, data, len,
+			sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		kernel_vector_end();
+	} else {
+		ret = crypto_sha256_update(desc, data, len);
+	}
+
+	return ret;
+}
+
+static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
+				unsigned int len, u8 *out)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sha256_base_do_update(
+				desc, data, len,
+				sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		sha256_base_do_finalize(
+			desc, sha256_block_data_order_zvkb_zvknha_or_zvknhb);
+		kernel_vector_end();
+
+		return sha256_base_finish(desc, out);
+	}
+
+	return crypto_sha256_finup(desc, data, len, out);
+}
+
+static int riscv64_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha256_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sha256_algs[] = {
+	{
+		.init = sha256_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.descsize = sizeof(struct sha256_state),
+		.digestsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA256_BLOCK_SIZE,
+			.cra_priority = 150,
+			.cra_name = "sha256",
+			.cra_driver_name = "sha256-riscv64-zvknha_or_zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.init = sha224_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.descsize = sizeof(struct sha256_state),
+		.digestsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA224_BLOCK_SIZE,
+			.cra_priority = 150,
+			.cra_name = "sha224",
+			.cra_driver_name = "sha224-riscv64-zvknha_or_zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+static inline bool check_sha256_ext(void)
+{
+	/*
+	 * From the spec:
+	 * The Zvknhb ext supports both SHA-256 and SHA-512 and Zvknha only
+	 * supports SHA-256.
+	 */
+	return (riscv_isa_extension_available(NULL, ZVKNHA) ||
+		riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	       riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_sha256_mod_init(void)
+{
+	if (check_sha256_ext())
+		return crypto_register_shashes(sha256_algs,
+					       ARRAY_SIZE(sha256_algs));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sha256_mod_fini(void)
+{
+	crypto_unregister_shashes(sha256_algs, ARRAY_SIZE(sha256_algs));
+}
+
+module_init(riscv64_sha256_mod_init);
+module_exit(riscv64_sha256_mod_fini);
+
+MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sha224");
+MODULE_ALIAS_CRYPTO("sha256");
diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl b/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
new file mode 100644
index 000000000000..51b2d9d4f8f1
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.pl
@@ -0,0 +1,318 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+# Copyright (c) 2023, Phoebe Chen <phoebe.chen@sifive.com>
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
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+# - RISC-V Vector SHA-2 Secure Hash extension ('Zvknha' or 'Zvknhb')
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
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+.text
+___
+
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+my $K256 = "K256";
+
+# Function arguments
+my ($H, $INP, $LEN, $KT, $H2, $INDEX_PATTERN) = ("a0", "a1", "a2", "a3", "t3", "t4");
+
+sub sha_256_load_constant {
+    my $code=<<___;
+    la $KT, $K256 # Load round constants K256
+    @{[vle32_v $V10, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V11, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V12, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V13, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V14, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V16, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V17, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V18, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V19, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V20, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V21, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V22, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V23, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V24, $KT]}
+    addi $KT, $KT, 16
+    @{[vle32_v $V25, $KT]}
+___
+
+    return $code;
+}
+
+################################################################################
+# void sha256_block_data_order_zvkb_zvknha_or_zvknhb(void *c, const void *p, size_t len)
+$code .= <<___;
+.p2align 2
+.globl sha256_block_data_order_zvkb_zvknha_or_zvknhb
+.type   sha256_block_data_order_zvkb_zvknha_or_zvknhb,\@function
+sha256_block_data_order_zvkb_zvknha_or_zvknhb:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[sha_256_load_constant]}
+
+    # H is stored as {a,b,c,d},{e,f,g,h}, but we need {f,e,b,a},{h,g,d,c}
+    # The dst vtype is e32m1 and the index vtype is e8mf4.
+    # We use index-load with the following index pattern at v26.
+    #   i8 index:
+    #     20, 16, 4, 0
+    # Instead of setting the i8 index, we could use a single 32bit
+    # little-endian value to cover the 4xi8 index.
+    #   i32 value:
+    #     0x 00 04 10 14
+    li $INDEX_PATTERN, 0x00041014
+    @{[vsetivli "zero", 1, "e32", "m1", "ta", "ma"]}
+    @{[vmv_v_x $V26, $INDEX_PATTERN]}
+
+    addi $H2, $H, 8
+
+    # Use index-load to get {f,e,b,a},{h,g,d,c}
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vluxei8_v $V6, $H, $V26]}
+    @{[vluxei8_v $V7, $H2, $V26]}
+
+    # Setup v0 mask for the vmerge to replace the first word (idx==0) in key-scheduling.
+    # The AVL is 4 in SHA, so we could use a single e8(8 element masking) for masking.
+    @{[vsetivli "zero", 1, "e8", "m1", "ta", "ma"]}
+    @{[vmv_v_i $V0, 0x01]}
+
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+L_round_loop:
+    # Decrement length by 1
+    add $LEN, $LEN, -1
+
+    # Keep the current state as we need it later: H' = H+{a',b',c',...,h'}.
+    @{[vmv_v_v $V30, $V6]}
+    @{[vmv_v_v $V31, $V7]}
+
+    # Load the 512-bits of the message block in v1-v4 and perform
+    # an endian swap on each 4 bytes element.
+    @{[vle32_v $V1, $INP]}
+    @{[vrev8_v $V1, $V1]}
+    add $INP, $INP, 16
+    @{[vle32_v $V2, $INP]}
+    @{[vrev8_v $V2, $V2]}
+    add $INP, $INP, 16
+    @{[vle32_v $V3, $INP]}
+    @{[vrev8_v $V3, $V3]}
+    add $INP, $INP, 16
+    @{[vle32_v $V4, $INP]}
+    @{[vrev8_v $V4, $V4]}
+    add $INP, $INP, 16
+
+    # Quad-round 0 (+0, Wt from oldest to newest in v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V10, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[19:16]
+
+    # Quad-round 1 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V11, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[23:20]
+
+    # Quad-round 2 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V12, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[27:24]
+
+    # Quad-round 3 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V13, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[31:28]
+
+    # Quad-round 4 (+0, v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V14, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[35:32]
+
+    # Quad-round 5 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V15, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[39:36]
+
+    # Quad-round 6 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V16, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[43:40]
+
+    # Quad-round 7 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V17, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[47:44]
+
+    # Quad-round 8 (+0, v1->v2->v3->v4)
+    @{[vadd_vv $V5, $V18, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V3, $V2, $V0]}
+    @{[vsha2ms_vv $V1, $V5, $V4]}  # Generate W[51:48]
+
+    # Quad-round 9 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V19, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V4, $V3, $V0]}
+    @{[vsha2ms_vv $V2, $V5, $V1]}  # Generate W[55:52]
+
+    # Quad-round 10 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V20, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V1, $V4, $V0]}
+    @{[vsha2ms_vv $V3, $V5, $V2]}  # Generate W[59:56]
+
+    # Quad-round 11 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V21, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+    @{[vmerge_vvm $V5, $V2, $V1, $V0]}
+    @{[vsha2ms_vv $V4, $V5, $V3]}  # Generate W[63:60]
+
+    # Quad-round 12 (+0, v1->v2->v3->v4)
+    # Note that we stop generating new message schedule words (Wt, v1-13)
+    # as we already generated all the words we end up consuming (i.e., W[63:60]).
+    @{[vadd_vv $V5, $V22, $V1]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 13 (+1, v2->v3->v4->v1)
+    @{[vadd_vv $V5, $V23, $V2]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 14 (+2, v3->v4->v1->v2)
+    @{[vadd_vv $V5, $V24, $V3]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # Quad-round 15 (+3, v4->v1->v2->v3)
+    @{[vadd_vv $V5, $V25, $V4]}
+    @{[vsha2cl_vv $V7, $V6, $V5]}
+    @{[vsha2ch_vv $V6, $V7, $V5]}
+
+    # H' = H+{a',b',c',...,h'}
+    @{[vadd_vv $V6, $V30, $V6]}
+    @{[vadd_vv $V7, $V31, $V7]}
+    bnez $LEN, L_round_loop
+
+    # Store {f,e,b,a},{h,g,d,c} back to {a,b,c,d},{e,f,g,h}.
+    @{[vsuxei8_v $V6, $H, $V26]}
+    @{[vsuxei8_v $V7, $H2, $V26]}
+
+    ret
+.size sha256_block_data_order_zvkb_zvknha_or_zvknhb,.-sha256_block_data_order_zvkb_zvknha_or_zvknhb
+
+.p2align 2
+.type $K256,\@object
+$K256:
+    .word 0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5
+    .word 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5
+    .word 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3
+    .word 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174
+    .word 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc
+    .word 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da
+    .word 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7
+    .word 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967
+    .word 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13
+    .word 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85
+    .word 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3
+    .word 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070
+    .word 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5
+    .word 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3
+    .word 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208
+    .word 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
+.size $K256,.-$K256
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0


