Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6502DE7CC
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Dec 2020 18:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgLRRDt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Dec 2020 12:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgLRRDs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Dec 2020 12:03:48 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 1/5] crypto: aead - disallow en/decrypt for non-task or non-softirq context
Date:   Fri, 18 Dec 2020 18:01:02 +0100
Message-Id: <20201218170106.23280-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218170106.23280-1-ardb@kernel.org>
References: <20201218170106.23280-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In order to ensure that kernel mode SIMD routines will not need a scalar
fallback if they run with softirqs disabled, disallow any use of the
AEAD encrypt and decrypt routines from outside of task or softirq context.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aead.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/crypto/aead.c b/crypto/aead.c
index 16991095270d..b5304b3d3314 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -87,6 +87,11 @@ int crypto_aead_encrypt(struct aead_request *req)
 	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+	if (!(alg->cra_flags & CRYPTO_ALG_ASYNC) &&
+	    WARN_ONCE(!in_task() && !in_serving_softirq(),
+		      "synchronous call from invalid context\n"))
+		return -EBUSY;
+
 	crypto_stats_get(alg);
 	if (crypto_aead_get_flags(aead) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
@@ -104,6 +109,11 @@ int crypto_aead_decrypt(struct aead_request *req)
 	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+	if (!(alg->cra_flags & CRYPTO_ALG_ASYNC) &&
+	    WARN_ONCE(!in_task() && !in_serving_softirq(),
+		      "synchronous call from invalid context\n"))
+		return -EBUSY;
+
 	crypto_stats_get(alg);
 	if (crypto_aead_get_flags(aead) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
-- 
2.17.1

