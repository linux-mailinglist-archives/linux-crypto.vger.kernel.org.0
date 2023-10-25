Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F557D735F
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Oct 2023 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJYShY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Oct 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJYShR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357D6196
        for <linux-crypto@vger.kernel.org>; Wed, 25 Oct 2023 11:37:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c77449a6daso22995ad.0
        for <linux-crypto@vger.kernel.org>; Wed, 25 Oct 2023 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259027; x=1698863827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6MgwafsLqjywfMCXjdUW6zqI+itRnJtEI6/v6PIAPo=;
        b=J8pGuzYtbwxp6BKJzugWb4G291Ue4UVOcQSQawBCrNn4p3lu+nplTptpFfof1jRrdI
         zMds9De++5yQtiqFH/l6oQTQt0bwBi0M83WK7BftijDhpUR7KZ/xc30dkB2p/HI/yd2S
         0I2VzrHAxN23Pc1iAOW+gULA9PmjO/wEl8QgLi9X+4R/r4JZBnnXSMi1LuvNYJmbHX1r
         9pLICOwfRnbFSJqu7/8Ns0Bc5gR2Cw8b9OdBUAPf1L/S/3QHsx5eEytG7WhJgH+JSxwd
         Ej47reBYEfb6BDN2r5sRyJga/pfxdG4wjvr1Gd8mYeoHTVu7DHuwL7wy8brLy4raCppS
         +nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259027; x=1698863827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6MgwafsLqjywfMCXjdUW6zqI+itRnJtEI6/v6PIAPo=;
        b=L2d5O9ZrmQVWencUyP+47kYaOhVLW6jZYhMmA+PFCIInjaDNtyr8xD2i/VtWFbCyFK
         doEIru5hUGkyKHU9aH95C9YtQVSs7+EoFeUsr1T5CyqGk+j4wsGANy8X9fTPWxUKtKHw
         5DSQ9fRS4E/7WExt5RP7Fspxspn0hDBhPiJK+ZoT7Ta78j3KVjXq/Tr3Qi+E4CnokHtX
         YGEn5NlzsZQJpsRiquC9TUOh3MkwAg2Anhnt+2x62v6zhQLNeExlu4FNU4U/gHrDfgmw
         s/OcCM2O8U+MUlQWQkmcrl0SdrOQjfCSEPsMAxdGNXEuELKd/WSHD+KDGG2wR88Jm0gO
         QTXg==
X-Gm-Message-State: AOJu0YzFoB547qirS4hcJ2Yst+jR6EP3Q9CElDHyuzl58ZQu6WXXrEkx
        OYEiPl8ku61da7S5ySEDxUC3gQ==
X-Google-Smtp-Source: AGHT+IG0z9SRqLNyJg2TehdS4CqqTSOT1S0/ni0xDxr1Z9HFhKdeiZpJ1HKxezskjzDh9blmV89o3A==
X-Received: by 2002:a17:90a:1c8:b0:27d:6dd:fb7d with SMTP id 8-20020a17090a01c800b0027d06ddfb7dmr16708676pjd.17.1698259027428;
        Wed, 25 Oct 2023 11:37:07 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:06 -0700 (PDT)
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
Subject: [PATCH 03/12] RISC-V: crypto: add OpenSSL perl module for vector instructions
Date:   Thu, 26 Oct 2023 02:36:35 +0800
Message-Id: <20231025183644.8735-4-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The OpenSSL has some RISC-V vector cryptography implementations which
could be reused for kernel. These implementations use a number of perl
helpers for handling vector and vector-crypto-extension instructions.
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
 arch/riscv/crypto/riscv.pm | 828 +++++++++++++++++++++++++++++++++++++
 1 file changed, 828 insertions(+)
 create mode 100644 arch/riscv/crypto/riscv.pm

diff --git a/arch/riscv/crypto/riscv.pm b/arch/riscv/crypto/riscv.pm
new file mode 100644
index 000000000000..e188f7476e3e
--- /dev/null
+++ b/arch/riscv/crypto/riscv.pm
@@ -0,0 +1,828 @@
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
+# Read the sew setting(8, 16, 32 and 64) and convert to vsew encoding.
+sub read_sew {
+    my $sew_setting = shift;
+
+    if ($sew_setting eq "e8") {
+        return 0;
+    } elsif ($sew_setting eq "e16") {
+        return 1;
+    } elsif ($sew_setting eq "e32") {
+        return 2;
+    } elsif ($sew_setting eq "e64") {
+        return 3;
+    } else {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unsupported SEW setting:".$sew_setting."\n".$trace);
+    }
+}
+
+# Read the LMUL settings and convert to vlmul encoding.
+sub read_lmul {
+    my $lmul_setting = shift;
+
+    if ($lmul_setting eq "mf8") {
+        return 5;
+    } elsif ($lmul_setting eq "mf4") {
+        return 6;
+    } elsif ($lmul_setting eq "mf2") {
+        return 7;
+    } elsif ($lmul_setting eq "m1") {
+        return 0;
+    } elsif ($lmul_setting eq "m2") {
+        return 1;
+    } elsif ($lmul_setting eq "m4") {
+        return 2;
+    } elsif ($lmul_setting eq "m8") {
+        return 3;
+    } else {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unsupported LMUL setting:".$lmul_setting."\n".$trace);
+    }
+}
+
+# Read the tail policy settings and convert to vta encoding.
+sub read_tail_policy {
+    my $tail_setting = shift;
+
+    if ($tail_setting eq "ta") {
+        return 1;
+    } elsif ($tail_setting eq "tu") {
+        return 0;
+    } else {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unsupported tail policy setting:".$tail_setting."\n".$trace);
+    }
+}
+
+# Read the mask policy settings and convert to vma encoding.
+sub read_mask_policy {
+    my $mask_setting = shift;
+
+    if ($mask_setting eq "ma") {
+        return 1;
+    } elsif ($mask_setting eq "mu") {
+        return 0;
+    } else {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unsupported mask policy setting:".$mask_setting."\n".$trace);
+    }
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
+# Vector instructions
+
+sub vadd_vv {
+    # vadd.vv vd, vs2, vs1, vm
+    my $template = 0b000000_0_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vadd_vx {
+    # vadd.vx vd, vs2, rs1, vm
+    my $template = 0b000000_0_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vsub_vv {
+    # vsub.vv vd, vs2, vs1, vm
+    my $template = 0b000010_0_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vsub_vx {
+    # vsub.vx vd, vs2, rs1, vm
+    my $template = 0b000010_0_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vid_v {
+    # vid.v vd
+    my $template = 0b0101001_00000_10001_010_00000_1010111;
+    my $vd = read_vreg shift;
+    return ".word ".($template | ($vd << 7));
+}
+
+sub viota_m {
+    # viota.m vd, vs2, vm
+    my $template = 0b010100_0_00000_10000_010_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vd << 7));
+}
+
+sub vle8_v {
+    # vle8.v vd, (rs1), vm
+    my $template = 0b000000_0_00000_00000_000_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vle32_v {
+    # vle32.v vd, (rs1), vm
+    my $template = 0b000000_0_00000_00000_110_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vle64_v {
+    # vle64.v vd, (rs1)
+    my $template = 0b0000001_00000_00000_111_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vlse32_v {
+    # vlse32.v vd, (rs1), rs2
+    my $template = 0b0000101_00000_00000_110_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vlsseg_nf_e32_v {
+    # vlsseg<nf>e32.v vd, (rs1), rs2
+    my $template = 0b0000101_00000_00000_110_00000_0000111;
+    my $nf = shift;
+    $nf -= 1;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($nf << 29) | ($rs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vlse64_v {
+    # vlse64.v vd, (rs1), rs2
+    my $template = 0b0000101_00000_00000_111_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vluxei8_v {
+    # vluxei8.v vd, (rs1), vs2, vm
+    my $template = 0b000001_0_00000_00000_000_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vs2 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vmerge_vim {
+    # vmerge.vim vd, vs2, imm, v0
+    my $template = 0b0101110_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $imm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($imm << 15) | ($vd << 7));
+}
+
+sub vmerge_vvm {
+    # vmerge.vvm vd vs2 vs1
+    my $template = 0b0101110_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7))
+}
+
+sub vmseq_vi {
+    # vmseq.vi vd vs1, imm
+    my $template = 0b0110001_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    my $imm = shift;
+    return ".word ".($template | ($vs1 << 20) | ($imm << 15) | ($vd << 7))
+}
+
+sub vmsgtu_vx {
+    # vmsgtu.vx vd vs2, rs1, vm
+    my $template = 0b011110_0_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7))
+}
+
+sub vmv_v_i {
+    # vmv.v.i vd, imm
+    my $template = 0b0101111_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $imm = shift;
+    return ".word ".($template | ($imm << 15) | ($vd << 7));
+}
+
+sub vmv_v_x {
+    # vmv.v.x vd, rs1
+    my $template = 0b0101111_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vmv_v_v {
+    # vmv.v.v vd, vs1
+    my $template = 0b0101111_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vor_vv_v0t {
+    # vor.vv vd, vs2, vs1, v0.t
+    my $template = 0b0010100_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vse8_v {
+    # vse8.v vd, (rs1), vm
+    my $template = 0b000000_0_00000_00000_000_00000_0100111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vse32_v {
+    # vse32.v vd, (rs1), vm
+    my $template = 0b000000_0_00000_00000_110_00000_0100111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vssseg_nf_e32_v {
+    # vssseg<nf>e32.v vs3, (rs1), rs2
+    my $template = 0b0000101_00000_00000_110_00000_0100111;
+    my $nf = shift;
+    $nf -= 1;
+    my $vs3 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($nf << 29) | ($rs2 << 20) | ($rs1 << 15) | ($vs3 << 7));
+}
+
+sub vsuxei8_v {
+   # vsuxei8.v vs3, (rs1), vs2, vm
+   my $template = 0b000001_0_00000_00000_000_00000_0100111;
+   my $vs3 = read_vreg shift;
+   my $rs1 = read_reg shift;
+   my $vs2 = read_vreg shift;
+   my $vm = read_mask_vreg shift;
+   return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($rs1 << 15) | ($vs3 << 7));
+}
+
+sub vse64_v {
+    # vse64.v vd, (rs1)
+    my $template = 0b0000001_00000_00000_111_00000_0100111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vsetivli__x0_2_e64_m1_tu_mu {
+    # vsetivli x0, 2, e64, m1, tu, mu
+    return ".word 0xc1817057";
+}
+
+sub vsetivli__x0_4_e32_m1_tu_mu {
+    # vsetivli x0, 4, e32, m1, tu, mu
+    return ".word 0xc1027057";
+}
+
+sub vsetivli__x0_4_e64_m1_tu_mu {
+    # vsetivli x0, 4, e64, m1, tu, mu
+    return ".word 0xc1827057";
+}
+
+sub vsetivli__x0_8_e32_m1_tu_mu {
+    # vsetivli x0, 8, e32, m1, tu, mu
+    return ".word 0xc1047057";
+}
+
+sub vsetvli {
+    # vsetvli rd, rs1, vtypei
+    my $template = 0b0_00000000000_00000_111_00000_1010111;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $sew = read_sew shift;
+    my $lmul = read_lmul shift;
+    my $tail_policy = read_tail_policy shift;
+    my $mask_policy = read_mask_policy shift;
+    my $vtypei = ($mask_policy << 7) | ($tail_policy << 6) | ($sew << 3) | $lmul;
+
+    return ".word ".($template | ($vtypei << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub vsetivli {
+    # vsetvli rd, uimm, vtypei
+    my $template = 0b11_0000000000_00000_111_00000_1010111;
+    my $rd = read_reg shift;
+    my $uimm = shift;
+    my $sew = read_sew shift;
+    my $lmul = read_lmul shift;
+    my $tail_policy = read_tail_policy shift;
+    my $mask_policy = read_mask_policy shift;
+    my $vtypei = ($mask_policy << 7) | ($tail_policy << 6) | ($sew << 3) | $lmul;
+
+    return ".word ".($template | ($vtypei << 20) | ($uimm << 15) | ($rd << 7));
+}
+
+sub vslidedown_vi {
+    # vslidedown.vi vd, vs2, uimm
+    my $template = 0b0011111_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vslidedown_vx {
+    # vslidedown.vx vd, vs2, rs1
+    my $template = 0b0011111_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vslideup_vi_v0t {
+    # vslideup.vi vd, vs2, uimm, v0.t
+    my $template = 0b0011100_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vslideup_vi {
+    # vslideup.vi vd, vs2, uimm
+    my $template = 0b0011101_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vsll_vi {
+    # vsll.vi vd, vs2, uimm, vm
+    my $template = 0b1001011_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $uimm = shift;
+    return ".word ".($template | ($vs2 << 20) | ($uimm << 15) | ($vd << 7));
+}
+
+sub vsrl_vx {
+    # vsrl.vx vd, vs2, rs1
+    my $template = 0b1010001_00000_00000_100_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($vs2 << 20) | ($rs1 << 15) | ($vd << 7));
+}
+
+sub vsse32_v {
+    # vse32.v vs3, (rs1), rs2
+    my $template = 0b0000101_00000_00000_110_00000_0100111;
+    my $vs3 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($vs3 << 7));
+}
+
+sub vsse64_v {
+    # vsse64.v vs3, (rs1), rs2
+    my $template = 0b0000101_00000_00000_111_00000_0100111;
+    my $vs3 = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($vs3 << 7));
+}
+
+sub vxor_vv_v0t {
+    # vxor.vv vd, vs2, vs1, v0.t
+    my $template = 0b0010110_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vxor_vv {
+    # vxor.vv vd, vs2, vs1
+    my $template = 0b0010111_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vzext_vf2 {
+    # vzext.vf2 vd, vs2, vm
+    my $template = 0b010010_0_00000_00110_010_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vm = read_mask_vreg shift;
+    return ".word ".($template | ($vm << 25) | ($vs2 << 20) | ($vd << 7));
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

