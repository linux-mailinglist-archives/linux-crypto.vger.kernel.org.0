Return-Path: <linux-crypto+bounces-5214-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B7915A5B
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Jun 2024 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9C4B2305B
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Jun 2024 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4981A2C04;
	Mon, 24 Jun 2024 23:23:06 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06671A255B;
	Mon, 24 Jun 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271386; cv=none; b=ZBQ7UH5+Pb4iaw33GOYlbijxcaBckzSZWpFaUGm5HFEER6Sn3vrXnlIfEL8ORzlup6nrQJRb4l6kFuugQC9jOkqwB0k8EbehcjjmFScPslRg9fLa0y2c2Ji2a6ZMYxd5sXrqKrEpr7xr65fdlhtQTPF8rN0Cyct1arDhpzaK9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271386; c=relaxed/simple;
	bh=KvmbdydXpOos6pQj7PzGDoZI5wEE4oJZr9Q2b/564JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gupMK45ntUXGFSlWju8WgkU4yFGSRZP7dUB0EDKh15XFj8bWHdtRat3K7pn2foZ1ou12FmdvScHN8ks/SNl0z732xE4dttG/2JYXoNGsQJ1qsjX9fHywqhmAWg5tONPxLBCVRCVcHNQoN3zv7qHky2ziTYA9NaO6hgIZYaYtPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687B7DA7;
	Mon, 24 Jun 2024 16:23:29 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8797A3F766;
	Mon, 24 Jun 2024 16:23:02 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: allwinner: h616: add crypto engine node
Date: Tue, 25 Jun 2024 00:21:10 +0100
Message-Id: <20240624232110.9817-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240624232110.9817-1-andre.przywara@arm.com>
References: <20240624232110.9817-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 SoC contains a crypto engine very similar to the H6
version, but with all base addresses in the DMA descriptors shifted by
two bits. This requires a new compatible string.
Also the H616 CE relies on the internal osciallator for the TRNG
operation, so we need to reference this clock.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 921d5f61d8d6a..187663d45ed72 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -113,6 +113,16 @@ soc {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		crypto: crypto@1904000 {
+			compatible = "allwinner,sun50i-h616-crypto";
+			reg = <0x01904000 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>,
+				 <&ccu CLK_MBUS_CE>, <&rtc CLK_IOSC>;
+			clock-names = "bus", "mod", "ram", "trng";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h616-system-control";
 			reg = <0x03000000 0x1000>;
-- 
2.39.4


