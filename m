Return-Path: <linux-crypto+bounces-25424-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nxOVFbhBPmrUCAkAu9opvQ
	(envelope-from <linux-crypto+bounces-25424-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:09:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3726CB942
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 11:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e2xFVZ7S;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25424-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25424-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB3C30AFA44
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F23E4C70;
	Fri, 26 Jun 2026 09:03:54 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04B3BAD95
	for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 09:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464633; cv=none; b=idyFEzqyMP71hwvavXzV8kiaqhqbV7JRUIoIFGAEi10LY2fekY3ohEaImvMKzRi7W/eL1CAyKW3hHseg4VzTQaTyXY7WiEZb83borfGMH9uR6hH2Wm7yxU5XSqlG43UoOaNr9HYyW+OFAbmVmcarLs4+ZLuVLOSNDGi/1B8PY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464633; c=relaxed/simple;
	bh=XhFvV3Pst9OQZ0KTgYAScYpo3nLbmT7aSzDFADrNCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzwMDmCLnwR4RorG/lSffxgaW/Rr2P50CbjHMrCgzE9NaEFfEF/mQIFOoymW63TjOymUNtSwdXmZXV0M0FoCIUozIsJ1O/e+hrdb2/wxbb6BMJ9NdI4XBlq3BNpZv4Msc4uwcg8CdCzl+XKs050pMkMUCOK2h2VCZH3IHXZHLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2xFVZ7S; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so303214a12.0
        for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2026 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464629; x=1783069429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iknM7cswknxj4qdDnOVnIMU9meZwE3Gb+QzXsxgdJD4=;
        b=e2xFVZ7SjT2pUOlz32GWGFfm90J1BKUvyYRqjFB4gjsBrRNt/QEOYHssvC+pFBmFK6
         FUSl70iSiWDUeXhOKIZVX8W/potHzFySkirKiqsewN9D8yfmV0qzR6MxF5CxxcVj9Eda
         S36YyZ1MU5DgXz1guu7WdDc5NyVqIs0kstddbbz3Gaf7VqW0c5YXgi42Sh/J6wdlimoY
         zf1LWBVoPWnp025mV8PimuBhZHVL7WQUZEBVCTs1Hx9iRiAMDHBKodW7XfFL4+GsnF6h
         aOsXtAOrkpyJFbISzCItbqBn+7SAKUC61+U10ucj2jyNRWqRli+oGIF/+9YC5Nlub2W0
         HA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464629; x=1783069429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iknM7cswknxj4qdDnOVnIMU9meZwE3Gb+QzXsxgdJD4=;
        b=gRBY4OHsdMOj2rdFIbBG+LygwSFpVZVFsk/sGbvht1oe7IdbZg1lhV/+IJ+MyqtL/B
         WAFzMNiF0rQ2A68Q6W3MEK8suHLZfkcL69g/4WQCyDleti1h5GOuKYTY9HQH0gxw7X6C
         AkMyiV3KptQfuS6vniLOFZbqzPSEm/vStkNgu9gPPUNagRMGgLIOYuCgiYMvrdAUhGxO
         QWjvTJS2jwpgs+rIPStZ2G5WRRx7QD37/ujpqH0kebVvXpXTiFxJJgK0ur/vjMdOqcHf
         aDIuY3iE+KFqYHgS6x+1K98x0vHK+HQiXWPZztC0QWgsirtqXIrBcl8y57ajZtOmyyHK
         LXDA==
X-Forwarded-Encrypted: i=1; AHgh+RqVHcmsQUarPkGi49UyHil4igcZCzImyvUlwkBF8gJqc7j/aRkKFDV7CvU3ljzeKpckLjW755BWgWqZxA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVcuS/AQ1bgzSZefzKoX9Ur+T4jmyjco51n6hFT3ZizgE2FBu
	P1F9OodrznZ5Coc3HWQ2dY2PYH72q1EIxPyP6vHsOAhCTnmXDsHV4MMxx/E+
X-Gm-Gg: AfdE7ck+nF8UxqjGa1AikLXZw+noSMOAeM4tfOvBNeAD8Wi4cFuvVHyhc6gYPsXagri
	iSjtm9m0T8uX/QA7oVyt0dZlEUpzQW9Lfp0tHBFfZkHORKuEHD4ROFR9g7oodnCch9XzVgxzbB+
	AB0Dsg2PIADY4/uXCG9c19u/cYniH2oXMpVdlwpAafuCRGc8otj11W+HGnD9mSDQ1LL9dm/zBs0
	6TEE0mjl5ay4VXdCFJch+7HRXF0eYK5t/yb+cynbJxBogja2YXAelpZi7Mcyz22FGCWLsqz+QOy
	uzGariwUHtOqFq0UwFIcoT0cwbt2M54yAbJ4yTTiha+kfsfr6umJX+lRlbzkwdWOChZxKKYL0/M
	j0j6bHfG0u7/ssVuiHF6qBTh+wifnBHJ3LxhOnxUyTIa4CdIHz/nflT48l8qCbIg2e/XJcu6zFw
	NxedqDSpcdAJYhGmQ8ihsXWNiYe90R9hz73xRhdWVy0IO/RqTymXmu1TxinvzywSo9
X-Received: by 2002:a17:903:40ce:b0:2c7:e2bc:6705 with SMTP id d9443c01a7336-2c7fc9c1861mr61671745ad.23.1782464629059;
        Fri, 26 Jun 2026 02:03:49 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f6509ca0sm35075495ad.81.2026.06.26.02.03.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 02:03:48 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] hwrng: omap: disable runtime PM on resume failure
Date: Fri, 26 Jun 2026 18:02:13 +0900
Message-ID: <20260626090302.42134-1-mhun512@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[selenic.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25424-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsaxena@plexity.net,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC3726CB942

omap_rng_probe() enables runtime PM before calling
pm_runtime_resume_and_get().  If the resume call fails, the error path
currently jumps to err_ioremap and returns without disabling runtime PM
again.

Add a runtime-PM-only error label and route the resume failure through it.
The label is placed after the runtime PM usage-count unwind, so later
probe failures keep using the existing pm_runtime_put_sync() path while
this early failure only disables the runtime PM state that was already
enabled.

Fixes: 61dc0a446e5d ("hwrng: omap - Fix assumption that runtime_get_sync will always succeed")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/char/hw_random/omap-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 5e8b50f15dc3..44b8bb4a24a8 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -455,7 +455,7 @@ static int omap_rng_probe(struct platform_device *pdev)
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to runtime_get device: %d\n", ret);
-		goto err_ioremap;
+		goto err_pm_disable;
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
@@ -499,6 +499,7 @@ err_register:
 err_register:
 	priv->base = NULL;
 	pm_runtime_put_sync(&pdev->dev);
+err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(priv->clk_reg);
-- 
2.47.1

