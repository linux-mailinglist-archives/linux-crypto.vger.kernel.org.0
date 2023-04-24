Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FAF6D7572
	for <lists+linux-crypto@lfdr.de>; Wed,  5 Apr 2023 09:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjDEHbN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 5 Apr 2023 03:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjDEHbD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CB46B4
        for <linux-crypto@vger.kernel.org>; Wed,  5 Apr 2023 00:31:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id iw3so33650084plb.6
        for <linux-crypto@vger.kernel.org>; Wed, 05 Apr 2023 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=c+K/1+I+HXNSCA+LfMD5CMiAizpy7/+k/uIoMuC0C64a0F9DISCIQMHQO5y0+xkGtQ
         1uyEmMvwMQuEZvegvvGNiGVVC/AKHF7l7FoNmYmk1bWPbMFU4hSCkb9hkk5GfeCYESH8
         QJijlyfA9be1obqzhMYszoL78c+/zxKEFbYvG/DlUEcFLD+bc4Dl8RA9nrzcAXvvsULs
         pyH6tyq/HiKR4IKXS2XhKjlUwNY3oclfps4Df3rM/l33od7rPMA5G22V8HimencOLYYz
         sM+vXe913MQpsbXK/J7yUfV0Qeq4xRv3Cb9I3AYZvDYycyMCW2mPKZeDAFUiaJLdHXFh
         tCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=2ZvrNxud2GgX7g8QdacNtrX0pw12mA73NADkedm2BORgazOYYFPwauenY0sq/0chNm
         IR6Y/qT5ZJ+n4YlhHUEdiuOXypiEWKRwVrcKFgLZ0zql3q49qxd8BwmUSTQgi0mTgLUY
         waJ+zpmg+uvF0RkaBGdZhbyWatMqsTMlaUmkJ4lHYKCDzO8PXHpIkQJTiiq1zyXbpCC4
         i3VVRYcpxPfWU+TYUXlqaHqJ2k34czjWN7UL6sgv1E5RNnmnxc3jdWTFSckoLq4fzEtC
         LmCn3Dn0QANHAni0wrzBdxV3LZJdlitaG3QMGQrgDZi5QRDYVnZrLS3ZiW0ZLB7bL/dE
         3hrA==
X-Gm-Message-State: AAQBX9c8FIyZMEVzUs0QhYhVKX+bLCFWKay6OsfWv6DRhWk41tMfg9Wa
        YsPeQg8PFbZ9+GKpGhxgm5NK4A==
X-Google-Smtp-Source: AKy350ZeQM8mCNtvwzU2cxCF1iY0OeNfPnYG4fOJ1QjHI8BKr3pmLDSpqHbdIHkojl358gPdvXgdLQ==
X-Received: by 2002:a05:6a20:4fa7:b0:da:bace:b06a with SMTP id gh39-20020a056a204fa700b000dabaceb06amr4335745pzb.50.1680679859776;
        Wed, 05 Apr 2023 00:30:59 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:30:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 02/11] dt-bindings: dma: Increase iommu maxItems for BAM DMA
Date:   Wed,  5 Apr 2023 12:58:27 +0530
Message-Id: <20230405072836.1690248-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
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

Since SM8450 BAM DMA engine supports five iommu entries,
increase the maxItems in the iommu property section, without
which 'dtbs_check' reports the following error:

  arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
    dma-controller@1dc4000: iommus: is too long

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index c663b6102f50..5636d38f712a 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -44,7 +44,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.38.1

