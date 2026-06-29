Return-Path: <linux-crypto+bounces-25449-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RUAmLFDmQWoTvwkAu9opvQ
	(envelope-from <linux-crypto+bounces-25449-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 05:28:16 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8A6D5AAD
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 05:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fel4PdcU;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25449-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25449-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 045D730028C2
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000837E307;
	Mon, 29 Jun 2026 03:28:10 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B737DEA2;
	Mon, 29 Jun 2026 03:28:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703689; cv=none; b=pUtbXnutX/6xqWp5Gv/YyS8cf8GqKJvqyATds02i25959vPpXmc0dUvNFc0eUUVsRyKKvg/ZOOpygHLWvFUiGfG6jAOW3fypk1HGLh5kTi4i1JqEbHNzKy7mVIcNzd6NY42h0nThvRipGR5iI6/R/OjcjFaxxsrA7kLVVjouq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703689; c=relaxed/simple;
	bh=5zB+je9lQ1tGhP/t9lxIm32J2PwQwLZjjKw3m4AhsNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huAfdmVJeofwz1d1vTnSK1b9Oh5j2UXSOVdsDJ5tKtWASLwxS1GiaX9fYg8a3blowXxS6aMvlAmaApiz4UuCeIivWf50Ly5mBjGFue2Gnv3Qhavd3by5+t+FOnrEeYdcEezUs9tqxHDpSZqIsNHZJZNHIAijWkTwM4Utq7luGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fel4PdcU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606DF1F000E9;
	Mon, 29 Jun 2026 03:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782703688;
	bh=mkQir9JSn28EgBSoiIxqaa+E1e9/QhLgZWWbRzFEI40=;
	h=From:To:Cc:Subject:Date;
	b=fel4PdcUBmKsNQfQOR432qllH/glRENtfKDE42oAsEdWruCcIBehU+7534/UMHe7c
	 EIyDpsgEyA423oCJxkeoN1hOeFwvz7caKfPC0vxzd5pwtL2GpBO35jMml/WvA6V3lf
	 SRcDEaKz0JY2+hD0H/aVEbsdQQX8EY8htPIswqLO/z7xOqMVgHe15YytNi3ZBwmoZa
	 ELOmL9yLjLRnd04xlsQcDHpYjo1tKsW2t3j5JZqlu6VSg01Q+65vEuCtO4bnhuce6A
	 9PZL4KaC+2aXxEU4p3UuvhjKZ2vKnFy+sGfU7yDLaIa0JqxhIPdvKaglMTFcc5ejuv
	 z8S/vGPhl0SCw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/crypto: md5: Remove support for md5_mod_init_arch()
Date: Sun, 28 Jun 2026 20:25:52 -0700
Message-ID: <20260629032552.26100-1-ebiggers@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25449-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA8A6D5AAD

No definitions of md5_mod_init_arch() remain, so remove the code that
handles it.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/md5.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/crypto/md5.c b/lib/crypto/md5.c
index 6bf130cfbbf9..3d2b017a0525 100644
--- a/lib/crypto/md5.c
+++ b/lib/crypto/md5.c
@@ -298,19 +298,5 @@ void hmac_md5_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_md5_usingrawkey);
 
-#ifdef md5_mod_init_arch
-static int __init md5_mod_init(void)
-{
-	md5_mod_init_arch();
-	return 0;
-}
-subsys_initcall(md5_mod_init);
-
-static void __exit md5_mod_exit(void)
-{
-}
-module_exit(md5_mod_exit);
-#endif
-
 MODULE_DESCRIPTION("MD5 and HMAC-MD5 library functions");
 MODULE_LICENSE("GPL");

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0


