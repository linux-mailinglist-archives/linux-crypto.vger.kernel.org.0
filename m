Return-Path: <linux-crypto+bounces-24497-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJD3GiHiEGpqfAYAu9opvQ
	(envelope-from <linux-crypto+bounces-24497-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 23 May 2026 01:09:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C098E5BB5B8
	for <lists+linux-crypto@lfdr.de>; Sat, 23 May 2026 01:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FD9306A5C1
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01D3905F0;
	Fri, 22 May 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duIFNigS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886A3905F5
	for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490925; cv=none; b=aRVI/j2Vrw9NbILQQWJ8aGYRc7RVGmiDmEg4i0S1sEYX3MH3qj1IgsMz6ZHUBkJdTWmKVS+VE3M+XcX9SlabLu2qjD5zV3EGrHuzOeXrxEGeinQQUUjnUAs0MSKsiH091E7JiNohgJW+jxhW3tzugRDAhByiznBjNR5v8IaZc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490925; c=relaxed/simple;
	bh=cILOBnvDwNoAaw6TFLiy0E5sbUtN7dlvslPX/+r/UjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WG1inI3194Gx6HxH673M8yLYuY7gPEjJytqmVXQFVJj1mn6Dyf1UWmoc1NVPWfWfva3f8GnGD1pClCyOzztP5gm/VuBMIuupWsgVjBLDe5+LQ2HMxZMtMrRfgw9kykPl1rg+KB75bBZdbEEUeNuapAzIDo1zcHJeYB9EZVGOFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duIFNigS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so8930975e9.0
        for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779490916; x=1780095716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwP1TF7NDrWi/kVnVYhZYtclyhtFTXoBjciS6AkRDbs=;
        b=duIFNigSoup2krUBUJbT6rMT8q57BQWAUK7Z6Xgq20xRrQac4UA6llHwOLbdRqL27l
         rgAQiMXfh7LXQST2AjcwtyBSDlIdrYEqv+1yvVe/ITuVM+HdmZXjOyTewZJdqXCzFYYs
         EhmKTmWHbkCRjJJ/CiuGonxvih96VwAOQgAKH2WP4Ap9NQmAr267+ibkpHcnDgaw4tU9
         hflKsayDrJUonOvs8qdAZv4u1xkG2pvhdwQsV351OKuON6YPA64rXJfjPi+/tkpySI+o
         fnJnZJf6Xz1YQrtS8IivWQGVhze4553CXoK4iOCFmui+j+QmAWuFiRSdVxeHMcYfzWuh
         l6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490916; x=1780095716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwP1TF7NDrWi/kVnVYhZYtclyhtFTXoBjciS6AkRDbs=;
        b=Xtl+J14KaWsrwtiTU65QpARW1j3goWuMk+XsuMiNqTEdbbKHLwSZAnAhbs+FZ/ezgG
         MGPe//OResry3dH/UIN2b2kFsgPIyoElHxT2gNvdUadyFE86oufvroZoRkMRQtxwZ+Jg
         Y7bn/C17/2rbpj13RtmA0Aam6MQYNPSg3iMYMURVfrErLvwJkVt2gPk/hzMgkrudvEZC
         GCr9+VWDtCa+rR3jgQKa/oOYq+XPHADoSt9T3Gdye4GnkFQ8BJAVaMwHPkdSqBBZ3WRA
         3h3NZodEC6Qz+BxYEEIvoIYBPEchiRpJfLjR04CHYFRk7rpepuBSjt8zXQ7KQST39RUw
         hDuA==
X-Gm-Message-State: AOJu0YyFtTjTRZDYeWv4h2ybVh9NEM6hr5GtYiOsXozWPQca0dWGcL0A
	VbWbZMrJfWTdV654pRJhgM3/7g85YFxLC35mWkxP/kr7/qiaEDdttagc
X-Gm-Gg: Acq92OGc92OsDyMEQPSwF7KzfuT/GCN5t+3DXHTp0Gv2JAMu739XwEcCiv7pUkSBdqX
	7xjrBelo0sqY9QCjadBbHpouk4lZYnwxhLte1JzfZOpRbssuvNBW1OJIKgLHJpglnEGxt7YB5/v
	3Fn+IjbOFSltJl3P0Oy3LrYh6QgBQTTR7gb1Sqq/JAs8Kyio4RvGUAIqrGpL+pPeUYT0Xe+MqqR
	xvaDirZLO+2NCE96SsjMm1ZihY5sZ2OoT+h6772R6S3O2jiYCiw/A0G58mSs6bGkrgEedhqhbV9
	mB+nYb7j6sqLjDja72+03gYWdBxRV1qIiHjcEjAC0DU6gfvuFq43nz75cyOxeei20Dvqy/m/Nue
	4ipM9/3EXaSCdMIl7R83ExoBU14O9h+KF7I6VlOZmTUx4M7PX+rcm94A+2h5eu2v82jf2c4hCwN
	vCXzKEvSSAKD+kOTW1EPQSbBMf7XMJOq6by8OePMW7wCeM1KE9dMpbHvjWprJBEfDeMxDD1EFqZ
	Q==
X-Received: by 2002:a05:600c:8484:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-490428ce814mr38170445e9.3.1779490916058;
        Fri, 22 May 2026 16:01:56 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490456274ebsm67100265e9.15.2026.05.22.16.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:01:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: thorsten.blum@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	tudor.ambarus@linaro.org,
	ardb@kernel.org,
	linusw@kernel.org,
	krzk+dt@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v4 12/12] crypto: atmel-sha204a - switch to module_i2c_driver
Date: Fri, 22 May 2026 23:01:34 +0000
Message-Id: <20260522230134.32414-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522230134.32414-1-l.rubusch@gmail.com>
References: <20260522230134.32414-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24497-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: C098E5BB5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace explicit module init and exit boilerplate functions with the
module_i2c_driver() macro helper to simplify the driver registration
path.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 86a68f2a27e0..74f91e176713 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -257,18 +257,7 @@ static struct i2c_driver atmel_sha204a_driver = {
 	.driver.of_match_table	= atmel_sha204a_dt_ids,
 };
 
-static int __init atmel_sha204a_init(void)
-{
-	return i2c_add_driver(&atmel_sha204a_driver);
-}
-
-static void __exit atmel_sha204a_exit(void)
-{
-	i2c_del_driver(&atmel_sha204a_driver);
-}
-
-module_init(atmel_sha204a_init);
-module_exit(atmel_sha204a_exit);
+module_i2c_driver(atmel_sha204a_driver);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_DESCRIPTION("Microchip / Atmel SHA204A (I2C) driver");
-- 
2.39.5


