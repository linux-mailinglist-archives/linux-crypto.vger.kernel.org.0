Return-Path: <linux-crypto+bounces-24353-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHmCIkLgDWrb4QUAu9opvQ
	(envelope-from <linux-crypto+bounces-24353-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 18:24:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20396591D7A
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BE3338FAEB
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9323403FD;
	Wed, 20 May 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntdMmOGp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A230356745
	for <linux-crypto@vger.kernel.org>; Wed, 20 May 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292636; cv=none; b=Uxtnkslyfqvtipxc9gj7aNnq87NvHgcgrQOKrFfgngmO4qMnDKaky8CW5S+RL3+4VK48Y07xwNZp6kPIliYZ0AptyWBHaoXcTYlerHJ345R4+ZayuO+Y7Vw1HKWpI3S7JZc1ktQONd1mDVZpfaJPTrM8ywvKVS6FQZ7skDEJoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292636; c=relaxed/simple;
	bh=7NvgkVii9Mt+xIZwtiwwvrxtLwTlV0FgDfzptlWirWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gb1kyy39is/xAbQ9MmNbdhoIrN9h7FkvlStFXWPDCa/+8JPcsVrI2DXQfufMdnYDHKLMSQcuxPROY3zC2vF7ImgacCS/lxpzSZ2WukWG6mn7iOhEwnBGuCTaSlPQ0NzTqLQl5yG5kGf/wKCqssPot2xrAZLhd2gQB/+hDGdPXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntdMmOGp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490227b682cso1297575e9.3
        for <linux-crypto@vger.kernel.org>; Wed, 20 May 2026 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292631; x=1779897431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJt+1uhmRklXQWY1fAdB9UbwqmpgsjgJ14JFT2yZWDo=;
        b=ntdMmOGpOfWo8njdS7nH/M1gC2mxbaYawtNFFXpG3tTzJ9dpNQcRwW1DvIKFdeJY3S
         I9vB9Ni4o8wWYiEtjhzhGX42mR1u8uPUyHEUuXdZDsE1z4vbjPMG3NnLpPNCnDECXqH3
         MQd4/IjnA0HocnJS9bLanIVui+Qbl0YAnYuSa7a9SiLR9M/R0mfnqW9dxHcMR9uNWtDm
         DlEhirnDo/LEFFSEXcUXpg28Xtm9xTbT6xfRYZEn2+4ZeQHwIukuMa+mKZ5cCE/ZwTqj
         oTbp73FsEdwzT2z9i0VhOVIG+uKIk/OkJDdmUGvN+UXH43W8LpCkOuEsx+JWngnqAtog
         TOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292631; x=1779897431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJt+1uhmRklXQWY1fAdB9UbwqmpgsjgJ14JFT2yZWDo=;
        b=oDAdOTpaee1sFs67wOi63d9fsJeHnldtcjDc5IgupRNyZf/rsMG/r9RCzGXR0a87ng
         j1DKkHaDpEvwFyghOppKO8gZeXBL3OuLR+85AsC3wpJj9x4+Y9dvBDlm11iwU9n1nfCK
         A1d9K88sIo0ipsFfpZNlOc4DXy8HmRJhNevWV0onK5u+aqJa8ZuGUufcvY5oCjcAYzt1
         3n6Z9xPgXKIaJtG+Y0qzaBlQBrB3ZR4vq2xuf+3iZxCLCljlRzRN0AmeKhnprLgDs0Eg
         PLept0imiAvL4LXwpNiK+UNSbgIVdA9IRxvzEEu9MvcIsE9tX4GWLwwrb0qGsGJ373kB
         w0qg==
X-Gm-Message-State: AOJu0YwtC1VhMThTlxQNqR5EFqulgsNv3i/f+DfQarQWYOuvWysvVl6F
	gW1nepjpKMDvHV0fGEYF82TFIHxfhoHEu+kxS4wNb3rR8vg1p3D6X18l
X-Gm-Gg: Acq92OHJc2KJHzWGLybw3CH6gXumfmZt+/x+IyxJ2ZCxVNjpOd+xdLMOMcCsU9GHvDk
	b/lvbPQZXZp9NPBtNFLYJ5BwYK3CfZ3pYiJVIF8aSNkW9n/B03L6VnlHETP9rtkj+5wGDCftFFB
	QVyXw2ysyHTkamqaPtbRG5fVE2WeJl9ZRXTWEnh4zVCtmp7QLtORWrwjlJJRuyS+SRC5wboNleh
	nBm2NONZlWngfdqCzOkk4pE8cZH0NolkMZaqnQuHRRT4mD7dzH+Qput7h2XBZuiDNVwy9vPuuJb
	/Xvz9ui4VqJ9Y2ZML4yaRrBxYXYnGwqLXgjl9IViEb3qP+jIiSWO61+cT0DNDerTo00wywrsK/R
	2kGW2cB0U1CVrIItfdpnLaNyQWDSKdeE/YRb4tFMUVLHPOB4cQj8z15imEEVPkpbQM6LsU43IkA
	30YK+iAIOwsVRxjxanuJTmk/qHA1GL3wvUP+GUK+GRlxEGki+F3+SxhH2K8eZ/79nFZsIoP34Nw
	A==
X-Received: by 2002:a05:600c:8b25:b0:490:6ab:406a with SMTP id 5b1f17b1804b1-49006ab40f1mr142371715e9.8.1779292630575;
        Wed, 20 May 2026 08:57:10 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm137216715e9.31.2026.05.20.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:57:10 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: thorsten.blum@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	tudor.ambarus@linaro.org,
	ardb@kernel.org,
	linusw@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v3 02/12] crypto: atmel-ecc - fix use after free situation
Date: Wed, 20 May 2026 15:56:53 +0000
Message-Id: <20260520155703.23018-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260520155703.23018-1-l.rubusch@gmail.com>
References: <20260520155703.23018-1-l.rubusch@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-24353-lists,linux-crypto=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20396591D7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes the very likely race condition, having multiple of such devices
attached (identified by sashiko feedback).

The Scenario:
    Thread A (Device 1 Probe): Successfully adds i2c_priv to the global
             list (Line 324). The lock is released.
    Thread B (An active crypto request): Concurrently calls
              atmel_ecc_i2c_client_alloc(). It scans the global list, sees
              Device 1, and assigns a crypto job to it.
    Thread A: Moves to line 332. crypto_register_kpp() fails (e.g., out of
              memory or name clash).
    Thread A: Enters the error path. It removes Device 1 from the list and
              frees the i2c_priv memory.
    Thread B: Is still actively trying to talk to the I2C hardware using
              the i2c_priv pointer it grabbed in Step 2. The memory is now
              gone. Result: Kernel crash (Use-After-Free).

Fixes: 11105693fa05 ("crypto: atmel-ecc - introduce Microchip / Atmel ECC driver")
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-ecc.c | 10 ++++++++++
 drivers/crypto/atmel-i2c.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index c9f798ebf44f..4c6860fc3dd9 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -218,6 +218,8 @@ static struct i2c_client *atmel_ecc_i2c_client_alloc(void)
 
 	list_for_each_entry(i2c_priv, &atmel_i2c_mgmt.i2c_client_list,
 			    i2c_client_list_node) {
+		if (!i2c_priv->ready)
+			continue;
 		tfm_cnt = atomic_read(&i2c_priv->tfm_count);
 		if (tfm_cnt < min_tfm_cnt) {
 			min_tfm_cnt = tfm_cnt;
@@ -322,20 +324,24 @@ static int atmel_ecc_probe(struct i2c_client *client)
 		return ret;
 
 	i2c_priv = i2c_get_clientdata(client);
+	i2c_priv->ready = false;
 
 	spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 	list_add_tail(&i2c_priv->i2c_client_list_node,
 		      &atmel_i2c_mgmt.i2c_client_list);
+	i2c_priv->ready = true;
 	spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 
 	ret = crypto_register_kpp(&atmel_ecdh_nist_p256);
 	if (ret) {
 		spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 		list_del(&i2c_priv->i2c_client_list_node);
+		i2c_priv->ready = false;
 		spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 
 		dev_err(&client->dev, "%s alg registration failed\n",
 			atmel_ecdh_nist_p256.base.cra_driver_name);
+		return ret;
 	} else {
 		dev_info(&client->dev, "atmel ecc algorithms registered in /proc/crypto\n");
 	}
@@ -347,6 +353,10 @@ static void atmel_ecc_remove(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv = i2c_get_clientdata(client);
 
+	spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
+	i2c_priv->ready = false;
+	spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
+
 	/* Return EBUSY if i2c client already allocated. */
 	if (atomic_read(&i2c_priv->tfm_count)) {
 		/*
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 72f04c15682f..e3b12030f9c4 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -129,6 +129,7 @@ struct atmel_ecc_driver_data {
  * @wake_token_sz       : size in bytes of the wake_token
  * @tfm_count           : number of active crypto transformations on i2c client
  * @hwrng               : hold the hardware generated rng
+ * @ready               : hw client is ready to use
  *
  * Reads and writes from/to the i2c client are sequential. The first byte
  * transmitted to the device is treated as the byte size. Any attempt to send
@@ -145,6 +146,7 @@ struct atmel_i2c_client_priv {
 	size_t wake_token_sz;
 	atomic_t tfm_count ____cacheline_aligned;
 	struct hwrng hwrng;
+	bool ready;
 };
 
 /**
-- 
2.39.5


