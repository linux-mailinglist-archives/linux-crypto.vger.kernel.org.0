Return-Path: <linux-crypto+bounces-23202-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KedKUnK5WlIoAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23202-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:40:09 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C00427516
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727C4305DA68
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E638551B;
	Mon, 20 Apr 2026 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNLwVM7/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B53845DF;
	Mon, 20 Apr 2026 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667023; cv=none; b=b+OuvNFUUZTapXOkBOzc07kmtDjkQa3K9k0zxiIdPwioQVUGrH0vGohGnA7sWmfqY8S0KRzE0sAHuCBzoQA1SWcsgJkevjOwB3X7XKT/q/sLrrwx/7vdZu8S/aqKlXqwqVHYTQcnU9xTInWffhRjXaVtykpwBRTOdFACxifZwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667023; c=relaxed/simple;
	bh=cZwmCscUuEyvlR+CvwGe/YP6a6yyBNLUC2VWDUQBNgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiEpvNnr03wqw6UdDB9mq+xYsDzSr/RYE/89lct5Vv2Jq4ZLbs10063qIq2r4HZPGzY0bxN7cFoWL4+OkiOhhp4lZkkIraYEuC5/d6Ccv1dLlMJsXUsBdgkm/lwPYcmzCzk/R3AinL+XCI2tGHUMBtFgCDAbdmqbL2O5rwCXi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNLwVM7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5EBC2BCB3;
	Mon, 20 Apr 2026 06:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776667022;
	bh=cZwmCscUuEyvlR+CvwGe/YP6a6yyBNLUC2VWDUQBNgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNLwVM7/9ws/bRc6aHvyM+GykytYG4H4A0q6Jkf6G2WZlwHoX09CcpxN7damXoilO
	 B3MFpwYuU6FDHbGlGs2upYWC7tG1TMfIpI7JLlrahhB8lX/rZBQC2SPxmwxJ/b7Jot
	 ZjI1NCyn7S+Jqf5Tcpolk0NhZLD7WErv+vtTtH6xknn8jO6/3Yrklp13O0wForkbwt
	 AJeU4EgmlKZvMAhr1MK8WtaByJMz4f8YLQfiefBHkqwnFjuWx+TePM0czBSZgEVH4m
	 8OXaNMFAG3H7EYI8WIaANACt1jSfIQhcO2CVVSE6X1YJauc1PU3eSSbEYRfjQPYANn
	 tPDdsCRSRSCtA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 11/38] crypto: drbg - Remove import of crypto_cipher functions
Date: Sun, 19 Apr 2026 23:33:55 -0700
Message-ID: <20260420063422.324906-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420063422.324906-1-ebiggers@kernel.org>
References: <20260420063422.324906-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23202-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C00427516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The inclusion of <crypto/internal/cipher.h> and the import of the
internal crypto namespace became unnecessary in commit ba0570bdf1d9
("crypto: drbg - Replace AES cipher calls with library calls").

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/drbg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index fd1d75addaf7..9dedc6186b42 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -91,11 +91,10 @@
  * -------------------------------------------------------------
  * Just mix both scenarios above.
  */
 
 #include <crypto/df_sp80090a.h>
-#include <crypto/internal/cipher.h>
 #include <crypto/internal/drbg.h>
 #include <crypto/internal/rng.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
 #include <linux/fips.h>
@@ -1906,6 +1905,5 @@ MODULE_DESCRIPTION("NIST SP800-90A Deterministic Random Bit Generator (DRBG) "
 		   "using following cores: "
 		   CRYPTO_DRBG_HASH_STRING
 		   CRYPTO_DRBG_HMAC_STRING
 		   CRYPTO_DRBG_CTR_STRING);
 MODULE_ALIAS_CRYPTO("stdrng");
-MODULE_IMPORT_NS("CRYPTO_INTERNAL");
-- 
2.53.0


