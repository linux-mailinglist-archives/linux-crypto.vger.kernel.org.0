Return-Path: <linux-crypto+bounces-24205-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDpoC7UECmqNwAQAu9opvQ
	(envelope-from <linux-crypto+bounces-24205-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 17 May 2026 20:11:01 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B9562E69
	for <lists+linux-crypto@lfdr.de>; Sun, 17 May 2026 20:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447713050F51
	for <lists+linux-crypto@lfdr.de>; Sun, 17 May 2026 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467B3CC33F;
	Sun, 17 May 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE33QWGz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014D3CC334
	for <linux-crypto@vger.kernel.org>; Sun, 17 May 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041224; cv=none; b=u8PayKOvEI1yMzRfjbY8L8FKY9Nu06kyaqmf2zRuXjIIz45V9MPh9mjZEiYU6p9wIJoUKAEjRMof3PV2fRJ31t0pcEuh+qNG7Rnwou163A3kvcuFRSPZVAlOmWswCmv+51kR+qFEJ42XwxZSYk/kK0R6ncoj/ebbuRRUMd1kwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041224; c=relaxed/simple;
	bh=3LM6h2aHFdhtzdJtTIft4eZwUciZz65DnEuEQv8YulQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6Sr4CSgwmTZY2n08aaDmW8ErFyE2WI9I9hp70+jxOGxNitSg0Lb2E5kvJL0cPLqLSVMD0xPy/MJjRFJkfENTqCSKVzuaAoVcr8Rdbq79iY5XiN6kqehQ3fHqN4rUwzxo7PLnlZlNIrNwH2bZXoadx1z1CJOhCP7NSuuP+tXipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE33QWGz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso3337755e9.2
        for <linux-crypto@vger.kernel.org>; Sun, 17 May 2026 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041215; x=1779646015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msTE632b5gRHZXchhXxhyfIjZMxg97RrD6+uOCX904A=;
        b=iE33QWGzcC7EIY8h++wi1AE7Sk3KKpj8uzUPUuola/BVmET7msXZy1cZ5fXgn5F3Rj
         c9Ik9+62Ul7z4vDqPBxWoGYNWozKuUwyKbpgyICh6DVVOweRCgL+MVlTbTNL19qRkHtq
         zzHAumWZGkc68OtlmnRWcluWWwbQTBijbyLAA+Bgu57+XCttUpdF2wBHKdE012M2iVPv
         bFNwtEun9yKpOmdbTiMEj7ETCP3wOL2CNUDjPZRSVNKMpKIjnBW5R3i8O+e6lIBs9Wqm
         Si8P7pYfATk7swU7u1qhp+kedk/zCwpTcROc9PQ0/Jzd2ZdG9gRE3I0dnM0SSp4bNf7m
         3MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041215; x=1779646015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msTE632b5gRHZXchhXxhyfIjZMxg97RrD6+uOCX904A=;
        b=YSadeBW/t6+odxthbJNKvBldjk+IFPL9+1XiFSKd+KvrkL80lver8FmcFZh9f2Bf/a
         7CTpy3EI8sRP88xtnAtCOxzdSCAYWik9GycmbpKFg55dgQWy2uxECJUheFzd0fPIrKju
         V1Jqto9xbNqtqbCTcdsryrzhUvlEJRmLG0L6qXs5MbVhk3Zu7EKXiIfAeLfuthCKP973
         sWOg+6WghlQ92FfJtAieoBKOf+Ze/thLTCwOBo55JIj/1Rg5R8ve55xEYIh9tomHXnmp
         RV6zXHlTHFxiHpTqarwEim36DQJVbzj91ujZBDVhxhH5pnqC/kFBA3GJ41wnRl8C5nsW
         jeBw==
X-Gm-Message-State: AOJu0Yy78y6ZlnUviBdD+hFHNQ/mIlfsO87UG2PyYaDNM4Lot5cC+Fnm
	+QosC8pf4pN3FlkHuVK7hAeQzLkpVbKJfV2JBbOoCX26v3EClO6cMuBB
X-Gm-Gg: Acq92OFuoINTEu5R+eV64jK+yTApMDSEcybsc3je/wovQJb2lt9kOGXO7V9csAVje3j
	0hySFNc3vd5QpGPOZU5y7M8Eyq5T4Bb9P08DjCgWSKDuD/kJAzAahbhjcsR2jmRjPrlN+oDZ6BM
	wNvgXrJAWYG4omJL/RD/3hTIx2TeyaF28DKFfmVDdfJ2QmyAp2Q647wWW7rgqEfZCG3+tQaFrsU
	M5apUqN/n94vlDK+Gf27hyc2Yrp8MWAi14nx0Jj42+BAyQ9nVKumBFTyQxQOop4i3cGT7xLJbvv
	2cbPRnSdOP5/Kl9SQbTpMNL9g/F6zuBzyyTCU1mr+3uaQJHc5hk1r6Gga3xZZNxc9HJ4bkIoPAi
	Z39Kk6z9UWNBDzHw4T48aZy3C/ZHAuc4n4ypyeAZ4UKdEOfpGQYMTuea2xPjI8+sTiazPsMwdMg
	UmGicv2P3oA5FFflMn5HxvegH6mvaaCB6c84g9X1Wv5yhLRsKh5xsdAsfv/AgxoDI=
X-Received: by 2002:a05:6000:4683:b0:45c:e615:56cc with SMTP id ffacd0b85a97d-45e5c5edef7mr5526552f8f.7.1779041214493;
        Sun, 17 May 2026 11:06:54 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm31766775f8f.34.2026.05.17.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:06:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: thorsten.blum@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH 07/12] crypto: atmel-sha204a - switch to module_i2c_driver
Date: Sun, 17 May 2026 18:06:34 +0000
Message-Id: <20260517180639.9657-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260517180639.9657-1-l.rubusch@gmail.com>
References: <20260517180639.9657-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 980B9562E69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-24205-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Action: no action

Replace custom module init/exit functions with module_i2c_driver() for
driver registration.

Update remove path to unregister the client from the shared I2C management
list before flushing pending work and cleaning up sysfs and hwrng
resources.

No functional change intended.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index cdfdcf2e43a7..613ed5e7b3f6 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -216,6 +216,8 @@ static void atmel_sha204a_remove(struct i2c_client *client)
 	struct atmel_i2c_client_priv *i2c_priv = i2c_get_clientdata(client);
 
 	devm_hwrng_unregister(&client->dev, &i2c_priv->hwrng);
+
+	atmel_i2c_unregister_client(i2c_priv);
 	atmel_i2c_flush_queue();
 
 	sysfs_remove_group(&client->dev.kobj, &atmel_sha204a_groups);
@@ -246,19 +248,7 @@ static struct i2c_driver atmel_sha204a_driver = {
 	.driver.of_match_table	= atmel_sha204a_dt_ids,
 };
 
-static int __init atmel_sha204a_init(void)
-{
-	return i2c_add_driver(&atmel_sha204a_driver);
-}
-
-static void __exit atmel_sha204a_exit(void)
-{
-	atmel_i2c_flush_queue();
-	i2c_del_driver(&atmel_sha204a_driver);
-}
-
-module_init(atmel_sha204a_init);
-module_exit(atmel_sha204a_exit);
+module_i2c_driver(atmel_sha204a_driver);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_DESCRIPTION("Microchip / Atmel SHA204A (I2C) driver");
-- 
2.53.0


