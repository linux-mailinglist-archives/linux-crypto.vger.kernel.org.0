Return-Path: <linux-crypto+bounces-22394-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADn4HoB7xGlXzgQAu9opvQ
	(envelope-from <linux-crypto+bounces-22394-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:19:12 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0332D9BE
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A8430B2729
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212972367D5;
	Thu, 26 Mar 2026 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROKdZrpq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67931A8F84;
	Thu, 26 Mar 2026 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484207; cv=none; b=SH1qAqV+sDOF5z+sMz/Th2ionHc/wGBz6RaHEps5YjlhY25WHWpQUzlDWgR/pwhv9sleMQFnhWwAZZgfjEgCuyYC86t6B/OIXUQ4FwWAp7owGHY130ND+Gh1WC7XoHtQRPSzF8RdrjUUZAu1YZxdXrk9/BSWtWU2AAy8dtjyBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484207; c=relaxed/simple;
	bh=4Swp1cs6iV8ZLXuEHat42F4Z33RaoHb0nQf1lLGDVl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIOb5e64Cd+epIcR0x4Dhwdr1BZnrGuSU8+ynMN1kPQ9E3r8dEDUNC0LAmy2oCFAhRWiRwDab2tqH4Em16MjoU10aV4q0LJCKCBIvDgR85kNbyJQ57esNo884ekYZ5CvjdxapMiatdidasDhFGO8REcmSXt+LnvN59QLvKYZCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROKdZrpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAC2C2BC9E;
	Thu, 26 Mar 2026 00:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774484207;
	bh=4Swp1cs6iV8ZLXuEHat42F4Z33RaoHb0nQf1lLGDVl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROKdZrpqOr/+OP+8wd/4OhKoIB6iExiFz6LfSPxwbp4LF3a49az7nQnBnLYwTk1te
	 a8dcdOeqg6kZ8EiY8Aa5SGXTJ6e8ECiOoOkMar/pcSoKBT9sdMcnHXLvrtn1woNrLh
	 wY0bpL10t86ypmLX3xCiePfDyJ/cb77VQhO4IQWZfKNCc2IJAtAXI5Ec8+TK2rLS06
	 bRVtrOUANEvioF8X75hOJ3tJsR9c71ELEzud5XCe+QyUDV5OIyg1JySm/6Gc0RA9EL
	 v7ng9wX6ZckiAk3mu/bsBvcfgG5kdGS8ZjYbGh/JPEGj8HftFyR1JkWWUT2lOxdG42
	 7GjIFfjdKfAuQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Stephan Mueller <smueller@chronox.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 04/11] crypto: geniv - Use crypto_stdrng_get_bytes()
Date: Wed, 25 Mar 2026 17:15:00 -0700
Message-ID: <20260326001507.66500-5-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22394-lists,linux-crypto=lfdr.de];
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
X-Rspamd-Queue-Id: 1CB0332D9BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the sequence of crypto_get_default_rng(),
crypto_rng_get_bytes(), and crypto_put_default_rng() with the equivalent
helper function crypto_stdrng_get_bytes().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/geniv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/crypto/geniv.c b/crypto/geniv.c
index 42eff6a7387c..c619a5ad2fc1 100644
--- a/crypto/geniv.c
+++ b/crypto/geniv.c
@@ -112,17 +112,11 @@ int aead_init_geniv(struct crypto_aead *aead)
 	struct crypto_aead *child;
 	int err;
 
 	spin_lock_init(&ctx->lock);
 
-	err = crypto_get_default_rng();
-	if (err)
-		goto out;
-
-	err = crypto_rng_get_bytes(crypto_default_rng, ctx->salt,
-				   crypto_aead_ivsize(aead));
-	crypto_put_default_rng();
+	err = crypto_stdrng_get_bytes(ctx->salt, crypto_aead_ivsize(aead));
 	if (err)
 		goto out;
 
 	child = crypto_spawn_aead(aead_instance_ctx(inst));
 	err = PTR_ERR(child);
-- 
2.53.0


