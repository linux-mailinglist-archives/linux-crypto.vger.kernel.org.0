Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5726C98C
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Sep 2020 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgIPTMo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Sep 2020 15:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgIPRkj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:39 -0400
Received: from e123331-lin.nice.arm.com (adsl-245.46.190.88.tellas.gr [46.190.88.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E83121741;
        Wed, 16 Sep 2020 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600259815;
        bh=jdhet4pAVNc3fpclGZ8QPI56K1G+WFUaqh6M3wUEr+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToOOTPbvq/tUHYgszQiFk4RgRRzkb0HAgIqSj6e7EFb7GvDwh+RDug0Fu9jzLlkCe
         plKuiXL+EVfmRQ0PEb0jXIC7UCOHCFMwLlC+jKtbhkTJkksaaeP7YTujcK+9jLSFcL
         g49Qleb1JKlileDF15aiU1vb+6EJJ1tJ2Nvo7rmE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] crypto: arm/aes-neonbs - avoid loading reorder argument on encryption
Date:   Wed, 16 Sep 2020 15:36:41 +0300
Message-Id: <20200916123642.20805-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916123642.20805-1-ardb@kernel.org>
References: <20200916123642.20805-1-ardb@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Reordering the tweak is never necessary for encryption, so avoid the
argument load on the encryption path.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/crypto/aes-neonbs-core.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/aes-neonbs-core.S b/arch/arm/crypto/aes-neonbs-core.S
index 07cde1374bb0..7d0cc7f226a5 100644
--- a/arch/arm/crypto/aes-neonbs-core.S
+++ b/arch/arm/crypto/aes-neonbs-core.S
@@ -956,8 +956,7 @@ ENDPROC(__xts_prepare8)
 	push		{r4-r8, lr}
 	mov		r5, sp			// preserve sp
 	ldrd		r6, r7, [sp, #24]	// get blocks and iv args
-	ldr		r8, [sp, #32]		// reorder final tweak?
-	rsb		r8, r8, #1
+	rsb		r8, ip, #1
 	sub		ip, sp, #128		// make room for 8x tweak
 	bic		ip, ip, #0xf		// align sp to 16 bytes
 	mov		sp, ip
@@ -1013,9 +1012,11 @@ ENDPROC(__xts_prepare8)
 	.endm
 
 ENTRY(aesbs_xts_encrypt)
+	mov		ip, #0			// never reorder final tweak
 	__xts_crypt	aesbs_encrypt8, q0, q1, q4, q6, q3, q7, q2, q5
 ENDPROC(aesbs_xts_encrypt)
 
 ENTRY(aesbs_xts_decrypt)
+	ldr		ip, [sp, #8]		// reorder final tweak?
 	__xts_crypt	aesbs_decrypt8, q0, q1, q6, q4, q2, q7, q3, q5
 ENDPROC(aesbs_xts_decrypt)
-- 
2.17.1

