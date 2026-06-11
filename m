Return-Path: <linux-crypto+bounces-25060-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NBZCDl5mKmr4ogMAu9opvQ
	(envelope-from <linux-crypto+bounces-25060-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:40:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 459DC66F748
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DCtTJymI;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25060-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25060-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8283D301FB0D
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7643B8BD9;
	Thu, 11 Jun 2026 07:37:08 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBE3BADB7;
	Thu, 11 Jun 2026 07:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163427; cv=none; b=GUFwClMv9SQJ47yAYljXScwKoPcPLz0YT1atFEn4sXAkOTWPTthT8/ZWpzq8FtW9CyOgblE86nkY4CsiszaAvWUBcrpqVC7k5zyAd1aYSiKtg1WT1c/0RObT37BWfR1s76sia0ZuRVBl8aQQJeUKMZSFYXx3Vsd7oMl4cKOBpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163427; c=relaxed/simple;
	bh=SK4R1wkRudsJALTEbXJa0wGjEhBmNwxrT9yiRS3QoaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxeDSUvQC6an+tNfIGglskOCInObQf03dTVs3vFbUWWA3OLu4oTmmNn79GJImlXIExiOlHhw/WEYCKMkBlwOvySKYpPRqOgUZCnOWKleJYAa7Yvtyg8/M2FDHVd+XGkXjeSY0QFc+iH5O1fROsur3oK8UKfX/P/6QMB/9rgZ2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DCtTJymI; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F4025C49F68;
	Thu, 11 Jun 2026 07:37:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7D885FF03;
	Thu, 11 Jun 2026 07:37:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F1A8106B9E5E;
	Thu, 11 Jun 2026 09:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781163422; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ow2Cxrdwc88th7EZd0b3eAv0efoe5h+5PTN9hZq0PKY=;
	b=DCtTJymIJikjEoMBVks/XwDIqSI0MOjNGKLy+O0vnKqMeU9tIdz1AfQzVRrqAdPRDPpBxL
	nomm5QzZ8tjYQVJv03zUPyD+0f83hmrjUCc22QTlghKXLhW+LL1ddB/dYOhRzlGanymeF+
	Yciyq/lQ33bGeAK87sJK48do0pnQmZxAqpQvPP7qGVwya6NDC3jC0Tl+Pz2C5dv5qeW955
	vbEuy1pcmedDUsRogIcvJWlw6w3o60/nq4V/TYW/fGT8Aaqg3p9Z5z5tHD1Ta/Lz69nb6J
	n7yAuzruD/zXQynTG37gCo8YkzRmLW+ZPA1tmJqugJXpwj3reuy0TfKm8xQ0FQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 11 Jun 2026 09:36:13 +0200
Subject: [PATCH v2 19/19] crypto: talitos - Remove TALITOS_DESC_SIZE macro
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-7-1-rc1_talitos_cleanup-v2-19-aa4a813ce69b@bootlin.com>
References: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
In-Reply-To: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, linux-crypto@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781163398; l=3411;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=SK4R1wkRudsJALTEbXJa0wGjEhBmNwxrT9yiRS3QoaU=;
 b=WOjr8dKe8/57PHaqzA1YQi7Io+rKLmVD0D16hSS1ok3KlfvQSDt8YCI/zaiIyxieWS+/C9d8K
 oYyFvSrG2nJDYh7/qtfvk1aLxTqbGAiGpnEBzWfECHOOE6qsMJWnyl/
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25060-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:thomas.petazzoni@bootlin.com,m:herve.codina@bootlin.com,m:chleroy@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paul.louvel@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 459DC66F748

Now that TALITOS_DESC_SIZE is simply sizeof(struct talitos_desc) with no
arithmetic, the macro is useless. Replace all occurrences with the
underlying sizeof expression and remove the macro.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos/talitos.c | 16 ++++++++--------
 drivers/crypto/talitos/talitos.h |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/talitos/talitos.c b/drivers/crypto/talitos/talitos.c
index 1221eb9497fb..7faf3c2606a9 100644
--- a/drivers/crypto/talitos/talitos.c
+++ b/drivers/crypto/talitos/talitos.c
@@ -166,7 +166,7 @@ static void dma_map_request(struct device *dev, struct talitos_request *request,
 	if (is_sec1()) {
 		while (edesc) {
 			dma_desc = dma_map_single(dev, &edesc->desc.sec1.hdr,
-						  TALITOS_DESC_SIZE,
+						  sizeof(struct talitos_desc),
 						  DMA_BIDIRECTIONAL);
 
 			if (!prev_edesc) {
@@ -179,7 +179,7 @@ static void dma_map_request(struct device *dev, struct talitos_request *request,
 			prev_edesc->desc.sec1.next_desc = cpu_to_be32(dma_desc);
 
 			dma_sync_single_for_device(dev, prev_dma_desc,
-						   TALITOS_DESC_SIZE,
+						   sizeof(struct talitos_desc),
 						   DMA_TO_DEVICE);
 
 next:
@@ -188,7 +188,7 @@ static void dma_map_request(struct device *dev, struct talitos_request *request,
 			edesc = edesc->next_desc;
 		}
 	} else {
-		request->dma_desc = dma_map_single(dev, desc, TALITOS_DESC_SIZE,
+		request->dma_desc = dma_map_single(dev, desc, sizeof(struct talitos_desc),
 						   DMA_BIDIRECTIONAL);
 	}
 }
@@ -258,7 +258,7 @@ static __be32 get_request_hdr(struct device *dev,
 
 	if (!is_sec1()) {
 		dma_sync_single_for_cpu(dev, request->dma_desc,
-					TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+					sizeof(struct talitos_desc), DMA_BIDIRECTIONAL);
 
 		return request->desc->sec2.hdr;
 	}
@@ -270,7 +270,7 @@ static __be32 get_request_hdr(struct device *dev,
 		edesc = edesc->next_desc;
 	}
 
-	dma_sync_single_for_cpu(dev, dma_desc, TALITOS_DESC_SIZE,
+	dma_sync_single_for_cpu(dev, dma_desc, sizeof(struct talitos_desc),
 				DMA_BIDIRECTIONAL);
 
 	return edesc->desc.sec1.hdr;
@@ -282,17 +282,17 @@ static void dma_unmap_request(struct device *dev,
 	struct talitos_edesc *edesc;
 
 	if (is_sec1()) {
-		dma_unmap_single(dev, request->dma_desc, TALITOS_DESC_SIZE,
+		dma_unmap_single(dev, request->dma_desc, sizeof(struct talitos_desc),
 				 DMA_BIDIRECTIONAL);
 		edesc = container_of(request->desc, struct talitos_edesc, desc);
 		while (edesc->next_desc) {
 			dma_unmap_single(dev,
 					 be32_to_cpu(edesc->desc.sec1.next_desc),
-					 TALITOS_DESC_SIZE, DMA_BIDIRECTIONAL);
+					 sizeof(struct talitos_desc), DMA_BIDIRECTIONAL);
 			edesc = edesc->next_desc;
 		}
 	} else {
-		dma_unmap_single(dev, request->dma_desc, TALITOS_DESC_SIZE,
+		dma_unmap_single(dev, request->dma_desc, sizeof(struct talitos_desc),
 				 DMA_BIDIRECTIONAL);
 	}
 }
diff --git a/drivers/crypto/talitos/talitos.h b/drivers/crypto/talitos/talitos.h
index 2e2414ad1e03..6b9ce69daed4 100644
--- a/drivers/crypto/talitos/talitos.h
+++ b/drivers/crypto/talitos/talitos.h
@@ -78,8 +78,6 @@ struct talitos_desc {
 	};
 };
 
-#define TALITOS_DESC_SIZE	(sizeof(struct talitos_desc))
-
 /*
  * talitos_edesc - s/w-extended descriptor
  * @bufsl: scatterlist buffer

-- 
2.54.0


