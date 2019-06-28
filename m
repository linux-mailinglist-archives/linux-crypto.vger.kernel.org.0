Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA8592C2
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jun 2019 06:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF1E1e (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 00:27:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfF1E1e (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 00:27:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5S4RN1q105146;
        Thu, 27 Jun 2019 23:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561696043;
        bh=x+WogUHOQpJWSNWE1krdU8Z75nvmnuhuxjWIzK98k/4=;
        h=From:To:CC:Subject:Date;
        b=F0PwIXsR0lAyxa+sbDM2MNLwQY9jxRU4FxR0aDstX8FvyTWdugs+D182fD5j5Xzzi
         lqbzrpaUZtFbSH5GZxf7DBvclkcbXyE6G7UIMUcMaGBBVcz/Nb8XqduuvfTi8ULWuh
         yt8g/SJNhblOhk5/VjJe30ui2gapelaXeVrwQJ44=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5S4RNt2113240
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 23:27:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 23:27:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 23:27:23 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5S4RKPK062595;
        Thu, 27 Jun 2019 23:27:20 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>,
        <j-keerthy@ti.com>, <linux-crypto@vger.kernel.org>, <nm@ti.com>
Subject: [RESEND PATCH 00/10] crypto: k3: Add sa2ul driver
Date:   Fri, 28 Jun 2019 09:57:35 +0530
Message-ID: <20190628042745.28455-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The series adds Crypto hardware accelerator support for SA2UL.
SA2UL stands for security accelerator ultra lite.

The Security Accelerator (SA2_UL) subsystem provides hardware
cryptographic acceleration for the following use cases:
• Encryption and authentication for secure boot
• Encryption and authentication of content in applications
  requiring DRM (digital rights management) and
  content/asset protection
The device includes one instantiation of SA2_UL named SA2_UL0

SA2UL needs on tx channel and a pair of rx dma channels.

This series has dependency on UDMA series. Hence is based on top of:

https://patchwork.kernel.org/project/linux-dmaengine/list/?series=114105

The above series adds couple of dmaengine APIs that are used
by the sa2ul driver. Hence there is a hard dependency on the
above series.

Resending with linux-crypto list in Cc.

Keerthy (10):
  dt-bindings: crypto: k3: Add sa2ul bindings documentation
  crypto: sa2ul: Add crypto driver
  crypto: sa2ul: Add AES ECB Mode support
  crypto: sa2ul: Add aead support for hmac(sha1)cbc(aes) algorithm
  crypto: sha256_generic: Export the Transform function
  crypto: sa2ul: Add hmac(sha256)cbc(aes) AEAD Algo support
  crypto: sa2ul: Add hmac(sha1) HMAC algorithm support
  crypto: sa2ul: Add hmac(sha256) HMAC algorithm support
  sa2ul: Add 3DES ECB & CBC Mode support
  arm64: dts: k3-am6: Add crypto accelarator node

 .../devicetree/bindings/crypto/sa2ul.txt      |   47 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |   33 +
 crypto/sha256_generic.c                       |    3 +-
 drivers/crypto/Kconfig                        |   17 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/sa2ul.c                        | 2232 +++++++++++++++++
 drivers/crypto/sa2ul.h                        |  384 +++
 include/crypto/sha.h                          |    1 +
 8 files changed, 2717 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/sa2ul.txt
 create mode 100644 drivers/crypto/sa2ul.c
 create mode 100644 drivers/crypto/sa2ul.h

-- 
2.17.1

