Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24067A70CC
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Sep 2023 05:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjITDEv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Sep 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjITDEu (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Sep 2023 23:04:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C9C6;
        Tue, 19 Sep 2023 20:04:44 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K2GBV3028718;
        Wed, 20 Sep 2023 03:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=72Zh74UtllpRjj9hNt5DbTA6YqNubjF+pjgqAMLRreI=;
 b=CL+PDhwKUprLPGZ3hYfPGHj+LGEfmBQX4VjTYmQ4lo+x+g8kQvCuBFiWEK2UrKGbuazp
 NQNp6jHnm2sskDkCbodfRCq9AnxlmsKCYFTRutd3kUn04EfYKerRHDL0ChBacO/B/nG0
 yj9VjUSxpV+DkjcNbMsp5cQVSenESoOyr9ijyM2ksv24lC0D02lYI0vKwNsCnkxMtQzU
 JuACoBVVcQ0mQJJIJt1TWpZc+Pf4mEOwPldkZvFKZzcsjZVtM21MrGeCicDnx9de8WvN
 StAdUUUsr+GPNW78ageBJT1ks02s/DZ1JfBFkGrMPghXQVhFl4yUQCjIQJpBAES7nosT hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t77wna522-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 03:04:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K34Tlq016296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 03:04:29 GMT
Received: from hu-omprsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 19 Sep 2023 20:04:24 -0700
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
To:     <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: [PATCH V2] crypto: qcom-rng - Add hw_random interface support
Date:   Wed, 20 Sep 2023 08:34:08 +0530
Message-ID: <20230920030408.3181394-1-quic_omprsing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905062420.3983268-1-quic_omprsing@quicinc.com>
References: <20230905062420.3983268-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dWJwYM3rol0T-ynWGlypJANTNuTyXqH6
X-Proofpoint-GUID: dWJwYM3rol0T-ynWGlypJANTNuTyXqH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=961 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add hw_random interface support in qcom-rng driver as new IP block
in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
to generate true random number.

Keeping current rng_alg interface as well for random number generation
using Kernel Crypto API.

Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
---

Changes in V2:
- Updated patch to fix the return value from qcom_rng_generate() to be
  consistent with current implementation
- Updated patch to make it more concise
- Removed unnecessary use local variable and it's initialization
- Updated patch to use devm_hwrng_register() instead of hwrng_register()
- Updated subject line of the patch

This patch is depends on [1]
[1] https://lore.kernel.org/lkml/20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org/

 drivers/crypto/qcom-rng.c | 65 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index fb54b8cfc35f..e5a574a3cc59 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
+#include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -32,13 +33,18 @@ struct qcom_rng {
 	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int skip_init;
+	struct qcom_rng_of_data *of_data;
 };
 
 struct qcom_rng_ctx {
 	struct qcom_rng *rng;
 };
 
+struct qcom_rng_of_data {
+	bool skip_init;
+	bool hwrng_support;
+};
+
 static struct qcom_rng *qcom_rng_dev;
 
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
@@ -70,7 +76,7 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 		}
 	} while (currsize < max);
 
-	return 0;
+	return currsize;
 }
 
 static int qcom_rng_generate(struct crypto_rng *tfm,
@@ -92,6 +98,9 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
 	mutex_unlock(&rng->lock);
 	clk_disable_unprepare(rng->clk);
 
+	if (ret == dlen)
+		ret = 0;
+
 	return ret;
 }
 
@@ -101,6 +110,13 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
 	return 0;
 }
 
+static int qcom_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct qcom_rng *qrng = (struct qcom_rng *)rng->priv;
+
+	return qcom_rng_read(qrng, data, max);
+}
+
 static int qcom_rng_enable(struct qcom_rng *rng)
 {
 	u32 val;
@@ -136,7 +152,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
 
 	ctx->rng = qcom_rng_dev;
 
-	if (!ctx->rng->skip_init)
+	if (!ctx->rng->of_data->skip_init)
 		return qcom_rng_enable(ctx->rng);
 
 	return 0;
@@ -157,6 +173,12 @@ static struct rng_alg qcom_rng_alg = {
 	}
 };
 
+static struct hwrng qcom_hwrng = {
+	.name = "qcom-hwrng",
+	.read = qcom_hwrng_read,
+	.quality = 1024,
+};
+
 static int qcom_rng_probe(struct platform_device *pdev)
 {
 	struct qcom_rng *rng;
@@ -177,15 +199,29 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
+	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
 	if (ret) {
 		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
 		qcom_rng_dev = NULL;
+		return ret;
+	}
+
+	if (rng->of_data->hwrng_support) {
+		qcom_hwrng.priv = (unsigned long)qcom_rng_dev;
+		ret = devm_hwrng_register(&pdev->dev, &qcom_hwrng);
+		if (ret) {
+			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
+			qcom_rng_dev = NULL;
+			goto fail;
+		}
 	}
 
+	return ret;
+fail:
+	crypto_unregister_rng(&qcom_rng_alg);
 	return ret;
 }
 
@@ -198,6 +234,21 @@ static int qcom_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
+struct qcom_rng_of_data qcom_prng_of_data = {
+	.skip_init = false,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_prng_ee_of_data = {
+	.skip_init = true,
+	.hwrng_support = false,
+};
+
+struct qcom_rng_of_data qcom_trng_of_data = {
+	.skip_init = true,
+	.hwrng_support = true,
+};
+
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 	{ .id = "QCOM8160", .driver_data = 1 },
 	{}
@@ -205,9 +256,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
 
 static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
-	{ .compatible = "qcom,prng", .data = (void *)0},
-	{ .compatible = "qcom,prng-ee", .data = (void *)1},
-	{ .compatible = "qcom,trng", .data = (void *)1},
+	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
+	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
+	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
-- 
2.25.1

