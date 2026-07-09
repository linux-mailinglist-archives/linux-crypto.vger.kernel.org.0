Return-Path: <linux-crypto+bounces-25750-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ek9JGwkHT2o3ZQIAu9opvQ
	(envelope-from <linux-crypto+bounces-25750-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 04:27:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225272BEBD
	for <lists+linux-crypto@lfdr.de>; Thu, 09 Jul 2026 04:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ej+XT254;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25750-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25750-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ABF8300B9C5
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2026 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA82EEE99;
	Thu,  9 Jul 2026 02:27:15 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834043935A;
	Thu,  9 Jul 2026 02:27:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564035; cv=none; b=eBwcULp196GWzeQLf06gI/LyVQ4ULFRdfL3QPCf7sskd20Ctm9i9t2PqiCKxCZr5LvmmjkMEEmpwx63KS2CMUtHJP12JObvjU6CDYm0GhyZ08oKFX3P4r1kcBrT9oqzFds0+1HxqS1IZNU2jfcsmiFRFjpktiKZ172vP4Pf0Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564035; c=relaxed/simple;
	bh=T2OfrOkr0G1j0a+hapy3UPr9El1BFVUIIATtGHWgNPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxs7iuDSnyvvKSCflNuQzBnmlZj9AUzowHMP3bAHY8v0xsUVi/0IngUCJRayPRj5wu3ITdDCr+IRPiyVNkL6UVIZtBlAai7A2vsjDWhn3pJOyr1Iuahp26rRxinv/ikULRy6ntpNafBrnsYY4qFGOD9eyVeenRXD77rm6iPUf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej+XT254; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA531F000E9;
	Thu,  9 Jul 2026 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783564033;
	bh=0/VLGLH5/go+Vwpr0tw0EW20comPYZm9iNmYzQPPYms=;
	h=From:To:Cc:Subject:Date;
	b=ej+XT254DzqJ39V+PmCMlKPQzuzyUQsIWfic4bsx+YRCrqF++5Zh1pEJa6Kp7ni+a
	 gsZJiYz35zloJTn7HansAQcCa30ndYOMyjqAqIb9kQSHceqW4DZlIp1r7IoqQC530C
	 702bNApU4zKrKhG+f9fjqvbCw/sGxcyOdBKzMMPEcgNqrtJCqdZmzDtJ3FlG6pKLYA
	 dfUGdrqIApt4clB2iVoMsKCjyy2+L6ChrDzw6hWYaKanFIsbTU+d0SlSNS/CeN9WiO
	 VzC7/kUdLACDz1c/nwYMMCTJUJRQD17202TfsWl4XmQH2g7JN+Fzrsqcb1r30dQA6/
	 CzMsxWPnIdEug==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH] lib/crypto: docs: Fix some sentence fragments
Date: Wed,  8 Jul 2026 22:26:51 -0400
Message-ID: <20260709022651.44216-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25750-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ardb@kernel.org,m:Jason@zx2c4.com,m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,m:thuth@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5225272BEBD

Currently, the section about the library API for each algorithm begins
with a noun phrase that was intended to serve as an elaboration on the
title.  It's better to use complete sentences.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 .../crypto/libcrypto-blockcipher.rst          |  6 +--
 Documentation/crypto/libcrypto-hash.rst       | 38 ++++++++++---------
 Documentation/crypto/libcrypto-signature.rst  |  2 +-
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/crypto/libcrypto-blockcipher.rst b/Documentation/crypto/libcrypto-blockcipher.rst
index dd5ce2f8b515..fd85e27fab8d 100644
--- a/Documentation/crypto/libcrypto-blockcipher.rst
+++ b/Documentation/crypto/libcrypto-blockcipher.rst
@@ -6,14 +6,14 @@ Block ciphers
 AES
 ---
 
-Support for the AES block cipher.
+This API provides support for the AES block cipher.
 
 .. kernel-doc:: include/crypto/aes.h
 
 DES
 ---
 
-Support for the DES block cipher.  This algorithm is obsolete and is supported
-only for backwards compatibility.
+This API provides support for the DES block cipher.  This algorithm is obsolete
+and is supported only for backwards compatibility.
 
 .. kernel-doc:: include/crypto/des.h
diff --git a/Documentation/crypto/libcrypto-hash.rst b/Documentation/crypto/libcrypto-hash.rst
index 4248e6fdc952..fa4c54236af6 100644
--- a/Documentation/crypto/libcrypto-hash.rst
+++ b/Documentation/crypto/libcrypto-hash.rst
@@ -6,81 +6,83 @@ Hash functions, MACs, and XOFs
 AES-CMAC and AES-XCBC-MAC
 -------------------------
 
-Support for the AES-CMAC and AES-XCBC-MAC message authentication codes.
+This API provides support for the AES-CMAC and AES-XCBC-MAC message
+authentication codes.
 
 .. kernel-doc:: include/crypto/aes-cbc-macs.h
 
 BLAKE2b
 -------
 
-Support for the BLAKE2b cryptographic hash function.
+This API provides support for the BLAKE2b cryptographic hash function.
 
 .. kernel-doc:: include/crypto/blake2b.h
 
 BLAKE2s
 -------
 
-Support for the BLAKE2s cryptographic hash function.
+This API provides support for the BLAKE2s cryptographic hash function.
 
 .. kernel-doc:: include/crypto/blake2s.h
 
 GHASH and POLYVAL
 -----------------
 
-Support for the GHASH and POLYVAL universal hash functions.  These algorithms
-are used only as internal components of other algorithms.
+This API provides support for the GHASH and POLYVAL universal hash functions.
+These algorithms are used only as internal components of other algorithms.
 
 .. kernel-doc:: include/crypto/gf128hash.h
 
 MD5
 ---
 
-Support for the MD5 cryptographic hash function and HMAC-MD5.  This algorithm is
-obsolete and is supported only for backwards compatibility.
+This API provides support for the MD5 cryptographic hash function and HMAC-MD5.
+This algorithm is obsolete and is supported only for backwards compatibility.
 
 .. kernel-doc:: include/crypto/md5.h
 
 NH
 --
 
-Support for the NH universal hash function.  This algorithm is used only as an
-internal component of other algorithms.
+This API provides support for the NH universal hash function.  This algorithm is
+used only as an internal component of other algorithms.
 
 .. kernel-doc:: include/crypto/nh.h
 
 Poly1305
 --------
 
-Support for the Poly1305 universal hash function.  This algorithm is used only
-as an internal component of other algorithms.
+This API provides support for the Poly1305 universal hash function.  This
+algorithm is used only as an internal component of other algorithms.
 
 .. kernel-doc:: include/crypto/poly1305.h
 
 SHA-1
 -----
 
-Support for the SHA-1 cryptographic hash function and HMAC-SHA1.  This algorithm
-is obsolete and is supported only for backwards compatibility.
+This API provides support for the SHA-1 cryptographic hash function and
+HMAC-SHA1.  This algorithm is obsolete and is supported only for backwards
+compatibility.
 
 .. kernel-doc:: include/crypto/sha1.h
 
 SHA-2
 -----
 
-Support for the SHA-2 family of cryptographic hash functions, including SHA-224,
-SHA-256, SHA-384, and SHA-512.  This also includes their corresponding HMACs:
-HMAC-SHA224, HMAC-SHA256, HMAC-SHA384, and HMAC-SHA512.
+This API provides support for the SHA-2 family of cryptographic hash functions,
+including SHA-224, SHA-256, SHA-384, and SHA-512.  This also includes their
+corresponding HMACs: HMAC-SHA224, HMAC-SHA256, HMAC-SHA384, and HMAC-SHA512.
 
 .. kernel-doc:: include/crypto/sha2.h
 
 SHA-3
 -----
 
-The SHA-3 functions are documented in :ref:`sha3`.
+The SHA-3 API is documented in :ref:`sha3`.
 
 SM3
 ---
 
-Support for the SM3 cryptographic hash function.
+This API provides support for the SM3 cryptographic hash function.
 
 .. kernel-doc:: include/crypto/sm3.h
diff --git a/Documentation/crypto/libcrypto-signature.rst b/Documentation/crypto/libcrypto-signature.rst
index e80d59fa51b6..2a6dc793f0de 100644
--- a/Documentation/crypto/libcrypto-signature.rst
+++ b/Documentation/crypto/libcrypto-signature.rst
@@ -6,6 +6,6 @@ Digital signature algorithms
 ML-DSA
 ------
 
-Support for the ML-DSA digital signature algorithm.
+This API provides support for the ML-DSA digital signature algorithm.
 
 .. kernel-doc:: include/crypto/mldsa.h

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0


