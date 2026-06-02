Return-Path: <linux-crypto+bounces-24850-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id atK+GPdZH2q8kwAAu9opvQ
	(envelope-from <linux-crypto+bounces-24850-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 03 Jun 2026 00:32:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F7632746
	for <lists+linux-crypto@lfdr.de>; Wed, 03 Jun 2026 00:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=OgtWM0zv;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24850-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24850-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D0B312ECD9
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E263BFE31;
	Tue,  2 Jun 2026 22:26:27 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FC3B9D95
	for <linux-crypto@vger.kernel.org>; Tue,  2 Jun 2026 22:26:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439187; cv=none; b=k7loW2hjnIKOqYcOfgodcekFr9Ka58SK4m0XCX0AoSng2yK1kEjHUBF72zDRIWWVVgMg4cLy5U7ulBn1c7qAdEhYV2/mc71idbZ+gmWxk4qiCNiB9YNqg4f9aRpRibe6MRO9bEy/4FG6y7nDJXZcBleMc0EGGH+2sn2T3iP1xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439187; c=relaxed/simple;
	bh=GHxDkgIiIX6c6vtHT0FV/dwHUgNRsmaaQ7EjOBafrV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/4FauARIYxR1WsPseewO8hx0CfXXVk+vlSoOUfVrNDiEU88UHkIajwmYWPpBNJb8wApGkzh4vU3CkkYf81gxtI3cTcblc+HW86yv8Nkw2wV9H2uOweGIlY+vne4GGj0/kHdbGeaQUaqB2ahtu7LcXWgRnaS5lUBuNhrr0iee2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OgtWM0zv; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780439173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sFhdpRv9iR7Qc8J7Cw//4CHayJHFtnc2pfvbLSWkvUY=;
	b=OgtWM0zvkiDPhp8fyZHlDO02xUt8hzA9wHXqs+QH5bqDQ7zRmljlsuoRQ9N8STnpgf1B76
	Z9twu5MNXJBxF9EVzqWJed6G4561e3IPelvLpKakvVxLAcDIpCyBIUuVSpTKOBICZXpaKk
	kCx2UidvHC79lpsQdDXqp4t79UPeTfk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-ecc - drop dead code in atmel_ecdh_max_size
Date: Wed,  3 Jun 2026 00:25:19 +0200
Message-ID: <20260602222517.1071850-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=thorsten.blum@linux.dev; h=from:subject; bh=GHxDkgIiIX6c6vtHT0FV/dwHUgNRsmaaQ7EjOBafrV8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnyEb6Teu69zq+5KL7i9fmNljwS5kZ9jHMuv66bFrH8z 9fll05t7ihlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJXHrE8N8vKvr4osBQuzwL 2zaR9nNZ758LcbC+fnRSNSitI57L24/hf1GN4HNv8dT1Nwt11yXus7lj6RPk6/hkGksr12SzDgY LNgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24850-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A45F7632746

atmel_ecdh_init_tfm() always allocates ctx->fallback, so it is never
NULL in atmel_ecdh_max_size(). Remove the dead code and return
crypto_kpp_maxsize() directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-ecc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 9c380351d2f9..6a1716175b30 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -284,15 +284,7 @@ static unsigned int atmel_ecdh_max_size(struct crypto_kpp *tfm)
 {
 	struct atmel_ecdh_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	if (ctx->fallback)
-		return crypto_kpp_maxsize(ctx->fallback);
-
-	/*
-	 * The device only supports NIST P256 ECC keys. The public key size will
-	 * always be the same. Use a macro for the key size to avoid unnecessary
-	 * computations.
-	 */
-	return ATMEL_ECC_PUBKEY_SIZE;
+	return crypto_kpp_maxsize(ctx->fallback);
 }
 
 static struct kpp_alg atmel_ecdh_nist_p256 = {

