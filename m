Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E4174C31
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Mar 2020 09:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgCAIHO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 1 Mar 2020 03:07:14 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:43245 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCAIHO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 1 Mar 2020 03:07:14 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7e9ea0e4;
        Sun, 1 Mar 2020 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=PWd4gaEwdwxzUv9bntUt3ix7rVQ=; b=EYI2leuhfqL1V/ghpwDz
        fDZNufa5kC8gjVLiEvJxLIkoIdizPZ76FLctdzLtQFrExqrxXSZEzmQ24CaNSnEb
        vgnrDe9Upp+VdmaEd35r4Aiv1viP7bQJTO2ipuZrp9qLsLpWJ4RWSBmK1rtCczzv
        IZVk85b+6tD7UxYE8QQUsbP77ZfXhKKwFtOTMpsBIa9zFozY2A324lVoGhyrkuSz
        pcI6M8Wvm7R9UV0r/dpMO0U79uGUQMAAJK3i18MXgKZ02aKRBRiAvwV4QhfD/U0O
        Ya64eyG3GgtylozTIVGy08P0RRQonIC+2iEVIIK8SJlLVleSVrxtbikKb9+2ZNYn
        Hg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 84ff11e7 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 1 Mar 2020 08:03:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH cryptodev] crypto: x86/curve25519 - leave r12 as spare register
Date:   Sun,  1 Mar 2020 16:06:56 +0800
Message-Id: <20200301080656.772440-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This updates to the newer register selection proved by HACL*, which
leads to a more compact instruction encoding, and saves around 100
cycles.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/crypto/curve25519-x86_64.c | 110 ++++++++++++++--------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index e4e58b8e9afe..8a17621f7d3a 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -167,28 +167,28 @@ static inline void fmul(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  movq 0(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 0(%0);"
 		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 8(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"
 		/* Compute src1[1] * src2 */
 		"  movq 8(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 8(%0), %%r8;"    "  movq %%r8, 8(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 16(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 16(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[2] * src2 */
 		"  movq 16(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 16(%0), %%r8;"    "  movq %%r8, 16(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 24(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 24(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[3] * src2 */
 		"  movq 24(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 24(%0), %%r8;"    "  movq %%r8, 24(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 32(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 40(%0);"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 32(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  movq %%rbx, 40(%0);"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 48(%0);"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 56(%0);"
 		/* Line up pointers */
@@ -202,11 +202,11 @@ static inline void fmul(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  mulxq 32(%1), %%r8, %%r13;"
 		"  xor %3, %3;"
 		"  adoxq 0(%1), %%r8;"
-		"  mulxq 40(%1), %%r9, %%r12;"
+		"  mulxq 40(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 8(%1), %%r9;"
 		"  mulxq 48(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 16(%1), %%r10;"
 		"  mulxq 56(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -231,7 +231,7 @@ static inline void fmul(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  movq %%r8, 0(%0);"
 	: "+&r" (tmp), "+&r" (f1), "+&r" (out), "+&r" (f2)
 	:
-	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "memory", "cc"
+	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%rbx", "%r13", "%r14", "memory", "cc"
 	);
 }
 
@@ -248,28 +248,28 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  movq 0(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 0(%0);"
 		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 8(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"
 		/* Compute src1[1] * src2 */
 		"  movq 8(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 8(%0), %%r8;"    "  movq %%r8, 8(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 16(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 16(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[2] * src2 */
 		"  movq 16(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 16(%0), %%r8;"    "  movq %%r8, 16(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 24(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 24(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[3] * src2 */
 		"  movq 24(%1), %%rdx;"
 		"  mulxq 0(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 24(%0), %%r8;"    "  movq %%r8, 24(%0);"
-		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 32(%0);"
-		"  mulxq 16(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 40(%0);"    "  mov $0, %%r8;"
+		"  mulxq 8(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 32(%0);"
+		"  mulxq 16(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  movq %%rbx, 40(%0);"    "  mov $0, %%r8;"
 		"  mulxq 24(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 48(%0);"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 56(%0);"
 
@@ -279,28 +279,28 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  movq 32(%1), %%rdx;"
 		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  movq %%r8, 64(%0);"
 		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  movq %%r10, 72(%0);"
-		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"
+		"  mulxq 48(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"
 		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"
 		/* Compute src1[1] * src2 */
 		"  movq 40(%1), %%rdx;"
 		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"     "  adcxq 72(%0), %%r8;"    "  movq %%r8, 72(%0);"
-		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 80(%0);"
-		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 80(%0);"
+		"  mulxq 48(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[2] * src2 */
 		"  movq 48(%1), %%rdx;"
 		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 80(%0), %%r8;"    "  movq %%r8, 80(%0);"
-		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 88(%0);"
-		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  mov $0, %%r8;"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 88(%0);"
+		"  mulxq 48(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  mov $0, %%r8;"
 		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"
 		/* Compute src1[3] * src2 */
 		"  movq 56(%1), %%rdx;"
 		"  mulxq 32(%3), %%r8, %%r9;"       "  xor %%r10, %%r10;"    "  adcxq 88(%0), %%r8;"    "  movq %%r8, 88(%0);"
-		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%r12, %%r10;"    "  movq %%r10, 96(%0);"
-		"  mulxq 48(%3), %%r12, %%r13;"    "  adox %%r11, %%r12;"    "  adcx %%r14, %%r12;"    "  movq %%r12, 104(%0);"    "  mov $0, %%r8;"
+		"  mulxq 40(%3), %%r10, %%r11;"     "  adox %%r9, %%r10;"     "  adcx %%rbx, %%r10;"    "  movq %%r10, 96(%0);"
+		"  mulxq 48(%3), %%rbx, %%r13;"    "  adox %%r11, %%rbx;"    "  adcx %%r14, %%rbx;"    "  movq %%rbx, 104(%0);"    "  mov $0, %%r8;"
 		"  mulxq 56(%3), %%r14, %%rdx;"    "  adox %%r13, %%r14;"    "  adcx %%rax, %%r14;"    "  movq %%r14, 112(%0);"    "  mov $0, %%rax;"
 		                                   "  adox %%rdx, %%rax;"    "  adcx %%r8, %%rax;"     "  movq %%rax, 120(%0);"
 		/* Line up pointers */
@@ -314,11 +314,11 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  mulxq 32(%1), %%r8, %%r13;"
 		"  xor %3, %3;"
 		"  adoxq 0(%1), %%r8;"
-		"  mulxq 40(%1), %%r9, %%r12;"
+		"  mulxq 40(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 8(%1), %%r9;"
 		"  mulxq 48(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 16(%1), %%r10;"
 		"  mulxq 56(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -347,11 +347,11 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  mulxq 96(%1), %%r8, %%r13;"
 		"  xor %3, %3;"
 		"  adoxq 64(%1), %%r8;"
-		"  mulxq 104(%1), %%r9, %%r12;"
+		"  mulxq 104(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 72(%1), %%r9;"
 		"  mulxq 112(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 80(%1), %%r10;"
 		"  mulxq 120(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -376,7 +376,7 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
 		"  movq %%r8, 32(%0);"
 	: "+&r" (tmp), "+&r" (f1), "+&r" (out), "+&r" (f2)
 	:
-	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "memory", "cc"
+	: "%rax", "%rdx", "%r8", "%r9", "%r10", "%r11", "%rbx", "%r13", "%r14", "memory", "cc"
 	);
 }
 
@@ -388,11 +388,11 @@ static inline void fmul_scalar(u64 *out, const u64 *f1, u64 f2)
 	asm volatile(
 		/* Compute the raw multiplication of f1*f2 */
 		"  mulxq 0(%2), %%r8, %%rcx;"      /* f1[0]*f2 */
-		"  mulxq 8(%2), %%r9, %%r12;"      /* f1[1]*f2 */
+		"  mulxq 8(%2), %%r9, %%rbx;"      /* f1[1]*f2 */
 		"  add %%rcx, %%r9;"
 		"  mov $0, %%rcx;"
 		"  mulxq 16(%2), %%r10, %%r13;"    /* f1[2]*f2 */
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  mulxq 24(%2), %%r11, %%rax;"    /* f1[3]*f2 */
 		"  adcx %%r13, %%r11;"
 		"  adcx %%rcx, %%rax;"
@@ -419,7 +419,7 @@ static inline void fmul_scalar(u64 *out, const u64 *f1, u64 f2)
 		"  movq %%r8, 0(%1);"
 	: "+&r" (f2_r)
 	: "r" (out), "r" (f1)
-	: "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "memory", "cc"
+	: "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11", "%rbx", "%r13", "memory", "cc"
 	);
 }
 
@@ -520,8 +520,8 @@ static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 16(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
 		"  mulxq 24(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
 		"  movq 24(%1), %%rdx;"                                      /* f[3] */
-		"  mulxq 8(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
-		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  mulxq 8(%1), %%r11, %%rbx;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%rbx;"    /* f[2]*f[3] */
 		"  movq 8(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
 		"  mulxq 16(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
 
@@ -531,12 +531,12 @@ static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%r8, %%r8;"
 		"  adox %%rcx, %%r11;"
 		"  adcx %%r9, %%r9;"
-		"  adox %%r15, %%r12;"
+		"  adox %%r15, %%rbx;"
 		"  adcx %%r10, %%r10;"
 		"  adox %%r15, %%r13;"
 		"  adcx %%r11, %%r11;"
 		"  adox %%r15, %%r14;"
-		"  adcx %%r12, %%r12;"
+		"  adcx %%rbx, %%rbx;"
 		"  adcx %%r13, %%r13;"
 		"  adcx %%r14, %%r14;"
 
@@ -549,7 +549,7 @@ static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%rcx, %%r10;"     "  movq %%r10, 24(%0);"
 		"  movq 16(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
 		"  adcx %%rax, %%r11;"     "  movq %%r11, 32(%0);"
-		"  adcx %%rcx, %%r12;"     "  movq %%r12, 40(%0);"
+		"  adcx %%rcx, %%rbx;"     "  movq %%rbx, 40(%0);"
 		"  movq 24(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
 		"  adcx %%rax, %%r13;"     "  movq %%r13, 48(%0);"
 		"  adcx %%rcx, %%r14;"     "  movq %%r14, 56(%0);"
@@ -565,11 +565,11 @@ static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 32(%1), %%r8, %%r13;"
 		"  xor %%rcx, %%rcx;"
 		"  adoxq 0(%1), %%r8;"
-		"  mulxq 40(%1), %%r9, %%r12;"
+		"  mulxq 40(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 8(%1), %%r9;"
 		"  mulxq 48(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 16(%1), %%r10;"
 		"  mulxq 56(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -594,7 +594,7 @@ static inline void fsqr(u64 *out, const u64 *f, u64 *tmp)
 		"  movq %%r8, 0(%0);"
 	: "+&r" (tmp), "+&r" (f), "+&r" (out)
 	:
-	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "memory", "cc"
+	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%rbx", "%r13", "%r14", "%r15", "memory", "cc"
 	);
 }
 
@@ -611,8 +611,8 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 16(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
 		"  mulxq 24(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
 		"  movq 24(%1), %%rdx;"                                      /* f[3] */
-		"  mulxq 8(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
-		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  mulxq 8(%1), %%r11, %%rbx;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%rbx;"    /* f[2]*f[3] */
 		"  movq 8(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
 		"  mulxq 16(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
 
@@ -622,12 +622,12 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%r8, %%r8;"
 		"  adox %%rcx, %%r11;"
 		"  adcx %%r9, %%r9;"
-		"  adox %%r15, %%r12;"
+		"  adox %%r15, %%rbx;"
 		"  adcx %%r10, %%r10;"
 		"  adox %%r15, %%r13;"
 		"  adcx %%r11, %%r11;"
 		"  adox %%r15, %%r14;"
-		"  adcx %%r12, %%r12;"
+		"  adcx %%rbx, %%rbx;"
 		"  adcx %%r13, %%r13;"
 		"  adcx %%r14, %%r14;"
 
@@ -640,7 +640,7 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%rcx, %%r10;"     "  movq %%r10, 24(%0);"
 		"  movq 16(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
 		"  adcx %%rax, %%r11;"     "  movq %%r11, 32(%0);"
-		"  adcx %%rcx, %%r12;"     "  movq %%r12, 40(%0);"
+		"  adcx %%rcx, %%rbx;"     "  movq %%rbx, 40(%0);"
 		"  movq 24(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
 		"  adcx %%rax, %%r13;"     "  movq %%r13, 48(%0);"
 		"  adcx %%rcx, %%r14;"     "  movq %%r14, 56(%0);"
@@ -651,8 +651,8 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 48(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
 		"  mulxq 56(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
 		"  movq 56(%1), %%rdx;"                                      /* f[3] */
-		"  mulxq 40(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
-		"  mulxq 48(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
+		"  mulxq 40(%1), %%r11, %%rbx;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
+		"  mulxq 48(%1), %%rax, %%r13;"    "  adcx %%rax, %%rbx;"    /* f[2]*f[3] */
 		"  movq 40(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
 		"  mulxq 48(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
 
@@ -662,12 +662,12 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%r8, %%r8;"
 		"  adox %%rcx, %%r11;"
 		"  adcx %%r9, %%r9;"
-		"  adox %%r15, %%r12;"
+		"  adox %%r15, %%rbx;"
 		"  adcx %%r10, %%r10;"
 		"  adox %%r15, %%r13;"
 		"  adcx %%r11, %%r11;"
 		"  adox %%r15, %%r14;"
-		"  adcx %%r12, %%r12;"
+		"  adcx %%rbx, %%rbx;"
 		"  adcx %%r13, %%r13;"
 		"  adcx %%r14, %%r14;"
 
@@ -680,7 +680,7 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  adcx %%rcx, %%r10;"     "  movq %%r10, 88(%0);"
 		"  movq 48(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
 		"  adcx %%rax, %%r11;"     "  movq %%r11, 96(%0);"
-		"  adcx %%rcx, %%r12;"     "  movq %%r12, 104(%0);"
+		"  adcx %%rcx, %%rbx;"     "  movq %%rbx, 104(%0);"
 		"  movq 56(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
 		"  adcx %%rax, %%r13;"     "  movq %%r13, 112(%0);"
 		"  adcx %%rcx, %%r14;"     "  movq %%r14, 120(%0);"
@@ -694,11 +694,11 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 32(%1), %%r8, %%r13;"
 		"  xor %%rcx, %%rcx;"
 		"  adoxq 0(%1), %%r8;"
-		"  mulxq 40(%1), %%r9, %%r12;"
+		"  mulxq 40(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 8(%1), %%r9;"
 		"  mulxq 48(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 16(%1), %%r10;"
 		"  mulxq 56(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -727,11 +727,11 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  mulxq 96(%1), %%r8, %%r13;"
 		"  xor %%rcx, %%rcx;"
 		"  adoxq 64(%1), %%r8;"
-		"  mulxq 104(%1), %%r9, %%r12;"
+		"  mulxq 104(%1), %%r9, %%rbx;"
 		"  adcx %%r13, %%r9;"
 		"  adoxq 72(%1), %%r9;"
 		"  mulxq 112(%1), %%r10, %%r13;"
-		"  adcx %%r12, %%r10;"
+		"  adcx %%rbx, %%r10;"
 		"  adoxq 80(%1), %%r10;"
 		"  mulxq 120(%1), %%r11, %%rax;"
 		"  adcx %%r13, %%r11;"
@@ -756,7 +756,7 @@ static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
 		"  movq %%r8, 32(%0);"
 	: "+&r" (tmp), "+&r" (f), "+&r" (out)
 	:
-	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "memory", "cc"
+	: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%rbx", "%r13", "%r14", "%r15", "memory", "cc"
 	);
 }
 
-- 
2.25.0

