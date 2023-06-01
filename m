Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E32719967
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Jun 2023 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjFAKTT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 1 Jun 2023 06:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjFAKS4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 1 Jun 2023 06:18:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903D2115
        for <linux-crypto@vger.kernel.org>; Thu,  1 Jun 2023 03:16:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKZ-0004WA-5h; Thu, 01 Jun 2023 12:14:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKX-004KWB-JG; Thu, 01 Jun 2023 12:14:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKW-001V3d-J1; Thu, 01 Jun 2023 12:14:52 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v1 1/7] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul support
Date:   Thu,  1 Jun 2023 12:14:45 +0200
Message-Id: <20230601101451.357662-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601101451.357662-1-o.rempel@pengutronix.de>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
the fsl-imx-esdhc.yaml file. This is required to match the compatible
strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
commit addresses the following dtbs_check warning:
  imx6ul-prti6g.dtb: mmc@2190000: compatible: 'oneOf' conditional failed,
    one must be fixed: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc'] is too long
    'fsl,imx6ul-usdhc' is not one of ['fsl,imx25-esdhc', 'fsl,imx35-esdhc',
    'fsl,imx51-esdhc', 'fsl,imx53-esdhc', 'fsl,imx6q-usdhc',
    'fsl,imx6sl-usdhc', 'fsl,imx6sx-usdhc', 'fsl,imx7d-usdhc',
    'fsl,imx7ulp-usdhc', 'fsl,imx8mm-usdhc', 'fsl,imxrt1050-usdhc',
    'nxp,s32g2-usdhc']
  From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index fbfd822b9270..090e781705d3 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -30,6 +30,7 @@ properties:
           - fsl,imx6q-usdhc
           - fsl,imx6sl-usdhc
           - fsl,imx6sx-usdhc
+          - fsl,imx6ul-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
           - fsl,imx8mm-usdhc
@@ -42,6 +43,7 @@ properties:
           - enum:
               - fsl,imx6sll-usdhc
               - fsl,imx6ull-usdhc
+              - fsl,imx6ul-usdhc
           - const: fsl,imx6sx-usdhc
       - items:
           - const: fsl,imx7d-usdhc
-- 
2.39.2

