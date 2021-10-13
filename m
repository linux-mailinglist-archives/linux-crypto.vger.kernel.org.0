Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBB42BE51
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Oct 2021 12:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJMLB3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Oct 2021 07:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhJMLBF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900BCC061776
        for <linux-crypto@vger.kernel.org>; Wed, 13 Oct 2021 03:57:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y7so2095538pfg.8
        for <linux-crypto@vger.kernel.org>; Wed, 13 Oct 2021 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ir565eYViyaMF1NhYbNf160wfGMLFG9RXVF0S7mT0r8=;
        b=EIuYWtDUiCkV6nabp8a3clkBRw/BI5XNCyehvDkZzPIDlRKTJ+6FvRM7Q268Ivhjv3
         x6aC9QN2zYKKqBsMYHoZercYfh4C7ms2PZTEjgRSF6B5fvJAEKkjyuo8qssz54pOSDDG
         sQgv3o+Xu4+0OnVS+IJwtzkPwqaxgc1grU/S00WtkmejNR4CTH04uzFPpwsf6rFyPE0C
         9rB06cxOtuNzBOTn7R7Ryd3HADWkujucMxjkdx6gSyEU9DSxX4JtSax63r6vbCzItTZ2
         r7Rpy2k+wA1uy+jw9BZ+s56NdVQGwye456TKIjqmk5I0Jz/0m0hVm3+u53ZyJHHXPcDj
         x5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ir565eYViyaMF1NhYbNf160wfGMLFG9RXVF0S7mT0r8=;
        b=ljPLvawnoNq3OiUYXe12nMnrpLrc/MDnwtSvEQa2XAZhuYxIUMCW7GrPV2S2xy7f74
         WTtn5BCmKg7htxQS74YVNQmypeDPE6TslwaEsWenc9S8IkxlwyxgzeW1Hw212AK4Ek15
         Vvb2n0RyV+N+fbtmvIsGkbLSK9ahWlEhkR3F70p8T70YNskZaUoatMg7Z3/w7xd/50Kz
         dZfNJh0E6edQheHKcxrBm574gHI102sh50l9jCD3CzNER41t0TJz6mDgPe8DIIn1W4Mx
         Fa4MlSa1W9/Cp0kDFPvOM4mu52m90DZG76H4eGRuPGxBcqdC9s9P0PcCu6DYIm6QoQHY
         Mx6g==
X-Gm-Message-State: AOAM533TwJqXt3R65YzIc2/jIesNyi72qU/hb7eEmhg/8CRhC2eTjeUy
        ZGAL81SCSGb+cXT7w+2EynZVXg==
X-Google-Smtp-Source: ABdhPJwnglZWYenJRS4WgqciFpCWUiwMSDNY72SLKhg2wBe9u8XThIhQKVtgovadRj74nzGMRAVp8Q==
X-Received: by 2002:a63:40c:: with SMTP id 12mr27354845pge.406.1634122620025;
        Wed, 13 Oct 2021 03:57:00 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:56:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 14/20] crypto: qce: core: Add support to initialize interconnect path
Date:   Wed, 13 Oct 2021 16:25:35 +0530
Message-Id: <20211013105541.68045-15-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

Crypto engine on certain Snapdragon processors like sm8150, sm8250, sm8350
etc. requires interconnect path between the engine and memory to be
explicitly enabled and bandwidth set prior to any operations. Add support
in the qce core to enable the interconnect path appropriately.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Make header file inclusion alphabetical]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 35 ++++++++++++++++++++++++++++-------
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index d3780be44a76..033c7278aa5d 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,8 @@
 #define QCE_MAJOR_VERSION5	0x05
 #define QCE_QUEUE_LENGTH	1
 
+#define QCE_DEFAULT_MEM_BANDWIDTH	393600
+
 static const struct qce_algo_ops *qce_ops[] = {
 #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
 	&skcipher_ops,
@@ -206,21 +209,35 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	qce->mem_path = of_icc_get(qce->dev, "memory");
+	if (IS_ERR(qce->mem_path))
+		return PTR_ERR(qce->mem_path);
+
 	qce->core = devm_clk_get(qce->dev, "core");
-	if (IS_ERR(qce->core))
-		return PTR_ERR(qce->core);
+	if (IS_ERR(qce->core)) {
+		ret = PTR_ERR(qce->core);
+		goto err_mem_path_put;
+	}
 
 	qce->iface = devm_clk_get(qce->dev, "iface");
-	if (IS_ERR(qce->iface))
-		return PTR_ERR(qce->iface);
+	if (IS_ERR(qce->iface)) {
+		ret = PTR_ERR(qce->iface);
+		goto err_mem_path_put;
+	}
 
 	qce->bus = devm_clk_get(qce->dev, "bus");
-	if (IS_ERR(qce->bus))
-		return PTR_ERR(qce->bus);
+	if (IS_ERR(qce->bus)) {
+		ret = PTR_ERR(qce->bus);
+		goto err_mem_path_put;
+	}
+
+	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
+	if (ret)
+		goto err_mem_path_put;
 
 	ret = clk_prepare_enable(qce->core);
 	if (ret)
-		return ret;
+		goto err_mem_path_disable;
 
 	ret = clk_prepare_enable(qce->iface);
 	if (ret)
@@ -260,6 +277,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	clk_disable_unprepare(qce->iface);
 err_clks_core:
 	clk_disable_unprepare(qce->core);
+err_mem_path_disable:
+	icc_set_bw(qce->mem_path, 0, 0);
+err_mem_path_put:
+	icc_put(qce->mem_path);
 	return ret;
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 085774cdf641..228fcd69ec51 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -35,6 +35,7 @@ struct qce_device {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *core, *iface, *bus;
+	struct icc_path *mem_path;
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
-- 
2.31.1

