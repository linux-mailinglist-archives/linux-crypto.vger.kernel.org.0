Return-Path: <linux-crypto+bounces-23742-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IE6Efe8+WmTCwMAu9opvQ
	(envelope-from <linux-crypto+bounces-23742-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:48:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F34CA1B1
	for <lists+linux-crypto@lfdr.de>; Tue, 05 May 2026 11:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 581E1301069A
	for <lists+linux-crypto@lfdr.de>; Tue,  5 May 2026 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9A2BDC26;
	Tue,  5 May 2026 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qt+qAZWt"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2623E334
	for <linux-crypto@vger.kernel.org>; Tue,  5 May 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974410; cv=none; b=FZ0Q9AtAbSlWok32ljEaursDa9JR8pjYawF8/jQ9Zc6WyaGMNzMwn92O5WQzLHuN28y75YSHXCiuLwTzbZVeOfXS+f1CZ4bANxCmVN8v80esSd8tbGQUCGb59uPCT3XAH2vlVUEygEzXwwqCmkeWTZdSG2UXAdevBSuz0RnksJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974410; c=relaxed/simple;
	bh=gFOw2tThy9bgsiR8LqWtBtta1Ualj50A2DKlZ/LLw64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dlzp7W7hf6rkowOGZdfolLB1vfIaZxZdy23EVT8LmJSoN/rs4fziWTUuq+DCs7OKLr/AaRfW67qLSv+iYLKzPZ5VerGimT7qLjlf9kMzy7rKslFlCJzPQbk7K1X1Y3YofOeq7TbewsgsZ55PqWK8RHZ3PxfCVffWHcg+InDOucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qt+qAZWt; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777974406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP7jDOLWVS/DWQTa7LHGUtGZd36355/h8hhtTJBgQ0A=;
	b=qt+qAZWtvl1rk70AKwdR/MqJVXVx7kgWN7oEehVRD06zr1D8zor5OHHXMv6EZencOmVlrO
	W9Y8ml8STjWklBNHJ/WsQrTsufSQtu0Q3NoEmfTyhDijLZNRX+lzyLliI8wDilj+ElyBcZ
	uVTE40tf69krPSVDj3uVwr70ldNK4Qo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Lianjie Wang <karin0.zst@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan McDowell <noodles@meta.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] hwrng: core - use MAX to simplify RNG_BUFFER_SIZE
Date: Tue,  5 May 2026 11:45:57 +0200
Message-ID: <20260505094555.158017-8-thorsten.blum@linux.dev>
In-Reply-To: <20260505094555.158017-6-thorsten.blum@linux.dev>
References: <20260505094555.158017-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=thorsten.blum@linux.dev; h=from:subject; bh=gFOw2tThy9bgsiR8LqWtBtta1Ualj50A2DKlZ/LLw64=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/90RvEZXYGbmo0CKxVsaX/1y+54myJHvBc7enqtXHv s3gW/Wuo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbydREjw01Gb8ET3ddjuSek v+b2Mvmw9lv5t29Wk80lNq6cGRvUf4nhf747c9e1fJeyYz4CQoLrFiz+9kb2bK7qGWOV4Mbcugp DHgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3E6F34CA1B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[selenic.com,gondor.apana.org.au,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-23742-lists,linux-crypto=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Replace the open-coded variant with MAX().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Drop the explicit include as suggested by Herbert.
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 870e77c9ec20..26c46cd90a83 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -30,7 +30,7 @@
 
 #define RNG_MODULE_NAME		"hw_random"
 
-#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+#define RNG_BUFFER_SIZE		MAX(32, SMP_CACHE_BYTES)
 
 static struct hwrng __rcu *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */

