Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304A264EF9
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 21:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIJTbX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 15:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgIJT3j (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 15:29:39 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E811821D92;
        Thu, 10 Sep 2020 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766176;
        bh=J+36KfiCj6ZqQvGQMiAmr/24p4yD+AflrA4ni1Zap14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPBKvVFpHggxzO23tGiSaky0KlkF4+un8LWAPbmZObck71qM/avY7UqWtG577qnY0
         PnA5fZOLc357YA1FVO32FkV6B0h+ZvtEKxwKl3Jnz5KJxQ9pvava+qp9B+q6Tttgta
         mqfZp2Q4IUeXW9ww6qq3T2nooXdigTyVomwfhcsc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 4/4] crypto: allwinner/sun8i - Simplify with dev_err_probe()
Date:   Thu, 10 Sep 2020 21:29:19 +0200
Message-Id: <20200910192919.12503-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910192919.12503-1-krzk@kernel.org>
References: <20200910192919.12503-1-krzk@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 9 +++------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 138759dc8190..e3c62051c595 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -573,12 +573,9 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 		return irq;
 
 	ce->reset = devm_reset_control_get(&pdev->dev, NULL);
-	if (IS_ERR(ce->reset)) {
-		if (PTR_ERR(ce->reset) == -EPROBE_DEFER)
-			return PTR_ERR(ce->reset);
-		dev_err(&pdev->dev, "No reset control found\n");
-		return PTR_ERR(ce->reset);
-	}
+	if (IS_ERR(ce->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ce->reset),
+				     "No reset control found\n");
 
 	mutex_init(&ce->mlock);
 
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 9a23515783a6..576df8c8df51 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -545,12 +545,9 @@ static int sun8i_ss_probe(struct platform_device *pdev)
 		return irq;
 
 	ss->reset = devm_reset_control_get(&pdev->dev, NULL);
-	if (IS_ERR(ss->reset)) {
-		if (PTR_ERR(ss->reset) == -EPROBE_DEFER)
-			return PTR_ERR(ss->reset);
-		dev_err(&pdev->dev, "No reset control found\n");
-		return PTR_ERR(ss->reset);
-	}
+	if (IS_ERR(ss->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ss->reset),
+				     "No reset control found\n");
 
 	mutex_init(&ss->mlock);
 
-- 
2.17.1

