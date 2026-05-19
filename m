Return-Path: <linux-crypto+bounces-24316-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMw9M5LMDGrAlwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24316-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8A584D37
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD195301E360
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7B3B5306;
	Tue, 19 May 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDhY4S+N"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E1386C3B
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223692; cv=none; b=EPLaDPQKfxONBZhc/aB7ciJTqdSV1K3n5cLsww4U//ir8OFlA9LnIVqig+l0BwgfnT4ds6aplYM4jsZou2qF74r0E/6Vi1mf6edMbHEhNcc3lzT/Lc4dnUsjqBAZi3O/HzQYGIfFZwpvdny1uNTvVTwi05y6Khg7sRE+5EGcwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223692; c=relaxed/simple;
	bh=aN/jIKU8WwEj7tNWCy2Y/6waCIjstgh4Ig/sdNXpIWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h6dWlgi4kpmsdhsvaKRlshF0POEMy41nbMbkWB0ZEVC7V7hlbOBP3R4uV9b7SOv+AMIAL2fJQPXwjn0+hmnq5xokB+kpKu9dWwgESAlt5fryuf4rYRtBadmLhOtzokIpPXfQBiMSPdUadlcHomMQAt2ttVuA/Vtk3YuvsdA90S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDhY4S+N; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so542605f8f.3
        for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223689; x=1779828489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9yu/QXPv7IRT169VYxzMPUPurNcWd0h458FPz0Rs4c=;
        b=oDhY4S+Necuuhim/+0xdvZnLITUqpQUwueXBdVX0fqelCKV3TjucddyqJ2c5nTt6BJ
         4SJKRi4uYoB92VMGYCrbHimPnucFZqdtzQ75cwdjq3a4P9ttrB4pD6l4mMDWGmG0870W
         VbNx6GcznOQQMmXfjaur9Tod7Y65xwLDpoPxLEJ6x+oksfoOlCmU32S6YtGQrOiXOp0o
         sdveGQuiih+otWQw0NM+Dt4RgAb28FFnJ2DyyPKqPk65tPzoOG2+eQ5dBWTmKOpZcOs4
         ygiDo3LvGfrddUuKCUms8Xy23DuulEw1cwVacOmYJgYukENMEPV5H4oraw0WkM7kRdAo
         8caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223689; x=1779828489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9yu/QXPv7IRT169VYxzMPUPurNcWd0h458FPz0Rs4c=;
        b=m3w6uRgffpCvUVFGGFeJgz2/lVZ4QzsD1dRL9B4zVTgzvIv5jMVIV6ukIsmyJBHaOv
         hcZaiwmg5Vh76UbOHzFENYOuTZYzL5PUtou4aFLT2tT6k9mKDK1GYqLR+qGk9KwTXA0v
         FpPd5kOzVx1lADuYS/+Ny+91enzqFjkVezyl9bZpYDyMIlRmOn9g9skOA0jcp4yzaTX8
         zNJBlEuULkkG72BtoJHfMlhDl7gHpeGhKTpA9jRjbid1X6C+HS8THYx2DdeF5LDU35l3
         rCGVxMtogyCZRbe1wlEBhCViDhBNdGH62jSEDXGp3In9WjMv/BngfKgJYtIvQC3gPwDT
         2/aw==
X-Gm-Message-State: AOJu0YxdYs3mRuFdEtlMgGsbl3OdhETZsCVAS5rgTjZw0nvGBX88+Mfa
	XKJVOj+WlFk3QDodUnlUzKlqnIKVG9ZS7/qrd695whJ/VzItp5U+cXFGRG8byg==
X-Gm-Gg: Acq92OG+qDzm/bvr7E8TUf1D3+R3j0uamesYcajlUHSDw+lXO4lHpCw5k3ssinBqcw6
	sknYRtCWQozyDd8QS7fH/dwGzOIQe5UUnmTct46xZ4HtdKzhhtsJsPMv6iYi9ON5677LfXhd/Tf
	Sna8sVCosI8qu7lBkxWQ7eAFYtUcXw5zsWrnT1zRsIYHpwULxrf+QI0QJuBMYqj7OFizOcTI6sL
	Q6E1JLs9+mBUMbBhMH2P5cHN1x1C/3pvPEW3XEeMP61+FNXB0HxGoKTdeeEC9Wqp/p8ksvP/7Wt
	ggcTVrtF7kZtftkvht4s+MxpOI7aXSpqe3k6dYSYTxkp9Gg4BS5Bufv7ctgHSZ7ZyZNbId6W8Dz
	hG4Ya3+5PPvjts0qDZ/axdA1mVqB8WBHVngoVAwAGsYrFvsXDMUha2GKe3dJm8SkQaP6GPS9W+s
	iD2V8ick1nCUa5f1FD9JNEV8/OGTwXg4sOpWfW13t0N0ix47cdUH6UheBUCU2NK240SKF6AjuaB
	bUknyteKRUU
X-Received: by 2002:a05:600c:a48:b0:48f:c8d4:487a with SMTP id 5b1f17b1804b1-48fe63138d7mr141836725e9.8.1779223689381;
        Tue, 19 May 2026 13:48:09 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm356457755e9.0.2026.05.19.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:48:08 -0700 (PDT)
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
Subject: [PATCH v2 00/12] crypto: atmel - introduce shared i2c core client management and capability-based selection framework
Date: Tue, 19 May 2026 20:47:51 +0000
Message-Id: <20260519204803.17034-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
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
	TAGGED_FROM(0.00)[bounces-24316-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3A8A584D37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces a staged refactoring of the Atmel crypto I2C
drivers in preparation for a shared core-based architecture. The goal is to
consolidate I2C client management and selection logic into a common
atmel-i2c core driver while keeping ECC (ECDH) and SHA204A client drivers
functionally separate but interoperating through shared infrastructure.

The series moves existing ECC-specific client tracking into a shared
management structure, relocates allocation and selection logic, and
introduces capability-based filtering for hardware selection. This allows
individual crypto drivers to request hardware clients based on supported
features while still benefiting from a unified least-loaded selection
strategy.

Subsequent patches extend this base by:
- migrating client management fully into the core driver,
- introducing explicit capability advertisement by each hardware client,
- updating ECC and SHA204A drivers to participate in capability-aware allocation,
- and cleaning up probe/remove paths to ensure consistent lifecycle handling.

No functional behavioral changes are intended at this stage beyond internal
refactoring and preparation for future feature expansion. The series is
designed to preserve existing crypto functionality while gradually
centralizing shared logic in the atmel-i2c core layer, reducing duplication
and improving maintainability across all Atmel crypto drivers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v1 -> v2:
- going over Sashiko feedback[1]
- rephrasing commit messages and titles
- fix: introduce a ready/state flag to address the UAF risk
- fix: add kpp lock and refcnt to impede overwriting global driver struct
- fix: explicitely clearing rng cached buffer in return branch
- unregistering ready state by dedicated function
- reorder Atmel ECC related things and atmel I2C at beginning
- reorder Atmel SHA204a related things behind introduction of cap
- patches dropped: NULL checks in remove functions
- changed to EXPORT_SYMBOL_GPL
- additionally to alloc hw client also migrate freeing it to core driver

[1] https://sashiko.dev/#/patchset/20260517180639.9657-1-l.rubusch%40gmail.com
---
Lothar Rubusch (12):
  crypto: atmel-ecc - rename driver_data before moving it into atmel-i2c
  crypto: atmel-ecc - fix use after free situation
  crypto: atmel-ecc - fix multi-device kpp registration
  crypto: atmel - rename atmel_ecc_driver_data to atmel_i2c_client_mgmt
  crypto: atmel-i2c - move client management instance into core
  crypto: atmel-i2c - introduce shared teardown helpers and fix queue
    flush
  crypto: atmel-ecc - switch to module_i2c_driver
  crypto: atmel-i2c - move shared client allocation logic to core
  crypto: atmel-i2c - implement capability-based client selection
  crypto: atmel-sha204a - integrate into core management tracking
  crypto: atmel-sha204a - fix heap info leak on I2C transfer failure
  crypto: atmel-sha204a - switch to module_i2c_driver

 drivers/crypto/atmel-ecc.c     | 137 +++++++++++----------------------
 drivers/crypto/atmel-i2c.c     |  78 +++++++++++++++++++
 drivers/crypto/atmel-i2c.h     |  17 +++-
 drivers/crypto/atmel-sha204a.c |  53 ++++++++-----
 4 files changed, 173 insertions(+), 112 deletions(-)


base-commit: 6c9dddeb582fde005360f4fe02c760d45ca05fb5
-- 
2.39.5


