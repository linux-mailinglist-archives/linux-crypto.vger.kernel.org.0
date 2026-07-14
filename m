Return-Path: <linux-crypto+bounces-25970-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AWCgCuU3VmqW1gAAu9opvQ
	(envelope-from <linux-crypto+bounces-25970-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 15:21:41 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 975ED755060
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 15:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25970-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25970-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F6D322857E
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Jul 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C346AF04;
	Tue, 14 Jul 2026 13:14:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616C39E9D5;
	Tue, 14 Jul 2026 13:14:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034899; cv=none; b=gKPeFuEZGO2z6d9FJ4VWnjQ+jNNsuz6yZzCBbsxyeJHdUNKV8IerGVEWTOcRnpgumjkO1ilhtj7moUPsbYtdVKqUZRILQ/ZRqADVs+99w3/b5868yyrOo/AmqGc7Wuq24pK7XPnEocJPjt7gjbPrfdnQ0P0ma35sap4LWSiU5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034899; c=relaxed/simple;
	bh=nmqSIws7vRX2EW/5LLslQG2OckXHaoREys/JVj1PNP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2dhNwyhQ05dH5+DVKx4lUmPFOXvSygZfqtrRTSfE2Od5aCLKkKUGoovWR0ykhGHs1Sw0+eV/I9i3iYbMhzRj8mUq3T5TnO7KvLKP1gxdaIVbxkNOROqCqqCEsVlw3Ty0TotR3WY+MLOwqQVr5senLwFmMYvX6DY/Kkn8updTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: fd849fea7f8511f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a1f9f766-12f5-4770-b95e-ebf84a740619,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:e507974033cd6dc90fac44063ad26dab,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fd849fea7f8511f1aa26b74ffac11d73-20260714
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1837002741; Tue, 14 Jul 2026 21:14:48 +0800
From: Can Peng <pengcan@kylinos.cn>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	mgross@linux.intel.com,
	mikex.healy@intel.com,
	daniele.alessandrelli@gmail.com
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] crypto: keembay - publish OF module alias for OCS AES/SM4
Date: Tue, 14 Jul 2026 21:14:42 +0800
Message-ID: <20260714131442.153699-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25970-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER(0.00)[pengcan@kylinos.cn,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:mgross@linux.intel.com,m:mikex.healy@intel.com,m:daniele.alessandrelli@gmail.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengcan@kylinos.cn,m:danielealessandrelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,linux.intel.com,intel.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengcan@kylinos.cn,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 975ED755060

The Keem Bay OCS AES/SM4 driver has an OF match table wired to
.of_match_table, but does not export the table with MODULE_DEVICE_TABLE().

Although the match table lives in keembay-ocs-aes-core.o, that object is
part of the composite keembay-ocs-aes module.  Add the missing
MODULE_DEVICE_TABLE(of, ...) entry so modpost can generate OF module alias
information for OF based module autoloading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by the
platform driver, and the missing module alias publication.

Fixes: 885743324513 ("crypto: keembay - Add support for Keem Bay OCS AES/SM4")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/crypto/intel/keembay/keembay-ocs-aes-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c b/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
index 0e424024224e..68013fe43ec6 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-aes-core.c
@@ -1561,6 +1561,7 @@ static const struct of_device_id kmb_ocs_aes_of_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_ocs_aes_of_match);
 
 static void kmb_ocs_aes_remove(struct platform_device *pdev)
 {
-- 
2.53.0


