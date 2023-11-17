Return-Path: <linux-crypto+bounces-180-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77537EF8BD
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A97B2089F
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5E45C09
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcneZDwR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1B171A;
	Fri, 17 Nov 2023 12:17:50 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so3447357a12.1;
        Fri, 17 Nov 2023 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252269; x=1700857069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC+himnz38l/KoIV2K7+BOXv6I9H6nNXMdtkGXbKeCU=;
        b=UcneZDwRmtlmn5yaZCjLOotQ7CXLlHCK5Cfw1RM7PXElF3pN0V6Ff83mx5oSCgRTCG
         nqIcm1LJql6ncOvYteoxVLnqvBeCi9zJOqd+aYhGBrNpsc/Yt3XZn6x4bvUvwFrYpQAg
         izrKa7dFPeiCOJUm7JR7XHvPeHyQE1jl7qtaDo6daS3hNKRaTI2gno+zcK5gvEAHC2aS
         lkHKiMWp1Pecsp5MUesMdbc5hZwHbJxBVt1BX4Ys1m8dbsFCHhrO6CTL3VCZObTcFIZp
         c4mN9h6RCqC4cuDiItQ1jhEBvhLEzFeWxhXIsYM7ZuaGxBZ0gI8CCBLyx8/fJF0dw1AR
         z88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252269; x=1700857069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC+himnz38l/KoIV2K7+BOXv6I9H6nNXMdtkGXbKeCU=;
        b=smGfsIDe4HIn6KPImr8Lg9GeO3UAiF20G8OpnNvBomBMnNcy8aot02Uy63ol6ut8Al
         ypIdH5LEFDG9BMxWfoCLhy5w9MWaYgK/Y13XPmD38Q17jAbOgHbkYjjvRmFp6B+1C3b2
         ll5SrDW5psq56wuTiWlMrBZClXaiuvibxhSfcuIAUUpyqLKrm2pTkovD05f+brkgGB3s
         ajypX0oTQWqqfBaZCCYwrjOJNdxn45ywHaiCXMeDg55GodZ9/BFOlN6VZxgho+4j10Yp
         PLDaMr9d2AcsfnnSSZYyQ5G/mct6LbG0jah6RsTDY0uoeuMqlhzy8PfapA7If/oAe2DM
         2Rug==
X-Gm-Message-State: AOJu0Yw+Yyoi6nuxnZTFrNXT3sFAFcOCxN3BfDkgmC0uvWjDa2e212dy
	PMIwLx6jjRAqu/+cT4dUCGg=
X-Google-Smtp-Source: AGHT+IGCNBi4gWuvRE++iwdLWuYcOU7PqdFx0Dwq+NJsFkMmZzQ+CsPzHq5WwKF5sfxu4plbJLWyHA==
X-Received: by 2002:a17:907:9056:b0:9f8:f6bd:2952 with SMTP id az22-20020a170907905600b009f8f6bd2952mr134480ejc.32.1700252268786;
        Fri, 17 Nov 2023 12:17:48 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:48 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 8/8] arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
Date: Fri, 17 Nov 2023 21:08:40 +0100
Message-ID: <20231117201720.298422-9-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117201720.298422-1-davidwronek@gmail.com>
References: <20231117201720.298422-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Mason <buddyjojo06@outlook.com>

Add a device tree for the Xiaomi Redmi Note 9S (curtana) phone, based on
sm7125-xiaomi-common.dtsi.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                |  1 +
 .../boot/dts/qcom/sm7125-xiaomi-curtana.dts      | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6cb840b7050..57974fb0c580 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -207,6 +207,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
new file mode 100644
index 000000000000..12f517a8492c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Joe Mason <buddyjojo06@outlook.com>
+ */
+
+/dts-v1/;
+
+#include "sm7125-xiaomi-common.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 9S";
+	compatible = "xiaomi,curtana", "qcom,sm7125";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0x20022 1>;
+};
-- 
2.42.1


