Return-Path: <linux-crypto+bounces-24186-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dNYQGvtZCGrXkgMAu9opvQ
	(envelope-from <linux-crypto+bounces-24186-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 16 May 2026 13:50:19 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCB55B89E
	for <lists+linux-crypto@lfdr.de>; Sat, 16 May 2026 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0CF300DE39
	for <lists+linux-crypto@lfdr.de>; Sat, 16 May 2026 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA73D6CAD;
	Sat, 16 May 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c65nvH0U"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F533B4EAD;
	Sat, 16 May 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932215; cv=none; b=tbFylhMrSTEjE4qnLiDD7hLBMsAJeVjYGHzhcj/G6ZhC+Wu/SmOtjEw81ejpW0Bwph2Retenqeakr+ZFCS6BwzIldI70s2QQi1eZ6g+GdVZdNG4Dw5TFJL2kVdjAp2oP0mheOwVImk0D9UyuuxWA0eE112Fs9aewK4ponepWmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932215; c=relaxed/simple;
	bh=jWLYogHcOigEdl8KaQsNpK8HmSeN9DkcewI7FQ2DrA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6IgGjgaRmpaPYM+OFn2uQKUgRyfq+BS7LXogcZK3tSOGBZ2NZI5kPRpHvo7KHxHlCrOsb6xY7Y8zBvw00jWoDJtahTx4GLMgnzP6ijxytORm6tVClpkI0D9yfvJuO4XmDqSQNUy3YNJ2cVUsoTB22h+bexxwne33MSMYKSnYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c65nvH0U; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778932202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9FM0JSbWbDpP/vqiOdm3Us3P362uG/bjYNImhK8xzTg=;
	b=c65nvH0U6V76q6KRTi/w0ReWp8bE7Kn/XHOYUhGoVyIi9vvKrWKVPwCsDx2HbDiD+C4Ovx
	hnYQRqaBTTGELJ7EYuwIvZA5/YKD95X5paxek6aP4xCNipR82U4lEXO7wiQbhCCbBBNsxz
	qqp7uxPOWmZs9rWDUHIIXdJ+M1v2C5A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] crypto: drivers - remove of_match_ptr from OF match tables
Date: Sat, 16 May 2026 13:49:40 +0200
Message-ID: <20260516114941.741140-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=thorsten.blum@linux.dev; h=from:subject; bh=jWLYogHcOigEdl8KaQsNpK8HmSeN9DkcewI7FQ2DrA0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkckdfibvif/qKu9uXsMnU7z0da9rs/n3iqucT+W7++9 4GI+9FTO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi08MZ/pffl2+8EZJ6hC9s SbfQ6zUPvv3LXPdj6unMig6Z3APZz8oYGZorez+tn7hQt+Hh34LvfzpO773lrrStN+HHlx3NOTf Ce9kA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B9CCB55B89E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24186-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Drop of_match_ptr() because OF matching is stubbed out when CONFIG_OF=n.

Indent bcm_spu_pdriver.driver and its members while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/bcm/cipher.c | 6 +++---
 drivers/crypto/omap-des.c   | 2 +-
 drivers/crypto/qcom-rng.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 2bce15dc0aa8..240b40ae9cd6 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -4698,9 +4698,9 @@ static void bcm_spu_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm_spu_pdriver = {
 	.driver = {
-		   .name = "brcm-spu-crypto",
-		   .of_match_table = of_match_ptr(bcm_spu_dt_ids),
-		   },
+		.name = "brcm-spu-crypto",
+		.of_match_table = bcm_spu_dt_ids,
+	},
 	.probe = bcm_spu_probe,
 	.remove = bcm_spu_remove,
 };
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 149ebd77710b..43768323de75 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1111,7 +1111,7 @@ static struct platform_driver omap_des_driver = {
 	.driver	= {
 		.name	= "omap-des",
 		.pm	= &omap_des_pm_ops,
-		.of_match_table	= of_match_ptr(omap_des_of_match),
+		.of_match_table	= omap_des_of_match,
 	},
 };
 
diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 0685ba122e8a..150e5802e351 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -265,7 +265,7 @@ static struct platform_driver qcom_rng_driver = {
 	.remove =  qcom_rng_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(qcom_rng_of_match),
+		.of_match_table = qcom_rng_of_match,
 		.acpi_match_table = ACPI_PTR(qcom_rng_acpi_match),
 	}
 };

