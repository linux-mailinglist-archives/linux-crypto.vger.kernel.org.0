Return-Path: <linux-crypto+bounces-25743-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GTnBMlaQTmoZPgIAu9opvQ
	(envelope-from <linux-crypto+bounces-25743-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 20:00:54 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66434729623
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 20:00:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HTUPiprO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25743-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25743-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B86307A9F9
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2026 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C902C43713C;
	Wed,  8 Jul 2026 17:59:19 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCC4ADD8E
	for <linux-crypto@vger.kernel.org>; Wed,  8 Jul 2026 17:59:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533559; cv=none; b=YHj63r0Lwx94IXf/QOvEyNY5AYWkStYZ1RIkBsKA/o+v0nKKY/hvJAIo1KFIDcyHewz2tnai4R6FJ9ldsmqmKbm98lRzlwhmi3ec1oirDmk95lNLY+hqC0uLIpCaRVjoLvHrUqqv7h0hfQczM0iOb2ijiIK7PbBuAeFQMCCP1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533559; c=relaxed/simple;
	bh=g0zBm/HT/JX8+0Ve2noPh/XhrvlAOxSKonPdGSV7PAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KraETYkpOlWZVFybNnCJLSStvx4+oSkY8Ylngfey39Q8iaS2AoTGm34ndXZNEJYXd4n/wjbxUcEjrVtgkjwLanyCfZD9Fq+GB11SWPeaNWqi4YC3T9LyGyaghtNyNVTVCpucSqr7rCXZsNE15TP7Nk8SINpEO/ye0QufDgC30HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTUPiprO; arc=none smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1276f8414bso118538866b.0
        for <linux-crypto@vger.kernel.org>; Wed, 08 Jul 2026 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533555; x=1784138355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3RbPrXYdQbVWUvs+F9bureO/gAjNoSjgQ1E6c4QgBI=;
        b=HTUPiprOuzgdZnrc0eX8kY55b194o0cAPFEbqczJQ+cxhsdwf9tVdkoZ1GdapfWfK7
         FlMnBf9AV8J9zM9QfeXGZzMmc7tBB13liJgTwx83Nm6lTDVg+lDWRYQONI3PvpziBPUV
         pFR4vDE1pqS24Hy+GQGUrf6xF0ioj1zvqaZ6eccK1vRkJbUDkMaXwNtGlyiD3didMm2u
         HrJlQZz0XNzw/6/c0jRZ4tbSIIqP4R3oa/XKUBvd/wk0D/tS3JefJTRkV8hGMTyaIxSC
         kgaMZloiBUVTJ1IOSZB5pv55Is1MV0i0MZSMeiSlikQWpsi6MseRIlsrT1CLEP38kAvq
         n68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533555; x=1784138355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3RbPrXYdQbVWUvs+F9bureO/gAjNoSjgQ1E6c4QgBI=;
        b=oTIenabOafpQh+R5ReCklqX5Y0pMBY6iyErykrnay/f4xxRvBPXDS5o8DRtA4Ne1v7
         94n6cDtEilcoNa7NIIKURmMg6t5rAuwLIx8g14zE+04Rqc2IlSG4QOhivasDuT6NHakn
         pRU2meJERYRLgnxc0+r5ahQlbLjNjydVh46apoTy3j1p2XHkdfwu54RqyJY0hly+zdxI
         +cKzDjTuL+knPRy3N64u36nOM7MkTPQUhcBM0PTAPK8FdCO23Fmo9VZPJmI4gYPahWgs
         vBqx4vFnFYEGSp+gp8JAjO40jRv/6IeERbmkfzX4hnq/EwWB9OGVcqa3ItTIHqdaVPic
         rA1g==
X-Forwarded-Encrypted: i=1; AHgh+RpaRHFnrhSkOCitKYUsSqZ5jY7/iISf3Nf1tnEBwia/MDAxteHFFxU/rmU+5wyipMoOnd0hkd5TKCjE1c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UlAv97g4yWsjRt5pg08fXrkinCg2Oo6oB6bfPVNSOZ0+tHAl
	BCIVK+xPn9zd8JZo+prxNL+wZRPbrFBcfcacwL+Nn1WfkFfDSRX4eP7Z
X-Gm-Gg: AfdE7clE1WthSZMBwcoI6cTJizv1DWRLaicleJsM3ii+UI6PdWsPwsZoYoAj+BIngVa
	hrGTwLbf+SOfBQHuuw2gUOYh0HU9b+zUjq5PsQycw1uodzOiJ+e4maSpezfPDvyZuf4Oj7Yl5C6
	bkUTm5/ND4Yia4T/tqpvOyVvYvaNZ1JaCg+OZdUH3P6QfL4U3x9ZHQMR+IJgyDUM1MRaWOqMVq/
	Pl2ZBHG1peRXFlhFKDMW5sP4UzKV6Cm3UjdfKNocOd4NkzJvizk+h8wcA8M6dJQoyHIT391rJ3v
	TKWZvEEPy+1W2z4EcKUCk33igrEGfkqiBRIZOZARvUguc3dqsoabihtOSLe774gVV+WiML/b3cG
	n6cvkDbJViXEwgn3wk/584eiL4Ady1SqaX+stErb+7bL+4lWTaO7Fk+83PzNpYYDcXQtdw/ED5A
	VLudbHUXJSaQqMwRkk
X-Received: by 2002:a17:907:3f18:b0:c11:f4d6:48fc with SMTP id a640c23a62f3a-c15ce1c331cmr188941466b.45.1783533555363;
        Wed, 08 Jul 2026 10:59:15 -0700 (PDT)
Received: from olympus.. ([2a0a:ef40:ea3:3f01:2e0:4cff:fe68:285])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bcc26sm357653666b.34.2026.07.08.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:59:14 -0700 (PDT)
From: Dawid Olesinski <dawidro@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Corentin Labbe <clabbe@baylibre.com>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dawid Olesinski <dawidro@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add crypto node to rk3588-base
Date: Wed,  8 Jul 2026 18:58:25 +0100
Message-ID: <20260708175837.1718437-5-dawidro@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708175837.1718437-1-dawidro@gmail.com>
References: <20260708175837.1718437-1-dawidro@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25743-lists,linux-crypto=lfdr.de];
	FORGED_SENDER(0.00)[dawidro@gmail.com,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,baylibre.com,vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:clabbe@baylibre.com,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:dawidro@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawidro@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66434729623

Add the device tree node for the V2 cryptographic hardware accelerator
on RK3588.

On RK3588 the crypto IP sits inside the secure domain controlled by
SECURECRU, a register bank that is exclusively accessible to the
TrustZone firmware (TF-A). Linux must therefore obtain its clocks and
reset line through the ARM SCMI interface provided by the firmware
rather than mapping the CRU registers directly. Attempting direct MMIO
access to SECURECRU from the non-secure world triggers an asynchronous
bus fault.

The interrupt uses the four-cell GICv3 format as required by the RK3588
GIC node definition (the fourth cell is the CPU affinity/partition
specifier; 0 means no affinity constraint).

The node is disabled by default; board files that wish to use hardware
crypto offload must enable it.

Signed-off-by: Dawid Olesinski <dawidro@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc1fdbfd3162..a7560b09aeb6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2447,6 +2447,18 @@ sdhci: mmc@fe2e0000 {
 		status = "disabled";
 	};
 
+	crypto: crypto@fe370000 {
+		compatible = "rockchip,rk3588-crypto";
+		reg = <0x0 0xfe370000 0x0 0x2000>;
+		interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&scmi_clk SCMI_CRYPTO_CORE>, <&scmi_clk SCMI_ACLK_SECURE_NS>,
+			 <&scmi_clk SCMI_HCLK_SECURE_NS>;
+		clock-names = "core", "aclk", "hclk";
+		resets = <&scmi_reset SCMI_SRST_CRYPTO_CORE>;
+		reset-names = "core";
+		status = "disabled";
+	};
+
 	rng@fe378000 {
 		compatible = "rockchip,rk3588-rng";
 		reg = <0x0 0xfe378000 0x0 0x200>;
-- 
2.47.3


