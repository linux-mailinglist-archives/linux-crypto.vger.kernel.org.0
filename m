Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CB3F94D0
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Aug 2021 09:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbhH0HEp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Aug 2021 03:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244407AbhH0HEp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Aug 2021 03:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D28E460FD8;
        Fri, 27 Aug 2021 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630047837;
        bh=wORP+cczyLOONPyMYye+k0Djo3iNYiwdUHvTiSrRTEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv+ktl5j+80JvGoCQ8/PhYdn/fNRPLzgjXWArNOFzaEligf/ahSqtbBmoxpYdxwe0
         hsTTqrdBbMPTIDiX0cX9aWo11pdUnxdOUkg92xGGnL5fu3SU5KDZ9313E7OFUkW1LU
         508dfnIlVRo7hY7bxXT4k+t8bQ6IefWOlJ8xCGMQeawO3Ub27UorjoDNTBKlzW3Smo
         Cz58H8Y256j9dD63SwzL4blPq9IWZyEztXX8VmrJ8Qe2e7+xjCpvxaLMk1GdA6iFgJ
         rvX9qGG/i2eXr6EW2tMf/z/rBTx7tBgmm5iRa2y9m62g5EXwKRNwj4X+bgDNjJckbW
         IYmjEbWbnjAzg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 6/7] crypto: arm64/aes-ccm - reduce NEON begin/end calls for common case
Date:   Fri, 27 Aug 2021 09:03:41 +0200
Message-Id: <20210827070342.218276-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210827070342.218276-1-ardb@kernel.org>
References: <20210827070342.218276-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

AES-CCM (as used in WPA2 CCMP, for instance) typically involves
authenticate-only data, and operates on a single network packet, and so
the common case is for the authenticate, en/decrypt and finalize SIMD
helpers to all be called exactly once in sequence. Since
kernel_neon_end() now involves manipulation of the preemption state as
well as the softirq mask state, let's reduce the number of times we are
forced to call it to only once if we are handling this common case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-ce-ccm-core.S |  1 +
 arch/arm64/crypto/aes-ce-ccm-glue.c | 80 ++++++++++++--------
 2 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-core.S b/arch/arm64/crypto/aes-ce-ccm-core.S
index 99a028e298ed..8adff299fcd3 100644
--- a/arch/arm64/crypto/aes-ce-ccm-core.S
+++ b/arch/arm64/crypto/aes-ce-ccm-core.S
@@ -124,6 +124,7 @@ SYM_FUNC_START(ce_aes_ccm_final)
 SYM_FUNC_END(ce_aes_ccm_final)
 
 	.macro	aes_ccm_do_crypt,enc
+	cbz	x2, 5f
 	ldr	x8, [x6, #8]			/* load lower ctr */
 	ld1	{v0.16b}, [x5]			/* load mac */
 CPU_LE(	rev	x8, x8			)	/* keep swabbed ctr in reg */
diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index c1f221a181a5..d973655fab7e 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -97,10 +97,8 @@ static int ccm_init_mac(struct aead_request *req, u8 maciv[], u32 msglen)
 static void ccm_update_mac(struct crypto_aes_ctx *key, u8 mac[], u8 const in[],
 			   u32 abytes, u32 *macp)
 {
-	kernel_neon_begin();
 	ce_aes_ccm_auth_data(mac, in, abytes, macp, key->key_enc,
 			     num_rounds(key));
-	kernel_neon_end();
 }
 
 static void ccm_calculate_auth_mac(struct aead_request *req, u8 mac[])
@@ -136,6 +134,12 @@ static void ccm_calculate_auth_mac(struct aead_request *req, u8 mac[])
 		n = min_t(u32, n, SZ_4K); /* yield NEON at least every 4k */
 		p = scatterwalk_map(&walk);
 		ccm_update_mac(ctx, mac, p, n, &macp);
+
+		if (len / SZ_4K > (len - n) / SZ_4K) {
+			kernel_neon_end();
+			kernel_neon_begin();
+		}
+
 		len -= n;
 
 		scatterwalk_unmap(p);
@@ -158,35 +162,41 @@ static int ccm_encrypt(struct aead_request *req)
 	if (err)
 		return err;
 
-	if (req->assoclen)
-		ccm_calculate_auth_mac(req, mac);
-
 	/* preserve the original iv for the final round */
 	memcpy(buf, req->iv, AES_BLOCK_SIZE);
 
 	err = skcipher_walk_aead_encrypt(&walk, req, false);
+	if (unlikely(err))
+		return err;
+
+	kernel_neon_begin();
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, mac);
 
-	while (walk.nbytes) {
+	do {
 		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
 
 		if (walk.nbytes == walk.total)
 			tail = 0;
 
-		kernel_neon_begin();
 		ce_aes_ccm_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
 				   walk.nbytes - tail, ctx->key_enc,
 				   num_rounds(ctx), mac, walk.iv);
-		kernel_neon_end();
 
-		err = skcipher_walk_done(&walk, tail);
-	}
-	if (!err) {
-		kernel_neon_begin();
-		ce_aes_ccm_final(mac, buf, ctx->key_enc, num_rounds(ctx));
+		if (walk.nbytes == walk.total)
+			ce_aes_ccm_final(mac, buf, ctx->key_enc, num_rounds(ctx));
+
 		kernel_neon_end();
-	}
-	if (err)
-		return err;
+
+		if (walk.nbytes) {
+			err = skcipher_walk_done(&walk, tail);
+			if (unlikely(err))
+				return err;
+			if (unlikely(walk.nbytes))
+				kernel_neon_begin();
+		}
+	} while (walk.nbytes);
 
 	/* copy authtag to end of dst */
 	scatterwalk_map_and_copy(mac, req->dst, req->assoclen + req->cryptlen,
@@ -210,35 +220,41 @@ static int ccm_decrypt(struct aead_request *req)
 	if (err)
 		return err;
 
-	if (req->assoclen)
-		ccm_calculate_auth_mac(req, mac);
-
 	/* preserve the original iv for the final round */
 	memcpy(buf, req->iv, AES_BLOCK_SIZE);
 
 	err = skcipher_walk_aead_decrypt(&walk, req, false);
+	if (unlikely(err))
+		return err;
 
-	while (walk.nbytes) {
+	kernel_neon_begin();
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, mac);
+
+	do {
 		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
 
 		if (walk.nbytes == walk.total)
 			tail = 0;
 
-		kernel_neon_begin();
 		ce_aes_ccm_decrypt(walk.dst.virt.addr, walk.src.virt.addr,
-					   walk.nbytes - tail, ctx->key_enc,
-					   num_rounds(ctx), mac, walk.iv);
-		kernel_neon_end();
+				   walk.nbytes - tail, ctx->key_enc,
+				   num_rounds(ctx), mac, walk.iv);
+
+		if (walk.nbytes == walk.total)
+			ce_aes_ccm_final(mac, buf, ctx->key_enc, num_rounds(ctx));
 
-		err = skcipher_walk_done(&walk, tail);
-	}
-	if (!err) {
-		kernel_neon_begin();
-		ce_aes_ccm_final(mac, buf, ctx->key_enc, num_rounds(ctx));
 		kernel_neon_end();
-	}
-	if (err)
-		return err;
+
+		if (walk.nbytes) {
+			err = skcipher_walk_done(&walk, tail);
+			if (unlikely(err))
+				return err;
+			if (unlikely(walk.nbytes))
+				kernel_neon_begin();
+		}
+	} while (walk.nbytes);
 
 	/* compare calculated auth tag with the stored one */
 	scatterwalk_map_and_copy(buf, req->src,
-- 
2.30.2

