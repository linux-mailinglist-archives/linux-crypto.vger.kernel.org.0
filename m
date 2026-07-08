Return-Path: <linux-crypto+bounces-25742-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J+3lMyyQTmoFPgIAu9opvQ
	(envelope-from <linux-crypto+bounces-25742-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 20:00:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867F729611
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 20:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NLqYK+Fx;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25742-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25742-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8CF305775B
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2026 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CAD4A138B;
	Wed,  8 Jul 2026 17:59:15 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D344BC92
	for <linux-crypto@vger.kernel.org>; Wed,  8 Jul 2026 17:59:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533554; cv=none; b=UHwP902em33LJvM+cGnHDiXbi+eoqBXgvWxzS19Ipg6xyOrNeHF1K4srrS/DacdLqrgleDvc+kiI6vtLun54SPQX4dSHuciW7AaCe3XHSnYfWU8leoaKi2tzcyoN166ScCEuO7/akKU96oTnHZMNpKIDXYx8fwMSGkDQLLpc7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533554; c=relaxed/simple;
	bh=kBDjEzQ80kgpn8wJAREQLaXT5HdibWwvuZRJylSEIBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz5jHI8w2zI65NJmKlZB7FW/dB0FtQQtve904eq1NGZsc1Wy1DvaTWSBOzepzk9xlBt5TPCOALdVRAFlkiErAmkdP/tZit1v3H31oaLErcmWiGoQ8NWKiYgNgYI5/RPllgOR/6p6HQ2D6GLPMWudfKaUHZ+a/aaMq7g8qcNFEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLqYK+Fx; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so95973866b.3
        for <linux-crypto@vger.kernel.org>; Wed, 08 Jul 2026 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533552; x=1784138352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sa+hq1ddPX1RzBXoQyE6BmGgQ/wGb1XIxI/SPhDUhIA=;
        b=NLqYK+FxxhKI3Ept5cV/2oaeL7lvywevLOCb7ZxMk9aRRKRzlPoPPMwY2SK18LNKEy
         XKRPu37fICoBPkgK1e4pTBiM0DfW1V+i+B44JAlHboWWNBHDXmZjAgPCbcjfISkwMTgL
         8NBCsXEkV9m6OeNARyq186dDRDSjDFAUBAPobIr8vmenFb60ggR/iUWOumKu8YmHy56p
         CCgqOhBjZ+BAxG7RfjlvP7+YfeExv/1UnOvT/5pZdL6S8JLSzB15pGroY8ASM05W55BY
         +ec5nlGNGAWI9SZ4wv/lx6bt4UeoUDjwgsslLFv+MEjfsLtdixcDkpHk1wXXu7rYmkfc
         +bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533552; x=1784138352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sa+hq1ddPX1RzBXoQyE6BmGgQ/wGb1XIxI/SPhDUhIA=;
        b=NtGZoZU4BqeRlOdGS8AVaGhykX2jnr5HnlwlsbZbMaQAhnGurdxhC6eFiK4+RYeni4
         1srxuAOv93MYQj6sEW9M/POuOuCsBnlw0idafH63EJvikEYcGkwKtsKxpgGlaM/CJMzZ
         zRyfLkytGiFOKsgLkKsLTFB+hTwovBr1xOpmPzgc9P9pWQFyze0piY4JwPTC4F6g+gcN
         41j9e4B5CUT8MQ2iszMrNyH+aVYhS30StyC8Ds8hWeZYrC88lCIA5zRRm7nH1XWs2Gtn
         NNvZRuZkPExYijWJYiKRZx42KqMNPS6teFkJQAGt4tKt5qhSo77bgm8WiDYfLF0Ko9fY
         CRuA==
X-Forwarded-Encrypted: i=1; AHgh+RqICl4MH05f2XDJWOaBBpN5fcF1sW/Zm/tfwUHSPFqIVLAQgPrMR7+SWJDw4hsI5OwZPXv8IalYj0PuDOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQylRny5TcBFJm5+aySZ52qtTcej1sa3J87Gnv+cZrInCqtCvz
	UBQu1aXT9A+D8fEBgfrwRynxAFCydGmqVBpU6o//Rf6yErEXVzRh90Fr
X-Gm-Gg: AfdE7cnNQLOi2eKePy9I/an32nhPnSmaZXhp6chr0vT81E9IFCsxAbO5Zc0FekgtX1K
	g7R0a9oC3pNuEOPLcrZgk5P3NPaX5RiSIXYpDgC0DqXcq3X+SPzrGrxsgF34vgMtkI6BCTTUqxu
	tKxsGD3QVUbeigF6GjVFSJ5CjO4fwRENXbsZW4AJOqlJvcksreVqnPQqDtysR1XHf2RS8hehvMl
	sBPU77+4qYg2zxN+1pIzMsz/8b9zgNd9cZmccpZMn6osPFRXdnHOWQirMaBJAxeQBUKDvM9iAUY
	Pgg5e7QW4JzAt4+mnwBLXrHL4KeqoYLb8lAOGFSqS37kaTNORkyb8CMiBzhccCV677wpxxVcViK
	2CkrU3BOFSoYfZRrMrmXvxZjVRW/AjFfWUrz5IhgeZUBS/g4YWlAPihcy/tEuDtJPGchW9cktmx
	cqfoUEew==
X-Received: by 2002:a17:907:9406:b0:c12:6a72:5882 with SMTP id a640c23a62f3a-c15cde71af8mr169523166b.5.1783533551631;
        Wed, 08 Jul 2026 10:59:11 -0700 (PDT)
Received: from olympus.. ([2a0a:ef40:ea3:3f01:2e0:4cff:fe68:285])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bcc26sm357653666b.34.2026.07.08.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:59:11 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add crypto node to rk356x-base
Date: Wed,  8 Jul 2026 18:58:24 +0100
Message-ID: <20260708175837.1718437-4-dawidro@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-25742-lists,linux-crypto=lfdr.de];
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
X-Rspamd-Queue-Id: 0867F729611

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
index a5832895bd39..9de7e7487ca1 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -1112,6 +1112,18 @@ sdhci: mmc@fe310000 {
 		status = "disabled";
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
 	/*
 	 * Testing showed that the HWRNG found in RK3566 produces unacceptably
 	 * low quality of random data, so the HWRNG isn't enabled for all RK356x
-- 
2.47.3


