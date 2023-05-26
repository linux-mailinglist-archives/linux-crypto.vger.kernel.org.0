Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB7712D4E
	for <lists+linux-crypto@lfdr.de>; Fri, 26 May 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjEZTYM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 May 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbjEZTXt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 May 2023 15:23:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFD810F5
        for <linux-crypto@vger.kernel.org>; Fri, 26 May 2023 12:23:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae85b71141so10687165ad.0
        for <linux-crypto@vger.kernel.org>; Fri, 26 May 2023 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685129006; x=1687721006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMTHG8l+qigWdbQ7cyJvnKtXRMQ+ez6nvcozSSImI4Q=;
        b=GJQcey1tIco4VsgW2wCa3EVnoFzVEek0hn7ePdRn29+qgiW0g9UYwipeEXNnCsMFmm
         QdeaTktSBVaTQZCWHHFS06jCo6Aah31J9cn/15FwpU6QELQEa0EWimTP73hYhMFcHhE4
         U/lK6w5eW3vOpHDeVHqcEkXq0g19aLyz68otddynIjR3pd2MwTG3g0sEP/5LX08fZZge
         VR97znrZayCVAWtB16b2Z6oajzdVluVxGtmZO6LVZoPZOrOOjXtYBX08KhZJNcEZY4M8
         lQRRghIrInaBgcKvJ1bsn0YK+aGeBMGWrhvB4TVXfEGyWseLzJnlmjVYVGJslPT4KAvK
         JGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129006; x=1687721006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMTHG8l+qigWdbQ7cyJvnKtXRMQ+ez6nvcozSSImI4Q=;
        b=gHS14A46IW5lB7iq7uM3/62mx4wxEzAUuzWkCSt1oiLTbwuB5Hy2VbeWAJ7dy6wvty
         PL+IsEv7sNpKfUagVZhX4NHkRW7ZzEHzIduQN1O4fdBCRcZxz3pDSTPqvBaA/tWzsW16
         B2HYnr4Li76CbRVocGMXuOpcMW+q6rnwJkhlc3Us6i7TT5GDfWLCjpbqhl5QJit/5Oii
         kD1Z8r2BkIhv9cBwRWr6jXFsSQt+aXfozT6kUxHxUBB49RLU5TDatq+6/OYYn8Gn9u3d
         OFy6FprRTPVApERxc7JmqZnv4ZVS/Spwaw2D1vrc2oDUBN6uEIabNTTbieRrAb3H8ZaU
         IWgA==
X-Gm-Message-State: AC+VfDxnwwNcND5q3lflqa4Nc+AlPREAH6nJiPBniPBqkJpa6r88o04r
        y88mkX5qbMIgYkA+Wwq6S2Gziw==
X-Google-Smtp-Source: ACHHUZ6BO9w5FdXzRsIZxZBqjjuAe8EPfEYlgN9HTmnQi9ZZydY15sIjo/INoBxrERq9+zRRSBPEhg==
X-Received: by 2002:a17:903:2312:b0:1b0:155b:bff2 with SMTP id d18-20020a170903231200b001b0155bbff2mr3221607plh.59.1685129006728;
        Fri, 26 May 2023 12:23:26 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:23:26 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v8 09/11] arm64: dts: qcom: sm8250: Add Crypto Engine support
Date:   Sat, 27 May 2023 00:52:08 +0530
Message-Id: <20230526192210.3146896-10-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8250.dtsi'.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7bea916900e2..79fad917d142 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2232,6 +2232,38 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <8>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x592 0x0000>,
+				 <&apps_smmu 0x598 0x0000>,
+				 <&apps_smmu 0x599 0x0000>,
+				 <&apps_smmu 0x59f 0x0000>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x592 0x0000>,
+				 <&apps_smmu 0x598 0x0000>,
+				 <&apps_smmu 0x599 0x0000>,
+				 <&apps_smmu 0x59f 0x0000>,
+				 <&apps_smmu 0x586 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.38.1

