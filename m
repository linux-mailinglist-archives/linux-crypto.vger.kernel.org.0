Return-Path: <linux-crypto+bounces-23226-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKGwNdHK5WlIoAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23226-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:42:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8164275B7
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 776223021FEF
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292E393DDD;
	Mon, 20 Apr 2026 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCkD/UtS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDA383C62;
	Mon, 20 Apr 2026 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667030; cv=none; b=HPpXRWB+ClhqJacODujaKEY1+oSSew5AWTAAi3o8rZioVMDH7zOqR+SWk1FLIr4JlzKjMF5PFrlt5z1XW/jnnfBK8umaRzqUnW6KXOALG/LpVSe5bpZ7QtC6EDW2JCSSul7QIkZ0+WTdCcDXIBHEMjS99gU/rDyW4l/oNh5H300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667030; c=relaxed/simple;
	bh=hhVZHB54EAzb33a4/K2DaLRDeb7WDZ8eAJvBP+pq290=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBISTSlyLNybkbwYT5ApPBxBz6+4+n4QAPKwncVuEjhO2vVC3Mfl8hG3bmSfXZFVB0ECKWd+HSzgtjfpSkcUe4TneLPKNQ8sByKXvkoPy4RIq7y1NYWl7wqobppyZ4UU5r4ln+JHEqatcku+NLGo9L0xmqojne5WNMLvqILz7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCkD/UtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD8C2BCB9;
	Mon, 20 Apr 2026 06:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776667030;
	bh=hhVZHB54EAzb33a4/K2DaLRDeb7WDZ8eAJvBP+pq290=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCkD/UtSd35op6jgApu0vNvyNMyUqUnA7mKYoi5YSA2rUh7Mrr+ylCOYchthy4gKq
	 NbZZ5PGIVIuI8zUrFmUGB0EtludpRL7C40bR/x0qIPyy6s4lmDwXUYqQ+hezOSyxOy
	 KQyFITtRK5msBXnOnxsCGXUx6pSe48da5kbmJTXg+6EDpZ3M1DWpS+vIv5ZS63sWCd
	 iIi8vlztinpSIXQKwXurpL8vQ+iIF8zNn48TgKRINUFIcOmCRgMYS9FgWFrAWP6cBa
	 6iqMwmpMPVaGGrHTe9Y7gvxOinFedvUdRm6KtiYOhEy8pX/v7g4WrUEcY9swICHCF/
	 S2A1Bvbe6lrwg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 35/38] crypto: drbg - Change DRBG_MAX_REQUESTS to 4096
Date: Sun, 19 Apr 2026 23:34:19 -0700
Message-ID: <20260420063422.324906-36-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23226-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C8164275B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently a formal reseed happens only after each 1048576 requests.

That's quite a high number.  Let's follow the example of BoringSSL and
use a more conservative value of 4096.

Note that in practice this makes little difference, now that we're
including 32 bytes from get_random_bytes() in the additional input on
every request anyway, which is a de facto reseed.

But for the same reason, we might as well decrease the actual reseed
interval to something more reasonable.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/drbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index cda79d601f4f..7fd076ddc105 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -113,11 +113,11 @@ enum drbg_seed_state {
 
 /*
  * Maximum number of requests before reseeding is forced.
  * SP800-90A allows this to be up to 2**48.  We use a lower value.
  */
-#define DRBG_MAX_REQUESTS	(1 << 20)
+#define DRBG_MAX_REQUESTS	4096
 
 /*
  * Maximum number of random bytes that can be requested at once.
  * SP800-90A allows up to 2**19 bits, which is 2**16 bytes.
  */
-- 
2.53.0


