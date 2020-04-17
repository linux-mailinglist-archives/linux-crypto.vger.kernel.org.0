Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160F1AD710
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2020 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgDQHJf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Apr 2020 03:09:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgDQHJf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Apr 2020 03:09:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD2477AB1C634BCCDC59;
        Fri, 17 Apr 2020 15:09:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 15:09:23 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH] crypto: hisilicon - fix Kbuild warning
Date:   Fri, 17 Apr 2020 15:08:31 +0800
Message-ID: <1587107311-52310-1-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add Kconfig dependency to fix kbuild warnings.

Fixes: 6c6dd580 ("crypto: hisilicon/qm - add controller reset interface")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
---
 drivers/crypto/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index f09c6cf..99e962e 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -42,6 +42,7 @@ config CRYPTO_DEV_HISI_QM
 	depends on ARM64 || COMPILE_TEST
 	depends on PCI && PCI_MSI
 	depends on UACCE || UACCE=n
+	depends on ACPI
 	help
 	  HiSilicon accelerator engines use a common queue management
 	  interface. Specific engine driver may use this module.
-- 
2.7.4

