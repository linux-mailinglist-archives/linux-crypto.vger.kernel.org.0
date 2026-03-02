Return-Path: <linux-crypto+bounces-21466-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACOuJG8ipmlQKwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21466-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:51:11 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C6E1E6D7B
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671033070DE2
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F2352C5A;
	Mon,  2 Mar 2026 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezsHrkR7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F794350A22;
	Mon,  2 Mar 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495381; cv=none; b=uf82yIm0HukIoKtrbg/GpBtUMiDRlvMwATkOij9GPtEQMArxtg2aT+qQmId5nk6fUteqqHL6upMJuxDscMxCbAelaAM+EWbXIX6hGo0Scqbwg6MmGPajSfxLwC9+J8JeFExpNZNZ2chsUmvTrW7eQmFF3G+PZC7Jex5aeZbORMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495381; c=relaxed/simple;
	bh=lVckU9fV0K96txaKWynH+hEQtPyhAQIPx0S58PLEBsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL9V4qd9361hgGzrD2YlEM74SNU+OvPvhig4uSDU/49mar8oVcBqdBVp8V1T3BYjwxqECeo2P2mDSRzZbJfy7DCAi/fp+MWA5F80NYNmGlTz4zPMjvshigsmbUIPpdZo4nMXFNV7hlCvTmgNmA/hFfP2awsX7AxDjhImCoU3BGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezsHrkR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BACC19423;
	Mon,  2 Mar 2026 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772495380;
	bh=lVckU9fV0K96txaKWynH+hEQtPyhAQIPx0S58PLEBsw=;
	h=From:To:Cc:Subject:Date:From;
	b=ezsHrkR7SJ5/AB/1JwP0CQxXesQpVctWyV03GlXdVn3VILq3dwQM0k77yJpo/p48V
	 OGxc3IOnzoNWLvMwS4EPMMe04uWPVmt0CwMe/eZVRvyfgr8fqhOUGhD7niJ2vli5TX
	 reSO0kn0Y4H07Wzh2RuUXxtBRGkV8fj4ctcLbsDpoO8n6im06iM26bpAHruhudwDcw
	 MopyUEJ05Bk2F/cyCfBEfmn2K5IbRWa1MIxPVHP/g7xlOq+LqFtSZYRxN8+r5tGnYl
	 AyMMqf7CFwTMo9HI7k4ZfaIP0eEgSWfYxNUrT1H4UvIz0+jUStMyVmKc9MJeZNf32q
	 CLbgP6ZLnsN2g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] crypto: testmgr - Fix stale references to aes-generic
Date: Mon,  2 Mar 2026 15:48:56 -0800
Message-ID: <20260302234856.30569-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5C6E1E6D7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21466-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Action: no action

Due to commit a2484474272e ("crypto: aes - Replace aes-generic with
wrapper around lib"), the "aes-generic" driver name has been replaced
with "aes-lib".  Update a couple testmgr entries that were added
concurrently with this change.

Fixes: a22d48cbe558 ("crypto: testmgr - Add test vectors for authenc(hmac(sha224),cbc(aes))")
Fixes: 030218dedee2 ("crypto: testmgr - Add test vectors for authenc(hmac(sha384),cbc(aes))")
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting libcrypto-fixes for v7.0

 crypto/testmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 49b607f65f636..4985411dedaec 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4130,11 +4130,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
 		.alg = "authenc(hmac(sha224),cbc(aes))",
-		.generic_driver = "authenc(hmac-sha224-lib,cbc(aes-generic))",
+		.generic_driver = "authenc(hmac-sha224-lib,cbc(aes-lib))",
 		.test = alg_test_aead,
 		.suite = {
 			.aead = __VECS(hmac_sha224_aes_cbc_tv_temp)
 		}
 	}, {
@@ -4192,11 +4192,11 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
 		.test = alg_test_null,
 		.fips_allowed = 1,
 	}, {
 		.alg = "authenc(hmac(sha384),cbc(aes))",
-		.generic_driver = "authenc(hmac-sha384-lib,cbc(aes-generic))",
+		.generic_driver = "authenc(hmac-sha384-lib,cbc(aes-lib))",
 		.test = alg_test_aead,
 		.suite = {
 			.aead = __VECS(hmac_sha384_aes_cbc_tv_temp)
 		}
 	}, {

base-commit: f33ac74f9cc1cdadd3921246832b2084a5dec53a
-- 
2.53.0


