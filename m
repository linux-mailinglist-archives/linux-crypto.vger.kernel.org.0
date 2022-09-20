Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5665BE4C1
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Sep 2022 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiITLmF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Sep 2022 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiITLlt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D674BAB
        for <linux-crypto@vger.kernel.org>; Tue, 20 Sep 2022 04:41:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so2307198pgb.4
        for <linux-crypto@vger.kernel.org>; Tue, 20 Sep 2022 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=24eJhxzPFfKXUwOZKOTRmoYXZNNfpL+aRtWSIcJA8uw=;
        b=Xe/mLl+ylNGdFdiviFC3iqKG4YggC/bpamn+R5OuBr+rEewpMweGd9RWgesWYiNKKq
         DV/aB/0HC/XuiKuVj483yQoNSwdMAzDaFIhT3r8fJOC6+AZ2tukFFKMSXgXBnsJMvzrt
         XGwgDE7N4QsAXnAIp47FYjmku7cBupvgDlW9vwr6zk/ZB9CnSgJ/WJIeIKwSo5L2m10b
         qIrf/g4cTHuLvqCyrX58WheTER+qsKEQVf1J+8gTqHfttG6Dl3SWabrWY9f5xAQcZqfb
         4kvW5pKJkxN1huZ+uViUZJa2i4ltsOuskgxBDpRvzFptk/x4vnS2BHo1pNPCDyJxL2j5
         kuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=24eJhxzPFfKXUwOZKOTRmoYXZNNfpL+aRtWSIcJA8uw=;
        b=KipPa+lP9VpoiNcJtui6CU7mwQRFGMtSIVsVZSaaAeGMgZVGQBVHyAe6nrtWDs434C
         nVX9zuBm/WjncrMyZlkV/fEco0GKd50ymCaUZWzWcUAstM44a3l592JX/2pp33ca554R
         lIXG5SdLhRdFP6e8g7jiZT75Z4uQHhrC1g0LhDHnYMrms7PP4TylQW/97Ikpj/Mgjfto
         FI+qZfKnJHbW/8glRKezkMMrd1Xt/Mhtgbz81KHeTdG8CltFKXItgrvOuOpPH+dd1S6f
         h2KeNoLV58OERQIEKgJU241e3t0VigC6J4LQymDl1Z6PENOTSArQJNXpfZLsDPp/hoNN
         SMXA==
X-Gm-Message-State: ACrzQf08IPhvR7ddpMDXpopmP6C+idFOiti2n/k2r1uKACLKObDdKlxC
        Nfg2vDMUvdlkCMADwGYgULjpjR6MwLSGMw==
X-Google-Smtp-Source: AMsMyM4lgKA4KDnGlwop2eDvfZyX0HcQJj8xFPEpIdTSpOtMPvThWvag/f1sRsoijw8khQVuHGBgDw==
X-Received: by 2002:aa7:958e:0:b0:54a:792d:bce4 with SMTP id z14-20020aa7958e000000b0054a792dbce4mr22712441pfj.25.1663674094508;
        Tue, 20 Sep 2022 04:41:34 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 6/9] crypto: qce: core: Add new compatibles for qce crypto driver
Date:   Tue, 20 Sep 2022 17:10:48 +0530
Message-Id: <20220920114051.1116441-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Since we decided to use soc specific compatibles for describing
the qce crypto IP nodes in the device-trees, adapt the driver
now to handle the same.

Keep the old deprecated compatible strings still in the driver,
to ensure backward compatibility.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: herbert@gondor.apana.org.au
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 63be06df5519..99ed540611ab 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -291,8 +291,17 @@ static int qce_crypto_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
+	/* Following two entries are deprecated (kept only for backward compatibility) */
 	{ .compatible = "qcom,crypto-v5.1", },
 	{ .compatible = "qcom,crypto-v5.4", },
+	/* Add compatible strings as per updated dt-bindings, here: */
+	{ .compatible = "qcom,ipq4019-qce", },
+	{ .compatible = "qcom,ipq6018-qce", },
+	{ .compatible = "qcom,ipq8074-qce", },
+	{ .compatible = "qcom,msm8996-qce", },
+	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8150-qce", },
+	{ .compatible = "qcom,sm8250-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.37.1

