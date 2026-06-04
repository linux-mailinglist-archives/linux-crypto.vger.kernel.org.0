Return-Path: <linux-crypto+bounces-24905-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A24vHfmvIWoHLQEAu9opvQ
	(envelope-from <linux-crypto+bounces-24905-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 19:03:53 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9B56422A1
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 19:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vayavyalabs.com header.s=google header.b=Uyt6WeCm;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24905-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24905-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=vayavyalabs.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A235030C0A8E
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5549253C;
	Thu,  4 Jun 2026 16:54:45 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CC47ECD3
	for <linux-crypto@vger.kernel.org>; Thu,  4 Jun 2026 16:54:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592085; cv=none; b=m+M+lhsM3mLP9UpcqKwg+DjP6nZ6OoH5kTBwOf4B4DrN8KCvqyixPNQfsFunqSb8CyDoBUENc6uSW8ImGsbkjeVKQwlvwBHx+WUY1U8I9QrRN5gyHEQR+/HgpMZHYcezg3PyGwwKbwiJagaa/WJ8a3W6TamTqL6ItnQhC2vjFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592085; c=relaxed/simple;
	bh=rABbYZThzUNlASAg9PNrF9XDHFdMGNnw3+CijB5LI08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecYVzJkhYsg8v49YkT3jWr2pmgiRwZGeESyt8bAWgTx4cEAe69W5OWE6zFqumJV2d97NyEs0taLOAZOYzfLjytliPhezAWjb8Rxk1IATiwPYdJ6E80u7iTscFk1RG/NTJdofAkTcpu+10jDAkxArNLXjjfiIJ9WVhGuYVrnZmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=Uyt6WeCm; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b9033d230so570466a91.1
        for <linux-crypto@vger.kernel.org>; Thu, 04 Jun 2026 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1780592083; x=1781196883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkZvHdMfG2/miY1eJGcyaUgMffG3UaOtedsqc4De/Z4=;
        b=Uyt6WeCmqzpryxssDTkjul2TvH/Oes+JTekrQcH25+jivBhy3wOr/nkgeGcJIaNsz8
         D5iP9t7T2/MHUUochh5bRcx6UCFvP6909F4njEfHr6Nr5IHuHxivgVIJHHecMeEZNxaF
         5DIt7ioRTrieuLHed9A2slDr9TZFHrbQFjMYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592083; x=1781196883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkZvHdMfG2/miY1eJGcyaUgMffG3UaOtedsqc4De/Z4=;
        b=k2MxjRH2LP26/Q79zUBs0iRaKGc1QzZvw/aylIRkuStlFgj35IFhTuePhxukch+unC
         hEXeVA90PXD8c+IX8EeR4thc7HXoAymzcg1FfCch5WDA4N3NmVCtixyOp2GOW64vyh8/
         6y9EzfSw2H+1MY1yQkbPCWnGen0vRJr0r0xrX9ThOKPAVg2Wpt+bPfEpg1e/7EEVF5sy
         tNPOjdJyIXJ1SGCy3zyXAxdaLql+TK2ckgLFjnQkBGTcn09LoesAMv2xrAlylcYqbcJP
         IU7/mR05L9hxZL2qpm5HCdGuBRseWatRkJOgh/NrqBFxjJthpKfroArtZ8k6Am0wpJJf
         a77w==
X-Gm-Message-State: AOJu0Yz9xVjz8rnfLKkhoHfIfXDc8QWJMg/iR3X03TETg17T/czwzhrQ
	kBAmdqSFUaMZiu32yuckY5s2mrSn4aEamWAiNlX+bISrnrC4tUlp8mWvSERAU/2VY6AuGxwyStM
	PHEOr
X-Gm-Gg: Acq92OFBwAnvy+I3Og1UXxohLJhPlBbxTKplJ+eXV4qmEgCPPCXJU50eWHNTYTqrJRM
	vHv/OkCxugAeudO8FgCepUqOCbiseBfzQhh+ub7NRMyxAYoLpb4ieN2hOZJcpI6Aqdy+Eh2qk8O
	pLrpn81QD1HWaPeX0v2AaP3TCgQBvKy+XXhfefVLUxGlT+AxTTQ0E4U8ctgEtCMckisRwkc6NEY
	AJ7oeajRK8M1yN4PG3c00Xc01ngGB/lJt7SLD9oTSt8CUxNQ0AMHS1ZG0uB+9WsVoHXoMVRhmGk
	PATyjj02sE9WLpdzqC8A6PKVjJ5OT/EZCzthCsSiWct5N8+GKk/6Wl7c8JaTQKRs91f5VgIWn22
	5p5oHEIDa9g9pZlPB1xLhLCIOWySQ9TG2EhOByj/Xnix2ovkcCFBnONi+YOyl2eDEJL4Ji+anm3
	GQbGL7q0a61VUZYw0J5W8gozSkoenZ8YctechDomOIgJwodsiUTIhGAj7xFIIwHWcPKT+e6I8Qs
	b9T5VvbPggsbZQmoFd9QF721Aaotnp8BsceNouQPN0BSnodtKaMQWyyhInBCjg3JmqBYpq8wjn8
	wA==
X-Received: by 2002:a17:90b:520d:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-36f778fc247mr3693015a91.10.1780592082773;
        Thu, 04 Jun 2026 09:54:42 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e7b53sm3689229a91.14.2026.06.04.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:54:42 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	rbannerm@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	navami.telsang@vayavyalabs.com,
	bhoomikak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Subject: [PATCH v13 4/4] crypto: spacc - Add SPAcc Kconfig and Makefile
Date: Thu,  4 Jun 2026 22:22:10 +0530
Message-Id: <20260604165210.1141842-5-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260604165210.1141842-1-pavitrakumarm@vayavyalabs.com>
References: <20260604165210.1141842-1-pavitrakumarm@vayavyalabs.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vayavyalabs.com,reject];
	R_DKIM_ALLOW(-0.20)[vayavyalabs.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pavitrakumarm@vayavyalabs.com,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-24905-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:conor+dt@kernel.org,m:Ruud.Derwig@synopsys.com,m:rbannerm@synopsys.com,m:manjunath.hadli@vayavyalabs.com,m:adityak@vayavyalabs.com,m:navami.telsang@vayavyalabs.com,m:bhoomikak@vayavyalabs.com,m:pavitrakumarm@vayavyalabs.com,m:conor@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavitrakumarm@vayavyalabs.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vayavyalabs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synopsys.com:email,vayavyalabs.com:mid,vayavyalabs.com:dkim,vayavyalabs.com:from_mime,vayavyalabs.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B9B56422A1

Add Makefile and Kconfig for SPAcc driver.

Acked-by: Ross Bannerman <rbannerm@synopsys.com>
Signed-off-by: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
---
 drivers/crypto/Kconfig            |  1 +
 drivers/crypto/Makefile           |  1 +
 drivers/crypto/dwc-spacc/Kconfig  | 88 +++++++++++++++++++++++++++++++
 drivers/crypto/dwc-spacc/Makefile |  8 +++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/crypto/dwc-spacc/Kconfig
 create mode 100644 drivers/crypto/dwc-spacc/Makefile

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3449b3c9c6adf..00d67990644d4 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -774,6 +774,7 @@ config CRYPTO_DEV_BCM_SPU
 	  ahash, and aead algorithms with the kernel cryptographic API.

 source "drivers/crypto/stm32/Kconfig"
+source "drivers/crypto/dwc-spacc/Kconfig"

 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 283bbc650b5b2..d106c1c729060 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
+obj-y += dwc-spacc/
 obj-y += hisilicon/
 obj-y += loongson/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
diff --git a/drivers/crypto/dwc-spacc/Kconfig b/drivers/crypto/dwc-spacc/Kconfig
new file mode 100644
index 0000000000000..f9752e6f664b8
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Kconfig
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_DEV_SPACC
+	tristate "Support for dwc_spacc Security Protocol Accelerator"
+	depends on HAS_DMA
+	select CRYPTO_ENGINE
+	default n
+
+	help
+	  This enables support for SPAcc Hardware Accelerator.
+
+config CRYPTO_DEV_SPACC_HASH
+	bool "Enable HASH functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	select CRYPTO_HASH
+	select CRYPTO_SHA1
+	select CRYPTO_MD5
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_HMAC
+	select CRYPTO_SM3
+	select CRYPTO_CMAC
+	select CRYPTO_MICHAEL_MIC
+	select CRYPTO_XCBC
+	select CRYPTO_AES
+	select CRYPTO_SM4_GENERIC
+
+	help
+	  Say y to enable Hash functionality of SPAcc.
+
+config CRYPTO_DEV_SPACC_AUTODETECT
+	bool "Enable Autodetect functionality"
+	depends on CRYPTO_DEV_SPACC
+	default y
+	help
+	  Say y to enable Autodetect functionality of SPAcc.
+
+config CRYPTO_DEV_SPACC_DEBUG_TRACE_IO
+	bool "Enable Trace MMIO reads/writes stats"
+	depends on CRYPTO_DEV_SPACC
+	default n
+	help
+	  Say y to enable Trace MMIO reads/writes stats.
+	  To Debug and trace IO register read/write oprations.
+
+config CRYPTO_DEV_SPACC_DEBUG_TRACE_DDT
+	bool "Enable Trace DDT entries stats"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+	  Say y to enable Enable DDT entry stats.
+	  To Debug and trace DDT opration
+
+config CRYPTO_DEV_SPACC_SECURE_MODE
+	bool "Enable Spacc secure mode stats"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+	  Say y to enable SPAcc secure modes stats.
+
+config CRYPTO_DEV_SPACC_PRIORITY
+	int "VSPACC priority value"
+	depends on CRYPTO_DEV_SPACC
+	range 0 15
+	default 1
+	help
+	  Default arbitration priority weight for this Virtual SPAcc instance.
+	  Hardware resets this to 1. Higher values means higher priority.
+
+config CRYPTO_DEV_SPACC_INTERNAL_COUNTER
+	int "SPAcc internal counter value"
+	depends on CRYPTO_DEV_SPACC
+	range 100000 1048575
+	default 100000
+	help
+	  This value configures a hardware watchdog counter in the SPAcc engine.
+	  The counter starts ticking when a completed cryptographic job is
+	  sitting in the STATUS FIFO. If the job remains unprocessed for the
+	  configured duration, an interrupt is triggered to ensure it is serviced.
+
+config CRYPTO_DEV_SPACC_CONFIG_DEBUG
+	bool "Enable SPAcc debug logs"
+	default n
+	depends on CRYPTO_DEV_SPACC
+	help
+          Say y to enable additional debug prints and diagnostics in the
+	  SPAcc driver. Disable this for production builds.
diff --git a/drivers/crypto/dwc-spacc/Makefile b/drivers/crypto/dwc-spacc/Makefile
new file mode 100644
index 0000000000000..45d0166dfc8f7
--- /dev/null
+++ b/drivers/crypto/dwc-spacc/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRYPTO_DEV_SPACC) += snps-spacc.o
+snps-spacc-objs = spacc_hal.o spacc_core.o \
+spacc_manager.o spacc_interrupt.o spacc_device.o
+
+ifeq ($(CONFIG_CRYPTO_DEV_SPACC_HASH),y)
+snps-spacc-objs += spacc_ahash.o
+endif
--
2.25.1


