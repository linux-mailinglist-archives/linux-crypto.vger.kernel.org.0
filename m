Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86F670381
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jul 2019 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGVPUC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 22 Jul 2019 11:20:02 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:39691 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727036AbfGVPUC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 22 Jul 2019 11:20:02 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 11:20:01 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6MF2i0e032709;
        Mon, 22 Jul 2019 18:02:44 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id DEFE561FD1; Mon, 22 Jul 2019 18:02:43 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, sumit.garg@linaro.org,
        jens.wiklander@linaro.org, vkoul@kernel.org, tglx@linutronix.de,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] hwrng: npcm: add NPCM RNG driver support
Date:   Mon, 22 Jul 2019 18:02:39 +0300
Message-Id: <20190722150241.345609-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch set adds Randon Number Generator (RNG) support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

The RNG driver we use power consumption when the RNG 
is not required.

The NPCM RNG driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: hwrng: add NPCM RNG documentation
  hwrng: npcm: add NPCM RNG driver

 .../bindings/rng/nuvoton,npcm-rng.txt         |  17 ++
 drivers/char/hw_random/Kconfig                |  13 ++
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/npcm-rng.c             | 207 ++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
 create mode 100644 drivers/char/hw_random/npcm-rng.c

-- 
2.18.0

