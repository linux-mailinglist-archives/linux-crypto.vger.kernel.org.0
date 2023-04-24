Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F56D3709
	for <lists+linux-crypto@lfdr.de>; Sun,  2 Apr 2023 12:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjDBKJe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 2 Apr 2023 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjDBKIx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 2 Apr 2023 06:08:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51148684
        for <linux-crypto@vger.kernel.org>; Sun,  2 Apr 2023 03:08:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d8so15840073pgm.3
        for <linux-crypto@vger.kernel.org>; Sun, 02 Apr 2023 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oFHBwDflAuoBx3nAvQZJqLFUNje4jYksqgr3MUJ8Rg=;
        b=XVANtkx4Ujw3O5BQDdROvCmsJ6bq7/P0CEhVqCx7RKpYllQpA+HHyVWzXbE0HS3xf0
         Jd1UOqNKuV+vl8IM0Or/7X/3Yi1xw1HwlHBZ5PkipbTnWSMrfvlC8bScqXriH7n0NbhY
         Jy3qhn1oYCb8KTdrAIThAkQKmXygHhp/XqalOlg1jSpv7ORCmVnK7qzDXvO3BJ4LuLpM
         /XaTs1zSCdfyRVskPDEArs3wjKMo1c01vapmqf2xpCUA0bvLYjbNGFj/ccFKJBxwNCZt
         zucClueWyQIXFy8Iwv9EGn9mqKey7YNJycezAEPBK5+i2cj8wVlsSGGI+D2cvKjB7gUW
         YDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oFHBwDflAuoBx3nAvQZJqLFUNje4jYksqgr3MUJ8Rg=;
        b=MpwXsQXHIt+5W5T7eoywVgnWabvfNlAoUevDJgdVVKlyTC6tafkcffpqGq8PqGSRKH
         AITmZQWNq5l1AdmWcXoEN/hQIRYf+SncV8qfcH8pET1cZxVVM1/yYIPSHlRmlW5h8gFk
         cplDXYAkkaFFzqC0ixMg4xNboC2o9qNMe9WXA1WoLvJAIzQZV6fmtKN7TllXySzjhv3G
         BBknGnC8trwfJncX1NLyU5ikvdryIg8EjsD/cmZotUSzjzQn7czOYlsJC4//LoBGHC35
         2/2BIIq6vaiFOgq+J8Z6gQw8lMdnl3v2KHo8P6CJ9HH/OkZphIuM4YASnjEXg2dpZE41
         Ij5w==
X-Gm-Message-State: AAQBX9diJDrfCp5FgWtBL151BmpEjfB0/wA562++c2sdpkk6AJrwqxsL
        4x2AfykQJV2J2P0G9y/tIF9hRg==
X-Google-Smtp-Source: AKy350bg1jeAuFYwFwN9setvofB4ridXSnnwqFYhX53Ad6wGS71AeJ0ual7JAZZJlInCZ+ep84USXA==
X-Received: by 2002:a62:8401:0:b0:628:1852:8431 with SMTP id k1-20020a628401000000b0062818528431mr36133939pfd.30.1680430088880;
        Sun, 02 Apr 2023 03:08:08 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0062dba4e4706sm4788739pff.191.2023.04.02.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 03:08:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v5 11/11] arm64: dts: qcom: sm8450: add crypto nodes
Date:   Sun,  2 Apr 2023 15:35:09 +0530
Message-Id: <20230402100509.1154220-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add crypto engine (CE) and CE BAM related nodes and definitions
for the SM8450 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bhupesh: Corrected the compatible list]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 31877f18dce2..d7a28cac4f47 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4146,6 +4146,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x28000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+		};
+
+		crypto: crypto@1de0000 {
+			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x584 0x11>,
+				 <&apps_smmu 0x588 0x0>,
+				 <&apps_smmu 0x598 0x5>,
+				 <&apps_smmu 0x59a 0x0>,
+				 <&apps_smmu 0x59f 0x0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.38.1

