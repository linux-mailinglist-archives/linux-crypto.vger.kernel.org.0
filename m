Return-Path: <linux-crypto+bounces-22392-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJO9MzZ7xGlXzgQAu9opvQ
	(envelope-from <linux-crypto+bounces-22392-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:17:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4632D977
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727AB30675B0
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9B220F38;
	Thu, 26 Mar 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqhazUoT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020F21D3E4;
	Thu, 26 Mar 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484205; cv=none; b=IIuGrv8asW/geH3iPGU/f2JxoLzXkWv1RUmHwLDEY9p8fGNDI2MQv0mrPH31jnK9woS7vBxzLv/gTj2b+thncHVSg358rWTJY/8EBDhCzjEoLmYKDIYsiq4iz+Y3QKrL4PrVzZ3Fs3VdvoYzYGa/FrKNJP+OLYGv/emo6wge2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484205; c=relaxed/simple;
	bh=8RXRQarUEH5v46Pvke7LgdMNRlK7yH/04VpO240qSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLu1AkBDoRLGKofH9OZvb8djA6HqiHqsQMSxX+SIJa+/cY6ueY18T+vpFMiua1jI3Ynzbyeu76hGmJzIOElnhsYDjkimnXe7KEeUU+BRX14ohOZOwznE6KwHpmCDIydRAytU1Za5L6oXGviluGMM22NyJB60YqXFweXtviu1RHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqhazUoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26978C4CEF7;
	Thu, 26 Mar 2026 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774484205;
	bh=8RXRQarUEH5v46Pvke7LgdMNRlK7yH/04VpO240qSdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqhazUoTcDANuwlR0ubP5mgbR77uZCK281aBYKQrHpu1PTu8FdHXW7/83zylTM5dg
	 qv5jfNNJVUGgJgxC24bqFSMV5ejFeWUjltDawJcrgYYaQrMa27zG1WbE4ywFkkVkcF
	 ACWqgxZlKCa76XQhbxz6mMuve9yDq3am4+oNxIl0jeyvSUV13zyf6D45wyMVVeUYjL
	 wf6+zaI01Ab8Duizg0OIPDd+IEB9ORIyLNLplCB3owwyRnSLMG/NYGLaDKYKoBBMOf
	 27q2kmqF4+peqIxAt2b37m4oV5G7ALOOXWdztsb9q6k0BSSIpwZ1RYUD7+fJkDcpeV
	 BMM7EHM3O/cdA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Stephan Mueller <smueller@chronox.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 02/11] crypto: dh - Use crypto_stdrng_get_bytes()
Date: Wed, 25 Mar 2026 17:14:58 -0700
Message-ID: <20260326001507.66500-3-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22392-lists,linux-crypto=lfdr.de];
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
X-Rspamd-Queue-Id: 7DC4632D977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the sequence of crypto_get_default_rng(),
crypto_rng_get_bytes(), and crypto_put_default_rng() with the equivalent
helper function crypto_stdrng_get_bytes().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/dh.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index 8250eeeebd0f..7ad4768716c8 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -386,17 +386,11 @@ static void *dh_safe_prime_gen_privkey(const struct dh_safe_prime *safe_prime,
 
 	/*
 	 * 5.6.1.1.3, step 3 (and implicitly step 4): obtain N + 64
 	 * random bits and interpret them as a big endian integer.
 	 */
-	err = -EFAULT;
-	if (crypto_get_default_rng())
-		goto out_err;
-
-	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)key,
-				   oversampling_size);
-	crypto_put_default_rng();
+	err = crypto_stdrng_get_bytes(key, oversampling_size);
 	if (err)
 		goto out_err;
 
 	/*
 	 * 5.6.1.1.3, step 5 is implicit: 2^N < q and thus,
-- 
2.53.0


