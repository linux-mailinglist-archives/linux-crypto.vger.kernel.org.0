Return-Path: <linux-crypto+bounces-25085-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oTjEC36TKmpMswMAu9opvQ
	(envelope-from <linux-crypto+bounces-25085-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 12:52:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F36710D6
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 12:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=a4fhU6UR;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25085-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25085-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C5883016741
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6601C3D9025;
	Thu, 11 Jun 2026 10:52:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E463D565C;
	Thu, 11 Jun 2026 10:52:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175162; cv=none; b=M3Nxy2m8M2H0zSIcf54G1VUsu2nsVxTceAb6FYyDEaXe4W4JcDzzF2cUB8wYpoZtDvz7frwolDIDIGAzChdpEh8djGJGqT+sn8PHiVphxHdLRe34AXnHLL+Q01s6QPVXDnro/hnybEB643TizzwW10PPedIYnmooxglIHCovDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175162; c=relaxed/simple;
	bh=Qu6LcM2KvLfw0lQYIuHm/kgXovCbBsOqYibtk8bQ6UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxhgi5vjwB8vHOcdrHeqlSCWw3xUoGlD74lLVL1b9RqZWmSh6eyTVngOIGWnlJEeXJz4lUzucnIUnmVqJxD9YEZyJkvNzaSnwl2vucdd1GLnmGe/qR/BFK88+/DxfZVk6ccIYVib3ar4qIbS2IomAXY4FONtYh5YAe7e/Q1ZIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4fhU6UR; arc=none smtp.client-ip=91.218.175.184
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781175157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RmZrjg0Q3ZVv2NrQ57o9v2/owjwm0nO+Z9ZCILQ1szE=;
	b=a4fhU6URE5X9iJd0IpRNzX4jDyp2hwMqr/P4H5KJz1gYz9UxnwiAMr1T0LOT7WHIb2h29o
	ZcuZmudL+2qQVjP/2aL9umjpF5rdHnyig8KFTp21KwzAe703q2JNKKx1hNpOnpaYjK8nda
	xI4/6UGH6L1wSAfpDqCpgr9JVEgUJJo=
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
Subject: [PATCH] crypto: atmel-ecc - drop unused curve id from atmel_ecdh_ctx
Date: Thu, 11 Jun 2026 12:52:01 +0200
Message-ID: <20260611105159.460794-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=thorsten.blum@linux.dev; h=from:subject; bh=Qu6LcM2KvLfw0lQYIuHm/kgXovCbBsOqYibtk8bQ6UA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlak/0vVYav2rf+/sz3bSv0dRK94oLytI+KX/ad+zdMf HJYUFlYRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExkyyFGhkWd050XLVnS0PPq yP6T0/58kVkjcE9T+9elM6f+L5jEqKTJyLBnUz4/m47Fi6rb/j/ll62Z4xOUf9qqs/hI7sa79ar Rk7kB
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25085-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 930F36710D6

->curve_id is only set once, but never used - remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-ecc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 9da9dd6585df..93f219558c2f 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -33,7 +33,6 @@ static struct atmel_ecc_driver_data driver_data;
  * @public_key : generated when calling set_secret(). It's the responsibility
  *               of the user to not call set_secret() while
  *               generate_public_key() or compute_shared_secret() are in flight.
- * @curve_id   : elliptic curve id
  * @do_fallback: true when the device doesn't support the curve or when the user
  *               wants to use its own private key.
  */
@@ -41,7 +40,6 @@ struct atmel_ecdh_ctx {
 	struct i2c_client *client;
 	struct crypto_kpp *fallback;
 	const u8 *public_key;
-	unsigned int curve_id;
 	bool do_fallback;
 };
 
@@ -250,7 +248,6 @@ static int atmel_ecdh_init_tfm(struct crypto_kpp *tfm)
 	struct crypto_kpp *fallback;
 	struct atmel_ecdh_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	ctx->curve_id = ECC_CURVE_NIST_P256;
 	ctx->client = atmel_ecc_i2c_client_alloc();
 	if (IS_ERR(ctx->client)) {
 		pr_err("tfm - i2c_client binding failed\n");

