Return-Path: <linux-crypto+bounces-25125-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NFgYHAMELmoGogQAu9opvQ
	(envelope-from <linux-crypto+bounces-25125-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 03:29:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2B6802D4
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 03:29:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Qqxs5KHA;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25125-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25125-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C7B301778A
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FE221DAE;
	Sun, 14 Jun 2026 01:29:37 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947D5695
	for <linux-crypto@vger.kernel.org>; Sun, 14 Jun 2026 01:29:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781400576; cv=none; b=IZp4DgaVEpgWvKkgC7O/POTUlt8FB4bVRhk2VPnjmkqv05nlpG0MZi1vE92iIx0QOxnZtNWQIt1KHEcf8/NnfdybN9mdAcuxNo+GZ7lnTtJQ+sVZjwt44zwJDapqqNiYAqOxdMQH1xh1k5NPigCsmpYEI62C0f74/+g8g4zkI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781400576; c=relaxed/simple;
	bh=8Xqny1EEKfsZnZAw6Hrvhi+5T9ULq1DfaQo6bF9at+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmoPnf2KQ4ceHjzQxLa/9T8xO9qJTEsk6JcOopVLNgrwHuQS4ijtewSZala8QRiA7vho4Vft/0bFYTk1MSU5aTL5FLSqXk8lyXwzp3fEXU51RNrf87Ak3IkZwUfCsiQqkoiEqeAKJbwpfKv7unVABPrEhEFkr0RYn6T2MXEGMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqxs5KHA; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1238005b3a.3
        for <linux-crypto@vger.kernel.org>; Sat, 13 Jun 2026 18:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781400575; x=1782005375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T/LwGPf7tdWkgxqKaa4uBL4QJA9LIGsy6E8GC0qjkg=;
        b=Qqxs5KHAZ317jRE4ev/Q6saa5VFnBIFujRC/twXeivPQqESNQscRE2uyUGgPZhujsw
         2lEK8PPLEDtWnDqjQsXgFCwXqpXxpM2vrr0Qli5kt/ORgnBDDNXriRYCGtVYIt7yvvUK
         YK9ROlnsh6F1wa9FiyAP9zO8kQxhKwp7ZuNDW95LcZgkwL14Kc7ou4yEjBxQcKAKWhw5
         +WbsQXQQZL2XSWx4RztGPulvDoanxupzf89y1vpnLf26yQ4HrOkuf+ZmytRK4IHgd1lx
         A5edk2HSbiLI44YLeQHVpY5z7LUev2k/P8/Y9Sy7F+rh+zoD3tk6cG79Fb0c0QUSVT8z
         681A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781400575; x=1782005375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T/LwGPf7tdWkgxqKaa4uBL4QJA9LIGsy6E8GC0qjkg=;
        b=rMXZ8y8Y6AOecUwyts/Hd+0mSvK81VAkuv1+X5IIhN8AE31XmehLEDeOKW7zv8Fbi7
         fVytYqrqO+HbntvPW6d3u7bcID623OwwFkLttORfAPFwnAlm8i0KLiJHeecOtW2Ga87b
         ne5oGWduYHEPMEYzsEB7hVZAXCr65TGJ15/DFpVky0t+Z51KWqs9j2ntct6NM25xKsqF
         nea2ze9kvXs+ln4rm3W+EMfkLs+eTbHnHEzLpvZhjrEUPfllBzmflp6NTv/PMWjmos5f
         ekhGWSERIChR96xecrrd6Qs/gfB+cd2p+oaw0oX+M6SMm8S502X+7+39rP2RpY5+t6qa
         XLzA==
X-Gm-Message-State: AOJu0Yxn+C7QiDDl03xe3Ei5NToawSMvIAWxkTsFiS4/p427IMgaMBOv
	ikL8pnEI1eoZW/D5hUV1deSELr+3YE7LRRuGwOV+q7GE3FGM7TzweJHe2VAQWg==
X-Gm-Gg: Acq92OFjoCzCpTNmO7nZ3eBP6ijG0bANCgjZSrrAYlX7rmarlUz+2WaEC/+oopF1u4b
	e1dXawC77Pt/kNDP0kJfmCqddmBNQ1N7nWqWGI23HOU9VHMRqev698k3cGWScCCo5K41ll7qYBk
	dkzICN1bcPYsOaUpHJSSSMUItiJ1Scx0qRLRFkji4r1t4bwsx93p/1DSdnIqnEs67bIVBwaNaOl
	NNHWxp7RiQ+tqghE8Rj1XEjv4rVrRMQhw7JLiLfl3TUrpQCr0JTmMwd6lpvNLaz8Im23aBxnoXw
	QvnR1VrN5dZNYLoApUhHga4L9zlvxARpcGRzefDgkALIxhcp5xtaDNTZz47NUuTliG5RgM+6cTe
	9eM0b1KRjTrqSaEN/blpP3nnZgpbY/JftC/BhrhylWbKQtJnyT5rBoF3I/2yhe6SUfk8JGAHei4
	0IEJEspBt+kuu4kjo+4Pq7ZcbJ3oypkQvUhGxJukuZZijXFAFtKPBNC+yanndKj6Anbb6ukuqUd
	XD+ZjuEHCD47D+po496F5qg4oxIuGM+S2c=
X-Received: by 2002:a05:6a20:549f:b0:3a2:7ef4:81d9 with SMTP id adf61e73a8af0-3b78405985bmr9960245637.44.1781400575025;
        Sat, 13 Jun 2026 18:29:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6e63:e53e:e773:8f84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665187371sm4771731a12.18.2026.06.13.18.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 18:29:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crypto: amcc: move ioremapping up
Date: Sat, 13 Jun 2026 18:29:17 -0700
Message-ID: <20260614012917.70772-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25125-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEA2B6802D4

There's no need for devm_platform_ioremap_resource() to be so far down.
In fact, putting it up allows direct return instead of having to goto
some branch. Also, remove the error message as the function complains
loudly itself. No need to duplicate.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 001da785af07..0271b5e4d923 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1251,6 +1251,10 @@ static int crypto4xx_probe(struct platform_device *ofdev)
 	if (!core_dev->dev)
 		return -ENOMEM;
 
+	core_dev->dev->ce_base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(core_dev->dev->ce_base))
+		return PTR_ERR(core_dev->dev->ce_base);
+
 	/*
 	 * Older version of 460EX/GT have a hardware bug.
 	 * Hence they do not support H/W based security intr coalescing
@@ -1286,13 +1290,6 @@ static int crypto4xx_probe(struct platform_device *ofdev)
 	tasklet_init(&core_dev->tasklet, crypto4xx_bh_tasklet_cb,
 		     (unsigned long) dev);
 
-	core_dev->dev->ce_base = devm_platform_ioremap_resource(ofdev, 0);
-	if (IS_ERR(core_dev->dev->ce_base)) {
-		dev_err(&ofdev->dev, "failed to ioremap resource");
-		rc = PTR_ERR(core_dev->dev->ce_base);
-		goto err_build_sdr;
-	}
-
 	/* Register for Crypto isr, Crypto Engine IRQ */
 	core_dev->irq = platform_get_irq(ofdev, 0);
 	if (core_dev->irq < 0) {
-- 
2.54.0


