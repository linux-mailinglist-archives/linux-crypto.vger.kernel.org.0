Return-Path: <linux-crypto+bounces-24938-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UbpNMjYeJGp33QEAu9opvQ
	(envelope-from <linux-crypto+bounces-24938-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 06 Jun 2026 15:18:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4964D9A8
	for <lists+linux-crypto@lfdr.de>; Sat, 06 Jun 2026 15:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=J38yp16s;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24938-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24938-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C4C3020D78
	for <lists+linux-crypto@lfdr.de>; Sat,  6 Jun 2026 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3713AE1BC;
	Sat,  6 Jun 2026 13:18:08 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A003A1A35
	for <linux-crypto@vger.kernel.org>; Sat,  6 Jun 2026 13:18:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751888; cv=none; b=KZI64oShwGjQg42kKXL9e16PBN6wgBMuoW0pnE9PopXhCleMmGC4NSxRP60v5EcJQaPwacX0nyQfHx3WnlD3CyLG1bCTZmbGY/qH0UR5d6BFsye8ckwjTlEmb4G2IZjove0PrUnpX6VhzvPSFBosBLjxbHsHp6XotJNwbqvaNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751888; c=relaxed/simple;
	bh=bxiJ7ydWNjviwTvv7BK6XfpSQEPe+3QOJTVHTSTih8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBxDgVvPwNg9a75v2TAH0rnkCrgXxLiPRLlVJYroACj920Lky1IN07hnlgI3FG2VgSSr7oBUIb32W3P8v/eKQclk3OQrfPI/lWs+rxB4YhKuVCbYJH/+Q9FsZXE99XxyveZsk54jRGQ5o0zojPSbtDvdEOmwqEjO3jlTvT5Htr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J38yp16s; arc=none smtp.client-ip=91.218.175.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780751884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dAN9QoDN/aS6i/YFO52v0YwG/FbuUx8/Jx3OqvY1QBA=;
	b=J38yp16sI2AI7S3UGd8vwk74VuueaHEAuaoUv+X/nAUImps12By70yQPnNLvvEaafzNQuq
	zr2bRjXpBvT9DNt2QQe5W92Qu/zfAnGv5Qq/QRElkuzq3qH8pNkiYZx5CopEru2WxEAslT
	eAUyp7jDap1NCsb3GMzPM+hNVyWjeQw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: atmel - drop __maybe_unused from atmel_trng_pm_ops
Date: Sat,  6 Jun 2026 15:17:54 +0200
Message-ID: <20260606131755.10132-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=thorsten.blum@linux.dev; h=from:subject; bh=bxiJ7ydWNjviwTvv7BK6XfpSQEPe+3QOJTVHTSTih8M=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkqcsxXFHoZ5Pf+ac1mOCXMMW124cvbObcW/35emXArn NWFtfdyRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzE0JKRYeabSfM+7VC91v/+ hoCx5mXVuXdm/ln2yknqtRSPpUoinwojw5bgNTF+SmyXE6T//i9v1jKZvbj5Ru2Cycem/YrJKTb 05wQA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24938-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:sakari.ailus@linux.intel.com,m:angelogioacchino.delregno@collabora.com,m:thorsten.blum@linux.dev,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19B4964D9A8

Since atmel_trng_driver keeps atmel_trng_pm_ops referenced and pm_ptr()
uses IS_ENABLED(), which allows the compiler to optimize away unused
variables, drop the redundant __maybe_unused annotation.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/hw_random/atmel-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 6ed24be3481d..10082add0886 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -186,7 +186,7 @@ static int __maybe_unused atmel_trng_runtime_resume(struct device *dev)
 	return atmel_trng_init(trng);
 }
 
-static const struct dev_pm_ops __maybe_unused atmel_trng_pm_ops = {
+static const struct dev_pm_ops atmel_trng_pm_ops = {
 	SET_RUNTIME_PM_OPS(atmel_trng_runtime_suspend,
 			   atmel_trng_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,

base-commit: 79bbe453e5bfa6e1c6aa2e8329bfc8f152b81c9b

