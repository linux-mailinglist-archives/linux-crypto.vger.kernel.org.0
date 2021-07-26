Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB323D661F
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Jul 2021 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGZRQZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Jul 2021 13:16:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhGZRQY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Jul 2021 13:16:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8CB51FB;
        Mon, 26 Jul 2021 10:56:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1673F66F;
        Mon, 26 Jul 2021 10:56:50 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: [PATCH v3 0/2] hwrng: Add Arm SMCCC TRNG based driver
Date:   Mon, 26 Jul 2021 18:56:08 +0100
Message-Id: <20210726175610.3311-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The "Arm True Random Number Generator Firmware Interface"[1] provides
an SMCCC based interface to a true hardware random number generator.
So far we are using that in arch_get_random_seed(), but it might be
useful to expose the entropy through the /dev/hwrng device as well. This
allows to assess the quality of the implementation, by using "rngtest"
from the rng-tools package, for example.

Patch 1 creates a platform device, triggered by the previous discovery
of the SMCCC TRNG service.
Patch 2 implements a hw_random platform driver, which is instantiated
through this said platform device.

The driver can be loaded as module, or built into the kernel.

[1] https://developer.arm.com/documentation/den0098/latest/

Changelog v2 ... v3:
- split platform device and driver

Changelog v1 ... v2:
- fix building as a module
- de-register device upon exit
- mention module name in Kconfig

Andre Przywara (2):
  firmware: smccc: Register smccc_trng platform device
  hwrng: Add Arm SMCCC TRNG based driver

 drivers/char/hw_random/Kconfig          |  14 +++
 drivers/char/hw_random/Makefile         |   1 +
 drivers/char/hw_random/arm_smccc_trng.c | 134 ++++++++++++++++++++++++
 drivers/firmware/smccc/smccc.c          |  17 +++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/char/hw_random/arm_smccc_trng.c

-- 
2.17.6

