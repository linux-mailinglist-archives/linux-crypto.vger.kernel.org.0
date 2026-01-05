Return-Path: <linux-crypto+bounces-19614-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 308FECF1F76
	for <lists+linux-crypto@lfdr.de>; Mon, 05 Jan 2026 06:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3852B307A54A
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Jan 2026 05:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470B32D0DD;
	Mon,  5 Jan 2026 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH4w7+H/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A632C943;
	Mon,  5 Jan 2026 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767590108; cv=none; b=JRCRyHayGXD6tPPq4+bxO13dhRmsQW2ss6N+JS+HgOewM8FYQ4m0ZTf9jJQyYZuf8gaOoGgjQ+5Jj/w3B7CTPsyYEvPuj/Ov5ArFnz8WMEHvUh24FkYysx4d8q+frjX3vJjXj//dnzvnxjnRTSYPGZpcO396P3t+NztyJKyGfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767590108; c=relaxed/simple;
	bh=CEvjFtjQNPUEArHuTq+3s4Z3LAXNjA8ATEyzFR/Xb40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfWEsVmIAMIMkU8oIusJuHawhNIx8nfqi089BPTbAHz4geHigCSenBvwxgoskTTVnw1MuwmsYdIx8kwREFLvpSKG1skc3Bt+IwF4Dt5190LBiqRaYsLJyP+TkA8Crhxk+b6/aikRmnEjATlnOrMJYPFJTlZlSnfCkEux4Q+TmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH4w7+H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7216BC2BCB1;
	Mon,  5 Jan 2026 05:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767590108;
	bh=CEvjFtjQNPUEArHuTq+3s4Z3LAXNjA8ATEyzFR/Xb40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH4w7+H/0TkVDsJHMpEQqO72NXoaXdINRgTgmORdg/nBswVAhCJciDqyoaLoEsk0x
	 KAoH6UDXekrcipmj9EdyeltYyimR8UnDLawkjI+6YrgvtaV4XC6uy9bBcAwrCNOrqo
	 uvxWBU0GvZbjMMUxcxvyJ9+SSzcidEvS5+fb80pKeNVuf8mx93IcjqYPmo34LlotI8
	 R5iQTDSnm88aKbHIRjqpZ2geZ/An+n4r2q/siZIBEGFNZM6W0LiU9yHjVWFX3eojlW
	 chB+ghWLPeuD4EP0rNVXAzy1XU8rRggwi7ZW+xfi4AwjnXFQEHyAbPfYYJvt0v3Ijb
	 l3FWDTk6gFuFQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 26/36] crypto: ccp - Use new AES library API
Date: Sun,  4 Jan 2026 21:12:59 -0800
Message-ID: <20260105051311.1607207-27-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105051311.1607207-1-ebiggers@kernel.org>
References: <20260105051311.1607207-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from the old AES library functions (which use struct
crypto_aes_ctx) to the new ones (which use struct aes_enckey).  This
eliminates the unnecessary computation and caching of the decryption
round keys.  The new AES en/decryption functions are also much faster
and use AES instructions when supported by the CPU.

Note: aes_encrypt_new() will be renamed to aes_encrypt() once all
callers of the old aes_encrypt() have been updated.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/crypto/ccp/ccp-crypto-aes-cmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes-cmac.c b/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
index d8426bdf3190..ed5b0f8609f1 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-cmac.c
@@ -259,11 +259,11 @@ static int ccp_aes_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 	struct ccp_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct ccp_crypto_ahash_alg *alg =
 		ccp_crypto_ahash_alg(crypto_ahash_tfm(tfm));
 	u64 k0_hi, k0_lo, k1_hi, k1_lo, k2_hi, k2_lo;
 	u64 rb_hi = 0x00, rb_lo = 0x87;
-	struct crypto_aes_ctx aes;
+	struct aes_enckey aes;
 	__be64 *gk;
 	int ret;
 
 	switch (key_len) {
 	case AES_KEYSIZE_128:
@@ -282,17 +282,17 @@ static int ccp_aes_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 
 	/* Set to zero until complete */
 	ctx->u.aes.key_len = 0;
 
 	/* Set the key for the AES cipher used to generate the keys */
-	ret = aes_expandkey(&aes, key, key_len);
+	ret = aes_prepareenckey(&aes, key, key_len);
 	if (ret)
 		return ret;
 
 	/* Encrypt a block of zeroes - use key area in context */
 	memset(ctx->u.aes.key, 0, sizeof(ctx->u.aes.key));
-	aes_encrypt(&aes, ctx->u.aes.key, ctx->u.aes.key);
+	aes_encrypt_new(&aes, ctx->u.aes.key, ctx->u.aes.key);
 	memzero_explicit(&aes, sizeof(aes));
 
 	/* Generate K1 and K2 */
 	k0_hi = be64_to_cpu(*((__be64 *)ctx->u.aes.key));
 	k0_lo = be64_to_cpu(*((__be64 *)ctx->u.aes.key + 1));
-- 
2.52.0


