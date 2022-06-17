Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62354F4AE
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jun 2022 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380496AbiFQJz5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jun 2022 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiFQJz4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jun 2022 05:55:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AC4F4AE2C;
        Fri, 17 Jun 2022 02:55:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D4812FC;
        Fri, 17 Jun 2022 02:55:54 -0700 (PDT)
Received: from ampere-altra-2-1.usa.Arm.com (ampere-altra-2-1.usa.arm.com [10.118.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974FE3F73B;
        Fri, 17 Jun 2022 02:55:54 -0700 (PDT)
From:   Yoan Picchi <yoan.picchi@arm.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] Crypto: Remove x86 dependency on QAT drivers
Date:   Fri, 17 Jun 2022 09:55:48 +0000
Message-Id: <20220617095548.436758-1-yoan.picchi@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The QAT acceleration card can be very helpfull for some tasks like dealing
with IPSEC but it is currently restricted to be used only on x86 machine.
Looking at the code we didn't see any reasons why those drivers might not
work on other architectures. We've successfully built all of them on x86,
arm64, arm32, mips64, powerpc64, riscv64 and sparc64.

We also have tested the driver with an Intel Corporation C62x Chipset
QuickAssist Technology (rev 04) PCIe card on an arm64 server. After the numa
patch, it works with the AF_ALG crypto userland interface, allowing us to
encrypt some data with cbc for instance. We've also successfully created some
VF, bound them to DPDK, and used the card this way, thus showing some real
life usecases of x86 do work on arm64 too.

Changelog v1 ... v2:
- add COMPILE_TEST to Kconfig

Changelog v2 ... v3:
- Add the Crypto tag to the commit header

Andre Przywara (1):
  crypto: qat: replace get_current_node() with numa_node_id()

Yoan Picchi (1):
  Removes the x86 dependency on the QAT drivers

 drivers/crypto/qat/Kconfig                     | 14 +++++++-------
 drivers/crypto/qat/qat_common/adf_common_drv.h |  5 -----
 drivers/crypto/qat/qat_common/qat_algs.c       |  4 ++--
 drivers/crypto/qat/qat_common/qat_asym_algs.c  |  4 ++--
 4 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.25.1

