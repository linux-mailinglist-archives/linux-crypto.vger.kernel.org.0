Return-Path: <linux-crypto+bounces-22370-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHUuOVMYw2lCoAQAu9opvQ
	(envelope-from <linux-crypto+bounces-22370-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2026 00:03:47 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37231D9BF
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2026 00:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198D530315FA
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C793C7DF4;
	Tue, 24 Mar 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe/f0km6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B5363C61;
	Tue, 24 Mar 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393376; cv=none; b=a4JOMP3VwccK56MBBpeLoizi48cDarrBrtPTt2EXqJF2XFNCIcNhf0f4Q+2qWfR70neuFjfiGVTV6XDHQYixOrFin4Bkocf2CJE9ddGdyh6byoS5KSZPD66rbKCcvvaqNeBTg+3e5+b0pMsKVr7tzAGJtYgIbrOAsYRZCV66HtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393376; c=relaxed/simple;
	bh=+58EzvEC3WDsbuUjiUwWIAb/WaFwd7wIySaVJIWAExk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APqa9Jpu7PgQyadqLcenTIKa3IrQ+VIdImmt0888bzgwvsRFWOWXk5wT6w9tbqVstD6ZkOWTyNccfQ5Ix1U1oaJBPQMLlpQsKjPTgcFM4H4NXWNOexK2vGYrS2DcdWiX4xOZhHv1xLPeusLU60fhl1TLqIFdFSeatoXXaFW9LJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe/f0km6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97BAC19424;
	Tue, 24 Mar 2026 23:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393376;
	bh=+58EzvEC3WDsbuUjiUwWIAb/WaFwd7wIySaVJIWAExk=;
	h=From:To:Cc:Subject:Date:From;
	b=qe/f0km6xd5b5tC5SDlxlJ+OBGOLLRBOAGyqWhKwBkamBKSl/Vlxn4hKPgH2P3o2A
	 6e4l5KRtRz87MtM6UZFEbGM/ZqcZ/V/1Dk3ydgokzhobhSGOdQaLZCyBEXRGE0Y9yx
	 /vddVJm3lTNGNpl9qzyGv7qAPOJgejfxtux+6JdS2mkzRr0dmKTEmH5kMuRwgC7ERa
	 IPE/9A1uv5P909doORDiNRKpYtZVKH48FHjzeIA+39I8DS7szlJ/kBaZfOHtuJa6J/
	 k2WvEZ85i0FJ2dAb4hLZiPatDYsbeXH3T3TnvL0kHG8zZpfChayp1csRyjzkV806Ej
	 JGhtFXGAEIdrg==
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3] crypto: cryptomgr - Select algorithm types only when CRYPTO_SELFTESTS
Date: Tue, 24 Mar 2026 16:02:20 -0700
Message-ID: <20260324230220.5457-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22370-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A37231D9BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enabling any template selects CRYPTO_MANAGER, which causes
CRYPTO_MANAGER2 to enable itself, which selects every algorithm type
option.  However, pulling in all algorithm types is needed only when the
self-tests are enabled.  So condition the selections accordingly.

To make this possible, also add the missing selections to various
symbols that were relying on transitive selections via CRYPTO_MANAGER.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting cryptodev/master

v3: addressed more transitive selections
v2: add selections to options that were relying on transitive selection

 crypto/Kconfig                   | 26 ++++++++++++++++++--------
 drivers/crypto/Kconfig           |  1 +
 drivers/crypto/allwinner/Kconfig |  2 ++
 drivers/crypto/intel/qat/Kconfig |  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e2b4106ac961..209a040c74bf 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -155,18 +155,18 @@ config CRYPTO_MANAGER
 	  This provides the support for instantiating templates such as
 	  cbc(aes), and the support for the crypto self-tests.
 
 config CRYPTO_MANAGER2
 	def_tristate CRYPTO_MANAGER || (CRYPTO_MANAGER!=n && CRYPTO_ALGAPI=y)
-	select CRYPTO_ACOMP2
-	select CRYPTO_AEAD2
-	select CRYPTO_AKCIPHER2
-	select CRYPTO_SIG2
-	select CRYPTO_HASH2
-	select CRYPTO_KPP2
-	select CRYPTO_RNG2
-	select CRYPTO_SKCIPHER2
+	select CRYPTO_ACOMP2 if CRYPTO_SELFTESTS
+	select CRYPTO_AEAD2 if CRYPTO_SELFTESTS
+	select CRYPTO_AKCIPHER2 if CRYPTO_SELFTESTS
+	select CRYPTO_SIG2 if CRYPTO_SELFTESTS
+	select CRYPTO_HASH2 if CRYPTO_SELFTESTS
+	select CRYPTO_KPP2 if CRYPTO_SELFTESTS
+	select CRYPTO_RNG2 if CRYPTO_SELFTESTS
+	select CRYPTO_SKCIPHER2 if CRYPTO_SELFTESTS
 
 config CRYPTO_USER
 	tristate "Userspace cryptographic algorithm configuration"
 	depends on NET
 	select CRYPTO_MANAGER
@@ -222,10 +222,11 @@ config CRYPTO_PCRYPT
 	  This converts an arbitrary crypto algorithm into a parallel
 	  algorithm that executes in kernel threads.
 
 config CRYPTO_CRYPTD
 	tristate "Software async crypto daemon"
+	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
 	  This is a generic software asynchronous crypto daemon that
@@ -255,24 +256,33 @@ config CRYPTO_KRB5ENC
 	  sunrpc/NFS and rxrpc/AFS.
 
 config CRYPTO_BENCHMARK
 	tristate "Crypto benchmarking module"
 	depends on m || EXPERT
+	select CRYPTO_AEAD
+	select CRYPTO_HASH
 	select CRYPTO_MANAGER
+	select CRYPTO_SKCIPHER
 	help
 	  Quick & dirty crypto benchmarking module.
 
 	  This is mainly intended for use by people developing cryptographic
 	  algorithms in the kernel.  It should not be enabled in production
 	  kernels.
 
 config CRYPTO_SIMD
 	tristate
+	select CRYPTO_AEAD
 	select CRYPTO_CRYPTD
 
 config CRYPTO_ENGINE
 	tristate
+	select CRYPTO_AEAD
+	select CRYPTO_AKCIPHER
+	select CRYPTO_HASH
+	select CRYPTO_KPP
+	select CRYPTO_SKCIPHER
 
 endmenu
 
 menu "Public-key cryptography"
 
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 8d3b5d2890f8..3c52e7a1df2b 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -299,10 +299,11 @@ config CRYPTO_DEV_PPC4XX
 	select CRYPTO_AES
 	select CRYPTO_LIB_AES
 	select CRYPTO_CCM
 	select CRYPTO_CTR
 	select CRYPTO_GCM
+	select CRYPTO_RNG
 	select CRYPTO_SKCIPHER
 	help
 	  This option allows you to have support for AMCC crypto acceleration.
 
 config HW_RANDOM_PPC4XX
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index b8e75210a0e3..7270e5fbc573 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -12,10 +12,11 @@ config CRYPTO_DEV_SUN4I_SS
 	depends on CRYPTO_DEV_ALLWINNER
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_AES
 	select CRYPTO_LIB_DES
+	select CRYPTO_RNG
 	select CRYPTO_SKCIPHER
 	help
 	  Some Allwinner SoC have a crypto accelerator named
 	  Security System. Select this if you want to use it.
 	  The Security System handle AES/DES/3DES ciphers in CBC mode
@@ -47,10 +48,11 @@ config CRYPTO_DEV_SUN8I_CE
 	select CRYPTO_ENGINE
 	select CRYPTO_ECB
 	select CRYPTO_CBC
 	select CRYPTO_AES
 	select CRYPTO_DES
+	select CRYPTO_RNG
 	depends on CRYPTO_DEV_ALLWINNER
 	depends on PM
 	help
 	  Select y here to have support for the crypto Engine available on
 	  Allwinner SoC H2+, H3, H5, H6, R40 and A64.
diff --git a/drivers/crypto/intel/qat/Kconfig b/drivers/crypto/intel/qat/Kconfig
index 4b4861460dd4..6734b746ea70 100644
--- a/drivers/crypto/intel/qat/Kconfig
+++ b/drivers/crypto/intel/qat/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CRYPTO_DEV_QAT
 	tristate
+	select CRYPTO_ACOMP
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AKCIPHER
 	select CRYPTO_DH

base-commit: f9bbd547cfb98b1c5e535aab9b0671a2ff22453a
-- 
2.53.0


