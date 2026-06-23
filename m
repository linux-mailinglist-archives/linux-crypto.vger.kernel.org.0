Return-Path: <linux-crypto+bounces-25324-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B1yyOeNHOmoT5QcAu9opvQ
	(envelope-from <linux-crypto+bounces-25324-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 10:46:27 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F66B55F6
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 10:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TGg4rBPA;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25324-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25324-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE66E300381E
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ACB3C417E;
	Tue, 23 Jun 2026 08:46:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30F342173
	for <linux-crypto@vger.kernel.org>; Tue, 23 Jun 2026 08:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204382; cv=none; b=R/WbXktjTkKSuCffStlsg6S6954QSZubMMDXyUlZShSBjLBKuRLnKr4fP9wyvnuLd9A9iwlr0uB6tc/TNSyQwQRr/1cK9WyReUpEBX0Jein50LwLsukivIuxV6GzENMhWZ6iNuSPyrJLGen+7/vxDF0h7ohUTYlr79kDRDfS6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204382; c=relaxed/simple;
	bh=4o8ok0rnKVg2FF7+5n9CsHSHW0m2RSdPHOd7yjSKWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZkTm/TIYbncqlVHLmtzHWc9a/hFcEUvPRR1LM9UyI3H0swW9Nk9rxmzTHbb3U+VO5CaTWZ+/LywmCRLwgUMcNXPoWpplAN+RVLW41omTMPazX6jst+MJFJEc379XSSZX6ESRQ3pATVu4sMvhJZvAVwx62u3tWGXTauuwgGwIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGg4rBPA; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so3037963b3a.1
        for <linux-crypto@vger.kernel.org>; Tue, 23 Jun 2026 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782204380; x=1782809180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwXW0gwjelQCHFK4iUQJDYmRzILj7IFNL62VaLXhyiA=;
        b=TGg4rBPAvnWPB2nCjwQTxyr9pygnJPo6KbkTUtJgkcxH9AylsMjAzpOAWqzX6BP1ny
         XQSP4TOLdiFPZMPVY/GDDZPp7Lgt5oSFcbS28F0IvEC8UmjZ8EGlb6S8PBWmZxRgiadN
         j1W+4UrQlQZ9zY6Yb2Mq49vh155eMhCir/0rUiaIoMkTx2Kti+sMZY9oo713oHhZnv33
         QKcTFun9fagzKGpx3tn1Z6WoFhW2clhhYVGdrBi8GjxBP4tvp4iTsyiAVqjuRur2+8al
         UX0qPFb4ZoNBv4C/K8JqBiwfoTFUNCA5ITa0ydmmcQ9k28x9+9oqsH2otfzqwmkPHcOb
         PSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204380; x=1782809180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwXW0gwjelQCHFK4iUQJDYmRzILj7IFNL62VaLXhyiA=;
        b=IlSysQL5+RP3xNTR4hN0yHhhRQm2XOwB4ApHPgfgfM4HmPavTZ9NQlRxXs1a7jfGKd
         H+6t81RcHesdHXc7RQAs6SXt+OvY/64kBPHYkK91AEqE7qcff8ibvy4TqwibidT7MENs
         dlrKoMMWSgFI601Lo2QAyoIzNCey6G1JFDQJYpGSbAonJT3EB7RwkQvioRL6UXngPXaC
         6DleZmNxpiih0yxq0hwPrm6RkbwMjp65JCXul2frnGthrhGAfMYNlrH+uDYkfmZfo9gn
         LJwsgibbEWFdt3BeXj+3nVQci2vkcitxXqALHHd6DG3G5cfP5+omgCwAvAB0fB+JIBjw
         YQLg==
X-Gm-Message-State: AOJu0YwrIP3MHmLkr4ZR+Uk7NRDIMF5AzVBi0rdqb+MJYoXoWcOTqzfT
	A1NSs7RUzarvu792Tu+/QZ79Fg6lq3DDocxZF7y43X3meqK38GPZ6Xo=
X-Gm-Gg: AfdE7ckp9pbbQ+Tj3ZalrSu0u4vM8zL/ZvEJFVUoxbxyCZP5FS75AVEw7IPJRw4ynzo
	1kQcKReu9LYFC8KZdBHfK60UR5Ph7l10ZnOuoPxvtswNBl95l7sbSW0quqHPi3piWP0LAlYt4wz
	wpKysaH9Y1TU2wzXdD1sscqpBnRka0aTqOwge0/452lc/7F/fXq+9e0KyXuQldjSiC7Efr8Ty2o
	SrrEy1jFlFmwx8sKd78yCmT10gLs3kmEtPk1yGZwrjIk9fK9xxtm5vAaeNMdhwavO9NXOrKsSQX
	UgCGa/91MAfAhhKRFoWuua7epo9f7yTsEX4T/KHJEqCzpEOlQOj8W9E9qhZZyC76wfiGbhynbX/
	OUGSEBHGvp16a0eB99zH/Pa13qN78RWkZbjYKwPodz7K6QSn1Pfa4w7400r1R5/PaL3Q/IRzhnF
	GGjH++PYtOL9c60827olbJ2a5naVPJN8G7gw+nagEVt9F0RDvv42AclpfXgLXTkRqF
X-Received: by 2002:a05:6a00:4fcd:b0:845:352a:a207 with SMTP id d2e1a72fcca58-84597125d29mr1927983b3a.34.1782204380278;
        Tue, 23 Jun 2026 01:46:20 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564da57a0sm11294151b3a.26.2026.06.23.01.46.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 01:46:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Deepak Saxena <dsaxena@plexity.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] hwrng: omap: Fix probe error path cleanup
Date: Tue, 23 Jun 2026 17:42:23 +0900
Message-ID: <20260623084612.58054-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25324-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsaxena@plexity.net,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3F66B55F6

omap_rng_probe() enables runtime PM before acquiring and enabling the
functional clocks.  Several later error paths returned or unwound without
undoing all state acquired so far.

If pm_runtime_resume_and_get() failed, the driver returned through the
generic ioremap error label and left runtime PM enabled.  If either clock
lookup returned -EPROBE_DEFER, the function returned directly and skipped
the runtime PM cleanup; the register clock defer path could also leave the
already enabled functional clock prepared.

Route these failures through the existing unwind labels so each path only
undoes resources that were acquired successfully.  Keep the resume failure
path limited to pm_runtime_disable(), and use the later labels only after
the runtime PM usage count or clocks have been acquired.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 61dc0a446e5d ("hwrng: omap - Fix assumption that runtime_get_sync will always succeed")
Fixes: 43ec540e6f9b ("hwrng: omap - move clock related code to omap_rng_probe()")
Fixes: b166be004491 ("hwrng: omap - Fix clock resource by adding a register clock")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/char/hw_random/omap-rng.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 5e8b50f15d..a8c0b3dfb1 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -455,32 +455,40 @@ static int omap_rng_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to runtime_get device: %d\n", ret);
-		goto err_ioremap;
+		goto err_pm_disable;
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (PTR_ERR(priv->clk) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_pm_put;
+	}
 	if (!IS_ERR(priv->clk)) {
 		ret = clk_prepare_enable(priv->clk);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Unable to enable the clk: %d\n", ret);
-			goto err_register;
+			goto err_pm_put;
 		}
+	} else {
+		priv->clk = NULL;
 	}
 
 	priv->clk_reg = devm_clk_get(&pdev->dev, "reg");
-	if (PTR_ERR(priv->clk_reg) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (PTR_ERR(priv->clk_reg) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_clk;
+	}
 	if (!IS_ERR(priv->clk_reg)) {
 		ret = clk_prepare_enable(priv->clk_reg);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Unable to enable the register clk: %d\n",
 				ret);
-			goto err_register;
+			goto err_clk;
 		}
+	} else {
+		priv->clk_reg = NULL;
 	}
 
 	ret = (dev->of_node) ? of_get_omap_rng_device_details(priv, pdev) :
@@ -498,12 +506,14 @@ static int omap_rng_probe(struct platform_device *pdev)
 	return 0;
 
 err_register:
+	clk_disable_unprepare(priv->clk_reg);
+err_clk:
+	clk_disable_unprepare(priv->clk);
+err_pm_put:
 	priv->base = NULL;
 	pm_runtime_put_sync(&pdev->dev);
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-
-	clk_disable_unprepare(priv->clk_reg);
-	clk_disable_unprepare(priv->clk);
 err_ioremap:
 	dev_err(dev, "initialization failed.\n");
 	return ret;
-- 
2.47.1

