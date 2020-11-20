Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655B2BA556
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 09:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgKTI7C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 03:59:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7961 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKTI7C (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 03:59:02 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ccr7T6h6SzhdcR;
        Fri, 20 Nov 2020 16:58:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 16:58:47 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <mpm@selenic.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon/trng - add HiSilicon TRNG driver support
Date:   Fri, 20 Nov 2020 16:56:59 +0800
Message-ID: <1605862623-37584-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1. Move HiSilicon TRNG driver form 'drivers/char/hw_random/'
   to 'drivers/crypto/hisilicon/'.
2. Add support for PRNG in Crypto subsystem.

Weili Qian (4):
  hwrng: hisi - remove HiSilicon TRNG driver
  crypto: hisilicon/trng - add HiSilicon TRNG driver support
  crypto: hisilicon/trng - add support for PRNG
  MAINTAINERS: Move HiSilicon TRNG V2 driver

 MAINTAINERS                            |   2 +-
 arch/arm64/configs/defconfig           |   1 +
 drivers/char/hw_random/Kconfig         |  13 --
 drivers/char/hw_random/Makefile        |   1 -
 drivers/char/hw_random/hisi-trng-v2.c  |  99 ----------
 drivers/crypto/hisilicon/Kconfig       |   8 +
 drivers/crypto/hisilicon/Makefile      |   1 +
 drivers/crypto/hisilicon/trng/Makefile |   2 +
 drivers/crypto/hisilicon/trng/trng.c   | 334 +++++++++++++++++++++++++++++++++
 9 files changed, 347 insertions(+), 114 deletions(-)
 delete mode 100644 drivers/char/hw_random/hisi-trng-v2.c
 create mode 100644 drivers/crypto/hisilicon/trng/Makefile
 create mode 100644 drivers/crypto/hisilicon/trng/trng.c

-- 
2.8.1

