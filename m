Return-Path: <linux-crypto+bounces-25946-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ej+AlqtVWqCrgAAu9opvQ
	(envelope-from <linux-crypto+bounces-25946-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 05:30:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16C750A54
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 05:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25946-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25946-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7CBC300E038
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ED32D0610;
	Tue, 14 Jul 2026 03:30:31 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB74346ACE;
	Tue, 14 Jul 2026 03:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999830; cv=none; b=LYEA9+08Uu5Eo1Jwhk6Mbt5UQHS19NioYBR6Dk83O3OQvJr6xEOZEJjqHfHRfRr3jRSSbWAmnnDJhs2xhgi6Reik/5gyELF3hpfhWzbuWv6a/Pje5YI0RuSxVuKL1TOMA7B7noKOn0cEdS//YsS9Up4HDsaN8CgnyEiU9NwgqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999830; c=relaxed/simple;
	bh=mmfe9gHLB7ePjJaWewz42odhVYbujfsWX2CtiAlM1cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7evGkZMLX6F5ZTLSu2d3Lu88kpm/IGALWC6Y4kYD4ca5N2Dwn4hS5Vc0rNHuv+T3jm11gfaoBL9Ir7PxubrsC+g/VgHtcUqJFeyjN6qlrZs4d0eZvXvUTKIDAk3fm0FV4vCv9VNt53HFJf5dnXr9NB1V3oItYhl7h4kz1qOLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 56a8479a7f3411f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:17f74601-b71b-4c08-b219-f95fcdb5c2e5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0383adb66ba4ddb5412cc554729f5811,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 56a8479a7f3411f1aa26b74ffac11d73-20260714
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1138076989; Tue, 14 Jul 2026 11:30:19 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] crypto: keembay - Initialize completion before requesting IRQ
Date: Tue, 14 Jul 2026 11:30:15 +0800
Message-Id: <20260714033015.367735-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25946-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lilinmao@kylinos.cn,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lilinmao@kylinos.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilinmao@kylinos.cn,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E16C750A54

kmb_ocs_aes_probe() requests the device IRQ before initializing
irq_completion. Once the handler is registered it can run immediately,
and ocs_aes_irq_handler() unconditionally calls complete(). An
interrupt in this window would therefore use an uninitialized
completion.

Initialize the completion before requesting the IRQ, as the sibling
OCS HCU and ECC drivers already do.

Fixes: 885743324513 ("crypto: keembay - Add support for Keem Bay OCS AES/SM4")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c b/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
index 8a8f6c81e010..4496f1e64adc 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
@@ -1602,6 +1602,8 @@ static int kmb_ocs_aes_probe(struct platform_device *pdev)
 	if (IS_ERR(aes_dev->base_reg))
 		return PTR_ERR(aes_dev->base_reg);
 
+	init_completion(&aes_dev->irq_completion);
+
 	/* Get and request IRQ */
 	aes_dev->irq = platform_get_irq(pdev, 0);
 	if (aes_dev->irq < 0)
@@ -1619,8 +1621,6 @@ static int kmb_ocs_aes_probe(struct platform_device *pdev)
 	list_add_tail(&aes_dev->list, &ocs_aes.dev_list);
 	spin_unlock(&ocs_aes.lock);
 
-	init_completion(&aes_dev->irq_completion);
-
 	/* Initialize crypto engine */
 	aes_dev->engine = crypto_engine_alloc_init(dev, true);
 	if (!aes_dev->engine) {
-- 
2.25.1


