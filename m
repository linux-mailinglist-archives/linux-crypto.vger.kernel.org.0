Return-Path: <linux-crypto+bounces-24327-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC24MhXODGpMmQUAu9opvQ
	(envelope-from <linux-crypto+bounces-24327-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:54:45 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50800584EA0
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CBE30F8178
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F123BFAED;
	Tue, 19 May 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd8igZkI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB63C1F26
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223708; cv=none; b=XP/IWpJCGdtNWGu40rOsSGMkk160Y4tjhMrg9VpZfECv+8DjvaITAjnb52ci1rhOxIMnbmRltQuTGSiJbtzwWYMEhwwGLCg16MYmC0vfAF67z4ystFSoqE59lmAVQx50cICTnyJLeDxIwoXhf2GrZPdx86SWJZdAqAMxpzwQKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223708; c=relaxed/simple;
	bh=HcGNt0IMVlN/ojuZul68gyUXfj92IbH1U64eeoIpt3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4hWsw7lVSaOulU1Bq785B26GzEcRivRq23avsmtJY1sBxUit4hZSyV2tk5yjsv94Zkcpghx7lVcSjTSqDp+IcTaU/MrLPJhl1gD5UpyogoNeLXElgbPfZkwIK5Eh6IYXKX8NZh5cAK8SMlxXOc5rS10WDFuCwn2+QK5WJZG5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd8igZkI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7670826bso297569f8f.3
        for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223700; x=1779828500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dQdC9oLqGqR6Yemw3ngZxXH5nQjTXJGwmXiYcKTYls=;
        b=Pd8igZkIw9G8LfKTgHoNZlhYGcxeqABunGWVVA3e9CvynGho4AFCPd1Yxv9zm5Ix3V
         o8Al9G/QLCWWm6/SM0ffhJonYMoeiwEzHlPnFx/c/AgYlN4soKTd1Pm8btr7dRdH7rcK
         izsGdwxy+59l7mEsutOFBTLpSstnLFOx6vqjBD+39V+7TGcoSKotrwLcD4U+VIhlV4RM
         vgjCkjpwgTtyBDosOYXMfU/iSfA82+DNDtX8kILOgJb78xZzKIFajCVAMfwbrZtgI7X/
         Alp3aC9RRX8pvXta6XGnGg6bRLzkEFB/5PE9/WSP0P9E5j7gmyIdT4bY6YT8A0gKjsh2
         UdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223700; x=1779828500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+dQdC9oLqGqR6Yemw3ngZxXH5nQjTXJGwmXiYcKTYls=;
        b=LCJbWL0e+9CYHJMsNlhvPSLBop1XBrjoGIFn+8f1tlaSLTP5CIkJNxQxdBKItKVzxe
         03srQy+OrnRnh8qDS0w5bZkKd+U2FA1/n0AA1nOcV5lFMN8At1oB6ywsMiFwpAbG5Wid
         H2QplknoPqCN9t2z1QdI+ZhG7RcLnCYIHAzSRprgfFxwsG886pn6jpEVuiVIvyDedPZp
         9hIgkQ6wRb8S0SurDU2ayQSwVIUwNj4KClFVa+h0JEToc3FVi9sWeeUfLQNup/UDcFo1
         Pyv9VAhcsCQ3jDFslPS0NgXVdGUGBI92npMntmkxtN8ZsYJFNMgmYqZK3iT0+A42AUB/
         8vNQ==
X-Gm-Message-State: AOJu0YzN2nYKZDckQSi//hm+wKq6xx01jhkMbqM3TFuo2KzcfSmMS6Sl
	LILR/VYUu/Wy1+RXtWCYiYj3M4lvxYHfuACDLVndtc1h8aCEJy1cbPjD
X-Gm-Gg: Acq92OFwXDKG0TBk6LcEeTf5Pa3JabmytaZaiRSx2wpiBQOU583ZVzsVn5cFukGt7OG
	6QxD30U6tuBPPtyUdWi3aK+K3u3AQIEwmWayiR2ujv0HYzBdYUnL2RtKy0RY4baWfQnz626j980
	3r+6bnayqG2geb+WGmR6QVvrIC7PokJg5CM3aw8H0uk6QPM0bIuFVAy6EEk+GpUfelVqz5w+SzV
	z5GsV6t2Qdh6Kzc1CQmDoqrjfy9MHTVTdh2FckXM+i4gubLhTPNye29jBwAqLnFpAu8yxQ5/aDF
	TlT7QIuIEpNhiIpevZTKOkNs1XSB812A06UXsu4yzVxQ8wJoqgB+C750Lye5VOeOGVKVCOtI1Fr
	2j6hwhw+Pj9YKbjBKVOtGm8qobj45FGCOcULoa2p3hz9ja69Q7bzNqms16Y3RJDX6f2xXvflDvc
	ypKPmcLLOPhxOb4ayH02LiIBaqBl4/mk1YnnRUiTDwtdeupOByodkIomBsIHn5lZ5Z2STZlWYkI
	g==
X-Received: by 2002:a05:600c:198d:b0:487:1826:e138 with SMTP id 5b1f17b1804b1-48fe6309a99mr184655105e9.1.1779223700120;
        Tue, 19 May 2026 13:48:20 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm356457755e9.0.2026.05.19.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:48:19 -0700 (PDT)
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
Subject: [PATCH v2 11/12] crypto: atmel-sha204a - fix heap info leak on I2C transfer failure
Date: Tue, 19 May 2026 20:48:02 +0000
Message-Id: <20260519204803.17034-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260519204803.17034-1-l.rubusch@gmail.com>
References: <20260519204803.17034-1-l.rubusch@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-24327-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50800584EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a non-blocking read operation is requested, the driver dynamically
allocates memory to track asynchronous transfer status. If the underlying
I2C transmission fails, atmel_sha204a_rng_done() logs a rate-limited
warning but incorrectly proceeds to cache the pointer to this uninitialized
buffer inside the rng->priv data field anyway.

On subsequent execution passes, atmel_sha204a_rng_read_nonblocking()
detects the stale rng->priv value, skips executing a hardware data read,
and copies up to 32 bytes of uninitialized kernel heap data from this
garbage memory pool straight back into the system's hwrng data stream.

Fix this information disclosure vector by immediately releasing the
allocated asynchronous work data buffer and explicitly clearing the
tracking pointer context whenever an I2C transaction returns a non-zero
error status.

Additionally, ensure that tfm counter is decremented within the error path
to prevent reference counter stagnation, which would otherwise leave the
driver in a permanently busy state. Finding by a sashiko side-review.

Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 38a269186e2a..3d29543032cc 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -31,10 +31,15 @@ static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
 	struct atmel_i2c_client_priv *i2c_priv = work_data->ctx;
 	struct hwrng *rng = areq;
 
-	if (status)
+	if (status) {
 		dev_warn_ratelimited(&i2c_priv->client->dev,
 				     "i2c transaction failed (%d)\n",
 				     status);
+		kfree(work_data);
+		rng->priv = 0;
+		atomic_dec(&i2c_priv->tfm_count);
+		return;
+	}
 
 	rng->priv = (unsigned long)work_data;
 	atomic_dec(&i2c_priv->tfm_count);
-- 
2.39.5


