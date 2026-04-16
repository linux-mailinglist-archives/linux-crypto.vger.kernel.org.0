Return-Path: <linux-crypto+bounces-23037-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO6XE0Om4GlZkgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23037-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 11:05:07 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428140BFA9
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 11:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C0F305959E
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7A395D9B;
	Thu, 16 Apr 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="kLOa3SHH"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3248395DB9
	for <linux-crypto@vger.kernel.org>; Thu, 16 Apr 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330057; cv=none; b=VDtxJAQKlilb3x+nsmUYnELikBErcxpSoL1K/imv0DL1cUOjXAjLehGL4eJQmd13FQturghk+uXKZJfHxllw2l6AYsd9ITlhJckEqpBeI0p7WTpca4A0oNxQ6L4xpdh68QZuYiq1Zs+sygGbf8y3A3DCwmlhEYRGAza8/yWBqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330057; c=relaxed/simple;
	bh=7UpSVZ8xwh8LbFXyUanHXHm8ITIsTuz3BwsR9YEgVQ8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OPOT3eXaFttfcLgS2+qXsKpEedzcUWcyobkZucxIL8TIslTLQANs08VWSrh0HJxQDedYmbXlKwL5ROleeLOYfbQ6y3w+LBnV1grGaPcyO+Lpt/fDmzVb5r26v63Po4VkJLK7os5w4EWiKYuIpRAoYow/sWcXEaKGv8HiUfCijv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=kLOa3SHH; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=G/h5qr8wmZlLsyrNjaSXym8MlhG/oWKnlgIxvo2CI+Y=; b=kLOa3
	SHHQENfndkEEweKNmyrz8VJbL2OM/f6AlJakPdMQ2W9bgNcRZr2teFFVssGkDaxljmXhpb44fGQFF
	vxHzYmSxr+y0N/Wk4z5XL2dkD6Z684QM+gKtS4/ccX9o4111WFibqMgDMYcC5WmWvRWOCwSDQnCzA
	V3e3rmJ9zREw5N3Lk1bxNg2IDN8icjS3GAjPkGyhd8JThiHhQaYW9WOaLotn9gJdZiaiU1Lh2BBoA
	E66xK+rg91Ze/xRoBanUS4WW7WxO3qbaP20Uz+mi6M50wtKbK68NX3zbaV8ohwlregmNjJ3ZYDSbk
	PoFjfa2+OlXrsy6DVavqqPcXa+/Iw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDIag-006V8B-2j;
	Thu, 16 Apr 2026 17:00:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2026 17:00:50 +0800
Date: Thu, 16 Apr 2026 17:00:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	=?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Subject: [PATCH] crypto: pcrypt - Fix handling of MAY_BACKLOG requests
Message-ID: <aeClQtEFPw4ALfTR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-23037-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6428140BFA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MAY_BACKLOG requests can return EBUSY.  Handle them by checking
for that value and filtering out EINPROGRESS notifications.

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Fixes: 5a1436beec57 ("crypto: pcrypt - call the complete function on error")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index c3a9d4f2995c..ed0feaba2383 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -69,6 +69,9 @@ static void pcrypt_aead_done(void *data, int err)
 	struct pcrypt_request *preq = aead_request_ctx(req);
 	struct padata_priv *padata = pcrypt_request_padata(preq);
 
+	if (err == -EINPROGRESS)
+		return;
+
 	padata->info = err;
 
 	padata_do_serial(padata);
@@ -82,7 +85,7 @@ static void pcrypt_aead_enc(struct padata_priv *padata)
 
 	ret = crypto_aead_encrypt(req);
 
-	if (ret == -EINPROGRESS)
+	if (ret == -EINPROGRESS || ret == -EBUSY)
 		return;
 
 	padata->info = ret;
@@ -133,7 +136,7 @@ static void pcrypt_aead_dec(struct padata_priv *padata)
 
 	ret = crypto_aead_decrypt(req);
 
-	if (ret == -EINPROGRESS)
+	if (ret == -EINPROGRESS || ret == -EBUSY)
 		return;
 
 	padata->info = ret;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

