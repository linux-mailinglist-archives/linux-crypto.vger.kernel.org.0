Return-Path: <linux-crypto+bounces-23008-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKHcNjVi3mldDgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23008-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 17:50:13 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F553FC1FA
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988413025C51
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B7C7081E;
	Tue, 14 Apr 2026 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbxicmW6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAA3ECBCC
	for <linux-crypto@vger.kernel.org>; Tue, 14 Apr 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181755; cv=none; b=G7j5eXsIf90eTm8lLOOmh+YmvwM0Se5NhLVnkZy6iNf/bbtqI90O6WPfJTbIxgCCo7fX5krxUQM4xzK3luty7f8WbVsvSTZaFCQZ8So0mPkS1bEN56spLbFYkQE4uD+rKcei767m+d/QmelpF9bUQlcHFDjXWprU/XcjCaMxAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181755; c=relaxed/simple;
	bh=V1Fk519hgo3dpZBGJB1Y3JfAX4U+Qfb1seDaiWtoFMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6OxdlqIR5oAFzpjE4xZZ2FAe4+lKfPYmwforeAXpUnzZemHIUI3BwUYko8+c0NxsfU0rgkzXPpqOTRtjlRPOHgj8WtM4pg240s4OAWZaWtW7qUzI7bODqWvYdn1cPhSgBUqojGGlNZL3Gyo4KWoMoLMADAxbbiBSMg6ACAEz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbxicmW6; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776181749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=STfz/ccXR7C9ENHj5rGcf2fIXq9sUv9WzGnqBbk19js=;
	b=sbxicmW6jI3cdclr/KpsdmmH6iWO28WXsrq0nTgd1KigvmhyGZclhmt4zD8pU2a5j+X7jV
	SnPCK95CjJZ4Plo9Gzx0badiqgfL2wbMUXR8iCJJWCVvMd+zo5yFfYPTrQwDVswvMSpRUU
	scel4B3itKFXbTR2yOci5yqOcjf+nsQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: blake2b - use memcpy_and_pad in __blake2b_init
Date: Tue, 14 Apr 2026 17:49:03 +0200
Message-ID: <20260414154902.344182-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=thorsten.blum@linux.dev; h=from:subject; bh=V1Fk519hgo3dpZBGJB1Y3JfAX4U+Qfb1seDaiWtoFMw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn3Et+xiX1p12WcFLtos8Bs/2cCZ9JWynX8zz/t8rObd WFhevPsjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhIbBYjw6qrW9+vmPnx0Du2 F3635tZM7vk2wzxToIt/72qfnwvrF1xk+Gei+eO+cYDGb+2iR8HPFeo+K4oKfTJIWr3H8tNfPhv vc+wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23008-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 59F553FC1FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use memcpy_and_pad() instead of memcpy() followed by memset() to
simplify __blake2b_init(). Use sizeof(ctx->buf) instead of the macro
BLAKE2B_BLOCK_SIZE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/crypto/blake2b.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
index 3bc37fd103a7..a7a6440bd784 100644
--- a/include/crypto/blake2b.h
+++ b/include/crypto/blake2b.h
@@ -66,9 +66,8 @@ static inline void __blake2b_init(struct blake2b_ctx *ctx, size_t outlen,
 	ctx->buflen = 0;
 	ctx->outlen = outlen;
 	if (keylen) {
-		memcpy(ctx->buf, key, keylen);
-		memset(&ctx->buf[keylen], 0, BLAKE2B_BLOCK_SIZE - keylen);
-		ctx->buflen = BLAKE2B_BLOCK_SIZE;
+		memcpy_and_pad(ctx->buf, sizeof(ctx->buf), key, keylen, 0);
+		ctx->buflen = sizeof(ctx->buf);
 	}
 }
 

