Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444CB163288
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Feb 2020 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBRUHb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Feb 2020 15:07:31 -0500
Received: from foss.arm.com ([217.140.110.172]:60480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgBRT7D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Feb 2020 14:59:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE883FEC;
        Tue, 18 Feb 2020 11:59:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5210A3F68F;
        Tue, 18 Feb 2020 11:59:02 -0800 (PST)
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
Subject: [PATCH 04/18] arm64: entry: Annotate ret_from_fork as code
Date:   Tue, 18 Feb 2020 19:58:28 +0000
Message-Id: <20200218195842.34156-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218195842.34156-1-broonie@kernel.org>
References: <20200218195842.34156-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In an effort to clarify and simplify the annotation of assembly
functions new macros have been introduced. These replace ENTRY and
ENDPROC with two different annotations for normal functions and those
with unusual calling conventions.

ret_from_fork is not a normal C function and should therefore be
annotated as code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1454f3ea2e2e..d535cb8a7413 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -902,14 +902,14 @@ NOKPROBE(cpu_switch_to)
 /*
  * This is how we return from a fork.
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	bl	schedule_tail
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
 	blr	x19
 1:	get_current_task tsk
 	b	ret_to_user
-ENDPROC(ret_from_fork)
+SYM_CODE_END(ret_from_fork)
 NOKPROBE(ret_from_fork)
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
-- 
2.20.1

