Return-Path: <linux-crypto+bounces-20416-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHSLKPupd2nrjwEAu9opvQ
	(envelope-from <linux-crypto+bounces-20416-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 18:52:59 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A268BC00
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 18:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91FF8306816B
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jan 2026 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42E34D4C1;
	Mon, 26 Jan 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sH0JvFOW"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BA34A790
	for <linux-crypto@vger.kernel.org>; Mon, 26 Jan 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449861; cv=none; b=jAFWqA3f6r/joNa+cGfdmORXpfckVWwaz+kA+LxZ/hY1Xt5r2LuUhXLM233ggh3DD39mA7cCKCEfeWJ8xCMLigPri3N9JvlUFpQAeNGSKEK/6NBtlnkvylQJfMreOlhJa6JKCaX0Y3RGWlKUrupHd4FIGZg9nVtvaOfO/qAxUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449861; c=relaxed/simple;
	bh=SL7/KNDA0aF6p0CwNfieUoCsvRdgyHD+yR8VTxGpO4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwc9PHterKYz+Hkw2zSGKU/pnKXcmFh/FyIPM499B/Db8m/jlz87M2SwnDlBGabMxVpsvb3tvjqPTG+XAzeQVOqlRF6MF9kCYp5OUiDDH7Cpqt330FGuUXU5ghkf8GkYUybCkFqbrkn67bneGIvimVeNOErtGiSO4GWmxM0sIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sH0JvFOW; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769449847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HGQxOYCusMSp/ky1aE6Sp7zrl/h/nHZNCBtArDjwvUA=;
	b=sH0JvFOWqHxH5X9ZIdDN+yxw8DGmVyy/ZUkP9O4QXl67tVQUDh0MiHXXmkCjXNVmiZcjuP
	tvB4qZukY1jQNwPQLCFTAiGPCUAaplJjhHSWgqCdfBUmcv+SMNb5FI5ZT5sbus3cvDf6b/
	q7uuBc1hF6nrg19qbpjmDgZmNDrXgbk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Neil Horman <nhorman@tuxdriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: rng - Use unregister_rngs in register_rngs
Date: Mon, 26 Jan 2026 18:50:18 +0100
Message-ID: <20260126175018.237812-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20416-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: E8A268BC00
X-Rspamd-Action: no action

Replace the for loop with a call to crypto_unregister_rngs(). Return
'ret' immediately and remove the goto statement to simplify the error
handling code.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/rng.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/crypto/rng.c b/crypto/rng.c
index ee1768c5a400..475b6a42d826 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -203,17 +203,13 @@ int crypto_register_rngs(struct rng_alg *algs, int count)
 
 	for (i = 0; i < count; i++) {
 		ret = crypto_register_rng(algs + i);
-		if (ret)
-			goto err;
+		if (ret) {
+			crypto_unregister_rngs(algs, i);
+			return ret;
+		}
 	}
 
 	return 0;
-
-err:
-	for (--i; i >= 0; --i)
-		crypto_unregister_rng(algs + i);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_register_rngs);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


