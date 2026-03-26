Return-Path: <linux-crypto+bounces-22398-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD+3DOZ7xGlXzgQAu9opvQ
	(envelope-from <linux-crypto+bounces-22398-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:20:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F232D9CE
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3CD30E8D2D
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 00:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C77B217662;
	Thu, 26 Mar 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAlnVUgN"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BE249E5;
	Thu, 26 Mar 2026 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484213; cv=none; b=VuG0/tCyRnRevhY7YFVAn5g2UTJn+K1UgdHvzK7w1W9t62FYrFW4KWEep6zlAIOVd+bZ0Mp/FxTluGOtYeXdJ1aP9TJ6m858xBl8EHZqPh3tLDf94+M2l5vQNHIkLeLayvrBtFMjHkH/6Cy191KfBYHYJdBk0FaN3oq1W4Di11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484213; c=relaxed/simple;
	bh=tVSbQtwKB+tbe5aaUg9tEfJjGXDQd/Olsy6HwfILhb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qszvrAY7sHt7OZgbOn/i9hplL0TUgZSOkEY7RY2xzqCUzr7LzI9vqsCsg8jCjGLEBCAlMp/Ma2MytT5EyG2mvwFLDqMc/yco6ahn4sfHNXSKugdUR0zDIxqg38pb3iYmoZhAZZoGIL1ZdWrN1n7B9L0e4ubwjtcDd0QUjuobBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAlnVUgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DC5C4CEF7;
	Thu, 26 Mar 2026 00:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774484211;
	bh=tVSbQtwKB+tbe5aaUg9tEfJjGXDQd/Olsy6HwfILhb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAlnVUgNHYFqC7MwgFg6MoDvQd6ASPmUWbP8ZR1e3ha+GNQu1mkyyeHoO7/ex1XMp
	 P104PR0o8zYCVbBLOPrPt7yxdbxik69x9B9KnQUPMjZ7rjc7eb1wEmOIX5bIyGoO//
	 hVRt4bfuou/UH/j1E3ID8FmxprtdS7KiBzp8EnUbSnE5LRKX1vhQ9h/SsHCgTEw+1O
	 0JLEBPTbshbOZf1RgwjMpGLbmXUL/j4os7UnUOy336UM7auzl47qE2NpneikkwfM9W
	 T5zWyLK1wRwHeVRnGw6RmI8LxWT1+fH9xeTm1DXMDX0Gyi47RPczBBMPFIZrvX+uik
	 o5CNOwEYmjldQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Stephan Mueller <smueller@chronox.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 07/11] net: tipc: Use crypto_stdrng_get_bytes()
Date: Wed, 25 Mar 2026 17:15:03 -0700
Message-ID: <20260326001507.66500-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326001507.66500-1-ebiggers@kernel.org>
References: <20260326001507.66500-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22398-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 905F232D9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the sequence of crypto_get_default_rng(),
crypto_rng_get_bytes(), and crypto_put_default_rng() with the equivalent
helper function crypto_stdrng_get_bytes().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/tipc/crypto.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index d3046a39ff72..6d3b6b89b1d1 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -365,21 +365,12 @@ int tipc_aead_key_validate(struct tipc_aead_key *ukey, struct genl_info *info)
  *
  * Return: 0 in case of success, otherwise < 0
  */
 static int tipc_aead_key_generate(struct tipc_aead_key *skey)
 {
-	int rc = 0;
-
-	/* Fill the key's content with a random value via RNG cipher */
-	rc = crypto_get_default_rng();
-	if (likely(!rc)) {
-		rc = crypto_rng_get_bytes(crypto_default_rng, skey->key,
-					  skey->keylen);
-		crypto_put_default_rng();
-	}
-
-	return rc;
+	/* Fill the key's content with a random value via stdrng */
+	return crypto_stdrng_get_bytes(skey->key, skey->keylen);
 }
 
 static struct tipc_aead *tipc_aead_get(struct tipc_aead __rcu *aead)
 {
 	struct tipc_aead *tmp;
-- 
2.53.0


