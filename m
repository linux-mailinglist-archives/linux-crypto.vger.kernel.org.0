Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D1F74F3D1
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Jul 2023 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjGKPjm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jul 2023 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjGKPjG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jul 2023 11:39:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E2198A;
        Tue, 11 Jul 2023 08:38:10 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFQz-0000g0-M6; Tue, 11 Jul 2023 17:37:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 05/12] RISC-V: crypto: update perl include with helpers for vector (crypto) instructions
Date:   Tue, 11 Jul 2023 17:37:36 +0200
Message-Id: <20230711153743.1970625-6-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

The openSSL scripts use a number of helpers for handling vector
instructions and instructions from the vector-crypto-extensions.

Therefore port these over from openSSL.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/riscv.pm | 433 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 432 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/crypto/riscv.pm b/arch/riscv/crypto/riscv.pm
index a44edc68d1a6..89e4cb7cfd8c 100644
--- a/arch/riscv/crypto/riscv.pm
+++ b/arch/riscv/crypto/riscv.pm
@@ -79,6 +79,29 @@ sub read_reg {
     return $1;
 }
 
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
 # Helper functions
 
 sub brev8_rv64i {
@@ -258,4 +281,412 @@ sub rev8 {
     return ".word ".($template | ($rs << 15) | ($rd << 7));
 }
 
+# Vector instructions
+
+sub vadd_vv {
+    # vadd.vv vd, vs2, vs1
+    my $template = 0b0000001_00000_00000_000_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vs1 << 15) | ($vd << 7));
+}
+
+sub vid_v {
+    # vid.v vd
+    my $template = 0b0101001_00000_10001_010_00000_1010111;
+    my $vd = read_vreg shift;
+    return ".word ".($template | ($vd << 7));
+}
+
+sub vle32_v {
+    # vle32.v vd, (rs1)
+    my $template = 0b0000001_00000_00000_110_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($vd << 7));
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
+sub vlse64_v {
+    # vlse64.v vd, (rs1), rs2
+    my $template = 0b0000101_00000_00000_111_00000_0000111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($vd << 7));
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
+    return ".word ".($template | ($vs2 << 20) | ($vs1 <<   15) | ($vd << 7))
+}
+
+sub vmseq_vi {
+    # vmseq vd vs1, imm
+    my $template = 0b0110001_00000_00000_011_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs1 = read_vreg shift;
+    my $imm = shift;
+    return ".word ".($template | ($vs1 << 20) | ($imm <<   15) | ($vd << 7))
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
+sub vse32_v {
+    # vse32.v vd, (rs1)
+    my $template = 0b0000001_00000_00000_110_00000_0100111;
+    my $vd = read_vreg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($vd << 7));
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
+sub vsetivli__x0_2_e64_m1_ta_ma {
+    # vsetivli x0, 2, e64, m1, ta, ma
+    return ".word 0xcd817057";
+}
+
+sub vsetivli__x0_4_e32_m1_ta_ma {
+    # vsetivli x0, 4, e32, m1, ta, ma
+    return ".word 0xcd027057";
+}
+
+sub vsetivli__x0_4_e64_m1_ta_ma {
+    # vsetivli x0,4,e64,m1,ta,ma
+    return ".word 0xcd827057";
+}
+
+sub vsetivli__x0_8_e32_m1_ta_ma {
+    return ".word 0xcd047057";
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
+# Vector crypto instructions
+
+## Zvbb instructions
+
+sub vrev8_v {
+    # vrev8.v vd, vs2
+    my $template = 0b0100101_00000_01001_010_00000_1010111;
+    my $vd = read_vreg shift;
+    my $vs2 = read_vreg shift;
+    return ".word ".($template | ($vs2 << 20) | ($vd << 7));
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
 1;
-- 
2.39.2

