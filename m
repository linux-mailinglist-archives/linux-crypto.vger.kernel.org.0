Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E7AD938
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Sep 2019 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfIIMk1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 08:40:27 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:42626 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbfIIMk1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 08:40:27 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x89Ccfih029012;
        Mon, 9 Sep 2019 15:38:41 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 23293628F1; Mon,  9 Sep 2019 15:38:41 +0300 (IDT)
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
Subject: [PATCH v2 0/2] hwrng: npcm: add NPCM RNG driver support
Date:   Mon,  9 Sep 2019 15:38:38 +0300
Message-Id: <20190909123840.154745-1-tmaimon77@gmail.com>
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

Addressed comments from:.
 - Daniel Thompson, Milton Miller II : https://patchwork.ozlabs.org/patch/1154598/ 
  
Changes since version 1:
 - Define timout in real-world units.
 - Using readl_poll_timeout in rng_read function.
 - Honor wait parameter in rng_read function.
 - Using local variable instead of #ifndef.
 - Remove probe print.

Tomer Maimon (2):
  dt-binding: hwrng: add NPCM RNG documentation
  hwrng: npcm: add NPCM RNG driver

 .../bindings/rng/nuvoton,npcm-rng.txt         |  17 ++
 drivers/char/hw_random/Kconfig                |  13 ++
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/npcm-rng.c             | 203 ++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.txt
 create mode 100644 drivers/char/hw_random/npcm-rng.c

-- 
2.18.0

