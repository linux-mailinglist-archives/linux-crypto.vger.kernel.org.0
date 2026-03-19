Return-Path: <linux-crypto+bounces-22127-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLgXLKuVu2nwlgIAu9opvQ
	(envelope-from <linux-crypto+bounces-22127-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 07:20:27 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 625922C6A92
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 07:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCC7330451ED
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016A3624DB;
	Thu, 19 Mar 2026 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb5YamRu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849B34D391;
	Thu, 19 Mar 2026 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773901163; cv=none; b=NEORRmaUssRQPPfwtbbP4w2hgPkYBWSB1HBsfhnnpOkrwuXeqqW5x30dN6Qenv4JjWjPXQwTHaAEQRctPde1NPt7FJjuALwo265tnNQL3EQVFKHnN2jJjxYJUfuvH9p6zwJKU0uB8WwTtiCpR+JDL7C3ytKtNKfenIUq7k10ApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773901163; c=relaxed/simple;
	bh=30YR8O9RGszwoyHMoelh/TUtAbWKLQ7inDpOxAFZk7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRVKAJR6OU78BWoEbWnUmvesWH/UNdy3LSenMMBZvGHyPXcBytKFxDQpvc/Zq9OaGqxqHt9SNKvMl6YgqccFj5vh/HlZWrdMG9r3cnUoexIML+ffGHL1c3HjvUZc45pCtUSCnzWoUOdckAtxlE/LPjIdr01xJQp2e2VRw0+SZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb5YamRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE38C2BCB7;
	Thu, 19 Mar 2026 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773901163;
	bh=30YR8O9RGszwoyHMoelh/TUtAbWKLQ7inDpOxAFZk7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb5YamRuffHIic0o3S+n53i4qR5e6SehVWlaTLv8p1LyBsgjpRVs/k1Cx/Xp7ce1W
	 Zf0W4HoFFtWz5rRWKO4sKN81SffR9WDMIBpwl0xK1/I00zBhZVV5MF6ckGERn1BU6Z
	 m2OAlKc80xW5wLY01FrtxijQ0aLm3eKC9uTS1nN6KW82CQkUXIMv6Jl62fACy+VPm+
	 TMTPRYFNjVleqEA95/N+pxM69ANF2eFCsbQwyUDCmDZ2rKjS12BzFcRwNqGEV8EbLp
	 8f7Bo8/Jb08B8sDDi2wv+tf5yku4WvsNXYwoIrg79Hvcy/49rLVT1DjimFh74VZ0LU
	 uLuXhujkLXMCg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 18/19] lib/crypto: gf128hash: Remove unused content from ghash.h
Date: Wed, 18 Mar 2026 23:17:19 -0700
Message-ID: <20260319061723.1140720-19-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319061723.1140720-1-ebiggers@kernel.org>
References: <20260319061723.1140720-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22127-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625922C6A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the structures in <crypto/ghash.h> are no longer used, remove
them.  Since this leaves <crypto/ghash.h> as just containing constants,
include it from <crypto/gf128hash.h> to deduplicate these definitions.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/gf128hash.h |  3 +--
 include/crypto/ghash.h     | 12 ------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/crypto/gf128hash.h b/include/crypto/gf128hash.h
index 0bc649d01e12..41c557d55965 100644
--- a/include/crypto/gf128hash.h
+++ b/include/crypto/gf128hash.h
@@ -6,15 +6,14 @@
  */
 
 #ifndef _CRYPTO_GF128HASH_H
 #define _CRYPTO_GF128HASH_H
 
+#include <crypto/ghash.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
-#define GHASH_BLOCK_SIZE	16
-#define GHASH_DIGEST_SIZE	16
 #define POLYVAL_BLOCK_SIZE	16
 #define POLYVAL_DIGEST_SIZE	16
 
 /**
  * struct polyval_elem - An element of the POLYVAL finite field
diff --git a/include/crypto/ghash.h b/include/crypto/ghash.h
index 043d938e9a2c..d187e5af9925 100644
--- a/include/crypto/ghash.h
+++ b/include/crypto/ghash.h
@@ -4,21 +4,9 @@
  */
 
 #ifndef __CRYPTO_GHASH_H__
 #define __CRYPTO_GHASH_H__
 
-#include <linux/types.h>
-
 #define GHASH_BLOCK_SIZE	16
 #define GHASH_DIGEST_SIZE	16
 
-struct gf128mul_4k;
-
-struct ghash_ctx {
-	struct gf128mul_4k *gf128;
-};
-
-struct ghash_desc_ctx {
-	u8 buffer[GHASH_BLOCK_SIZE];
-};
-
 #endif
-- 
2.53.0


