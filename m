Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24950335
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Jun 2019 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfFXHYi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Jun 2019 03:24:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17835 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbfFXHYi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Jun 2019 03:24:38 -0400
X-UUID: 0704b223eb5949cbbda10de7e55c1fb2-20190624
X-UUID: 0704b223eb5949cbbda10de7e55c1fb2-20190624
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1259754356; Mon, 24 Jun 2019 15:24:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Jun 2019 15:24:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Jun 2019 15:24:28 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v4 2/3] dt-bindings: rng: add bindings for MediaTek ARMv8 SoCs
Date:   Mon, 24 Jun 2019 15:24:11 +0800
Message-ID: <1561361052-13072-3-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1561361052-13072-1-git-send-email-neal.liu@mediatek.com>
References: <1561361052-13072-1-git-send-email-neal.liu@mediatek.com>
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
 .../devicetree/bindings/rng/mtk-sec-rng.txt        |   10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/mtk-sec-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
new file mode 100644
index 0000000..c04ce15
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
@@ -0,0 +1,10 @@
+MediaTek random number generator with TrustZone enabled
+
+Required properties:
+- compatible : Should be "mediatek,mtk-sec-rng"
+
+Example:
+
+hwrng: hwrng {
+	compatible = "mediatek,mtk-sec-rng";
+}
-- 
1.7.9.5

