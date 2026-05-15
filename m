Return-Path: <linux-crypto+bounces-24132-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOtdN12CB2qQ5gIAu9opvQ
	(envelope-from <linux-crypto+bounces-24132-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 22:30:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F0F5576F9
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D703300FF86
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2026 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F333E3167;
	Fri, 15 May 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PHc3J6vr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29C3E2AD4
	for <linux-crypto@vger.kernel.org>; Fri, 15 May 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877018; cv=none; b=eN0rNsavvsLC3B9iAMREOK/CLNNvUdiRtWfh48bQT29zuzWJFlOZBU+4YC/Z/BN2tQboTQY3nx9dSBizuFHV9Ws1hurydizO6UV8AmvdiKm47myAY2YQLHAa30fRQvqSuHUp7fwej/Z/mw1GsfTRRmGFsyPuHs/G/FkBTjIJrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877018; c=relaxed/simple;
	bh=Q8X3Cfsu45fvncATKmw13bJFse7MnTZYaL27Q0//WKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxzNksq1tVUH0MYybuSJi6gYpGRjGPOaBRY91+Lc5sV/2J8DG04ATdPCJhDA23VvAEV19tTajJg3ev11p+7ETYTvTLRO4rf+Pp8QJduKHsjxAN8qTucHD00csdxgKfJLc9fkhO9lgKuKLSmRyBDKa5poexafNnpsZUUJDh53QFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PHc3J6vr; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778877013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DoOscPPbEq+IsrvoFBtYmGkOpWEY5ZhOZDh4BoQkSzU=;
	b=PHc3J6vrb8NtBt640oarelPk5aRnfNS2YuFma4X7BqcLegm8HmkVQmONqcN7uluRBbnTgT
	SPC36gGi3Og8IOgyrxZI+mJxwE2PND5slfu8ydnErK1ei2j9u4zck4f0VHlCdPjASJ1vu5
	U6qbwP7vpGrN1lkEtCxKphJCWLu2cfI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-i2c - drop redundant void * callback cast in enqueue
Date: Fri, 15 May 2026 22:29:48 +0200
Message-ID: <20260515202946.725533-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=thorsten.blum@linux.dev; h=from:subject; bh=Q8X3Cfsu45fvncATKmw13bJFse7MnTZYaL27Q0//WKk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnsTVa6UytjG7780pcP1KvOspV6bt5tUKh8dNK6X/uyC vQdavZ2lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwEQsMxj+x91e0XTv37aLJ9mF KyaGHozx3v9i2f+qK8tumvy5scbi6TVGhsfl+kYHPNjqi97nMG1Q6d3m/0fEI+1B2DYFX+Z7C4r cuAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 21F0F5576F9
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
	TAGGED_FROM(0.00)[bounces-24132-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

The callback already has the correct type - remove the redundant cast.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 0e275dbdc8c5..ff19857894d0 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -294,7 +294,7 @@ void atmel_i2c_enqueue(struct atmel_i2c_work_data *work_data,
 				   void *areq, int status),
 		       void *areq)
 {
-	work_data->cbk = (void *)cbk;
+	work_data->cbk = cbk;
 	work_data->areq = areq;
 
 	INIT_WORK(&work_data->work, atmel_i2c_work_handler);

