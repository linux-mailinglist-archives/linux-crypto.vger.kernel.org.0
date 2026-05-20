Return-Path: <linux-crypto+bounces-24345-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PRrF3+GDWpdygUAu9opvQ
	(envelope-from <linux-crypto+bounces-24345-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 12:01:35 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF458B41F
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B8103017E56
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36E3B52F5;
	Wed, 20 May 2026 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWhd7ROi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D773955C4
	for <linux-crypto@vger.kernel.org>; Wed, 20 May 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271283; cv=none; b=HsKSHdEA9dU2JBX8Ze3bo7nvyFeAZnapuArIRXRZIn9CAilVqnPh+k+HLwJzzGxy9eOZV1koSVWDUYl4XT10qmzr6Af4ayNImTjoDeeRr/jiAz0qzLHft4Hitan9UVJRTLFMfjTQCz6DUeXrCERf4LBfbR1ClKcDw9sQd5Zcht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271283; c=relaxed/simple;
	bh=yFwM5PqbotdeJzNgzjeqgA9RaNzQqOatkuIPDmcjdz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kD80JKyuRGcP+mthV2rs0HOPL1mJjlahfDeNA+hlmMt+Mrfb51kWPo0CFo5J2kFT6/NqCDLat4c6UQe7J81rEsvV0iAmiLfpM6wy/MLpPic/Re8B3FdMS9nN+Fn09CGZaK9tpessoVk62mQ3PoJmbyIHS5gc512KRmDzpUg6gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWhd7ROi; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779271272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oSYoZE3APiv3L4JqGabArJNg5tRoRTXBcqiwu9fBl84=;
	b=KWhd7ROi6eMuEj5YqY3ZQss6XS82c+yMoNzfkcuapj8zevu/p3Aile2/WUCJFoWzxdG4gU
	ftUibnJoC1k069DvutVd8PQByr9p4qCTUwa9B7Mh9qfWP6KqG6ayI+Fj6I6zlEp50Hu1Wl
	NmueBYHIynaCBTl+DBH+DxSPThLJ2Ko=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: octeontx - use strscpy_pad in ucode_load_store
Date: Wed, 20 May 2026 12:00:30 +0200
Message-ID: <20260520100031.246078-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=thorsten.blum@linux.dev; h=from:subject; bh=yFwM5PqbotdeJzNgzjeqgA9RaNzQqOatkuIPDmcjdz0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFm8bQ5vOxcXMXBcaK/cLXWiJOPU9MM5VV7+TitWv+A6l ZVssoS7o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACayVZqRYc/rQ8uTbC4lukQG L973S3rjirPP3xxvKzvZfSSg9eFfq3ZGhvX2rU1GPN8qLUQPZt/r0TXr8Dku9817kcbGAomCuDN NXAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24345-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFDF458B41F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of zero-initializing the temporary buffer and then copying into
it with strscpy(), use strscpy_pad() to copy the string and zero-pad any
trailing bytes. Drop the explicit size argument to further simplify the
code since strscpy_pad() can determine it automatically when the
destination buffer has a fixed length.

Also use strscpy_pad() to check for string truncation instead of the
hard-coded OTX_CPT_UCODE_NAME_LENGTH.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index e0f38d32bc93..205579a6ba2b 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1318,7 +1318,7 @@ static ssize_t ucode_load_store(struct device *dev,
 {
 	struct otx_cpt_engines engs[OTX_CPT_MAX_ETYPES_PER_GRP] = { {0} };
 	char *ucode_filename[OTX_CPT_MAX_ETYPES_PER_GRP];
-	char tmp_buf[OTX_CPT_UCODE_NAME_LENGTH] = { 0 };
+	char tmp_buf[OTX_CPT_UCODE_NAME_LENGTH];
 	char *start, *val, *err_msg, *tmp;
 	struct otx_cpt_eng_grps *eng_grps;
 	int grp_idx = 0, ret = -EINVAL;
@@ -1326,12 +1326,11 @@ static ssize_t ucode_load_store(struct device *dev,
 	int del_grp_idx = -1;
 	int ucode_idx = 0;
 
-	if (count >= OTX_CPT_UCODE_NAME_LENGTH)
+	if (strscpy_pad(tmp_buf, buf) < 0)
 		return -EINVAL;
 
 	eng_grps = container_of(attr, struct otx_cpt_eng_grps, ucode_load_attr);
 	err_msg = "Invalid engine group format";
-	strscpy(tmp_buf, buf, OTX_CPT_UCODE_NAME_LENGTH);
 	start = tmp_buf;
 
 	has_se = has_ie = has_ae = false;

