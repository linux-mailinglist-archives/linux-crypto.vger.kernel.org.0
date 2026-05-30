Return-Path: <linux-crypto+bounces-24751-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3fk1MMALG2ql+ggAu9opvQ
	(envelope-from <linux-crypto+bounces-24751-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 30 May 2026 18:09:36 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA260DEE7
	for <lists+linux-crypto@lfdr.de>; Sat, 30 May 2026 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E30230421FA
	for <lists+linux-crypto@lfdr.de>; Sat, 30 May 2026 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E033F594;
	Sat, 30 May 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqF2hDXX"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB13246E8
	for <linux-crypto@vger.kernel.org>; Sat, 30 May 2026 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157242; cv=none; b=ugiQKT7fwGx2B+8gszmcuhV8H1X994uEADP9fIFXX4wvYfb8NLCMmWqlQr7xyMMRDk3m5yQVcFXCo1bgm+YGke1xOx8EBFbrCq6OzCjQ8jEbswk8XSqXbcdE9ftX/3P7lqmUKB2zaPi1ObbeiDGqZcFvIWqZFvhdz/qkv1+8OIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157242; c=relaxed/simple;
	bh=tZfd/ISESKohi7rVf3H86fUzZEpjAxBv1DvbXjeNK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUzC/t6JB0gH8XjRxnl5x+iR5yJ6uQ3DXskyBztvBZq9FKGLo48MqTAzbyyGYOi9YEcoD9g50CpBBdiYRWfIjJKLLseT+TZHZEUy+L/gEZcaBBIf91BHePS0aTx0gGTtSHBjEQBDQJdfDlcsJeb90dpLriGzWotAmt4uGZ7OoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqF2hDXX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45efb698ef2so188440f8f.3
        for <linux-crypto@vger.kernel.org>; Sat, 30 May 2026 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157240; x=1780762040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SJMrJ4Tyw4rnth10NKoarZEEEB3Q5hOPvF+j2hwsdo=;
        b=EqF2hDXXWHydBl2C49IydzSYwvEtoKSkO0FF+LuzVOnE1kWfh4XWvFEu1G+AyHSV06
         xxB+sA/ULyQhFwTiYcjSH8aBnBN+3OwksCDlKkMU3nS99falyqYcmw3yX0gMMKhokapa
         UvXPlQ1mC6cVp6oOf+6KBUwM8LYDBY9obHCa70a0hAIouU3RwLrppT/z9S17YRMjYGlZ
         KK1sWWqjcJTFbUg8FtwDrWOFSemRMC+C0E2WQ5NZnMwcC3use+JS+hCfTWmM2EITsSkm
         jo79R5GIClBEIum5rDYmckirLtxEVkjVGtdZH5GEIxvTu/kx/SQwyH9VweLqjNm2TFq4
         kLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157240; x=1780762040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SJMrJ4Tyw4rnth10NKoarZEEEB3Q5hOPvF+j2hwsdo=;
        b=qoDxbInGzWPb2gzQZCEiqw+Wb9Qe3VDniIHPrMol/F4Ecg9kyAyTy9V3rXoaqDca8b
         XMNKgXwLwg/5gH806sa15k/rEaEe6EPchjYNCQgQw+/nImJp2nIWyenWBvvKUkak26dD
         ccdIVHE6OPIYtkgnL8gSj0dyJCNXFkHDuh0wfrU9uH9p4zuYZ2pv1dz3Bcf0Z14BzAcF
         2c2AdVObEtC8YX/q4JLIbh+teqkpWbEi4ZcCV7Gw+DotXvQYEa0S6fnh4ZcpasXF1cOu
         MpKIXhME9PDNfoIx67ZOzsGLsUAuzjdurY0JZxc6Rc9Sf0XzQo0uL5Nfic5x9Otzt4gb
         6Rwg==
X-Gm-Message-State: AOJu0YzKKW8EWmHiPdSCjZuxjot9NhDCty8cNZG2/FbEQejmyO1Yal6p
	oFtQRjEv0pDEKVGt6SV882HfHD9dzpLwMMea+6bXHhp7/4LkZdvE5RDc
X-Gm-Gg: Acq92OE0eHhfn1vkOykoYzT4G6wTytVlr6Y3E1T8Ct5NQyjxBfQs2yYJkQ7PktnmB8Q
	j7Ce/OMphNygil/qzcCYz0puMym6/sKsisjKVz+qE8c/oOpbKP29OP48WnBdDbYo1ABklS+P7pr
	ikbC+C6nfxFPwavC1GyGcH4kMGbBLY4OnnRYNbSxGgyqKOpZ2UAqk8c3l2lG4631bCkzMe8X9pQ
	Cr4JQC8Hjz0e1Jg2Qsfmc0pOQYOsQQR7KV9dhK1Mu2RnAXcLwxo66HVSIvLbp+qu6Grjzm2V37k
	gmtAYLaY1bSGyA3LELcH9y1mKJIIfY/qyIf1cXzhg1F64Zk9SjEzdKZh+obC4RDOFIp//Mss8WJ
	f0M2yfzbQfviqtHkTt41AW+OACauNUJIErCVoXATUQ34NtVJgq9rk+g9Uy4AOMSAai1XtdZr0b0
	JGBAFfXDJpzCf3qG1YuP5+uETfkI4=
X-Received: by 2002:a5d:5989:0:b0:45f:68a7:38d0 with SMTP id ffacd0b85a97d-45f68a73a2amr1942009f8f.0.1780157239975;
        Sat, 30 May 2026 09:07:19 -0700 (PDT)
Received: from olympus.. ([2a0a:ef40:ea3:3f01:2e0:4cff:fe68:285])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm11667339f8f.0.2026.05.30.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:07:19 -0700 (PDT)
From: Dawid Olesinski <dawidro@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	heiko@sntech.de
Cc: linux-crypto@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	clabbe@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Dawid Olesinski <dawidro@gmail.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add crypto node to rk356x-base
Date: Sat, 30 May 2026 17:06:44 +0100
Message-ID: <20260530160704.3453555-4-dawidro@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260530160704.3453555-1-dawidro@gmail.com>
References: <20260530160704.3453555-1-dawidro@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,baylibre.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-24751-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawidro@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fe380000:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1d:email,fe400000:email]
X-Rspamd-Queue-Id: 60CA260DEE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the device tree node for the V2 cryptographic hardware accelerator
on RK356x SoCs (RK3566, RK3568).

The IP block sits in the non-secure peripheral domain. Its three clocks
(core, aclk, hclk) and reset line are accessible directly through the
main non-secure CRU, so no firmware intermediary is required.

The node is disabled by default; board files that wish to use hardware
crypto offload must enable it.

Signed-off-by: Dawid Olesinski <dawidro@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b..3b73a56046e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -1171,6 +1171,18 @@ gpu_leakage: gpu-leakage@1d {
 		};
 	};
 
+	crypto: crypto@fe380000 {
+		compatible = "rockchip,rk3568-crypto";
+		reg = <0x0 0xfe380000 0x0 0x2000>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_CRYPTO_NS_CORE>, <&cru ACLK_CRYPTO_NS>,
+			 <&cru HCLK_CRYPTO_NS>;
+		clock-names = "core", "aclk", "hclk";
+		resets = <&cru SRST_CRYPTO_NS_CORE>;
+		reset-names = "core";
+		status = "disabled";
+	};
+
 	i2s0_8ch: i2s@fe400000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe400000 0x0 0x1000>;
-- 
2.47.3


