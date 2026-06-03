Return-Path: <linux-crypto+bounces-24869-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ktZZNyGBIGrI4QAAu9opvQ
	(envelope-from <linux-crypto+bounces-24869-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 03 Jun 2026 21:31:45 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4118763ADF3
	for <lists+linux-crypto@lfdr.de>; Wed, 03 Jun 2026 21:31:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="ZNBV4wI/";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24869-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24869-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB5A30590B0
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jun 2026 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0B39E176;
	Wed,  3 Jun 2026 19:27:44 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C33822AA
	for <linux-crypto@vger.kernel.org>; Wed,  3 Jun 2026 19:27:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514863; cv=none; b=H2YVFS9e+0oJ2DV1gO9BatrwJNcDkrG2gMtcMBK0DUyTnDOrB4qbLt5b8Kt6O4mNvjgTHIYQM8+/nyPNjo5v7Ge5RN98Bc+FL523UUCeWJbG0LbcUDdmBfxopKWD6W9UtSX7Gils3H1nRhuo1gyAgVGX+T+0J4LGF/AFmxIBfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514863; c=relaxed/simple;
	bh=9q6DUpING7t7Xrmg5p0Sx2PWzYhZ78AwiWV6omFLEIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJkBPks07ns0ZJP+iqzklE72J2s+FB4BHefqbdmiMWzmmJpXQVO/c/7x7g3kWhed9gWL2sh5N89SIcf+TJYpM87h8UBPPBVZGmv2mp0pWEIt77i9o3S2QSjbU22MKvHH+NGdjoVS505vMEcY40eyMFneEpf0aEP5CIEC08iEz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZNBV4wI/; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780514859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LCd2JZE6WNougagJTMnn2kq3grK0eduAPPd4c0q8mnM=;
	b=ZNBV4wI/e5TtPidtua9p5pkIHm9dbpT5EAzjHPDw/cDFHNao5DM/cdCHTkydtcLmoJBhlH
	lJT1Vc/bcgxnOuVJyT4YD3Fx0RdINiuzcpK19ieudZi+qGcixAMiC7Q/W23hPUtnybRGu1
	QSYRD6pCM1T6mKDJlGSGYOQMJT2PPM4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: atmel-i2c - improve comment in atmel_i2c_init_ecdh_cmd
Date: Wed,  3 Jun 2026 21:27:10 +0200
Message-ID: <20260603192708.1237715-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=thorsten.blum@linux.dev; h=from:subject; bh=9q6DUpING7t7Xrmg5p0Sx2PWzYhZ78AwiWV6omFLEIE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkKDTwqn85/MRHMvPMxe6Hh79kB1yU3HhMNfehYtU1Pb dOJmHPXO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi7GEM/6xnf5Xxz88V9JNq uSGr/GJr1ZqjPx+IXnsgfsh40upZblmMDP1zeu/uyLLcl8n0Pfdg6l3V2wI8Ti0WuwzNDhzz99l izg8A
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24869-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:thorsten.blum@linux.dev,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4118763ADF3

Clarify that a P-256 public key is encoded as two 32-byte coordinates.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index ff19857894d0..24bded47a32b 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -138,9 +138,8 @@ int atmel_i2c_init_ecdh_cmd(struct atmel_i2c_cmd *cmd,
 	cmd->param2 = cpu_to_le16(DATA_SLOT_2);
 
 	/*
-	 * The device only supports NIST P256 ECC keys. The public key size will
-	 * always be the same. Use a macro for the key size to avoid unnecessary
-	 * computations.
+	 * The device only supports P-256. Its public key is encoded as
+	 * two 32-byte coordinates.
 	 */
 	copied = sg_copy_to_buffer(pubkey,
 				   sg_nents_for_len(pubkey,

