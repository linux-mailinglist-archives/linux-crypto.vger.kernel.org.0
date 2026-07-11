Return-Path: <linux-crypto+bounces-25843-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hqIBF+tYUmpsOgMAu9opvQ
	(envelope-from <linux-crypto+bounces-25843-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 16:53:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D68741D6A
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 16:53:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ZwLBM+Pr;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25843-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25843-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E5C1300E24F
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443628136F;
	Sat, 11 Jul 2026 14:53:28 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5627A476
	for <linux-crypto@vger.kernel.org>; Sat, 11 Jul 2026 14:53:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783781608; cv=none; b=sGbgshF0DtI5s+NDHAlV3AhX60EdOGxde7xbEo+/Tw155g5lDXLE8RU/ZfNv4ERSjMP4NZKkmwg8VQUUxz4puTGRTTGOVRo3k0gtKEy0V6gM+RmZOZ8Se68L3H0aZqrOzXUlKh+OdXQ8zdztYgLhil5KdFQ0QMlRbg/g3wzfEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783781608; c=relaxed/simple;
	bh=/rlW6l0xR2wdtg1H+Pws5RiWM86Rbb+yDyIqU8+10pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mou3Q4mXzqyrzsg4lP/wX0AVOtx9vaT7Mgiqzlo9bNq5ab1Y6SloWQZYwi5sSTKhaRCSqJqhOmGWkstZinx5aThMuBJkUsesFlMIfonriFPZO2abLnMnIn1thfl2ZpXDRh70YWpNJ2XZEn7LCQuRJwpK4IpvkZUlthw7opZfqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwLBM+Pr; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783781602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aZtHVuRO2nxmJugmNN9a89pfeJYPUJKY7mYAI9yqz4Q=;
	b=ZwLBM+Prxzi72yW7EV+6MvJuM3ROokiTbHd5DIazgdBzC6OV/mhrGAyB15HEwFzWGU39Su
	zCpOt2D18CKk5ETaBKkOhe/IvuhXo1yjwJmuPlBPOIFjT3pzffG167Oso7MiEU9c0eVLm6
	m84wdUt8HVFCPggR/3MyPWnlyH0w+nY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: powerpc/aes - use bool for encryption/decryption flag
Date: Sat, 11 Jul 2026 16:52:17 +0200
Message-ID: <20260711145216.747128-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=thorsten.blum@linux.dev; h=from:subject; bh=/rlW6l0xR2wdtg1H+Pws5RiWM86Rbb+yDyIqU8+10pQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlBEQv+3Pg0ufzyLEXdyVmXBVc942tZweRfeedI+48G6 wbDLXmFHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRB3mMDNuuPgtIcY408L7d 8/5bym73eec1qp4VTr9WM/FGcq2E7R2Gf8oHM88daags1bxrYHsocX64rTknK2fBcpfynQVphl4 NHAA=
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:nayna@linux.ibm.com,m:pfsmorigo@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:thorsten.blum@linux.dev,m:linux-crypto@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[debian.org,linux.ibm.com,gmail.com,gondor.apana.org.au,davemloft.net,ellerman.id.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25843-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70D68741D6A

Use bool for the CBC encryption/decryption flag passed through
p8_aes_cbc_crypt() to aes_p8_cbc_encrypt().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/crypto/aes_cbc.c | 6 +++---
 include/crypto/aes.h          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/aes_cbc.c b/arch/powerpc/crypto/aes_cbc.c
index 4a9f285f0970..9c271b4642c8 100644
--- a/arch/powerpc/crypto/aes_cbc.c
+++ b/arch/powerpc/crypto/aes_cbc.c
@@ -72,7 +72,7 @@ static int p8_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return ret ? -EINVAL : 0;
 }
 
-static int p8_aes_cbc_crypt(struct skcipher_request *req, int enc)
+static int p8_aes_cbc_crypt(struct skcipher_request *req, bool enc)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	const struct p8_aes_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
@@ -110,12 +110,12 @@ static int p8_aes_cbc_crypt(struct skcipher_request *req, int enc)
 
 static int p8_aes_cbc_encrypt(struct skcipher_request *req)
 {
-	return p8_aes_cbc_crypt(req, 1);
+	return p8_aes_cbc_crypt(req, true);
 }
 
 static int p8_aes_cbc_decrypt(struct skcipher_request *req)
 {
-	return p8_aes_cbc_crypt(req, 0);
+	return p8_aes_cbc_crypt(req, false);
 }
 
 struct skcipher_alg p8_aes_cbc_alg = {
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 16fbfd93e2bd..3279cfa54608 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -259,7 +259,7 @@ int aes_p8_set_decrypt_key(const u8 *userKey, const int bits,
 void aes_p8_encrypt(const u8 *in, u8 *out, const struct p8_aes_key *key);
 void aes_p8_decrypt(const u8 *in, u8 *out, const struct p8_aes_key *key);
 void aes_p8_cbc_encrypt(const u8 *in, u8 *out, size_t len,
-			const struct p8_aes_key *key, u8 *iv, const int enc);
+			const struct p8_aes_key *key, u8 *iv, bool enc);
 void aes_p8_ctr32_encrypt_blocks(const u8 *in, u8 *out, size_t len,
 				 const struct p8_aes_key *key, const u8 *iv);
 void aes_p8_xts_encrypt(const u8 *in, u8 *out, size_t len,

