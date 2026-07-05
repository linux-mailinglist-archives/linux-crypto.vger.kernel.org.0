Return-Path: <linux-crypto+bounces-25612-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S3oHCUCmSmoHFgEAu9opvQ
	(envelope-from <linux-crypto+bounces-25612-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 20:45:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAA70AD0E
	for <lists+linux-crypto@lfdr.de>; Sun, 05 Jul 2026 20:45:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QGhKtPfQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25612-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25612-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27D53008D4B
	for <lists+linux-crypto@lfdr.de>; Sun,  5 Jul 2026 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F63305668;
	Sun,  5 Jul 2026 18:45:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A963A0E8A;
	Sun,  5 Jul 2026 18:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783277114; cv=none; b=Ysd0/l2EPNrebW3daQB4BWtlMZMl1980jI07cb7IaTAcIRuBNW9pzZweKDy/l4muZqJK+29+Fuwa3GVI285eAW0F7ECab/rSn9QPzyf6YI3p8uXmwjiXT/VsVsTqmO34ItpZiQy9kfgkzom5B7RyU6OQ6P1LBiCRpZq04HYwddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783277114; c=relaxed/simple;
	bh=ckK9Io4PQP7xx+wwIpTDQUvg2fC/RfSrE74uP/cZ448=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBErou9CTKWxuFTaUpKmckgOYP/SzGDCPQRPyJWMTjAsFOR8QXDlxhdPF4n1978xjRcQAXypYl3sjocyeihaCuhpkWDbqWCX88mGT6M5BPhcHBEopx/8/uxB1vJNxdnK8yNE3jbkIV6LlRm7eLLs+S8qzRK5iLr39yuEz2h2hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGhKtPfQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34F31F000E9;
	Sun,  5 Jul 2026 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783277112;
	bh=1sqCgdU8FpXHHIhLwWAj/joTSTKHhMSYmEG40tv2+HY=;
	h=From:To:Cc:Subject:Date;
	b=QGhKtPfQf+fpXOULwG9IywhQHWWA/+oRLjXB9uGJ2cNWIvFveUPIg3KUGB54TMKwt
	 JL+0MKkUcPWbHALFLhY+EwaqtY/0px0p/dfMKpQ23F+/W7h9evqv40XJ8e9IiZ7hTU
	 5LmIEb05a9sXxEuBQIZPmIQ2wYuEWRaFTs7o/3Maf1IRgVA2a8ICrN4vj9Rmix8d4z
	 DC/AevS6+6LlRtNmMVATawVpNFgzQdd9427Nw/NqXkE6HAMU/cdDQ+QNEsLOvRsJUy
	 4aEBmp8cLVJ1pNrKKYz87NLbpU66djvJI6EmNy74Yt2cdd2Zt+3+TmjUAF0yuGiRFz
	 7W5yoN2JnI8Kw==
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Milan Broz <gmazyland@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] crypto: af_alg - Allow additional ciphers for cryptsetup
Date: Sun,  5 Jul 2026 11:44:19 -0700
Message-ID: <20260705184419.40762-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25612-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,m:ebiggers@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91CAA70AD0E

Add "xts(camellia)", "xts(serpent)", and "xts(twofish)" to the allowlist
for af_alg_restrict=1.  These niche AES alternatives have continued to
see rare but persistent use via cryptsetup, which has historically
relied on the AF_ALG support for these ciphers in XTS mode for
performing the keyslot encryption.  (cryptsetup v2.8.7 and later fall
back to a temporary dm-crypt mapping, but that requires root.)

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/algif_skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 2b8069667974..49ae779b3b6b 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -45,6 +45,9 @@ static const struct af_alg_allowlist_entry skcipher_allowlist[] = {
 	{ "ecb(des)", true }, /* iwd */
 	{ "hctr2(aes)", false }, /* cryptsetup */
 	{ "xts(aes)", false }, /* cryptsetup benchmark */
+	{ "xts(camellia)", false }, /* cryptsetup */
+	{ "xts(serpent)", false }, /* cryptsetup */
+	{ "xts(twofish)", false }, /* cryptsetup */
 	{},
 };
 

base-commit: e264401ce4776a288524e5b87593d4d864147115
-- 
2.54.0


