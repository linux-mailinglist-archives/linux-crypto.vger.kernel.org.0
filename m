Return-Path: <linux-crypto+bounces-22657-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEHYLPmIy2kuIwYAu9opvQ
	(envelope-from <linux-crypto+bounces-22657-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 10:42:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8F366563
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 10:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E75930C58BF
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001183E4C8C;
	Tue, 31 Mar 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="JbLQ2hd0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9D3E275E
	for <linux-crypto@vger.kernel.org>; Tue, 31 Mar 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946197; cv=none; b=suPHcPWqUlB866qd+y3A+USoAK/b+m+WZpvLs1qAqzkba0J7RUq3oLJ7grdZFKANvCIKsT1eD30TLDMfgLpdfBZx3+MfaHDMBnweKOgShAktdt6lr3C2AV+0O2UVi5yF1TQMbxGgNnhufG+DuEnVNcBClVXANShErWp47sGxCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946197; c=relaxed/simple;
	bh=p3uh2xsZ7/ggtAPjZDSQjECancLCk12CkcKBEIJMr/Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kRO5dsrN71C/HbN/x0ohwQoIxbmTEzkR8s/aaCQw3Ihz1TnVUzYuDmSneiBFYStOsuQp9A63xZ3Dcc6RVqOURm4ptLCCJHS5gffSF6JvTAkJOFdwmb73NLT9Y1qJbzjlVenkVOLHELH+v5LAQQtCRss48szWAYNIN1R1LNTNPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=JbLQ2hd0; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=D313fFut+TgNlq/mMl8Eri9NjLicpzhm3ArldXHiDyM=; b=JbLQ2
	hd0nYO1iU1tX5KMmTtcilvOBEtuUqz7pr6n7NtZDr4+4K6SnRGQPybN4EV1WPgmUtz/SGDmI2JGbo
	OLO2armQN6AFDVBBIfnsMz84QPPLCPlR6eOtgp3bXNgOjA/7v5D7p9fsN7EUeakXEVIXQC9FDTSz/
	vKBBp+3dcIS64ozQrXZwRNPHOatKlfY/XtuTiPIiomDwyZAAaOvXt7aXH5iYfwu3A1dqKiQ+QYE+4
	DB8BPK7u9i7vVsgMxV4LFZSfPkAaXVSK++7s0ZSsK3TPKqov/9+fSld7EtaHYKO6oQt07AP8tEOpT
	71mao8AxNvnHw7TV//oCdjkizAVpw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w7UAs-002ZoR-3C;
	Tue, 31 Mar 2026 16:36:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 31 Mar 2026 17:36:29 +0900
Date: Tue, 31 Mar 2026 17:36:29 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: geniv - Remove unused spinlock from struct
 aead_geniv_ctx
Message-ID: <acuHjfXzPCWEaquc@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-22657-lists,linux-crypto=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_DNSFAIL(0.00)[apana.org.au : query timed out];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_ONE(0.00)[1]
X-Rspamd-Queue-Id: 68F8F366563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The spin lock in geniv hasn't been used in over 10 years.  Remove it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/geniv.c b/crypto/geniv.c
index 42eff6a7387c..de5a954e3e3b 100644
--- a/crypto/geniv.c
+++ b/crypto/geniv.c
@@ -112,8 +112,6 @@ int aead_init_geniv(struct crypto_aead *aead)
 	struct crypto_aead *child;
 	int err;
 
-	spin_lock_init(&ctx->lock);
-
 	err = crypto_get_default_rng();
 	if (err)
 		goto out;
diff --git a/include/crypto/internal/geniv.h b/include/crypto/internal/geniv.h
index 012f5fb22d43..e38d9f0487ec 100644
--- a/include/crypto/internal/geniv.h
+++ b/include/crypto/internal/geniv.h
@@ -9,11 +9,9 @@
 #define _CRYPTO_INTERNAL_GENIV_H
 
 #include <crypto/internal/aead.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 struct aead_geniv_ctx {
-	spinlock_t lock;
 	struct crypto_aead *child;
 	u8 salt[] __attribute__ ((aligned(__alignof__(u32))));
 };
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

