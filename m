Return-Path: <linux-crypto+bounces-20532-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLWnJWKUf2lotwIAu9opvQ
	(envelope-from <linux-crypto+bounces-20532-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 01 Feb 2026 18:58:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5239C6DBD
	for <lists+linux-crypto@lfdr.de>; Sun, 01 Feb 2026 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C3F3003E9B
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Feb 2026 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E626B2D2;
	Sun,  1 Feb 2026 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DsN4ltz4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CE1D5170
	for <linux-crypto@vger.kernel.org>; Sun,  1 Feb 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968648; cv=none; b=MzDnrROTitmPdbeW+HfSTSddbBvK7PIfXtJJN9gKtALR3if+dn4THnLv92nP6wNmCYr/UHB9SxG4Ej4JAmWKT1TyxgwTZLLYMeE1YlQEs2izCglG/ipbL6MOsYgb0pExHFiIVWyCYf3RqR1M9eNM5L6aNeU84F0Xk2EcZ25kC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968648; c=relaxed/simple;
	bh=HRBBj0nPq7qU55R3IPHOngXEvBb3wwpPQ7k4n533wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csJculBFqjrp4RL9N/Yet8fwIXshWoM4jUeG/0rOh4xr7VxsTEoQ03wP2kgwp9NzGntcsu/6qJLQBx5goC4LacCCJCHAe35vI/ZHiuVtWabvkMz3nM5s6q9gSdp9moUwbcKIvCbcA0+WDSWltSQ+f6oU77WMU2N5WSkpUZ4ZGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DsN4ltz4; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769968644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWD89ORk2rwOefxQ8yqPj9t/reTFvE2D7mE1erXtzWc=;
	b=DsN4ltz47LFzz+FP/6VNpbbyaIEC9zf/s79KNqe87N94SixmnHa3t6G7J79WVBeF7LDMm+
	NwuY13MHSZD0DoKuTEdDT+jafWLoxAyTO7NjekmNnx0O5uQw9lgaXMUM4cR0OVHN3dLT2r
	VWz+jgBnnGYQ9Rf81ITJ4aZADyxVlIs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: img-hash - Use unregister_ahashes in img_{un}register_algs
Date: Sun,  1 Feb 2026 18:56:33 +0100
Message-ID: <20260201175632.662976-2-thorsten.blum@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-20532-lists,linux-crypto=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5239C6DBD
X-Rspamd-Action: no action

Replace the for loops with calls to crypto_unregister_ahashes(). In
img_register_algs(), return 'err' immediately and remove the goto
statement to simplify the error handling code.

Convert img_unregister_algs() to a void function since its return value
is never used.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/img-hash.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index f22c12e36b56..7195c37dd102 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -870,25 +870,18 @@ static int img_register_algs(struct img_hash_dev *hdev)
 
 	for (i = 0; i < ARRAY_SIZE(img_algs); i++) {
 		err = crypto_register_ahash(&img_algs[i]);
-		if (err)
-			goto err_reg;
+		if (err) {
+			crypto_unregister_ahashes(img_algs, i);
+			return err;
+		}
 	}
-	return 0;
 
-err_reg:
-	for (; i--; )
-		crypto_unregister_ahash(&img_algs[i]);
-
-	return err;
+	return 0;
 }
 
-static int img_unregister_algs(struct img_hash_dev *hdev)
+static void img_unregister_algs(struct img_hash_dev *hdev)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(img_algs); i++)
-		crypto_unregister_ahash(&img_algs[i]);
-	return 0;
+	crypto_unregister_ahashes(img_algs, ARRAY_SIZE(img_algs));
 }
 
 static void img_hash_done_task(unsigned long data)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


