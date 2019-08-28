Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BE9FC92
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Aug 2019 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfH1IE0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 28 Aug 2019 04:04:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbfH1IEZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 28 Aug 2019 04:04:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C6AC9ECEE8D10C340F99;
        Wed, 28 Aug 2019 16:04:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 16:04:15 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <liguozhu@hisilicon.com>, <john.garry@huawei.com>,
        <Jonathan.Cameron@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH v2 -next] crypto: hisilicon: select CRYPTO_LIB_DES while compiling SEC driver
Date:   Wed, 28 Aug 2019 16:07:40 +0800
Message-ID: <20190828080740.43244-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <affd8de1-ae35-a1d0-534a-d9cdfac90de8@huawei.com>
References: <affd8de1-ae35-a1d0-534a-d9cdfac90de8@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When CRYPTO_DEV_HISI_SEC=y, below compilation error is found after 
'commit 894b68d8be4b ("crypto: hisilicon/des - switch to new verification routines")':

drivers/crypto/hisilicon/sec/sec_algs.o: In function `sec_alg_skcipher_setkey_des_cbc':
sec_algs.c:(.text+0x11f0): undefined reference to `des_expand_key'
drivers/crypto/hisilicon/sec/sec_algs.o: In function `sec_alg_skcipher_setkey_des_ecb':
sec_algs.c:(.text+0x1390): undefined reference to `des_expand_key'
make: *** [vmlinux] Error 1

This because DES library has been moved to lib/crypto in this commit 
'04007b0e6cbb ("crypto: des - split off DES library from generic DES cipher driver")'.
Fix this by selecting CRYPTO_LIB_DES in CRYPTO_DEV_HISI_SEC.

Fixes: 04007b0e6cbb ("crypto: des - split off DES library from generic DES cipher driver")
Fixes: 894b68d8be4b ("crypto: hisilicon/des - switch to new verification routines")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 v2: remove fix tag 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver") 
 drivers/crypto/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index fa8aa06..ebaf91e 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -4,6 +4,7 @@ config CRYPTO_DEV_HISI_SEC
 	tristate "Support for Hisilicon SEC crypto block cipher accelerator"
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_DES
 	select SG_SPLIT
 	depends on ARM64 || COMPILE_TEST
 	depends on HAS_IOMEM
-- 
2.7.4

