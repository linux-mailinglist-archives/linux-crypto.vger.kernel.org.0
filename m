Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4F6D36F7
	for <lists+linux-crypto@lfdr.de>; Sun,  2 Apr 2023 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjDBKIp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 2 Apr 2023 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjDBKIN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 2 Apr 2023 06:08:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C32BEEE
        for <linux-crypto@vger.kernel.org>; Sun,  2 Apr 2023 03:07:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so27717950pjl.4
        for <linux-crypto@vger.kernel.org>; Sun, 02 Apr 2023 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=NO5QchAAiX8nxK4rrdvECkFevEeGuWkK4uaqqNoeXGSX1jw/qgyZADY1FXvgWnd6TK
         D9q35AYvvrRjzSsPVabk6HveQgT5bqTv00HNFOYTorYKfl3UMuaPv1GmkjwCa5kRucBP
         Xt1yxsJ9BfLlios0H9g5G1hmNwtlf4Mvb0y3Me8TXmTDaYfGBVZeGx0nnA3hmn3XaUvS
         n48KLXQFag51mE6XL6JpasLFKQzinX/vKvunX4sSl+f8s+HI7RXVnWD27kmDrr+Z47hj
         hwE7BDptQc/FX0uLr3OklU/SN7yax/xOhCI7dta7II0EScmSRKj1B0KhIxkAs2tWOz2w
         xmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuEDYxPh1iqRLp/0Giai1ZnY3ruEMo64qCfhktsCtAU=;
        b=r/W4X2HJyNDOvYA3TRcINbBa1qknpwYAupzdySjEXjLcSssX2/z8ZIu7+aPAmIaPUd
         zUXbuuTTwoH1UXVoOJbJD4O0ZjbHin7xqTafxTMDX9RC3RmKACRaNevwFb6rTwejq2eF
         ozaskzEY2xq9R7dawq+ndYjnMK/rCsMxQui2S/O6GkzOS7JyrjkBGxo1cJufrxcfaIOp
         2htMj6aUYCWinzG7RcHRtsiSCNkymbz0JyrG3JtzHRnOMf8cVmG+8SgKt11Y69vWptIl
         PHuIkTPEBK+gyoNvViwWblrF8zAQWkQEXj22vgR8J7lMfSVpHVvGF1LH2xJj4OdlHJas
         +fBg==
X-Gm-Message-State: AO0yUKVQMr/NWNcxY6P/b1IZGawJqn1j4mVRB1j/GlfFkn5aTUI9Sc57
        fgtLyE+d8Qx8aOIxS1FGZq1IPQ==
X-Google-Smtp-Source: AK7set+wPRYRXyFtC6QO0rNNDfJZgfLxY8u9e6wgqZWEYohIIuRd8DFdKsqGwPaRn/V4i53GUl9X4Q==
X-Received: by 2002:a05:6a20:6ca6:b0:dd:2577:4018 with SMTP id em38-20020a056a206ca600b000dd25774018mr28432249pzb.49.1680430070996;
        Sun, 02 Apr 2023 03:07:50 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0062dba4e4706sm4788739pff.191.2023.04.02.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 03:07:50 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v5 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
Date:   Sun,  2 Apr 2023 15:35:05 +0530
Message-Id: <20230402100509.1154220-8-bhupesh.sharma@linaro.org>
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

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm6115.dtsi'.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..ebac026b4cc7 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x94 0x11>,
+				 <&apps_smmu 0x96 0x11>;
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
-- 
2.38.1

