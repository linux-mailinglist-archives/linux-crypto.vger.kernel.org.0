Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BDF3B350
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Jun 2019 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbfFJKgn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Jun 2019 06:36:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17360 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389319AbfFJKgm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Jun 2019 06:36:42 -0400
X-UUID: aa5536ce880d42eab5ddbc920a36d885-20190610
X-UUID: aa5536ce880d42eab5ddbc920a36d885-20190610
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1520545478; Mon, 10 Jun 2019 18:36:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 18:36:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 18:36:33 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>
Subject: [PATCH v3 2/3] dt-bindings: rng: update bindings for MediaTek ARMv8 SoCs
Date:   Mon, 10 Jun 2019 18:36:23 +0800
Message-ID: <1560162984-26104-3-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1560162984-26104-1-git-send-email-neal.liu@mediatek.com>
References: <1560162984-26104-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Document the binding used by the MediaTek ARMv8 SoCs random
number generator with TrustZone enabled.

Signed-off-by: Neal Liu <neal.liu@mediatek.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.txt |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
index 2bc89f1..fb3dd59 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
@@ -3,9 +3,13 @@ found in MediaTek SoC family
 
 Required properties:
 - compatible	    : Should be
-			"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" : for MT7622
-			"mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
-			"mediatek,mt7623-rng" : for MT7623
+			"mediatek,mt7622-rng", "mediatek,mt7623-rng" for MT7622
+			"mediatek,mt7629-rng", "mediatek,mt7623-rng" for MT7629
+			"mediatek,mt7623-rng" for MT7623
+			"mediatek,mtk-sec-rng" for MediaTek ARMv8 SoCs with
+			security RNG
+
+Optional properties:
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
 - clock-names	    : Should contain "rng" entries;
@@ -19,3 +23,8 @@ rng: rng@1020f000 {
 	clocks = <&infracfg CLK_INFRA_TRNG>;
 	clock-names = "rng";
 };
+
+/* secure RNG */
+hwrng: hwrng {
+	compatible = "mediatek,mtk-sec-rng";
+};
-- 
1.7.9.5

