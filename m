Return-Path: <linux-crypto+bounces-21645-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLmMI88dqmlLLgEAu9opvQ
	(envelope-from <linux-crypto+bounces-21645-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 01:20:31 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D616D219BD6
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 01:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93DF3020D62
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2026 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9629C351;
	Fri,  6 Mar 2026 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THSO5Q3g"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0776190473;
	Fri,  6 Mar 2026 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756426; cv=none; b=mZWgCTGxJuWPhRMucXUxeMmW+5sxNOl1J0BEdvh1SJ0JeK/x3DGlwBdOD5+Z+rW0ZkI7fRK3DcQV5AokndbvsmH2ZFaqZDQyCl/uJrtYLcCCDsjetHu0n5wdFybLiUMC5Ls+K/3gh7I1WaR4JYX4KGr2XHnBVbqYFFM8VGbTeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756426; c=relaxed/simple;
	bh=2m9nF0p0OdbUjR6hTYp5NFma5L+MqoxNyXQslnug9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpnUtuYcrBY3ozecCSUe+jUOpyU1ut7oxipumdshFFV3KdcVyYQigcgw39so2+F2TgFFhse+ZqIJYtIfASKEHYx+cf/XSTh3wn8XuPIGohrXmE8tbFNSrSiKj/oeNxbOEz0/QzExmf243QLc3n5H/KGzz9h2BbZI6KeaSCJ8c0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THSO5Q3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5F4C116C6;
	Fri,  6 Mar 2026 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772756425;
	bh=2m9nF0p0OdbUjR6hTYp5NFma5L+MqoxNyXQslnug9Fc=;
	h=From:To:Cc:Subject:Date:From;
	b=THSO5Q3gO+MhZrcgPJB4/Y/csZjJ01vCahW2vteLlFrdA0phpOd3BrxDtVERFaHZJ
	 ibQyZCSEcFfjAkCt1LGZOFMAtqbJu0GaZkISKolot8EMMlF4TxtIUW2WtJ4s5wieya
	 jfQZCRjUUw9FbZvtw6Npzy17LTwkqwXjTBGsEvd2qya/6EXSmjfLVcrxie/4MW4QdL
	 L0gUBDogghcSwuZciit5qb0NceFMj05CnKf1gNY0Cn4+MMjzZ6c5w6w4yTDIgN2nMv
	 Q/MujS+pJZ6kGWfZ4LpMKU931HNo5uUc2IXbeZFJCMiEnnWkxZbGCf8J2iwflzkgiB
	 l7D8eujcvtLYQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/crypto: tests: Fix aes_cbc_macs dependency and add to kunitconfig
Date: Thu,  5 Mar 2026 16:19:17 -0800
Message-ID: <20260306001917.24105-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D616D219BD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21645-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Update the dependency of CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST to match the
new convention established by commit 4478e8eeb871 ("lib/crypto: tests:
Depend on library options rather than selecting them"), and add this
test to the kunitconfig file added by commit 20d6f07004d6 ("lib/crypto:
tests: Add a .kunitconfig file").

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This is targeting libcrypto-next.  This patch is needed because the
aes_cbc_macs test is queued for 7.1 and wasn't handled by the commits
mentioned above which were merged into 7.0.
 
 lib/crypto/.kunitconfig  | 3 +++
 lib/crypto/tests/Kconfig | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/crypto/.kunitconfig b/lib/crypto/.kunitconfig
index 6b2ce28ae509..8cfd213bded9 100644
--- a/lib/crypto/.kunitconfig
+++ b/lib/crypto/.kunitconfig
@@ -3,12 +3,14 @@ CONFIG_KUNIT=y
 # These kconfig options select all the CONFIG_CRYPTO_LIB_* symbols that have a
 # corresponding KUnit test.  Those symbols cannot be directly enabled here,
 # since they are hidden symbols.
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ADIANTUM=y
+CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_BLAKE2B=y
 CONFIG_CRYPTO_CHACHA20POLY1305=y
+CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_HCTR2=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MLDSA=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
@@ -18,10 +20,11 @@ CONFIG_INET=y
 CONFIG_IPV6=y
 CONFIG_NET=y
 CONFIG_NETDEVICES=y
 CONFIG_WIREGUARD=y
 
+CONFIG_CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_BLAKE2B_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_BLAKE2S_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_CURVE25519_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_MD5_KUNIT_TEST=y
 CONFIG_CRYPTO_LIB_MLDSA_KUNIT_TEST=y
diff --git a/lib/crypto/tests/Kconfig b/lib/crypto/tests/Kconfig
index f6b842cad97e..0d71de3da15d 100644
--- a/lib/crypto/tests/Kconfig
+++ b/lib/crypto/tests/Kconfig
@@ -1,13 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 config CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST
 	tristate "KUnit tests for AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && CRYPTO_LIB_AES_CBC_MACS
 	default KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
 	select CRYPTO_LIB_BENCHMARK_VISIBLE
-	select CRYPTO_LIB_AES_CBC_MACS
 	help
 	  KUnit tests for the AES-CMAC, AES-XCBC-MAC, and AES-CBC-MAC message
 	  authentication codes.
 
 config CRYPTO_LIB_BLAKE2B_KUNIT_TEST

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

