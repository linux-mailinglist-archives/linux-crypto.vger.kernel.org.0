Return-Path: <linux-crypto+bounces-9396-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C0A2760F
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Feb 2025 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C97160F59
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Feb 2025 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853892144BE;
	Tue,  4 Feb 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gXYZ3Mpe"
X-Original-To: linux-crypto@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B3213E7D;
	Tue,  4 Feb 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683434; cv=pass; b=t2cIcSW2eJj3JJCobzErMqG493qppqPywgD5MQ+eNvNE5ueg01B5txFbMF7UCJvNBx2p6Z+1V+yF10bg30awlVTFGKs92lPNt3/bzIJHNG7s4PPqVuaKLRlLbpnelOPmDdpmGazG8Ia5IwZsMJ1uSc+5fyFTb3lUOevoCMdqG1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683434; c=relaxed/simple;
	bh=u+FxAfqeRNPTPn8oDj5OPMxq0lbgjmJKpSWFq0ZSTdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrckZJWOjMAjfBjdtCPAQSFsC1Z88tUorx19j4I+j6ZIGk4Ga7WqTOzaP39ja2ka3/zvmb0r4efd97MrfRBaYHmsultrNpyGT9lk6ZRl93gm/Wty+TP0pqW4EpVV/OvNRLPItDtTkCJPg4X0g0eS9uogl0dKxHYdle1csbi99Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gXYZ3Mpe; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738683398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zyt/HjfG+yTFPFCoPjfzW+BlsfazEKApAez9eCk9iAoCMH0V/cS0xCY8WIMTYLcxgMKGvLpggch4OyfN4fqjwOblENL6C3HxzrIPOYHkeXkSvZHixYq9cVdfSf7JBE3eNr8eu123yMP/TZIJX2H6MMW1tU9eGdxbUPlLyuDjnqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738683398; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kVZIBsJ2ukDO0m/xIz1rl1s2choG2uPMysZ4azq+d4A=; 
	b=Uzat8tJIuh0xrX25VHIn7B3SkrnZdjLyzJnNK5WGPu5FfdMZbe8IuqgodWZMpf+HKkqFp/vdGvchMPXatBSx/S95I+9EpGp7FMO55s8DidoeQ5QqkVXt5P0kZjHHrk/b7QtW6aMlf1Gb05zXeG6sVn5tzq74k0xpY+1Kaox1qMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738683398;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kVZIBsJ2ukDO0m/xIz1rl1s2choG2uPMysZ4azq+d4A=;
	b=gXYZ3MpeQTLxffZoid6o4agzOgQjiHL2ZDn+6EGgU2VkvVoDZGwcKtRzs5osCPEe
	ef4oaLK/Qwm0IzDdxWdX1JcqbfBj/kf+P8Fmfl3KgRdO5ITfFRWB/9+dTqPcHyFzZb8
	VK6SfnnbiBM6WI2yST8UYG1O/TQ55Uwb/ChKbWrI=
Received: by mx.zohomail.com with SMTPS id 1738683395390506.65916958717594;
	Tue, 4 Feb 2025 07:36:35 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 04 Feb 2025 16:35:48 +0100
Subject: [PATCH v2 3/7] hwrng: rockchip: store dev pointer in driver struct
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-rk3588-trng-submission-v2-3-608172b6fd91@collabora.com>
References: <20250204-rk3588-trng-submission-v2-0-608172b6fd91@collabora.com>
In-Reply-To: <20250204-rk3588-trng-submission-v2-0-608172b6fd91@collabora.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Daniel Golle <daniel@makrotopia.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The rockchip rng driver does a dance to store the dev pointer in the
hwrng's unsigned long "priv" member. However, since the struct hwrng
member of rk_rng is not a pointer, we can use container_of to get the
struct rk_rng instance from just the struct hwrng*, which means we don't
have to subvert what little there is in C of a type system and can
instead store a pointer to the device struct in the rk_rng itself.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/char/hw_random/rockchip-rng.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_random/rockchip-rng.c
index 289b385bbf05e3c828b6e26feb2453db62f6b2a2..b1b510087e5862b3b2ed97cefbf10620bcf9b020 100644
--- a/drivers/char/hw_random/rockchip-rng.c
+++ b/drivers/char/hw_random/rockchip-rng.c
@@ -54,6 +54,7 @@ struct rk_rng {
 	void __iomem *base;
 	int clk_num;
 	struct clk_bulk_data *clk_bulks;
+	struct device *dev;
 };
 
 /* The mask in the upper 16 bits determines the bits that are updated */
@@ -70,8 +71,7 @@ static int rk_rng_init(struct hwrng *rng)
 	/* start clocks */
 	ret = clk_bulk_prepare_enable(rk_rng->clk_num, rk_rng->clk_bulks);
 	if (ret < 0) {
-		dev_err((struct device *) rk_rng->rng.priv,
-			"Failed to enable clks %d\n", ret);
+		dev_err(rk_rng->dev, "Failed to enable clocks: %d\n", ret);
 		return ret;
 	}
 
@@ -105,7 +105,7 @@ static int rk_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 	u32 reg;
 	int ret = 0;
 
-	ret = pm_runtime_resume_and_get((struct device *) rk_rng->rng.priv);
+	ret = pm_runtime_resume_and_get(rk_rng->dev);
 	if (ret < 0)
 		return ret;
 
@@ -122,8 +122,8 @@ static int rk_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 	/* Read random data stored in the registers */
 	memcpy_fromio(buf, rk_rng->base + TRNG_RNG_DOUT, to_read);
 out:
-	pm_runtime_mark_last_busy((struct device *) rk_rng->rng.priv);
-	pm_runtime_put_sync_autosuspend((struct device *) rk_rng->rng.priv);
+	pm_runtime_mark_last_busy(rk_rng->dev);
+	pm_runtime_put_sync_autosuspend(rk_rng->dev);
 
 	return (ret < 0) ? ret : to_read;
 }
@@ -164,7 +164,7 @@ static int rk_rng_probe(struct platform_device *pdev)
 		rk_rng->rng.cleanup = rk_rng_cleanup;
 	}
 	rk_rng->rng.read = rk_rng_read;
-	rk_rng->rng.priv = (unsigned long) dev;
+	rk_rng->dev = dev;
 	rk_rng->rng.quality = 900;
 
 	pm_runtime_set_autosuspend_delay(dev, RK_RNG_AUTOSUSPEND_DELAY);

-- 
2.48.1


