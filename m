Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB9163272
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Feb 2020 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBRT7N (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Feb 2020 14:59:13 -0500
Received: from foss.arm.com ([217.140.110.172]:60558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgBRT7M (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Feb 2020 14:59:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99B6101E;
        Tue, 18 Feb 2020 11:59:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BBAC3F68F;
        Tue, 18 Feb 2020 11:59:11 -0800 (PST)
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
Subject: [PATCH 08/18] arm64: ftrace: Modernise annotation of return_to_handler
Date:   Tue, 18 Feb 2020 19:58:32 +0000
Message-Id: <20200218195842.34156-9-broonie@kernel.org>
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

return_to_handler does entertaining things with LR so doesn't follow the
usual C conventions and should therefore be annotated as code rather than
a function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/entry-ftrace.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index baf5a20a5566..820101821ac4 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -320,7 +320,7 @@ SYM_FUNC_END(ftrace_stub)
  * Run ftrace_return_to_handler() before going back to parent.
  * @fp is checked against the value passed by ftrace_graph_caller().
  */
-ENTRY(return_to_handler)
+SYM_CODE_START(return_to_handler)
 	/* save return value regs */
 	sub sp, sp, #64
 	stp x0, x1, [sp]
@@ -340,5 +340,5 @@ ENTRY(return_to_handler)
 	add sp, sp, #64
 
 	ret
-END(return_to_handler)
+SYM_CODE_END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

