Return-Path: <linux-crypto+bounces-24323-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCKOALjMDGrAlwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24323-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C051584D5B
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0E02302FF6D
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 20:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37943C13E9;
	Tue, 19 May 2026 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT48dX9U"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B23C2772
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223703; cv=none; b=e91/22CEEjeLM4s4lWKJVJO8wN+QoS6a9WqljnAgS5HhUSjLIU0UB+3KiMAUSKYM0rMLIUCkCZTYp8Ad7gP2JB7AkWnP76BVALvj+hv9tIChMC8e78BJSqG90lc0uAaF/QQsCNofLvcrm4ptb+3d9HYVL2UgLkBI6i6wWWSD95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223703; c=relaxed/simple;
	bh=7md/GO2YbdMxhovqDbwh9Ck8m70e0HbBva2h+wz2M+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxFSAKbvBD/jtUlbTxr0vBAV6sTREIYCusBl7UTU0RHFhAtDgOz5tZV7ZtM2buYesbPdT+TZ6o9Cy8jEvATMUJgHzaOoU6L0I+ijnD7Iqe5yaWxaFHd7N5FGlKRcfZXA7CgxiFT5xLdR1UblinMqMoEdGkk/nEZuBLqt/CaXuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT48dX9U; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45e6c2d9c5cso246598f8f.1
        for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223696; x=1779828496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iv91Yr/xdaF4aAKWiyJjatlZadYEBC7HnO1idj6/DU=;
        b=eT48dX9U75guiiMZ5iMHlhkZSqF/EQ+zCaMAjNhG8SGztzQOTOipmUxBIjJ8C/kl38
         qnU7R02uhfVVLxFfh/qkhHYDfP4xnEv7Lcw3Zs9MY24oztoOWySgIuoVrtyyjNvoUmmi
         D5ifzjXOyJbdvUQsXKHeG4LgyBCbwHKGsiisWsGAuSP55pNriOJenkqykDGKwI39b9Bw
         IqK//slOe/zBNFNg8Dz+Rwp+n6IKhhMZ6vFsLLg2l8qrFGbkeGDaRkTcAjdpT737barc
         j3+7YsjiL/O+ejdhVuY4+PCfvBBMt9/UYcJPfIavu/QxcSUj9j4kNTEKNVkUs9h6g8xk
         VsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223696; x=1779828496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0iv91Yr/xdaF4aAKWiyJjatlZadYEBC7HnO1idj6/DU=;
        b=hJBK2FIrKuUk+YA7mek0M6D61U4o9T3f7HQoEJcCPYQ4/YLeZ9AegqLx+jpnZdYYAu
         2uSusJqQ/o5qGShOvbSJMhtdd3GSa2iMyMlZz22uNoYTvFlf4+hhiKh5Pq8Np54kK3sq
         C8TVkdtOPBPVFJbZe8akn/Y+5oUmY2CFw/hqw9HNsmXJHSV4oEkvo5XZO7zNYsAWpKNd
         MmrNbW4afaQ/Yz2bP3Aglr8FtXVKOLYCoimNKPvyi1AEUlN5xmGOF7o/sQTR+DNrZH3B
         s5T79bvlA9546tpUTJnpuiqXqjLMX4gom8q3dOy0i4xV2OEHna3aoJkzGdW3L3dwV2uf
         SK8w==
X-Gm-Message-State: AOJu0YyNTUEkkNmVVnmePdlxE4HZVAyb0eEGSOlZS31sh5Yh85Dc0zs2
	uvhpL2XkWyTmq+1pN5j/Dj70xJhGMCdsShwXKDE+hxhukPL3J7FZmU8J
X-Gm-Gg: Acq92OHJ5Ltzz2v4cJRjN2jqxiGNvEjYSfdnHYMwnwy1EPw54XCHSc72s8k3l7TWBDt
	zXG5rE0pOcPbJGJj6d813ZaiTEobRcc8O9cj/ISO/dQ3C7Izrtx54OcfWJXInjfAHpCvX8aW+LQ
	8bJsvEMlLDQl9WHt20Zxefx/X3pKjLlnzE6YtQww9ukOBqejTWy4e9mXsAy0DG+fgWGhwfyUksD
	FSED97H3qTw5FYXrc5TEunyL/9khKuZ1ezLWh0k/71ZxsjJdZIUTeQSoFvCV6fTfI3gkMqf1oEl
	u+htu9tcWa8Doy6NjZDGdCKVWdqosiYRRnd/86sCN1lUs3R03tkzL9QPEAd0zdcYrcHYeqGk2iG
	jEqdnBVG8KHlllwycN6vYIK2SgW9LtA8SNtFYxqN1/Z63MuTnspS2Vu2qgeYTFx7hXdNdw2vqYo
	9YLYXYu2ebbnoZos43uveMe6xgfXPVqWq2xGBln/aWCQM/0d3ho4bBJngJkQfUx+mqjJ0PyGjRT
	g==
X-Received: by 2002:a05:600c:4692:b0:48f:d410:6072 with SMTP id 5b1f17b1804b1-48fe6302a9fmr178240165e9.6.1779223696104;
        Tue, 19 May 2026 13:48:16 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm356457755e9.0.2026.05.19.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:48:15 -0700 (PDT)
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
Subject: [PATCH v2 07/12] crypto: atmel-ecc - switch to module_i2c_driver
Date: Tue, 19 May 2026 20:47:58 +0000
Message-Id: <20260519204803.17034-8-l.rubusch@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-24323-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C051584D5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove custom boilerplate module configuration code and convert the module
init/exit paths to use the modern module_i2c_driver() helper macro.

This shortens and simplifies driver initialization. Custom structure setup
is no longer required here since management tracking context initialization
was already safely moved into the atmel-i2c core library module.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-ecc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 29706e4bfa04..4f27e1caf106 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -401,18 +401,7 @@ static struct i2c_driver atmel_ecc_driver = {
 	.id_table	= atmel_ecc_id,
 };
 
-static int __init atmel_ecc_init(void)
-{
-	return i2c_add_driver(&atmel_ecc_driver);
-}
-
-static void __exit atmel_ecc_exit(void)
-{
-	i2c_del_driver(&atmel_ecc_driver);
-}
-
-module_init(atmel_ecc_init);
-module_exit(atmel_ecc_exit);
+module_i2c_driver(atmel_ecc_driver);
 
 MODULE_AUTHOR("Tudor Ambarus");
 MODULE_DESCRIPTION("Microchip / Atmel ECC (I2C) driver");
-- 
2.39.5


