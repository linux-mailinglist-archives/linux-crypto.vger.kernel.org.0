Return-Path: <linux-crypto+bounces-24320-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IQQJ6HMDGrAlwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24320-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A4584D46
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B3DD302008F
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9703C0617;
	Tue, 19 May 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5T9qZBZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9233BB670
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223696; cv=none; b=pm0tnRUzsr22RNeSlQo58TU8WmMigAHQr3wbx4Q9VLHt9YZc0Wy4e0th/V8PK5XhacWuAk6R+10wuKD4VRnKgForOXGvPThmzDkZo5SXS7Vcdj8N/v/BnYmVR2EjDI1v1RZp3xjNcGM8hwO8c7qIJr4Gm95xYxQqsFi1m9Ir5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223696; c=relaxed/simple;
	bh=ph1dfj9cBGflSBFQjBZjJ8ZjvOFSmyP7dZ3NJ2+hUz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVzNwxWVmTyLMOipEJIt3OyRZkl9Dv32kujIe5RpBqxJ5EeXwAPo+WIRQ65Qal7Op6kTHlnnhNdDY4WduAkbEwIWVEhBF9IJQXdzWdxuSACYe8gf6OgRPWntz7Ww9T1w7d6ZG3SDRi3HinOkFkCH1UyEI1Nz1jdmwZUx4QMZPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5T9qZBZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-449cdc12a8aso520943f8f.2
        for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223693; x=1779828493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2MBEXVQCUICFyYJC+vk71e18yKEtxbyVZMMqmm+Rw4=;
        b=G5T9qZBZVsEsU7OLfFyd/2MWlxdVXWtfLLgreMiwilUfzPbG8TgbaDngb0fjK0zI55
         t/3t5lah8pa2RCnAW01VnBz+3BemhxhIzvHmy9RQGsLNV1BfZMS3gXqEBMTBbCSdv+Vc
         LQ7w3KOAv/kKhZI+BAtSuzZ6KRduU1MOMF+q94TIISjt3DfzJshLYSyxA9MYQiy7r2kd
         rIJpY7bnMQvU/xx+cZr5HGsYMYOp4EOjxMhFndzCqHW8sgfPuQN8et/sfB/n+tCqLCpH
         siWiCYbL8+V2+jnaUykWqOaYcXJ8S28iiTCkODq1VwZBq9Ex0YF2b1wVdmL9YVG162nh
         igtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223693; x=1779828493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2MBEXVQCUICFyYJC+vk71e18yKEtxbyVZMMqmm+Rw4=;
        b=M2aFysJbxQHmq6aTf1U4jAQfMaGC+j/R9Y+AxdqaLnL9LmNhjPVMFLRBcewWr8aWJ1
         xs09piV1LqGBjNDNIU0fuTVMLLbtStR6rgNFgDullVku4SqaSDY6qM4tXDvHTUmczNlX
         ouPHYTmbpYMIOxZENMpYBofXbSRX6tK4DKuUX9yiEZeWSTSeGl/w4AISd1Bhamg3yGQR
         CRlE3Fu8oabC02SNDK1cHwu3JEx8Av8ZHgJNZ3qDIMKFW0Qcp35loyJaG3LNXJNMs3w7
         hzN6UuAXvPt9zUVaXRJ3BerIe2IO2bTeikrCYMBTAubZ9xPwAN8Q3TQIXPHYU//0QOvG
         bSVQ==
X-Gm-Message-State: AOJu0Yxn/kp61zzY2lAUScxql16ZrFyVK5Yss+pA7prllgv7mKoohY+o
	33yMWa774TM4nd5ADEK6HeBXyFiIQId3Ux3GhEI4eEITQPbIy9G+h+HR
X-Gm-Gg: Acq92OHE7aTbroM8EsvFau/NLOdJNhC0lGLbG1d25aC94oTEOeZih4DI8ewL+CxCI/k
	1vYuD8EMkj0MkFSsOVT2hwzfATQ3FTAvwO1Tg0hTgtONORLhXNe5KAXyzSyESGUI7/f8jztEa14
	+jLOUnpwVD3REJvKZKjcx/wpVc5uiaBgCaKcVb8q7OhkNu3Vj6EyI5ZWrjtowyn8g1L0hkDIQkl
	9OosHsFhcceQUjFsoJdoO9lKxlBfziDAwlY/DmK57WsgbSmJF9meFuu4xeqyHrW5tRl9jv1Ul/B
	ob370wgNVFM7y74+c5tstvyADmroQbEud5SGUHj44IdTNG4aA/6G2kBFs6Y/UEkW241alfNUf1/
	J2HwXy4YH99ocgHBBy2RNma2rPSdsdqUil3H5HmI/4Am7iPlFjxWKkJDal3xZgJvWhWLGhzPQib
	dkmsIMCo4wA4La5GwJCJUQrbXmtvVGp75onl96AhGXW442b16q0SO86ixagrH46/k=
X-Received: by 2002:a05:600c:3594:b0:490:502:8422 with SMTP id 5b1f17b1804b1-4900d55ec74mr79065995e9.6.1779223693208;
        Tue, 19 May 2026 13:48:13 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm356457755e9.0.2026.05.19.13.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:48:12 -0700 (PDT)
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
Subject: [PATCH v2 04/12] crypto: atmel - rename atmel_ecc_driver_data to atmel_i2c_client_mgmt
Date: Tue, 19 May 2026 20:47:55 +0000
Message-Id: <20260519204803.17034-5-l.rubusch@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-24320-lists,linux-crypto=lfdr.de];
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
X-Rspamd-Queue-Id: BF2A4584D46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename struct atmel_ecc_driver_data to atmel_i2c_client_mgmt to reflect its
generic role in shared I2C client tracking and locking. A subsequent change
will move the client management infrastructure into the atmel-i2c core
driver.

No functional changes intended.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-ecc.c | 2 +-
 drivers/crypto/atmel-i2c.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index e5dd166fd785..aa2dde99b2b1 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -26,7 +26,7 @@
 static DEFINE_MUTEX(atmel_ecc_kpp_lock);
 static int atmel_ecc_kpp_refcnt;
 
-static struct atmel_ecc_driver_data atmel_i2c_mgmt;
+static struct atmel_i2c_client_mgmt atmel_i2c_mgmt;
 
 /**
  * struct atmel_ecdh_ctx - transformation context
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index e3b12030f9c4..30ed816814af 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -115,7 +115,7 @@ struct atmel_i2c_cmd {
 #define ECDH_PREFIX_MODE		0x00
 
 /* Used for binding tfm objects to i2c clients. */
-struct atmel_ecc_driver_data {
+struct atmel_i2c_client_mgmt {
 	struct list_head i2c_client_list;
 	spinlock_t i2c_list_lock;
 } ____cacheline_aligned;
-- 
2.39.5


