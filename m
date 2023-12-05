Return-Path: <linux-crypto+bounces-565-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4F805097
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9AB28187D
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271556472
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mstM7xO4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253E98
	for <linux-crypto@vger.kernel.org>; Tue,  5 Dec 2023 01:28:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce5f4b3eefso1207595b3a.3
        for <linux-crypto@vger.kernel.org>; Tue, 05 Dec 2023 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768501; x=1702373301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBuedL2MVaDCSRXtoqXWbAJ3hnegLt9N4TQwD0//bFg=;
        b=mstM7xO4k5v2OPKpNLZfV9FXtpl+XDt4i24c2zKZZtVcHW/xcVPRDpbeCMg0qbwhs8
         R25McSJQRST64gOQdeS2UmGTfEAz2P6ryEh4+6KV5UfwAmxxpubpnLVoRLO+Bgmi+l3w
         iG6OHloWZuDhhUyVRwCsRblFlUWyPzo259ktoZXuz1cFFr5G4WApJwbKRGAyRy14bz88
         RwHWQt3ly8PhYLWWzSsCDsx/65pdvG32X7vAiRrR+rMz8y4HkBTmJ5zoDYsCGkF8FZod
         TM9Bnno8sV885H0EC5gJqRBsiSbFvXh0ZXgrUaHjhVqdu6XhxKFMV7BRFHAfIXgb4p3+
         HLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768501; x=1702373301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBuedL2MVaDCSRXtoqXWbAJ3hnegLt9N4TQwD0//bFg=;
        b=glM1FFIYMhJzAHRiXmVVd9LjoRMIjDYb+AOkfXRPCCCwUHxz3ZZQUWBwRTYpJwJkb9
         V/0LxemizaYkGMhdQsVlNMtBN+3wkSrCFJCRvp9p9zP6qbXLF6eIZQCSRgR7YZd7YrOe
         X30YpHjqKicJ9cF04hReDz93YzgU5wsq5GRwxX+9tPz84FiCx5p66HQqZ1y4DbU2Ov/p
         T8TS9cXRmxTZew6MNbBMq4oTdYn9C2kG0MG6F5SWURIES2mw51imU3S6jB61QA+757o+
         IKo+Y49VCJbRcxsxvooBETeZOaWNCv4Eo9jcgc+55vUGhM10Kx4ni+ewH6NorFMrgOjG
         2S3g==
X-Gm-Message-State: AOJu0Yyu31nYwWTwixhGNTcS5n7qfYkOikGDJhXkM/PU8GORtcawntW/
	vbbMjlmnDYLAkpKf/52EN5B6lvNhWpgHCQ8gJ+Q=
X-Google-Smtp-Source: AGHT+IFr4dGGyEyZHIGPv5AWO9ts4wPN/yPzSbmCzmCq7FmwKS1IxwoO4xI+C5TPbBu3ZHb04zstKg==
X-Received: by 2002:a05:6a00:a90:b0:6ce:54c4:b514 with SMTP id b16-20020a056a000a9000b006ce54c4b514mr731370pfl.50.1701768501556;
        Tue, 05 Dec 2023 01:28:21 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:21 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org,
	conor@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v3 03/12] RISC-V: crypto: add OpenSSL perl module for vector instructions
Date: Tue,  5 Dec 2023 17:27:52 +0800
Message-Id: <20231205092801.1335-4-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The OpenSSL has some RISC-V vector cryptography implementations which
could be reused for kernel. These implementations use a number of perl
helpers for handling vector-crypto-extension instructions.
This patch take these perl helpers from OpenSSL(openssl/openssl#21923).
The unused scalar crypto instructions in the original perl module are
skipped.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v3:
 - Only use opcodes for vector crypto extensions.
 We use the asm mnemonics for all instructions in RVV 1.0 extension which
 are already supported in kernel.
---
 arch/riscv/crypto/riscv.pm | 359 +++++++++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 arch/riscv/crypto/riscv.pm

diff --git a/arch/riscv/crypto/riscv.pm b/arch/riscv/crypto/riscv.pm
new file mode 100644
index 000000000000..d91ad902ca04
--- /dev/null
+++ b/arch/riscv/crypto/riscv.pm
@@ -0,0 +1,359 @@
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
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
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
+use strict;
+use warnings;
+
+# Set $have_stacktrace to 1 if we have Devel::StackTrace
+my $have_stacktrace = 0;
+if (eval {require Devel::StackTrace;1;}) {
+    $have_stacktrace = 1;
+}
+
+my @regs = map("x$_",(0..31));
+# Mapping from the RISC-V psABI ABI mnemonic names to the register number.
+my @regaliases = ('zero','ra','sp','gp','tp','t0','t1','t2','s0','s1',
+    map("a$_",(0..7)),
+    map("s$_",(2..11)),
+    map("t$_",(3..6))
+);
+
+my %reglookup;
+@reglookup{@regs} = @regs;
+@reglookup{@regaliases} = @regs;
+
+# Takes a register name, possibly an alias, and converts it to a register index
+# from 0 to 31
+sub read_reg {
+    my $reg = lc shift;
+    if (!exists($reglookup{$reg})) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unknown register ".$reg."\n".$trace);
+    }
+    my $regstr = $reglookup{$reg};
+    if (!($regstr =~ /^x([0-9]+)$/)) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Could not process register ".$reg."\n".$trace);
+    }
+    return $1;
+}
+
+my @vregs = map("v$_",(0..31));
+my %vreglookup;
+@vreglookup{@vregs} = @vregs;
+
+sub read_vreg {
+    my $vreg = lc shift;
+    if (!exists($vreglookup{$vreg})) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unknown vector register ".$vreg."\n".$trace);
+    }
+    if (!($vreg =~ /^v([0-9]+)$/)) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Could not process vector register ".$vreg."\n".$trace);
+    }
+    return $1;
+}
+
+# Read the vm settings and convert to mask encoding.
+sub read_mask_vreg {
+    my $vreg = shift;
+    # The default value is unmasked.
+    my $mask_bit = 1;
+
+    if (defined($vreg)) {
+        my $reg_id = read_vreg $vreg;
+        if ($reg_id == 0) {
+            $mask_bit = 0;
+        } else {
+            my $trace = "";
+            if ($have_stacktrace) {
+                $trace = Devel::StackTrace->new->as_string;
+            }
+            die("The ".$vreg." is not the mask register v0.\n".$trace);
+        }
+    }
+    return $mask_bit;
+}
+
+# Vector crypto instructions
+
+## Zvbb and Zvkb instructions
+##
+## vandn (also in zvkb)
+## vbrev
+## vbrev8 (also in zvkb)
+## vrev8 (also in zvkb)
+## vclz
+## vctz
+## vcpop
+## vrol (also in zvkb)
+## vror (also in zvkb)
+## vwsll
+
+sub vbrev8_v {
+    # vbrev8.v vd, vs2, vm
+    my $template = 0b010010_0_00000_01000_010_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vrev8_v {
+    # vrev8.v vd, vs2, vm
+    my $template = 0b010010_0_00000_01001_010_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vror_vi {
+    # vror.vi vd, vs2, uimm
+    my $template = 0b01010_0_1_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    my $uimm_i5 = $uimm >> 5;
+    my $uimm_i4_0 = $uimm & 0b11111;
+
+    return ".word ".($template | ($uimm_i5 << 26) | ($vs2 << 20) | ($uimm_i4_0 << 15) | ($vd << 7));
+}
+
+sub vwsll_vv {
+    # vwsll.vv vd, vs2, vs1, vm
+    my $template = 0b110101_0_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+## Zvbc instructions
+
+sub vclmulh_vx {
+    # vclmulh.vx vd, vs2, rs1
+    my $template = 0b0011011_00000_00000_110_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vclmul_vx_v0t {
+    # vclmul.vx vd, vs2, rs1, v0.t
+    my $template = 0b0011000_00000_00000_110_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vclmul_vx {
+    # vclmul.vx vd, vs2, rs1
+    my $template = 0b0011001_00000_00000_110_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+## Zvkg instructions
+
+sub vghsh_vv {
+    # vghsh.vv vd, vs2, vs1
+    my $template = 0b1011001_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vgmul_vv {
+    # vgmul.vv vd, vs2
+    my $template = 0b1010001_00000_10001_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+## Zvkned instructions
+
+sub vaesdf_vs {
+    # vaesdf.vs vd, vs2
+    my $template = 0b101001_1_00000_00001_010_00000_1110111;
+    my $vd = read_vreg  shift;
+    my $vs2 = read_vreg  shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vaesdm_vs {
+    # vaesdm.vs vd, vs2
+    my $template = 0b101001_1_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vaesef_vs {
+    # vaesef.vs vd, vs2
+    my $template = 0b101001_1_00000_00011_010_00000_1110111;
+    my $vd = read_vreg  shift;
+    my $vs2 = read_vreg  shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vaesem_vs {
+    # vaesem.vs vd, vs2
+    my $template = 0b101001_1_00000_00010_010_00000_1110111;
+    my $vd = read_vreg  shift;
+    my $vs2 = read_vreg  shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vaeskf1_vi {
+    # vaeskf1.vi vd, vs2, uimmm
+    my $template = 0b100010_1_00000_00000_010_00000_1110111;
+    my $vd = read_vreg  shift;
+    my $vs2 = read_vreg  shift;
+    my $uimm = shift;
+    return ".word ".($template | ($uimm << 15) | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vaeskf2_vi {
+    # vaeskf2.vi vd, vs2, uimm
+    my $template = 0b101010_1_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vaesz_vs {
+    # vaesz.vs vd, vs2
+    my $template = 0b101001_1_00000_00111_010_00000_1110111;
+    my $vd = read_vreg  shift;
+    my $vs2 = read_vreg  shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+## Zvknha and Zvknhb instructions
+
+sub vsha2ms_vv {
+    # vsha2ms.vv vd, vs2, vs1
+    my $template = 0b1011011_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20)| ($vs1 << 15 )| ($vd << 7));
+}
+
+sub vsha2ch_vv {
+    # vsha2ch.vv vd, vs2, vs1
+    my $template = 0b101110_10000_00000_001_00000_01110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20)| ($vs1 << 15 )| ($vd << 7));
+}
+
+sub vsha2cl_vv {
+    # vsha2cl.vv vd, vs2, vs1
+    my $template = 0b101111_10000_00000_001_00000_01110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20)| ($vs1 << 15 )| ($vd << 7));
+}
+
+## Zvksed instructions
+
+sub vsm4k_vi {
+    # vsm4k.vi vd, vs2, uimm
+    my $template = 0b1000011_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vsm4r_vs {
+    # vsm4r.vs vd, vs2
+    my $template = 0b1010011_00000_10000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
+}
+
+## zvksh instructions
+
+sub vsm3c_vi {
+    # vsm3c.vi vd, vs2, uimm
+    my $template = 0b1010111_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15 ) | ($vd << 7));
+}
+
+sub vsm3me_vv {
+    # vsm3me.vv vd, vs2, vs1
+    my $template = 0b1000001_00000_00000_010_00000_1110111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15 ) | ($vd << 7));
+}
+
+1;
-- 
2.28.0


