Return-Path: <linux-crypto+bounces-21064-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eECkDGoInGnW/AMAu9opvQ
	(envelope-from <linux-crypto+bounces-21064-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 08:57:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F330172DC7
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1EAB300A8D4
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC8346E64;
	Mon, 23 Feb 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VW74dszo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626B34B697
	for <linux-crypto@vger.kernel.org>; Mon, 23 Feb 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833414; cv=none; b=iRihYICp194V3nkL4t3iLcrZqUiTMJSDspbus0OfEa+8IG3tRK1SkzqQgAMNUHloCCKXYEkC3uhGr7gtutlKpOIY7rnC6mWRxHf7ftajp+QkJ18px1VzbW+8fEJHiysdBvZcviFeh5peNWIc5g1nFzRh4sHvtNoTAIrT87n4kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833414; c=relaxed/simple;
	bh=XvMVcKt/0r5kRONtwpp+F4V3utNj6holEBQEssCg+K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnqgPBbar65VpYs3QqyyWJqWAd9ItWCNwV60hvL+LyDDD5gi6jYaqorF7eYp8fp3mJhpumjDh4vsjax7ikcW6GVFZuoAO0Tybtn7j4TAOg+RNlK27XeuuA3AepwMQBlEKErDm8uhG0qdijzKnn9ZNSyMuLEYXqfOe+6WQBm+ovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VW74dszo; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771833401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYwiN4nghP1kmo4cngG1gXKb6guI7kDWkrfEn3kS1Pg=;
	b=VW74dszoqQsBZNpnIOhwPwpcXqJhI2ECVeyVXvh1sO+KLaId3flNHdLGXo6CcvJNO/185n
	3S0Y7j6Y2ybD6amtsIWeZmsgOKoj3U+14hCRCIRH83R+S0RcEkrdO0B6tChT65WWB7YSDF
	2CeIpDFRJcxodknznYyexoC1hxG0+84=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: vmx - Remove disabled build directive
Date: Mon, 23 Feb 2026 08:56:12 +0100
Message-ID: <20260223075612.322388-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21064-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F330172DC7
X-Rspamd-Action: no action

CONFIG_CRYPTO_DEV_VMX has been moved to arch/powerpc - delete the
disabled build directive.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 322ae8854e3e..283bbc650b5b 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -38,7 +38,6 @@ obj-y += stm32/
 obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
 obj-$(CONFIG_CRYPTO_DEV_TEGRA) += tegra/
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
-#obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


