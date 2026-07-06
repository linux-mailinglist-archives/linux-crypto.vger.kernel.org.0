Return-Path: <linux-crypto+bounces-25644-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oj6sM+HjS2q1cAEAu9opvQ
	(envelope-from <linux-crypto+bounces-25644-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 19:20:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B569713CB9
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 19:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=PDfBzBJV;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25644-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25644-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A10353C618
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jul 2026 15:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD43381AE9;
	Mon,  6 Jul 2026 15:04:30 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295937CD20
	for <linux-crypto@vger.kernel.org>; Mon,  6 Jul 2026 15:04:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350270; cv=none; b=GJkiEZFeE2lV+HZKQp94hurTS5NMFWp/FsYHKSoZho1o+kECP3ln+EBOFsKKa+3Hwd1Fm4fgMZx6WfTbv0r8n5FnEbSMlrAG5ApU4PuidStyCF99A1IDdH6fr3KyOYdYRsYScjy8CmZZPQaf7FmkwIpPk366Of3mAWKJIfNIjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350270; c=relaxed/simple;
	bh=a+Olt+ci13rqSPS4SJgJk85PDpEKmzQRJHhJh3LQqZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R98klHdN+hUouUl+qr5Ez0h9WzwmvXov0L/MDrHPCLfMdI+GZSyjMC0vKOgg5IggKhgKLB/aKMF2HvlrVe7fDM1QrgcToKbNn1Ly5mw/DesgXMlpQK5doeH5TzmshnXNP5gqle10mobhh3Wbxbzc7KYIxGZqhFwK9QTzWpPe8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PDfBzBJV; arc=none smtp.client-ip=95.215.58.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783350266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08VdG4udULNeeqwqKevnwBUl3foigbG9+JAc/3kbzIY=;
	b=PDfBzBJVr/NT3u5/jdEu4k+xyKsN3JEifzbluzANOAwmGRhpwsURnBGwtjtYXL5pLKIQgJ
	sZHi5IPp4c78HXjyJZxVjHdv4ryJJkE4nzTkK7jsuqN196hgyBHeX8n7NXgIvG8wGRDHDV
	mpzzVakBDcaBUynM/20/cTu6erhcC2Q=
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
Subject: [PATCH 2/4] crypto: atmel-tdes - use __get_free_page in buff_init
Date: Mon,  6 Jul 2026 17:04:06 +0200
Message-ID: <20260706150404.382209-6-thorsten.blum@linux.dev>
In-Reply-To: <20260706150404.382209-5-thorsten.blum@linux.dev>
References: <20260706150404.382209-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=thorsten.blum@linux.dev; h=from:subject; bh=a+Olt+ci13rqSPS4SJgJk85PDpEKmzQRJHhJh3LQqZQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFneh594p5wsixb/vbFsXUWdqv8jbZPLL951/zbVYnL8z MG0pnB7RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExklzXDH95oz1ldhdXKVUVq vZs/PZgx6/M2NYcw15mKM1w23JofnsnIcEfncG/ZkVdKE5lu1V38vumlWPnvtHIVa/+g+atZ5Zj qOAE=
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
	TAGGED_FROM(0.00)[bounces-25644-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:thorsten.blum@linux.dev,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B569713CB9

Replace __get_free_pages(..., 0) with __get_free_page().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-tdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index d9cc4f657481..32f0acae46e3 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -313,8 +313,8 @@ static int atmel_tdes_buff_init(struct atmel_tdes_dev *dd)
 {
 	int err = -ENOMEM;
 
-	dd->buf_in = (void *)__get_free_pages(GFP_KERNEL, 0);
-	dd->buf_out = (void *)__get_free_pages(GFP_KERNEL, 0);
+	dd->buf_in = (void *)__get_free_page(GFP_KERNEL);
+	dd->buf_out = (void *)__get_free_page(GFP_KERNEL);
 	dd->buflen = PAGE_SIZE;
 	dd->buflen &= ~(DES_BLOCK_SIZE - 1);
 

