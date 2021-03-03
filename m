Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA732B309
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Mar 2021 04:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhCCB1r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 2 Mar 2021 20:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378840AbhCBJCz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 2 Mar 2021 04:02:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21F4C64F16;
        Tue,  2 Mar 2021 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614675723;
        bh=aQQMjGFMp2Bb6EAdSE481XHUoiuLHHMb2JHfGrl7s/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9Y9skrG3ZpOLIg9ZjcKAdaEXs0t8IQQkjQ26AAYgJy3joZHYI1erC32NwWj/IVfk
         B2vVTvc1WQCHtoHkG4lmoXmb6zMppFOqrFtJE0E/XXhYkVMo2zIOpH5YsYgUiET+wn
         pR+lN3cFIW1oJdSOa4ftX5lU2+t4vvdFz++mUmPrOP7G+zss/qCeeI4cL6BPA6SuQV
         O/AOAG0Kisw/VBkFHhGRp53BVHBXBsq/xJ39RFC72L134+yWr9wQ8AUb5fcNB81LpA
         dHoWDOo3HqoJuy2M2wLTGjqYUJSV/smJu2qKRsK+BAbkAG23vLA2Ew1A3REpae9bwL
         lnsBLwt/fZPHw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/9] arm64: assembler: remove conditional NEON yield macros
Date:   Tue,  2 Mar 2021 10:01:10 +0100
Message-Id: <20210302090118.30666-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302090118.30666-1-ardb@kernel.org>
References: <20210302090118.30666-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The users of the conditional NEON yield macros have all been switched to
the simplified cond_yield macro, and so the NEON specific ones can be
removed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 70 --------------------
 1 file changed, 70 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ca31594d3d6c..e0fc1d424f9b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -692,76 +692,6 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	isb
 .endm
 
-/*
- * Check whether to yield to another runnable task from kernel mode NEON code
- * (which runs with preemption disabled).
- *
- * if_will_cond_yield_neon
- *        // pre-yield patchup code
- * do_cond_yield_neon
- *        // post-yield patchup code
- * endif_yield_neon    <label>
- *
- * where <label> is optional, and marks the point where execution will resume
- * after a yield has been performed. If omitted, execution resumes right after
- * the endif_yield_neon invocation. Note that the entire sequence, including
- * the provided patchup code, will be omitted from the image if
- * CONFIG_PREEMPTION is not defined.
- *
- * As a convenience, in the case where no patchup code is required, the above
- * sequence may be abbreviated to
- *
- * cond_yield_neon <label>
- *
- * Note that the patchup code does not support assembler directives that change
- * the output section, any use of such directives is undefined.
- *
- * The yield itself consists of the following:
- * - Check whether the preempt count is exactly 1 and a reschedule is also
- *   needed. If so, calling of preempt_enable() in kernel_neon_end() will
- *   trigger a reschedule. If it is not the case, yielding is pointless.
- * - Disable and re-enable kernel mode NEON, and branch to the yield fixup
- *   code.
- *
- * This macro sequence may clobber all CPU state that is not guaranteed by the
- * AAPCS to be preserved across an ordinary function call.
- */
-
-	.macro		cond_yield_neon, lbl
-	if_will_cond_yield_neon
-	do_cond_yield_neon
-	endif_yield_neon	\lbl
-	.endm
-
-	.macro		if_will_cond_yield_neon
-#ifdef CONFIG_PREEMPTION
-	get_current_task	x0
-	ldr		x0, [x0, #TSK_TI_PREEMPT]
-	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
-	cbz		x0, .Lyield_\@
-	/* fall through to endif_yield_neon */
-	.subsection	1
-.Lyield_\@ :
-#else
-	.section	".discard.cond_yield_neon", "ax"
-#endif
-	.endm
-
-	.macro		do_cond_yield_neon
-	bl		kernel_neon_end
-	bl		kernel_neon_begin
-	.endm
-
-	.macro		endif_yield_neon, lbl
-	.ifnb		\lbl
-	b		\lbl
-	.else
-	b		.Lyield_out_\@
-	.endif
-	.previous
-.Lyield_out_\@ :
-	.endm
-
 	/*
 	 * Check whether preempt-disabled code should yield as soon as it
 	 * is able. This is the case if re-enabling preemption a single
-- 
2.30.1

