Return-Path: <linux-crypto+bounces-4191-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1148C6FFD
	for <lists+linux-crypto@lfdr.de>; Thu, 16 May 2024 03:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADAC1F217F6
	for <lists+linux-crypto@lfdr.de>; Thu, 16 May 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F35B10F2;
	Thu, 16 May 2024 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cxyhxVUv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66110E6
	for <linux-crypto@vger.kernel.org>; Thu, 16 May 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822560; cv=none; b=lDDpvm2BDkE3iyqZzMCGrb1TV7bm0aZKDOTAPGM2HlWSAJVuihQHlbDtkFmVfFjpmhk81RVvIA7rwtFo2e1/LjIiEh+qEcfT2SnwhVsItOQPw+y+QAAACXSF1bzTa/bQm3B2gPWmRThWVb0hJJK1iXYkoQYuvCd9xoLM9Htw7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822560; c=relaxed/simple;
	bh=3XGY/2PZ+ZWfvUg/HYQ2/3FHRrRJgt6FZBt/U8zbZBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZX8YlegRkyDW5sph8R+hDVD+v+rRhLg4+AZfu4P1ju/njnF5uZyaMLToR+80MkeBloznxBNGZDzW7lVv3JH+Js2YyErBezZdRtiEcV/+nNwXuVCADTJmInWrLJUCyMDGma76pXg3XCPMEArCw1wsofK7bW29BrlOblRe1vyf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cxyhxVUv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E81D988155;
	Thu, 16 May 2024 03:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715822554;
	bh=XDDQDeGaUh54AFK1n3ABER4j+LeDfbvu6Ukr923uNrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxyhxVUvGDibspPEmNeE8DDxC9H9ZM/a6gaJhI2edjqGxZCXLngVPtqFxMPNh715y
	 05DuZYTcCckTOFIB0+5Hp7BBmi1ns14RlbjvXbr5zisJNGDbCRjqFxaUHVNjckjYTg
	 g6K0ucoGlj+SYe8Qyrdjb1A7UmqeNG/gpzCwH4N2ilV3oworC43JF9VH2f6HIMiFnM
	 3LH1iBFR2VDHpWyX2k8V/cT9toJYSowtT5lm8CGXV8l4wyHVg6s/9X6SCFnIzRGkQw
	 Hz+iyBaFYIMbLV/tkL6sCAJUb7cG9Ga0eQeldgO4x/9jynpRxxcDokmNIMvjqp+CMX
	 ScFE21sk7ppFA==
From: Marek Vasut <marex@denx.de>
To: linux-crypto@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	kernel@dh-electronics.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] hwrng: stm32 - cache device pointer in struct stm32_rng_private
Date: Thu, 16 May 2024 03:20:46 +0200
Message-ID: <20240516012210.128307-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516012210.128307-1-marex@denx.de>
References: <20240516012210.128307-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Place device pointer in struct stm32_rng_private and use it all over the
place to get rid of the horrible type casts throughout the driver.

No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marek Vasut <marex@denx.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/char/hw_random/stm32-rng.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 6dec4adc49853..00012e6e4ccc8 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -70,6 +70,7 @@ struct stm32_rng_config {
 
 struct stm32_rng_private {
 	struct hwrng rng;
+	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -99,7 +100,7 @@ struct stm32_rng_private {
  */
 static int stm32_rng_conceal_seed_error_cond_reset(struct stm32_rng_private *priv)
 {
-	struct device *dev = (struct device *)priv->rng.priv;
+	struct device *dev = priv->dev;
 	u32 sr = readl_relaxed(priv->base + RNG_SR);
 	u32 cr = readl_relaxed(priv->base + RNG_CR);
 	int err;
@@ -171,7 +172,7 @@ static int stm32_rng_conceal_seed_error(struct hwrng *rng)
 {
 	struct stm32_rng_private *priv = container_of(rng, struct stm32_rng_private, rng);
 
-	dev_dbg((struct device *)priv->rng.priv, "Concealing seed error\n");
+	dev_dbg(priv->dev, "Concealing seed error\n");
 
 	if (priv->data->has_cond_reset)
 		return stm32_rng_conceal_seed_error_cond_reset(priv);
@@ -187,7 +188,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	int retval = 0, err = 0;
 	u32 sr;
 
-	retval = pm_runtime_resume_and_get((struct device *)priv->rng.priv);
+	retval = pm_runtime_resume_and_get(priv->dev);
 	if (retval)
 		return retval;
 
@@ -206,7 +207,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 								   sr, sr,
 								   10, 50000);
 			if (err) {
-				dev_err((struct device *)priv->rng.priv,
+				dev_err(priv->dev,
 					"%s: timeout %x!\n", __func__, sr);
 				break;
 			}
@@ -220,7 +221,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 				err = stm32_rng_conceal_seed_error(rng);
 				i++;
 				if (err && i > RNG_NB_RECOVER_TRIES) {
-					dev_err((struct device *)priv->rng.priv,
+					dev_err(priv->dev,
 						"Couldn't recover from seed error\n");
 					retval = -ENOTRECOVERABLE;
 					goto exit_rpm;
@@ -239,7 +240,7 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 			err = stm32_rng_conceal_seed_error(rng);
 			i++;
 			if (err && i > RNG_NB_RECOVER_TRIES) {
-				dev_err((struct device *)priv->rng.priv,
+				dev_err(priv->dev,
 					"Couldn't recover from seed error");
 				retval = -ENOTRECOVERABLE;
 				goto exit_rpm;
@@ -255,8 +256,8 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	}
 
 exit_rpm:
-	pm_runtime_mark_last_busy((struct device *) priv->rng.priv);
-	pm_runtime_put_sync_autosuspend((struct device *) priv->rng.priv);
+	pm_runtime_mark_last_busy(priv->dev);
+	pm_runtime_put_sync_autosuspend(priv->dev);
 
 	return retval || !wait ? retval : -EIO;
 }
@@ -331,8 +332,7 @@ static int stm32_rng_init(struct hwrng *rng)
 							10, 50000);
 		if (err) {
 			clk_disable_unprepare(priv->clk);
-			dev_err((struct device *)priv->rng.priv,
-				"%s: timeout %x!\n", __func__, reg);
+			dev_err(priv->dev, "%s: timeout %x!\n", __func__, reg);
 			return -EINVAL;
 		}
 	} else {
@@ -360,7 +360,7 @@ static int stm32_rng_init(struct hwrng *rng)
 						10, 100000);
 	if (err || (reg & ~RNG_SR_DRDY)) {
 		clk_disable_unprepare(priv->clk);
-		dev_err((struct device *)priv->rng.priv,
+		dev_err(priv->dev,
 			"%s: timeout:%x SR: %x!\n", __func__, err, reg);
 		return -EINVAL;
 	}
@@ -467,7 +467,7 @@ static int __maybe_unused stm32_rng_resume(struct device *dev)
 
 		if (err) {
 			clk_disable_unprepare(priv->clk);
-			dev_err((struct device *)priv->rng.priv,
+			dev_err(priv->dev,
 				"%s: timeout:%x CR: %x!\n", __func__, err, reg);
 			return -EINVAL;
 		}
@@ -543,6 +543,7 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	priv->ced = of_property_read_bool(np, "clock-error-detect");
 	priv->lock_conf = of_property_read_bool(np, "st,rng-lock-conf");
+	priv->dev = dev;
 
 	priv->data = of_device_get_match_data(dev);
 	if (!priv->data)
-- 
2.43.0


