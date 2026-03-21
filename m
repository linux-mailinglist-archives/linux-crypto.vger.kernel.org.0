Return-Path: <linux-crypto+bounces-22208-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BgAKN2ZvmlPUAMAu9opvQ
	(envelope-from <linux-crypto+bounces-22208-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 14:15:09 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F972E5734
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 14:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75808301C11F
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7C381AEA;
	Sat, 21 Mar 2026 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IeoP5H2T"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8337B3EC
	for <linux-crypto@vger.kernel.org>; Sat, 21 Mar 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098905; cv=none; b=kQPWS2Z1Va5MRdgMDRnZ/NzfM9HjFmE4mTp40CFxvR8E2AdbCIPzZA2gg4nZ5f6Tvny4vlrvnpDZDlESI2c+mR3eLIWcKKFF4MLaYKMolPMDck3KfuIbVmkX7JOugthMrmkx17HYkB6PiErEeS25X/5HX2S9k8Ju3FIS7nXcul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098905; c=relaxed/simple;
	bh=1zI5fPdz25kWkBIW3VERqBrEGo7EvgTLrs8+vxPbUZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ek0TpthRo2/sfs+S0rf4XOk/oX2BO66n7EYlDEMbU4mYylw4s17YZazElRAh29aLyAQhzF0k55ZYZXUhmZ6fRMTeZfgH50c16wR8vN8bS/qnOIpV6mldomUJQ9V7GePb0tMZKjo8mAZsG7oI1YXbAFC1QQfc2LA3yGdXOGneu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IeoP5H2T; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774098899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPZKYTEDgsQC6ilCDUzMflkaNztJ4ppVzWWza0vSIXA=;
	b=IeoP5H2TWFAViOquiyE8phrjpMdAk4aLsVh0mCMEowXe+jZ5Ht7pB2wYyutngWTEokYTRs
	Xd3SCrnzqYQQd4hYb0URWhxGVxsjEK2+TERjotbB1/za6b7zK3PmJSAWGXT17Y3os5jKZS
	y9XvEl50S+Lf8yqUNhdRczpa//gKjJ0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qce - use memcpy_and_pad in qce_aead_setkey
Date: Sat, 21 Mar 2026 14:14:39 +0100
Message-ID: <20260321131439.40149-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=thorsten.blum@linux.dev; h=from:subject; bh=1zI5fPdz25kWkBIW3VERqBrEGo7EvgTLrs8+vxPbUZo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn7Zu5v3SR/SGDijtNfjV2fdK0QlJ5xdmvilyNCuw6os vrEd3+e0FHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATSfBlZJiXlVbtGK7SoDOn o6f1w4Nnc8MYltpyhz4xvvj7mtJ7fjFGhnmH84+EPJHOFjSLZ7gw8dL2XbzHny28MP/ZUd8zkwT ETzABAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net];
	TAGGED_FROM(0.00)[bounces-22208-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67F972E5734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace memset() followed by memcpy() with memcpy_and_pad() to simplify
the code and to write to ->auth_key only once.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/qce/aead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 846e1d42775d..425ee6703e3e 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -642,8 +642,8 @@ static int qce_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int
 
 	memcpy(ctx->enc_key, authenc_keys.enckey, authenc_keys.enckeylen);
 
-	memset(ctx->auth_key, 0, sizeof(ctx->auth_key));
-	memcpy(ctx->auth_key, authenc_keys.authkey, authenc_keys.authkeylen);
+	memcpy_and_pad(ctx->auth_key, sizeof(ctx->auth_key),
+		       authenc_keys.authkey, authenc_keys.authkeylen, 0);
 
 	return crypto_aead_setkey(ctx->fallback, key, keylen);
 }

