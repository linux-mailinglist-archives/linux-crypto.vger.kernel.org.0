Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D824413CEB
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Sep 2021 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhIUVub (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Sep 2021 17:50:31 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:34174 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIUVua (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Sep 2021 17:50:30 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 17:50:30 EDT
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id E2F78F40B6B; Tue, 21 Sep 2021 23:39:49 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 3/4] powerpc: wii.dts: Expose the AES engine on this platform
Date:   Tue, 21 Sep 2021 23:39:29 +0200
Message-Id: <20210921213930.10366-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921213930.10366-1-linkmauve@linkmauve.fr>
References: <20210921213930.10366-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This can be used by the newly-added nintendo-aes crypto module.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index aaa381da1906..c5720fdd0686 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -113,6 +113,13 @@ exi@d006800 {
 			interrupts = <4>;
 		};
 
+		aes@d020000 {
+			compatible = "nintendo,hollywood-aes";
+			reg = <0x0d020000 0x14>;
+			interrupts = <2>;
+			interrupt-parent = <&PIC1>;
+		};
+
 		usb@d040000 {
 			compatible = "nintendo,hollywood-usb-ehci",
 					"usb-ehci";
-- 
2.33.0

