Return-Path: <linux-crypto+bounces-23412-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAKbAfU972le/AAAu9opvQ
	(envelope-from <linux-crypto+bounces-23412-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 12:44:05 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03647126B
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93179301680E
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EBC3B4EB5;
	Mon, 27 Apr 2026 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vFnuPRgk"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669943ACF15
	for <linux-crypto@vger.kernel.org>; Mon, 27 Apr 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286634; cv=none; b=fJHZklNzkYsslfWFSd89vzXvSrpmu+0rJofDKEICnnMrs7N+zm0gvqRPluuhfWwtBNWozEw+SYl3EGTYCsmFn6enGm6iUgTBFg7is918n3L3h8ApJFcfIf2XMe9bxNNJU6Z28Liau9bwEcWxwCQwMHPWCFsV/a6v0F7XqBlkavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286634; c=relaxed/simple;
	bh=MHQSSnl0eVcnwfgVuoavh5dOF26BOJ73k+GxAZ+tVFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTv0cXBbgfJp01IEHdHeNi2PBwWIArkhmHjuEa9L7S6uhI2IJCClcpMJzlV502Synq63+clnzV/LFSoG+HCHXEWA/PHFPfj3TuwgwCAIj7E02xWn1pJw0gM+hU76pvceZeF0d543dRUrIoM9Ngf0b7tGv3yd6Lab4gdf5qRA8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vFnuPRgk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777286631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxXezg4VdD+s2G4MRCa4xBQXQVy7OIS1ya/oSZuKtVI=;
	b=vFnuPRgk4smKSO4P/HerRaG34JJd6v7oYe8LyvK0X0CGRdmf4RnXL9eHEY6QSYJA3nQ2UF
	hWN+l+GyyfB+OS4c7nePx+IFEEdcFEIx6ZSiw2pOIwE62c4PeZPxnKTVpV92u0EOInF0KH
	DToqf7l4Jg+mqDZHMNVw+sOargUX6so=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 2/6] crypto: af_alg - use sock_kzalloc in af_alg_alloc_areq
Date: Mon, 27 Apr 2026 12:41:31 +0200
Message-ID: <20260427104129.309982-8-thorsten.blum@linux.dev>
In-Reply-To: <20260427104129.309982-7-thorsten.blum@linux.dev>
References: <20260427104129.309982-7-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=thorsten.blum@linux.dev; h=from:subject; bh=MHQSSnl0eVcnwfgVuoavh5dOF26BOJ73k+GxAZ+tVFw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnvbeN+77G7er+F2S+K3b/WPydj/4zPS36fawz2Ovi8a RGvXnZGRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEykfDEjwxu25AXdv7ja2ybw a+iH3j+2LUx+zz0+znOuegXiN+9+FGf4H7b9BWMwo7XQu1vzL+e3/OZ+/PWDbPWJ7rXeHytdFZx v8gMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6F03647126B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23412-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
simplify af_alg_alloc_areq().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/af_alg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 5a00c18eb145..7a853a866957 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1179,12 +1179,10 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (ctx->inflight)
 		return ERR_PTR(-EBUSY);
 
-	areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
+	areq = sock_kzalloc(sk, areqlen, GFP_KERNEL);
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
-	memset(areq, 0, areqlen);
-
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;

