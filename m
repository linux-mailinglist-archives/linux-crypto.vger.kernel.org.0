Return-Path: <linux-crypto+bounces-23620-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFytFUBM9ml7TgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23620-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 21:10:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B494B34AE
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8225300A10A
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2026 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227F3876BF;
	Sat,  2 May 2026 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNQwjJQf"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D73876C0
	for <linux-crypto@vger.kernel.org>; Sat,  2 May 2026 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777749052; cv=none; b=rEnXaMZlNzc7IIPRSDkqVLHbYfrqNZPEwO3V7CjGTcQpxFkpWhHKkZvtkPZOT0soH2pyvb29mkKjMGo+FpdKZ460K/VqSSOEuhli6vLkl3B8Y8ZfKQ7JOR6HKAoCsrOW1JMRFTwaX+pIGuIMoDv30yseSF6keHXGsyZvS4DjR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777749052; c=relaxed/simple;
	bh=2k+pROnaqtRg4paYHsezDta8apckjCrGkTD89Y61EP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uijCNmIhxZLADMDNakRJI57YjYLqdeWyP2iAwmznr8jSDBmLThQYT8iS8ndhtn72ES1RBvErm7TjfPCBo2ccCFpQ08hlSZJOoKZZOFwpWUEUKxFenCoh0lFKvzVPTWSJIxI27izoixwnFXKO2qkcm3Jf0K/fjC9KBntWCkEH9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNQwjJQf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777749038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vbXt7SKz9jJRZsbFgn2tMqqzCv3vnBSFSOmfSt36JN4=;
	b=XNQwjJQfdexg5jMrg/ET/4Yoxo6epQ/tyEbIfsh/+WtJ4ROU2M03Q4BcZ21jloEx9MU8N+
	8aq2QGlsWCJXc2o8g8ghUGy/By5M8boJcNXzHRO9Bghrjg57aehBSLZf7hBwJgO3+Fdcc7
	sj1WQHfTGX3uRpO4FGU8ZwaWZhKn+bA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vitaly Chikunov <vt@altlinux.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ecrdsa - fix unknown OID check in ecrdsa_param_curve
Date: Sat,  2 May 2026 21:09:04 +0200
Message-ID: <20260502190903.252061-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=thorsten.blum@linux.dev; h=from:subject; bh=2k+pROnaqtRg4paYHsezDta8apckjCrGkTD89Y61EP4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnfvM8/dUpJO+/5zPHGqxMT9zm6/DmnvLl0xpzHB1TU2 G2PPP2a31HKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATydnK8Jv90huF2IbDK4T3 yGksC0/RklaecEnl/7FJTxf+qbc7Xn+QkeHBLdEdRu7fmNs59ilpfOS2PzttfdTPmXtcJp5eEFO m+oMZAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C5B494B34AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23620-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The ->curve_oid check in ecrdsa_param_curve() rejects the valid enum
value 0 (OID_id_dsa_with_sha1), but look_up_OID() returns OID__NR on
lookup failure. Compare ->curve_oid with OID__NR instead to ensure that
only unknown OIDs return -EINVAL.

Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/ecrdsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
index 2c0602f0cd40..0cd7eb367604 100644
--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -145,7 +145,7 @@ int ecrdsa_param_curve(void *context, size_t hdrlen, unsigned char tag,
 	struct ecrdsa_ctx *ctx = context;
 
 	ctx->curve_oid = look_up_OID(value, vlen);
-	if (!ctx->curve_oid)
+	if (ctx->curve_oid == OID__NR)
 		return -EINVAL;
 	ctx->curve = get_curve_by_oid(ctx->curve_oid);
 	return 0;

