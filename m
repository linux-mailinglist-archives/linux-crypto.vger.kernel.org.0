Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF96DABB0
	for <lists+linux-crypto@lfdr.de>; Fri,  7 Apr 2023 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjDGKvB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 7 Apr 2023 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbjDGKur (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 7 Apr 2023 06:50:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21112AD25
        for <linux-crypto@vger.kernel.org>; Fri,  7 Apr 2023 03:50:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso4206356wmr.0
        for <linux-crypto@vger.kernel.org>; Fri, 07 Apr 2023 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680864642; x=1683456642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AoJwb3uiC7XvXnq9Cv6Yi3/auRbCXXml6xp1v+5NAQ=;
        b=ImJosRLr6cpfZxxfAvHh3FuP1UDctl5bNsG7L7v0kNVn8a1u6zf7uie565hVY4VU8/
         1sFAOdrjycvRq+rdVPBertPJk/lt7kvLp3y8eqBymKflDkC8lfk+06m080d2DFO9kt+l
         ptjGTKDdEzZ6lo4m272ysLpL5mPJpG12Drab4M97O0oIPl/Q5xPSjgDPToXTzz0l0BCQ
         uJE5yppDrUSL+b6Wr8r4EF468IzrkPw7GNLQ/YEzfgTC+FEvdSymoPDEd+PyFd0pg0Ek
         ZBGZQ5fgaX5k92FtcAzlf4o5yT3RzZ8vfp/l6BUFhPj7U2h99SMkG42qPiK1ubgqi29A
         ZI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680864642; x=1683456642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AoJwb3uiC7XvXnq9Cv6Yi3/auRbCXXml6xp1v+5NAQ=;
        b=IXi5Ae+Ga1GMqj+mcekbuesl/K8n5c0uWsLi5akAIFGoR+T2E+rxSFFAsnt6wogfWo
         NCJ8J5BAkFEAa4/U0FqCof3EFx7rU0LkJKYXHot/Oas2hI3wHAzEtaOMfiZQwlnvl8Qi
         Wyzbn4XK4bqqdYDG+sDlUMXW4u4nEhn15H/Jw59rm17Q2CEvjLsYBWzrne+aDRLusKJl
         DwF65mB3r5Jt6l450LJgUfTJ20xBq1/jmCtkNm7KUhWoTQdhaiO7sZqOeBUx1TvC9jBH
         bIcdX0/pbIzxqFmwx6t6uLCW6lgF7l0Hvib3AyBbv8EOr5aEcO5NWO/zD3dK2Y4BVK+j
         Fdig==
X-Gm-Message-State: AAQBX9ep+aKvsZxM6p7p/grXc2/BHhryUc8iubzZ8/5yZaph3KUBFEHR
        Tq0cOhlBgsbUmqxjNryel6I+3Q==
X-Google-Smtp-Source: AKy350ZGMq6FqyYpcpPwyGasQ3zXfUjoGqvbNEbFh5ND4lxo6ouDY+z+yl+oGLluNLUadwGxj/Unkg==
X-Received: by 2002:a05:600c:2182:b0:3ee:3fd7:5f85 with SMTP id e2-20020a05600c218200b003ee3fd75f85mr1016584wme.11.1680864642510;
        Fri, 07 Apr 2023 03:50:42 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b003ede6540190sm8131909wmq.0.2023.04.07.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:50:42 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v6 2/6] dt-bindings: ufs: qcom: Add ICE phandle
Date:   Fri,  7 Apr 2023 13:50:25 +0300
Message-Id: <20230407105029.2274111-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407105029.2274111-1-abel.vesa@linaro.org>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
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

Starting with SM8550, the ICE will have its own devicetree node
so add the qcom,ice property to reference it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v5 is here:
https://lore.kernel.org/all/20230403200530.2103099-3-abel.vesa@linaro.org/

Changes since v5:
 * dropped the sm8550 specific subschema and replaced it with one that
   mutually excludes the qcom,ice vs both the ICE specific reg range
   and the ICE clock

Changes since v4:
 * Added check for sm8550 compatible w.r.t. qcom,ice in order to enforce
   it while making sure none of the other platforms are allowed to use it

Changes since v3:
 * dropped the "and drop core clock" part from subject line

Changes since v2:
 * dropped all changes except the qcom,ice property


 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..71aa79eac6b4 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -70,6 +70,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   reg:
     minItems: 1
     maxItems: 2
@@ -187,6 +191,28 @@ allOf:
 
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
+  - if:
+      properties:
+        qcom,ice:
+          minItems: 1
+          maxItems: 1
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+        clocks:
+          minItems: 8
+          maxItems: 8
+    else:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        clocks:
+          minItems: 9
+          maxItems: 11
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

