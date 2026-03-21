Return-Path: <linux-crypto+bounces-22182-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GXmGu4avmlNGgMAu9opvQ
	(envelope-from <linux-crypto+bounces-22182-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 05:13:34 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0532E3394
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 05:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 291CB304A548
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281A359FAA;
	Sat, 21 Mar 2026 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so3kgmeO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313C3469FA;
	Sat, 21 Mar 2026 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774066325; cv=none; b=mMXbG0ly/SnWwEa4qV9Ll6I0Vks0OkD8+TQQ83/kai1wLitAaBbr12X6nwbe1x8HfrmLqg4648ZDVOL21tODTEgeDMPVORSdppsh1kJZXFs5QaBy6ERSjIJMKZpEzoMIyjnTkUn/8cBwuQGNBtGLVQZjyHnJ7SQaQFjP4Slfbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774066325; c=relaxed/simple;
	bh=lXet9mn/RNAHfsi2ltnD8G94KFEGqvjdvngfRQ0H8xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okYDwi3Rq0gl6qA2RctYZ/sg/DP9niZIk9OwExKxIvFbGZadv+NEK3n4RHj52D2uJe+TzjWTuPMvyEcwDVp/eP2k/AnFDhZXFIf+0RFZZdPA3sZMOUeebiVgDyLw8kUCvah9apgwvtXGO9quN7zQsW9V96st+PWf0TXfS/1yy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so3kgmeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1DBC2BCB0;
	Sat, 21 Mar 2026 04:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774066323;
	bh=lXet9mn/RNAHfsi2ltnD8G94KFEGqvjdvngfRQ0H8xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so3kgmeOeNqPqhjFKKKrVJiXY3XDI150LSByS/ickjQ8CnQMe+SSUL5qSwkyVMzRU
	 PJUEXz2dRmuc760kR7ocy/pQ6EFKC0THsdgeyzyS3IkmkPo6PL9rPwA4Fkm6vC/CK2
	 Bz/1K1w8CD7XaK1WfzyxHxwy3TaLUt8nrFCaPwvqk9XJ/FG8TdnTjZtiL+Oip8o01X
	 7pHs90GBou3BCXaX5p2FeXnitMTKQYcnotFrVQfoz1qHruvXKrIQAiE2434944WG+u
	 5QwhP+6EtJY3s/d9lMRhkmYUlRtivs2HNyBCMoTFGSHbrNg/It4DtYRyCIhXOBDPc2
	 z5zrOZ5jm5yBQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 12/12] crypto: sm3 - Remove 'struct sm3_state'
Date: Fri, 20 Mar 2026 21:09:35 -0700
Message-ID: <20260321040935.410034-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321040935.410034-1-ebiggers@kernel.org>
References: <20260321040935.410034-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22182-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC0532E3394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update one driver that used sizeof(struct sm3_state) to use
sizeof(struct sm3_ctx) instead.  Then, remove struct sm3_state and
SM3_STATE_SIZE.

This completes the replacement of struct sm3_state with struct sm3_ctx.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/crypto/starfive/jh7110-hash.c | 4 ++--
 include/crypto/sm3.h                  | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index 742038a5201a..008a47baa165 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -793,11 +793,11 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 	.base.import   = starfive_hash_import,
 	.base.init_tfm = starfive_sm3_init_tfm,
 	.base.exit_tfm = starfive_hash_exit_tfm,
 	.base.halg = {
 		.digestsize = SM3_DIGEST_SIZE,
-		.statesize  = sizeof(struct sm3_state),
+		.statesize  = sizeof(struct sm3_ctx),
 		.base = {
 			.cra_name		= "sm3",
 			.cra_driver_name	= "sm3-starfive",
 			.cra_priority		= 200,
 			.cra_flags		= CRYPTO_ALG_ASYNC |
@@ -822,11 +822,11 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 	.base.init_tfm = starfive_hmac_sm3_init_tfm,
 	.base.exit_tfm = starfive_hash_exit_tfm,
 	.base.setkey	  = starfive_hash_setkey,
 	.base.halg = {
 		.digestsize = SM3_DIGEST_SIZE,
-		.statesize  = sizeof(struct sm3_state),
+		.statesize  = sizeof(struct sm3_ctx),
 		.base = {
 			.cra_name		= "hmac(sm3)",
 			.cra_driver_name	= "sm3-hmac-starfive",
 			.cra_priority		= 200,
 			.cra_flags		= CRYPTO_ALG_ASYNC |
diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
index 34d7eb32b7db..371e8a661705 100644
--- a/include/crypto/sm3.h
+++ b/include/crypto/sm3.h
@@ -12,27 +12,20 @@
 
 #include <linux/types.h>
 
 #define SM3_DIGEST_SIZE	32
 #define SM3_BLOCK_SIZE	64
-#define SM3_STATE_SIZE	40
 
 #define SM3_IVA		0x7380166f
 #define SM3_IVB		0x4914b2b9
 #define SM3_IVC		0x172442d7
 #define SM3_IVD		0xda8a0600
 #define SM3_IVE		0xa96f30bc
 #define SM3_IVF		0x163138aa
 #define SM3_IVG		0xe38dee4d
 #define SM3_IVH		0xb0fb0e4e
 
-struct sm3_state {
-	u32 state[SM3_DIGEST_SIZE / 4];
-	u64 count;
-	u8 buffer[SM3_BLOCK_SIZE];
-};
-
 /* State for the SM3 compression function */
 struct sm3_block_state {
 	u32 h[SM3_DIGEST_SIZE / 4];
 };
 
-- 
2.53.0


