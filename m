Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34CD16314F
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Feb 2020 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgBRT7T (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Feb 2020 14:59:19 -0500
Received: from foss.arm.com ([217.140.110.172]:60616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgBRT7S (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Feb 2020 14:59:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C7C31B;
        Tue, 18 Feb 2020 11:59:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED71F3F68F;
        Tue, 18 Feb 2020 11:59:17 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-crypto@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 11/18] arm64: kernel: Convert to modern annotations for assembly data
Date:   Tue, 18 Feb 2020 19:58:35 +0000
Message-Id: <20200218195842.34156-12-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218195842.34156-1-broonie@kernel.org>
References: <20200218195842.34156-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In an effort to clarify and simplify the annotation of assembly functions
in the kernel new macros have been introduced. These include specific
annotations for the start and end of data, update symbols for data to use
these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/entry.S | 7 ++++---
 arch/arm64/kernel/head.S  | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fbf69fe94412..7439f29946fb 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -859,9 +859,9 @@ SYM_CODE_END(tramp_exit_compat)
 #ifdef CONFIG_RANDOMIZE_BASE
 	.pushsection ".rodata", "a"
 	.align PAGE_SHIFT
-	.globl	__entry_tramp_data_start
-__entry_tramp_data_start:
+SYM_DATA_START(__entry_tramp_data_start)
 	.quad	vectors
+SYM_DATA_END(__entry_tramp_data_start)
 	.popsection				// .rodata
 #endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
@@ -983,8 +983,9 @@ NOKPROBE(__sdei_asm_exit_trampoline)
 .popsection		// .entry.tramp.text
 #ifdef CONFIG_RANDOMIZE_BASE
 .pushsection ".rodata", "a"
-__sdei_asm_trampoline_next_handler:
+SYM_DATA_START(__sdei_asm_trampoline_next_handler)
 	.quad	__sdei_asm_handler
+SYM_DATA_END(__sdei_asm_trampoline_next_handler)
 .popsection		// .rodata
 #endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c334863991e7..a06727354fad 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -464,8 +464,9 @@ SYM_FUNC_END(__primary_switched)
  */
 	.section ".idmap.text","awx"
 
-ENTRY(kimage_vaddr)
+SYM_DATA_START(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
+SYM_DATA_END(kimage_vaddr)
 EXPORT_SYMBOL(kimage_vaddr)
 
 /*
@@ -667,15 +668,17 @@ SYM_FUNC_END(set_cpu_boot_mode_flag)
  * This is not in .bss, because we set it sufficiently early that the boot-time
  * zeroing of .bss would clobber it.
  */
-ENTRY(__boot_cpu_mode)
+SYM_DATA_START(__boot_cpu_mode)
 	.long	BOOT_CPU_MODE_EL2
 	.long	BOOT_CPU_MODE_EL1
+SYM_DATA_END(__boot_cpu_mode)
 /*
  * The booting CPU updates the failed status @__early_cpu_boot_status,
  * with MMU turned off.
  */
-ENTRY(__early_cpu_boot_status)
+SYM_DATA_START(__early_cpu_boot_status)
 	.quad 	0
+SYM_DATA_END(__early_cpu_boot_status)
 
 	.popsection
 
-- 
2.20.1

