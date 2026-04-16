Return-Path: <linux-crypto+bounces-23033-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMfdEMmF4GlPjAAAu9opvQ
	(envelope-from <linux-crypto+bounces-23033-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 08:46:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBFC40AC18
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 515F8309A84E
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03C37BE72;
	Thu, 16 Apr 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="DyoDhw6O"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E53264D9
	for <linux-crypto@vger.kernel.org>; Thu, 16 Apr 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321960; cv=none; b=DACAOtkIwy8o4sR/Ez0dlFFcDexAzgKA3HcBLDBZTGyCpPtOL06VuQvl4XhM6ZGfF5zc2szFez+jHa8FRXZqmiSImb5Je4nyhQnAmCeRRCcjKxyvdi+0HIq8t39in7OUkbCP6cLjpp4gbf+d1fk0DX/0Iv6JOf9iisqhvi3sMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321960; c=relaxed/simple;
	bh=1rCkpkHyHE3IPuAx81k2bwmc4nwhuww71wQ9MS0fnZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bd+RlsUmMkNSYkUu9JQtIfmFHePqHMrhqC9f9DKeBfPXQZNA6Ro4vWkZpbU6jxTegku+5HRrHfzyvZJOJGdrMbU7zGWakYYwQNt8eCQU35YfqeNlstuRbgYaVyf0Cdx6XkBko8pCrQ5L520IX+x80/R8GQcvXWw6IGSrjA6UNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=DyoDhw6O; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82cf636dac8so3382445b3a.3
        for <linux-crypto@vger.kernel.org>; Wed, 15 Apr 2026 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1776321958; x=1776926758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WO3LsK3AW3by8XZxWRGcuY2BsjgbgR+h9RmVDdaQIY=;
        b=DyoDhw6OVq2Wxd2PoBMKerj5Fk5u8ppOXcTH56OFfZL+L8+UCeX877JWsu8feITiV9
         WXn3b4iEF7T70H0w+rREuTD0K1QFjLjC9E46874hoLD70AwHcUwM8wr7WvnrX8lITfsF
         cJe/YFKGQYI1L5HsZrvXXrQ0Kgnuxuz6QHdsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776321958; x=1776926758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WO3LsK3AW3by8XZxWRGcuY2BsjgbgR+h9RmVDdaQIY=;
        b=dV1lQR4UiYhQzXO7+B3f4ViCcFy/0L/b4GZ6H5J7PD944m1Rl694/4Jj2w/zloXGcC
         fpBkcoKuebtya9UpXDxFMkIBoAcc9tru6ew7M+tHAEvYBse8weC7T6BcZwVTBT5QSGN3
         2tVFvrsN5aTRG91bY/LGmkzrVwoDpH91EpQ9KN7uMZSViX8fuWs+MpYu5a0pX1uXDUTO
         9hYRzRhqQqtcpHypG7+Wgsfs4PmC2lReVSogxiPkNux0ZLUa7sxV4DyqfWzIk2rNFqLD
         s5xjPLM1PjznRzzvr4Y3U4KmHPAc2NyZrSU6/6Ky3aI+orupasBYgmmHesqV0v2ZurrY
         CQ6w==
X-Gm-Message-State: AOJu0YzXnAbcdNKP9+9YDGXhRVvuWnW3uH2tLaWqz9L5iJuWDelarRlb
	IOSGg5ijMmJ4DYdyfRXRX85Ht5Orc/tTufJB+rPbk8gsRnwy3D/sZc031WJ7NszgqM0zZc1igMo
	aA7zha0i4Mw==
X-Gm-Gg: AeBDies8twQZoQaQIr2ISt/lRKFc8pqc3Y2XtGKS2gCVylVWwoWX7y7rUqvn61P+DbD
	Rqnz6a0IQqYIFHNMTTklyYox6HCl2dNZLVMCgLGHHaVHKBNuioBHy6oKLxvWyttNAQMP/meQ5dJ
	RoyE/voAvU3HEnkUcaGgZ7duqxK48p1k1n2LkAQkW8JJNxMj9f4Nhz1NnrD8Qge26JjB/LNbRYy
	C/iRQAVGjnJZhyoerIpPcY5xXyniTIPi5F3Dfj94V7Rw51eXrK76VIqpjLIVIkzAdBkUCSASYcV
	uUrHPP4ShCq731vCrpxu+kCQYuk9Au5mrRh2wzbt2etv+Z6bwdHQhSfQDPaXZXzA9e4CzCv4p9y
	oDZ8EXfw862h/0+6EKZXTKSWaBGsQOkvUWjVOkFyix7bK/e55Ew9WKZq8PhL+t2mEs2szZS9Guc
	1IXNFTC5q2HiOYkkOjmjgj0+63KLu45Xr8jRkvW/DRuaP+if6EmPOv6hVr7O7ZcG3wxXYx0Yh9D
	BSo6DliHx9GfuZnddPgaJaShws8xGryfDdVm41CFDYrRiTAx6zsb360ojavk6GIiRA=
X-Received: by 2002:a05:6a00:3987:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-82f0c38a1demr25856946b3a.37.1776321957983;
        Wed, 15 Apr 2026 23:45:57 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67418a47sm4107066b3a.48.2026.04.15.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:45:57 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	navami.telsang@vayavyalabs.com,
	bhoomikak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/4] dt-bindings: crypto: Document support for SPAcc
Date: Thu, 16 Apr 2026 12:14:48 +0530
Message-Id: <20260416064451.99886-2-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260416064451.99886-1-pavitrakumarm@vayavyalabs.com>
References: <20260416064451.99886-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vayavyalabs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vayavyalabs.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23033-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavitrakumarm@vayavyalabs.com,linux-crypto@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vayavyalabs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:email,vayavyalabs.com:email,vayavyalabs.com:dkim,vayavyalabs.com:mid,2.98.90.0:email,linaro.org:email]
X-Rspamd-Queue-Id: DEBFC40AC18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DT bindings related to the SPAcc driver for Documentation.
DWC Synopsys Security Protocol Accelerator(SPAcc) Hardware Crypto
Engine is a crypto IP designed by Synopsys.

Co-developed-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Signed-off-by: Bhoomika Kadabi <bhoomikak@vayavyalabs.com>
Acked-by: Ruud Derwig <Ruud.Derwig@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/crypto/snps,dwc-spacc.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml

diff --git a/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
new file mode 100644
index 0000000000000..857e5c6d97fc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/snps,dwc-spacc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Security Protocol Accelerator(SPAcc) Crypto Engine
+
+maintainers:
+  - Ruud Derwig <Ruud.Derwig@synopsys.com>
+
+description: |
+  The Synopsys DWC Security Protocol Accelerator (SPAcc), which is a
+  semiconductor IP designed to accelerate cryptographic operations,
+  such as encryption, decryption, and hashing.
+
+  In this configuration, the SPAcc IP is instantiated within the Synopsys
+  NSIMOSCI virtual SoC platform, a SystemC simulation environment used for
+  software development and testing. The device is accessed as a memory-mapped
+  peripheral and generates interrupts to the ARC interrupt controller.
+
+properties:
+  compatible:
+    items:
+      - const: snps,nsimosci-hs-spacc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto@40000000 {
+        compatible = "snps,nsimosci-hs-spacc";
+        reg = <0x40000000 0x3ffff>;
+        interrupts = <28>;
+        clocks = <&clock>;
+    };
--
2.25.1


