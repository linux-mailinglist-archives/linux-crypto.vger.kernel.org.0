Return-Path: <linux-crypto+bounces-23589-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OKoNxY382lgygEAu9opvQ
	(envelope-from <linux-crypto+bounces-23589-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2026 13:03:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B34A1372
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2026 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFC6D3036093
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2026 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10983C65FE;
	Thu, 30 Apr 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WeyUfWxR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F63E51C9
	for <linux-crypto@vger.kernel.org>; Thu, 30 Apr 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546962; cv=none; b=EZvoomK4mkB+NKsQKtfKU2S1FCNJlPzhuJOxzDpzf/sLKi8RRoJx/rneovknGOBsBUj0EYM0/ryBi/91uwOT9IgzQuCJZB2FgFV05AAgqgYZXJ0++Wj54qTBFh8tj1juKsGiPqMZ4Hzp4GK8f9WlMcuXtrCHN8Lv6VK6LoqNg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546962; c=relaxed/simple;
	bh=aoJSJuihLA9P+OZ3rpdOiSQXCyYtBxYq1IF+637Tio4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8TiTLqUOy1uxLv0cRgQSgm0NqhWq3OfZgkNE5ks4mx+/pvpfthooUaM+N8sb+pgy1TRpNgtNYMp+TDtA8jaPoXHlbGOFvM/Oh7aqT7s1YwwLSwBClm6ErZdJltCvo5yKoo9Gm/MjYeXyZciFuKA3v3MxTdc6LMo9iZ+kDSJdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WeyUfWxR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777546946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k/Ax3rJzZx6lwyaackm0hVg0xDKQ2TzRvxu8b0FYoMQ=;
	b=WeyUfWxR8sazSyxj94kQ+GmLZC21QuDumSZn6toXXehwwvrg7ENO0tWOU8aJJ3RDR2lM2P
	xgwoZ3eYwCKoirb3KneS/Fv7r9uj1GnOjLiu9kQJ/nm7bfWrzKNf3y6ajVJgwGmknHUCZs
	bJD0VSJnUWmUfWGEQtIgNunzJ0I7DYU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 1/4] hwrng: core - drop unnecessary forward declarations
Date: Thu, 30 Apr 2026 13:00:48 +0200
Message-ID: <20260430110047.248825-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=thorsten.blum@linux.dev; h=from:subject; bh=aoJSJuihLA9P+OZ3rpdOiSQXCyYtBxYq1IF+637Tio4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmfzeL//PMrEd3WOWebwf53IZMNrWfvfXDmVczf+TI/t i0+ve3Yw45SFgYxLgZZMUWWB7N+zPAtrancZBKxE2YOKxPIEAYuTgGYyIkqhr9SNfGyWl87hNaW /uxm2ixr8frWt0u/Sh5OeR/7VaamaH0jwx+u75UbIp6fzLVLOt8zNfCOvLiPE5P7/Ms+fv2XKk1 5zZkB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5F4B34A1372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23589-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The forward declarations for drop_current_rng() and rng_get_data() are
not needed - remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/hw_random/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index aba92d777f72..68add1a97f31 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -54,13 +54,9 @@ module_param(default_quality, ushort, 0644);
 MODULE_PARM_DESC(default_quality,
 		 "default maximum entropy content of hwrng per 1024 bits of input");
 
-static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
 static int hwrng_fillfn(void *unused);
 
-static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
-			       int wait);
-
 static size_t rng_buffer_size(void)
 {
 	return RNG_BUFFER_SIZE;

