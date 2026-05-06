Return-Path: <linux-crypto+bounces-23785-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGvqM9lB+2lPYgMAu9opvQ
	(envelope-from <linux-crypto+bounces-23785-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 06 May 2026 15:27:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934E4DAF58
	for <lists+linux-crypto@lfdr.de>; Wed, 06 May 2026 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E9CF30120D6
	for <lists+linux-crypto@lfdr.de>; Wed,  6 May 2026 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966B3F1641;
	Wed,  6 May 2026 13:27:51 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9F3F0ABE;
	Wed,  6 May 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074070; cv=none; b=r5/HiJut1BVVa022C0kHfu+mgOU0zQc+hDE9yLIeQ4r+AJWP5Wkev4h1TIQpI/YfkRAUyTq5L70Mob0v3aJ9zR4MWwOE36ISZ5ZMAH1Jyn0D9FBhxtO7BwAvLmvPiA7qiCCBoVt/3Fzoo3GFyiQUfZpZU3hLjTyb1tFAACap8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074070; c=relaxed/simple;
	bh=5cF1WGzLgKm8TXk//I3thXJZYfXicmdqvKNNldydGsI=;
	h=Message-Id:From:Date:Subject:To:Cc; b=l5W72J+5OdcFFPWUfK9dN6OPEdUP6U6DbGhwoZknILjiKbe0HBLLfMJDZJnt29xSnB8zTTGpTtXD22s8X0FhFsiSqIzeCpX0saA9pAG2BMMMleaoonwQtJumTAO0+jhDXM+JWkHqN1V5nWiiyWIsg8MUHt2tKtTCIWbZEbB1XXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 364DDF52;
	Wed, 06 May 2026 15:27:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1F5D06001EB0; Wed,  6 May 2026 15:27:44 +0200 (CEST)
Message-Id: <7e3d64a53efb28740b32d1f934e78c10086208ab.1778073318.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 6 May 2026 15:27:49 +0200
Subject: [PATCH v2] crypto: ecc - Unbreak the build on arm with
 CONFIG_KASAN_STACK=y
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Ignat Korchagin <ignat@linux.win>, Stefan Berger <stefanb@linux.ibm.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Eric Biggers <ebiggers@kernel.org>, Nathan Chancellor <nathan@kernel.org>, David Laight <david.laight.linux@gmail.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4934E4DAF58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,linux.win,linux.ibm.com,vger.kernel.org,googlegroups.com,google.com,arm.com,linux.intel.com,kernel.org,zx2c4.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23785-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linux-foundation.org:email]

Andrew reports build breakage of arm allmodconfig, reproducible with gcc
14.2.0 and 15.2.0:

  crypto/ecc.c: In function 'ecc_point_mult':
  crypto/ecc.c:1380:1: error: the frame size of 1360 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

gcc aggressively inlines functions called by ecc_point_mult() (without
there being any explicit inline declarations), which pushes stack usage
close to the limit imposed by CONFIG_FRAME_WARN.  allmodconfig implies
CONFIG_KASAN_STACK=y, which increases the stack above that limit.

In the bugzilla entry linked below, gcc maintainers explain that gcc
estimates extra stack usage caused by inlining, but ASAN instrumentation
is added in post-IPA passes and thus the inlining heuristics cannot
account for it.

It could be argued that -Werror=frame-larger-than=1280 instructs the
compiler to avoid inlining beyond that limit lest the build breaks,
which would imply gcc behaves incorrectly.  But gcc maintainers reject
this notion and believe that a warning switch should never affect code
generation, even if it is promoted to an error.

One way to unbreak the build is to limit inlining via -finline-limit=100
or by explicitly declaring some functions noinline.  However while it
does keep stack usage of individual functions below the limit, *total*
stack usage increases.

A longterm solution is to refactor ecc.c for reduced stack usage.  It
currently performs ECC point multiplication with a Montgomery ladder
which uses co-Z (conjugate) addition to trade off memory for speed.
The algorithm is susceptible to timing attacks and needs to be replaced
with a constant time Montgomery ladder, which should consume less memory
and thus resolve the stack usage issue as a side effect.

In the interim, raise the limit for ecc.c, as is already done for
several other files in the source tree.

Constrain to gcc because clang 19.1.7 does not exhibit the issue.  It
makes do with a 724 bytes stack frame even though it inlines almost the
same functions as gcc.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124949
Reported-by: Andrew Morton <akpm@linux-foundation.org> # off-list
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes v1 -> v2:
* s/ARCH/CONFIG_ARM/, s/LLVM/CONFIG_CC_IS_GCC/ (Nathan)
* Add link to gcc bugzilla entry
* Rewrite commit message to include feedback provided by gcc maintainers
  and explain high stack usage with algorithm choice

Link to v1:
https://lore.kernel.org/r/abfaede9ab2e963d784fb70598ed74935f7f8d93.1775628469.git.lukas@wunner.de/

 crypto/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/Makefile b/crypto/Makefile
index 1622425..c73f4d5 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -178,6 +178,11 @@ obj-$(CONFIG_CRYPTO_ZSTD) += zstd.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
 obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124949
+ifeq ($(CONFIG_ARM)$(CONFIG_KASAN_STACK)$(CONFIG_CC_IS_GCC),yyy)
+CFLAGS_ecc.o += $(call cc-option,-Wframe-larger-than=1536)
+endif
+
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
 obj-$(CONFIG_CRYPTO_ECDH) += ecdh_generic.o
-- 
2.51.0


