Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96B9264F0F
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIJTbg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 15:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgIJT3a (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 15:29:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E598721D91;
        Thu, 10 Sep 2020 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766169;
        bh=orngRUhSl9l3X7hGv/CI9HzZMY8gLdIvlGNKvUcPMhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LrVyziBD+ZKBtC0vuwxz/pdDe5ERb2/m4gWYDms2mSX8hRmJ+3MJAfN5QFCstv8H
         hkk2UB3HmE0mb2UD26y1W/ya0AzJHesj0eCsa/mFutb1UQTxteRQu9siO1vi+7GJXH
         6H1PWhOGfcpaCDOdcgX9+9QnXwl1zRM6Un+Zfe3o=
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
Subject: [PATCH v2 2/4] crypto: caam - Simplify with dev_err_probe()
Date:   Thu, 10 Sep 2020 21:29:17 +0200
Message-Id: <20200910192919.12503-2-krzk@kernel.org>
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
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---

Changes since v1:
1. Add Reviewed-by
---
 drivers/crypto/caam/caamalg_qi2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 0441e4ff2df2..076c6b04bea9 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -5115,8 +5115,7 @@ static int dpaa2_caam_probe(struct fsl_mc_device *dpseci_dev)
 	/* DPIO */
 	err = dpaa2_dpseci_dpio_setup(priv);
 	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "dpaa2_dpseci_dpio_setup() failed\n");
+		dev_err_probe(dev, err, "dpaa2_dpseci_dpio_setup() failed\n");
 		goto err_dpio_setup;
 	}
 
-- 
2.17.1

