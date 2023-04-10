Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F696DC3EA
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Apr 2023 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDJHiO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-crypto@lfdr.de>); Mon, 10 Apr 2023 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDJHiN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Apr 2023 03:38:13 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BA3C0A;
        Mon, 10 Apr 2023 00:38:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B04C924E17E;
        Mon, 10 Apr 2023 15:37:58 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 15:37:58 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 15:37:54 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 0/4] crypto: starfive - Add drivers for crypto engine
Date:   Mon, 10 Apr 2023 15:37:48 +0800
Message-ID: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch series adds kernel driver support for StarFive JH7110 crypto
engine. The first patch adds Documentations for the device and Patch 2
adds device probe and DMA init for the module. Patch 3 adds crypto and
DMA dts node for VisionFive 2 board. Patch 4 adds hash/hmac support to
the module.

Patch 3 needs to be applied on top of:
https://patchwork.kernel.org/project/linux-riscv/cover/20230120024445.244345-1-xingyu.wu@starfivetech.com/

Changes v3->v4:
- Use fallback for non-aligned cases as hardware doesn't support
  hashing piece-meal (Herbert)
- Use ahash_request_set_* helpers to update members of ahash_request
  (Herbert)
- Set callbacks for async fallback (Herbert)
- Remove completion variable and use dma_callback to do the rest of
  processing instead. (Herbert)

Changes v2->v3:
- Only implement digest and use fallback for other ops (Herbert)
- Use interrupt instead of polling for hash complete (Herbert)
- Remove manual data copy from out-of-bound memory location as it will
  be handled by DMA API. (Christoph & Herbert)

Changes v1->v2:
- Fixed yaml filename and format (Krzysztof)
- Removed unnecessary property names in yaml (Krzysztof)
- Moved of_device_id table close to usage (Krzysztof)
- Use dev_err_probe for error returns (Krzysztof)
- Dropped redundant readl and writel wrappers (Krzysztof)
- Updated commit signed offs (Conor)
- Dropped redundant node in dts, module set to on in dtsi (Conor)

Jia Jie Ho (4):
  dt-bindings: crypto: Add StarFive crypto module
  crypto: starfive - Add crypto engine support
  riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
  crypto: starfive - Add hash and HMAC support

 .../crypto/starfive,jh7110-crypto.yaml        |  70 ++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  28 +
 drivers/crypto/Kconfig                        |   1 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/starfive/Kconfig               |  21 +
 drivers/crypto/starfive/Makefile              |   4 +
 drivers/crypto/starfive/jh7110-cryp.c         | 234 +++++
 drivers/crypto/starfive/jh7110-cryp.h         | 127 +++
 drivers/crypto/starfive/jh7110-hash.c         | 990 ++++++++++++++++++
 10 files changed, 1483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
 create mode 100644 drivers/crypto/starfive/Kconfig
 create mode 100644 drivers/crypto/starfive/Makefile
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.c
 create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
 create mode 100644 drivers/crypto/starfive/jh7110-hash.c

-- 
2.25.1

