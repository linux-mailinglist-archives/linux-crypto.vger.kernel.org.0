Return-Path: <linux-crypto+bounces-23212-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EnoCEPK5WlIoAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23212-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:40:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE968427508
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E56613019FCD
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE56388390;
	Mon, 20 Apr 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmeYFYCZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C758388361;
	Mon, 20 Apr 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667026; cv=none; b=tFQTvnHOo7Ac0bJaOrctN0xIKDeiRDh1bV0LACCmlpJ3U+KZyPwxXTOtCNdJGFZRoY1HPhPMusi/GzTB02XbFyeJ6IUXIaxoP6PgEHh3zkK/D6s+PMfV2OO3e7+4nyJhZJP6bJ3YzE6NQloVB1GFrrqpWpj1nFyiYQW7OHibPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667026; c=relaxed/simple;
	bh=KsjL1I/qHqZAMOvNImGVboveH2me9CZFpEy2B+wUoBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+Q2xsyY2YCPG67nAaB3MxEX/WaZO6o6CRRwlkVphTwrMTGWzPgPrBZySy+7yKZexppA3BnL7xBTUEwZmPeWu3ZQ3E86En85rTWQqwBcP0sXavjhaODKknYrkCYRQNI1eC++HdMOJyRUnbQwFFFNdnCQwfjYVH6QcAdI2PCCBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmeYFYCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB669C2BCB8;
	Mon, 20 Apr 2026 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776667026;
	bh=KsjL1I/qHqZAMOvNImGVboveH2me9CZFpEy2B+wUoBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmeYFYCZg65JEytfejrXz4pvbqhdNP0exExTUQ8zraS1Yhr72B3PN/e2FOjDGaRh4
	 otG9Ge9rqSeJTfh8NxZuQcui5kZazEjxV1AjhORZKcYcexpvJ308VT+jpB8ESYsTzM
	 PzG/Ds4n+rYw5w7GNbebiWtZNI99FFS5sUzxwh/W2OJxhgysCjZCPP476msDBcpDNM
	 PajXjs0NsUjrUIdivAwS7vwFACxc5yseJlDS8Qm4XAcXIhxu24XO1AZIPYmGZnwhEv
	 6M9jBUROeLm2yIn4VV5PVk06eL/SFsSN00KaochRtV8ppJNkh/038v8xMhvS8Tfr3M
	 OyQ1ipmciM6+Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 21/38] crypto: drbg - Embed V and C into struct drbg_state
Date: Sun, 19 Apr 2026 23:34:05 -0700
Message-ID: <20260420063422.324906-22-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420063422.324906-1-ebiggers@kernel.org>
References: <20260420063422.324906-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23212-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE968427508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the sizes of V and C are known at compile time, embed them into
struct drbg_state rather than using separate allocations.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/drbg.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 34a7cbdda1f1..e62bde7aab43 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -140,14 +140,12 @@ enum drbg_seed_state {
  */
 #define DRBG_MAX_ADDTL		(U32_MAX - 1)
 
 struct drbg_state {
 	struct mutex drbg_mutex;	/* lock around DRBG */
-	unsigned char *V;	/* internal state -- 10.1.2.1 1a */
-	unsigned char *Vbuf;
-	unsigned char *C;	/* current key -- 10.1.2.1 1b */
-	unsigned char *Cbuf;
+	u8 V[DRBG_STATE_LEN];		/* internal state -- 10.1.2.1 1a */
+	u8 C[DRBG_STATE_LEN];		/* current key -- 10.1.2.1 1b */
 	/* Number of RNG requests since last reseed -- 10.1.2.1 1c */
 	size_t reseed_ctr;
 	size_t reseed_threshold;
 	void *priv_data;	/* Cipher handle */
 
@@ -490,16 +488,12 @@ static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
 /* Free all substructures in a DRBG state without the DRBG state structure */
 static inline void drbg_dealloc_state(struct drbg_state *drbg)
 {
 	if (!drbg)
 		return;
-	kfree_sensitive(drbg->Vbuf);
-	drbg->Vbuf = NULL;
-	drbg->V = NULL;
-	kfree_sensitive(drbg->Cbuf);
-	drbg->Cbuf = NULL;
-	drbg->C = NULL;
+	memzero_explicit(drbg->V, sizeof(drbg->V));
+	memzero_explicit(drbg->C, sizeof(drbg->C));
 	drbg->reseed_ctr = 0;
 	drbg->core = NULL;
 }
 
 /*
@@ -511,28 +505,12 @@ static inline int drbg_alloc_state(struct drbg_state *drbg)
 	int ret = -ENOMEM;
 
 	ret = drbg_init_hash_kernel(drbg);
 	if (ret < 0)
 		goto err;
-
-	drbg->Vbuf = kmalloc(DRBG_STATE_LEN + ret, GFP_KERNEL);
-	if (!drbg->Vbuf) {
-		ret = -ENOMEM;
-		goto fini;
-	}
-	drbg->V = PTR_ALIGN(drbg->Vbuf, ret + 1);
-	drbg->Cbuf = kmalloc(DRBG_STATE_LEN + ret, GFP_KERNEL);
-	if (!drbg->Cbuf) {
-		ret = -ENOMEM;
-		goto fini;
-	}
-	drbg->C = PTR_ALIGN(drbg->Cbuf, ret + 1);
-
 	return 0;
 
-fini:
-	drbg_fini_hash_kernel(drbg);
 err:
 	drbg_dealloc_state(drbg);
 	return ret;
 }
 
-- 
2.53.0


