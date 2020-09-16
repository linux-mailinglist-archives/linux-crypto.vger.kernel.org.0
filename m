Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A608D26BDD3
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Sep 2020 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIPHUN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Sep 2020 03:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:54786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIPHUL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Sep 2020 03:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A3D1045;
        Wed, 16 Sep 2020 00:20:10 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0C883F68F;
        Wed, 16 Sep 2020 00:20:08 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: crypto: update ccree optional params
Date:   Wed, 16 Sep 2020 10:19:49 +0300
Message-Id: <20200916071950.1493-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200916071950.1493-1-gilad@benyossef.com>
References: <20200916071950.1493-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Document ccree driver supporting new optional parameters allowing to
customize the DMA transactions cache parameters and ACE bus sharability
properties.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
index 6130e6eb4af8..1a1603e457a8 100644
--- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
+++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
@@ -13,6 +13,10 @@ Required properties:
 Optional properties:
 - clocks: Reference to the crypto engine clock.
 - dma-coherent: Present if dma operations are coherent.
+- awcache: Set write transactions cache attributes
+- arcache: Set read transactions cache attributes
+- awdomain: Set write transactions ACE sharability domain (712, 703, 713 only)
+- ardomain: Set read transactions ACE sharability domain (712, 703, 713 only)
 
 Examples:
 
-- 
2.27.0

