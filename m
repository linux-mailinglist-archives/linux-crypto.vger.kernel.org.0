Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6B1976BB
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2020 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgC3Ijl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Mar 2020 04:39:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729399AbgC3Ijl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Mar 2020 04:39:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 915F798D24ABF315CD1B;
        Mon, 30 Mar 2020 16:39:35 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 16:39:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <wangzhou1@hisilicon.com>, <Jonathan.Cameron@huawei.com>,
        <xuzaibo@huawei.com>, <shiju.jose@huawei.com>,
        <ebiggers@google.com>, <yaohongbo@huawei.com>,
        <maowenan@huawei.com>, <arnd@arndb.de>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: hisilicon - Fix build error
Date:   Mon, 30 Mar 2020 16:36:43 +0800
Message-ID: <20200330083643.28824-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When UACCE is m, CRYPTO_DEV_HISI_QM cannot be built-in.
But CRYPTO_DEV_HISI_QM is selected by CRYPTO_DEV_HISI_SEC2
and CRYPTO_DEV_HISI_HPRE unconditionally, which may leads this:

drivers/crypto/hisilicon/qm.o: In function 'qm_alloc_uacce':
drivers/crypto/hisilicon/qm.c:1579: undefined reference to 'uacce_alloc'

Add Kconfig dependency to enforce usable configurations.

Fixes: 47c16b449921 ("crypto: hisilicon - qm depends on UACCE")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 095850d01dcc..f09c6cf7823e 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -27,6 +27,7 @@ config CRYPTO_DEV_HISI_SEC2
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	depends on PCI && PCI_MSI
+	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	help
 	  Support for HiSilicon SEC Engine of version 2 in crypto subsystem.
@@ -58,6 +59,7 @@ config CRYPTO_DEV_HISI_ZIP
 config CRYPTO_DEV_HISI_HPRE
 	tristate "Support for HISI HPRE accelerator"
 	depends on PCI && PCI_MSI
+	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	select CRYPTO_DEV_HISI_QM
 	select CRYPTO_DH
-- 
2.17.1


