Return-Path: <linux-crypto+bounces-25646-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vb9dBkvHS2p1aAEAu9opvQ
	(envelope-from <linux-crypto+bounces-25646-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 17:18:35 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B22FE71279A
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 17:18:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CqvbK4Rs;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25646-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25646-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F21C3222EBB
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jul 2026 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF4383C9F;
	Mon,  6 Jul 2026 15:04:34 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E263822B5
	for <linux-crypto@vger.kernel.org>; Mon,  6 Jul 2026 15:04:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350274; cv=none; b=iqfcDigOMOJAZ8C0Pp78cM/w5qLGC25oR4yS0/Xfqdu1lH+GLo0jeE1B+VO9/gY5h0p8PmMaY7rocWOOCxFYFosi3/CvEz8b+Y15P2GA4441qzscSLgwKDdYx7q2F3FLX8po6qsgJI0Vtp8GTI6vsLlGBvmrOm4H4XP2VKCMLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350274; c=relaxed/simple;
	bh=zBBXMLoE2TCrYVlVYb7oomLt3VwpY4MdVgmSJC4X9mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMiAj/pRs2xlCUO9WmhFdXqZmJrp8ixcZadL6IvHE+AWYSln6D/iE9BSsBHCR8pTYrHQsAVd/gOH5EjvWJcv0QkMh5CXk+ZBG7egSOZfM6FWmVR27+5+cLbKFGceBkEOfWp5u4tPEA+tPfw3xGTwsi7nRzh1bGlHjneP5Dauwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqvbK4Rs; arc=none smtp.client-ip=95.215.58.186
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783350270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6HV0b9sMqpNpq1FfedKJ4S6F9IUmh8TP/Cz/DVk+Z8=;
	b=CqvbK4RsoLH4/qwbrNeD/+kj7DtLkFYfI2qQVdUTkbDqsXWUMTPI40+DMQQWXgTEejqTVi
	qVYccIxhasI50UJTlcWRLRlXdymBdSNqUB3vUY1fKh+4KLPVDvsf1ZqZGINdhivXikamOC
	97xHasVYHVdgyVn3pELcYwf11RqI0QU=
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
Subject: [PATCH 4/4] crypto: atmel-tdes - drop redundant if check in crypt_dma_stop
Date: Mon,  6 Jul 2026 17:04:08 +0200
Message-ID: <20260706150404.382209-8-thorsten.blum@linux.dev>
In-Reply-To: <20260706150404.382209-5-thorsten.blum@linux.dev>
References: <20260706150404.382209-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=thorsten.blum@linux.dev; h=from:subject; bh=zBBXMLoE2TCrYVlVYb7oomLt3VwpY4MdVgmSJC4X9mE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFneh58WTfte9mhFGNt05c7trExqD+UnLX6R4GLk7x9fI LFb4Uh6RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEIYaRYVLQOQ+G7Qw1jB/9 z27df4uN4xfnzI2TNLd9OBNwM7Yys4qR4YZp2+kC7xhfnxcnvmy6kSV4p/VE0c8TGZ+2Fk9dP+G 7Jz8A
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25646-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:thorsten.blum@linux.dev,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B22FE71279A

The call site already checks dd->flags & TDES_FLAGS_DMA before calling
atmel_tdes_crypt_dma_stop(). Remove the redundant check, return early on
error, and drop the now-obsolete return variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-tdes.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 00a0b9694a26..208910d0d08d 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -601,28 +601,25 @@ static int atmel_tdes_handle_queue(struct atmel_tdes_dev *dd,
 
 static int atmel_tdes_crypt_dma_stop(struct atmel_tdes_dev *dd)
 {
-	int err = -EINVAL;
 	size_t count;
 
-	if (dd->flags & TDES_FLAGS_DMA) {
-		err = 0;
-		if  (dd->flags & TDES_FLAGS_FAST) {
-			dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
-			dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
-		} else {
-			dma_sync_single_for_cpu(dd->dev, dd->dma_addr_out,
-						dd->dma_size, DMA_FROM_DEVICE);
-
-			/* copy data */
-			count = atmel_tdes_sg_copy(&dd->out_sg, &dd->out_offset,
-				dd->buf_out, dd->buflen, dd->dma_size, 1);
-			if (count != dd->dma_size) {
-				err = -EINVAL;
-				dev_dbg(dd->dev, "not all data converted: %zu\n", count);
-			}
+	if  (dd->flags & TDES_FLAGS_FAST) {
+		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
+		dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
+	} else {
+		dma_sync_single_for_cpu(dd->dev, dd->dma_addr_out, dd->dma_size,
+					DMA_FROM_DEVICE);
+
+		count = atmel_tdes_sg_copy(&dd->out_sg, &dd->out_offset,
+					   dd->buf_out, dd->buflen,
+					   dd->dma_size, 1);
+		if (count != dd->dma_size) {
+			dev_dbg(dd->dev, "not all data converted: %zu\n", count);
+			return -EINVAL;
 		}
 	}
-	return err;
+
+	return 0;
 }
 
 static int atmel_tdes_crypt(struct skcipher_request *req, unsigned long mode)

