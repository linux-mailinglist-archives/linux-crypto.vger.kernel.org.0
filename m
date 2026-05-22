Return-Path: <linux-crypto+bounces-24488-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PYDGMXgEGo1fAYAu9opvQ
	(envelope-from <linux-crypto+bounces-24488-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 23 May 2026 01:03:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026A85BB519
	for <lists+linux-crypto@lfdr.de>; Sat, 23 May 2026 01:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27EDC302A07A
	for <lists+linux-crypto@lfdr.de>; Fri, 22 May 2026 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC638390610;
	Fri, 22 May 2026 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3ej08MZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC8368941
	for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490906; cv=none; b=d/tqix0qu+yqFEIqpTd80WG5PQcGoEN/w5hIuYKlHVjkkLBEcwxUCqo5aHNuv6OYOOF+VRUTdlmgGKcwX/wM4gCvLMvnwB96RjiMM1v2hiYf8VUvJD68pScx1X7pdjiBSPbMuZNuV8S9mjYNN4EgC9AoazRi3lfczrfOHH8OgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490906; c=relaxed/simple;
	bh=WT68BEzTx1l29XJyggZ3cUigYYl0bj5fpGSnTqow5sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVzVpGVBTwzli69jKoFreZCaVKz/vBqHPLnYFhBSKHWXcD8gAD+bS66L7sNLAZTbbeQtxR6oRfEjw6Cbigw/IY2c6nVtVR4fp+MhOwH3IDt7QJBWiuvZBtfJwh9uLQggX5Is6+rD8tO0+1ucM0kBfj3AfG9w71gM3YXBoPeQIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3ej08MZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ad87a57f6so612344f8f.2
        for <linux-crypto@vger.kernel.org>; Fri, 22 May 2026 16:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779490903; x=1780095703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4hFlokuo7P4aQz1gprT7L1r7NqG5LdGzkVv8qgvK+0=;
        b=s3ej08MZnmsJCHBndcquvjzw/tLVMBDZCyPG4BE+EU6+5WuPnB7y+YOuQM6xJlKTe2
         caffvG0wV923GgewcB9UWvHtlb3kwuosNeOD6ZDPhyNHsL70SJfjZZ4hWK9O5xRS9Yse
         32lBjH1WdlAlH4bnfb+gUqmR7qFQcn1l+FLiPLXzSnj7k0QTXYELBAHkNuewrLncgMM3
         99d8wBjoYRvAzUPw8SHBetotEzghWp3WXlyAxXHXfPFAbuRkFXFNDAoCCIAcMAu639X/
         1mbY+G5MiteVyx3YSN2F0n73w+efUHySQfQmRqUW1xEEYHojj0FVl3EwYUW6NKuFuovq
         QxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490903; x=1780095703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4hFlokuo7P4aQz1gprT7L1r7NqG5LdGzkVv8qgvK+0=;
        b=ZkhPuo+qopQ8Y3D7Wc3GfIbPnA9wqLGje6J5g+kRYclt/7g2ekC/p74pqvkvH8e3lY
         CF59Hp92LzwiwtMz1BDRBIKv2TBHr114/hVUJqefx8IBUQLDPD8n0KCu9qTbV62SaDd+
         czcCWeMpqWzs2nOdlCxG1Qo0cI12pesbM6FGsRrq3x+8e+AmwplR5m7hfhwmpVl3lq3h
         2JNDH1chx+QHP8DLXZQUk3YKvKdJ4cFQ3bSA9Ur5KNKfS8wJl6SccCU163VU0tNNK1ln
         HEgAyLyc7C+mgo1acg+HCRWVQLwO6T7H4fQKul3fDIVozHV8y2C8so+I9a5O7PuEc+89
         EWWQ==
X-Gm-Message-State: AOJu0Yxu2NLCaRvoWXNczGamuVKVR9WadUMlsgFenXDmZ9Pti42ngZY9
	e01ivC6jpmd08QFQhje2irVBPjGjSJb+2AU6EwlYDr9GQ530xscBqhGv
X-Gm-Gg: Acq92OEdAt61T5ilZDTvQ1lW6wEJ0wChQYgdNd3WEbQNL1PjY/SU6bwACy3sk2//toe
	LKhlonWAk5Y2Kdj1hMiZbq6xWUIaB+prkQFOBeRxAWht++k0AcoTC3gb9Nv1ur0mN8LFI56tdWS
	Paqmq/xlNbG1XUb5fISofujVRq7/UdvhzH3r5wROlxz+GlQj6zY70SkG+WE/gxRBLZpfeB3mk2Z
	EBxYLIJ/jonqABkH5LUKwUlLC/tiiktSrRB3d0QRXSV0AhDLhhjwyig1U890YlyXxeuwz821YkN
	RFGSRx+stHlaDJpkXazfR2sSAKdWw72vrbrmPNdDf6ge/Zqk9PxcpgAYIHNrmxYeVThYSWrp3qM
	SUhEnit3sZwCnUulAD5mLjwYutbli/erY461/DVU49ofi3nImCjpIV9QgHt1fQqoqZ/ixUQZkgD
	/Jmrexs6BH6fiKaKdFr8gNAArd+FUBMyWhRwc5H6CBHZ8Ch3jE9Ns1a0We/6JbCIQ=
X-Received: by 2002:a05:600c:35cf:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-490426bb7f1mr44203705e9.3.1779490903199;
        Fri, 22 May 2026 16:01:43 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490456274ebsm67100265e9.15.2026.05.22.16.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:01:42 -0700 (PDT)
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
Subject: [PATCH v4 03/12] crypto: atmel-sha204a - fix heap info leak on I2C transfer failure
Date: Fri, 22 May 2026 23:01:25 +0000
Message-Id: <20260522230134.32414-4-l.rubusch@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24488-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 026A85BB519
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

Additionally, duplicate the tfm counter decrement within the new error
path to ensure the reference counter is properly released before executing
the early return, maintaining the driver's availability for subsequent
requests.

Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 12eb85b57380..33e5a66b843c 100644
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


