Return-Path: <linux-crypto+bounces-10692-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06BA5BC27
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Mar 2025 10:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA117A6B85
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Mar 2025 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B9231C8D;
	Tue, 11 Mar 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kOOWTexF"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317E231A4D
	for <linux-crypto@vger.kernel.org>; Tue, 11 Mar 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685152; cv=none; b=j/QrLOru7Ehzh+oXK4iWimbdh+Zp3nLpB7+xw5HqR2JRoSuL08xhQ66KSsasnKOnAz/5R7UtU97BjvgVWUWx4RUo8pk+FSZmYtDxoad2/lacn5dOXcpQR860Latax1YC13a5ktlss78W1vP1bB3U8iAMcGo1ACc3vE95dzYVZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685152; c=relaxed/simple;
	bh=LFM9b2u67bSZaIUBYliTcIHljksO8+uTJ/L/rcNEnC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McSJ4G+ghEibbWKH6Ogt+jx1MGEetoBcQPgkJqIRqAzgEz8RK906mW/BK2qsyg154QCAccNQOsZ4D+dl4Yf6qClSzn4zojVI+dU2AzRCQM9VCid3JWItDegd3b5pej2zxiJcJNzMqXMsLmUQ3lX+OQxu0b0k5iEkB9XbuytJQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kOOWTexF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso8917135e9.2
        for <linux-crypto@vger.kernel.org>; Tue, 11 Mar 2025 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741685148; x=1742289948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9nXciZ3P4WwGQnYiP3b72/6X89GnLhZDt45DEZdMkk=;
        b=kOOWTexFDGeuEu6IoTX2U7l/wF9zuWLQli1trnIxMxNfshQSVETOQd0u0Krj8mQPH/
         eZMvfQVlED/+UkXJaMNSqvVKOXGcR1plx5G5Y+BkjARoLmwp3B+CXgcUuuo2tJjfMfsa
         M6t/yZgSBPsLozsvukLfsOiL1JJg00eTdzw+f7yZ0zBacA+Z2W1prl4egVTom2WiJpn1
         4Vr7HIBdTWStCLerngTULxbNGfku398w5Q7IWdUOzyjVtoKjq4ZziikBuRVPGRhhVEOV
         PTrtEp+bkzV3AVppWRr/0SxjIAZ3SCGbNrLJ9Ej9pg86cJDcooa5XGaicBmiNP5ol21f
         AAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685148; x=1742289948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9nXciZ3P4WwGQnYiP3b72/6X89GnLhZDt45DEZdMkk=;
        b=jpKYhDE3a+Gb+PKus5S6DvKHdVt6ryBp5fayEoYiCRdTRtsmkDLLSwOhfGPq6rZW34
         w3YK4TCvKQr+46HeYJYdciGlroRiIrAmHaJ8cp1/Lxon1iI02CS3bM9sSCRXaXLrahPq
         hD/9Z4Cf4cSVVFdztrOf1wWleg8gWTVf1SuQ86hbL0odhBlLqqe4lIx8oSPy/ds0PKSB
         QtPZxtNhh+Ft3GGJvgTZ9XkGh5nXSO0tytIQQjmq6Kil09eO2Tr0/p+ud7DEoBe7Clt/
         4CTbIKYKUGwziZCsw3II8zud7s5bAmrP/wBRKMnRDfVutGuhv0j3etqrqaYJzNftItAj
         9/oQ==
X-Gm-Message-State: AOJu0YzwQVwMLG2Og4Kxc1q1noSzgEo8Jeg9YnFjK/dG+CAqKyK8Kplp
	nAiNE56t5ERrdLYPGb8X9IpAnwLNxBiIHFJohVTz3cDIMhQWxI6xaOwIW/myooE=
X-Gm-Gg: ASbGncvj//JFh7u6N5bfWRfiTVmuQTm8Yvqg7O9Rnyn8Kl6WSst3VNe6ORvokgjS4Kx
	xsaNJZ8GlonlOhN+anMuOdH7flJzPqFl79CuX7mYYgHe9AsB4GdwLPdhUcOkIeZN7nAvyK1sl2h
	ur8KAozlpRBa7280LvraR7f4da4FaL+D3C56wGBhMk7REw3SGSflzuXI7WYHDcQKAVTgFwlLfdP
	69oD4KNqFZakQRbvUygxbym8l/X1EQq0ItNQnZohyKs/EyckNUlHZTzaI+CbWBIsw4RL80h6JBk
	Zw2vDL8vhSSKeM1X3RcGpigL8RAAcPqlnETO
X-Google-Smtp-Source: AGHT+IE2E06qFQygO0D9rODHdFFqN5iR8TR9Ya/5fd51L8cHA3jpRugMsQeHjlRJdpMOp7hvX6gTFQ==
X-Received: by 2002:a05:6000:1a8f:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39263b00732mr3395249f8f.9.1741685148109;
        Tue, 11 Mar 2025 02:25:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm107436465e9.15.2025.03.11.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:25:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 10:25:35 +0100
Subject: [PATCH v7 4/8] crypto: qce - use devres to allocate the result
 buffer
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qce-cmd-descr-v7-4-db613f5d9c9f@linaro.org>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
In-Reply-To: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QD4k77mywEecEa6p/7h3b1ceYlu1HySwlr50tAYI57M=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn0AGVFsw9bJEeGpjhulSppdP2lv0fkee/YIGKa
 tPx5XsyfJaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ9ABlQAKCRARpy6gFHHX
 cmGlD/9/wrcM4bzrh+5npGBrHGmHl8cxk3vCvVG+9N4m8cFZB2OJ+ZuPeg3KYsOn+SmT0HxPUq0
 8hp6fj+p3kuuHkrrivZABLtFkbd6xD5DDMSJQ4Ym71F3lYLadSrrZEAjUX2NsATSdy/2t8HurN0
 6fvHynkYnFEU5iShfugSIhKBDpwIepItYZEfqN/vikttjMOEe36JtCquL9h2z8CJh1fCyG08imw
 +xIGc851nGEC6ce1IgbgGK+8zWXizMVooSuebQIMNdkIyAE182ViByWAInlwjmagblE4qyx8obH
 wwUPQZAhRYIsQM5q4hZW3dCaZi6Uqqpc5Thi/tx/dzECU9WkCVli0Cke+V7u4OqoB3RdJr+SuPA
 hYPOtax2yIxJOspX+aAmk1eUYyU4kq4Kd54ASrRb/ZDEhKYeB72Kz6/a3YpuyR+SyCQtPa4IUjS
 +y+NJubwdhmSFUnuEpGSqlSvnMT45EeElhZKf4aVGycNazv70VyvDcdbIN8TRa2ejyJ7ixoSEJC
 cdUpZaW90EbnEu2tbe9QyRIsV8ij6lkq/cIT5+CnME7B1RnxBP0sN9ix1DhxTGGUJhCDr/ElfQP
 9Dcgeja5XXqn0crz3kjXoqj2gaEQYvNZlqu5QgEWmk/FZ2PTnlq5XYe1bi9vR7ypZDmBthS3GIr
 RJdD3lpziCPiMEw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc for allocating the result_buf. This allows us to
drop two labels and make the devm action callback for DMA channels
smaller.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/dma.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 1dec7aea852d..6ac2efb7c2f7 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -15,7 +15,6 @@ static void qce_dma_release(void *data)
 
 	dma_release_channel(dma->txchan);
 	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
 }
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
@@ -28,26 +27,23 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->rxchan = dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->rxchan)) {
-		ret = PTR_ERR(dma->rxchan);
-		goto error_rx;
+		dma_release_channel(dma->txchan);
+		return PTR_ERR(dma->rxchan);
 	}
 
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
+	ret = devm_add_action_or_reset(dev, qce_dma_release, dma);
+	if (ret)
+		return ret;
+
+	dma->result_buf = devm_kmalloc(dev,
+				       QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
+				       GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
 
 	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
 
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
-
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.45.2


