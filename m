Return-Path: <linux-crypto+bounces-25216-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjOqMkaHMmor1gUAu9opvQ
	(envelope-from <linux-crypto+bounces-25216-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 13:38:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5216992CE
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 13:38:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g2a8K3Kt;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25216-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25216-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A70336BD58
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA33CF97F;
	Wed, 17 Jun 2026 11:27:00 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F143C1400
	for <linux-crypto@vger.kernel.org>; Wed, 17 Jun 2026 11:26:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695619; cv=none; b=nklT/TOCGXVYFn1yRH0ZcdsVeN+9p8BU9MFZNYoM74Cr4EVKfd2HF3rhMS0YDlL0qV/1WCoNwpTwC2FC6SbLLDhHxY8M7TvilyM0EnUL/cwRS2NqSHv3WVG5p2hfpAWs+lwcTa6tKPNL2RvDQQ6qnqAXdyPG8MV0iZVuaHnoZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695619; c=relaxed/simple;
	bh=P4XSAZSSLDI4/lBmgVAcoWO17E1NYhn5/B0VYcpM5x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kB13MoN75KrZQ7F8twNI/RHOuI7vTCYS2hUXN8JNAkq9IPG7keo1hwiYitB5ApnqRVRt/kyXkZk+WFJfeJSMizvR/08K6BL97KfUS6vxJjK2fnZOaYhNqIvD4KDGRFAXbrurYPHGTbeqCjNu6JtPaGYu1UhSbbFrq8asIAlIdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2a8K3Kt; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49222fb062bso46688965e9.1
        for <linux-crypto@vger.kernel.org>; Wed, 17 Jun 2026 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781695617; x=1782300417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XzRtYwZdepQpW7+D4SUSJ9DefBGTPjjaWTyX93dJg30=;
        b=g2a8K3Ktc70xFKHV8ViDZiYEHfXXgvu7nPzLcend6e98Isp0C6LX/af9E88bsyyIkp
         Hty7Fofxz+1oAIJLXRemb5b8bWQ0Zt2m9D0IApkxLJYBWJmoXPInl3a4zPN+4zSsMTi7
         YbW3yYA+JpPDLS1Sqx6xBzfRFpJDod0EFJMWv52YaO9s0PSf6F04SaXmLXpg1lGmsomh
         bV4TMjtoNtWCaGU22n0gKLpuUhYwaupNlkLkc0Cnz+k0Lpg0xnMZ+FKRyk4MrtXhpGxD
         N2i+hzJN3ARhd/bpbUUGDHDW1XEHOl2RgAm0tIO1efP4Vo0AYnv/0aVKvv9rEK8cgzWo
         rDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781695617; x=1782300417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzRtYwZdepQpW7+D4SUSJ9DefBGTPjjaWTyX93dJg30=;
        b=ebfGue5SNdcWkXDVkE0m8W74gWeCewO+L4TemIDDh4p6vRUyXrkLAMqMKBdYgTnCiP
         oJp7dZML+czIhPcPJVZcEeYkg2EqY+6GbrN46M2TTUFztpC5a45g6eSKYivm7sd+J9uB
         T9iKwpFqvyY8Jg2HWV7ln2psnXYEeBT1vXZOwToU5I0bp/ruvDRN0NzQPk6LxzqtV2QN
         l/C3BdN8/458QKKFKzU0jgqbg5rkr7JE2t2lOaS/df+3gEyW8LPFJAciY0ybMJNbSGZ2
         lIOZHYvnUmBLdG8mTDcn+f/SB2b83O62Xml5oCNXXhyaGyhu4T9FG481jccbc0DJ4v/l
         kbtA==
X-Forwarded-Encrypted: i=1; AFNElJ+c36soFdf73SBcnefiKEl8OmxXM9tBfvbWGxdmjPC6WFmNYnA7WlNIGtVpEE4HVgBQPasroV2Z+MhLRCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2eqNFvawxOnwYM42irXtDeagmopMCOdaQKoKPS8ShYOy9mia
	qQ6E2laR6K9TgT7LcR4/Jtfz+xKEquw1gh3qTh3EiBK8euMVxSb9jM42
X-Gm-Gg: Acq92OHlBsRIGEjj3Cc4GFHBhjsSLsRmaTe5MB748PTgKLforMvf9Y+gX5vL2Omr1c5
	fR52sFRATgOSmqubXn8H+BXKUrWYVLv03R1fmsFLrKkTXejVO07dn90zrNfor/ujF2UkqhtxjAz
	i/sIwKtMhm9hrL8GDRyMyj+vs3Cf1UjYI9i6nbD7vLTwTno2XXL2SlwWYyqNHzBWMQ7JKJAuSJE
	zvcll6Z5SuBst7m1HsR3r/reikTXG0pBFwzQ0T17L+af9vDTlYw22l316A9djID4Yc2bsekcqBt
	X/FtPyZsIFow/1APOM+MvNb4bKlPBA+mf+rgwrelxjnNu6rtR2CmDyqizmON3Q5sOhmYh210UjZ
	WQe5Ne9et9/9cvaJybOxjJ/QNCdt2eZHGjNV0CaIILuzK1+hftTdlZoDj77xtpf/d+JXVRHXHTc
	futEKd/W6LojKaS8x2K+K2s7QdxbGwFR+mjC2Fg3m2JM0MUB/KTAa3qiTdqEVaoBU=
X-Received: by 2002:a05:600c:c0c8:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-492333e2958mr48897325e9.23.1781695616322;
        Wed, 17 Jun 2026 04:26:56 -0700 (PDT)
Received: from fedora ([196.77.26.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm138192065e9.12.2026.06.17.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:26:55 -0700 (PDT)
From: Jad Keskes <inasj268@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olivia Lu <luolivialean@163.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Alexander Clouter <alex@digriz.org.uk>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jad Keskes <inasj268@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: rng: timeriomem_rng: add width and mask properties
Date: Wed, 17 Jun 2026 12:26:41 +0100
Message-ID: <20260617112642.1897096-1-inasj268@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[163.com,gondor.apana.org.au,kernel.org,digriz.org.uk,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25216-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:luolivialean@163.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:alex@digriz.org.uk,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:inasj268@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[inasj268@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inasj268@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D5216992CE

Add optional width (8, 16, 32) and mask properties to the binding.
The width selects the bus access size for reads. The mask is ANDed
with the raw register value to allow only the entropy-bearing bits
through.

Update the example to show a typical 8-bit configuration.
Update SPDX to dual license to match kernel convention.
Drop the misleading '32-bit aligned' constraint from the reg
description since alignment now depends on the configured width.

Signed-off-by: Jad Keskes <inasj268@gmail.com>
---
 .../bindings/rng/timeriomem_rng.yaml          | 48 +++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml b/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
index 4754174e9849..636305f211c8 100644
--- a/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
+++ b/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
@@ -1,10 +1,16 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/rng/timeriomem_rng.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TimerIO Random Number Generator
+title: Timer IOMEM Hardware Random Number Generator
+
+description: |
+  This binding covers platforms that have a single IO memory address which
+  provides periodic random data.  The driver reads from the address at a
+  fixed interval, returning a configurable-width value masked to the desired
+  bits.
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -13,9 +19,17 @@ properties:
   compatible:
     const: timeriomem_rng
 
+  reg:
+    maxItems: 1
+    description:
+      Base address to sample from.  Must be aligned to the configured access
+      width (1, 2, or 4 bytes) and at least that wide.
+
   period:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: wait time in microseconds to use between samples
+    description:
+      Interval in microseconds between reads.  New random data is expected to
+      be available at this rate.
 
   quality:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -26,16 +40,26 @@ properties:
       instead.  Note that the default quality is usually zero which disables
       using this rng to automatically fill the kernel's entropy pool.
 
-  reg:
-    maxItems: 1
+  width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [8, 16, 32]
     description:
-      Base address to sample from. Currently 'reg' must be at least four bytes
-      wide and 32-bit aligned.
+      Access width in bits.  Determines whether the read is performed as
+      an 8-bit, 16-bit, or 32-bit bus access.
+
+  mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0xFFFFFFFF
+    description:
+      Mask applied to the value read from the register.  Bits set to 0 in
+      the mask are cleared in the output data.  Default (no mask) passes
+      all bits through.
 
 required:
   - compatible
-  - period
   - reg
+  - period
 
 additionalProperties: false
 
@@ -46,3 +70,11 @@ examples:
         reg = <0x44 0x04>;
         period = <1000000>;
     };
+
+    rng@64 {
+        compatible = "timeriomem_rng";
+        reg = <0x64 0x01>;
+        period = <50000>;
+        width = <8>;
+        mask = <0xFF>;
+    };
-- 
2.54.0


